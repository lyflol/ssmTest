package com.dao;

import com.model.Hero;
import com.model.HeroLogin;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
@Repository
public interface Function {
    public List<Hero> find(@Param("id")Integer id,@Param("name") String name);//根据条件查询英雄信息
    public List<Hero> findAll();
    public void deleteById(int id);
    public void update(int id,String name,double money);
    public void insert(int id,String name,double money);
    public void transf(int idA,int idB,double money);
    public HeroLogin findUser(String userId);
    public void insertLogin(@Param("userId") String userId,@Param("password") String password);
    //分页
    public int findCount();//记录总数
    public List<Hero> fenye(HashMap<String,Object> map);

}
