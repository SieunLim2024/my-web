package mymemberone;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import jdbc.DBPoolUtil2;

public class CartDAO {
	public static CartDAO instance = null;

	private CartDAO() {
	};

	public static CartDAO getInstance() {
		if (instance == null) {
			synchronized (CartDAO.class) {
				instance = new CartDAO();
			}
		}
		return instance;
	}

	public int insertArticle(String performanceId, String userId, String seatNum) {
		String sql = "CALL CARTTBL_INSERT(?,?,?)";
		Connection con = null;
		CallableStatement cstmt = null;
		int value = -1;
		try {
			con = DBPoolUtil2.makeConnection();
			cstmt = con.prepareCall(sql);
			cstmt.setString(1, userId);
			cstmt.setString(2, performanceId);
			cstmt.setString(3, seatNum);

			value = cstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBPoolUtil2.dbReleaseClose(null, cstmt, con);
		}
		return value;
	}

}
