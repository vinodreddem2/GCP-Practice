INSERT INTO `apmena-oneconsumer-dna-apac-qa.space_crm_domain.dim_consumer`
(
consumer_code,
market_code,
signature_code,
source_signature_id,
MARS_PERSON_ID,
LUCID,
YEAR_OF_BIRTH,
consumer_type,
is_consumer_flag,
is_valid_direct_message,
is_opt_in_direct_message,
is_valid_email,
is_opt_in_email,
is_valid_home_phone,
is_opt_in_home_phone,
is_valid_mobile,
is_opt_in_call,
is_opt_in_sms,
is_valid_line,
is_opt_in_line,
is_whatsapp_contactable,
is_we_chat_contactable,
load_ts
)
(
select
CONCAT(SUBSTR(ltrim(rtrim(a.brand_code)), 1,2),'',a.CUSTOMER_ROW_ID) as consumer_code,
SUBSTR(ltrim(rtrim(a.brand_code)), 1,2) as market_code,
H.compass_signature_code as signature_code,
z.signature_code as source_signature_id,
--SUBSTR(brand_code, 5,6) as counter_signature_code,
a.MARS_PERSON_ID,
CASE 
	WHEN SUBSTR(ltrim(rtrim(a.brand_code)), 1,2)='AU' THEN CONCAT(SUBSTR(ltrim(rtrim(a.brand_code)), 1,2),'',EMAIL)
	WHEN SUBSTR(ltrim(rtrim(a.brand_code)),1,2) in ('TH', 'MY', 'SG') THEN CONCAT(SUBSTR(ltrim(rtrim(a.brand_code)),1,2),'',a.MOBILE)
	ELSE ''
END AS LUCID,
SUBSTR(a.BIRTHDAY,1,5) AS YEAR_OF_BIRTH,
a.CUSTOMER_TYPE_LOCAL_TOURIST AS consumer_type ,
cast(a.CUSTOMER_FLAG AS string) as is_consumer_flag,
"N" AS is_valid_direct_message,
"N" AS is_Opt_In_direct_message,
cast(a.valid_email as string ) as is_valid_email,
cast(a.opt_in_email as string) as is_opt_in_email,
cast(a.Valid_Home as string ) as is_valid_home_phone,
cast(a.opt_in_home_call as string) as is_opt_in_home_phone,
cast(a.Valid_Mobile as string) as is_valid_mobile,
cast(a.opt_in_mobile_call as string) as is_opt_in_call,
cast(a.Opt_In_SMS as  string) as is_opt_in_sms,
"N" AS is_Valid_Line,
"N" AS is_Opt_In_Line,
"N" AS is_whatsapp_contactable,
"N" AS is_we_chat_contactable,
a._PARTITIONTIME  as load_ts
FROM 
`apmena-oneconsumer-dna-apac-qa.crm_market_summary_parallel_run.MDB_CUSTOMER_VW` a
INNER JOIN 
`apmena-oneconsumer-dna-apac-qa.crm_market_summary_parallel_run.MDB_ORDER_VW` b on a.CUSTOMER_ROW_ID=cast(b.CUSTOMER_ID as string)
LEFT JOIN 
`apmena-oneconsumer-dna-apac-qa.crm_market_summary_parallel_run.MDB_PRODUCT_VW` c on c.product_row_id=b.product_id
LEFT JOIN
`apmena-onedata-dna-apac-qa.product.dim_sap_product`J on c.SAP_CODE=J.sap_product_code
LEFT JOIN 
`apmena-onedata-dna-apac-qa.product.dim_compass_product` H on J.sap_orig_reference_code=H.sap_reference_code and H.compass_division_code='LLD'
INNER JOIN 
`apmena-oneconsumer-dna-apac-dv.crm_market_summary_data.counter_to_channel` z on z.counter_id =b.COUNTER_ID
--LEFT JOIN
--`apmena-oneconsumer-dna-apac-dv.crm_prod_data.signature` S on a.BRAND_CODE=S.integration_id
)