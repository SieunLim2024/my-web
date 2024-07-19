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

public class ReceiptDAO {
	private static ReceiptDAO instance = null;

	private ReceiptDAO() {
	};

	public static ReceiptDAO getInstance() {
		if (instance == null) {
			synchronized (ReceiptDAO.class) {// 동기화 처리
				instance = new ReceiptDAO();
			}
		}
		return instance;
	}

	public int insertArticle(ReceiptVO article) {
		String sql = "CALL RECEIPT_INSERT(?,?,?,?)";
		Connection con = null;
		CallableStatement cstmt = null;
		int result = -1;
		try {
			con = DBPoolUtil2.makeConnection();
			cstmt = con.prepareCall(sql);
			cstmt.setInt(1, article.getPrice());
			cstmt.setInt(2, article.getTotalPrice());
			cstmt.setInt(3, article.getUseMileage());
			cstmt.setString(4, article.getUserId());

			result = cstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBPoolUtil2.dbReleaseClose(null, cstmt, con);
		}
		return result;
	}

	public static ArrayList<HashMap> selectArticle(String userId) {
		ArrayList<HashMap> list = new ArrayList<>();
		String sql = "CALL RECEIPT_SELECT(?,?)";
		Connection con = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;

		try {
			con = DBPoolUtil2.makeConnection();
			cstmt = con.prepareCall(sql);
			cstmt.setString(1, userId);
			cstmt.registerOutParameter(2, Types.REF_CURSOR);
			cstmt.execute();
			rs = (ResultSet) cstmt.getObject(2);
			while (rs.next()) {
				HashMap<String, String> map = new HashMap<>();
				map.put("userId", userId);
				map.put("receiptId", rs.getString("receiptId"));
				map.put("price", rs.getString("price"));
				map.put("totalPrice", rs.getString("totalPrice"));
				map.put("paymentDate", rs.getString("paymentDate"));
				map.put("useMileage", rs.getString("useMileage"));
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
