
sqlcmd -S localhost,20001 -h -1 -t 1 -U sa -P 'YourStr0ng!P@ssw0rd' -Q "SET NOCOUNT ON; select SUM(state) from sys.databases" -TrustServerCertificate yes | tr -d '[:space:]'
echo ""
sqlcmd -S localhost,20001 -h -1 -t 1 -U sa -P 'YourStr0ng!P@ssw0rd' -Q "SELECT name, state FROM sys.databases"