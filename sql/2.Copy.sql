COPY sales
FROM 's3://my-bucket/dados/sales.csv'
credentials 'aws_access_key_id=my-key; aws_secret_access_key=my-secret'
region 'sa-east-1'
delimiter ';'
IGNOREHEAD 1
DATEFORMAT 'DD/MM/YYYY';