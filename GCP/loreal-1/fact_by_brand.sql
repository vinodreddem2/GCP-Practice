declare historydates DEFAULT ["20201201","20201101","20201001","20200901","20200801","20200701"];
DECLARE DATE_VALUE DATETIME DEFAULT PARSE_DATE("%Y%m%d", "20200401");
DECLARE k INT64 DEFAULT 0;
DECLARE 
MTD_TO_CY, MTD_FROM_CY, MTD_TO_LY, MTD_FROM_LY,
YTD_TO_CY, YTD_FROM_CY, YTD_TO_LY, YTD_FROM_LY,
R12_TO_CY, R12_FROM_CY,
R12_TO_LY, R12_FROM_LY,
R36_TO, R36_FROM ,
R2536_TO, R2536_FROM,
R1324_TO, R1324_FROM,
R13MTD_TO_CY, R13MTD_FROM_CY,
R13MTD_TO_LY,R13MTD_FROM_LY ,
R13YTD_TO_CY , R13YTD_FROM_CY,
R13YTD_TO_LY, R13YTD_FROM_LY ,
R1324R12_TO_CY ,R1324R12_FROM_CY ,
R1324R12_TO_LY , R1324R12_FROM_LY ,
STRING DEFAULT "";

DECLARE fromDATE_CY, TODATE_CY, FROMDATE_LY, TODATE_LY , R1324_FROMDATE_CY, R1324_FROMDATE_LY, R1324_TODATE_CY, R1324_TODATE_LY STRING DEFAULT "0" ;

DECLARE period ARRAY <STRING>;
DECLARE i INT64 DEFAULT 0;



