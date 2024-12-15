# coding: utf-8
# author: Kun Shi
# date: 2019/04/01
import os
import warnings
import pandas as pd
import numpy as np

pd.set_option('display.max_rows', 500)
pd.set_option('display.max_columns', 50)

# local directory to save files.
directoryPath = "/Users/liuhaoran/PycharmProjects/Faers/data/FAERS_DATA/"
#directoryPath = os.getcwd() + '/' + data_dir
faers_data_type = ['demo', 'drug', 'reac', 'outc', 'ther', 'indi', 'rpsr']

# ignore warnings
warnings.filterwarnings('ignore')


## 通过迅雷下载得到原始文件
def get_file_list(directoryPath):
    all_faers_data = []
    for root, dirs, files in os.walk(directoryPath):
        for filename in files:
            print(filename)
            if filename[:4].lower() in faers_data_type and \
                    filename.lower().endswith('.txt') and \
                    not filename.lower().startswith('.'):
                file_path = os.path.join(root, filename)
                all_faers_data.append(file_path)
    return sorted(all_faers_data)


## global variable: 文件列表
filelist = get_file_list(directoryPath)


#filelist = ['/Users/liuhaoran/PycharmProjects/Faers/data/FAERS_DATA/faers_ascii_2018Q1/ascii/DEMO18Q1_new.txt',]#
#filelist = ['/Users/liuhaoran/PycharmProjects/Faers/data/FAERS_DATA/faers_ascii_2017Q4/ascii/REAC17Q4.txt']
def processDemo():
    def process_age(row):
        # process age
        # demo_df = demo_df[pd.notnull(demo_df['age'])]
        # unified age unit
        #demo_df['age'] = demo_df['age'].apply(pd.to_numeric, errors='coerce')
        try:
            age = float(row['age'])
        except:
            return '无'
        finally:
            pass

        if row['age_cod'] == 'DEC':  # decade
            return age * 10
        elif row['age_cod'] == 'YR' or row['age_cod'] == '' or row['age_cod'] == ' ':  # Default: Year
            return age
        elif row['age_cod'] == 'MON':  # mounth
            return age * 1 / 12
        elif row['age_cod'] == 'WK':  # week
            return age * 1 / 52
        elif row['age_cod'] == 'DY':  # day
            return age * 1 / 365
        elif row['age_cod'] == 'HR':  # hour
            return age * 1 / 8760
        else:
            return row['age_cod']

    def process_weight(row):
        #demo_df = demo_df[pd.notnull(demo_df['wt'])]
        # unified weight unit
        #demo_df['wt'] = demo_df['wt'].apply(pd.to_numeric, errors='coerce')
        #demo_df['wt'] = np.where(demo_df['wt_cod'] == 'LBS', demo_df['wt'] * 0.453592, demo_df['wt'])  # pounds
        #demo_df['wt'] = np.where(demo_df['wt_cod'] == 'GMS', demo_df['wt'] * 0.001, demo_df['wt'])  # grams
        #demo_df = demo_df.drop(['wt_cod'], axis=1)
        # weight discretization and label encode
        #wt_bins = [0, 5, 10, 40, 50, 60, 70, 80, 90, 100, 150, 200, 300]
        #demo_df['wt'] = pd.cut(demo_df.wt, wt_bins, labels=[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12])

        try:
            weight = float(row['wt'])
        except:
            return '无'
        finally:
            pass

        if row['wt_cod'] == 'LBS':  # LBS
            return weight * 0.453592
        elif row['wt_cod'] == 'GMS':  # GMS
            return weight * 0.001
        else:
            return weight

    for filename in filelist:
        if "DEMO" in filename.upper() and "TXT" in filename.upper():
            print("Now processing " + filename)
            demo_df = pd.read_csv(filename, low_memory=False, sep='$', on_bad_lines='skip')
            #print(demo_df.describe())
            # keep primaryid, caseid, age, sex, wt
            demo_df.drop(
                ['lit_ref', 'auth_num', 'age_grp', 'e_sub',
                 'to_mfr', 'rept_cod', 'mfr_num',
                 'mfr_sndr'], inplace=True, axis=1, errors='ignore')

            # process sex
            ##demo_df['sex'] = demo_df['sex'].fillna('UNK')
            ##sex_map = {'M': "0", 'F': "1", 'UNK': "2"}
            ##demo_df['sex'] = demo_df['sex'].map(sex_map)

            ## process age
            demo_df['age']= demo_df['age'].apply(lambda x: '无' if pd.isna(x) or pd.isnull(x) else x)
            demo_df['age'] = demo_df.apply(process_age, axis=1)
            demo_df = demo_df.drop(['age_cod'], axis=1)

            # age discretization and label encode
            # Newborn, Infant, Child Preschool, Child, Adolescent, Young Adult, Adult,Middle Aged, Aged, Aged+
            #age_bins = [0, 1, 2, 5, 12, 18, 24, 44, 64, 79, 123]
            #demo_df['age'] = pd.cut(demo_df.age, age_bins, labels=[1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
            # demo_df = demo_df.dropna(axis=0, subset=["age"])  # drop unreasonable age <0 or >123

            # process weight(wt)
            demo_df['wt'] = demo_df['wt'].apply(lambda x: '无' if pd.isna(x) or pd.isnull(x) else x)
            demo_df['wt'] = demo_df.apply(process_weight, axis=1)
            demo_df = demo_df.drop(['wt_cod'], axis=1)
            ## drop rows, be very careful
            #demo_df = demo_df.dropna(axis=0, subset=["wt"])  # drop unreasonable weight <0 or >300

            # save file & check
            demo_df.to_csv(filename[:-4] + '.csv', header=True, index=False)
            #print(demo_df[demo_df['primaryid'] == 141664221])


