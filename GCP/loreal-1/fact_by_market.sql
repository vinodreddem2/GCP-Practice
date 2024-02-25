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


	SET i=0;
	set period = ["MTD","YTD","R12"];
	
	WHILE i < ARRAY_LENGTH(period) DO
	IF period[OFFSET(i)] = 'MTD' THEN 
			set fromDATE_CY = MTD_FROM_CY; 
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
		/*
		insert into `apmena-oneconsumer-dna-apac-qa.space_crm_domain.dateLoopTest`
		(Period,currentFromDate,currentToDate)
		values ( period[OFFSET(i)], fromDATE_CY,TODATE_CY);
		*/
 insert into apmena-oneconsumer-dna-apac-qa.space_crm_domain.fact_by_market
		(
            market	, 
            brand	, 
            customer_Type	, 
            inter_month	, 
            period	, 
            act_cus_cy	, 
            act_cus_ly	, 
            new_cus_cy	, 
            new_cus_ly	, 
            retained_cy	, 
            retained_ly	, 
            act_aus_cy	, 
            act_aus_ly,
			repeatcus_cy,
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
			  AND FORMAT_TIMESTAMP("%Y%m%d",order_date) BETWEEN FROMDATE_CY AND TODATE_CY
			  and dc.market_code= dc_ot.market_code
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
			  and dc.market_code= dc_ot.market_code   
			)) AS act_cus_ly,



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
		where FORMAT_TIMESTAMP("%Y%m%d" ,order_date) BETWEEN FROMDATE_CY AND TODATE_CY
		and dc.market_code= dc_ot.market_code)) as new_cus_cy,


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
		and dc.market_code= dc_ot.market_code)) as new_cus_ly,



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
			FORMAT_TIMESTAMP("%Y%m%d" ,order_date) between FROMDATE_CY and TODATE_CY
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
			FORMAT_TIMESTAMP("%Y%m%d" ,order_date) between R1324_TO and R1324_FROM
			and fc.net_sales_in_local_curr >0
			and is_consumer_flag = 'TRUE'
			) as lastYearTable
		where thisYeartable.brand=lastYearTable.brand
		and lastYearTable.unique_id=thisYeartable.unique_id
		and lastYearTable.market_code=thisYeartable.market_code
		and lastYearTable.market_code=dc_ot.market_code
		and thisYeartable.market_code=dc_ot.market_code
		)) as retained_cy,

		  (-- query 18 Retained Last Year
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
			FORMAT_TIMESTAMP("%Y%m%d" ,order_date) between FROMDATE_LY and TODATE_LY 
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
			FORMAT_TIMESTAMP("%Y%m%d" ,order_date) between R1324_TO and R1324_FROM
			and fc.net_sales_in_local_curr >0
			and is_consumer_flag = 'TRUE'
			) as lastYearTable
		where thisYeartable.brand=lastYearTable.brand
		and lastYearTable.unique_id=thisYeartable.unique_id
		and lastYearTable.market_code=thisYeartable.market_code
		and lastYearTable.market_code=dc_ot.market_code
		and thisYeartable.market_code=dc_ot.market_code
		)) as retained_ly,


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
		and FORMAT_TIMESTAMP("%Y%m%d" ,order_date) BETWEEN FROMDATE_CY AND TODATE_CY
		and dc.market_code= dc_ot.market_code
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
		and dc.market_code= dc_ot.market_code
		)) as act_aus_ly,
	
		(select 
		count(*) 
			from 
			(
				select 
		case
			when dc.market_code='JP' then dc.mars_person_id
			when dc.market_code in ('TW','HK','KR') then dc.lucid
			else ''
		end unique_id,
		dc.MARKET_CODE
		from `apmena-oneconsumer-dna-apac-qa.space_crm_domain.dim_consumer_trim` dc 
		inner join `apmena-oneconsumer-dna-apac-qa.space_crm_domain.fact_sales` fc on dc.consumer_code=fc.consumer_code
		where is_consumer_flag='True' or is_consumer_flag IS NULL 
		AND FORMAT_TIMESTAMP("%Y%m%d",order_date) BETWEEN fromDATE_CY AND TODATE_CY
		and fc.net_sales_in_local_curr>0 or (dc.market_code='HK' and fc.PROD_TYPE='YFG' and fc.net_sales_in_local_curr>0 ) 
		and (fc.order_type) in ('Normal Sales','Sales Return') or dc.market_code='KR' 
		group by unique_id, dc.market_code
		) as thisYeartable,
	  (
		select 
		case
			when dc.market_code='JP' then dc.mars_person_id
			when dc.market_code in ('TW','HK','KR') then dc.lucid
			else ''
		end unique_id,
		dc.MARKET_CODE
		from `apmena-oneconsumer-dna-apac-qa.space_crm_domain.dim_consumer_trim` dc inner join 
		`apmena-oneconsumer-dna-apac-qa.space_crm_domain.fact_sales` fc on dc.consumer_code=fc.consumer_code
		where is_consumer_flag='True' or is_consumer_flag IS NULL 
		AND FORMAT_TIMESTAMP("%Y%m%d" ,order_date) between R1324_FROMDATE_CY and R1324_TODATE_CY
		and fc.net_sales_in_local_curr>0 or (dc.market_code='HK' and fc.PROD_TYPE='YFG' and fc.net_sales_in_local_curr>0 ) 
		and (fc.order_type) in ('Normal Sales','Sales Return') or dc.market_code='KR' 
		group by unique_id, dc.market_code 
		) as lastYearTable
		where thisYeartable.MARKET_CODE=lastYearTable.MARKET_CODE
		and lastYearTable.unique_id=thisYeartable.unique_id
		and lastYearTable.MARKET_CODE=dc_ot.MARKET_CODE
		and thisYeartable.MARKET_CODE=dc_ot.MARKET_CODE
		) as repeatcus_cy,
		
		
			(select 
		count(*) 
		from 
	(
	      select 
		case
			when dc.market_code='JP' then dc.mars_person_id
			when dc.market_code in ('TW','HK','KR') then dc.lucid
			else ''
		end unique_id,
		dc.MARKET_CODE
		from `apmena-oneconsumer-dna-apac-qa.space_crm_domain.dim_consumer_trim` dc 
		inner join `apmena-oneconsumer-dna-apac-qa.space_crm_domain.fact_sales` fc on dc.consumer_code=fc.consumer_code
		where is_consumer_flag='True' or is_consumer_flag IS NULL 
		AND FORMAT_TIMESTAMP("%Y%m%d",order_date) BETWEEN fromDATE_LY AND TODATE_LY
		and fc.net_sales_in_local_curr>0 or (dc.market_code='HK' and fc.PROD_TYPE='YFG' and fc.net_sales_in_local_curr>0 ) 
		and (fc.order_type) in ('Normal Sales','Sales Return') or dc.market_code='KR' 
		group by unique_id, dc.market_code
		) as thisYeartable,
	(
		select 
		case
			when dc.market_code='JP' then dc.mars_person_id
			when dc.market_code in ('TW','HK','KR') then dc.lucid
			else ''
		end unique_id,
		dc.MARKET_CODE
		from `apmena-oneconsumer-dna-apac-qa.space_crm_domain.dim_consumer_trim` dc inner join 
		`apmena-oneconsumer-dna-apac-qa.space_crm_domain.fact_sales` fc on dc.consumer_code=fc.consumer_code
		where is_consumer_flag='True' or is_consumer_flag IS NULL 
		AND FORMAT_TIMESTAMP("%Y%m%d" ,order_date) between R1324_FROMDATE_LY and R1324_TODATE_LY
		and fc.net_sales_in_local_curr>0 or (dc.market_code='HK' and fc.PROD_TYPE='YFG' and fc.net_sales_in_local_curr>0 ) 
		and (fc.order_type) in ('Normal Sales','Sales Return') or dc.market_code='KR' 
		group by unique_id, dc.market_code 
		) as lastYearTable
		where thisYeartable.MARKET_CODE=lastYearTable.MARKET_CODE
		and lastYearTable.unique_id=thisYeartable.unique_id
		and lastYearTable.MARKET_CODE=dc_ot.MARKET_CODE
		and thisYeartable.MARKET_CODE=dc_ot.MARKET_CODE
		) as repeatcus_ly,
	
			FROM
				`apmena-oneconsumer-dna-apac-qa.space_crm_domain.dim_consumer_trim` dc_ot
				group by dc_ot.market_code, dc_ot.signature_code,dc_ot.consumer_type
	
			);
		set i = i + 1;
		END WHILE;

set k = k + 1;
END WHILE;
