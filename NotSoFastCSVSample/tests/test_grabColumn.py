import pandas as pd
import numpy as np

df = pd.read_csv("2008_May.csv", usecols = ["ARR_DELAY"], na_filter=True)
df[~np.isnan(df["ARR_DELAY"])].to_csv("2008_May_col.txt", index=False)
