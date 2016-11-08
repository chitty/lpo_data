# Lake Pend Oreille data project

This project uses the static version of the data as found in the [LPO_weatherdata repository](https://github.com/lyndadotcom/LPO_weatherdata).

## Dependencies

- Postgres
- python-psycopg2

## Usage

After having the dependencies installed, simply run the `raw_data.sql` script to create the database, tables and populate the data. This should be done by a user with postgres priviledge, for example the `postgres` user:

    sudo -i -u postgres
    psql -f raw_data.sql


## To Do

- Create a GUI.
    - Check [Caravel](https://github.com/airbnb/superset) and [D3](https://d3js.org/)
