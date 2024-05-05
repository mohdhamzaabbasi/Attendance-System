const express=require("express");
const app=express();
let port=8080;
const path=require("path");
const over=require("method-override");
app.use(over("_method"));
app.listen(port,()=>{
});
app.use(express.urlencoded({extended : true}));
app.set("view engine","ejs");
app.set("views",path.join(__dirname,"views"));
app.use(express.static(path.join(__dirname,"public")));
const mysql = require('mysql2');
const { count, Console } = require("console");
const connection=mysql.createConnection({
host: 'localhost',
user: 'root',
database: 'info',
password: 'Hamzalfs@7086'
});
let q="USE ATTENDANCE";
try{
    connection.query(q,(err,res)=>{
        if(err)
        {
            throw err; 
        }
        console.log("started!!");
    });
} catch{
    console.log("eRROR");
}       
app.get("/newclass",(req,res)=>{
    res.render("indexnew.ejs");
});
app.post("/qr",(req,respo)=>{
    let data=req.body;
    console.log(data);
    let q=`SELECT * FROM COURSE WHERE SECID = (SELECT SECID FROM SECTION WHERE SECNAME='${data.sec}') AND SID = (SELECT SID FROM SUBJECT WHERE SNAME='${data.sub}') AND FID = (SELECT FID FROM FACULTY WHERE FPASS=${data.pass})`;
    connection.query(q,(err,resp)=>
    {
        if(err)
        {
            throw err; 
        }
        console.log(resp);
        if(resp.length==0)
        {
            respo.redirect("/newclass");
        }
        else
        {
            let qt="SELECT * FROM CLASS";
            try{
                connection.query(qt,(err,res)=>{
                    if(err)
                    {
                        throw err; 
                    }
                    const date=new Date();
                    let qts=`INSERT INTO CLASS (CID, SID, FID,TIMESTAMP, STATUS, secid) VALUE(${res.length+1},${resp[0].SID},${resp[0].FID}, '2024-03-16 12:00:00',FALSE,${resp[0].SECID});`;
                    try{
                        connection.query(qts,(err,rest)=>{
                            if(err)
                            {
                                throw err; 
                            }
                            data.id=res.length+1;
                            console.log("ye hai sex");
                            console.log(data);
                            respo.render("newqrgen.ejs",{data});
                        });
                    } catch{
                        console.log("eRROR");
                    }
                });
            } catch{
                console.log("eRROR");
            }   
            console.log("****0");
            console.log(data);
            
        }
    });
});  
app.get("/:branch/:batch/:sec/:sub/:deadline",(req,res)=>{
    console.log("SUCCESS AA GAYA");
    let {branch}=req.params;  
    let bra=branch;
    let {batch}=req.params;
    let bat=batch;
    let {sec}=req.params;
    let section=sec;
    let {sub}=req.params;
    let subject=sub;
    let {deadline}=req.params;
    let dead=deadline;
    let qt="SELECT * FROM CLASS";
            try{
                connection.query(qt,(err,rest)=>{
                    if(err)
                    {
                        throw err; 
                    }
                    let data=[bra,bat,section,subject,rest.length];
                    const date=new Date();
                    const key=date.getHours()*3600+date.getMinutes()*60+date.getSeconds();
                    if((key-dead)<=8)
                    {
                        console.log("SUCCESS");
                        res.render("prncall.ejs",{data});
                    }
                    else
                    {
                        res.render("failure.ejs");
                    }
                });
            } catch{
                console.log("eRROR");
            }
    
});
app.post("/marking",(req,res)=>{
    let data=req.body;
    console.log(data);
    let qts=`INSERT INTO ATTENDANCE (PRN,CID) VALUE(${data.prn},${data.cid});`;
    try{
        connection.query(qts,(err,rest)=>{
            if(err)
            {
                res.render("prncall.ejs",{data});
            }
            else{
                res.render("success.ejs");
            }
            
        });
    }catch{
        res.send("Access Denied!!");
        console.log("eRROR");
    }
}); 

app.post("/list",(req,res)=>{
    let data=req.body;
    let clid=data.cid;
    console.log(data);
    let qts=`Select PRN, SNAME FROM STUDENT WHERE PRN IN (SELECT PRN FROM ATTENDANCE WHERE CID = ${clid})`;
    try{
        connection.query(qts,(err,rest)=>{
            if(err)
            {
                res.send("Failure");
            }
            console.log("kya hua?");
            console.log(rest);
            res.render("list.ejs",{rest});
            
        });
    }catch{
        res.send("Access Denied!!");
        console.log("eRROR");
    }
}); 
