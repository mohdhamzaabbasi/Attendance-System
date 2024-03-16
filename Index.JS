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
const { count } = require("console");
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
    });
} catch{
    console.log("eRROR");
}   
app.get("/",(req,res)=>{
    res.render("new.ejs");
});
app.post("/qr",(req,res)=>{
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
            res.redirect("/");
        }
        else
        {
            res.render("index.ejs",{data});
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
    const key=date.getHours()*3600+date.getMinutes()*60+date.getSeconds();
    if((key-dead)<=20)
    {
        console.log("SUCCESS");
        res.render("prncall.ejs");
    }
    else
    {
        res.send("QR EXPIRED");
    }
});