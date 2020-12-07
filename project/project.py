import pandas as pd
import psycopg2
import streamlit as st
from configparser import ConfigParser
'''
# Welcome to Shang Ke & Tengri Zhang's DB Project 
We will showcase some database functions here.
'''

@st.cache
def get_config(filename='database.ini', section='postgresql'):
    parser = ConfigParser()
    parser.read(filename)
    return {i: j for i, j in parser.items(section)}

@st.cache
def query_db(sql: str):
    db_info = get_config()
    # Connect to an existing database
    conn = psycopg2.connect(**db_info)
    # Open a cursor to perform database operations
    cur = conn.cursor()
    # Execute a command: this creates a new table
    cur.execute(sql)
    # Obtain data
    data = cur.fetchall()
    column_names = [desc[0] for desc in cur.description]
    # Make the changes to the database persistent
    conn.commit()
    # Close communication with the database
    cur.close()
    conn.close()
    df = pd.DataFrame(data=data, columns=column_names)
    return df

'## See All Tables'
sql_all_table_names = "select relname from pg_class where relkind='r' and relname !~ '^(pg_|sql_)';"
all_table_names = query_db(sql_all_table_names)['relname'].tolist()
table_name = st.selectbox('Choose a table', all_table_names)
if table_name:
    f'Display the table'
    sql_table = f'select * from {table_name};'
    df = query_db(sql_table)
    st.dataframe(df)

'## Query Books'

sql_book_names = 'select name from books;'
book_names = query_db(sql_book_names)['name'].tolist()
book_name = st.selectbox('Choose a book', book_names)
if book_name:
    sql_book = f"select * from books where name='{book_name}';"
    book_info = query_db(sql_book).loc[0]
    sql_author = f"select * from written_by W join authors A on W.author=A.id where W.isbn = '{book_info['isbn']}';"
    author_info = query_db(sql_author).loc[0]
    b_name,b_year,b_genre,b_publisher,b_stock=book_info['name'],book_info['year'],book_info['genre'],book_info['publisher'],book_info['stock']
    a_name,a_country=author_info['name'],author_info['country']
    st.write(f"{b_name} is a book about {b_genre}, published by {b_publisher} in {b_year}.")
    st.write(f"{b_name} is written by {a_name} who lives in {a_country}.")
    st.write(f"There are currently {b_stock} copies available.")

'## Query Movies'

sql_movie_names = 'select name from movies;'
movie_names = query_db(sql_movie_names)['name'].tolist()
movie_name = st.selectbox('Choose a movie', movie_names)
if movie_name:
    sql_movie = f"select * from movies where name='{movie_name}';"
    movie_info = query_db(sql_movie).loc[0]
    sql_actor = f"select * from starred_by S join actors A on S.aid=A.id where S.mid = '{movie_info['id']}';"
    m_name,m_year,m_genre,m_director,m_stock=movie_info['name'],movie_info['year'],movie_info['genre'],movie_info['director'],movie_info['stock']
    st.write(f"{m_name} is a {m_genre} movie, directed by {m_director} in {m_year}.")
    actor_infos = query_db(sql_actor)
    actor_names=actor_infos['name'].tolist()
    actor_countries=actor_infos['country'].tolist()
    st.write(f"This movie is acted by the following actors:  ")
    for i in range(len(actor_names)):
        st.write(f"{actor_names[i]} who is from {actor_countries[i]}.")
    st.write(f"There are currently {m_stock} DVDs available.")
'## Query Albums'

sql_album_names = 'select name from albums;'
album_names = query_db(sql_album_names)['name'].tolist()
album_name = st.selectbox('Choose an album', album_names)
if album_name:
    sql_album = f"select * from albums where name='{album_name}';"
    album_info = query_db(sql_album).loc[0]
    sql_artist = f"select * from created_by C join artists A on C.artist=A.id where C.album = '{album_info['id']}';"
    artist_info = query_db(sql_artist).loc[0]

    a_name,a_year,a_genre,a_stock=album_info['name'],album_info['year'],album_info['genre'],album_info['stock']
    ar_name,ar_country=artist_info['name'],artist_info['country']
    st.write(f"{a_name} is an {a_genre} album sang by {ar_name} from {ar_country} in {a_year} .")
    sql_track = f"select AT.name from album_tracks AT join albums A on AT.id=A.id where A.name = '{album_name}';"
    track_infos = query_db(sql_track)
    track_names=track_infos['name'].tolist()

    sql_tracknum=f"select count(*) num from album_tracks where id={album_info['id']} group by id;"
    track_num= query_db(sql_tracknum).loc[0]

    st.write(f"This album has the following {track_num['num']} tracks:  ")

    for track_name in track_names:
        st.write(f"{track_name}")
    st.write(f"There are currently {a_stock} DVDs available.")

