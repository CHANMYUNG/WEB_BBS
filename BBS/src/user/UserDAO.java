package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * Created by NooHeat on 09/06/2017.
 */
public class UserDAO {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;
    private String url;
    private String IO;
    private String password;

    public UserDAO() {
        try {
            url = "jdbc:mysql://localhost:3306/BBS";
            IO = "root";
            password = "xogns1228";

            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(url, IO, password);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int login(String userID, String userPassword) {

        /* SQL INJECTION SHIELD */
        String SQL = "select userPassword from user where userId =?";

        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            rs = pstmt.executeQuery();

            if(rs.next()){

                // LOGIN
                if(rs.getString(1).equals(userPassword))
                    return 1;

                // NOT
                else return 0;


            }
            return -1; // NO ID
        }catch(Exception e){
            e.printStackTrace();
        }
        return -2; // NO DATABASE
    }

    public int join(User user){
        String SQL = "insert into user values (?,?,?,?,?)";
        try{
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, user.getUserID());
            pstmt.setString(2, user.getUserPassword());
            pstmt.setString(3, user.getUserName());
            pstmt.setString(4, user.getUserGender());
            pstmt.setString(5, user.getUserEmail());

            // SUCCESS
            return pstmt.executeUpdate();
        }catch(Exception e){
            e.printStackTrace();
        }

        // FAILED
        return -1;
    }
}
