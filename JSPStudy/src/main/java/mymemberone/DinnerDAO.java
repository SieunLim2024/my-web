package mymemberone;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import jdbc.DBPoolUtil2;

public class DinnerDAO {
	private static DinnerDAO instance = null;
	private DinnerDAO() {
		
	}
	public static DinnerDAO getInstance() {
		if(instance==null) {
			synchronized (DinnerDAO.class) {//동기화처리
				instance = new DinnerDAO();
				
			}
		}
		return instance;
	}
	public List<DinnerVO> getArticles(){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<DinnerVO> articleList = null;
		try {
			conn = DBPoolUtil2.makeConnection();
			String sql="select * from dinner order by dinnerdate desc, dinnertime asc";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			articleList = new ArrayList<DinnerVO>();
			while (rs.next()) {
					DinnerVO article = new DinnerVO();
					article.setNo(rs.getInt("no"));
					article.setDinnerdate(rs.getString("dinnerdate"));
					article.setDinnertime(rs.getString("dinnertime"));
					article.setDinnertype(rs.getString("dinnertype"));
					article.setPrice(rs.getInt("price"));
					System.out.println(rs.getString("dinnertype"));
					articleList.add(article);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			DBPoolUtil2.dbReleaseClose(rs, pstmt, conn);
		}
		return articleList;
	}
//	public List<DinnerVO> getArticles(int start, int end){
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		List<DinnerVO> articleList = null;
//		try {
//			conn = DBPoolUtil2.makeConnection();
//			String sql="select * from (select rownum rnum, no, dinnerdate, dinnertime, dinnertype, price"
//					+ " from (select * from dinner" 
//					+ " order by dinnerdate desc, dinnertime asc)) where rnum>=?and rnum<=?";
//			pstmt.setInt(1, start);
//			pstmt.setInt(2, end);
//			rs = pstmt.executeQuery();
//			articleList = new ArrayList<DinnerVO>(end-start+1);
//			while (rs.next()) {
//					DinnerVO article = new DinnerVO();
//					article.setNo(rs.getInt("no"));
//					article.setDinnerdate(rs.getString("dinnerdate"));
//					article.setDinnertime(rs.getString("dinnertime"));
//					article.setDinnertype(rs.getString("dinnertype"));
//					article.setPrice(rs.getInt("price"));
//					articleList.add(article);
//			}
//		} catch (Exception ex) {
//			ex.printStackTrace();
//		} finally {
//			DBPoolUtil2.dbReleaseClose(rs, pstmt, conn);
//		}
//		return articleList;
//	}
	
	public int getArticleCount() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x = 0;
		try {
			conn = DBPoolUtil2.makeConnection();
			pstmt = conn.prepareStatement("select count(*) from dinner");
			rs = pstmt.executeQuery();
			if (rs.next()) {
				x = rs.getInt(1);
			}
		} catch (Exception ex) {
			ex.printStackTrace();

		} finally {
			DBPoolUtil2.dbReleaseClose(rs, pstmt, conn);
		}
		return x;
	}
}