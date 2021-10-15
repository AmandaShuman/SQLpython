# %%
import sqlite3
import pandas as pd
# %%
# creates connection to database
con = sqlite3.connect('sakila.db')
# %%
# function to query database
def sql_to_df(sql_query):
    # takes in query and uses pandas to get dataframe
    df = pd.read_sql(sql_query, con)
    return df


# %%
query = '''
    SELECT *
    FROM sqlite_master
    WHERE type = 'table';
'''

tables = sql_to_df(query)
tables
# %%
query = '''
    SELECT first_name, last_name
    FROM customer
'''

customer_names = sql_to_df(query)
customer_names
# %%
# if you just want to see the first few results
print(customer_names.head())
# %%
# if you want to see the last few results
print(customer_names.tail())
# %%
# ask pandas to describe data for quick summary
print(customer_names.describe())
# %%
# get more info 
print(customer_names.info())
# %%
query = '''
    SELECT * 
    FROM film
    WHERE description
    LIKE '%Pastry%'
'''

pastry_films = sql_to_df(query)
pastry_films.describe()
# %%
# gives full list of columns
pastry_films
# %%
query = '''
    SELECT
        COUNT(title) AS Count,
        rating AS Rating
    FROM film
    WHERE description
    LIKE '%Pastry%'
    GROUP BY rating
    ORDER BY Count DESC;
'''

pastry_films_by_rating = sql_to_df(query)
pastry_films_by_rating
# %%
# prints off a histogram of the data
pastry_films_by_rating.hist(column='Count', grid=False)
# %%
