package mymemberone;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import jdbc.DBPoolUtil2;

public class SeatDAO {
	public static SeatDAO instance = null;

	private SeatDAO() {

	}

	public static SeatDAO getInstance() {
		if (instance == null) {
			synchronized (SeatDAO.class) {
				instance = new SeatDAO();
			}
		}
		return instance;
	}

	public List<SeatVO> getArticles(String id) {
		List<SeatVO> list = null;
		String sql = "CALL SEAT_SELECT(?,?)";
		Connection con = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		try {
			list = new ArrayList<SeatVO>();
			con = DBPoolUtil2.makeConnection();
			cstmt = con.prepareCall(sql);
			cstmt.setString(1, id);
			cstmt.registerOutParameter(2, Types.REF_CURSOR);
			cstmt.execute();
			rs = (ResultSet) cstmt.getObject(2);
			while (rs.next()) {
				SeatVO s = new SeatVO();
				s.setNo(rs.getInt("no"));
				s.setPerformanceId(rs.getString("performanceid"));
				s.setYseats(rs.getInt("yseats"));
				s.setXseats(rs.getInt("xseats"));
				s.setState(rs.getString("state"));

				list.add(s);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBPoolUtil2.dbReleaseClose(rs, cstmt, con);
		}
		return list;
	}

}
