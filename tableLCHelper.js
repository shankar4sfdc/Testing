({
	doInit : function(component, event, helper) {
        let headerNames = ["Material"];//,"Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec","Jan","Feb"];
        const months = ["Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec","Jan","Feb"];
        const d = new Date();
        var currentYear;
        if(d.getMonth()+1>2)
        {
            currentYear = d.getFullYear();
        }
        for(let i=0;i<12;i++)
        {
            if(i<10)
                headerNames.push(months[i]+" - "+String(currentYear-1).slice(2,4));
            else 
                headerNames.push(months[i]+" - "+String(currentYear).slice(2,4));
        }
        var action = component.get("c.getOTIFS");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS"){
                var result = response.getReturnValue();
                    console.log('--result---'+result.length);
                if(result.length > 0){
                    //const myObj = JSON.parse(result);
                    var keys = Object.entries(result);
                    console.log('--keys---'+keys);
                    /*for (var i = 0; i < result.length; i++) {
                    	console.log('month data----->'+String(result[i]));
                        
                    }
                    for (let x in months) {
                        console.log('-----'+myObj[x].month);
                        const d = new Date(myObj[x].month);
                    	headerNamesSet.add(months[d.getMonth()]+"-"+String(d.getFullYear()).slice(2,4));
                    }
                    for (const x of headerNamesSet.values()) {
                        console.log('---headers--'+x);
                    	headerNames.push(x);
                    }*/
                    component.set('v.listOfRecords', result);
                    component.set('v.listOfHeaders', headerNames);
                }else{
                    // if there is no records then display message
                    component.set("v.NoRecordsFound" , true);
                } 
            }
            else{
                alert('Error...');
            }
        });
        $A.enqueueAction(action);  
	},
})