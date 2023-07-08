namespace ConsoleApp1.models;

public enum Tip
{
    Rezerva,
    Participant
}

public class JucatorActiv : Entitate<string>
{

    public string IdJucator { get; set; }
    public string IdMeci { get; set; }
    public int NrPuncteInscrise { get; set; }
    public Tip Tip { get; set; }

    public JucatorActiv(string id ,string idJucator, string idMeci, int nrPuncteInscrise, Tip tip) : base(id)
    {
        IdJucator = idJucator;
        IdMeci = idMeci;
        NrPuncteInscrise = nrPuncteInscrise;
        Tip = tip;
    }

    /*public JucatorActiv(string id ,int v1, int v2, int v3, Tip tip) : base(id)
    {
        
    }*/

    public override string ToString()
    {
        return IdJucator + " " + IdMeci + " " + NrPuncteInscrise.ToString() + " " + Tip;
    }
}
