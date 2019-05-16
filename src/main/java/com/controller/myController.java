package com.controller;

import com.model.Hero;
import com.model.HeroLogin;
import com.model.page;
import com.service.Functionservice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/app")
public class myController {
    @Autowired
    private Functionservice fc;

    //登陆检查
    @RequestMapping("/checklogin")
    @ResponseBody
    public Map<String,Object> checklogin(@RequestParam String username , @RequestParam String password){
        String str=password;
        Map<String,Object> resultMap = new HashMap<String, Object>();
        HeroLogin hl=fc.findUser(username);
        if(hl==null){
            resultMap.put("result","failA");
        }else if (!str.equals(hl.getPassword())){//验证密码是否正确
            resultMap.put("result","failB");
        }else {
            resultMap.put("result","success");
        }
        return resultMap;
    }

    //注册业务处理
    @RequestMapping("/checkZhuce")
    @ResponseBody
    public Map<String,Object> checkZhuce(@RequestParam String username , @RequestParam String password) {
        HeroLogin hl=fc.findUser(username);
        Map<String,Object> resultMap=new HashMap<String,Object>();
        if (hl==null){
            fc.insertLogin(username,password);
             resultMap.put("result","yes");
        }else{
             resultMap.put("result","no");
        }
        return resultMap;
    }


    //登录成功后跳转到all.jsp,再由all.jsp里的 <table url="allA">进行查询所有英雄
    @RequestMapping("/allHero")
    public String findAlljsp(){
        return "all";
  }

//查询所有英雄，直接在数据网格里显示
     @RequestMapping("/allA")
     @ResponseBody
    public List<Hero> findAll(){
        List<Hero> heroList=fc.findAll();
        return heroList;
    }
    //模糊查询
    @RequestMapping("/find")
    @ResponseBody
    public List<Hero> find(@RequestParam("id") Integer id,@RequestParam("name")String name){
        List<Hero> heroList=fc.find(id,name);
        return  heroList;
    }

    @RequestMapping("/fenye")
    @ResponseBody
    public Map<String,Object> fenye(int page,int rows){
        HashMap<String,Object> map=new HashMap<>();
        page pa=fc.fenye(page,rows);
        List<Hero> list=pa.getLists();
        map.put("rows",list);//数据列表
        map.put("total",pa.getTotal());//总记录数
        return map;
    }
    //插入操作
    @RequestMapping("/insert")
    @ResponseBody
    public Map<String,Object>  insertHero(int id,String name,double money){
        Map<String,Object> msg=new HashMap<>();
        msg.put("result","success");
        try{fc.insert(id,name,money);
        }catch (Exception ex){
             msg.put("result","fail");
        }finally {
            return msg;
        }
    }


    //删除操作
    @RequestMapping("/delete")
    @ResponseBody
    public Map<String,Object> delete(int id){
        Map<String,Object> msg=new HashMap<>();
        msg.put("result","success");
        try{
            fc.deleteById(id);

        }catch (Exception ex){
            msg.put("result","fail");
        }finally {
            return msg;
        }
    }
    //修改操作
    @RequestMapping("/update")
    @ResponseBody
    public Map<String,Object> update(int id,String name,double money){
        Map<String,Object> msg=new HashMap<>();
        msg.put("result","success");
        try{
            fc.update(id,name,money);}
        catch (Exception ex){
            msg.put("result","fail");
        }finally {
            return msg;
        }
    }

    //事务管理，转账
    @Transactional//启动事务管理，保证错误操作下的事务回滚
    @RequestMapping("/transf")
    @ResponseBody
    public Map<String,Object> transf(int idA,int idB,double moneyA){
        Map<String,Object> msg=new HashMap<>();
        msg.put("result","success");
        try{
              fc.transf(idA,idB,moneyA);
        }
        catch (Exception ex){
            msg.put("result","fail");
        }finally {
            return msg;
        }
    }
}
