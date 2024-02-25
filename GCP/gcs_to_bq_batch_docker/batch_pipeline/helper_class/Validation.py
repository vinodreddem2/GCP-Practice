import logging
import apache_beam as beam

class validateRows(beam.DoFn):

    def __init__(self,schema):
        self.schema = schema
        
    def process(self, batch):

        valid_rows = []
        for element in batch:
            validated_row = self.validate_schema(element)
            if validated_row:
                # logging.info(f"validated row: {validated_row}")
                valid_rows.append(validated_row)
                # yield validated_row
        
        yield valid_rows


    def validate_schema(self, row):
        # Validate each row against the specified schema
        # You might need to customize this based on your actual schema
        table_schema = self.schema.get().split(";")
        # logging.info(f"table_schema : {table_schema}")
        if len(row) == len(table_schema):
            json_row = {field: value for field, value in zip(table_schema, row)}
            if json_row['store_and_fwd_flag'] == 'Y':
                json_row['store_and_fwd_flag'] = True
            else: 
                json_row['store_and_fwd_flag'] = False
            return json_row

        else:
            # Log or handle invalid rows
            logging.info(f"Invalid row: {row}")
