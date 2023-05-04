

## 1. From Kaggle to S3

1.1 Create new EC2 instance manually. 

1.2 Insall the requiered libraries

```bash
sudo yum install pip
pip install pandas
pip install kaggle
pip install pyarrow
```

1.3 Create new token in kaggle (on site) and copy it on EC2

```bash
scp -i zoomcamp_key.pem kaggle.json ec2-user@<aws_host_name>:/home/ec2-user
mkdir ~/.kaggle
mv <source path> <destination path>
mv ~/Downloads/kaggle.json ~/.kaggle/kaggle.json
chmod 600 ~/.kaggle/kaggle.json
```

1.4. Download dataset from Kaggle
```
kaggle datasets download -d olistbr/brazilian-ecommerce
```

1.5. Create an IAM role with S3 write access or admin access and map it to an EC2 instance

1.6. Create a new bucket

```bash
 aws s3api create-bucket --bucket olist-data
```

1.7 Run a [script](transformation/format_to_parquet.py) to convert csv files to parqut and store on S3.
