
-- DDL

-- 1. Tabel Karyawan

CREATE TABLE Karyawan (
	id int PRIMARY KEY,
	nama varchar(150),
	jenis_kelamin varchar(150),
	date_of_birth DATE,
	status Varchar(150),
	alamat text
)
;

CREATE TABLE Detail_Karyawan (
	id int PRIMARY KEY,
	id_karyawan varchar(150),
	nik varchar(150),
	npwp varchar(150)
)
;

-- 2. Tabel Rekening

CREATE TABLE Rekening (
	id int PRIMARY KEY,
	id_karyawan varchar(150),
	nama varchar(150),
	jenis varchar(150),
	nomor varchar(150)
)
;


-- 3. Tabel Training

CREATE TABLE Training (
	id int PRIMARY KEY,
	tema varchar(150),
    nama_pengajar varchar(150)
)
;

-- 4. Tabel Training Karyawan

CREATE TABLE Karyawan_Training (
	id int PRIMARY KEY,
	id_karyawan varchar(150),
	id_training varchar(150),
	tanggal_training DATE
)
;

-- Stored Procedure

-- 1. Insert Karyawan

create or replace procedure  Savekaryawan(INOUT in_id int,
inout in_id_karyawan varchar,
INOUT in_nama varchar,
INOUT in_jenis_kelamin varchar,
INOUT in_date_of_birth date,
INOUT in_alamat text,
INOUT in_status varchar,
INOUT in_nik varchar,
INOUT in_npwp varchar,
INOUT eror_desc varchar,
INOUT eror_code integer)
language plpgsql
as
$insert_karyawan$
BEGIN

if in_id is null then
eror_code = 404;
eror_desc = 'ID Kosong';
return;

elsif in_id_karyawan is null then
eror_code = 404;
eror_desc = 'ID Karyawan Kosong';

elsif in_nama is null then
eror_code = 404;
eror_desc = 'Nama Kosong';
return;

elsif in_jenis_kelamin is null then
eror_code = 404;
eror_desc = 'Jenis Kosong';
return;

elsif in_date_of_birth is null then
eror_code = 404;
eror_desc = 'Nomor Kosong';
return;

elsif in_alamat is null then
eror_code = 404;
eror_desc = 'Alamat Kosong';
return;

elsif in_status is null then
eror_code = 404;
eror_desc = 'Status Kosong';
return;

elsif in_nik is null then
eror_code = 404;
eror_desc = 'ID Kosong';
return;

elsif in_npwp is null then
eror_code = 404;
eror_desc = 'ID Kosong';
return;

else
    INSERT INTO karyawan(
	id, nama, jenis_kelamin, date_of_birth, status, alamat)
	VALUES (in_id, in_nama, in_jenis_kelamin, in_date_of_birth, in_status, in_alamat);

    INSERT INTO detail_karyawan(
	id, id_karyawan, nik, npwp)
	VALUES (in_id, in_id_karyawan, in_nik, in_npwp);

    eror_code = 200;
    eror_desc = 'sukses';
commit;
end if;
end;

$insert_karyawan$;

call Savekaryawan(19,
    '019'::varchar,
    'Turner2'::varchar,
    'laki-laki'::varchar,
    '1999-10-10'::date,
    'jalan-jalan'::text,
    'status_karyawan'::varchar,
    '36005'::varchar,
    '324444'::varchar,
    null,
    null);
;

UPDATE detail_karyawan
	SET npwp='5454', nik='3821'
	WHERE id=1
;

select a.* ,
       b.*
from Karyawan as a,
     Detail_Karyawan as b
where a.id = b.id;

-- 2. Update Karyawan

create or replace procedure updatekaryawan (INOUT in_id int,
inout in_id_karyawan varchar,
INOUT in_nama varchar,
INOUT in_jenis_kelamin varchar,
INOUT in_date_of_birth date,
INOUT in_alamat text,
INOUT in_status varchar,
INOUT in_nik varchar,
INOUT in_npwp varchar,
INOUT eror_desc varchar,
INOUT eror_code integer
)
language plpgsql
as $update_karyawan$
BEGIN

if in_id is null then
eror_code = 404;
eror_desc = 'ID Kosong';
return;

elsif in_id_karyawan is null then
eror_code = 404;
eror_desc = 'ID Karyawan Kosong';


elsif in_nama is null then
eror_code = 404;
eror_desc = 'Nama Kosong';
return;

elsif in_jenis_kelamin is null then
eror_code = 404;
eror_desc = 'Jenis Kosong';
return;

elsif in_date_of_birth is null then
eror_code = 404;
eror_desc = 'Nomor Kosong';
return;

elsif in_alamat is null then
eror_code = 404;
eror_desc = 'Alamat Kosong';
return;

elsif in_status is null then
eror_code = 404;
eror_desc = 'Status Kosong';
return;

