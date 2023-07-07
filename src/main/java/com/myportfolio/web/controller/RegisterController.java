package com.myportfolio.web.controller;

import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.validation.Valid;

import com.myportfolio.web.dao.UserDao;
import com.myportfolio.web.domain.UserDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.beans.propertyeditors.StringArrayPropertyEditor;
import org.springframework.core.convert.ConversionService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Validator;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

@Controller // ctrl+shift+o 자동 import
@RequestMapping("/register")
public class RegisterController {
    @Autowired
    UserDao userDao;

    final int FAIL = 0;

    @InitBinder
    public void toDate(WebDataBinder binder) {
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(df, false));
        binder.setValidator(new UserValidator()); // UserValidator를 WebDataBinder의 로컬 validator로 등록
        //	List<Validator> validatorList = binder.getValidators();
        //	System.out.println("validatorList="+validatorList);
    }

    @GetMapping("/checkId")
    public ResponseEntity<String> checkId(@RequestParam String userid) {
        try {
            int rowCnt = userDao.countId(userid);
            if (rowCnt == 0) {
                return new ResponseEntity<>("ID_OK", HttpStatus.OK);
            }
            throw new Exception(("Id Failed"));
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("ID_ERR", HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping("/add")
    public String register() {
        return "registerForm"; // WEB-INF/views/registerForm.jsp
    }

    @PostMapping("/add")
    public String save(@Valid UserDto user, BindingResult result, Model m) throws Exception {
        System.out.println("result="+result);
        System.out.println("user="+user);

        // User객체를 검증한 결과 에러가 있으면, registerForm을 이용해서 에러를 보여줘야 함.
        if(!result.hasErrors()) { //1. 에러 없음
            // 2. DB에 신규회원 정보를 저장
            int rowCnt = userDao.insert(user);

            if(rowCnt!=FAIL) {
                m.addAttribute("msg", "reg_ok");
                return "index";
            }
            m.addAttribute("msg", "reg_no");
            return "registerForm";
        }
        m.addAttribute("msg", "reg_no");
        return "registerForm";
    }
}