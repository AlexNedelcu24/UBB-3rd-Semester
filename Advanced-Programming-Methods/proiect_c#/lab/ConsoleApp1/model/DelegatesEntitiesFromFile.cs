namespace ConsoleApp1.models;

public class DelegatesEntitiesFromFile
{
    private static char Separator = ';';


    public static Echipa DelegateEchipa(string line)
    {
        string[] splitEchipa = line.Split(Separator);
        return new Echipa(splitEchipa[0], splitEchipa[1]);
    }

    public static Elev DelegateElev(string line)
    {
        string[] splitElev = line.Split(Separator);
        return new Elev(splitElev[0], splitElev[1], splitElev[2]);
    }

    public static Jucator DelegateJucator(string line)
    {
        string[] splitJucator = line.Split(Separator);
        string NumeEchipa = splitJucator[3];
        return new Jucator(splitJucator[0], splitJucator[1], splitJucator[2], NumeEchipa);
    }

    public static JucatorActiv DelegateJucatorActiv(string line)
    {
        string[] splitJucatorActiv = line.Split(Separator);
        return new JucatorActiv(splitJucatorActiv[0], splitJucatorActiv[1], splitJucatorActiv[2], int.Parse(splitJucatorActiv[3]), (Tip)Enum.Parse(typeof(Tip), splitJucatorActiv[4]));
    }

    public static Meci DelegateMeci(string line)
    {
        string[] splitMeci = line.Split(Separator);
        string echipa1 = splitMeci[1];
        string echipa2 = splitMeci[2];
        return new Meci(splitMeci[0], echipa1, echipa2, DateTime.Parse(splitMeci[3]));
    }


}