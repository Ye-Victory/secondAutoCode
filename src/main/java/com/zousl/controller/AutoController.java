package com.zousl.controller;

import com.alibaba.fastjson.JSON;
import com.zousl.service.AutoService;
import com.zousl.utils.FreeMarkertUtil;
import com.zousl.utils.StringUtils;
import com.zousl.vo.BaseDef;
import com.zousl.vo.TableDef;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.zousl.utils.SingleConfigConst.*;

/**
 * Created by ZOUSL1 on 2019-3-12.
 */

/**
 * @RestController 返回的是一段json数据
 * @Controller 返回视图
 */
@Controller
public class AutoController {

    @Autowired
    AutoService autoService;

    /**
     * 登录，跳转到login.html视图
     * @param model
     * @return
     */
    @RequestMapping("/login")
    public String login(Model model){
        // 提供默认的配置信息
        BaseDef def = new BaseDef();
        def.setTableName("zsl_demo_order_single");
        def.setAddButtonType("popUp");
        def.setAuthor("zousl@meicloud.com");
        def.setEntity("ZslDemoOrderSingle");
        def.setTableComment("测试单表生成");
        def.setFromUrl("D:\\二代开发工具\\secondAutoCode\\src\\main\\resources\\templates\\freemarker");
        def.setToUrl("D://work");
        def.setBasePackage("com\\zousl");
        def.setJustepCatalog("cmha");
        def.setIsTitleSearch("false");
        def.setAsSearchKey("orderNo,orderMount,orderTotalPrice,orderUserName,orderComment");
        model.addAttribute("baseDef",def);
        return "login";
    }

    @RequestMapping("/getDataSource")
    public String getDataSource(String source){
        List<String> dataSource = autoService.getDataSource(source);
        return JSON.toJSONString(dataSource);
    }

