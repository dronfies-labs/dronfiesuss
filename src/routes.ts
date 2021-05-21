import { UserController } from "./restControllers/UserController";
import { VehicleController } from "./restControllers/VehicleController";
import { OperationController } from "./restControllers/OperationController";
import { UTMMessageController } from "./restControllers/UtmMessageRestController";
import { AuthController } from "./restControllers/AuthController";
import { PositionController } from "./restControllers/PositionController";
import { ParaglidingPositionController } from "./restControllers/ParaglidingPositionController";
import { UASVolumeReservationController } from "./restControllers/UASVolumeReservationController";
import { NotamController } from "./restControllers/NotamRestController";
import { RestrictedFlightVolumeController } from "./restControllers/RestrictedFlightVolumeController";
import { MailController } from "./restControllers/MailController";

import { checkJwt } from "./middleware/checkJwt";
import { QuickFlyController } from "./restControllers/QuickFly";

interface CustomRoute {
    method: string
    route: string
    controller: any
    action: string
    middlewares?: any

}

const doRoutes = (route: String, Dao: any) => {
    return [{
        method: "get",
        route: `/${route}`,
        controller: Dao,
        action: "all",
        middlewares: [checkJwt]
    }, {
        method: "get",
        route: `/${route}/:id`,
        controller: Dao,
        action: "one",
        middlewares: [checkJwt]
    }, {
        method: "post",
        route: `/${route}`,
        controller: Dao,
        action: "save",
        middlewares: [checkJwt]
    }, {
        method: "delete",
        route: `/${route}/:id`,
        controller: Dao,
        action: "remove",
        middlewares: [checkJwt]
    }];
}

let operations = [
    {
        method: "post",
        route: `/operation/geo`,
        controller: OperationController,
        action: "getOperationByPoint",
        middlewares: [checkJwt]
    },
    {
        method: "post",
        route: `/operation/volume`,
        controller: OperationController,
        action: "getOperationByVolumeOperation",
        middlewares: [checkJwt]
    },
    {
        method: "get",
        route: `/operation/creator`,
        controller: OperationController,
        action: "operationsByCreator",
        middlewares: [checkJwt]
    },
    {
        method: "get",
        route: `/operation/owner`,
        controller: OperationController,
        action: "operationsByOwner",
        middlewares: [checkJwt]
    },
    {
        method: "post",
        route: `/operation/:id/pendingtoaccept`,
        controller: OperationController,
        action: "acpetPendingOperation",
        middlewares: [checkJwt]
    },
    {
        method: "post",
        route: `/operation/:id/updatestate`,
        controller: OperationController,
        action: "updateState",
        middlewares: [checkJwt]
    },
    {
        method: "post",
        route: `/operation/:id/close`,
        controller: OperationController,
        action: "closeOperation",
        middlewares: [checkJwt]
    },
    ...doRoutes("operation", OperationController)]

let user = [
    {
        method: "post",
        route: `/user/register`,
        controller: UserController,
        action: "userRegister",
        // middlewares: [checkJwt]  
    },
    {
        method: "put",
        route: `/user/info/:id`,
        controller: UserController,
        action: "updateUser",
        middlewares: [checkJwt]
    },
    {
        method: "put",
        route: `/user/password/:id`,
        controller: UserController,
        action: "updateUserPassword",
        middlewares: [checkJwt]
    },
    {
        method: "post",
        route: `/user/confirm`,
        controller: UserController,
        action: "confirmUser",
        // middlewares: [checkJwt]  
    },
    ...doRoutes("user", UserController)
]

let auth = [{
    method: "post",
    route: `/auth/login`,
    controller: AuthController,
    action: "login"

}]

let mail = [{
    method: "post",
    route: "/mail/pending",
    controller: MailController,
    action: "sendMailForPendingOperation",
    middlewares: [checkJwt],
},
{
    method: "post",
    route: "/mail/operation",
    controller: MailController,
    action: "sendOperationMail",
    middlewares: [checkJwt],
}]

let positions = [
    {
        method: "post",
        route: "/position/drone",
        controller: PositionController,
        action: "savePositionWithDrone",
        middlewares: [checkJwt],
    },
    {
        method: "post",
        route: "/position/tracker",
        controller: PositionController,
        action: "savePositionWithDroneTrackerId",
        middlewares: [checkJwt],
    },
    ...doRoutes("position", PositionController),
]

let vehicles = [
    {
        method: "get",
        route: "/vehicle/operator",
        controller: VehicleController,
        action: "allVehiclesOperator",
        middlewares: [checkJwt],
    },
    {
        method: "post",
        route: "/vehicle/authorize",
        controller: VehicleController,
        action: "authorizeVehicle",
        middlewares: [checkJwt],
    },
    ...doRoutes("vehicle", VehicleController),
]

let r: CustomRoute[] = [
    ...user, // ...doRoutes("user",UserController),
    ...doRoutes("notam", NotamController),
    ...doRoutes("utmmessage", UTMMessageController),
    
    ...doRoutes("uasvolume", UASVolumeReservationController),
    ...doRoutes("restrictedflightvolume", RestrictedFlightVolumeController),
    ...doRoutes("quickfly", QuickFlyController),
    ...doRoutes("paraglidingposition", ParaglidingPositionController),
    ...vehicles,
    ...positions,
    ...operations,
    ...auth,
    ...mail,
];

// if(process.env.NODE_ENV == "dev"){
//     let testRoute : CustomRoute = {
//         action : "changeDate",
//         controller : TestController,
//         method : "post",
//         middlewares : [checkJwt] ,
//         route : "/changeDate"
//     }
//     let testRoute2 : CustomRoute = {
//         action : "echo",
//         controller : TestController,
//         method : "post",
//         middlewares : [checkJwt] ,
//         route : "/echo"
//     }
//     // testRoute.action = "changeDate"
//     // testRoute.controller = TestController
//     // testRoute.method= "POST"
//     // testRoute.middlewares = [checkJwt] 
//     // testRoute.route = "changeDate"
//     r.push(testRoute)
//     r.push(testRoute2)
// }

export const Routes = r;
