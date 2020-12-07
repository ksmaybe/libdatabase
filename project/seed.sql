select * from written_by W join authors A on W.author=A.id;
select * from books;

select * from written_by W join authors A on W.author=A.id where W.isbn = '{book_info['isbn']}';
select * from written_by W join authors A on W.author=A.id where W.isbn = '9781483184043';


streamlit run project.py --server.address=localhost --server.port=8514
select * from album_tracks AT join albums A on AT.id=A.id
