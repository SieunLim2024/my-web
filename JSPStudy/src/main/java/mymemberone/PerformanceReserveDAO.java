package mymemberone;

public class PerformanceReserveDAO {
	public static PerformanceReserveDAO instance=null;
	private PerformanceReserveDAO() {
		
	}
	
	public PerformanceReserveDAO getInstance() {
		if(instance==null) {
			synchronized (PerformanceReserveDAO.class) {
				instance = new PerformanceReserveDAO();
			}
		}
		return instance;
	}

}
