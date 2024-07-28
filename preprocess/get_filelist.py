# coding: utf-8
# author: Jing Li
# date: 2019/04/01

import os
import re
import lxml
import time
import shutil
import warnings
import requests
from tqdm import tqdm
from io import BytesIO
from zipfile import ZipFile
from datetime import datetime
from bs4 import BeautifulSoup
from urllib.request import urlopen

# this script will find target in this list pages.
target_page = ["https://fis.fda.gov/extensions/FPD-QDE-FAERS/FPD-QDE-FAERS.html"]

def getFilesUrl():
    """
    find all web urls in target page.
    :return: dict files = {"name":"url"}
    """
    print("Get web urls.\t")
    files = {}
    for page_url in target_page:
        try:
            request = urlopen(page_url)
            page_bs = BeautifulSoup(request, "lxml")
            request.close()
        except:
            request = urlopen(page_url)
            page_bs = BeautifulSoup(request)
        for url in page_bs.find_all("a"):
            a_string = str(url)
            if "ASCII" in a_string.upper():
                t_url = url.get('href')
                files[str(url.get('href'))[-16:-4]] = t_url

    # save urls to FaersFilesWebUrls.txt
    save_path = os.getcwd() + "/FaersFilesWebUrls.txt"
    if (os.path.exists(save_path)):
        os.remove(save_path)
    with open(save_path, 'a+') as f:
        for k in files.keys():
            f.write(k + ":" + files[k] + "\n")

    print("Done!")
    return files


print(getFilesUrl())