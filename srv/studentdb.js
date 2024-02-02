const cds = require('@sap/cds');

function calcAge(dob) {
    var today = new Date();
    var birthDate = new Date(Date.parse(dob));
    var age = today.getFullYear() - birthDate.getFullYear();
    var m = today.getMonth() - birthDate.getMonth();
    if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
        age--;
    }
    return age;
}

module.exports = cds.service.impl(function () {

    const { Student, Gender } = this.entities();

    this.on('READ', Student, async(req) => {
        results = await cds.run(req.query);
        if(Array.isArray(results)) {
            results.forEach(element => {
                element.age = calcAge(element.dob);
                element.gender = getGenderDescription(element.gender);
            });
        }
        else {
            results.age = calcAge(results.dob);
            results.gender = getGenderDescription(results.gender);
        }
        return results;
    });

    function getGenderDescription(genderCode) {
        if (genderCode === 'M') {
            return "Male";
        } else if (genderCode === 'F') {
            return "Female";
        } else {
            return "UNKNOWN";
        }
    }

    this.on('READ', Student, async(req) => {
        results = await cds.run(req.query);
        if(Array.isArray(results)){
            results.forEach(element => {
             element.age=calcAge(element.dob); 
            });
        }else{
            results.age=calcAge(results.dob);
        }
        
        return results;
    });

    this.before(['CREATE'], Student, async(req) => {

        age = calcAge(req.data.dob);
            if (age<18 || age>45){
                req.error({'code': 'WRONGDOB',message:'Student not the right age for school: '+ age, target:'dob'});
            }

        let query1 = SELECT.from(Student).where({ref:["email"]}, "=", {val: req.data.email});
        result = await cds.run(query1);
        if (result.length > 0) {
            req.error({'code': 'STMAILEXISTS',message:'Student with such email already exists', target: 'email'});
        }

        let query2 = SELECT.from(Student).where({ref:["pan_no"]}, "=", {val: req.data.pan_no});
        result = await cds.run(query2);
        if (result.length > 0) {
            req.error({'code': 'STPANEXISTS',message:'Student with such pan_no already exists', target: 'pan_no'});
        }
        
    });

    this.on('READ', Gender, async(req) => {
        genders = [
            {"code":'M', "description":"Male"},
            {"code":'F', "description":"Female"}
        ];
        genders.$count=genders.length;
        return genders;
    });

});