using ConsoleApp1.models;

using ConsoleApp1.models;

namespace ConsoleApp1.repository;

public class FileRepoMeci : FileRepository<string, Meci>
{
    public FileRepoMeci(string numeFisier) : base(numeFisier,
        DelegatesEntitiesFromFile.DelegateMeci)
    {
    }
}