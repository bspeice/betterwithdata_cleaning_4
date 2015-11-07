#/usr/bin/env python

import argparse
import os, re, sys
import requests
import urllib
import pandas as pd

IMPORT_API_ENDPOINT = (
    'https://api.import.io/store/data/8a8c1017-a2ec-46b2-a20a-a7c711496ee8/_query'
    '?input/webpage/url={}'
    '&_user=303b474d-8ebb-45f1-aa94-27a7b1719366'
    '&_apikey=303b474d8ebb45f1aa9427a7b1719366818dc07c503b3c555038a8d03dae311e551744249d9a429177684fb0ecc415f942aece4a63b938b8d1c796f42a10114778c3182bc5556d245329e6dfcf9f7ad4'
)

MEPS_CODEBOOK = (
    'http://meps.ahrq.gov/mepsweb/data_stats/download_data_files_codebook.jsp'
    '?PUFId={}&varName={}'
)

def get_labels(PUFId, varName):
    """Loads the mapping of numeric IDs to labels of a categorical field"""

    meps_url = MEPS_CODEBOOK.format(PUFId, varName)
    import_url = IMPORT_API_ENDPOINT.format(urllib.quote(meps_url, safe=''))

    r = requests.get(import_url)
    labels = pd.DataFrame(r.json()['results'])
    labels = labels[labels['value_value'] != 'TOTAL']

    # Extract the int id
    labels[varName] = labels.value_value.str.split(' ').apply(lambda x: int(x[0]))
    # And the label
    labels[varName + '_label'] = labels.value_value.str.split(' ').apply(lambda x: ' '.join(x[1:]))

    return labels


def load_dictionary(dictfile):
    df = pd.read_csv(dictfile)
    return dict(zip(df.NAME, df.DESCRIPTION))


# hardcoded config of which file corresponds to which year.
YEAR_FILES = dict([('h{}e.csv'.format(idx), 2013-i) for i, idx in enumerate([160, 152, 144, 135, 126,  118,  110,  102,  94,
                                                                           85,  77,  67, 59,  51,  33,  26,  16,  10])]
                  + [('h{}f.csv'.format(idx), 2013-i) for i, idx in enumerate([160, 152, 144, 135, 126,  118,  110,  102,  94,
                                                                               85,  77,  67, 59,  51,  33,  26,  16,  10])])

if __name__ == '__main__':

    parser = argparse.ArgumentParser()
    parser.add_argument('--input-file')
    parser.add_argument('--output-dir')
    parser.add_argument('--column-dictionary')
    parser.add_argument('--category')
    args = parser.parse_args()

    infile = os.path.basename(args.input_file)
    puf_id = os.path.splitext(infile)[0].upper()

    raw_data = pd.read_csv(args.input_file)
    raw_data.columns = [x.upper() for x in raw_data.columns]

    for col in raw_data.columns:
        try:
            labels = get_labels(puf_id, col)
        except Exception,e :
            continue

        joined = raw_data.merge(labels, on=col)
        raw_data[col + '_label'] = joined[col + '_label']

    if args.column_dictionary:
        dictionary = load_dictionary(args.column_dictionary)
        srcs = dictionary.keys()
        for k in srcs:
            dictionary[k + '_label'] = dictionary[k] + '_label'

        raw_data.columns = [dictionary.get(col, col) for col in raw_data.columns]

    outfile = 'enriched_{}'.format(infile)
    if infile in YEAR_FILES:
        outfile = 'enriched_{}_{}'.format(YEAR_FILES[infile], infile)

    output = '{}/{}'.format(args.output_dir, outfile)

    raw_data.to_csv(output)
