namespace ConsoleApp1.models;

public class Jucator:Elev
{
    public string NumeEchipa { get; set; }

    public Jucator(string id, string nume, string scoala) : base(id, nume, scoala)
    {
    }

    public Jucator(string id , string nume, string scoala, string echipa) : base(id ,nume, scoala)
    {
        NumeEchipa= echipa;
    }


    public override string ToString()
    {
        return Id + " " + Nume + " " + Scoala + " " + NumeEchipa;
    }
}