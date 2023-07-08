namespace ConsoleApp1.models;

public class Elev : Entitate<string>
{
    public String Nume { get; set; }
    public String Scoala { get; set; }

    public Elev(string id) : base(id)
    {

    }

    public Elev(string id, string nume, string scoala) : base(id)
    {
        Nume = nume;
        Scoala = scoala;
    }

    public Elev(string id, string v, Echipa echipa) : this(id)
    {
    }

    public override string ToString()
    {
        return Id + " " + Nume + " " + Scoala;
    }
}
