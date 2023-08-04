# School Project SQL Design Pattern

<img width="600" alt="image" src="https://github.com/Sasaliha/SchoolDb/assets/77535648/a76ff0d9-6ca1-4a9a-b8e3-3ed167e9d3ef">

Okul Projemde yukarıdaki diagramda da paylastıgım üzere 13 table ile çalıştım. Bu projede 3 Procedure ve 2 View Sorgusu oluşturdum. Bu sorguları dilersek daha da çeşitlendirebiliriz. Ben örnek olarak birkaç tanesini paylasıyor olacagım. 
Detaylara ait açıklamalarımı aşağıda bulabilirsiniz: 


### Veritabanındaki tablolara ait alanların acıklamaları: 

>AdminUser Table : Veritabanımızdaki tüm tablolara tam erişim yetkisi olan ve tüm tablolarda veri ekleme/güncelleme/silme işlemlerini gerçekleştirebilen ana kullanıcıdır.

>Teachers Table : Okulun öğretmenlerine ait kişisel verilerin tutuldugu tablodur.

>Students Table: Okulun öğrencilerine ait kişisel verilerin tutuldugu tablodur.

>StudentParents: Öğrenciye ait veli bilgisi ve yakınlık derecesinin tutuldugu tablodur.

>Exams Table: Öğrencilerin sınav notlarının, sınava ait ders,tarih ve saat bilgilerinin, öğrencilerin sınava katılım saglayıp/saglamadıkları ile ilgili durum bilgilerinin öğretmen tarafından tutuldugu tablodur.

>Lessons Table: Okuldaki eğitim müfredatında yer alan ders isimlerinin tutuldugu tablodur. Müfredattan çıkarılmıs bir ders IsActive alanında false olarak görünmelidir.

>Classes Table: Okuldaki sınıf şubeleri, sınıflara atanan sınıf öğretmenleri, sınıfın hala aktif kullanılıp/kullanılmadıgı bilgilerinin yer aldıgı tablodur.

>GradeLevel Table: Okuldaki ana sınıf derecelerinin tutuldugu tablodur. Örneğin bir ilkokul ele alındıgında veritabanında 1-4. sınıf aralıgındaki sınıf dereceleri yer alacaktır.

>NoneAttandances Table: Öğrencilerin hangi derslere hangi tarihte devamsızlıkta bulundugu ile ilgili öğretmeni tarafından girilen devamsızlık bilgilerinin tutuldugu tablodur.

>AdministrativeStaff Table: Okuldaki diğer idari kadrolarda ve departmanlarda çalışan personellerin bilgilerinin tutuldugu tablodur.

>Departments Table: okuldaki diğer görev tanımlarına ait departman bilgilerinin tutuldugu tablodur.

>SchoolStatistics Table: Okulun internet sitesinde yayınlanmak üzere; belli aralıklarla okuldaki toplam öğretmen, öğrenci ve sınıf sayılarına ait verilerinin veritabanındaki verilerden yola cıkarak hesaplanıp paylasılması için olusturulmustur. Sitede yayınlanmak istenen baska veri olması durumunda alana ekleme yapılarak görüntüleme saglanabilecektir.

>SchoolContactInformations Table: Okula ait iletişim bilgilerinin yer aldıgı tablodur.

#### PROCEDURE SORGU KODLARI


>Okul istatistiklerine ait verileri getirmeye yarayan bir Procedure:

```tsql
Create Procedure SchoolStatisticsProcedure @userId int=1  --Okul istatistikleri ile ilgili güncel verileri çekmek üzere SchoolStatisticsProcedure isimli bir procedure olusturdum. kullanıcı ıd'si 1 olan kullanıcının verilerini burada default olarak getirmektedir. hangi kullanıcının cektiği verileri getirmek istersek buradaki userId parametresini vererek sorgulama yaptırabiliriz.
AS
BEGIN
insert into SchoolStatistics  values((select count(*) from Teachers), (select count(*) from Students),(select count(*) from Classes), @userId,getdate()) --verileri veritabanından cekerek güncel verilere ait kayıtları SchoolStatistic tabloma eklettim.

select*from SchoolStatistics 
END
```
Örnek Çalıştırma komutu: Exec SchoolStatisticsProcedure 


>Girilen şube parametresi ile güncel şube öğrencilerine ait verilerin listelenmesini saglayan Procedure:

