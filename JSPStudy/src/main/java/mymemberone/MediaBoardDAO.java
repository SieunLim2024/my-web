package mymemberone;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import jdbc.DBPoolUtil2;

public class MediaBoardDAO {
	private static MediaBoardDAO instance = null;

	private MediaBoardDAO() {
	}

	public static MediaBoardDAO getInstance() {
		if (instance == null) {
			synchronized (MediaBoardDAO.class) {// 동기화 처리
				instance = new MediaBoardDAO();
			}
		}
		return instance;
	}

	public boolean insertArticle(MediaBoardVO article) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int num = article.getNum();
		int ref = article.getRef();
		int step = article.getStep();
		int depth = article.getDepth();
		int number = 0;
		boolean flag = false;
		String sql = "";
		try {
			conn = DBPoolUtil2.makeConnection();
			// 가장 최근 num 가져온다. => nvl(max(num),0)+1 =freeboard_seq.nextval

			pstmt = conn.prepareStatement("select nvl(max(num),0)+1 from mediaboard");
			rs = pstmt.executeQuery();
			if (rs.next())
				number = rs.getInt(1);
			else
				number = 1;
			if (num != 0) {// 답변글일경우
				sql = "update mediaboard set step=step+1 where ref= ? and step>= ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, step);
				pstmt.executeUpdate();
				step = step + 1;
				depth = depth + 1;
			} else {// 새 글일 경우
				ref = number;
				step = 0;
				depth = 0;
			} // 쿼리를 작성
			sql = "insert into mediaboard(num, writer, email, subject, pass, regdate, ref, step, depth, content, ip, upload, filename) values(mediaboard_seq.nextval,?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, article.getWriter());
			pstmt.setString(2, article.getEmail());
			pstmt.setString(3, article.getSubject());
			pstmt.setString(4, article.getPass());
			pstmt.setTimestamp(5, article.getRegdate());
			pstmt.setInt(6, ref);
			pstmt.setInt(7, step);
			pstmt.setInt(8, depth);
			pstmt.setString(9, article.getContent());
			pstmt.setString(10, article.getIp());
			pstmt.setString(11, article.getUpload());
			pstmt.setString(12, article.getFileName());
			int cnt = pstmt.executeUpdate();
			if (cnt > 0) {
				flag = true;
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			DBPoolUtil2.dbReleaseClose(rs, pstmt, conn);
		}
		return flag;
	}

