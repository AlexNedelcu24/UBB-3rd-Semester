using ConsoleApp1.models;

namespace ConsoleApp1.repository;

public class FileRepoElev : FileRepository<string, Elev>
{
    public FileRepoElev(string numeFisier) : base(numeFisier,
        DelegatesEntitiesFromFile.DelegateElev)
    {
    }
}