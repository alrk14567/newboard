package com.example.newboard.service;

import com.example.newboard.model.UserDTO;
import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
@RequiredArgsConstructor
public class UserService {

    private final int PAGE_SIZE = 20;
    @Autowired
    private SqlSession session;

    private final String NAMESPACE = "com.example.mappers.UserMapper";

    public UserDTO auth(UserDTO userDTO) {
        return session.selectOne(NAMESPACE + ".auth", userDTO);
    }

    public boolean validateUsername(String username) {
        return session.selectOne(NAMESPACE + ".selectByUsername", username)==null;
    }

    public boolean validateNickname(String nickname) {
        return session.selectOne(NAMESPACE + ".selectByNickname", nickname)==null;
    }

    public void register(UserDTO userDTO) {
        session.insert(NAMESPACE + ".register", userDTO);
    }

    public List<UserDTO> selectAll(int pageNo) {
        HashMap<String, Integer> paramMap = new HashMap<>();
        paramMap.put("startRow", (pageNo - 1) * PAGE_SIZE);
        paramMap.put("size", PAGE_SIZE);

        return session.selectList(NAMESPACE + ".selectAll", pageNo);
    }

    public int selectMaxPage() {
        int maxRow = session.selectOne(NAMESPACE + ".selectMaxRow");
        int maxPage = maxRow / PAGE_SIZE;

        if (maxRow % PAGE_SIZE != 0) {
            maxPage++;
        }

        return maxPage;
    }
}