	public int getArticleCount() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x = 0;
		try {
			conn = DBPoolUtil2.makeConnection();
			pstmt = conn.prepareStatement("select count(*) from mediaboard");
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

	// 글 하나 가져오기 // 전체글 갯수 가져오기(카운트 1 증가 시킨다.)
	public MediaBoardVO getArticle(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MediaBoardVO article = null;
		try {
			conn = DBPoolUtil2.makeConnection();
			pstmt = conn.prepareStatement("update mediaboard set readcount=readcount+1 where num = ?");
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			pstmt = conn.prepareStatement("select * from mediaboard where num = ?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				article = new MediaBoardVO();
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setEmail(rs.getString("email"));
				article.setSubject(rs.getString("subject"));
				article.setPass(rs.getString("pass"));
				article.setRegdate(rs.getTimestamp("regdate"));
				article.setReadcount(rs.getInt("readcount"));
				article.setRef(rs.getInt("ref"));
				article.setStep(rs.getInt("step"));
				article.setDepth(rs.getInt("depth"));
				article.setContent(rs.getString("content"));
				article.setIp(rs.getString("ip"));
				article.setUpload(rs.getString("upload"));
				article.setFileName(rs.getString("filename"));
				
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			DBPoolUtil2.dbReleaseClose(rs, pstmt, conn);
		}
		return article;
	}

	// 전체글 가져오기
	public List<MediaBoardVO> getArticles(int start, int end) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<MediaBoardVO> articleList = null;
		try {
			conn = DBPoolUtil2.makeConnection();
			/* 게시판글을 참조순으로 내림차순처리하고, step 오른차순한 정령 테이블 만든다. 이러한 순으로 페이지정령할 수 있다. 7페이지 = 61~70 (page-1)*10+1 ~page*10 */
			String sql="select * from (select rownum rnum, num, writer,email, subject, pass,"
							+ " regdate, readcount, ref, step, depth, content, ip, upload, filename from (select * from mediaboard" 
					+ " order by ref desc, step asc)) where rnum>=?and rnum<=?";
			pstmt = conn.prepareStatement(sql);// 수정 <3>
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			articleList = new ArrayList<MediaBoardVO>(end-start+1);
			while (rs.next()) {
					MediaBoardVO article = new MediaBoardVO();
					article.setNum(rs.getInt("num"));
					article.setWriter(rs.getString("writer"));
					article.setEmail(rs.getString("email"));
					article.setSubject(rs.getString("subject"));
					article.setPass(rs.getString("pass"));
					article.setRegdate(rs.getTimestamp("regdate"));
					article.setReadcount(rs.getInt("readcount"));
					article.setRef(rs.getInt("ref"));
					article.setStep(rs.getInt("step"));
					article.setDepth(rs.getInt("depth"));
					article.setContent(rs.getString("content"));
					article.setIp(rs.getString("ip"));
					article.setUpload(rs.getString("upload"));
					article.setFileName(rs.getString("filename"));
					articleList.add(article);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			DBPoolUtil2.dbReleaseClose(rs, pstmt, conn);
		}
		return articleList;
	}

	public MediaBoardVO updateGetArticle(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MediaBoardVO article = null;
		try {
			conn = DBPoolUtil2.makeConnection();
			pstmt = conn.prepareStatement("select * from mediaboard where num = ?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				article = new MediaBoardVO();
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setEmail(rs.getString("email"));
				article.setSubject(rs.getString("subject"));
				article.setPass(rs.getString("pass"));
				article.setRegdate(rs.getTimestamp("regdate"));
				article.setReadcount(rs.getInt("readcount"));
				article.setRef(rs.getInt("ref"));
				article.setStep(rs.getInt("step"));
				article.setDepth(rs.getInt("depth"));
				article.setContent(rs.getString("content"));
				article.setIp(rs.getString("ip"));
				article.setUpload(rs.getString("upload"));
				article.setFileName(rs.getString("filename"));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			DBPoolUtil2.dbReleaseClose(rs, pstmt, conn);
		}
		return article;
	}

	public int updateArticle(MediaBoardVO article) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbpasswd = "";
		String sql = "";
		int result = -1;// 결과값
		try {
			conn = DBPoolUtil2.makeConnection();
			pstmt = conn.prepareStatement("select pass from mediaboard where num = ?");
			pstmt.setInt(1, article.getNum());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dbpasswd = rs.getString("pass");// 비밀번호 비교
				if (dbpasswd.equals(article.getPass())) {
					sql = "update mediaboard set writer= ? , email= ?, subject= ? , content= ? , upload=?, filename=? where num= ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, article.getWriter());
					pstmt.setString(2, article.getEmail());
					pstmt.setString(3, article.getSubject());
					pstmt.setString(4, article.getContent());
					pstmt.setString(5, article.getUpload());
					pstmt.setString(6, article.getFileName());
					pstmt.setInt(7, article.getNum());
					pstmt.executeUpdate();
					System.out.println(article.getUpload()+article.getFileName());
					result = 1;// 수정성공
				} else {
					result = 0;// 수정실패
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			DBPoolUtil2.dbReleaseClose(rs, pstmt, conn);
		}
		return result;
	}
	
	
	//글 삭제하기 (원글 삭제하면 답변 글도 삭제하기)
	public int deleteArticle(int num, String pass) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbpasswd = "";
		int result = -1;
		try {
			conn = DBPoolUtil2.makeConnection();
			pstmt = conn.prepareStatement("select pass from mediaboard where num = ?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dbpasswd = rs.getString("pass");
				if (dbpasswd.equals(pass)) {
					pstmt = conn.prepareStatement("delete from mediaboard where num=?");
					pstmt.setInt(1, num);
					pstmt.executeUpdate();
					result = 1; // 글삭제 성공
				} else
					result = 0; // 비밀번호 틀림

			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			DBPoolUtil2.dbReleaseClose(rs, pstmt, conn);
		}
		return result;
	}
	

}