    @RequestMapping("/getColumns")
    public String getColumns(){
        String table = "zsl_demo_order_single";
        Map<String,Object> params = new HashMap<>();
        params.put("tableName",table);
        List<TableDef> tables = new ArrayList<>();
        try {
            tables = autoService.getColumns(params, false);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return JSON.toJSONString(tables);
    }

    /**
     * 生成代码一键响应接口
     * @param baseDef
     * @return
     */
    @RequestMapping("/autoCode")
    public String autoCode(@ModelAttribute BaseDef baseDef){
        try {
            autoFile(baseDef);
        }catch (Exception e){
            return "fail";
        }
        return "success";
    }

    private void autoFile(BaseDef baseDef) throws Exception {
        Map<String,Object> params = new HashMap<>();
        params.put("tableName",baseDef.getTableName());
        List<TableDef> tables = autoService.getColumns(params, false);
        createController(baseDef);
        createService(baseDef);
        createServiceImpl(baseDef);
        createDao(baseDef);
        createDaoXml(baseDef,tables);
        createEntity(baseDef,tables);
//        createListW(tables,baseDef);
    }

    /**
     * 生成entity文件
     * @param def
     * @param tables
     */
    private void createEntity(BaseDef def, List<TableDef> tables) throws IOException {
        long currentTimeMillis=System.currentTimeMillis();
        Map<String, Object> root = new HashMap<String, Object>();
        root.put("currentTimeMillis", String.valueOf(currentTimeMillis));
        root.put("entity", def.getEntity());
        root.put("tableComment", def.getTableComment());
        root.put("tableName", def.getTableName());
        root.put("classsName", def.getEntity());
        root.put("author", def.getAuthor());//作者
        root.put("corePackageName", def.getBasePackage());//核心基本包名称
        root.put("tabledef", tables);
        Writer out = new OutputStreamWriter(System.out);
        FreeMarkertUtil freemk = new FreeMarkertUtil(def.getFromUrl(), "entity.ftl");
        String fileName = def.getEntity()+ ".java";
        freemk.processTemplate(root, out, def.getToUrl(), fileName);
        out.flush();
    }

    /**
     * 生成dao.xml文件
     * @param def
     * @param tables
     */
    private void createDaoXml(BaseDef def, List<TableDef> tables) throws IOException {
        Map<String, Object> root = new HashMap<String, Object>();
        root.put("entity", def.getEntity());
        root.put("corePackageName", def.getBasePackage().replaceAll("\\\\","."));
        root.put("tableName",def.getTableName());

        String tablePk = "";
        for(TableDef baseDef : tables){
            String isPk = baseDef.getIsPk();
            if("true".equalsIgnoreCase(isPk)){
                tablePk = baseDef.getTableCode();//获取主键
                break;
            }
        }
        root.put("tablePk",tablePk);

        List<TableDef> tableDefList = new ArrayList<>();
        // 显示查询的字段
        for(TableDef tableDef : tables){
            if (def.getAsSearchKey().contains(tableDef.getCode())){
                tableDefList.add(tableDef);
            }
        }
        root.put("dataTabledef", tableDefList);
        root.put("tabledef",tables);
        Writer out = new OutputStreamWriter(System.out);
        FreeMarkertUtil freemk = new FreeMarkertUtil(def.getFromUrl(), "daoXml.ftl");
        String fileName = def.getEntity() + "Dao.xml";
        freemk.processTemplate(root, out, def.getToUrl(), fileName);
        out.flush();
    }

    /**
     * 生成dao文件
     * @param def
     */
    private void createDao(BaseDef def) throws IOException {
        Map<String, Object> root = new HashMap<String, Object>();
        root.put("entity", def.getEntity());
        root.put("tableComment", def.getTableComment());
        root.put("corePackageName", def.getBasePackage().replaceAll("\\\\","."));
        root.put("author", def.getAuthor());
        Writer out = new OutputStreamWriter(System.out);
        FreeMarkertUtil freemk = new FreeMarkertUtil(def.getFromUrl(), "dao.ftl");
        String fileName = def.getEntity() + "Dao.java";
        freemk.processTemplate(root, out, def.getToUrl(), fileName);
        out.flush();
    }

    /**
     * 生成serviceImpl文件
     * @param def
     */
    private void createServiceImpl(BaseDef def) throws IOException {
        Map<String, Object> root = new HashMap<String, Object>();
        root.put("entity", def.getEntity());
        root.put("tableComment", def.getTableComment());
        root.put("corePackageName", def.getBasePackage().replaceAll("\\\\","."));
        root.put("author", def.getAuthor());
        root.put("isTitleSearch", def.getIsTitleSearch());
        root.put("classsName", def.getEntity());
        Writer out = new OutputStreamWriter(System.out);
        FreeMarkertUtil freemk = new FreeMarkertUtil(def.getFromUrl(), "serviceImp.ftl");
        String fileName = def.getEntity() + "ServiceImpl.java";
        freemk.processTemplate(root, out, def.getToUrl(), fileName);
        out.flush();
    }

    /**
     * 生成service文件
     * @param def
     */
    private void createService(BaseDef def) throws IOException {
        Map<String, Object> root = new HashMap<String, Object>();
        root.put("entity", def.getEntity());
        root.put("tableComment", def.getTableComment());
        root.put("corePackageName", def.getBasePackage().replaceAll("\\\\","."));
        root.put("author", def.getAuthor());
        root.put("isTitleSearch",def.getIsTitleSearch());
        Writer out = new OutputStreamWriter(System.out);
        FreeMarkertUtil freemk = new FreeMarkertUtil(def.getFromUrl(), "service.ftl");
        String fileName = def.getEntity() + "Service.java";
        freemk.processTemplate(root, out, def.getToUrl(), fileName);
        out.flush();
    }

    /**
     * 生成controller文件
     * @param def
     * @throws IOException
     */
    private void createController(BaseDef def) throws IOException {
        Map<String, Object> root = new HashMap<String, Object>();
        root.put("entity", def.getEntity());
        root.put("tableComment", def.getTableComment());
        root.put("author", def.getAuthor());
        root.put("corePackageName", def.getBasePackage().replaceAll("\\\\","."));
        root.put("controllerCorePackageName", def.getBasePackage().replaceAll("\\\\","_"));
        root.put("moduleWFileName", def.getJustepCatalog());
        root.put("isTitleSearch",def.getIsTitleSearch());
        Writer out = new OutputStreamWriter(System.out);
        FreeMarkertUtil freemk = new FreeMarkertUtil(def.getFromUrl(), "controller.ftl");
        String fileName = def.getEntity() + "Controller.java";
        freemk.processTemplate(root, out, def.getToUrl(), fileName);
        out.flush();
    }

    private void createListW(List<TableDef> tables, BaseDef baseDef) throws IOException {
        Map<String, Object> root = new HashMap<String, Object>();
        String entity = baseDef.getEntity();
        root.put("entity",entity);
        root.put("dataTabledefAll", tables);

        List<TableDef> tableDefList = new ArrayList<>();
        for(TableDef tableDef :tables ){//排除不显示的字段
            String code = tableDef.getCode();
            String isPk = tableDef.getIsPk();
            if(EXCLUDE_FIELD.contains(code) || "true".equalsIgnoreCase(isPk)){
                continue;
            }
            tableDefList.add(tableDef);
        }
        root.put("dataTabledef", tableDefList);
        Writer out = new OutputStreamWriter(System.out);
        FreeMarkertUtil freemk = new FreeMarkertUtil("D:\\二代开发工具\\secondAutoCode\\src\\main\\resources\\templates","listW.ftl");
        String fileUrl = "D://work";
        String fileName = StringUtils.lowerFirstCapse(entity)+ "List.w";
        freemk.processTemplate(root, out, fileUrl, fileName);
        out.flush();
    }
}
