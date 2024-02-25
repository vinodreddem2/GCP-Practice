from pyspark.sql import SparkSession

spark = SparkSession.builder \
.appName('spark_gcs_to_bq') \
.getOrCreate()

sc = spark.sparkContext
sc.setLogLevel("WARN")

BUCKET_NAME="gcp-practice-95"
log_files_rdd = sc.textFile('gs://{}/logs/*'.format(BUCKET_NAME))

splitted_rdd = log_files_rdd.map(lambda x: x.split(" "))
selected_col_rdd = splitted_rdd.map(lambda x: (x[0], x[3], x[5], x[6]))

columns = ["ip","date","method","url"]
logs_df = selected_col_rdd.toDF(columns)
logs_df.createOrReplaceTempView('logs_df')

sql = """
  SELECT
  url,
  count(*) as count
  FROM logs_df
  WHERE url LIKE '%/article%'
  GROUP BY url
  """
article_count_df = spark.sql(sql)
print(" ### Get only articles and blogs records ### ")
article_count_df.show(5)

article_count_df.write.format('bigquery') \
.option('temporaryGcsBucket', BUCKET_NAME) \
.option('table', 'gcp_practice.log_tbl') \
.mode('overwrite') \
.save()