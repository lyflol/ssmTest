package com.service;

import com.model.Hero;
import com.model.HeroLogin;
import com.model.page;

import java.util.List;

public interface Functionservice {
    public List<Hero> find(Integer id,String name);
    public List<Hero> findAll();
    public void deleteById(int id);
    public void update(int id,String name,double money);
    public void insert(int id,String name,double money);
    public void transf(int idA,int idB,double money);
    public HeroLogin findUser(String userId);
    public void insertLogin(String userId,String password);
    public page<Hero> fenye(int currentpage,int rows);
}