def processDrug():
    for filename in filelist:
        if "DRUG" in filename.upper() and "TXT" in filename.upper():
            print("Process " + filename)
            drug_df = pd.read_csv(filename, encoding='utf-8', low_memory=False, sep="$", on_bad_lines='skip')

            # keep primaryid, caseid, role_cod, drugname
            drug_df.drop(
                ['val_vbm', 'dose_vbm', 'dose_form', 'dose_amt', 'dose_unit', 'cum_dose_chr',
                 'cum_dose_unit', 'dechal', 'rechal', 'lot_num', 'exp_dt', 'nda_num', 'route', 'dose_freq'],
                inplace=True, axis=1, errors='ignore')

            # process role_cod label encode
            #drug_df = drug_df[pd.notnull(drug_df['role_cod'])]
            #rolecod_map = {'PS': '0', 'SS': '1', 'C': '2', 'I': '3'}
            #drug_df['role_cod'] = drug_df['role_cod'].map(rolecod_map)

            # process drugname
            drug_df = drug_df[pd.notnull(drug_df['drugname'])]
            drug_df['drugname'] = drug_df['drugname'].str.strip().str.lower()  # to lowercase
            drug_df = drug_df[~drug_df['drugname'].isin(['unknown'])]  # drop unknown
            drug_df['drugname'] = drug_df['drugname'].str.replace('\\', '/')  # fix slashes
            drug_df['drugname'] = drug_df['drugname'].map(
                lambda x: x[:-1] if str(x).endswith(".") else x)  # fix ending with period

            # save file
            drug_df.to_csv(filename[:-4] + '.csv', header=True, index=False)


def processReac():
    import csv
    # 文件路径
    file_path = '/Users/liuhaoran/PycharmProjects/Faers/结果文件/merged_pt_soc.csv'
    # 初始化一个空字典来存储 key 和 value 对
    PT_SOC_MAPPING = {}
    PT_SOC_CODE_MAPPING = {}
    # 打开CSV文件
    with open(file_path, mode='r', encoding='utf-8') as csvfile:
        # 创建一个 csv reader 对象
        reader = csv.reader(csvfile)
        # 遍历CSV文件中的每一行
        for row in reader:
            # 检查行是否有足够的列
            if len(row) >= 3:
                # 将 key 和 value 从每行中提取出来，并将它们添加到字典中
                pt = row[0]  # 假设 key 是第一列
                soc_name = row[2]  # 假设 value 是第二列
                soc_code = row[3]  # 假设 value 是第二列

                PT_SOC_MAPPING[pt] = soc_name
                PT_SOC_CODE_MAPPING[pt] = soc_code
    # 打印结果字典
    print(len(PT_SOC_MAPPING))

    for filename in filelist:
        if "REAC" in filename.upper() and "TXT" in filename.upper():
            print("Process " + filename)
            reac_df = pd.read_csv(filename, low_memory=False, sep="$", on_bad_lines='skip')

            # keep primaryid, caseid, pt
            reac_df.drop(['drug_rec_act'], inplace=True, axis=1, errors='ignore')

            # process pt
            #reac_df = reac_df[pd.notnull(reac_df['pt'])]
            reac_df['pt'] = reac_df['pt'].str.strip().str.lower()  # to lowercase
            # reac_df = reac_df[~reac_df['pt'].isin(['unknown'])]  # drop unknown
            reac_df['pt'] = reac_df['pt'].map(
                lambda x: x[:-1] if str(x).endswith(".") else x)  # fix ending with period

            # process soc
            reac_df['soc'] = reac_df['pt'].map(
                lambda x: PT_SOC_MAPPING[x] if x in PT_SOC_MAPPING else 'UNKNOWN_SOC')  # 查询得到SOC
            reac_df['soc_code'] = reac_df['pt'].map(
                lambda x: PT_SOC_CODE_MAPPING[x] if x in PT_SOC_MAPPING else 'UNKNOWN_SOC_CODE')  # 查询得到SOC_CODE

            # save file
            reac_df.to_csv(filename[:-4] + '.csv', header=True, index=False)


def processOutc():
    for filename in filelist:
        if "OUTC" in filename.upper() and "TXT" in filename.upper():
            print("Process " + filename)
            outc_df = pd.read_csv(filename, low_memory=False, sep="$", on_bad_lines='skip')

            # process outc_cod
            #outc_df = outc_df[pd.notnull(outc_df['outc_cod'])]
            #outc_df = outc_df[outc_df['outc_cod'].isin(['DE', 'LT', 'HO', 'DS', 'CA', 'RI', 'OT'])]
            #outccod_map = {'DE': '0', 'LT': '1', 'HO': '2', 'DS': '3', 'CA': '4', 'RI': '5', 'OT': '6'}
            #outc_df['outc_cod'] = outc_df['outc_cod'].map(outccod_map)

            # save file
            outc_df.to_csv(filename[:-4] + '.csv', header=True, index=False)


def main():
    #print(filelist)
    #processDemo()
    #processDrug()
    processReac()
    #processOutc()


if __name__ == '__main__':
    main()
