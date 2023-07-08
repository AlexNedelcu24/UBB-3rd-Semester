using ConsoleApp1.models;


namespace ConsoleApp1.repository;

public class FileRepoJucatorActiv : FileRepository<string, JucatorActiv>
{
    public FileRepoJucatorActiv(string numeFisier) : base(numeFisier,
        DelegatesEntitiesFromFile.DelegateJucatorActiv)
    {
    }
}