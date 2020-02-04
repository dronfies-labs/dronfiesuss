
const cron = require("node-cron");

import { schedule } from "node-cron";
import { processOperations } from "./operationCronJobs";

export class CronService {
    tasks = {
    }

    constructor(){
        console.log("<>    CRON SERVICE     <>")
        this.tasks['operationCron'] = undefined;

        let operationCron = schedule("*/30 * * * * *", function() {
            processOperations();
        });
        operationCron.start();
        this.tasks['operationCron'] = operationCron;
    }

}


// let tasks = {}

// let operationCron = schedule("* * * * *", function() {
//     console.log("running a task every minute");
// });

// tasks['operationCron'] = operationCron;