elsif in_nik is null then
eror_code = 404;
eror_desc = 'ID Kosong';
return;

elsif in_npwp is null then
eror_code = 404;
eror_desc = 'ID Kosong';
return;

else
    UPDATE Karyawan
	SET nama=in_nama,
	    jenis_kelamin=in_jenis_kelamin,
	    status=in_status,
	    alamat=in_alamat,
	    date_of_birth=in_date_of_birth
	WHERE id=in_id;

    update Detail_Karyawan
    set id_karyawan=in_id_karyawan,
        nik=in_nik,
        npwp=in_npwp
    where id=in_id;
    eror_code = 200;
    eror_desc = 'sukses';
    commit;

end if;
end;

$update_karyawan$;
call updatekaryawan(19,
    '019'::varchar,
    'Turner new'::varchar,
    'laki-laki'::varchar,
    '1999-10-10'::date,
    'jalan-jalan baru'::text,
    'status_karyawan'::varchar,
    '36005'::varchar,
    '324444'::varchar,
    null,
    null);
;


UPDATE Karyawan
	SET nama='Budiarta',date_of_birth='10/01/1999', status='menikah'
	WHERE id=1
;

-- 3. List Karyawan by Nama

create or replace function getListKaryawann (IN in_nama Varchar)
returns table  (
    id int  ,
	nama varchar,
	jenis_kelamin varchar,
	date_of_birth DATE,
	status Varchar,
	alamat text
    )

language plpgsql
as
$$
begin

return query
    select *
      from Karyawan
     where Karyawan.nama ilike in_nama;

end;
$$;
drop function if exists getListKaryawann(in_nama Varchar);
select getListKaryawann('Budiarta');
;

-- 4. Get Karyawan by ID

create or replace function getKaryawan(IN var_ID int)
returns table  (
    id int  ,
	nama varchar,
	jenis_kelamin varchar,
	date_of_birth DATE,
	status Varchar,
	alamat text
    )

language plpgsql
as
$$
begin
    return query
    select *
      from Karyawan
     where Karyawan.id = var_ID;

end;
$$;
drop function if exists  getkaryawan(var_id int);
select getKaryawan(1);

-- 5. Insert Training

create or replace procedure Savetraining(
INOUT in_tema varchar,INOUT in_nama varchar,INOUT in_id int
)
language plpgsql
as $$
BEGIN
    insert into training(id, tema, nama_pengajar) values (in_id,in_tema,in_nama);
    commit;

END;
$$;
call Savetraining('data','imha',6);

-- 6. Update Training

create or replace procedure updateTraining(
INOUT in_old_id int, INOUT in_tema varchar,INOUT in_nama varchar
)
language plpgsql
as $$
BEGIN
    update Training
       set  tema=in_tema, nama_pengajar=in_nama
     where id= in_old_id;
    commit;
END;
$$;
call updateTraining(5,'Basic-Java','Imha');

-- 7. list Training like by Nama

create or replace function getListTraining(IN in_tema Varchar)
returns varchar
language plpgsql
as $getlist$
declare tema_selected varchar;
    BEGIN
    select tema
      into tema_selected
      from training
     where training.tema ilike in_tema;

return tema_selected;
END;

$getlist$;
end;
select getListTraining('test');
select * from Training;
-- 8. get By Id Training

create or replace function idLoop(IN in_id int)
returns table(return_id int ,return_tema varchar,return_nama_pengajar varchar)
language plpgsql

as $test$
DECLARE jumlah_record record;
BEGIN

    for jumlah_record in(

    select Training.id::integer,
           Training.tema::character varying,
           Training.nama_pengajar::character varying

      from training
     where id = in_id
    )
    loop
        return_id:= jumlah_record.id::integer;
        return_tema:= jumlah_record.tema::character varying;
        return_nama_pengajar:= jumlah_record.nama_pengajar::character varying;
    return next;
    end loop;

END;
$test$;
drop function idLoop(in_id integer);

select * from idLoop(1);

-- 9. Insert Training Karyawan

drop procedure if exists SaveTrainingKaryawan(in_id int, in_id_karyawan varchar, in_id_Training varchar, in_tanggal_training DATE);
create or replace procedure SaveTrainingKaryawan(
INOUT in_id int,
INOUT in_id_karyawan varchar,
INOUT in_id_Training varchar,
INOUT in_tanggal_training DATE

)
language plpgsql
as $proc$
BEGIN
    INSERT INTO karyawan_training(
	id, id_karyawan, id_training, tanggal_training)
	VALUES (in_id, in_id_karyawan,in_id_training,in_tanggal_training);
    commit;

END;
$proc$;
call SaveTrainingKaryawan( 3,'0002'::character varying, '1'::character varying, '20/10/1999'::date);

--10. Delete Training Karyawan

