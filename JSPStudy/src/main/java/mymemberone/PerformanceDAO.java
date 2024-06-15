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
	
	public static List<PerformanceVO> getArticles() {
		List<PerformanceVO> performanceList=null;
		String sql = "CALL PERFORMANCETBL_SELECT(?)";
		Connection con = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		try {
			performanceList = new ArrayList<PerformanceVO>();
			con = DBPoolUtil2.makeConnection();
			cstmt = con.prepareCall(sql);
			cstmt.registerOutParameter(1, Types.REF_CURSOR);
			cstmt.execute();
			rs=(ResultSet)cstmt.getObject(1);
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
	
}
