import re
import apache_beam as beam
import logging

from datetime import datetime


class ValidateCSVRow(beam.DoFn):
    def __init__(self, schema, date_format="%Y-%m-%d"):
        self.schema = schema
        self.date_format = date_format
        self.bq_column_names = ['customer_id', 'store_id', 'first_name', 'last_name', 'email',
                                'is_active', 'birth_day', 'birth_month', 'birth_year', 'create_date',
                                'last_update_date']

        logging.info(f"schema:{self.schema}")

    def process(self, element):
        # Split the CSV row into fields
        logging.info(f"element:{element}")
        fields = element.split(',')

        # Validate the number of fields

        if len(fields) != len(self.schema):
            logging.info(f"Invalid row: {element}")
            return

        # Validate each field based on the schema
        for i, (field, expected_type) in enumerate(zip(fields, self.schema)):
            if expected_type == datetime:
                try:
                    # Convert the field to the expected type
                    if len(field):
                        converted_value = datetime.strptime(field, self.date_format)

                except ValueError:
                    logging.info(f"Invalid value in field {i + 1}: {element}")
                    return

            elif expected_type == bool:
                # Convert the field to the expected type
                if not str(field).lower() in ["true", "false", '']:
                    logging.info(f"Invalid value in field {i + 1}: {element}")
                    return

            else:
                try:
                    # Convert the field to the expected type
                    converted_value = expected_type(field)

                except ValueError:
                    logging.info(f"Invalid value in field {i + 1}: {element}")
                    return

                    # If the row passes all validations, yield it

        bq_row_values = re.split(",", re.sub('\r\n', '', re.sub('"', '', element)))

        bq_row = dict(zip(self.bq_column_names, bq_row_values))

        logging.info(f"bq_row before : {bq_row}")

        if bq_row.get('create_date') == '':
            bq_row['create_date'] = None

        if bq_row.get('last_update_date') == '':
            bq_row['last_update_date'] = None

        if bq_row.get('is_active') == '':
            bq_row['is_active'] = None

        logging.info(f"bq_row after: {bq_row}")
        yield bq_row