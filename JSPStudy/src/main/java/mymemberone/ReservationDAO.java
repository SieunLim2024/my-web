package mymemberone;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jdbc.DBPoolUtil2;

public class ReservationDAO {
	private static ReservationDAO instance = null;

	private ReservationDAO() {
	}

	public static ReservationDAO getInstance() {
		if (instance == null) {
			synchronized (ReservationDAO.class) {// 동기화 처리
				instance = new ReservationDAO();
			}
		}
		return instance;
	}
	
	public int reservationInsert(int no, String userId) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean flag = false;
		int count=0;
		try {
			conn = DBPoolUtil2.makeConnection();
			String strQuery = "insert into reservation values(?, ?, reservation_seq.nextval)";
			pstmt = conn.prepareStatement(strQuery);
			pstmt.setString(1, userId);
			pstmt.setInt(2, no);
			count = pstmt.executeUpdate();
		} catch (Exception ex) {
			System.out.println("Exception" + ex);
		} finally {
			DBPoolUtil2.dbReleaseClose(rs, pstmt, conn);
		}
		return count;
	}

}
