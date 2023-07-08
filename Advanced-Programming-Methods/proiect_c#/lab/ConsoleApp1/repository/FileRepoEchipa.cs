using ConsoleApp1.models;

namespace ConsoleApp1.repository;

public class FileRepoEchipa : FileRepository<string, Echipa>
{
    public FileRepoEchipa(string numeFisier) : base(numeFisier,
        DelegatesEntitiesFromFile.DelegateEchipa)
    {
    }
}