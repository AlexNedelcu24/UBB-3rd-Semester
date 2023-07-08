namespace ConsoleApp1.models;

public class Meci : Entitate<string>
{

    public string IDEchipa1 { get; set; }

    public string IDEchipa2 { get; set; }
    public DateTime Data { get; set; }

    public Meci(string id ,string echipa1, string echipa2, DateTime date) : base(id)
    {
        IDEchipa1 = echipa1; 
        IDEchipa2 = echipa2; 
        Data = date;    
    }

    public override string ToString()
    {
        return IDEchipa1 + " " + IDEchipa2 + " " + Data;
    }
}