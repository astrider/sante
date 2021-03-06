package com.astrider.sfc.src.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.astrider.sfc.app.lib.BaseDao;
import com.astrider.sfc.app.lib.Mapper;
import com.astrider.sfc.src.model.vo.db.UserStatsVo;

public class UserStatsDao extends BaseDao {
	public UserStatsDao() {
		super();
	}

	public UserStatsDao(Connection con) {
		super(con);
	}

	public UserStatsVo selectByUserId(int userId) {
		UserStatsVo stats = null;
		PreparedStatement pstmt = null;

		try {
			String sql = "SELECT * FROM user_stats WHERE user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, userId);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Mapper<UserStatsVo> mapper = new Mapper<UserStatsVo>();
				stats = mapper.fromResultSet(rs);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return stats;
	}
}
