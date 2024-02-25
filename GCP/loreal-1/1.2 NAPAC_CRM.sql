--declare historydates DEFAULT ["20200501","20210101"]; 
declare historydates DEFAULT ["20200501"];
DECLARE DATE_VALUE DATETIME DEFAULT PARSE_DATE("%Y%m%d", "20200401"); --Dummy Value
DECLARE k INT64 DEFAULT 0;
DECLARE 
MTD_TO_CY, MTD_FROM_CY, MTD_TO_LY, MTD_FROM_LY,
YTD_TO_CY, YTD_FROM_CY, YTD_TO_LY, YTD_FROM_LY,
R12_TO_CY, R12_FROM_CY,
R12_TO_LY, R12_FROM_LY,
R36_TO, R36_FROM ,
R36_TO_LY, R36_FROM_LY ,
R2536_TO, R2536_FROM,
R1324_TO, R1324_FROM,
R13MTD_TO_CY, R13MTD_FROM_CY,
R13MTD_TO_LY,R13MTD_FROM_LY ,
R13YTD_TO_CY , R13YTD_FROM_CY,
R13YTD_TO_LY, R13YTD_FROM_LY ,
R1324R12_TO_CY ,R1324R12_FROM_CY ,
R1324R12_TO_LY , R1324R12_FROM_LY ,
R1324_FROMDATE_MTD , R1324_TODATE_MTD,
R2536_FROMDATE_MTD , R2536_TODATE_MTD,
STRING DEFAULT "";

DECLARE FROMDATE_CY, TODATE_CY, FROMDATE_LY, TODATE_LY , R1324_FROMDATE_CY, R1324_FROMDATE_LY, R1324_TODATE_CY, R1324_TODATE_LY STRING DEFAULT "0" ;

DECLARE period ARRAY <STRING>;
DECLARE i INT64 DEFAULT 0;



WHILE k < ARRAY_LENGTH(historydates) DO
  	SET DATE_VALUE = PARSE_DATE("%Y%m%d",historydates[OFFSET(k)]);
	
	SET MTD_TO_CY = FORMAT_DATETIME("%Y%m%d" , LAST_DAY(DATETIME_SUB(DATE_VALUE, INTERVAL 1 MONTH), MONTH));
	SET MTD_FROM_CY = CONCAT(FORMAT_DATETIME("%Y%m" , DATETIME_SUB(DATE_VALUE, INTERVAL 1 MONTH)), "01"); 

	SET MTD_TO_LY = FORMAT_DATETIME("%Y%m%d" , LAST_DAY(DATETIME_SUB(DATE_VALUE, INTERVAL 13 MONTH), MONTH));
	SET MTD_FROM_LY = CONCAT(FORMAT_DATETIME("%Y%m" , DATETIME_SUB(DATE_VALUE, INTERVAL 13 MONTH)), "01");
	
	SET YTD_TO_CY = FORMAT_DATETIME("%Y%m%d" , LAST_DAY(DATETIME_SUB(DATE_VALUE, INTERVAL 1 MONTH), MONTH));
	SET YTD_FROM_CY = CONCAT(FORMAT_DATETIME("%Y" , DATETIME_SUB(DATE_VALUE, INTERVAL 1 MONTH)), "0101");
	
	SET YTD_TO_LY = FORMAT_DATETIME("%Y%m%d" , LAST_DAY(DATETIME_SUB(DATE_VALUE, INTERVAL 13 MONTH), MONTH));
	SET YTD_FROM_LY = CONCAT(FORMAT_DATETIME("%Y" , DATETIME_SUB(DATE_VALUE, INTERVAL 13 MONTH)), "0101");
	
	SET R12_TO_CY = FORMAT_DATETIME("%Y%m%d" , LAST_DAY(DATETIME_SUB(DATE_VALUE, INTERVAL 1 MONTH), MONTH));
	SET R12_FROM_CY = CONCAT(FORMAT_DATETIME("%Y%m" , DATETIME_SUB(DATE_VALUE, INTERVAL 1 YEAR)), "01");
	
	SET R12_TO_LY = FORMAT_DATETIME("%Y%m%d" , LAST_DAY(DATETIME_SUB(DATE_VALUE, INTERVAL 13 MONTH), MONTH)); 
	SET R12_FROM_LY = CONCAT(FORMAT_DATETIME("%Y%m" , DATETIME_SUB(DATE_VALUE, INTERVAL 24 MONTH)), "01");  
	
	SET R36_TO = FORMAT_DATETIME("%Y%m%d" , LAST_DAY(DATETIME_SUB(DATE_VALUE, INTERVAL 1 MONTH), MONTH));
	SET R36_FROM = CONCAT(FORMAT_DATETIME("%Y%m" , DATETIME_SUB(DATE_VALUE, INTERVAL 36 MONTH)), "01"); 
	
	SET R36_TO_LY = FORMAT_DATETIME("%Y%m%d" , LAST_DAY(DATETIME_SUB(DATE_VALUE, INTERVAL 13 MONTH), MONTH));
    SET R36_FROM_LY = CONCAT(FORMAT_DATETIME("%Y%m" , DATETIME_SUB(DATE_VALUE, INTERVAL 48 MONTH)), "01");
	
	SET R2536_TO = FORMAT_DATETIME("%Y%m%d" , LAST_DAY(DATETIME_SUB(DATE_VALUE, INTERVAL 25 MONTH), MONTH));
	SET R2536_FROM = CONCAT(FORMAT_DATETIME("%Y%m" , DATETIME_SUB(DATE_VALUE, INTERVAL 36 MONTH)), "01");
	
	SET R1324_TO = FORMAT_DATETIME("%Y%m%d" , LAST_DAY(DATETIME_SUB(DATE_VALUE, INTERVAL 13 MONTH), MONTH));
	SET R1324_FROM = CONCAT(FORMAT_DATETIME("%Y%m" , DATETIME_SUB(DATE_VALUE, INTERVAL 24 MONTH)), "01"); 
	
	SET R13MTD_TO_CY = FORMAT_DATETIME("%Y%m%d" , LAST_DAY(DATETIME_SUB(DATE_VALUE, INTERVAL 13 MONTH), MONTH));
	SET R13MTD_FROM_CY = CONCAT(FORMAT_DATETIME("%Y%m" , DATETIME_SUB(DATE_VALUE, INTERVAL 13 MONTH)), "01");
	
	SET R13MTD_TO_LY = FORMAT_DATETIME("%Y%m%d" , LAST_DAY(DATETIME_SUB(DATE_VALUE, INTERVAL 25 MONTH), MONTH));
	SET R13MTD_FROM_LY = CONCAT(FORMAT_DATETIME("%Y%m" , DATETIME_SUB(DATE_VALUE, INTERVAL 25 MONTH)), "01");
	
	SET R13YTD_TO_CY = FORMAT_DATETIME("%Y%m%d" , LAST_DAY(DATETIME_SUB(DATE_VALUE, INTERVAL 13 MONTH), MONTH));
	SET R13YTD_FROM_CY = CONCAT(FORMAT_DATETIME("%Y" , DATETIME_SUB(DATE_VALUE, INTERVAL 13 MONTH)), "0101");
	
	SET R13YTD_TO_LY = FORMAT_DATETIME("%Y%m%d" , LAST_DAY(DATETIME_SUB(DATE_VALUE, INTERVAL 25 MONTH), MONTH));
	SET R13YTD_FROM_LY = CONCAT(FORMAT_DATETIME("%Y" , DATETIME_SUB(DATE_VALUE, INTERVAL 25 MONTH)), "0101");
	
	SET R1324R12_TO_CY = FORMAT_DATETIME("%Y%m%d" , LAST_DAY(DATETIME_SUB(DATE_VALUE, INTERVAL 13 MONTH), MONTH));
	SET R1324R12_FROM_CY = CONCAT(FORMAT_DATETIME("%Y%m" , DATETIME_SUB(DATE_VALUE, INTERVAL 24 MONTH)), "01"); 
	
	SET R1324R12_TO_LY = FORMAT_DATETIME("%Y%m%d" , LAST_DAY(DATETIME_SUB(DATE_VALUE, INTERVAL 25 MONTH), MONTH));
	SET R1324R12_FROM_LY = CONCAT(FORMAT_DATETIME("%Y%m" , DATETIME_SUB(DATE_VALUE, INTERVAL 36 MONTH)), "01"); 
	
	
	--Newly added
	SET R1324_FROMDATE_MTD = CONCAT(FORMAT_DATETIME("%Y" , DATETIME_SUB(DATE_VALUE, INTERVAL 13 MONTH)), "0101");
	SET R1324_TODATE_MTD = CONCAT(FORMAT_DATETIME("%Y" , DATETIME_SUB(DATE_VALUE, INTERVAL 13 MONTH)), "1231");
	
	SET R2536_FROMDATE_MTD = CONCAT(FORMAT_DATETIME("%Y" , DATETIME_SUB(DATE_VALUE, INTERVAL 25 MONTH)), "0101");
	SET R2536_TODATE_MTD = CONCAT(FORMAT_DATETIME("%Y" , DATETIME_SUB(DATE_VALUE, INTERVAL 25 MONTH)), "1231");
	
	
	
	SET i=0;
    set period = ["MTD"];
	--set period = ["MTD","YTD","R12"];
	WHILE i < ARRAY_LENGTH(period) DO
	IF period[OFFSET(i)] = 'MTD' THEN 
			set FROMDATE_CY = MTD_FROM_CY; 
			set TODATE_CY = MTD_TO_CY;
			set fromDATE_LY = MTD_FROM_LY; 
			set TODATE_LY = MTD_TO_LY;
			
			set R1324_FROMDATE_CY =R1324_FROMDATE_MTD;
			set R1324_FROMDATE_LY = R2536_FROMDATE_MTD;
			set R1324_TODATE_CY = R1324_TODATE_MTD;
			set R1324_TODATE_LY = R2536_TODATE_MTD;
			
		ElseIF period[OFFSET(i)] = 'YTD' THEN
			set FROMDATE_CY = YTD_FROM_CY; 
			set TODATE_CY = YTD_TO_CY;
			set fromDATE_LY = YTD_FROM_LY; 
			set TODATE_LY = YTD_TO_LY;
			
			set R1324_FROMDATE_CY = R1324_FROMDATE_MTD;
			set R1324_FROMDATE_LY = R2536_FROMDATE_MTD;
			set R1324_TODATE_CY = R1324_TODATE_MTD;
			set R1324_TODATE_LY = R2536_TODATE_MTD;
			
		ELSEIF period[OFFSET(i)] = 'R12' THEN 
			set FROMDATE_CY = R12_FROM_CY;
			set TODATE_CY = R12_TO_CY;
			set fromDATE_LY = R12_FROM_LY;
			set TODATE_LY = R12_TO_LY;
			
			set R1324_FROMDATE_CY = R1324R12_FROM_CY;
			set R1324_FROMDATE_LY = R1324R12_FROM_LY;
			set R1324_TODATE_CY = R1324R12_TO_CY;
			set R1324_TODATE_LY = R1324R12_TO_LY;
	END IF;

/*	insert into `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_by_brand_2308`
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
		
		transaction_aus_cy,  
		transaction_aus_ly,  
		
		new_cus_cy,   
		new_cus_ly, 
		
		new_repeatcus_cy,   
		new_repeatcus_ly,  
		
		retained_cy,  
		retained_ly,
		
		avgage_cy, 
		avgage_ly, 
		
		act_cus_contactable_cy, 
		act_cus_contactable_ly, 
		
		retenbase_cy,	
		retenbase_ly,

		
		net_sale_aus_cy,
		net_sale_aus_ly
		
	)
	*/


