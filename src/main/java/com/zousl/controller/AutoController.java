package com.zousl.controller;

import com.alibaba.fastjson.JSON;
import com.zousl.service.AutoService;
import com.zousl.utils.FreeMarkertUtil;
import com.zousl.utils.SingleConfigConst;
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
        def.setAddButtonType("pop");
        def.setAuthor("zousl@meicloud.com");
        def.setEntity("ZslDemoOrderSingle");
        def.setTableComment("测试单表生成");
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
     * 生成代码按钮响应接口
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

    private void autoFile(BaseDef baseDef) {
//        String table = "zsl_demo_order_single";
        Map<String,Object> params = new HashMap<>();
//        params.put("tableName",table);

        params.put("tableName",baseDef.getTableName());

//        BaseDef def = new BaseDef();
//        def.setTableName("zsl_demo_order_single");
//        def.setAddButtonType("pop");
//        def.setAuthor("zousl@meicloud.com");
//        def.setEntity("ZslDemoOrderSingle");
//        def.setTableComment("测试单表生成");

        try {
            List<TableDef> tables = autoService.getColumns(params, false);
//            createController(def, tables);
            createListW(tables,baseDef);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void createController(BaseDef def, List<TableDef> tables) throws IOException {
        Map<String, Object> root = new HashMap<String, Object>();
        root.put("entity", def.getEntity());
        root.put("tableComment", def.getTableComment());
        root.put("tableName", def.getTableName());
        root.put("author", def.getAuthor());//作者
        root.put("corePackageName", BASE_CORE_PACKAGE_NAME);//核心基本包名称
        root.put("controllerCorePackageName",  BASE_CORE_PACKAGE_PATH.replaceAll("\\\\","_"));//核心基本包名称
        root.put("moduleWFileName", String.valueOf(MODULE_W_FILE_NAME));//前端的最后一个目录
        root.put("tabledef", tables);
        root.put("isTitleSearch",isTitleSearch);
        Writer out = new OutputStreamWriter(System.out);
        FreeMarkertUtil freemk = new FreeMarkertUtil("D:\\二代开发工具\\secondAutoCode\\src\\main\\resources\\templates", "controller.ftl");
        String fileUrl = "D://work";
        String fileName = def.getEntity() + "Controller.java";
        freemk.processTemplate(root, out, fileUrl, fileName);
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
            if(SingleConfigConst.EXCLUDE_FIELD.contains(code) || "true".equalsIgnoreCase(isPk)){
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
