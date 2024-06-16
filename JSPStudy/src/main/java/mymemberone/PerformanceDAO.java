package mymemberone;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import jdbc.DBPoolUtil2;

public class PerformanceDAO {
	private static PerformanceDAO instance = null;

	private PerformanceDAO() {
	}

	public static PerformanceDAO getInstance() {
		if (instance == null) {
			synchronized (PerformanceDAO.class) {// 동기화처리
				instance = new PerformanceDAO();
			}
		}
		return instance;
	}

	public List<PerformanceVO> getArticles(String genre) {
		List<PerformanceVO> performanceList = null;
		String sql = "CALL PERFORMANCETBL_SELECT(?,?)";
		Connection con = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		try {
			performanceList = new ArrayList<PerformanceVO>();
			con = DBPoolUtil2.makeConnection();
			cstmt = con.prepareCall(sql);
			cstmt.setString(1,genre);
			cstmt.registerOutParameter(2, Types.REF_CURSOR);
			cstmt.execute();
			rs = (ResultSet) cstmt.getObject(2);
			while (rs.next()) {
				PerformanceVO p = new PerformanceVO();
				p.setPerformanceId(rs.getString("performanceid"));
				p.setPerformanceName(rs.getString("performancename"));
				p.setGenre(rs.getString("genre"));
				p.setDayOfPerformance(rs.getString("dayofperformance"));
				p.setVenue(rs.getString("venue"));
				p.setLimitAge(rs.getInt("limitage"));
				p.setTotalSeats(rs.getInt("totalseats"));
				p.setSoldSeats(rs.getInt("soldseats"));
				p.setTicketPrice(rs.getInt("ticketprice"));
				p.setYseats(rs.getInt("yseats"));
				p.setXseats(rs.getInt("xseats"));

				performanceList.add(p);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBPoolUtil2.dbReleaseClose(rs, cstmt, con);
		}
		return performanceList;
	}

	public int insertArticle(PerformanceVO vo) {
		String sql = "CALL performancetbl_insert(?,?,?,?,?,?,?,?,?,?)";
		Connection con = null;
		CallableStatement cstmt = null;
		int value=-1;
		try {
			con = DBPoolUtil2.makeConnection();
			cstmt = con.prepareCall(sql);
			cstmt.setString(1, vo.getPerformanceId());
			cstmt.setString(2, vo.getPerformanceName());
			cstmt.setString(3, vo.getGenre());
			cstmt.setString(4, vo.getDayOfPerformance());
			cstmt.setString(5, vo.getVenue());
			cstmt.setInt(6, vo.getLimitAge());
			cstmt.setInt(7, vo.getTotalSeats());
			cstmt.setInt(8, vo.getTicketPrice());
			cstmt.setInt(9, vo.getYseats());
			cstmt.setInt(10, vo.getXseats());

			value = cstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBPoolUtil2.dbReleaseClose(null, cstmt, con);
		}
		return value;
	}
	public int getArticleCount(String genre) {
		int cnt = 0;
		Connection con = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		try {
			String sql = "{CALL PERFORMANCETBL_COUNT(?,?)}";
			con =DBPoolUtil2.makeConnection();
			cstmt = con.prepareCall(sql);
			cstmt.setString(1,genre);
			cstmt.registerOutParameter(2, Types.INTEGER);

			cstmt.executeQuery();
			cnt = cstmt.getInt(2);

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBPoolUtil2.dbReleaseClose(rs, cstmt, con);
		}
		return cnt;
	}

}
