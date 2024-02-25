from pyspark.sql import SparkSession

class RunSparkExampleInDataProc:

    def run_spark(self):
        spark = SparkSession.builder\
            .appName("SparkByExample")\
            .getOrCreate()
        
        simpleData=(("Java", 4000, 5), \
                    ("Python", 4600, 10), \
                        ("Scala", 4500, 5),\
                              ("Kotlin", 5000, 3))
        
        columns = ["CourseName", "fee", "discount"]


        df = spark.createDataFrame(data=simpleData, schema= columns)
        df.printSchema()
        df.show(truncate=False)


if __name__ == '__main__':
   run_spark = RunSparkExampleInDataProc()
   run_spark.run_spark()