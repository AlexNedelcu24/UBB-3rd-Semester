namespace ConsoleApp1.models;

public class Echipa : Entitate<string>
{
    public String Nume { get; set; }

    public Echipa(string id) : base(id)
    {

    }

    public Echipa(string id, string nume) : base(id)
    {
        Nume = nume;
    }

    public override string ToString()
    {
        return Id + " " + Nume;
    }
}