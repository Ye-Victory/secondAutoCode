package com.zousl.utils;

/**
 * Created by LINSB on 2019-2-16.
 * 配置基本信息
 */
public class SingleConfigConst {
    /**
      -------------------------------------------
     设置数据库名称，必须要配置
      ------------------------------------------
     */
    public static final String DATA_BASE = "test_cat_zsl";//数据库名称
    public static String CONNECTION_NAME  = "jdbc:mysql://10.17.145.78:3306/"+DATA_BASE+"?useUnicode=true&characterEncoding=UTF-8";
    public static String CON_USER = "appdba";//数据库账号
    public static String CON_PWD = "d1b4a_s5cc.78"; //数据库密码

    /**
     -------------------------------------------
     项目配置，必须要配置
     ------------------------------------------
     */
    public static final String PROJECT_PATH="D:\\singleDataSource"; //项目的根路径，必须要配置
    public static final String BASE_CORE_PACKAGE_PATH="com\\zousl";//项目的基本模块路径，必须配置
    //排除不显示的字段，中间用逗号隔开,驼峰命名，可以控制在 list.vue分页显示字段 和detail.vue 需要显示的字段表单
    public static  String EXCLUDE_FIELD="startDate,endDate"+"creationDate,createdBy,lastUpdateDate,lastUpdatedBy," +
            "globalId,globalSid,globalOrder,ownerId,ownerSid,ownerOrder,dsSid,version,isDelete";


    /*
     生成 vue前端模块配置
    */
    public static   String MODULE_W_FILE_NAME = "cmha";//前端模块名称，即在cdcui下的文件夹名称，修改成对应的模块即可
    public static  String LIST_W_PATH = "D:\\DevProgram\\WeX533R\\model\\UI2\\cdcui\\"+MODULE_W_FILE_NAME+"\\";
    //是否启动标题搜索
    public static String isTitleSearch ="false";//默认是false 取值为 false/true

    /**
     -------------------------------------------
     代码生成器配置，必须要配置
     ------------------------------------------
     */
    public static final String AUTO_CODE_PATH ="D:\\autocode\\"; //代码生成器的根路径，必须要配置

    /**
     -------------------------------------------
     以下不需要配置
     ------------------------------------------
     */
    //核心包名 不需要配置
    public static  String BASE_CORE_PACKAGE_NAME=BASE_CORE_PACKAGE_PATH.replaceAll("\\\\",".");
    //entity类生成路径
    public static final String ENTITY_PATH = PROJECT_PATH+"\\src\\main\\java\\"+BASE_CORE_PACKAGE_PATH+"\\";
    //服务接口路径
    public static final String SERVICE_PATH = PROJECT_PATH+"\\src\\main\\java\\"+BASE_CORE_PACKAGE_PATH+"\\";
    //服务实现路径
    public static final String SERVICEIMPL_PATH = PROJECT_PATH+"\\src\\main\\java\\"+BASE_CORE_PACKAGE_PATH+"\\";
    //业务中转路径
    public static final String CONTROLLER_PATH = PROJECT_PATH+"\\src\\main\\java\\"+BASE_CORE_PACKAGE_PATH+"\\";
    //DAO路径
    public static final String DAO_PATH = PROJECT_PATH+"\\src\\main\\java\\"+BASE_CORE_PACKAGE_PATH+"\\";
    //DAO_XML 路径
    public  static final String DAO_XML_PATH = PROJECT_PATH+"\\src\\main\\java\\"+BASE_CORE_PACKAGE_PATH+"\\";
    /*配置模板路径*/
    public static final String TEMPLETE_PATH = AUTO_CODE_PATH+"src\\main\\webapp\\template\\singleMeicloud";
    /*
    JAVA后台模板路径
     */
    public static final String TEMPLETE_JAVA_PATH =TEMPLETE_PATH+"\\java";
    /*
    w 模板路径
     */
    public static final String TEMPLETE_W_PATH = TEMPLETE_PATH + "\\w";
}
