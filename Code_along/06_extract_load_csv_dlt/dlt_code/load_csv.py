import dlt
import pandas as pd
from pathlib import Path
import os


#used for extracting data from source, in this case a local csv file
# använder för att visa vilken data vi vill ha som datasource.
# vi declarar en funktion som läser in csv filen och returnerar en dataframe.
# 1. dlt resource objekt. 2. read csv file med pandas. 3. yeild dataframe.
@dlt.resource(write_disposition="replace")
def load_csv_resource(file_path: str, **kwargs):
    df = pd.read_csv(file_path, **kwargs)
    yield df


if __name__ == "__main__":
    #need to change to current working directory as this is where
    # dlt looks for .dlt and when using the play button in vscode
    # it will run from where you are in the terminal, not neccessarily
    # where this script is resided
    working_directory = Path(__file__).parent

    #if you are using files from .dlt, 
    # the working directory should be the direct parent of .dlt folder
    os.chdir(working_directory)
    csv_path = working_directory / "data" / "NetflixOriginals.csv"
    data = load_csv_resource(csv_path, encoding="latin1")
    print(data)
    # skapar en dlt pipeline som laddar data till snowflake. dlt.pipline är funktionen som skapar piplinen, den letar under secrets.toml efterdestination och credentials.
    # vi ger även pipleninen ett namn och datasetet ett namn.
    pipeline = dlt.pipeline(
        pipeline_name='movies',
        destination="snowflake",
        dataset_name='staging'
        )
    
    # kör piplinen med data som vi vill ladda och ger tabellen ett namn. 
    load_info = pipeline.run(data, table_name="netflix")

    # pretty print the information on data that was loaded
    print(load_info)