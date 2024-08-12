import os
import sys
import requests
from cachetools import cached, TTLCache
import time
import pandas as pd

@cached(cache=TTLCache(maxsize=1, ttl=36000))
def get_token():
    # step 1:  using username='30007'  password='2A4nFXhP' on https://mid.meddra.org/account/register for apikey
    # step 2:  apply for grant
    cmd = '''
    curl \
        --request POST \
        --data "grant_type=password"  \
        --data "username={username}"  --data "password={apikey}" \
        --data "scope=meddraapi" \
        --data "client_id=mspclient" \
        "https://mid.meddra.org/connect/token"
    '''.format(username='30007', apikey='4Lj68iPSy3jjti7hK2hM')
    auth = os.system(cmd)
    # ref: https://cloud.tencent.com/developer/article/1908468
    return auth['access_token']
    # {"access_token":"6acb65aaaa2eee65530de8e2521606b10051a5b8a5451bdf1227eb704bda080d","expires_in":36000,"token_type":"Bearer"}

def get_token2():
    return "046aaf87d52c7a9db338d28f532c9161efec4b03965fb22d7f85cd8e9066cd8f"

def get_soc(pt_name=None):
    ## (1) search pt name for pt-code
    headers = {
        'accept': 'application/json',
        'Authorization': 'Bearer {}'.format(get_token2()),
        'Content-Type': 'text/json',
    }

    pt_name = "heart valve operation"

    data = '{"bview":"SOC","rsview":"release","language":"English","stype":1,"addlangs":[],"filters":[],"version":24,"searchterms":[{"searchtype":0,"searchterm":"' \
           + pt_name + '","searchlogic":0}],"kana":false,"idiacritical":true,"synonym":false,"contains":false,"soc":false,"hlgt":false,"hlt":false,"pt":true,"llt":false,"smq":false,"skip":0,"take":0,"separator":2}'

    response = requests.post('https://gxpmapiprod.meddra.org/api/search', headers=headers, data=data)

    print(response)
    print(response.json())

    ##(2) detail: search soc name & code using pt_code
    pt_code = response.json()[0]['pcode']

    data = '{"bview":"SOC","rsview":"release","code":' + str(
        pt_code) + ',"pcode":0,"syncode":0,"lltcode":0,"ptcode":0,"hltcode":0,"hlgtcode":0,"soccode":0,"smqcode":0,"type":"PT","addlangs":[],"rtype":"P","lang":"English","ver":24,"kana":false,"separator":2}'

    response = requests.post('https://gxpmapiprod.meddra.org/api/detail', headers=headers, data=data)

    soc_name = ''
    soc_code = -1
    smq_code = -1


    for item in response.json()['mds']:
        #print(item)
        if item['primarysocfg'] == 'Y':
            soc_name = item['socname']
            soc_code = item['soccode']
            smq_code = item['smqcode']


    ## finally output results using dataframes
    return (pt_name, pt_code, soc_name, soc_code, smq_code)



#df.to_excel()
#send_email()

pt_list = pd.read('/Users/liuhaoran/PycharmProjects/mysql_output/Out_64__sort_values_by__Out_64__columns_1____ascending__False_.csv')
result = []

for row in pt_list.iterrows():
    result.append(get_soc(row['pt']))

df = pd.DataFrame(result);
df.to_csv('/Users/liuhaoran/PycharmProjects/mysql_output/pt_soc_mapping.csv');