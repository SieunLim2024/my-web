package mymemberone;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;

import jdbc.DBPoolUtil2;

public class PaymentDAO {
	public static PaymentDAO instance = null;

	private PaymentDAO() {
	}

	public static PaymentDAO getInstance() {
		if (instance == null) {
			synchronized (PaymentDAO.class) {
				instance = new PaymentDAO();
			}
		}
		return instance;
	}

	public int insertArticle(String[] cartNo) {
		int result = 0;
		for (int i = 0; i < cartNo.length; i++) {
			String sql = "CALL PAYMENT_INSERT(?)";
			Connection con = null;
			CallableStatement cstmt = null;
			try {
				con = DBPoolUtil2.makeConnection();
				cstmt = con.prepareCall(sql);
				cstmt.setInt(1, Integer.parseInt(cartNo[i]));
				result = cstmt.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				DBPoolUtil2.dbReleaseClose(null, cstmt, con);
			}
		}
		return result;
	}
	
	public static ArrayList<HashMap> selectArticle(String userId) {
		ArrayList<HashMap> list = new ArrayList<>();
		String sql = "CALL PAYMENT_SELECT(?,?)";
		Connection con = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;

		try {
			con = DBPoolUtil2.makeConnection();
			cstmt = con.prepareCall(sql);
			cstmt.setString(1, userId);
			cstmt.registerOutParameter(2, Types.REF_CURSOR);
			cstmt.execute();
			rs=(ResultSet)cstmt.getObject(2);
			while (rs.next()) {
				HashMap<String, String> map = new HashMap<>();
				map.put("userId",  userId);
				map.put("no", rs.getString("no"));
				map.put("performanceId", rs.getString("performanceid"));
				map.put("genre", rs.getString("genre"));
				map.put("venue", rs.getString("venue"));
				map.put("performanceName", rs.getString("performancename"));
				map.put("seatNum", rs.getString("seatnum"));
				map.put("dayOfPerformance", rs.getString("dayOfPerformance"));
				map.put("receiptid",  rs.getString("receiptid"));
				list.add(map);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBPoolUtil2.dbReleaseClose(rs, cstmt, con);
		}
		return list;
	}
}
