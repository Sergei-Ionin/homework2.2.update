CREATE SEQUENCE public.authors_authors_id_seq
    MAXVALUE 1000;

ALTER SEQUENCE public.authors_authors_id_seq OWNER TO postgres;

CREATE TABLE IF NOT EXISTS public.readers
(
    reader_id       INTEGER GENERATED ALWAYS AS IDENTITY (MAXVALUE 10000)
        CONSTRAINT readers_pk
            PRIMARY KEY,
    reader_nomer    NUMERIC NOT NULL,
    reader_fullname VARCHAR NOT NULL,
    reader_adress   VARCHAR NOT NULL,
    reader_phone    NUMERIC
);

ALTER TABLE public.readers
    OWNER TO postgres;

CREATE TABLE IF NOT EXISTS public.isdat
(
    isdat_id   INTEGER GENERATED ALWAYS AS IDENTITY (MAXVALUE 1000)
        CONSTRAINT isdat_pk
            PRIMARY KEY,
    isdat_name VARCHAR NOT NULL,
    isdat_city VARCHAR NOT NULL
);

ALTER TABLE public.isdat
    OWNER TO postgres;

CREATE TABLE IF NOT EXISTS public.author_book
(
    book_id   INTEGER NOT NULL
        CONSTRAINT author_book_pk2
            UNIQUE,
    author_id INTEGER NOT NULL
        CONSTRAINT author_book_pk3
            UNIQUE,
    CONSTRAINT author_book_pk
        PRIMARY KEY (book_id, author_id)
);

ALTER TABLE public.author_book
    OWNER TO postgres;

CREATE TABLE IF NOT EXISTS public.book
(
    book_id    INTEGER GENERATED ALWAYS AS IDENTITY (MAXVALUE 1000000)
        CONSTRAINT book_pk
            PRIMARY KEY
        CONSTRAINT book_author_book_book_id_fk
            REFERENCES public.author_book (book_id),
    book_name  VARCHAR NOT NULL,
    book_list  NUMERIC NOT NULL,
    book_ex    NUMERIC NOT NULL,
    book_price NUMERIC NOT NULL,
    book_date  DATE    NOT NULL,
    book_isdat INTEGER NOT NULL
        CONSTRAINT book_isdat_isdat_id_fk
            REFERENCES public.isdat
);

ALTER TABLE public.book
    OWNER TO postgres;

CREATE TABLE IF NOT EXISTS public.cardbook
(
    cardbook_id     INTEGER GENERATED ALWAYS AS IDENTITY (MAXVALUE 1000000)
        CONSTRAINT cardbook_pk
            PRIMARY KEY,
    reader_id       INTEGER NOT NULL
        CONSTRAINT cardbook_readers_reader_id_fk
            REFERENCES public.readers,
    book_id         INTEGER NOT NULL
        CONSTRAINT cardbook_book_book_id_fk
            REFERENCES public.book,
    cardbook_date   DATE    NOT NULL,
    cardbook_return DATE
);

ALTER TABLE public.cardbook
    OWNER TO postgres;

CREATE TABLE IF NOT EXISTS public.authors
(
    author_id   INTEGER GENERATED ALWAYS AS IDENTITY (MAXVALUE 1000)
        CONSTRAINT authors_pk
            PRIMARY KEY
        CONSTRAINT authors_author_book_author_id_fk
            REFERENCES public.author_book (author_id),
    author_name VARCHAR NOT NULL
);

ALTER TABLE public.authors
    OWNER TO postgres;

ALTER SEQUENCE public.authors_authors_id_seq OWNED BY public.authors.author_id;


