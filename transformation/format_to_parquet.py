import argparse
import os
import pyarrow.csv as pv
import pyarrow.parquet as pt


def format_to_parquet(src_file, parquet_folder):
    if not src_file.endswith(".csv"):
        logging.error("Can only accept source files in CSV format, for the moment")
        return
    table = pv.read_csv(src_file)
    file_name = os.path.basename(src_file).replace(".csv", ".parquet")
    new_file_folder = os.path.basename(src_file).replace('.csv', '').replace('olist_', '').replace('_dataset', '')
    
    if not os.makedirs(os.path.join(parquet_folder, new_file_folder)):
        os.makedirs(os.path.join(parquet_folder, new_file_folder))
    pt.write_table(table, os.path.join(parquet_folder, new_file_folder, file_name))


def format_all_files_to_parquet(folder):
    csv_folder_path = os.path.abspath(folder)
    parquet_folder_path = os.path.join(os.path.dirname(csv_folder_path), 'olist_parquet')
    
    if not os.path.exists(parquet_folder_path):
        os.makedirs(parquet_folder_path)
        
    for file in os.listdir(csv_folder_path):
        format_to_parquet(os.path.join(csv_folder_path, file), parquet_folder_path)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Format csv to parquet')
    parser.add_argument('--folder', help='the csv file name')
    args = parser.parse_args()
    format_all_files_to_parquet(args.folder)