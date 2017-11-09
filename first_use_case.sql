2010 1/4/2010 1,425,504,460 4,628,115 $38,495,460,645
2010 1/5/2010 1,754,011,750 5,394,016 $43,932,043,406
2010 1/6/2010 1,655,507,953 5,494,460 $43,816,749,660
2010 1/7/2010 1,797,810,789 5,674,297 $44,104,237,184

begin;

create table factbook
 (
    year int,
    date date,
    shares text,
    trades text,
    dollars text
 );

\copy factbook from 'factbook.csv' with delimiter E'\t' null ''

alter table factbook
  alter shares
    type bigint
  using replace(shares, ',', '')::bigint,

  alter trades
    type bigint
  using replace(trades, ',', '')::bigint,

  alter dollars
    type bigint
  using substring(replace(dollars, ',', '') from 2)::numeric;

commit;

-- We use the PostgreSQL copy functionality to stream the data from the CSV file into our table.