create or replace procedure deleteTrainingKaryawan (inout in_id int,
inout eror_desc varchar,
inout eror_code int )
language plpgsql
as $delete$
BEGIN
if in_id is null then

        eror_code=404,
        eror_desc='id_is null';

    else

    delete from Karyawan_Training where id=in_id;
    commit;
    eror_code=200,
    eror_desc='sukses';
end if;

END;

$delete$;

call deleteTrainingKaryawan(1,null,null);

--11. Simpan Rekening
create or replace procedure saveRekening(
INOUT in_id int,
INOUT in_nama VARCHAR,
INOUT in_jenis VARCHAR,
INOUT in_nomor VARCHAR,
INOUT in_id_karyawan varchar,
INOUT eror_desc varchar,
INOUT eror_code integer)

LANGUAGE plpgsql
AS $procedure$
BEGIN
    raise notice '%',in_id;

if in_id is null then
eror_code = 404;
eror_desc = 'ID Kosong';
return;

elsif in_nama is null then
eror_code = 404;
eror_desc = 'Nama Kosong';
return;

elsif in_jenis is null then
eror_code = 404;
eror_desc = 'Jenis Kosong';
return;

elsif in_nomor is null then
eror_code = 404;
eror_desc = 'Nomor Kosong';
return;

elsif in_id_karyawan is null then
eror_code = 404;
eror_desc = 'ID Kosong';
return;

else
INSERT INTO rekening(
	id, id_karyawan, nama, jenis, nomor)
	VALUES (in_id,in_id_karyawan,in_nama,in_jenis,in_nomor);
eror_code = 200;
eror_desc = 'sukses';
commit;
end if;

END;

$procedure$;
call saveRekening(3,'Demi','CBA','10251104','002',null,null);

--12. Update Rekening

create or replace procedure updateRekening(
INOUT in_id int,
INOUT in_nama VARCHAR,
INOUT in_jenis VARCHAR,
INOUT in_nomor VARCHAR,
INOUT in_id_karyawan varchar
)
language plpgsql
as $$
BEGIN
    update Rekening
       set  id=in_id, id_karyawan=in_id_karyawan, nama=in_nama, jenis=in_jenis, nomor = in_nomor
     where id= in_id;
    commit;
END;
$$;
call updateRekening(3, 'Beby', 'CBA', '500000', '002');

--13. Delete Rekening + Soft Delete(Mengisi deleted_date )

create or replace procedure deleteRekening (in_id int,
INOUT eror_desc varchar,
INOUT eror_code integer
)
language plpgsql
as $delete$
BEGIN
    if in_id is null then
        eror_code=404,
        eror_desc='id_is null';

    else
    delete from Rekening where id=in_id;

    INSERT
      INTO rekening(id,deleted_date)
	VALUES (1,current_timestamp);

    commit;
    eror_code=200,
    eror_desc='sukses';
    end if;


END;
$delete$;

call deleteRekening(1,null,null);

--
--
--
--
---- EXTRA -----
commit;

INSERT INTO karyawan(
	id, nama, jenis_kelamin, date_of_birth, status, alamat)
	VALUES (1, 'Budi', 'Laki-laki', '01/01/1999', 'single', 'jalan-jalan')
;
INSERT INTO detail_karyawan(
	id, id_karyawan, nik, npwp)
	VALUES (1, '0001', '0001', '5555')

select * from Karyawan;
select * from Detail_Karyawan;
select * from Karyawan_Training;
select * from Rekening;
select * from Training;

alter table Rekening add column deleted_date timestamp;

delete from Rekening where id=1;


select *
  from Training
where tema ilike '%postgre%'
;

select *
  from Training
where id=1
;

select * from Karyawan where nama ilike 'budiarta';
select * from Karyawan where id =1;



select * from Detail_Karyawan;


select * from Karyawan_Training;

INSERT INTO karyawan_training(
	id, id_karyawan, id_training, tanggal_training)
	VALUES (2, '0002', '1', '20/10/1999')
;
INSERT INTO karyawan_training(
	id, id_karyawan, id_training, tanggal_training)
	VALUES (1, '0001', '1', '20/10/1999')
;

delete
  from Karyawan_Training
 where id=2
;

select * from karyawan_training
;



INSERT INTO rekening(
	id, id_karyawan, nama, jenis, nomor,deleted_date)
	VALUES (1, '0001', 'Budi', 'CBA', '8888',current_timestamp)
;

INSERT INTO rekening(
	id, id_karyawan, nama, jenis, nomor)
	VALUES (2, '0002', 'Ibud', 'CBA', '8889')
;

update rekening
   set id=3, nama='Mamat'
where id = 2
;

select * from rekening;

delete
  from rekening
 where id=3;

select * from Rekening;

INSERT INTO training(
	id, tema, nama_pengajar)
	VALUES (1, 'Database', 'Imha')
;
select * from Training;
update training
   set tema ='PostgreSQL', nama_pengajar='Alex'
 where id = 1;
;




