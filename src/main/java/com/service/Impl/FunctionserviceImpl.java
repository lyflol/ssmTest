package com.service.Impl;

import com.dao.Function;
import com.model.Hero;
import com.model.HeroLogin;
import com.model.page;
import com.service.Functionservice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;


@Service
public class FunctionserviceImpl implements Functionservice {
    @Autowired
    private Function function;

    @Override
    public List<Hero> find(Integer id,String name) {
        return function.find(id,name);
    }


    @Override
    public List<Hero> findAll() {
        return function.findAll();
    }

    @Override
    public void deleteById(int id) {
        function.deleteById(id);
    }

    @Override
    public void update(int id,String name,double money) {
        function.update(id,name,money);
    }

    @Override
    public void insert(int id,String name,double money) {
        function.insert(id,name,money);
    }

    @Override
    public void transf(int idA, int idB, double money) {
        function.transf(idA, idB, money);
    }

    @Override//登陆检查是否存在该用户
    public HeroLogin findUser(String userId) {
        return function.findUser(userId);

    }

    @Override
    public void insertLogin(String userId, String password) {
        function.insertLogin(userId,password);
    }

    //分页
    @Override
    public page<Hero> fenye(int currentpage,int rows) {
        HashMap<String,Object> map= new HashMap<>();
        page pa=new page();//使用这个类封装以下属性
        pa.setCurrenpage(currentpage);//保存当前页数
        pa.setRows(rows);//保存每页记录数

        //总页数
        int totle=function.findCount();//总记录数;
        Double pageCount=  Math.ceil(totle/rows);
        pa.setPageCount(pageCount.intValue());

        //向sql传参Map
        map.put("start",pa.getFirst());
        map.put("rows",pa.getRows());
        //封装分页查询的英雄信息
        List<Hero> list=function.fenye(map);
        pa.setLists(list);

        return pa;
    }
}
