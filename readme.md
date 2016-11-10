# Lake Pend Oreille data project

This project uses the static version of the data as found in the [LPO_weatherdata repository](https://github.com/lyndadotcom/LPO_weatherdata).


## Dependencies

- Python 2.7.x
- Postgres 9.1.x
- python-psycopg2 2.4.x

## Usage

First run the python script to aggregate the data in a single file running:

    python import_data.py

Then simply run the `raw_data.sql` script to create the database, tables and populate the data. This should be done by a user with postgres privileges, for example the `postgres` user:

    sudo -i -u postgres
    psql -f raw_data.sql

By this point all the data should be properly stored in the database.


## To Do

- Create a GUI.
    - Check [Caravel](https://github.com/airbnb/superset) and [D3](https://d3js.org/)