(
	SELECT distinct 
	dc_ot.market_code AS market,
	dc_ot.signature_code AS brand,
	dc_ot.consumer_type AS customer_Type,
	dc_ot.gender AS Gender,
    cc_ot.channel_mode,
	FORMAT_DATETIME("%Y%m", DATETIME_SUB(DATE_VALUE,INTERVAL 1 MONTH)) AS inter_month,
	period[OFFSET(i)] AS period,
	
	
(--Active Customer Current Year
	select active_cust from
		(
		select DISTINCT
		market_code,
		signature_code,
		consumer_type,
		gender,
		channel_mode,
		count(lucid) as active_cust from
		(
				SELECT o.market_code, c.signature_code,c.consumer_type,lucid,c.gender,cc.channel_mode,
				sum(o.net_sales_in_local_curr) as tot
				from
				`apmena-oneconsumer-dna-apac-qa.space_crm_1_2.dim_consumer_napac` c 
				left join
				`apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o
				on c.consumer_code=o.consumer_code
				right join
				`apmena-oneconsumer-dna-apac-qa.crm_market_summary_data.counter_to_channel` cc
				ON o.counter_code = concat(cc.market_id,cc.counter_id)
				
				where c.is_consumer_flag='Y' 
				and c.division='LLD' 
				and ((o.PROD_TYPE='YFG' and o.market_code='HK') or o.net_sales_in_local_curr <>0)
				AND FORMAT_TIMESTAMP("%Y%m%d",o.order_date) BETWEEN FROMDATE_CY AND TODATE_CY
				and (o.order_type in ('Normal Sales','Sales Return') or o.market_code='KR') 
				group by o.market_code,c.signature_code,c.consumer_type,lucid, c.gender,cc.channel_mode
				having tot>0
		)
			group by market_code,signature_code, consumer_type , gender, channel_mode
        )
		---------------------------------------
        where  market_code = dc_ot.market_code
		and signature_code = dc_ot.signature_code
		and consumer_type = dc_ot.consumer_type
        and gender = dc_ot.gender
		and channel_mode = cc_ot.channel_mode
	)as act_cus_cy,


(--Active Customer Current Year
	select active_cust from
		(
		select DISTINCT
		market_code,
		signature_code,
		consumer_type,
		gender,
		channel_mode,
		count(lucid) as active_cust from
		(
				SELECT o.market_code, c.signature_code,c.consumer_type,lucid,c.gender,cc.channel_mode,
				sum(o.net_sales_in_local_curr) as tot
				from
				`apmena-oneconsumer-dna-apac-qa.space_crm_1_2.dim_consumer_napac` c 
				left join
				`apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o
				on c.consumer_code=o.consumer_code
				right join
				`apmena-oneconsumer-dna-apac-qa.crm_market_summary_data.counter_to_channel` cc
				ON o.counter_code = concat(cc.market_id,cc.counter_id)
				
				where c.is_consumer_flag='Y' 
				and c.division='LLD' 
				and ((o.PROD_TYPE='YFG' and o.market_code='HK') or o.net_sales_in_local_curr <>0)
				AND FORMAT_TIMESTAMP("%Y%m%d",o.order_date) BETWEEN FROMDATE_LY AND TODATE_LY
				and (o.order_type in ('Normal Sales','Sales Return') or o.market_code='KR') 
				group by o.market_code,c.signature_code,c.consumer_type,lucid, c.gender,cc.channel_mode
				having tot>0
		)
			group by market_code,signature_code, consumer_type , gender, channel_mode
        )
		---------------------------------------
        where  market_code = dc_ot.market_code
		and signature_code = dc_ot.signature_code
		and consumer_type = dc_ot.consumer_type
        and gender = dc_ot.gender
		and channel_mode = cc_ot.channel_mode
	)as act_cus_ly,


(--Active Sales Current Year
	select active_cust_sales from
		(
		select 
		market_code,
		signature_code,
		consumer_type,
		gender,
		channel_mode,
		sum(tot) as active_cust_sales from
		(
				SELECT o.market_code, c.signature_code,c.consumer_type,lucid,c.gender,cc.channel_mode,
				sum(o.net_sales_in_local_curr) as tot
				from `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o
				inner join `apmena-oneconsumer-dna-apac-qa.space_crm_1_2.dim_consumer_napac` c 
				on c.consumer_code=o.consumer_code
				left join `apmena-oneconsumer-dna-apac-qa.crm_market_summary_parallel_run.counter_to_channel` cc
                ON o.counter_code = concat(cc.market_id,cc.counter_id)
				where c.is_consumer_flag='Y'
				and c.division='LLD'
				and ((o.PROD_TYPE='YFG' and o.market_code='HK') or o.net_sales_in_local_curr <>0)
				AND FORMAT_TIMESTAMP("%Y%m%d",o.order_date) BETWEEN FROMDATE_CY AND TODATE_CY
				and (o.order_type in ('Normal Sales','Sales Return') or o.market_code='KR') 
				group by o.market_code,c.signature_code,c.consumer_type,lucid, c.gender,cc.channel_mode
				having tot<>0
		)
			group by market_code,signature_code, consumer_type , gender, channel_mode
			--having market_code='KR'
        )
		---------------------------------------
        where  market_code = dc_ot.market_code
		and signature_code = dc_ot.signature_code
		and consumer_type = dc_ot.consumer_type
        and gender = dc_ot.gender
		and channel_mode = cc_ot.channel_mode
	)as act_cus_sales_cy,


(--Active Sales Last Year
	select active_cust_sales from
		(
		select 
		market_code,
		signature_code,
		consumer_type,
		gender,
		channel_mode,
		sum(tot) as active_cust_sales from
		(
				SELECT o.market_code, c.signature_code,c.consumer_type,lucid,c.gender,cc.channel_mode,
				sum(o.net_sales_in_local_curr) as tot
				from `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o
				inner join `apmena-oneconsumer-dna-apac-qa.space_crm_1_2.dim_consumer_napac` c 
				on c.consumer_code=o.consumer_code
				left join `apmena-oneconsumer-dna-apac-qa.crm_market_summary_parallel_run.counter_to_channel` cc
                ON o.counter_code = concat(cc.market_id,cc.counter_id)
				where c.is_consumer_flag='Y'
				and c.division='LLD'
				and ((o.PROD_TYPE='YFG' and o.market_code='HK') or o.net_sales_in_local_curr <>0)
				AND FORMAT_TIMESTAMP("%Y%m%d",o.order_date) BETWEEN FROMDATE_LY AND TODATE_LY
				and (o.order_type in ('Normal Sales','Sales Return') or o.market_code='KR') 
				group by o.market_code,c.signature_code,c.consumer_type,lucid, c.gender,cc.channel_mode
				having tot<>0
		)
			group by market_code,signature_code, consumer_type , gender, channel_mode
			--having market_code='KR'
        )
		---------------------------------------
        where  market_code = dc_ot.market_code
		and signature_code = dc_ot.signature_code
		and consumer_type = dc_ot.consumer_type
        and gender = dc_ot.gender
		and channel_mode = cc_ot.channel_mode
	)as act_cus_sales_ly,


(--New Customer Current Year
    select new_cus from
    (
	------------------------------------------------------------
	select market_code,signature_code,consumer_type,gender,channel_mode,count(lucid) as new_cus from 
		(
		select distinct market_code,signature_code,lucid,consumer_type,gender,channel_mode from
            (
			SELECT o.market_code,
			c.signature_code,
			c.consumer_type,
			c.gender,
			cc.channel_mode,
			lucid,
			sum(o.net_sales_in_local_curr) as tot, 
			min(o.order_date) as min_order_date
			
			from `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o
				inner join `apmena-oneconsumer-dna-apac-qa.space_crm_1_2.dim_consumer_napac` c 
				on c.consumer_code=o.consumer_code
				left join `apmena-oneconsumer-dna-apac-qa.crm_market_summary_parallel_run.counter_to_channel` cc
                ON o.counter_code = concat(cc.market_id,cc.counter_id)		
			

			where (c.is_consumer_flag='Y' or c.is_consumer_flag is null or lower(ltrim(rtrim(c.is_consumer_flag)))='null')
                --and c.division='LLD'
			and ((o.net_sales_in_local_curr >0) or
				(o.PROD_TYPE='YFG' 
				and o.market_code='HK' 
				and o.net_sales_in_local_curr >0))
				and (o.order_type in ('Normal Sales','Sales Return') or o.market_code='KR')
			group by o.market_code,c.signature_code,c.consumer_type,lucid , c.gender,cc.channel_mode
            --having tot>0 
			having FORMAT_TIMESTAMP("%Y%m%d",min_order_date) BETWEEN R36_FROM AND R36_TO
			)
            where FORMAT_TIMESTAMP("%Y%m%d",min_order_date) BETWEEN FROMDATE_CY AND TODATE_CY
			group by market_code,signature_code,consumer_type,lucid, gender,channel_mode
			
		) group by signature_code,market_code,consumer_type, gender,channel_mode
	------------------------------------------------------------

	) where  market_code = dc_ot.market_code
		and signature_code = dc_ot.signature_code
		and consumer_type = dc_ot.consumer_type
		and gender = dc_ot.gender
		and channel_mode = cc_ot.channel_mode
)as new_cus_cy,

(--New Customer Last Year
    select new_cus from
    (
	------------------------------------------------------------
	select market_code,signature_code,consumer_type,gender,channel_mode,count(lucid) as new_cus from 
		(
		select distinct market_code,signature_code,lucid,consumer_type,gender,channel_mode from
            (
			SELECT o.market_code,
			c.signature_code,
			c.consumer_type,
			c.gender,
			cc.channel_mode,
			lucid,
			sum(o.net_sales_in_local_curr) as tot, 
			min(o.order_date) as min_order_date
			
			from `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o
				inner join `apmena-oneconsumer-dna-apac-qa.space_crm_1_2.dim_consumer_napac` c 
				on c.consumer_code=o.consumer_code
				left join `apmena-oneconsumer-dna-apac-qa.crm_market_summary_parallel_run.counter_to_channel` cc
                ON o.counter_code = concat(cc.market_id,cc.counter_id)		
			

			where (c.is_consumer_flag='Y' or c.is_consumer_flag is null or lower(ltrim(rtrim(c.is_consumer_flag)))='null')
                --and c.division='LLD'
			and ((o.net_sales_in_local_curr >0) or
				(o.PROD_TYPE='YFG' 
				and o.market_code='HK' 
				and o.net_sales_in_local_curr >0))
				and (o.order_type in ('Normal Sales','Sales Return') or o.market_code='KR')
			group by o.market_code,c.signature_code,c.consumer_type,lucid , c.gender,cc.channel_mode
            --having tot>0 
			having FORMAT_TIMESTAMP("%Y%m%d",min_order_date) BETWEEN R36_FROM_LY AND R36_TO_LY
			)
            where FORMAT_TIMESTAMP("%Y%m%d",min_order_date) BETWEEN FROMDATE_LY AND TODATE_LY
			group by market_code,signature_code,consumer_type,lucid, gender,channel_mode
			
		) group by signature_code,market_code,consumer_type, gender,channel_mode
	------------------------------------------------------------

	) where  market_code = dc_ot.market_code
		and signature_code = dc_ot.signature_code
		and consumer_type = dc_ot.consumer_type
		and gender = dc_ot.gender
		and channel_mode = cc_ot.channel_mode
)as new_cus_ly,


	
(--New Customer_toBrand Current Year
    select new_cus from
    (
	------------------------------------------------------------
	select market_code,signature_code,consumer_type,gender,/*channel_mode,*/count(lucid) as new_cus from 
		(
		select distinct market_code,signature_code,lucid,consumer_type,gender--,channel_mode
		from
            (
			SELECT o.market_code,
			c.signature_code,
			c.consumer_type,
			c.gender,
			--cc.channel_mode,
			lucid,
			sum(o.net_sales_in_local_curr) as tot, 
			min(o.order_date) as min_order_date
			
			from `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o
				inner join `apmena-oneconsumer-dna-apac-qa.space_crm_1_2.dim_consumer_napac` c 
				on c.consumer_code=o.consumer_code
				left join `apmena-oneconsumer-dna-apac-qa.crm_market_summary_parallel_run.counter_to_channel` cc
                ON o.counter_code = concat(cc.market_id,cc.counter_id)		
			

			where (c.is_consumer_flag='Y' or c.is_consumer_flag is null or lower(ltrim(rtrim(c.is_consumer_flag)))='null')
                --and c.division='LLD'
			and ((o.net_sales_in_local_curr >0) or
				(o.PROD_TYPE='YFG' 
				and o.market_code='HK' 
				and o.net_sales_in_local_curr >0))
				and (o.order_type in ('Normal Sales','Sales Return') or o.market_code='KR')
			group by o.market_code,c.signature_code,c.consumer_type,lucid , c.gender--,cc.channel_mode
            --having tot>0 
			having FORMAT_TIMESTAMP("%Y%m%d",min_order_date) BETWEEN R36_FROM AND R36_TO
			)
            where FORMAT_TIMESTAMP("%Y%m%d",min_order_date) BETWEEN FROMDATE_CY AND TODATE_CY
			group by market_code,signature_code,consumer_type,lucid, gender--,channel_mode
			
		) group by signature_code,market_code,consumer_type, gender--,channel_mode
	------------------------------------------------------------

	) where  market_code = dc_ot.market_code
		and signature_code = dc_ot.signature_code
		and consumer_type = dc_ot.consumer_type
		and gender = dc_ot.gender
		--and channel_mode = cc_ot.channel_mode
)as new_cus_brand_cy,

(--New Customer_toBrand Last Year
    select new_cus from
    (
	------------------------------------------------------------
	select market_code,signature_code,consumer_type,gender,/*channel_mode,*/count(lucid) as new_cus from 
		(
		select distinct market_code,signature_code,lucid,consumer_type,gender--,channel_mode
		from
            (
			SELECT o.market_code,
			c.signature_code,
			c.consumer_type,
			c.gender,
			--cc.channel_mode,
			lucid,
			sum(o.net_sales_in_local_curr) as tot, 
			min(o.order_date) as min_order_date
			
			from `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o
				inner join `apmena-oneconsumer-dna-apac-qa.space_crm_1_2.dim_consumer_napac` c 
				on c.consumer_code=o.consumer_code
				left join `apmena-oneconsumer-dna-apac-qa.crm_market_summary_parallel_run.counter_to_channel` cc
                ON o.counter_code = concat(cc.market_id,cc.counter_id)		
			

			where (c.is_consumer_flag='Y' or c.is_consumer_flag is null or lower(ltrim(rtrim(c.is_consumer_flag)))='null')
                --and c.division='LLD'
			and ((o.net_sales_in_local_curr >0) or
				(o.PROD_TYPE='YFG' 
				and o.market_code='HK' 
				and o.net_sales_in_local_curr >0))
				and (o.order_type in ('Normal Sales','Sales Return') or o.market_code='KR')
			group by o.market_code,c.signature_code,c.consumer_type,lucid , c.gender--,cc.channel_mode
            --having tot>0 
			having FORMAT_TIMESTAMP("%Y%m%d",min_order_date) BETWEEN R36_FROM_LY AND R36_TO_LY
			)
            where FORMAT_TIMESTAMP("%Y%m%d",min_order_date) BETWEEN FROMDATE_LY AND TODATE_LY
			group by market_code,signature_code,consumer_type,lucid, gender--,channel_mode
			
		) group by signature_code,market_code,consumer_type, gender--,channel_mode
	------------------------------------------------------------

	) where  market_code = dc_ot.market_code
		and signature_code = dc_ot.signature_code
		and consumer_type = dc_ot.consumer_type
		and gender = dc_ot.gender
		--and channel_mode = cc_ot.channel_mode
)as new_cus_brand_ly,




(--new Repeat Customer Current Year
select repeat_cus from
    (
	------------------------------------------------------------------
	
					select  
					signature_code, market_code, consumer_type, gender,channel_mode,
					count (distinct unique_id)  as repeat_cus
					from
					(
					select unique_id, signature_code, market_code, consumer_type, gender,channel_mode,
					from(

					select 
					o.order_date, -- orderdate
					lucid as unique_id,
					o.consumer_code,-- contact Id,
					CONCAT(cast(o.consumer_code as string),'-',DATE(o.order_date),'-',cast(o.counter_code as string)) AS TRANACTION_ID,
					case 
					   when SUM(o.order_quantity * o.net_price)>0 then 1
					   when SUM(o.order_quantity * o.net_price)<0 then -1
					   ELSE 0 
					END AS Transactions,-- calculate trans,
					o.market_code,
					c.consumer_type,
					c.signature_code,
					c.gender,
					cc.channel_mode
					
					from `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o
					inner join `apmena-oneconsumer-dna-apac-qa.space_crm_1_2.dim_consumer_napac` c 
					on c.consumer_code=o.consumer_code
					left join `apmena-oneconsumer-dna-apac-qa.crm_market_summary_parallel_run.counter_to_channel` cc
					ON o.counter_code = concat(cc.market_id,cc.counter_id)
					
					
								where (c.is_consumer_flag='Y' or c.is_consumer_flag is null or lower(ltrim(rtrim(c.is_consumer_flag)))='null')
									and c.division='LLD'
									
								and ((o.net_sales_in_local_curr >0) or
									(o.PROD_TYPE='YFG' 
									and o.market_code='HK' 
									and o.net_sales_in_local_curr >0))
									and (o.order_type in ('Normal Sales','Sales Return') or o.market_code='KR')

						AND FORMAT_TIMESTAMP("%Y%m%d",o.order_date) BETWEEN R36_FROM AND R36_TO
					group by o.order_date,o.consumer_code,o.counter_code,lucid,c.signature_code,o.market_code,
					c.consumer_type, c.gender, cc.channel_mode
					) as customer_trans
					where Transactions=1
					group by unique_id,signature_code, market_code, consumer_type, gender, channel_mode
					having min( FORMAT_TIMESTAMP("%Y%m%d",order_date)) BETWEEN FROMDATE_CY  AND TODATE_CY
					and count(distinct TRANACTION_ID)>1
					) as new_repeat_cust
					group by signature_code,market_code,consumer_type, gender, channel_mode
					
	
	-------------------------------------------------------------------
	)
	where  market_code = dc_ot.market_code
		and signature_code = dc_ot.signature_code
		and consumer_type = dc_ot.consumer_type
		and gender = dc_ot.gender
		and channel_mode = cc_ot.channel_mode
)as new_repeatcus_cy,
	
	
(--new Repeat Customer last Year
select repeat_cus from
    (
	------------------------------------------------------------------
	
					select  
					signature_code, market_code, consumer_type, gender,channel_mode,
					count (distinct unique_id)  as repeat_cus
					from
					(
					select unique_id, signature_code, market_code, consumer_type, gender,channel_mode,
					from(

					select 
					o.order_date, -- orderdate
					lucid as unique_id,
					o.consumer_code,-- contact Id,
					CONCAT(cast(o.consumer_code as string),'-',DATE(o.order_date),'-',cast(o.counter_code as string)) AS TRANACTION_ID,
					case 
					   when SUM(o.order_quantity * o.net_price)>0 then 1
					   when SUM(o.order_quantity * o.net_price)<0 then -1
					   ELSE 0 
					END AS Transactions,-- calculate trans,
					o.market_code,
					c.consumer_type,
					c.signature_code,
					c.gender,
					cc.channel_mode
					
					from `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o
					inner join `apmena-oneconsumer-dna-apac-qa.space_crm_1_2.dim_consumer_napac` c 
					on c.consumer_code=o.consumer_code
					left join `apmena-oneconsumer-dna-apac-qa.crm_market_summary_parallel_run.counter_to_channel` cc
					ON o.counter_code = concat(cc.market_id,cc.counter_id)
					
					
								where (c.is_consumer_flag='Y' or c.is_consumer_flag is null or lower(ltrim(rtrim(c.is_consumer_flag)))='null')
									and c.division='LLD'
									
								and ((o.net_sales_in_local_curr >0) or
									(o.PROD_TYPE='YFG' 
									and o.market_code='HK' 
									and o.net_sales_in_local_curr >0))
									and (o.order_type in ('Normal Sales','Sales Return') or o.market_code='KR')

						AND FORMAT_TIMESTAMP("%Y%m%d",o.order_date) BETWEEN R36_FROM_LY AND R36_TO_LY
					group by o.order_date,o.consumer_code,o.counter_code,lucid,c.signature_code,o.market_code,
					c.consumer_type, c.gender, cc.channel_mode
					) as customer_trans
					where Transactions=1
					group by unique_id,signature_code, market_code, consumer_type, gender, channel_mode
					having min( FORMAT_TIMESTAMP("%Y%m%d",order_date)) BETWEEN FROMDATE_LY  AND TODATE_LY
					and count(distinct TRANACTION_ID)>1
					) as new_repeat_cust
					group by signature_code,market_code,consumer_type, gender, channel_mode
					
	
	-------------------------------------------------------------------
	)
	where  market_code = dc_ot.market_code
		and signature_code = dc_ot.signature_code
		and consumer_type = dc_ot.consumer_type
		and gender = dc_ot.gender
		and channel_mode = cc_ot.channel_mode
)as new_repeatcus_ly,


(--Retained Customer Current Period
select retained_cust
from(
    -------------------------------------------------
	
       select signature_code,market_code,consumer_type,gender,channel_mode,
		count(distinct UNIQUE_ID) AS retained_cust
		from
		(
			select lucid as UNIQUE_ID,o.market_code,c.signature_code,c.consumer_type,
			c.gender,cc.channel_mode
			
			from `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o
			inner join `apmena-oneconsumer-dna-apac-qa.space_crm_1_2.dim_consumer_napac` c 
			on c.consumer_code=o.consumer_code
			left join `apmena-oneconsumer-dna-apac-qa.crm_market_summary_parallel_run.counter_to_channel` cc
               ON o.counter_code = concat(cc.market_id,cc.counter_id)
			
			where (c.is_consumer_flag='Y' or c.is_consumer_flag is null or lower(ltrim(rtrim(c.is_consumer_flag)))='null')
			
			and (
			select sum(o_itr1.net_sales_in_local_curr)  
			 FROM  
			 `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o_itr1
			where  
				 ((o_itr1.net_sales_in_local_curr >0) or
				(o_itr1.PROD_TYPE='YFG' 
				and o_itr1.market_code='HK' 
				and o_itr1.net_sales_in_local_curr >0))
				and (o_itr1.order_type in ('Normal Sales','Sales Return') or o_itr1.market_code='KR') -- to exclude redemption
				
				and FORMAT_TIMESTAMP("%Y%m%d",o_itr1.order_date) BETWEEN FROMDATE_CY AND TODATE_CY
				and  c.consumer_code=o_itr1.consumer_code
				)>0 
			
				and (
			select sum(o_itr2.net_sales_in_local_curr)  
			 FROM  
			 `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o_itr2
			where  
				 ((o_itr2.net_sales_in_local_curr >0) or
				(o_itr2.PROD_TYPE='YFG' 
				and o_itr2.market_code='HK' 
				and o_itr2.net_sales_in_local_curr >0))
				and (o_itr2.order_type in ('Normal Sales','Sales Return') or o_itr2.market_code='KR') -- to exclude redemption
				
				and FORMAT_TIMESTAMP("%Y%m%d",o_itr2.order_date) BETWEEN R1324_FROMDATE_CY AND R1324_TODATE_CY
				and  c.consumer_code=o_itr2.consumer_code
				)>0 
		) as retain_customer_to_market
		group by signature_code,market_code,consumer_type,gender,channel_mode
   
    -------------------------------------------------
   
    )where  market_code = dc_ot.market_code
		and signature_code = dc_ot.signature_code
		and consumer_type = dc_ot.consumer_type
		and gender = dc_ot.gender
		and channel_mode = cc_ot.channel_mode
)as retained_cy,


(--Retained Customer Last Period
select retained_cust
from(
    -------------------------------------------------
	
       select signature_code,market_code,consumer_type,gender,channel_mode,
		count(distinct UNIQUE_ID) AS retained_cust
		from
		(
			select lucid as UNIQUE_ID,o.market_code,c.signature_code,c.consumer_type,
			c.gender,cc.channel_mode
			
			from `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o
			inner join `apmena-oneconsumer-dna-apac-qa.space_crm_1_2.dim_consumer_napac` c 
			on c.consumer_code=o.consumer_code
			left join `apmena-oneconsumer-dna-apac-qa.crm_market_summary_parallel_run.counter_to_channel` cc
               ON o.counter_code = concat(cc.market_id,cc.counter_id)
			
			where (c.is_consumer_flag='Y' or c.is_consumer_flag is null or lower(ltrim(rtrim(c.is_consumer_flag)))='null')
			
			and (
			select sum(o_itr1.net_sales_in_local_curr)  
			 FROM  
			 `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o_itr1
			where  
				 ((o_itr1.net_sales_in_local_curr >0) or
				(o_itr1.PROD_TYPE='YFG' 
				and o_itr1.market_code='HK' 
				and o_itr1.net_sales_in_local_curr >0))
				and (o_itr1.order_type in ('Normal Sales','Sales Return') or o_itr1.market_code='KR') -- to exclude redemption
				
				and FORMAT_TIMESTAMP("%Y%m%d",o_itr1.order_date) BETWEEN FROMDATE_LY AND TODATE_LY
				and  c.consumer_code=o_itr1.consumer_code
				)>0 
			
				and (
			select sum(o_itr2.net_sales_in_local_curr)  
			 FROM  
			 `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o_itr2
			where  
				 ((o_itr2.net_sales_in_local_curr >0) or
				(o_itr2.PROD_TYPE='YFG' 
				and o_itr2.market_code='HK' 
				and o_itr2.net_sales_in_local_curr >0))
				and (o_itr2.order_type in ('Normal Sales','Sales Return') or o_itr2.market_code='KR') -- to exclude redemption
				
				and FORMAT_TIMESTAMP("%Y%m%d",o_itr2.order_date) BETWEEN R1324_FROMDATE_LY AND R1324_TODATE_LY
				and  c.consumer_code=o_itr2.consumer_code
				)>0 
		) as retain_customer_to_market
		group by signature_code,market_code,consumer_type,gender,channel_mode
   
    -------------------------------------------------
   
    )where  market_code = dc_ot.market_code
		and signature_code = dc_ot.signature_code
		and consumer_type = dc_ot.consumer_type
		and gender = dc_ot.gender
		and channel_mode = cc_ot.channel_mode
)as retained_ly,


(-- net sales current year
	select net_sales from
	(
		SELECT o.market_code,c.signature_code,c.consumer_type,
		c.gender,cc.channel_mode,
		sum(o.net_sales_in_local_curr) as net_sales
		
		from `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o
		inner join `apmena-oneconsumer-dna-apac-qa.space_crm_1_2.dim_consumer_napac` c 
		on c.consumer_code=o.consumer_code
		left join `apmena-oneconsumer-dna-apac-qa.crm_market_summary_parallel_run.counter_to_channel` cc
		ON o.counter_code = concat(cc.market_id,cc.counter_id)
		
		where c.is_consumer_flag='Y'
		and c.division='LLD' and ((o.PROD_TYPE='YFG' and o.market_code='HK') or o.net_sales_in_local_curr <>0)
		and (o.order_type in ('Normal Sales','Sales Return') or o.market_code='KR')
		and FORMAT_TIMESTAMP("%Y%m%d",o.order_date) BETWEEN FROMDATE_CY AND TODATE_CY
		group by o.market_code,c.signature_code,c.consumer_type, c.gender,cc.channel_mode
		having net_sales>0
	)
	where  market_code = dc_ot.market_code
	and signature_code = dc_ot.signature_code
	and consumer_type = dc_ot.consumer_type
	and gender = dc_ot.gender
	and channel_mode = cc_ot.channel_mode
) as net_sale_aus_cy,


(-- net sales last year
	select net_sales from
	(
		SELECT o.market_code,c.signature_code,c.consumer_type,
		c.gender,cc.channel_mode,
		sum(o.net_sales_in_local_curr) as net_sales
		
		from `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o
		inner join `apmena-oneconsumer-dna-apac-qa.space_crm_1_2.dim_consumer_napac` c 
		on c.consumer_code=o.consumer_code
		left join `apmena-oneconsumer-dna-apac-qa.crm_market_summary_parallel_run.counter_to_channel` cc
		ON o.counter_code = concat(cc.market_id,cc.counter_id)
		
		where c.is_consumer_flag='Y'
		and c.division='LLD' and ((o.PROD_TYPE='YFG' and o.market_code='HK') or o.net_sales_in_local_curr <>0)
		and (o.order_type in ('Normal Sales','Sales Return') or o.market_code='KR')
		and FORMAT_TIMESTAMP("%Y%m%d",o.order_date) BETWEEN FROMDATE_LY AND TODATE_LY
		group by o.market_code,c.signature_code,c.consumer_type, c.gender,cc.channel_mode
		having net_sales>0
	)
	where  market_code = dc_ot.market_code
	and signature_code = dc_ot.signature_code
	and consumer_type = dc_ot.consumer_type
	and gender = dc_ot.gender
	and channel_mode = cc_ot.channel_mode
) as net_sale_aus_ly,


	
(---transactions aus current year
select active_trans from
    (

	select market_code, signature_code,consumer_type, gender,channel_mode,
    sum(Transactions) as active_trans
    from
        ( 
            SELECT
                c.market_code AS market_code,c.signature_code,
                o.order_date,o.consumer_code,o.counter_code, c.consumer_type,
				c.gender,cc.channel_mode,
                case 
                when SUM(o.order_quantity * o.net_price)>0 then 1
                when SUM(o.order_quantity * o.net_price)<0 then -1
                ELSE 0 
                END
                AS Transactions
				
				from `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o
				inner join `apmena-oneconsumer-dna-apac-qa.space_crm_1_2.dim_consumer_napac` c 
				on c.consumer_code=o.consumer_code
				left join `apmena-oneconsumer-dna-apac-qa.crm_market_summary_parallel_run.counter_to_channel` cc
				ON o.counter_code = concat(cc.market_id,cc.counter_id)
			
					
                where c.is_consumer_flag='Y'
                and ((o.net_sales_in_local_curr >0) or (o.PROD_TYPE='YFG' and o.market_code='HK' and o.net_sales_in_local_curr >0))
                and (o.order_type in ('Normal Sales','Sales Return') or o.market_code='KR')         
                AND FORMAT_TIMESTAMP("%Y%m%d",o.order_date) BETWEEN  FROMDATE_CY AND TODATE_CY
                group by c.market_code,c.signature_code ,c.consumer_type,
				o.order_date,o.consumer_code,o.counter_code,c.gender,cc.channel_mode
    )
    group by signature_code,market_code ,consumer_type, gender,channel_mode
	
	)
        where  market_code = dc_ot.market_code
		and signature_code = dc_ot.signature_code
		and consumer_type = dc_ot.consumer_type
		and gender = dc_ot.gender
		and channel_mode = cc_ot.channel_mode
)as transaction_aus_cy,
	
	
(---transactions aus last year
select active_trans from
    (

	select market_code, signature_code,consumer_type, gender,channel_mode,
    sum(Transactions) as active_trans
    from
        ( 
            SELECT
                c.market_code AS market_code,c.signature_code,
                o.order_date,o.consumer_code,o.counter_code, c.consumer_type,
				c.gender,cc.channel_mode,
                case 
                when SUM(o.order_quantity * o.net_price)>0 then 1
                when SUM(o.order_quantity * o.net_price)<0 then -1
                ELSE 0 
                END
                AS Transactions
				
				from `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o
				inner join `apmena-oneconsumer-dna-apac-qa.space_crm_1_2.dim_consumer_napac` c 
				on c.consumer_code=o.consumer_code
				left join `apmena-oneconsumer-dna-apac-qa.crm_market_summary_parallel_run.counter_to_channel` cc
				ON o.counter_code = concat(cc.market_id,cc.counter_id)
			
					
                where c.is_consumer_flag='Y'
                and ((o.net_sales_in_local_curr >0) or (o.PROD_TYPE='YFG' and o.market_code='HK' and o.net_sales_in_local_curr >0))
                and (o.order_type in ('Normal Sales','Sales Return') or o.market_code='KR')         
                AND FORMAT_TIMESTAMP("%Y%m%d",o.order_date) BETWEEN  FROMDATE_CY AND TODATE_CY
                group by c.market_code,c.signature_code ,c.consumer_type,
				o.order_date,o.consumer_code,o.counter_code,c.gender,cc.channel_mode
    )
    group by signature_code,market_code ,consumer_type, gender,channel_mode
	
	)
        where  market_code = dc_ot.market_code
		and signature_code = dc_ot.signature_code
		and consumer_type = dc_ot.consumer_type
		and gender = dc_ot.gender
		and channel_mode = cc_ot.channel_mode
)as transaction_aus_ly,



(--Active contactable Current Year
	select active_contactable from
		(
		select 
		market_code,
		signature_code,
		consumer_type,
		gender,
		channel_mode,
        COUNT(DISTINCT lucid) as active_contactable
		--sum(tot) as active_cust_sales 
        from
		(
				SELECT o.market_code, c.signature_code,c.consumer_type,
				lucid,c.gender,cc.channel_mode,
				sum(o.net_sales_in_local_curr) as tot
				
				from `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o
				inner join `apmena-oneconsumer-dna-apac-qa.space_crm_1_2.dim_consumer_napac` c 
				on c.consumer_code=o.consumer_code
				left join `apmena-oneconsumer-dna-apac-qa.crm_market_summary_parallel_run.counter_to_channel` cc
                ON o.counter_code = concat(cc.market_id,cc.counter_id)
				
				where --c.is_consumer_flag='Y'
				(c.is_consumer_flag='Y' or c.is_consumer_flag is null  or lower(ltrim(rtrim(c.is_consumer_flag)))='null')
				and c.division='LLD'
				and ((o.PROD_TYPE='YFG' and o.market_code='HK') or o.net_sales_in_local_curr <>0)
				AND FORMAT_TIMESTAMP("%Y%m%d",o.order_date) BETWEEN FROMDATE_CY AND TODATE_CY
				and (o.order_type in ('Normal Sales','Sales Return') or o.market_code='KR') 
				
                 
                and ((C.is_valid_email ='Y' and C.is_opt_in_email='Y' )  or
				 (C.is_valid_home_phone='Y' and C.is_Opt_In_home_Phone='Y') or --check
				 (C.is_Valid_mobile='Y' and C.is_opt_in_call= 'Y') or 
				 (C.is_valid_mobile='Y' and C.is_Opt_In_SMS='N') or
				 (C.is_valid_direct_message='Y' and C.is_Opt_In_direct_message='Y') or
				 (C.is_Valid_Line='Y' and C.is_Opt_In_Line='Y') or
				 (C.is_whatsapp_contactable='Y')
				)
				group by o.market_code,c.signature_code,c.consumer_type,lucid, c.gender,cc.channel_mode
				having tot>0
		)
			group by market_code,signature_code, consumer_type , gender, channel_mode
			
        )
		---------------------------------------
        where  market_code = dc_ot.market_code
		and signature_code = dc_ot.signature_code
		and consumer_type = dc_ot.consumer_type
        and gender = dc_ot.gender
		and channel_mode = cc_ot.channel_mode
	)as act_cus_contactable_cy,
	
	
(--Active contactable Last Year
	select active_contactable from
		(
		select 
		market_code,
		signature_code,
		consumer_type,
		gender,
		channel_mode,
        COUNT(DISTINCT lucid) as active_contactable
		--sum(tot) as active_cust_sales 
        from
		(
				SELECT o.market_code, c.signature_code,c.consumer_type,
				lucid,c.gender,cc.channel_mode,
				sum(o.net_sales_in_local_curr) as tot
				
				from `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o
				inner join `apmena-oneconsumer-dna-apac-qa.space_crm_1_2.dim_consumer_napac` c 
				on c.consumer_code=o.consumer_code
				left join `apmena-oneconsumer-dna-apac-qa.crm_market_summary_parallel_run.counter_to_channel` cc
                ON o.counter_code = concat(cc.market_id,cc.counter_id)
				
				where --c.is_consumer_flag='Y'
				(c.is_consumer_flag='Y' or c.is_consumer_flag is null  or lower(ltrim(rtrim(c.is_consumer_flag)))='null')
				and c.division='LLD'
				and ((o.PROD_TYPE='YFG' and o.market_code='HK') or o.net_sales_in_local_curr <>0)
				AND FORMAT_TIMESTAMP("%Y%m%d",o.order_date) BETWEEN  FROMDATE_LY AND TODATE_LY
				and (o.order_type in ('Normal Sales','Sales Return') or o.market_code='KR') 
				
                 
                and ((C.is_valid_email ='Y' and C.is_opt_in_email='Y' )  or
				 (C.is_valid_home_phone='Y' and C.is_Opt_In_home_Phone='Y') or --check
				 (C.is_Valid_mobile='Y' and C.is_opt_in_call= 'Y') or 
				 (C.is_valid_mobile='Y' and C.is_Opt_In_SMS='N') or
				 (C.is_valid_direct_message='Y' and C.is_Opt_In_direct_message='Y') or
				 (C.is_Valid_Line='Y' and C.is_Opt_In_Line='Y') or
				 (C.is_whatsapp_contactable='Y')
				)
				group by o.market_code,c.signature_code,c.consumer_type,lucid, c.gender,cc.channel_mode
				having tot>0
		)
			group by market_code,signature_code, consumer_type , gender, channel_mode
			
        )
		---------------------------------------
        where  market_code = dc_ot.market_code
		and signature_code = dc_ot.signature_code
		and consumer_type = dc_ot.consumer_type
        and gender = dc_ot.gender
		and channel_mode = cc_ot.channel_mode
	)as act_cus_contactable_ly,


	
(--Active contactable sales Current Year
	select active_contactable_sales from
		(
		select 
		market_code, signature_code,consumer_type,gender,channel_mode,
        --COUNT(DISTINCT lucid) as active_contactable_sales
		cast(sum(tot) as bignumeric) as active_contactable_sales 
        from
		(
				SELECT o.market_code, c.signature_code,c.consumer_type,
				lucid,c.gender,cc.channel_mode,
				sum(o.net_sales_in_local_curr) as tot
				
				from `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o
				inner join `apmena-oneconsumer-dna-apac-qa.space_crm_1_2.dim_consumer_napac` c 
				on c.consumer_code=o.consumer_code
				left join `apmena-oneconsumer-dna-apac-qa.crm_market_summary_parallel_run.counter_to_channel` cc
                ON o.counter_code = concat(cc.market_id,cc.counter_id)
				
				where --c.is_consumer_flag='Y'
				(c.is_consumer_flag='Y' or c.is_consumer_flag is null  or lower(ltrim(rtrim(c.is_consumer_flag)))='null')
				and c.division='LLD'
				and ((o.PROD_TYPE='YFG' and o.market_code='HK') or o.net_sales_in_local_curr <>0)
				AND FORMAT_TIMESTAMP("%Y%m%d",o.order_date) BETWEEN FROMDATE_CY AND TODATE_CY
				and (o.order_type in ('Normal Sales','Sales Return') or o.market_code='KR') 
				
                 
                and ((C.is_valid_email ='Y' and C.is_opt_in_email='Y' )  or
				 (C.is_valid_home_phone='Y' and C.is_Opt_In_home_Phone='Y') or --check
				 (C.is_Valid_mobile='Y' and C.is_opt_in_call= 'Y') or 
				 (C.is_valid_mobile='Y' and C.is_Opt_In_SMS='N') or
				 (C.is_valid_direct_message='Y' and C.is_Opt_In_direct_message='Y') or
				 (C.is_Valid_Line='Y' and C.is_Opt_In_Line='Y') or
				 (C.is_whatsapp_contactable='Y')
				)
				group by o.market_code,c.signature_code,c.consumer_type,lucid, c.gender,cc.channel_mode
				having tot>0
		)
			group by market_code,signature_code, consumer_type , gender, channel_mode
			
        )
		---------------------------------------
        where  market_code = dc_ot.market_code
		and signature_code = dc_ot.signature_code
		and consumer_type = dc_ot.consumer_type
        and gender = dc_ot.gender
		and channel_mode = cc_ot.channel_mode
)as active_contactable_sales_cy,
	

(--Active contactable sales Last Year
	select active_contactable_sales from
		(
		select 
		market_code, signature_code,consumer_type,gender,channel_mode,
        --COUNT(DISTINCT lucid) as active_contactable_sales
		cast(sum(tot) as bignumeric) as active_contactable_sales 
        from
		(
				SELECT o.market_code, c.signature_code,c.consumer_type,
				lucid,c.gender,cc.channel_mode,
				sum(o.net_sales_in_local_curr) as tot
				
				from `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o
				inner join `apmena-oneconsumer-dna-apac-qa.space_crm_1_2.dim_consumer_napac` c 
				on c.consumer_code=o.consumer_code
				left join `apmena-oneconsumer-dna-apac-qa.crm_market_summary_parallel_run.counter_to_channel` cc
                ON o.counter_code = concat(cc.market_id,cc.counter_id)
				
				where --c.is_consumer_flag='Y'
				(c.is_consumer_flag='Y' or c.is_consumer_flag is null  or lower(ltrim(rtrim(c.is_consumer_flag)))='null')
				and c.division='LLD'
				and ((o.PROD_TYPE='YFG' and o.market_code='HK') or o.net_sales_in_local_curr <>0)
				AND FORMAT_TIMESTAMP("%Y%m%d",o.order_date) BETWEEN FROMDATE_LY AND TODATE_LY
				and (o.order_type in ('Normal Sales','Sales Return') or o.market_code='KR') 
				
                 
                and ((C.is_valid_email ='Y' and C.is_opt_in_email='Y' )  or
				 (C.is_valid_home_phone='Y' and C.is_Opt_In_home_Phone='Y') or --check
				 (C.is_Valid_mobile='Y' and C.is_opt_in_call= 'Y') or 
				 (C.is_valid_mobile='Y' and C.is_Opt_In_SMS='N') or
				 (C.is_valid_direct_message='Y' and C.is_Opt_In_direct_message='Y') or
				 (C.is_Valid_Line='Y' and C.is_Opt_In_Line='Y') or
				 (C.is_whatsapp_contactable='Y')
				)
				group by o.market_code,c.signature_code,c.consumer_type,lucid, c.gender,cc.channel_mode
				having tot>0
		)
			group by market_code,signature_code, consumer_type , gender, channel_mode
			
        )
		---------------------------------------
        where  market_code = dc_ot.market_code
		and signature_code = dc_ot.signature_code
		and consumer_type = dc_ot.consumer_type
        and gender = dc_ot.gender
		and channel_mode = cc_ot.channel_mode
)as active_contactable_sales_ly,

	
(--Active Sales Transaction Current Year
	select active_trans from
		(
		select 
		market_code,
		signature_code,
		consumer_type,
		gender,
		channel_mode,
		sum(Transactions) as active_trans
		from
		(
				SELECT o.market_code, c.signature_code,c.consumer_type,lucid,c.gender,cc.channel_mode,
				case 
                when SUM(o.order_quantity * o.net_price)>0 then 1
                when SUM(o.order_quantity * o.net_price)<0 then -1
                ELSE 0 
                END
                AS Transactions,
				sum(o.net_sales_in_local_curr) as tot
				
				from `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o
				inner join `apmena-oneconsumer-dna-apac-qa.space_crm_1_2.dim_consumer_napac` c 
				on c.consumer_code=o.consumer_code
				left join `apmena-oneconsumer-dna-apac-qa.crm_market_summary_parallel_run.counter_to_channel` cc
                ON o.counter_code = concat(cc.market_id,cc.counter_id)
				
				where c.is_consumer_flag='Y'
				and c.division='LLD'
				and ((o.PROD_TYPE='YFG' and o.market_code='HK') or o.net_sales_in_local_curr <>0)
				AND FORMAT_TIMESTAMP("%Y%m%d",o.order_date) BETWEEN FROMDATE_CY AND TODATE_CY
				and (o.order_type in ('Normal Sales','Sales Return') or o.market_code='KR') 
				group by o.market_code,c.signature_code,c.consumer_type,lucid, c.gender,cc.channel_mode
				having tot<>0
		)
			group by market_code,signature_code, consumer_type , gender, channel_mode
        )
		---------------------------------------
        where  market_code = dc_ot.market_code
		and signature_code = dc_ot.signature_code
		and consumer_type = dc_ot.consumer_type
        and gender = dc_ot.gender
		and channel_mode = cc_ot.channel_mode
	)as act_cus_trans_cy,


(--Active Sales Transaction Last Year
	select active_trans from
		(
		select 
		market_code,
		signature_code,
		consumer_type,
		gender,
		channel_mode,
		sum(Transactions) as active_trans
		from
		(
				SELECT o.market_code, c.signature_code,c.consumer_type,lucid,c.gender,cc.channel_mode,
				case 
                when SUM(o.order_quantity * o.net_price)>0 then 1
                when SUM(o.order_quantity * o.net_price)<0 then -1
                ELSE 0 
                END
                AS Transactions,
				sum(o.net_sales_in_local_curr) as tot
				
				from `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o
				inner join `apmena-oneconsumer-dna-apac-qa.space_crm_1_2.dim_consumer_napac` c 
				on c.consumer_code=o.consumer_code
				left join `apmena-oneconsumer-dna-apac-qa.crm_market_summary_parallel_run.counter_to_channel` cc
                ON o.counter_code = concat(cc.market_id,cc.counter_id)
				
				where c.is_consumer_flag='Y'
				and c.division='LLD'
				and ((o.PROD_TYPE='YFG' and o.market_code='HK') or o.net_sales_in_local_curr <>0)
				AND FORMAT_TIMESTAMP("%Y%m%d",o.order_date) BETWEEN FROMDATE_LY AND TODATE_LY
				and (o.order_type in ('Normal Sales','Sales Return') or o.market_code='KR') 
				group by o.market_code,c.signature_code,c.consumer_type,lucid, c.gender,cc.channel_mode
				having tot<>0
		)
			group by market_code,signature_code, consumer_type , gender, channel_mode
        )
		---------------------------------------
        where  market_code = dc_ot.market_code
		and signature_code = dc_ot.signature_code
		and consumer_type = dc_ot.consumer_type
        and gender = dc_ot.gender
		and channel_mode = cc_ot.channel_mode
	)as act_cus_trans_ly,


	
(--New Customer Units Current Year
    select new_cus_units from
    (
	------------------------------------------------------------
	select market_code,signature_code,consumer_type,gender,channel_mode,sum(units) as new_cus_units from 
		(
		select distinct market_code,signature_code,lucid,units ,consumer_type,gender,channel_mode from
            (
			SELECT o.market_code,
			c.signature_code,
			c.consumer_type,
			c.gender,
			cc.channel_mode,
			lucid,
			--sum(o.net_sales_in_local_curr) as tot, 
			min(o.order_date) as min_order_date,
            o.order_quantity as units
			
			from `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o
				inner join `apmena-oneconsumer-dna-apac-qa.space_crm_1_2.dim_consumer_napac` c 
				on c.consumer_code=o.consumer_code
				left join `apmena-oneconsumer-dna-apac-qa.crm_market_summary_parallel_run.counter_to_channel` cc
                ON o.counter_code = concat(cc.market_id,cc.counter_id)		
			

			where (c.is_consumer_flag='Y' or c.is_consumer_flag is null or lower(ltrim(rtrim(c.is_consumer_flag)))='null')
                --and c.division='LLD'
			and ((o.net_sales_in_local_curr >0) or
				(o.PROD_TYPE='YFG' 
				and o.market_code='HK' 
				and o.net_sales_in_local_curr >0))
				and (o.order_type in ('Normal Sales','Sales Return') or o.market_code='KR')
			group by o.market_code,c.signature_code,c.consumer_type,lucid , 
            c.gender, cc.channel_mode,o.order_quantity
            having FORMAT_TIMESTAMP("%Y%m%d",min_order_date) BETWEEN R36_FROM AND R36_TO
            and o.order_quantity > 0
			)
            where FORMAT_TIMESTAMP("%Y%m%d",min_order_date) BETWEEN FROMDATE_CY AND TODATE_CY
			group by market_code,signature_code,consumer_type,lucid,units, gender,channel_mode
			
		) group by signature_code,market_code,consumer_type, gender,channel_mode
	------------------------------------------------------------

	) where  market_code = dc_ot.market_code
		and signature_code = dc_ot.signature_code
		and consumer_type = dc_ot.consumer_type
		and gender = dc_ot.gender
		and channel_mode = cc_ot.channel_mode
)as new_cus_units_cy,


(--New Customer Units Last Year
    select new_cus_units from
    (
	------------------------------------------------------------
	select market_code,signature_code,consumer_type,gender,channel_mode,sum(units) as new_cus_units from 
		(
		select distinct market_code,signature_code,lucid,units ,consumer_type,gender,channel_mode from
            (
			SELECT o.market_code,
			c.signature_code,
			c.consumer_type,
			c.gender,
			cc.channel_mode,
			lucid,
			--sum(o.net_sales_in_local_curr) as tot, 
			min(o.order_date) as min_order_date,
            o.order_quantity as units
			
			from `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o
				inner join `apmena-oneconsumer-dna-apac-qa.space_crm_1_2.dim_consumer_napac` c 
				on c.consumer_code=o.consumer_code
				left join `apmena-oneconsumer-dna-apac-qa.crm_market_summary_parallel_run.counter_to_channel` cc
                ON o.counter_code = concat(cc.market_id,cc.counter_id)		
			

			where (c.is_consumer_flag='Y' or c.is_consumer_flag is null or lower(ltrim(rtrim(c.is_consumer_flag)))='null')
                --and c.division='LLD'
			and ((o.net_sales_in_local_curr >0) or
				(o.PROD_TYPE='YFG' 
				and o.market_code='HK' 
				and o.net_sales_in_local_curr >0))
				and (o.order_type in ('Normal Sales','Sales Return') or o.market_code='KR')
			group by o.market_code,c.signature_code,c.consumer_type,lucid , 
            c.gender, cc.channel_mode,o.order_quantity
            having FORMAT_TIMESTAMP("%Y%m%d",min_order_date) BETWEEN R36_FROM_LY AND R36_TO_LY
            and o.order_quantity > 0
			)
            where FORMAT_TIMESTAMP("%Y%m%d",min_order_date) BETWEEN FROMDATE_LY AND TODATE_LY
			group by market_code,signature_code,consumer_type,lucid,units, gender,channel_mode
			
		) group by signature_code,market_code,consumer_type, gender,channel_mode
	------------------------------------------------------------

	) where  market_code = dc_ot.market_code
		and signature_code = dc_ot.signature_code
		and consumer_type = dc_ot.consumer_type
		and gender = dc_ot.gender
		and channel_mode = cc_ot.channel_mode
)as new_cus_units_ly,

	
(--New Customer Last Year
    select new_cus_trans from
    (
	------------------------------------------------------------
	select market_code,signature_code,consumer_type,gender,channel_mode,sum(Transactions) as new_cus_trans from 
		(
		select distinct market_code,signature_code,lucid,Transactions,consumer_type,gender,channel_mode from
            (
			SELECT o.market_code,
			c.signature_code,
			c.consumer_type,
			c.gender,
			cc.channel_mode,
			lucid,
			case 
                when SUM(o.order_quantity * o.net_price)>0 then 1
                when SUM(o.order_quantity * o.net_price)<0 then -1
                ELSE 0 
            END
            AS Transactions,
			sum(o.net_sales_in_local_curr) as tot, 
			min(o.order_date) as min_order_date
			
			from `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o
				inner join `apmena-oneconsumer-dna-apac-qa.space_crm_1_2.dim_consumer_napac` c 
				on c.consumer_code=o.consumer_code
				left join `apmena-oneconsumer-dna-apac-qa.crm_market_summary_parallel_run.counter_to_channel` cc
                ON o.counter_code = concat(cc.market_id,cc.counter_id)		
			

			where (c.is_consumer_flag='Y' or c.is_consumer_flag is null or lower(ltrim(rtrim(c.is_consumer_flag)))='null')
                --and c.division='LLD'
			and ((o.net_sales_in_local_curr >0) or
				(o.PROD_TYPE='YFG' 
				and o.market_code='HK' 
				and o.net_sales_in_local_curr >0))
				and (o.order_type in ('Normal Sales','Sales Return') or o.market_code='KR')
			group by o.market_code,c.signature_code,c.consumer_type,lucid , c.gender,cc.channel_mode
            --having tot>0 
			having FORMAT_TIMESTAMP("%Y%m%d",min_order_date)  BETWEEN R36_FROM AND R36_TO
			)
            where FORMAT_TIMESTAMP("%Y%m%d",min_order_date) BETWEEN FROMDATE_CY AND TODATE_CY
			group by market_code,signature_code,consumer_type,lucid, gender,channel_mode,Transactions
			
		) group by signature_code,market_code,consumer_type, gender,channel_mode
	------------------------------------------------------------

	) where  market_code = dc_ot.market_code
		and signature_code = dc_ot.signature_code
		and consumer_type = dc_ot.consumer_type
		and gender = dc_ot.gender
		and channel_mode = cc_ot.channel_mode
)as new_cus_trans_cy,

	
(--New Customer Last Year
    select new_cus_trans from
    (
	------------------------------------------------------------
	select market_code,signature_code,consumer_type,gender,channel_mode,sum(Transactions) as new_cus_trans from 
		(
		select distinct market_code,signature_code,lucid,Transactions,consumer_type,gender,channel_mode from
            (
			SELECT o.market_code,
			c.signature_code,
			c.consumer_type,
			c.gender,
			cc.channel_mode,
			lucid,
			case 
                when SUM(o.order_quantity * o.net_price)>0 then 1
                when SUM(o.order_quantity * o.net_price)<0 then -1
                ELSE 0 
            END
            AS Transactions,
			sum(o.net_sales_in_local_curr) as tot, 
			min(o.order_date) as min_order_date
			
			from `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o
				inner join `apmena-oneconsumer-dna-apac-qa.space_crm_1_2.dim_consumer_napac` c 
				on c.consumer_code=o.consumer_code
				left join `apmena-oneconsumer-dna-apac-qa.crm_market_summary_parallel_run.counter_to_channel` cc
                ON o.counter_code = concat(cc.market_id,cc.counter_id)		
			

			where (c.is_consumer_flag='Y' or c.is_consumer_flag is null or lower(ltrim(rtrim(c.is_consumer_flag)))='null')
                --and c.division='LLD'
			and ((o.net_sales_in_local_curr >0) or
				(o.PROD_TYPE='YFG' 
				and o.market_code='HK' 
				and o.net_sales_in_local_curr >0))
				and (o.order_type in ('Normal Sales','Sales Return') or o.market_code='KR')
			group by o.market_code,c.signature_code,c.consumer_type,lucid , c.gender,cc.channel_mode
            --having tot>0 
			having FORMAT_TIMESTAMP("%Y%m%d",min_order_date)  BETWEEN R36_FROM_LY AND R36_TO_LY
			)
            where FORMAT_TIMESTAMP("%Y%m%d",min_order_date) BETWEEN FROMDATE_LY AND TODATE_LY
			group by market_code,signature_code,consumer_type,lucid, gender,channel_mode,Transactions
			
		) group by signature_code,market_code,consumer_type, gender,channel_mode
	------------------------------------------------------------

	) where  market_code = dc_ot.market_code
		and signature_code = dc_ot.signature_code
		and consumer_type = dc_ot.consumer_type
		and gender = dc_ot.gender
		and channel_mode = cc_ot.channel_mode
)as new_cus_trans_ly,

	
(--New Customer Sales Current Year
    select new_cus_sales from
    (
	------------------------------------------------------------
	select market_code,signature_code,consumer_type,gender,channel_mode,cast(sum(total_sales) as bignumeric) as new_cus_sales from 
		(
		select distinct market_code,signature_code,lucid,total_sales,consumer_type,gender,channel_mode from
            (
			SELECT o.market_code,
			c.signature_code,
			c.consumer_type,
			c.gender,
			cc.channel_mode,
			lucid,
			o.net_sales_in_local_curr as total_sales, 
			min(o.order_date) as min_order_date
			
			from `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o
				inner join `apmena-oneconsumer-dna-apac-qa.space_crm_1_2.dim_consumer_napac` c 
				on c.consumer_code=o.consumer_code
				left join `apmena-oneconsumer-dna-apac-qa.crm_market_summary_parallel_run.counter_to_channel` cc
                ON o.counter_code = concat(cc.market_id,cc.counter_id)		
			

			where (c.is_consumer_flag='Y' or c.is_consumer_flag is null or lower(ltrim(rtrim(c.is_consumer_flag)))='null')
                --and c.division='LLD'
			and ((o.net_sales_in_local_curr >0) or
				(o.PROD_TYPE='YFG' 
				and o.market_code='HK' 
				and o.net_sales_in_local_curr >0))
				and (o.order_type in ('Normal Sales','Sales Return') or o.market_code='KR')
			group by o.market_code,c.signature_code,c.consumer_type,lucid , 
            c.gender,cc.channel_mode,o.net_sales_in_local_curr
            having FORMAT_TIMESTAMP("%Y%m%d",min_order_date) BETWEEN R36_FROM AND R36_TO
            )
            where FORMAT_TIMESTAMP("%Y%m%d",min_order_date) BETWEEN FROMDATE_CY AND TODATE_CY
			group by market_code,signature_code,consumer_type,lucid, gender,channel_mode, total_sales
			
		) group by signature_code,market_code,consumer_type, gender,channel_mode
	------------------------------------------------------------

	) where  market_code = dc_ot.market_code
		and signature_code = dc_ot.signature_code
		and consumer_type = dc_ot.consumer_type
		and gender = dc_ot.gender
		and channel_mode = cc_ot.channel_mode
)as new_cus_sales_cy,


(--New Customer Sales Last Year
    select new_cus_sales from
    (
	------------------------------------------------------------
	select market_code,signature_code,consumer_type,gender,channel_mode,cast(sum(total_sales) as bignumeric) as new_cus_sales from 
		(
		select distinct market_code,signature_code,lucid,total_sales,consumer_type,gender,channel_mode from
            (
			SELECT o.market_code,
			c.signature_code,
			c.consumer_type,
			c.gender,
			cc.channel_mode,
			lucid,
			o.net_sales_in_local_curr as total_sales, 
			min(o.order_date) as min_order_date
			
			from `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o
				inner join `apmena-oneconsumer-dna-apac-qa.space_crm_1_2.dim_consumer_napac` c 
				on c.consumer_code=o.consumer_code
				left join `apmena-oneconsumer-dna-apac-qa.crm_market_summary_parallel_run.counter_to_channel` cc
                ON o.counter_code = concat(cc.market_id,cc.counter_id)		
			

			where (c.is_consumer_flag='Y' or c.is_consumer_flag is null or lower(ltrim(rtrim(c.is_consumer_flag)))='null')
                --and c.division='LLD'
			and ((o.net_sales_in_local_curr >0) or
				(o.PROD_TYPE='YFG' 
				and o.market_code='HK' 
				and o.net_sales_in_local_curr >0))
				and (o.order_type in ('Normal Sales','Sales Return') or o.market_code='KR')
			group by o.market_code,c.signature_code,c.consumer_type,lucid , 
            c.gender,cc.channel_mode,o.net_sales_in_local_curr
            having FORMAT_TIMESTAMP("%Y%m%d",min_order_date) BETWEEN R36_FROM_LY AND R36_TO_LY
            )
            where FORMAT_TIMESTAMP("%Y%m%d",min_order_date) BETWEEN FROMDATE_LY AND TODATE_LY
			group by market_code,signature_code,consumer_type,lucid, gender,channel_mode, total_sales
			
		) group by signature_code,market_code,consumer_type, gender,channel_mode
	------------------------------------------------------------

	) where  market_code = dc_ot.market_code
		and signature_code = dc_ot.signature_code
		and consumer_type = dc_ot.consumer_type
		and gender = dc_ot.gender
		and channel_mode = cc_ot.channel_mode
)as new_cus_sales_ly,



(--Existing Customer Current Year
    select existing_cust from
    (
	------------------------------------------------------------
		
		select signature_code,market_code,consumer_type,gender,channel_mode,
		count(distinct UNIQUE_ID) AS existing_cust
		from
		(
			select lucid as UNIQUE_ID,o.market_code,c.signature_code,c.consumer_type,
			c.gender,cc.channel_mode
			
			from `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o
			inner join `apmena-oneconsumer-dna-apac-qa.space_crm_1_2.dim_consumer_napac` c 
			on c.consumer_code=o.consumer_code
			left join `apmena-oneconsumer-dna-apac-qa.crm_market_summary_parallel_run.counter_to_channel` cc
               ON o.counter_code = concat(cc.market_id,cc.counter_id)
			
			where (c.is_consumer_flag='Y' or c.is_consumer_flag is null or lower(ltrim(rtrim(c.is_consumer_flag)))='null')
			
			and (
			select sum(o_itr1.net_sales_in_local_curr)  
			 FROM  
			 `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o_itr1
			where  
				 ((o_itr1.net_sales_in_local_curr >0) or
				(o_itr1.PROD_TYPE='YFG' 
				and o_itr1.market_code='HK' 
				and o_itr1.net_sales_in_local_curr >0))
				and (o_itr1.order_type in ('Normal Sales','Sales Return') or o_itr1.market_code='KR') -- to exclude redemption
				--(net_sales  where order_dt_wid in MTD/YTD/R12/DateFromTo)>0 and  
				and FORMAT_TIMESTAMP("%Y%m%d",o_itr1.order_date) BETWEEN FROMDATE_CY AND TODATE_CY
				
				and  c.consumer_code=o_itr1.consumer_code
				)>0 
			
				and (
			select sum(o_itr2.net_sales_in_local_curr)  
			 FROM  
			 `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o_itr2
			where  
				 ((o_itr2.net_sales_in_local_curr >0) or
				(o_itr2.PROD_TYPE='YFG' 
				and o_itr2.market_code='HK' 
				and o_itr2.net_sales_in_local_curr >0))
				and (o_itr2.order_type in ('Normal Sales','Sales Return') or o_itr2.market_code='KR') -- to exclude redemption
				
				--(net_sales where order_dt_wid < MTD/YTD/R12/DateFromTo and order_dt_wid in R36 )>0
				
				and FORMAT_TIMESTAMP("%Y%m%d",o_itr2.order_date) BETWEEN R36_FROM AND R36_TO
				--and FORMAT_TIMESTAMP("%Y%m%d",o_itr2.order_date) < '20201201'
				and  c.consumer_code=o_itr2.consumer_code
				)>0 
		) as retain_customer_to_market
			group by signature_code,market_code,consumer_type,gender,channel_mode
	------------------------------------------------------------

	) where  market_code = dc_ot.market_code
		and signature_code = dc_ot.signature_code
		and consumer_type = dc_ot.consumer_type
		and gender = dc_ot.gender
		and channel_mode = cc_ot.channel_mode
		
)as existing_cust_cy,


(--Existing Customer Last Year
    select existing_cust from
    (
	------------------------------------------------------------
		
		select signature_code,market_code,consumer_type,gender,channel_mode,
		count(distinct UNIQUE_ID) AS existing_cust
		from
		(
			select lucid as UNIQUE_ID,o.market_code,c.signature_code,c.consumer_type,
			c.gender,cc.channel_mode
			
			from `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o
			inner join `apmena-oneconsumer-dna-apac-qa.space_crm_1_2.dim_consumer_napac` c 
			on c.consumer_code=o.consumer_code
			left join `apmena-oneconsumer-dna-apac-qa.crm_market_summary_parallel_run.counter_to_channel` cc
               ON o.counter_code = concat(cc.market_id,cc.counter_id)
			
			where (c.is_consumer_flag='Y' or c.is_consumer_flag is null or lower(ltrim(rtrim(c.is_consumer_flag)))='null')
			
			and (
			select sum(o_itr1.net_sales_in_local_curr)  
			 FROM  
			 `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o_itr1
			where  
				 ((o_itr1.net_sales_in_local_curr >0) or
				(o_itr1.PROD_TYPE='YFG' 
				and o_itr1.market_code='HK' 
				and o_itr1.net_sales_in_local_curr >0))
				and (o_itr1.order_type in ('Normal Sales','Sales Return') or o_itr1.market_code='KR') -- to exclude redemption
				--(net_sales  where order_dt_wid in MTD/YTD/R12/DateFromTo)>0 and  
				and FORMAT_TIMESTAMP("%Y%m%d",o_itr1.order_date) BETWEEN FROMDATE_LY AND TODATE_LY
				
				and  c.consumer_code=o_itr1.consumer_code
				)>0 
			
				and (
			select sum(o_itr2.net_sales_in_local_curr)  
			 FROM  
			 `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o_itr2
			where  
				 ((o_itr2.net_sales_in_local_curr >0) or
				(o_itr2.PROD_TYPE='YFG' 
				and o_itr2.market_code='HK' 
				and o_itr2.net_sales_in_local_curr >0))
				and (o_itr2.order_type in ('Normal Sales','Sales Return') or o_itr2.market_code='KR') -- to exclude redemption
				
				--(net_sales where order_dt_wid < MTD/YTD/R12/DateFromTo and order_dt_wid in R36 )>0
				
				and FORMAT_TIMESTAMP("%Y%m%d",o_itr2.order_date) BETWEEN R36_FROM_LY AND R36_TO_LY
				--and FORMAT_TIMESTAMP("%Y%m%d",o_itr2.order_date) < '20201201'
				and  c.consumer_code=o_itr2.consumer_code
				)>0 
		) as retain_customer_to_market
			group by signature_code,market_code,consumer_type,gender,channel_mode
	------------------------------------------------------------

	) where  market_code = dc_ot.market_code
		and signature_code = dc_ot.signature_code
		and consumer_type = dc_ot.consumer_type
		and gender = dc_ot.gender
		and channel_mode = cc_ot.channel_mode
		
)as existing_cust_ly,


(--Existing Customer sales Current Year
    select existing_cust_sales from
    (
	------------------------------------------------------------
		
		select signature_code,market_code,consumer_type,gender,channel_mode,
		cast(sum(sales) as bignumeric) AS existing_cust_sales
		from
		(
			select lucid as UNIQUE_ID,o.market_code,c.signature_code,c.consumer_type,
			c.gender,cc.channel_mode, cast(sum(o.net_sales_in_local_curr) as bignumeric) as sales
			
			from `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o
			inner join `apmena-oneconsumer-dna-apac-qa.space_crm_1_2.dim_consumer_napac` c 
			on c.consumer_code=o.consumer_code
			left join `apmena-oneconsumer-dna-apac-qa.crm_market_summary_parallel_run.counter_to_channel` cc
               ON o.counter_code = concat(cc.market_id,cc.counter_id)
			
			where (c.is_consumer_flag='Y' or c.is_consumer_flag is null or lower(ltrim(rtrim(c.is_consumer_flag)))='null')
			
			and (
			select sum(o_itr1.net_sales_in_local_curr)  
			 FROM  
			 `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o_itr1
			where  
				 ((o_itr1.net_sales_in_local_curr >0) or
				(o_itr1.PROD_TYPE='YFG' 
				and o_itr1.market_code='HK' 
				and o_itr1.net_sales_in_local_curr >0))
				and (o_itr1.order_type in ('Normal Sales','Sales Return') or o_itr1.market_code='KR') -- to exclude redemption
				--(net_sales  where order_dt_wid in MTD/YTD/R12/DateFromTo)>0 and  
				and FORMAT_TIMESTAMP("%Y%m%d",o_itr1.order_date) BETWEEN FROMDATE_CY AND TODATE_CY
				
				and  c.consumer_code=o_itr1.consumer_code
				)>0 
			
				and (
			select sum(o_itr2.net_sales_in_local_curr)  
			 FROM  
			 `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o_itr2
			where  
				 ((o_itr2.net_sales_in_local_curr >0) or
				(o_itr2.PROD_TYPE='YFG' 
				and o_itr2.market_code='HK' 
				and o_itr2.net_sales_in_local_curr >0))
				and (o_itr2.order_type in ('Normal Sales','Sales Return') or o_itr2.market_code='KR') -- to exclude redemption
				
				--(net_sales where order_dt_wid < MTD/YTD/R12/DateFromTo and order_dt_wid in R36 )>0
				
				and FORMAT_TIMESTAMP("%Y%m%d",o_itr2.order_date) BETWEEN R36_FROM AND R36_TO
				--and FORMAT_TIMESTAMP("%Y%m%d",o_itr2.order_date) < '20201201'
				and  c.consumer_code=o_itr2.consumer_code
				)>0 
				
				group by lucid,o.market_code,c.signature_code,c.consumer_type,c.gender,cc.channel_mode
		) as retain_customer_to_market
			group by signature_code,market_code,consumer_type,gender,channel_mode
	------------------------------------------------------------

	) where  market_code = dc_ot.market_code
		and signature_code = dc_ot.signature_code
		and consumer_type = dc_ot.consumer_type
		and gender = dc_ot.gender
		and channel_mode = cc_ot.channel_mode
		
)as existing_cust_sales_cy,


(--Existing Customer sales last Year
    select existing_cust_sales from
    (
	------------------------------------------------------------
		
		select signature_code,market_code,consumer_type,gender,channel_mode,
		cast(sum(sales) as bignumeric) AS existing_cust_sales
		from
		(
			select lucid as UNIQUE_ID,o.market_code,c.signature_code,c.consumer_type,
			c.gender,cc.channel_mode, cast(sum(o.net_sales_in_local_curr) as bignumeric) as sales
			
			from `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o
			inner join `apmena-oneconsumer-dna-apac-qa.space_crm_1_2.dim_consumer_napac` c 
			on c.consumer_code=o.consumer_code
			left join `apmena-oneconsumer-dna-apac-qa.crm_market_summary_parallel_run.counter_to_channel` cc
               ON o.counter_code = concat(cc.market_id,cc.counter_id)
			
			where (c.is_consumer_flag='Y' or c.is_consumer_flag is null or lower(ltrim(rtrim(c.is_consumer_flag)))='null')
			
			and (
			select sum(o_itr1.net_sales_in_local_curr)  
			 FROM  
			 `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o_itr1
			where  
				 ((o_itr1.net_sales_in_local_curr >0) or
				(o_itr1.PROD_TYPE='YFG' 
				and o_itr1.market_code='HK' 
				and o_itr1.net_sales_in_local_curr >0))
				and (o_itr1.order_type in ('Normal Sales','Sales Return') or o_itr1.market_code='KR') -- to exclude redemption
				--(net_sales  where order_dt_wid in MTD/YTD/R12/DateFromTo)>0 and  
				and FORMAT_TIMESTAMP("%Y%m%d",o_itr1.order_date) BETWEEN FROMDATE_LY AND TODATE_LY
				
				and  c.consumer_code=o_itr1.consumer_code
				)>0 
			
				and (
			select sum(o_itr2.net_sales_in_local_curr)  
			 FROM  
			 `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o_itr2
			where  
				 ((o_itr2.net_sales_in_local_curr >0) or
				(o_itr2.PROD_TYPE='YFG' 
				and o_itr2.market_code='HK' 
				and o_itr2.net_sales_in_local_curr >0))
				and (o_itr2.order_type in ('Normal Sales','Sales Return') or o_itr2.market_code='KR') -- to exclude redemption
				
				--(net_sales where order_dt_wid < MTD/YTD/R12/DateFromTo and order_dt_wid in R36 )>0
				
				and FORMAT_TIMESTAMP("%Y%m%d",o_itr2.order_date) BETWEEN R36_FROM_LY AND R36_TO_LY
				--and FORMAT_TIMESTAMP("%Y%m%d",o_itr2.order_date) < '20201201'
				and  c.consumer_code=o_itr2.consumer_code
				)>0 
				
				group by lucid,o.market_code,c.signature_code,c.consumer_type,c.gender,cc.channel_mode
		) as retain_customer_to_market
			group by signature_code,market_code,consumer_type,gender,channel_mode
	------------------------------------------------------------

	) where  market_code = dc_ot.market_code
		and signature_code = dc_ot.signature_code
		and consumer_type = dc_ot.consumer_type
		and gender = dc_ot.gender
		and channel_mode = cc_ot.channel_mode
		
)as existing_cust_sales_ly,


    
(--Existing Customer trans Current Year
    select existing_cust_trans from
    (
	------------------------------------------------------------
		
		select signature_code,market_code,consumer_type,gender,channel_mode,
		sum(Transactions)  AS existing_cust_trans
		from
		(
			select lucid as UNIQUE_ID,o.market_code,c.signature_code,c.consumer_type,
			c.gender,cc.channel_mode, 
			case 
                when SUM(o.order_quantity * o.net_price)>0 then 1
                when SUM(o.order_quantity * o.net_price)<0 then -1
                ELSE 0 
            END
            AS Transactions,
			
			from `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o
			inner join `apmena-oneconsumer-dna-apac-qa.space_crm_1_2.dim_consumer_napac` c 
			on c.consumer_code=o.consumer_code
			left join `apmena-oneconsumer-dna-apac-qa.crm_market_summary_parallel_run.counter_to_channel` cc
               ON o.counter_code = concat(cc.market_id,cc.counter_id)
			
			where (c.is_consumer_flag='Y' or c.is_consumer_flag is null or lower(ltrim(rtrim(c.is_consumer_flag)))='null')
			
			and (
			select sum(o_itr1.net_sales_in_local_curr)  
			 FROM  
			 `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o_itr1
			where  
				 ((o_itr1.net_sales_in_local_curr >0) or
				(o_itr1.PROD_TYPE='YFG' 
				and o_itr1.market_code='HK' 
				and o_itr1.net_sales_in_local_curr >0))
				and (o_itr1.order_type in ('Normal Sales','Sales Return') or o_itr1.market_code='KR') -- to exclude redemption
				--(net_sales  where order_dt_wid in MTD/YTD/R12/DateFromTo)>0 and  
				and FORMAT_TIMESTAMP("%Y%m%d",o_itr1.order_date) BETWEEN FROMDATE_CY AND TODATE_CY
				
				and  c.consumer_code=o_itr1.consumer_code
				)>0 
			
				and (
			select sum(o_itr2.net_sales_in_local_curr)  
			 FROM  
			 `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o_itr2
			where  
				 ((o_itr2.net_sales_in_local_curr >0) or
				(o_itr2.PROD_TYPE='YFG' 
				and o_itr2.market_code='HK' 
				and o_itr2.net_sales_in_local_curr >0))
				and (o_itr2.order_type in ('Normal Sales','Sales Return') or o_itr2.market_code='KR') -- to exclude redemption
				
				--(net_sales where order_dt_wid < MTD/YTD/R12/DateFromTo and order_dt_wid in R36 )>0
				
				and FORMAT_TIMESTAMP("%Y%m%d",o_itr2.order_date) BETWEEN R36_FROM AND R36_TO
				--and FORMAT_TIMESTAMP("%Y%m%d",o_itr2.order_date) < '20201201'
				and  c.consumer_code=o_itr2.consumer_code
				)>0 
				
				group by lucid,o.market_code,c.signature_code,c.consumer_type,c.gender,cc.channel_mode
		) as retain_customer_to_market
			group by signature_code,market_code,consumer_type,gender,channel_mode
	------------------------------------------------------------

	) where  market_code = dc_ot.market_code
		and signature_code = dc_ot.signature_code
		and consumer_type = dc_ot.consumer_type
		and gender = dc_ot.gender
		and channel_mode = cc_ot.channel_mode
		
)as existing_cust_trans_cy,


(--Existing Customer trans last Year
    select existing_cust_trans from
    (
	------------------------------------------------------------
		
		select signature_code,market_code,consumer_type,gender,channel_mode,
		sum(Transactions)  AS existing_cust_trans
		from
		(
			select lucid as UNIQUE_ID,o.market_code,c.signature_code,c.consumer_type,
			c.gender,cc.channel_mode, 
			case 
                when SUM(o.order_quantity * o.net_price)>0 then 1
                when SUM(o.order_quantity * o.net_price)<0 then -1
                ELSE 0 
            END
            AS Transactions,
			
			from `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o
			inner join `apmena-oneconsumer-dna-apac-qa.space_crm_1_2.dim_consumer_napac` c 
			on c.consumer_code=o.consumer_code
			left join `apmena-oneconsumer-dna-apac-qa.crm_market_summary_parallel_run.counter_to_channel` cc
               ON o.counter_code = concat(cc.market_id,cc.counter_id)
			
			where (c.is_consumer_flag='Y' or c.is_consumer_flag is null or lower(ltrim(rtrim(c.is_consumer_flag)))='null')
			
			and (
			select sum(o_itr1.net_sales_in_local_curr)  
			 FROM  
			 `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o_itr1
			where  
				 ((o_itr1.net_sales_in_local_curr >0) or
				(o_itr1.PROD_TYPE='YFG' 
				and o_itr1.market_code='HK' 
				and o_itr1.net_sales_in_local_curr >0))
				and (o_itr1.order_type in ('Normal Sales','Sales Return') or o_itr1.market_code='KR') -- to exclude redemption
				--(net_sales  where order_dt_wid in MTD/YTD/R12/DateFromTo)>0 and  
				and FORMAT_TIMESTAMP("%Y%m%d",o_itr1.order_date) BETWEEN FROMDATE_LY AND TODATE_LY
				
				and  c.consumer_code=o_itr1.consumer_code
				)>0 
			
				and (
			select sum(o_itr2.net_sales_in_local_curr)  
			 FROM  
			 `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o_itr2
			where  
				 ((o_itr2.net_sales_in_local_curr >0) or
				(o_itr2.PROD_TYPE='YFG' 
				and o_itr2.market_code='HK' 
				and o_itr2.net_sales_in_local_curr >0))
				and (o_itr2.order_type in ('Normal Sales','Sales Return') or o_itr2.market_code='KR') -- to exclude redemption
				
				--(net_sales where order_dt_wid < MTD/YTD/R12/DateFromTo and order_dt_wid in R36 )>0
				
				and FORMAT_TIMESTAMP("%Y%m%d",o_itr2.order_date) BETWEEN R36_FROM_LY AND R36_TO_LY
				--and FORMAT_TIMESTAMP("%Y%m%d",o_itr2.order_date) < '20201201'
				and  c.consumer_code=o_itr2.consumer_code
				)>0 
				
				group by lucid,o.market_code,c.signature_code,c.consumer_type,c.gender,cc.channel_mode
		) as retain_customer_to_market
			group by signature_code,market_code,consumer_type,gender,channel_mode
	------------------------------------------------------------

	) where  market_code = dc_ot.market_code
		and signature_code = dc_ot.signature_code
		and consumer_type = dc_ot.consumer_type
		and gender = dc_ot.gender
		and channel_mode = cc_ot.channel_mode
		
)as existing_cust_trans_ly,


(--Existing Customer units Current Year
    select existing_cust_units from
    (
	------------------------------------------------------------
		
		select signature_code,market_code,consumer_type,gender,channel_mode,
		sum(units) AS existing_cust_units
		from
		(
			select lucid as UNIQUE_ID,o.market_code,c.signature_code,c.consumer_type,
			c.gender,cc.channel_mode, sum(o.order_quantity) as units
			
			from `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o
			inner join `apmena-oneconsumer-dna-apac-qa.space_crm_1_2.dim_consumer_napac` c 
			on c.consumer_code=o.consumer_code
			left join `apmena-oneconsumer-dna-apac-qa.crm_market_summary_parallel_run.counter_to_channel` cc
               ON o.counter_code = concat(cc.market_id,cc.counter_id)
			
			where (c.is_consumer_flag='Y' or c.is_consumer_flag is null or lower(ltrim(rtrim(c.is_consumer_flag)))='null')
			
			and (
			select sum(o_itr1.net_sales_in_local_curr)  
			 FROM  
			 `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o_itr1
			where  
				 ((o_itr1.net_sales_in_local_curr >0) or
				(o_itr1.PROD_TYPE='YFG' 
				and o_itr1.market_code='HK' 
				and o_itr1.net_sales_in_local_curr >0))
				and (o_itr1.order_type in ('Normal Sales','Sales Return') or o_itr1.market_code='KR') -- to exclude redemption
				--(net_sales  where order_dt_wid in MTD/YTD/R12/DateFromTo)>0 and  
				and FORMAT_TIMESTAMP("%Y%m%d",o_itr1.order_date) BETWEEN FROMDATE_CY AND TODATE_CY
				
				and  c.consumer_code=o_itr1.consumer_code
				)>0 
			
				and (
			select sum(o_itr2.net_sales_in_local_curr)  
			 FROM  
			 `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o_itr2
			where  
				 ((o_itr2.net_sales_in_local_curr >0) or
				(o_itr2.PROD_TYPE='YFG' 
				and o_itr2.market_code='HK' 
				and o_itr2.net_sales_in_local_curr >0))
				and (o_itr2.order_type in ('Normal Sales','Sales Return') or o_itr2.market_code='KR') -- to exclude redemption
				
				--(net_sales where order_dt_wid < MTD/YTD/R12/DateFromTo and order_dt_wid in R36 )>0
				
				and FORMAT_TIMESTAMP("%Y%m%d",o_itr2.order_date) BETWEEN  R36_FROM AND R36_TO
				--and FORMAT_TIMESTAMP("%Y%m%d",o_itr2.order_date) < '20201201'
				and  c.consumer_code=o_itr2.consumer_code
				)>0 
				
				group by lucid,o.market_code,c.signature_code,c.consumer_type,c.gender,cc.channel_mode
		) as retain_customer_to_market
			group by signature_code,market_code,consumer_type,gender,channel_mode
	------------------------------------------------------------

	) where  market_code = dc_ot.market_code
		and signature_code = dc_ot.signature_code
		and consumer_type = dc_ot.consumer_type
		and gender = dc_ot.gender
		and channel_mode = cc_ot.channel_mode
		
)as existing_cust_units_cy,


(--Existing Customer units Last Year
    select existing_cust_units from
    (
	------------------------------------------------------------
		
		select signature_code,market_code,consumer_type,gender,channel_mode,
		sum(units) AS existing_cust_units
		from
		(
			select lucid as UNIQUE_ID,o.market_code,c.signature_code,c.consumer_type,
			c.gender,cc.channel_mode, sum(o.order_quantity) as units
			
			from `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o
			inner join `apmena-oneconsumer-dna-apac-qa.space_crm_1_2.dim_consumer_napac` c 
			on c.consumer_code=o.consumer_code
			left join `apmena-oneconsumer-dna-apac-qa.crm_market_summary_parallel_run.counter_to_channel` cc
               ON o.counter_code = concat(cc.market_id,cc.counter_id)
			
			where (c.is_consumer_flag='Y' or c.is_consumer_flag is null or lower(ltrim(rtrim(c.is_consumer_flag)))='null')
			
			and (
			select sum(o_itr1.net_sales_in_local_curr)  
			 FROM  
			 `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o_itr1
			where  
				 ((o_itr1.net_sales_in_local_curr >0) or
				(o_itr1.PROD_TYPE='YFG' 
				and o_itr1.market_code='HK' 
				and o_itr1.net_sales_in_local_curr >0))
				and (o_itr1.order_type in ('Normal Sales','Sales Return') or o_itr1.market_code='KR') -- to exclude redemption
				--(net_sales  where order_dt_wid in MTD/YTD/R12/DateFromTo)>0 and  
				and FORMAT_TIMESTAMP("%Y%m%d",o_itr1.order_date) BETWEEN FROMDATE_LY AND TODATE_LY
				
				and  c.consumer_code=o_itr1.consumer_code
				)>0 
			
				and (
			select sum(o_itr2.net_sales_in_local_curr)  
			 FROM  
			 `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o_itr2
			where  
				 ((o_itr2.net_sales_in_local_curr >0) or
				(o_itr2.PROD_TYPE='YFG' 
				and o_itr2.market_code='HK' 
				and o_itr2.net_sales_in_local_curr >0))
				and (o_itr2.order_type in ('Normal Sales','Sales Return') or o_itr2.market_code='KR') -- to exclude redemption
				
				--(net_sales where order_dt_wid < MTD/YTD/R12/DateFromTo and order_dt_wid in R36 )>0
				
				and FORMAT_TIMESTAMP("%Y%m%d",o_itr2.order_date) BETWEEN  R36_FROM_LY AND R36_TO_LY
				--and FORMAT_TIMESTAMP("%Y%m%d",o_itr2.order_date) < '20201201'
				and  c.consumer_code=o_itr2.consumer_code
				)>0 
				
				group by lucid,o.market_code,c.signature_code,c.consumer_type,c.gender,cc.channel_mode
		) as retain_customer_to_market
			group by signature_code,market_code,consumer_type,gender,channel_mode
	------------------------------------------------------------

	) where  market_code = dc_ot.market_code
		and signature_code = dc_ot.signature_code
		and consumer_type = dc_ot.consumer_type
		and gender = dc_ot.gender
		and channel_mode = cc_ot.channel_mode
		
)as existing_cust_units_ly,



(--Winback Current Year
    select winback_cust from
    (
	------------------------------------------------------------
		
		select signature_code,market_code,consumer_type,gender,channel_mode,
		count(distinct UNIQUE_ID) AS winback_cust
		from
		(
			select lucid as UNIQUE_ID,o.market_code,c.signature_code,c.consumer_type,
			c.gender,cc.channel_mode
			
			from `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o
			inner join `apmena-oneconsumer-dna-apac-qa.space_crm_1_2.dim_consumer_napac` c 
			on c.consumer_code=o.consumer_code
			left join `apmena-oneconsumer-dna-apac-qa.crm_market_summary_parallel_run.counter_to_channel` cc
               ON o.counter_code = concat(cc.market_id,cc.counter_id)
			
			where (c.is_consumer_flag='Y' or c.is_consumer_flag is null or lower(ltrim(rtrim(c.is_consumer_flag)))='null')
			
			
			
			and (
			select sum(o_itr1.net_sales_in_local_curr)  
			from `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o_itr1
			inner join `apmena-oneconsumer-dna-apac-qa.space_crm_1_2.dim_consumer_napac` c_itr1
			on c_itr1.consumer_code=o_itr1.consumer_code
			left join `apmena-oneconsumer-dna-apac-qa.crm_market_summary_parallel_run.counter_to_channel` cc_itr1
            ON o_itr1.counter_code = concat(cc_itr1.market_id,cc_itr1.counter_id)
			
			where  
				 ((o_itr1.net_sales_in_local_curr >0) or
				(o_itr1.PROD_TYPE='YFG' 
				and o_itr1.market_code='HK' 
				and o_itr1.net_sales_in_local_curr >0))
				and (o_itr1.order_type in ('Normal Sales','Sales Return') or o_itr1.market_code='KR') -- to exclude redemption
				
				--AND (net_sales where ORDER_DT_WID in YTD/MTD/R12 AND S.signature_code=<brand signatrue code>)>0 
				
				and FORMAT_TIMESTAMP("%Y%m%d",o_itr1.order_date) BETWEEN FROMDATE_CY AND TODATE_CY
				
				and c.consumer_code=o_itr1.consumer_code
				
				and c_itr1.signature_code=c.signature_code
				--and cc_itr1.channel_mode=cc.channel_mode
				)>0 
			
			and (
			select sum(o_itr2.net_sales_in_local_curr)  
			from `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o_itr2
			inner join `apmena-oneconsumer-dna-apac-qa.space_crm_1_2.dim_consumer_napac` c_itr2
			on c_itr2.consumer_code=o_itr2.consumer_code
			left join `apmena-oneconsumer-dna-apac-qa.crm_market_summary_parallel_run.counter_to_channel` cc_itr2
            ON o_itr2.counter_code = concat(cc_itr2.market_id,cc_itr2.counter_id)
			
			where  
				 ((o_itr2.net_sales_in_local_curr >0) or
				(o_itr2.PROD_TYPE='YFG' 
				and o_itr2.market_code='HK' 
				and o_itr2.net_sales_in_local_curr >0))
				and (o_itr2.order_type in ('Normal Sales','Sales Return') or o_itr2.market_code='KR') -- to exclude redemption
				
				--AND (net_sales where ORDER_DT_WID in 2 years ago/2 years ago/R13-R24 AND 
				--S.signature_code=<brand signatrue code> and Purchase Channel='Online')>0
				
				and FORMAT_TIMESTAMP("%Y%m%d",o_itr2.order_date) between '20180101' and '20181231'
				--This date has to be decided
				--and FORMAT_TIMESTAMP("%Y%m%d",o_itr2.order_date) between  R1324_FROMDATE_CY and R1324_TODATE_CY
				and c.consumer_code=o_itr2.consumer_code
				
				and c_itr2.signature_code=c.signature_code
				and cc_itr2.channel_mode=cc.channel_mode
				)>0 
				
				and (
			select sum(o_itr3.net_sales_in_local_curr)  
			from `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o_itr3
			inner join `apmena-oneconsumer-dna-apac-qa.space_crm_1_2.dim_consumer_napac` c_itr3
			on c_itr3.consumer_code=o_itr3.consumer_code
			left join `apmena-oneconsumer-dna-apac-qa.crm_market_summary_parallel_run.counter_to_channel` cc_itr3
            ON o_itr3.counter_code = concat(cc_itr3.market_id,cc_itr3.counter_id)
			
			where  
				 /*((o_itr3.net_sales_in_local_curr >0) or
				(o_itr3.PROD_TYPE='YFG' 
				and o_itr3.market_code='HK' 
				and o_itr3.net_sales_in_local_curr >0))
				and (o_itr3.order_type in ('Normal Sales','Sales Return') or o_itr3.market_code='KR') -- to exclude redemption
				*/
				--AND (net_sales where ORDER_DT_WID in 2 years ago/2 years ago/R13-R24 AND 
				--S.signature_code=<brand signatrue code> and Purchase Channel='Online')>0
				
				FORMAT_TIMESTAMP("%Y%m%d",o_itr3.order_date) between '20190101' and '20191231'
				--This date has to be decided
				--FORMAT_TIMESTAMP("%Y%m%d",o_itr3.order_date) between R1324_FROMDATE_CY and R1324_TODATE_CY
				and c.consumer_code=o_itr3.consumer_code
				
				and c_itr3.signature_code=c.signature_code
				and cc_itr3.channel_mode=cc.channel_mode
				)<=0 
			
				 
		) as winback_cust
			group by signature_code,market_code,consumer_type,gender,channel_mode
	------------------------------------------------------------

	) where  market_code = dc_ot.market_code
		and signature_code = dc_ot.signature_code
		and consumer_type = dc_ot.consumer_type
		and gender = dc_ot.gender
		and channel_mode = cc_ot.channel_mode
		
)as winback_cust_cy,


