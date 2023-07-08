namespace ConsoleApp1.models;

public class Entitate<TID>
{
    public TID Id { get; set; }

    public Entitate(TID id)
    {
        Id = id;
    }
}