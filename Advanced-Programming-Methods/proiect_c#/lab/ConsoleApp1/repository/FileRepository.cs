using System.Text;
using ConsoleApp1.models;

namespace ConsoleApp1.repository;

public delegate E ParseLineEntity<E>(string line);

public class FileRepository<ID, E> : InMemoryRepository<ID, E> where E : Entitate<ID>
{
    protected string NumeFisier;
    protected ParseLineEntity<E> ParseLineEntity;

    public FileRepository(string numeFisier, ParseLineEntity<E> parseLineEntity) :
        base()
    {
        NumeFisier = numeFisier;
        ParseLineEntity = parseLineEntity;
        if (ParseLineEntity != null)
        {
            LoadFromFile();
        }
    }

    void LoadFromFile()
    {
        using (var fileStream = File.OpenRead(this.NumeFisier))
        using (var streamReader = new StreamReader(fileStream))
        {
            String line;
            while ((line = streamReader.ReadLine()) != null)
            {
                E entitate = this.ParseLineEntity(line);
                base.Save(entitate);
            }
        }
    }
}