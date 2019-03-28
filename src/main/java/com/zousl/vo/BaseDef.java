package com.zousl.vo;

import lombok.Data;

/**
 * Created by ZOUSL1 on 2019-3-18.
 */
@Data
public class BaseDef {
    // 核心基本包名称
    private String basePackage;
    // 对象名称
    private String entity;
    // 表名称
    private String tableName;
    // 表注释
    private String tableComment;
    // 作者
    private String author;
    // 添加按钮的模式
    private String addButtonType;
    // 是否是父表 y 是  n 不是
    private String isParent;
    // 模板的存放路径
    private String fromUrl;
    // 生成文件的输出路径
    private String toUrl;
    // 前端的最后一个目录
    private String justepCatalog;
    // 是否启用表头搜索
    private String isTitleSearch;
    // 作为查询条件的字段
    private String asSearchKey;
}
