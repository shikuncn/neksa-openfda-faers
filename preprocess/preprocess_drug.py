# coding: utf-8
# author: Jing Li
# date: 2019/04/01
import os
import warnings
import pandas as pd
import numpy as np
directoryPath = '/Users/liuhaoran/PycharmProjects/Faers/data/FAERS_DATA/faers_ascii_2018Q1/ascii'
def processDrug():
    for filename in os.listdir(directoryPath):
        if "DRUG" in filename.upper() and "TXT" in filename.upper():
            print("Process " + filename)
            drug_df = pd.read_csv(directoryPath + "/" + filename, low_memory=False, sep="$", error_bad_lines=False)

            # keep primaryid, caseid, role_cod, drugname
            drug_df.drop(
                ['drug_seq', 'val_vbm', 'dose_vbm', 'dose_form', 'dose_amt', 'dose_unit', 'cum_dose_chr', 'prod_ai',
                 'cum_dose_unit', 'dechal', 'rechal', 'lot_num', 'exp_dt', 'nda_num', 'route', 'dose_freq'],
                inplace=True, axis=1, errors='ignore')

            # process role_cod label encode
            drug_df = drug_df[pd.notnull(drug_df['role_cod'])]
            rolecod_map = {'PS': '0', 'SS': '1', 'C': '2', 'I': '3'}
            drug_df['role_cod'] = drug_df['role_cod'].map(rolecod_map)

            # process drugname
            drug_df = drug_df[pd.notnull(drug_df['drugname'])]
            drug_df['drugname'] = drug_df['drugname'].str.strip().str.lower()  # to lowercase
            drug_df = drug_df[~drug_df['drugname'].isin(['unknown'])]  # drop unknown
            drug_df['drugname'] = drug_df['drugname'].str.replace('\\', '/')  # fix slashes
            drug_df['drugname'] = drug_df['drugname'].map(
                lambda x: x[:-1] if str(x).endswith(".") else x)  # fix ending with period

            # save file
            drug_df.to_csv(directoryPath + "/" + filename[:-4] + '.csv', header=True, index=False)