WHILE k < ARRAY_LENGTH(historydates) DO
  	SET DATE_VALUE = PARSE_DATE("%Y%m%d",historydates[OFFSET(k)]);
	
	SET MTD_TO_CY = FORMAT_DATETIME("%Y%m%d" , LAST_DAY(DATETIME_SUB(DATE_VALUE, INTERVAL 1 MONTH), MONTH));
	SET MTD_FROM_CY = CONCAT(FORMAT_DATETIME("%Y%m" , DATETIME_SUB(DATE_VALUE, INTERVAL 1 MONTH)), "01");

	SET MTD_TO_LY = FORMAT_DATETIME("%Y%m%d" , LAST_DAY(DATETIME_SUB(DATE_VALUE, INTERVAL 13 MONTH), MONTH));
	SET MTD_FROM_LY = CONCAT(FORMAT_DATETIME("%Y%m" , DATETIME_SUB(DATE_VALUE, INTERVAL 24 MONTH)), "01");
	
	SET YTD_TO_CY = FORMAT_DATETIME("%Y%m%d" , LAST_DAY(DATETIME_SUB(DATE_VALUE, INTERVAL 1 MONTH), MONTH));
	SET YTD_FROM_CY = CONCAT(FORMAT_DATETIME("%Y" , DATETIME_SUB(DATE_VALUE, INTERVAL 1 YEAR)), "0101");
	
	SET YTD_TO_LY = FORMAT_DATETIME("%Y%m%d" , LAST_DAY(DATETIME_SUB(DATE_VALUE, INTERVAL 13 MONTH), MONTH));
	SET YTD_FROM_LY = CONCAT(FORMAT_DATETIME("%Y" , DATETIME_SUB(DATE_VALUE, INTERVAL 2 YEAR)), "0101");
	
	SET R12_TO_CY = FORMAT_DATETIME("%Y%m%d" , LAST_DAY(DATETIME_SUB(DATE_VALUE, INTERVAL 1 MONTH), MONTH));
	SET R12_FROM_CY = CONCAT(FORMAT_DATETIME("%Y%m" , DATETIME_SUB(DATE_VALUE, INTERVAL 1 YEAR)), "01");
	
	SET R12_TO_LY = FORMAT_DATETIME("%Y%m%d" , LAST_DAY(DATETIME_SUB(DATE_VALUE, INTERVAL 13 MONTH), MONTH));
	SET R12_FROM_LY = CONCAT(FORMAT_DATETIME("%Y%m" , DATETIME_SUB(DATE_VALUE, INTERVAL 24 YEAR)), "01");
	
	SET R36_TO = FORMAT_DATETIME("%Y%m%d" , LAST_DAY(DATETIME_SUB(DATE_VALUE, INTERVAL 1 MONTH), MONTH));
	SET R36_FROM = CONCAT(FORMAT_DATETIME("%Y%m" , DATETIME_SUB(DATE_VALUE, INTERVAL 36 MONTH)), "01"); 
	
	SET R2536_TO = FORMAT_DATETIME("%Y%m%d" , LAST_DAY(DATETIME_SUB(DATE_VALUE, INTERVAL 25 MONTH), MONTH));
	SET R2536_FROM = CONCAT(FORMAT_DATETIME("%Y%m" , DATETIME_SUB(DATE_VALUE, INTERVAL 36 MONTH)), "01");
	
	SET R1324_TO = FORMAT_DATETIME("%Y%m%d" , LAST_DAY(DATETIME_SUB(DATE_VALUE, INTERVAL 13 MONTH), MONTH));
	SET R1324_FROM = CONCAT(FORMAT_DATETIME("%Y%m" , DATETIME_SUB(DATE_VALUE, INTERVAL 24 MONTH)), "01"); 
	
	SET R13MTD_TO_CY = FORMAT_DATETIME("%Y%m%d" , LAST_DAY(DATETIME_SUB(DATE_VALUE, INTERVAL 13 MONTH), MONTH));
	SET R13MTD_FROM_CY = CONCAT(FORMAT_DATETIME("%Y%m" , DATETIME_SUB(DATE_VALUE, INTERVAL 13 MONTH)), "01");
	
	SET R13MTD_TO_LY = FORMAT_DATETIME("%Y%m%d" , LAST_DAY(DATETIME_SUB(DATE_VALUE, INTERVAL 25 MONTH), MONTH));
	SET R13MTD_FROM_LY = CONCAT(FORMAT_DATETIME("%Y%m" , DATETIME_SUB(DATE_VALUE, INTERVAL 25 MONTH)), "01");
	
	SET R13YTD_TO_CY = FORMAT_DATETIME("%Y%m%d" , LAST_DAY(DATETIME_SUB(DATE_VALUE, INTERVAL 13 MONTH), MONTH));
	SET R13YTD_FROM_CY = CONCAT(FORMAT_DATETIME("%Y" , DATETIME_SUB(DATE_VALUE, INTERVAL 1 YEAR)), "0101");
	
	SET R13YTD_TO_LY = FORMAT_DATETIME("%Y%m%d" , LAST_DAY(DATETIME_SUB(DATE_VALUE, INTERVAL 25 MONTH), MONTH));
	SET R13YTD_FROM_LY = CONCAT(FORMAT_DATETIME("%Y" , DATETIME_SUB(DATE_VALUE, INTERVAL 2 YEAR)), "0101");
	
	SET R1324R12_TO_CY = FORMAT_DATETIME("%Y%m%d" , LAST_DAY(DATETIME_SUB(DATE_VALUE, INTERVAL 13 MONTH), MONTH));
	SET R1324R12_FROM_CY = CONCAT(FORMAT_DATETIME("%Y%m" , DATETIME_SUB(DATE_VALUE, INTERVAL 24 MONTH)), "01"); 
	
	SET R1324R12_TO_LY = FORMAT_DATETIME("%Y%m%d" , LAST_DAY(DATETIME_SUB(DATE_VALUE, INTERVAL 25 MONTH), MONTH));
	SET R1324R12_FROM_LY = CONCAT(FORMAT_DATETIME("%Y%m" , DATETIME_SUB(DATE_VALUE, INTERVAL 36 MONTH)), "01"); 
	
	--SET fromDATE_CY, TODATE_CY, FROMDATE_LY, TODATE_LY , R1324_FROMDATE_CY, R1324_FROMDATE_LY, R1324_TODATE_CY, R1324_TODATE_LY DEFAULT "0" ;
	
	SET i=0;
	set period = ["MTD","YTD","R12"];
	WHILE i < ARRAY_LENGTH(period) DO
	IF period[OFFSET(i)] = 'MTD' THEN 
			set FROMDATE_CY = MTD_FROM_CY; 
			set TODATE_CY = MTD_TO_CY;
			set fromDATE_LY = MTD_FROM_LY; 
			set TODATE_LY = MTD_TO_LY;
			
			set R1324_FROMDATE_CY =R13MTD_FROM_CY;
			set R1324_FROMDATE_LY = R13MTD_FROM_LY;
			set R1324_TODATE_CY = R13MTD_TO_CY;
			set R1324_TODATE_LY = R13MTD_TO_LY;
			
		ElseIF period[OFFSET(i)] = 'YTD' THEN
			set fromDATE_CY = YTD_FROM_CY; 
			set TODATE_CY = YTD_TO_CY;
			set fromDATE_LY = YTD_FROM_LY; 
			set TODATE_LY = YTD_TO_LY;
			
			set R1324_FROMDATE_CY = R13YTD_FROM_CY;
			set R1324_FROMDATE_LY = R13YTD_FROM_LY;
			set R1324_TODATE_CY = R13YTD_TO_CY;
			set R1324_TODATE_LY = R13YTD_TO_LY;
			
		ELSEIF period[OFFSET(i)] = 'R12' THEN 
			set fromDATE_CY = R12_FROM_CY;
			set TODATE_CY = R12_TO_CY;
			set fromDATE_LY = R12_FROM_LY;
			set TODATE_LY = R12_TO_LY;
			
			set R1324_FROMDATE_CY = R1324R12_FROM_CY;
			set R1324_FROMDATE_LY = R1324R12_FROM_LY;
			set R1324_TODATE_CY = R1324R12_TO_CY;
			set R1324_TODATE_LY = R1324R12_TO_LY;
	END IF;
	
 insert into apmena-oneconsumer-dna-apac-qa.space_crm_domain.fact_by_brand
	(
	market,  
	brand,  
	customer_Type,  
	inter_month,  
	period,  
	act_cus_cy,  
	act_cus_ly,  
	act_sales_cy,  
	act_sales_ly,  
	act_aus_cy,  
	act_aus_ly,  
	new_cus_cy,  
	new_cus_ly,  
	new_spending_cy,  
	new_spending_ly,  
	retained_cy,  
	retained_ly,  
	cross_brand_cus_cy,  
	cross_brand_cus_ly,  
	avgage_cy,  
	avgage_ly,
	repeatcus_cy,
	act_cus_R36,
	act_sales_R36,
	act_cus_contactable_cy,
	act_cus_contactable_ly,
	repeatcus_ly
	)
	(
	SELECT
	dc_ot.market_code AS market,
	dc_ot.signature_code AS brand,
	dc_ot.consumer_type AS customer_Type,
	FORMAT_DATETIME("%Y%m", DATETIME_SUB(DATE_VALUE,INTERVAL 1 MONTH)) AS inter_month,
	period[OFFSET(i)] AS period,
	( ----query2 Active Customer CURRENT Year
	SELECT COUNT(*) FROM (
		select
		case
			when dc.market_code='JP' then dc.mars_person_id
			when dc.market_code in ('TW','HK','KR') then dc.lucid
			else ''
		end unique_id,
		fc.order_date,
		fc.net_sales_in_local_curr,
		fc.market_product_code AS product,
		dc.consumer_type
		FROM
		`apmena-oneconsumer-dna-apac-qa.space_crm_domain.dim_consumer_trim` dc
		INNER JOIN
		`apmena-oneconsumer-dna-apac-qa.space_crm_domain.fact_sales` fc
		ON
		dc.consumer_code=fc.consumer_code
		WHERE
		fc.net_sales_in_local_curr >0
		AND FORMAT_TIMESTAMP("%Y%m%d",order_date) BETWEEN fromDATE_CY AND TODATE_CY
		and dc.signature_code= dc_ot.signature_code
		)) AS act_cus_cy,
	
	( ----query2 Active Customer last Year
		SELECT COUNT(*) FROM (
		select
		case
			when dc.market_code='JP' then dc.mars_person_id
			when dc.market_code in ('TW','HK','KR') then dc.lucid
			else ''
		end unique_id,
		fc.order_date,
		fc.net_sales_in_local_curr,
		fc.market_product_code AS product,
		dc.consumer_type
		FROM
		`apmena-oneconsumer-dna-apac-qa.space_crm_domain.dim_consumer_trim` dc
		INNER JOIN
		`apmena-oneconsumer-dna-apac-qa.space_crm_domain.fact_sales` fc
		ON
		dc.consumer_code=fc.consumer_code
		WHERE
		fc.net_sales_in_local_curr >0
		AND FORMAT_TIMESTAMP("%Y%m%d",order_date) BETWEEN FROMDATE_LY AND TODATE_LY
		and dc.signature_code= dc_ot.signature_code   
		)) AS act_cus_ly,
	
	(    ----query2_sum(netsale) Active Sales Current Year
	select sum(net_sales_in_local_curr)
	from
	(
	select
	case
	when dc.market_code='JP' then mars_person_id
	when dc.market_code in ('TW','HK','KR') then dc.lucid
	else ""
	end unique_id,
	fc.order_date,
	fc.net_sales_in_local_curr,
	fc.market_product_code as product,
	dc.consumer_type
	from `apmena-oneconsumer-dna-apac-qa.space_crm_domain.dim_consumer_trim` dc inner join
	`apmena-oneconsumer-dna-apac-qa.space_crm_domain.fact_sales` fc
	on dc.consumer_code=fc.consumer_code
	where
	fc.net_sales_in_local_curr >0
	and FORMAT_TIMESTAMP("%Y%m%d" ,order_date) BETWEEN fromDATE_CY AND TODATE_CY
	and dc.signature_code= dc_ot.signature_code
	)) as act_sales_cy,
	
	
	(    ----query2_sum(netsale) Active Sales last Year
	select sum(net_sales_in_local_curr)
	from
	(
	select
	case
	when dc.market_code='JP' then mars_person_id
	when dc.market_code in ('TW','HK','KR') then dc.lucid
	else ""
	end unique_id,
	fc.order_date,
	fc.net_sales_in_local_curr,
	fc.market_product_code as product,
	dc.consumer_type
	from `apmena-oneconsumer-dna-apac-qa.space_crm_domain.dim_consumer_trim` dc inner join
	`apmena-oneconsumer-dna-apac-qa.space_crm_domain.fact_sales` fc
	on dc.consumer_code=fc.consumer_code
	where
	fc.net_sales_in_local_curr >0
	and FORMAT_TIMESTAMP("%Y%m%d" ,order_date) BETWEEN FROMDATE_LY AND TODATE_LY
	and dc.signature_code= dc_ot.signature_code
	)) as act_sales_ly,
	
	( ----query 5 - Active Customer Sales Transaction current year #
	select count(*)
	from
	(
	select
	case
	when dc.market_code='JP' then mars_person_id
	when dc.market_code in ('TW','HK','KR') then dc.lucid
	else ""
	end unique_id,
	fc.order_date,
	fc.net_sales_in_local_curr,
	fc.market_product_code as product,
	dc.consumer_type
	
	from `apmena-oneconsumer-dna-apac-qa.space_crm_domain.dim_consumer_trim` dc inner join
	`apmena-oneconsumer-dna-apac-qa.space_crm_domain.fact_sales` fc
	on dc.consumer_code=fc.consumer_code
	where
	fc.net_sales_in_local_curr >0
	and FORMAT_TIMESTAMP("%Y%m%d" ,order_date) BETWEEN fromDATE_CY AND TODATE_CY
	and dc.signature_code= dc_ot.signature_code
	)) as act_aus_cy,
	
	( ----query 5 - Active Customer Sales Transaction last year #
	select count(*)
	from
	(
	select
	case
	when dc.market_code='JP' then mars_person_id
	when dc.market_code in ('TW','HK','KR') then dc.lucid
	else ""
	end unique_id,
	fc.order_date,
	fc.net_sales_in_local_curr,
	fc.market_product_code as product,
	dc.consumer_type
	
	from `apmena-oneconsumer-dna-apac-qa.space_crm_domain.dim_consumer_trim` dc inner join
	`apmena-oneconsumer-dna-apac-qa.space_crm_domain.fact_sales` fc
	on dc.consumer_code=fc.consumer_code
	where fc.net_sales_in_local_curr >0
	and FORMAT_TIMESTAMP("%Y%m%d" ,order_date) BETWEEN FROMDATE_LY AND TODATE_LY
	and dc.signature_code= dc_ot.signature_code
	)) as act_aus_ly,
	
	( --query1 -- New Customers Current Year
	select count(*) from
	(
		select 
		case
			when dc.market_code='JP' then mars_person_id
			when dc.market_code in ('TW','HK','KR') then dc.lucid
			else ''
		end unique_id,
		fc.order_date,
		fc.net_sales_in_local_curr,
		fc.market_product_code as product,
		dc.consumer_type
	
		from `apmena-oneconsumer-dna-apac-qa.space_crm_domain.dim_consumer_trim` dc inner join 
		`apmena-oneconsumer-dna-apac-qa.space_crm_domain.fact_sales` fc
		on dc.consumer_code=fc.consumer_code
	where FORMAT_TIMESTAMP("%Y%m%d" ,order_date) BETWEEN fromDATE_CY AND TODATE_CY
	and dc.signature_code= dc_ot.signature_code)) as new_cus_cy,
	
	
	( --query1 -- New Customers last Year
	select count(*) from
	(
		select 
		case
			when dc.market_code='JP' then mars_person_id
			when dc.market_code in ('TW','HK','KR') then dc.lucid
			else ''
		end unique_id,
		fc.order_date,
		fc.net_sales_in_local_curr,
		fc.market_product_code as product,
		dc.consumer_type
	
		from `apmena-oneconsumer-dna-apac-qa.space_crm_domain.dim_consumer_trim` dc inner join 
		`apmena-oneconsumer-dna-apac-qa.space_crm_domain.fact_sales` fc
		on dc.consumer_code=fc.consumer_code
	where FORMAT_TIMESTAMP("%Y%m%d" ,order_date) BETWEEN FROMDATE_LY AND TODATE_LY
	and dc.signature_code= dc_ot.signature_code)) as new_cus_ly,
	
	( --query1 + sum(net_sale)-- New Customers Current Year
	select sum(net_sales_in_local_curr) from
	(
		select 
		case
			when dc.market_code='JP' then mars_person_id
			when dc.market_code in ('TW','HK','KR') then dc.lucid
			else ''
		end as unique_id,
		fc.order_date,
		fc.net_sales_in_local_curr,
		fc.market_product_code as product,
		dc.consumer_type
		from `apmena-oneconsumer-dna-apac-qa.space_crm_domain.dim_consumer_trim` dc inner join 
		`apmena-oneconsumer-dna-apac-qa.space_crm_domain.fact_sales` fc
		on dc.consumer_code=fc.consumer_code
	where FORMAT_TIMESTAMP("%Y%m%d" ,order_date) BETWEEN fromDATE_CY AND TODATE_CY
	and dc.signature_code= dc_ot.signature_code)) as new_spending_cy,
	
	( --query1 + sum(net_sale) New Customers last Year
	select sum(net_sales_in_local_curr) from
	(
		select 
		case
			when dc.market_code='JP' then mars_person_id
			when dc.market_code in ('TW','HK','KR') then dc.lucid
			else ''
		end unique_id,
		fc.order_date,
		fc.net_sales_in_local_curr,
		fc.market_product_code as product,
		dc.consumer_type
		from `apmena-oneconsumer-dna-apac-qa.space_crm_domain.dim_consumer_trim` dc inner join 
		`apmena-oneconsumer-dna-apac-qa.space_crm_domain.fact_sales` fc
		on dc.consumer_code=fc.consumer_code
	where FORMAT_TIMESTAMP("%Y%m%d" ,order_date) BETWEEN FROMDATE_LY AND TODATE_LY
	and dc.signature_code= dc_ot.signature_code)) as new_spending_ly,
	
	
	(-- query 18 Retained Current Year
		select count(*) from
		(
		select thisYeartable.unique_id, thisYeartable.brand
		from
		(select distinct
		case
		when dc.market_code='JP' then mars_person_id
		when dc.market_code in ('TW','HK','KR') then dc.lucid
		else ''
		end unique_id,
		dc.signature_code as brand,
		dc.market_code
		from `apmena-oneconsumer-dna-apac-qa.space_crm_domain.dim_consumer_trim` dc inner join
		`apmena-oneconsumer-dna-apac-qa.space_crm_domain.fact_sales` fc 
		on dc.consumer_code=fc.consumer_code
		where
		FORMAT_TIMESTAMP("%Y%m%d" ,order_date) BETWEEN fromDATE_CY AND TODATE_CY
		and fc.net_sales_in_local_curr >0
		and is_consumer_flag = 'TRUE'
		) as thisYeartable,
		(
		select distinct
		case
		when dc.market_code='JP' then mars_person_id
		when dc.market_code in ('TW','HK','KR') then dc.lucid
		else ''
		end unique_id,
		dc.signature_code as brand,
		dc.market_code
		from `apmena-oneconsumer-dna-apac-qa.space_crm_domain.dim_consumer_trim` dc inner join
		`apmena-oneconsumer-dna-apac-qa.space_crm_domain.fact_sales` fc
		on dc.consumer_code=fc.consumer_code
		where
		FORMAT_TIMESTAMP("%Y%m%d" ,order_date) between R1324_FROMDATE_CY and R1324_TODATE_CY
		and fc.net_sales_in_local_curr >0
		and is_consumer_flag = 'TRUE'
		) as lastYearTable
	where thisYeartable.brand=lastYearTable.brand
	and lastYearTable.unique_id=thisYeartable.unique_id
	and lastYearTable.brand=dc_ot.signature_code
	and thisYeartable.brand=dc_ot.signature_code
	)) as retained_cy,
	
	(-- query 18 Retained last Year
		select count(*) from
		(
		select thisYeartable.unique_id, thisYeartable.brand
		from
		(select distinct
		case
		when dc.market_code='JP' then mars_person_id
		when dc.market_code in ('TW','HK','KR') then dc.lucid
		else ''
		end unique_id,
		dc.signature_code as brand,
		dc.market_code
		from `apmena-oneconsumer-dna-apac-qa.space_crm_domain.dim_consumer_trim` dc inner join
		`apmena-oneconsumer-dna-apac-qa.space_crm_domain.fact_sales` fc 
		on dc.consumer_code=fc.consumer_code
		where
		FORMAT_TIMESTAMP("%Y%m%d" ,order_date) BETWEEN fromDATE_LY AND TODATE_LY
		and fc.net_sales_in_local_curr >0
		and is_consumer_flag = 'TRUE'
		) as thisYeartable,
		(
		select distinct
		case
		when dc.market_code='JP' then mars_person_id
		when dc.market_code in ('TW','HK','KR') then dc.lucid
		else ''
		end unique_id,
		dc.signature_code as brand,
		dc.market_code
		from `apmena-oneconsumer-dna-apac-qa.space_crm_domain.dim_consumer_trim` dc inner join
		`apmena-oneconsumer-dna-apac-qa.space_crm_domain.fact_sales` fc
		on dc.consumer_code=fc.consumer_code
		where
		FORMAT_TIMESTAMP("%Y%m%d" ,order_date) between R1324_FROMDATE_LY and R1324_TODATE_LY
		and fc.net_sales_in_local_curr >0
		and is_consumer_flag = 'TRUE'
		) as lastYearTable
	where thisYeartable.brand=lastYearTable.brand
	and lastYearTable.unique_id=thisYeartable.unique_id
	and lastYearTable.brand=dc_ot.signature_code
	and thisYeartable.brand=dc_ot.signature_code
	)) as retained_ly,
	
	
	
	
	( --query 11 -- Cross Brand Customers Current Year
	select count(*)
	from
	(
	select unique_id, signature_code
	from (
	select
	case
	when dc.market_code='JP' then dc.mars_person_id
	when dc.market_code in ('TW','HK','KR') then dc.lucid
	else ''
	end unique_id,
	dc.signature_code
	from `apmena-oneconsumer-dna-apac-qa.space_crm_domain.dim_consumer_trim` dc inner join
	`apmena-oneconsumer-dna-apac-qa.space_crm_domain.fact_sales` fc
	on dc.consumer_code=fc.consumer_code
	where
	dc.is_consumer_flag = 'Y'
	and (dc.market_code not in ('HK') or (dc.market_code = 'HK' and fc.PROD_TYPE = 'YEG') and fc.net_sales_in_local_curr >0)
	and (fc.order_type in ('Normal Sales','Sales Return') or dc.market_code = 'KR')
	and FORMAT_TIMESTAMP("%Y%m%d" ,order_date) BETWEEN fromDATE_CY AND TODATE_CY
	group by unique_id, dc.signature_code
	HAVING COUNT(DISTINCT dc.signature_code)>1
	)
	where signature_code= dc_ot.signature_code
	
	))as cross_brand_cus_cy,
	
	( --query 11 -- Cross Brand Customers last Year
	select count(*)
	from
	(
	select unique_id, signature_code
	from (
	select
	case
	when dc.market_code='JP' then dc.mars_person_id
	when dc.market_code in ('TW','HK','KR') then dc.lucid
	else ''
	end unique_id,
	dc.signature_code
	from `apmena-oneconsumer-dna-apac-qa.space_crm_domain.dim_consumer_trim` dc inner join
	`apmena-oneconsumer-dna-apac-qa.space_crm_domain.fact_sales` fc
	on dc.consumer_code=fc.consumer_code
	where
	dc.is_consumer_flag = 'Y'
	and (dc.market_code not in ('HK') or (dc.market_code = 'HK' and fc.PROD_TYPE = 'YEG') and fc.net_sales_in_local_curr >0)
	and (fc.order_type in ('Normal Sales','Sales Return') or dc.market_code = 'KR')
	and FORMAT_TIMESTAMP("%Y%m%d" ,order_date) BETWEEN FROMDATE_LY AND TODATE_LY
	group by unique_id, dc.signature_code
	HAVING COUNT(DISTINCT dc.signature_code)>1
	)
	where signature_code= dc_ot.signature_code
	
	))as cross_brand_cus_ly,
	
	
	(--quer 23 -- Average Age current Year
	select AVG(customer_age)
	from(
	select
	case
	when dc.market_code='JP' then mars_person_id
	when dc.market_code in ('TW','HK','KR') then dc.lucid
	else ''
	end unique_id,
	fc.order_date,
	fc.net_sales_in_local_curr,
	dc.signature_code as brand,
	dc.year_of_birth,
	cast(FORMAT_DATETIME("%Y" ,DATE_VALUE) as int64) - cast(trim(dc.year_of_birth,' -') as INT64) as customer_age
	from `apmena-oneconsumer-dna-apac-qa.space_crm_domain.dim_consumer_trim` dc inner join
	`apmena-oneconsumer-dna-apac-qa.space_crm_domain.fact_sales` fc
	on dc.consumer_code=fc.consumer_code
	where
	fc.net_sales_in_local_curr >0
	and FORMAT_TIMESTAMP("%Y%m%d" ,order_date) BETWEEN fromDATE_CY AND TODATE_CY and dc.signature_code= dc_ot.signature_code
	and dc.YEAR_OF_BIRTH is not null
	)) as avgage_cy,
	
	
	
	(--quer 23 -- Average Age last Year
	select AVG(customer_age)
	from(
	select
	case
	when dc.market_code='JP' then mars_person_id
	when dc.market_code in ('TW','HK','KR') then dc.lucid
	else ''
	end unique_id,
	fc.order_date,
	fc.net_sales_in_local_curr,
	dc.signature_code as brand,
	dc.year_of_birth,
	cast(FORMAT_DATETIME("%Y" ,DATE_VALUE) as int64) - cast(trim(dc.year_of_birth,' -') as INT64) as customer_age
	from `apmena-oneconsumer-dna-apac-qa.space_crm_domain.dim_consumer_trim` dc inner join
	`apmena-oneconsumer-dna-apac-qa.space_crm_domain.fact_sales` fc
	on dc.consumer_code=fc.consumer_code
	where
	fc.net_sales_in_local_curr >0
	and FORMAT_TIMESTAMP("%Y%m%d" ,order_date) BETWEEN FROMDATE_LY AND TODATE_LY and dc.signature_code= dc_ot.signature_code
	and dc.YEAR_OF_BIRTH is not null
	)) as avgage_ly,
	
	
	(-- query 15 New Repeat customer Current Year --Newly Added
	select count(*)
	from(
	select thisYeartable.unique_id, thisYeartable.brand
	from 
	(select 
		case
			when dc.market_code='JP' then mars_person_id
			when dc.market_code in ('TW','HK','KR') then dc.lucid
			else ''
		end unique_id,
		dc.signature_code as brand,
		dc.market_code
		from `apmena-oneconsumer-dna-apac-qa.space_crm_domain.dim_consumer_trim` dc inner join 
		`apmena-oneconsumer-dna-apac-qa.space_crm_domain.fact_sales` fc
		on dc.consumer_code=fc.consumer_code
		where 
		FORMAT_TIMESTAMP("%Y%m%d" ,order_date) BETWEEN fromDATE_CY AND TODATE_CY
		and is_consumer_flag = 'TRUE'
		group by brand,dc.market_code , unique_id
	) as thisYeartable,
	(select 
		case
			when dc.market_code='JP' then mars_person_id
			when dc.market_code in ('TW','HK','KR') then dc.lucid
			else ''
		end unique_id,
		dc.signature_code as brand,
		dc.market_code
		from `apmena-oneconsumer-dna-apac-qa.space_crm_domain.dim_consumer_trim` dc inner join 
		`apmena-oneconsumer-dna-apac-qa.space_crm_domain.fact_sales` fc
		on dc.consumer_code=fc.consumer_code
		where 
		FORMAT_TIMESTAMP("%Y%m%d" ,order_date) between R1324_FROMDATE_CY and R1324_TODATE_CY
		and is_consumer_flag = 'TRUE'
		group by brand,dc.market_code , unique_id
	) as lastYearTable
	where thisYeartable.brand=lastYearTable.brand
	and lastYearTable.unique_id=thisYeartable.unique_id
	and lastYearTable.brand=dc_ot.signature_code
	and thisYeartable.brand=dc_ot.signature_code
	))as repeatcus_cy,
	
	
	( ----query2 Active Customer R36 Year 
	SELECT COUNT(*) FROM (
		select
		case
			when dc.market_code='JP' then dc.mars_person_id
			when dc.market_code in ('TW','HK','KR') then dc.lucid
			else ''
		end unique_id,
		fc.order_date,
		fc.net_sales_in_local_curr,
		fc.market_product_code AS product,
		dc.consumer_type
		FROM
		`apmena-oneconsumer-dna-apac-qa.space_crm_domain.dim_consumer_trim` dc
		INNER JOIN
		`apmena-oneconsumer-dna-apac-qa.space_crm_domain.fact_sales` fc
		ON
		dc.consumer_code=fc.consumer_code
		WHERE
		fc.net_sales_in_local_curr >0
		AND FORMAT_TIMESTAMP("%Y%m%d",order_date) BETWEEN R36_FROM AND R36_TO
		and dc.signature_code= dc_ot.signature_code
		)) AS act_cus_R36,
		
		
		(    ----query2_sum(netsale) Active Sales R36 Year
	select sum(net_sales_in_local_curr)
	from
	(
	select
	case
	when dc.market_code='JP' then mars_person_id
	when dc.market_code in ('TW','HK','KR') then dc.lucid
	else ""
	end unique_id,
	fc.order_date,
	fc.net_sales_in_local_curr,
	fc.market_product_code as product,
	dc.consumer_type
	from `apmena-oneconsumer-dna-apac-qa.space_crm_domain.dim_consumer_trim` dc inner join
	`apmena-oneconsumer-dna-apac-qa.space_crm_domain.fact_sales` fc
	on dc.consumer_code=fc.consumer_code
	where
	fc.net_sales_in_local_curr >0
	and FORMAT_TIMESTAMP("%Y%m%d" ,order_date) BETWEEN R36_FROM AND R36_TO
	and dc.signature_code= dc_ot.signature_code
	)) as act_sales_R36,
	
	
	( ----query2 Active Customer CURRENT Year + contactable
	SELECT COUNT(*) FROM (
		select
		case
			when dc.market_code='JP' then dc.mars_person_id
			when dc.market_code in ('TW','HK','KR') then dc.lucid
			else ''
		end unique_id,
		fc.order_date,
		fc.net_sales_in_local_curr,
		fc.market_product_code AS product,
		dc.consumer_type
		FROM
		`apmena-oneconsumer-dna-apac-qa.space_crm_domain.dim_consumer_trim` dc
		INNER JOIN
		`apmena-oneconsumer-dna-apac-qa.space_crm_domain.fact_sales` fc
		ON
		dc.consumer_code=fc.consumer_code
		WHERE
		fc.net_sales_in_local_curr >0
		AND FORMAT_TIMESTAMP("%Y%m%d",order_date) BETWEEN fromDATE_CY AND TODATE_CY
		and dc.signature_code= dc_ot.signature_code and (dc.is_valid_direct_message='Y' or dc.is_Opt_In_direct_message='Y' or dc.is_Valid_email='Y' or dc.is_Opt_In_email='Y' or dc.is_Valid_home_phone='Y' or dc.is_Opt_In_home_Phone='Y' or dc.is_Valid_mobile='Y' or dc.is_Opt_In_Call='Y' or dc.is_Opt_In_SMS='Y' or dc.is_Valid_Line='Y' or dc.is_Opt_In_Line='Y' or dc.is_whatsapp_contactable='Y')
		)) AS act_cus_contactable_cy,
		
		
		
		( ----query2 Active Customer Last Year + contactable
	SELECT COUNT(*) FROM (
		select
		case
			when dc.market_code='JP' then dc.mars_person_id
			when dc.market_code in ('TW','HK','KR') then dc.lucid
			else ''
		end unique_id,
		fc.order_date,
		fc.net_sales_in_local_curr,
		fc.market_product_code AS product,
		dc.consumer_type
		FROM
		`apmena-oneconsumer-dna-apac-qa.space_crm_domain.dim_consumer_trim` dc
		INNER JOIN
		`apmena-oneconsumer-dna-apac-qa.space_crm_domain.fact_sales` fc
		ON
		dc.consumer_code=fc.consumer_code
		WHERE
		fc.net_sales_in_local_curr >0
		AND FORMAT_TIMESTAMP("%Y%m%d",order_date) BETWEEN fromDATE_LY AND TODATE_LY
		and dc.signature_code= dc_ot.signature_code and (dc.is_valid_direct_message='Y' or dc.is_Opt_In_direct_message='Y' or dc.is_Valid_email='Y' or dc.is_Opt_In_email='Y' or dc.is_Valid_home_phone='Y' or dc.is_Opt_In_home_Phone='Y' or dc.is_Valid_mobile='Y' or dc.is_Opt_In_Call='Y' or dc.is_Opt_In_SMS='Y' or dc.is_Valid_Line='Y' or dc.is_Opt_In_Line='Y' or dc.is_whatsapp_contactable='Y')
		)) AS act_cus_contactable_ly,
		
		
		(-- query 15 New Repeat customer Last Year --Newly Added
	select count(*)
	from(
	select thisYeartable.unique_id, thisYeartable.brand
	from
	(select
		case
			when dc.market_code='JP' then mars_person_id
			when dc.market_code in ('TW','HK','KR') then dc.lucid
			else ''
		end unique_id,
		dc.signature_code as brand,
		dc.market_code
		from `apmena-oneconsumer-dna-apac-qa.space_crm_domain.dim_consumer_trim` dc inner join
		`apmena-oneconsumer-dna-apac-qa.space_crm_domain.fact_sales` fc
		on dc.consumer_code=fc.consumer_code
		where
		FORMAT_TIMESTAMP("%Y%m%d" ,order_date) BETWEEN fromDATE_LY AND TODATE_LY
		and is_consumer_flag = 'TRUE'
		group by brand,dc.market_code , unique_id
	) as thisYeartable,
	(select
		case
			when dc.market_code='JP' then mars_person_id
			when dc.market_code in ('TW','HK','KR') then dc.lucid
			else ''
		end unique_id,
		dc.signature_code as brand,
		dc.market_code
		from `apmena-oneconsumer-dna-apac-qa.space_crm_domain.dim_consumer_trim` dc inner join
		`apmena-oneconsumer-dna-apac-qa.space_crm_domain.fact_sales` fc
		on dc.consumer_code=fc.consumer_code
		where
		FORMAT_TIMESTAMP("%Y%m%d" ,order_date) between R1324_FROMDATE_CY and R1324_TODATE_CY
		and is_consumer_flag = 'TRUE'
		group by brand,dc.market_code , unique_id
	) as lastYearTable
	where thisYeartable.brand=lastYearTable.brand
	and lastYearTable.unique_id=thisYeartable.unique_id
	and lastYearTable.brand=dc_ot.signature_code
	and thisYeartable.brand=dc_ot.signature_code
	)as repeatcus_ly
	)
	
	
	
	
	FROM
		`apmena-oneconsumer-dna-apac-qa.space_crm_domain.dim_consumer_trim` dc_ot
		group by dc_ot.signature_code, dc_ot.market_code,dc_ot.consumer_type 
			);
	set i = i + 1;
	END WHILE;

set k = k + 1;
END WHILE;