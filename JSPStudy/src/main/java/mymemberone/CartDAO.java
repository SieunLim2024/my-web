package mymemberone;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;

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
	
	public static ArrayList<HashMap> selectArticle(String userId) {
		ArrayList<HashMap> list = new ArrayList<>();
		String sql = "CALL CARTTBL_SELECT(?,?)";
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
				map.put("no", rs.getString("no"));
				map.put("performanceId", rs.getString("performanceid"));
				map.put("genre", rs.getString("genre"));
				map.put("venue", rs.getString("venue"));
				map.put("performanceName", rs.getString("performancename"));
				map.put("seatNum", rs.getString("seatnum"));
				map.put("dayOfPerformance", rs.getString("dayOfPerformance"));

				list.add(map);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBPoolUtil2.dbReleaseClose(rs, cstmt, con);
		}
		return list;
	}
	
	public static ArrayList<HashMap> selectArticle(String userId,int no ) {
		ArrayList<HashMap> list = new ArrayList<>();
		String sql = "CALL CARTTBL_SELECT_NO(?,?,?)";
		Connection con = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;

		try {
			con = DBPoolUtil2.makeConnection();
			cstmt = con.prepareCall(sql);
			cstmt.setString(1, userId);
			cstmt.setInt(2, no);
			cstmt.registerOutParameter(3, Types.REF_CURSOR);
			cstmt.execute();
			rs=(ResultSet)cstmt.getObject(2);
			while (rs.next()) {
				HashMap<String, String> map = new HashMap<>();
				map.put("no", rs.getString("no"));
				map.put("performanceId", rs.getString("performanceid"));
				map.put("genre", rs.getString("genre"));
				map.put("venue", rs.getString("venue"));
				map.put("performanceName", rs.getString("performancename"));
				map.put("seatNum", rs.getString("seatnum"));
				map.put("dayOfPerformance", rs.getString("dayOfPerformance"));

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
