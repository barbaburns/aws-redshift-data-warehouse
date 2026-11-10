COPY sales
FROM 's3://my-bucket/dados/sales.csv'
CREDENTIALS 'aws_access_key_id=my-key;aws_secret_access_key=my-secret'
REGION 'sa-east-1'
DELIMITER ';'
IGNOREHEADER 1
DATEFORMAT 'DD/MM/YYYY';