```tsql
Create Procedure ClassStudentsProcedure @className varchar(10) --şube adını parametre olarak alan bir className olusturuldu

AS
BEGIN

select ClassName 'Sınıf Şubesi', s.Name 'Öğrenci Adı', t.Name 'Öğretmen Adı' from Classes as c inner join Students as s on c.Id=s.ClassId 
inner join Teachers as t on c.TeacherId=t.Id
where ClassName=@className --şart olarak verdiğimiz parametre verildi.

END

```

Örnek Çalıştırma komutu: Exec ClassStudentsProcedure '1-A'

>Bir sınıftaki öğrecilerin bir derse ait sınıf ortalamalarını alarak, o derse ait genel sınıf ortalamasını hesaplayıp çıktı alabileceğimiz bir procedure:


```tsql
CREATE Procedure LessonAverageProcedure  @className varchar(10) , @lessonName varchar(100)=null --parametre olarak verilen şube adını ve bilgilerinin hesaplanmasını istediğimiz dersin adını giriyoruz.

AS
BEGIN

select c.ClassName,  s.Name   , s.IdentityNumber, e.ExamDate, e.ExamHour, 
e.Exam1, e.Exam2, e.Exam3,((e.Exam1+e.Exam2+e.Exam3 )/3) 'Öğrenci ortalaması',  --tabloda yeni bir alan olusturarak öğrencilerin ortalamasını cıktı verir
l.Name 'Dersin Adı', t.Name 'Öğretmen Adı'  from  Classes as c left join Students as s on c.Id=s.ClassId
left join Exams as e on e.StudentId=s.Id
left join Lessons as l on l.Id=e.LessonId
left join Teachers as t on t.Id=e.TeacherId
where not s.Name is null and c.ClassName=@className -- yalnızca verilen parametredeki şubeye ait öğrencilerin bilgileri hesaplanır.

select AVG(((e.Exam1+e.Exam2+e.Exam3 )/3)) 'Sınıfın Ortalaması' FROM Exams as e left join Students as s on s.Id=e.StudentId --ortalama bilgisi hesaplanan öğrencilerin genel ortalaması ayrı bir sorgulamada gösterilir.
left join Classes as c on c.Id=s.ClassId
left join Lessons as l on l.Id=e.LessonId
where c.ClassName=@className and l.name=@lessonName 

END
```

Örnek Çalıştırma Komutu: Exec LessonAverageProcedure '1-A', 'Matematik'

#### VIEW SORGU KODLARI

>Öğrencilerin not ortalamasına göre 70'in üzerinde olanlara BAŞARILI altında olanlara ise BAŞARISIZ seklinde çıktı veren komuttur.

```tsql
CREATE VIEW ExamStatuListsView as 

select c.ClassName,  s.Name   , s.IdentityNumber, e.ExamDate, e.ExamHour, 
e.Exam1, e.Exam2, e.Exam3,((e.Exam1+e.Exam2+e.Exam3 )/3) 'Öğrenci ortalaması',
CASE
	WHEN ((e.Exam1+e.Exam2+e.Exam3 )/3)  > 70 then 'BAŞARILI'  --sart bloglarında durumlar degerlendirildi
	WHEN ((e.Exam1+e.Exam2+e.Exam3 )/3) <70 then 'BAŞARISIZ'
END as 'DURUM',

l.Name 'Dersin Adı', t.Name 'Öğretmen Adı'

from  Classes as c left join Students as s on c.Id=s.ClassId
left join Exams as e on e.StudentId=s.Id
left join Lessons as l on l.Id=e.LessonId
left join Teachers as t on t.Id=e.TeacherId
where not s.Name is null 

```
Örnek Çalıştırma Komutu:  SELECT * FROM ExamStatuLists


>Derse bugun tarihli katılım sağlamamıs öğrencileri sorgulayabilmemizi saglayan komuttur.


```tsql
CREATE VIEW noneAttandancesView as
select format(a.Date,'dd-MM-yyyy') 'Bugün Gelmeyenler',  
s.Name 'Öğrenci Adı Soyadı',
l.Name 'Ders Adı', 
c.ClassName  'Şube'
from NoneAttendances as a left join Students as s on s.Id=a.StudentId
left join Lessons as l on l.Id=a.LessonId
left join Classes as c on c.Id=s.ClassId WHERE CAST(a.Date AS DATE)= CAST (GETDATE() AS DATE); --bugun tarihini sart olarak belirttik
```

Örnek çalıştırma komutu: SELECT * FROM noneAttandancesView










