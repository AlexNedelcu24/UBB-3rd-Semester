using ConsoleApp1.models;


namespace ConsoleApp1.repository;

public class FileRepoJucator : FileRepository<string, Jucator>
{
    public FileRepoJucator(string numeFisier) : base(numeFisier,
        DelegatesEntitiesFromFile.DelegateJucator)
    {
    }
}