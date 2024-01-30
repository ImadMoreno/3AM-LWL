Connect system@xepdb1
Drop user instituto cascade;
Create user instituto identified by 123 quota unlimited on system;
Grant connect, resource to instituto;
Connect instituto/123@xepdb1;
