#Usage: python kegg_tax_count.py -i /home/sam/Nat_Comms -l kegg_focused_list

import os
import argparse
import pandas as pd
import numpy as np

parser = argparse.ArgumentParser()
parser.add_argument("-i", "--input_dir", help="Full file path to kegg input files")
parser.add_argument("-l", "--kegg_list", help="List of KO numbers to search for")

args = parser.parse_args()

print( "Input_directory {}\n KEGG_list {} ".format(
        args.input_dir,
        args.kegg_list,
        ))

#Convert search file to list
query_list = []
with open(os.path.join(args.input_dir, args.kegg_list)) as query_input:
        for line in query_input:
                query_list.append(line.strip("\n"))

#Read in kofamscan output from detailed run
kegg_files = [file for file in os.listdir(args.input_dir) if file.endswith("kegg_output")]

for kegg_file in kegg_files:
   output_file = kegg_file+"_reliable"
   output = open(args.input_dir+"/"+output_file,'a')
   for line in open(args.input_dir+"/"+kegg_file):
      if line.startswith('*'):
         output.write(line)
   output.close()

reliable_kegg_file = [file for file in os.listdir(args.input_dir) if file.endswith("_reliable")]

for rel_file in reliable_kegg_file:
	kegg_df = pd.read_csv(args.input_dir+"/"+rel_file,sep = '\t',usecols=[1,2],names=["Gene","KO"])
	kegg_df.drop_duplicates(keep='first',inplace=True)
	kegg_df['Chr'] = kegg_df['Gene'].str.split('_').str[:-1].str.join('_')
	tax_file = args.input_dir+"/"+rel_file.replace("_bacterial_only_kegg_output_reliable", ".taxonomy.tsv")
	tax_df = pd.read_csv(tax_file,sep = '\t',header=0)
	tax_df.rename({'contig': 'Chr'}, axis=1, inplace=True)
	control_df = pd.merge(kegg_df, tax_df, on='Chr')
	taxa = ['phylum', 'class', 'order','family']
	control_df['Family_full_tax'] = control_df[taxa].apply(lambda row: '_'.join(row.values.astype(str)), axis=1) + "_"+rel_file.replace("_bacterial_only_kegg_output_reliable", "")
	kegg_tax_df = control_df[['KO','Family_full_tax']]
	subset_df = kegg_tax_df[kegg_tax_df['KO'].isin(query_list)]
	kegg_tax_count_df = subset_df.pivot_table(index='Family_full_tax', columns='KO', aggfunc=len, fill_value=0)
	kegg_tax_count_df_transp = kegg_tax_count_df.transpose()
	output = rel_file.replace("_bacterial_only_kegg_output_reliable", "_kegg_tax_count.tsv")
	kegg_tax_count_df_transp.to_csv(args.input_dir+'/'+output, sep='\t', index=True)