package com.model;

import com.dao.Function;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public class page<T> {
    @Autowired
    private Function function;

    private int rows;//每页记录数
    private int currentpage;//当前页数
    private int first;//每页第一行
    private List<Hero> lists;//英雄信息列表
    private int pageCount;//总页数
    private int  total;//总记录数

    public int getTotal() {
        total=function.findCount();
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public int getPageCount() {
        return pageCount;
    }

    public void setPageCount(int pageCount) {
        this.pageCount = pageCount;
    }

    public int getFirst() {
        first=(currentpage-1)*rows;
        return first;
    }


    public int getRows() {
        return rows;
    }

    public void setRows(int rows) {
        this.rows = rows;
    }

    public int getCurrentpage() {
        return currentpage;
    }

    public void setCurrenpage(int currenpage) {
        this.currentpage = currenpage;
    }

    public List<Hero> getLists() {
        return lists;
    }

    public void setLists(List<Hero> lists) {
        this.lists = lists;
    }
}
