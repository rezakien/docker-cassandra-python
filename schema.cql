CREATE KEYSPACE IF NOT EXISTS topic_modeling
  WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 3 };

USE topic_modeling;

CREATE TABLE IF NOT EXISTS disciplines (
  id timeuuid,
  name_discipline text,
  content text,
  PRIMARY KEY(id)
) WITH comment = 'Table with all disciplines';

CREATE TABLE IF NOT EXISTS words (
 word text,
 postag text,
 PRIMARY KEY(word)
) WITH comment = 'Table with all words';

CREATE TABLE IF NOT EXISTS disciplines_words (
 id timeuuid,
 name_discipline text,
 word text,
 postag text,
 count_in int,
 PRIMARY KEY((id, name_discipline, word), count_in)
) WITH CLUSTERING ORDER BY (count_in ASC);

INSERT INTO disciplines(id,name_discipline,content) VALUES (now(),'ИХБД','Содержание дисциплины ИХБД...');
INSERT INTO disciplines(id,name_discipline,content) VALUES (now(),'АСОБД','Содержание дисциплины ИХБД...');
INSERT INTO disciplines(id,name_discipline,content) VALUES (now(),'ММО','Содержание дисциплины ММО...');
INSERT INTO disciplines(id,name_discipline,content) VALUES (now(),'КСМО','Содержание дисциплины КСМО...');

INSERT INTO words(word,postag) VALUES ('Слово1','N');
INSERT INTO words(word,postag) VALUES ('Слово2','NN');
INSERT INTO words(word,postag) VALUES ('Слово3','N');
INSERT INTO words(word,postag) VALUES ('Слово4','NN');

INSERT INTO disciplines_words(id,name_discipline,word,postag,count_in) VALUES (now(),'ИХБД','Слово2','NN', 15);
INSERT INTO disciplines_words(id,name_discipline,word,postag,count_in) VALUES (now(),'ИХБД','Слово2','NN', 15);
INSERT INTO disciplines_words(id,name_discipline,word,postag,count_in) VALUES (now(),'АСОБД','Слово2','NN', 5);
INSERT INTO disciplines_words(id,name_discipline,word,postag,count_in) VALUES (now(),'ММО','Слово2','NN', 2);
INSERT INTO disciplines_words(id,name_discipline,word,postag,count_in) VALUES (now(),'КСМО','Слово2','NN', 1);