(--Winback Last Year
    select winback_cust from
    (
	------------------------------------------------------------
		
		select signature_code,market_code,consumer_type,gender,channel_mode,
		count(distinct UNIQUE_ID) AS winback_cust
		from
		(
			select lucid as UNIQUE_ID,o.market_code,c.signature_code,c.consumer_type,
			c.gender,cc.channel_mode
			
			from `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o
			inner join `apmena-oneconsumer-dna-apac-qa.space_crm_1_2.dim_consumer_napac` c 
			on c.consumer_code=o.consumer_code
			left join `apmena-oneconsumer-dna-apac-qa.crm_market_summary_parallel_run.counter_to_channel` cc
               ON o.counter_code = concat(cc.market_id,cc.counter_id)
			
			where (c.is_consumer_flag='Y' or c.is_consumer_flag is null or lower(ltrim(rtrim(c.is_consumer_flag)))='null')
			
			
			
			and (
			select sum(o_itr1.net_sales_in_local_curr)  
			from `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o_itr1
			inner join `apmena-oneconsumer-dna-apac-qa.space_crm_1_2.dim_consumer_napac` c_itr1
			on c_itr1.consumer_code=o_itr1.consumer_code
			left join `apmena-oneconsumer-dna-apac-qa.crm_market_summary_parallel_run.counter_to_channel` cc_itr1
            ON o_itr1.counter_code = concat(cc_itr1.market_id,cc_itr1.counter_id)
			
			where  
				 ((o_itr1.net_sales_in_local_curr >0) or
				(o_itr1.PROD_TYPE='YFG' 
				and o_itr1.market_code='HK' 
				and o_itr1.net_sales_in_local_curr >0))
				and (o_itr1.order_type in ('Normal Sales','Sales Return') or o_itr1.market_code='KR') -- to exclude redemption
				
				--AND (net_sales where ORDER_DT_WID in YTD/MTD/R12 AND S.signature_code=<brand signatrue code>)>0 
				
				and FORMAT_TIMESTAMP("%Y%m%d",o_itr1.order_date) BETWEEN FROMDATE_CY AND TODATE_CY
				
				and c.consumer_code=o_itr1.consumer_code
				
				and c_itr1.signature_code=c.signature_code
				--and cc_itr1.channel_mode=cc.channel_mode
				)>0 
			
			and (
			select sum(o_itr2.net_sales_in_local_curr)  
			from `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o_itr2
			inner join `apmena-oneconsumer-dna-apac-qa.space_crm_1_2.dim_consumer_napac` c_itr2
			on c_itr2.consumer_code=o_itr2.consumer_code
			left join `apmena-oneconsumer-dna-apac-qa.crm_market_summary_parallel_run.counter_to_channel` cc_itr2
            ON o_itr2.counter_code = concat(cc_itr2.market_id,cc_itr2.counter_id)
			
			where  
				 ((o_itr2.net_sales_in_local_curr >0) or
				(o_itr2.PROD_TYPE='YFG' 
				and o_itr2.market_code='HK' 
				and o_itr2.net_sales_in_local_curr >0))
				and (o_itr2.order_type in ('Normal Sales','Sales Return') or o_itr2.market_code='KR') -- to exclude redemption
				
				--AND (net_sales where ORDER_DT_WID in 2 years ago/2 years ago/R13-R24 AND 
				--S.signature_code=<brand signatrue code> and Purchase Channel='Online')>0
				
				and FORMAT_TIMESTAMP("%Y%m%d",o_itr2.order_date) between '20170101' and '20171231'
				--This date has to be decided
				--and FORMAT_TIMESTAMP("%Y%m%d",o_itr2.order_date) between  R1324_FROMDATE_CY and R1324_TODATE_CY
				and c.consumer_code=o_itr2.consumer_code
				
				and c_itr2.signature_code=c.signature_code
				and cc_itr2.channel_mode=cc.channel_mode
				)>0 
				
				and (
			select sum(o_itr3.net_sales_in_local_curr)  
			from `apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` o_itr3
			inner join `apmena-oneconsumer-dna-apac-qa.space_crm_1_2.dim_consumer_napac` c_itr3
			on c_itr3.consumer_code=o_itr3.consumer_code
			left join `apmena-oneconsumer-dna-apac-qa.crm_market_summary_parallel_run.counter_to_channel` cc_itr3
            ON o_itr3.counter_code = concat(cc_itr3.market_id,cc_itr3.counter_id)
			
			where  
				 /*((o_itr3.net_sales_in_local_curr >0) or
				(o_itr3.PROD_TYPE='YFG' 
				and o_itr3.market_code='HK' 
				and o_itr3.net_sales_in_local_curr >0))
				and (o_itr3.order_type in ('Normal Sales','Sales Return') or o_itr3.market_code='KR') -- to exclude redemption
				*/
				--AND (net_sales where ORDER_DT_WID in 2 years ago/2 years ago/R13-R24 AND 
				--S.signature_code=<brand signatrue code> and Purchase Channel='Online')>0
				
				FORMAT_TIMESTAMP("%Y%m%d",o_itr3.order_date) between '20180101' and '20181231'
				--This date has to be decided
				--FORMAT_TIMESTAMP("%Y%m%d",o_itr3.order_date) between R1324_FROMDATE_CY and R1324_TODATE_CY
				and c.consumer_code=o_itr3.consumer_code
				
				and c_itr3.signature_code=c.signature_code
				and cc_itr3.channel_mode=cc.channel_mode
				)<=0 
			
				 
		) as winback_cust
			group by signature_code,market_code,consumer_type,gender,channel_mode
	------------------------------------------------------------

	) where  market_code = dc_ot.market_code
		and signature_code = dc_ot.signature_code
		and consumer_type = dc_ot.consumer_type
		and gender = dc_ot.gender
		and channel_mode = cc_ot.channel_mode
		
)as winback_cust_ly






    FROM
	`apmena-oneconsumer-dna-apac-qa.space_crm_1_2.dim_consumer_napac` dc_ot 
	left join
	`apmena-oneconsumer-dna-apac-qa.space_crm_domain_fact_dim.fact_sales_napac3` fc_ot
    on dc_ot.consumer_code=fc_ot.consumer_code
	inner join
	`apmena-oneconsumer-dna-apac-qa.crm_market_summary_parallel_run.counter_to_channel` cc_ot
	ON fc_ot.counter_code = concat(cc_ot.market_id,cc_ot.counter_id)

	);
	set i = i + 1;
	END WHILE;

set k = k + 1;
END WHILE;