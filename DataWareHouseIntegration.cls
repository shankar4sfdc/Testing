/**
 * Created by 10200312 on 25/05/2021.
 */

/**
 * This is a test Class and will be rewritten later
 */
public with sharing class DataWareHouseIntegration {
    public static String grantType = 'grant_type=client_credentials';

    // TODO Make storedClientId load for easy of update
    public static String storedClientId = 'ad6c6cbc-d11a-4e38-8d38-7bf362e2e49f';
    public static String clientId = 'client_id='+storedClientId;

    // TODO Make storedClientSecret load for easy of update
    public static String storedClientSecret = '7f2709fd-d57c-47fa-af56-446449767848';
    public static String clientSecret = 'client_secret='+storedClientSecret;
    public static String type = 'type=OAuth2';

    /**
     * This method will return the DW Complaints for a customer, The passed params will make up part of the URL Params
     * @param sfdcAccountCode The SFDC customer code  (e.g. 001w000001ZXdf8AAD)
     * @param SalesOrg The sales organisation the customer belongs (e.g. GB01)
     */
    public static List<DWCustomerCompliants> callDWForComplaintsAPI(String sfdcAccountCode, String salesOrg){

        // Before we do any calls lets create some validation on the mandatory fields
        if(String.isEmpty(sfdcAccountCode) || sfdcAccountCode == null){
            throw new DWIntegrationException('Mandatory Field Missing customerAccountCode');
        }

        if(String.isEmpty(salesOrg) || salesOrg == null){
            throw new DWIntegrationException('Mandatory Field Missing salesOrg');
        }

        //String salesOrg='/GB01';

        String oAuth = getOAuth();

        String endPoint = 'https://api-dev.univarsolutions.com/gateway/qpricing-pt/v1/datawarehouse/customer-complaints/';

        HttpRequest req = new HttpRequest();
        req.setEndpoint(endPoint + sfdcAccountCode + salesOrg);

        req.setMethod('GET');
        req.setHeader('x-usol-user', 'jim.bell@UnivarSolutions.com');
        req.setHeader('Authorization', 'Bearer '+oAuth);
        req.setTimeout(3600);

        HttpResponse res = new Http().send(req);
        System.debug(res.getStatus());
        System.debug(res.getBody());

        DWCustomerCompliants dWCustomerComplaints = new DWCustomerCompliants();
        return dWCustomerComplaints.parse(res.getBody());
    }

    /**
     * This method will return the DW OTIFs for a customer, The passed params will make up part of the URL Params
     * @param sfdcAccountCode The SFDC customer code  (e.g. 001w000001ZXdf8AAD)
     * @param salesOrg The sales organisation the customer belongs (e.g. GB01)
     */
    public static List<DWCustomerOTIFs> callDWForOTIFsAPI(String sfdcAccountCode, String salesOrg){

        // Before we do any calls lets create some validation on the mandatory fields
        if(String.isEmpty(sfdcAccountCode) || sfdcAccountCode == null){
            throw new DWIntegrationException('Mandatory Field Missing sfdcAccountCode');
        }

        if(String.isEmpty(salesOrg) || salesOrg == null){
            throw new DWIntegrationException('Mandatory Field Missing salesOrg');
        }

        //String salesOrg='/GB01';

        String oAuth = getOAuth();

        String endPoint = 'https://api-dev.univarsolutions.com:10601/gateway/qpricing-pt/v1/datawarehouse/otif/';

        HttpRequest req = new HttpRequest();
        req.setEndpoint(endPoint + '/' + sfdcAccountCode + '/' + salesOrg);

        req.setMethod('GET');
        req.setHeader('x-usol-user', 'jim.bell@UnivarSolutions.com');
        req.setHeader('Authorization', 'Bearer '+oAuth);
        req.setTimeout(3600);

        HttpResponse res = new Http().send(req);
        System.debug(res.getStatus());
        System.debug(res.getBody());

        DWCustomerOTIFs dWCustomerOTIFs = new DWCustomerOTIFs();
        return dWCustomerOTIFs.parse(res.getBody());
    }

    /**
     * This method will return the DW Sales History API for a customer, The passed params will make up part of the URL Params
     * @param sfdcAccountCode The SFDC customer code  (e.g. 001w000001ZXdf8AAD)
     * @param sfdcMaterialGroup The material group code (e.g. 111392)
     * @param salesOrg The sales organisation the customer belongs (e.g. GB01)
     */
    public static List<DWSalesHistory> callDWForSalesHistoryAPI(String sfdcAccountCode, String sfdcMaterialGroup, String salesOrg){

        // Before we do any calls lets create some validation on the mandatory fields
        if(String.isEmpty(sfdcAccountCode) || sfdcAccountCode == null){
            throw new DWIntegrationException('Mandatory Field Missing sfdcAccountCode');
        }

        if(String.isEmpty(sfdcMaterialGroup) || sfdcMaterialGroup == null){
            throw new DWIntegrationException('Mandatory Field Missing materialGroup');
        }

        if(String.isEmpty(salesOrg) || salesOrg == null){
            throw new DWIntegrationException('Mandatory Field Missing salesOrg');
        }

        //String salesOrg='/GB01';

        String oAuth = getOAuth();

        String endPoint = 'https://api-dev.univarsolutions.com:10601/gateway/qpricing-pt/v1/datawarehouse/sales-history/';

        HttpRequest req = new HttpRequest();
        req.setEndpoint(endPoint + '/' + sfdcAccountCode + '/' + sfdcMaterialGroup + '/' + salesOrg);

        req.setMethod('GET');
        req.setHeader('x-usol-user', 'jim.bell@UnivarSolutions.com');
        req.setHeader('Authorization', 'Bearer '+oAuth);
        req.setTimeout(3600);

        HttpResponse res = new Http().send(req);
        System.debug(res.getStatus());
        System.debug(res.getBody());

        DWSalesHistory dWSalesHistory = new DWSalesHistory();
        return dWSalesHistory.parse(res.getBody());
    }

    /**
 * This method will return the DW Waited Average Days for a customer, The passed params will make up part of the URL Params
 * @param sfdcAccountCode The SFDC customer code  (e.g. 001w000001ZXdf8AAD)
 * @param sfdcMaterialGroup The material group code (e.g. 111392)
 * @param salesOrg The sales organisation the customer belongs (e.g. GB01)
 */
    public static List<DWWaitedAverageDays> callDWForWaitedAverageDaysAPI(String sfdcAccountCode, String sfdcMaterialGroup, String salesOrg){

        // Before we do any calls lets create some validation on the mandatory fields
        if(String.isEmpty(sfdcAccountCode) || sfdcAccountCode == null){
            throw new DWIntegrationException('Mandatory Field Missing sfdcAccountCode');
        }

        if(String.isEmpty(sfdcMaterialGroup) || sfdcMaterialGroup == null){
            throw new DWIntegrationException('Mandatory Field Missing materialGroup');
        }

        if(String.isEmpty(salesOrg) || salesOrg == null){
            throw new DWIntegrationException('Mandatory Field Missing salesOrg');
        }

        //String salesOrg='/GB01';

        String oAuth = getOAuth();

        String endPoint = 'https://api-dev.univarsolutions.com:10601/gateway/qpricing-pt/v1/datawarehouse/wad/';

        HttpRequest req = new HttpRequest();
        req.setEndpoint(endPoint + '/' + sfdcAccountCode + '/' + sfdcMaterialGroup + '/' + salesOrg);

        req.setMethod('GET');
        req.setHeader('x-usol-user', 'jim.bell@UnivarSolutions.com');
        req.setHeader('Authorization', 'Bearer '+oAuth);
        req.setTimeout(3600);

        HttpResponse res = new Http().send(req);
        System.debug(res.getStatus());
        System.debug(res.getBody());

        DWWaitedAverageDays dWWaitedAverageDays = new DWWaitedAverageDays();
        return dWWaitedAverageDays.parse(res.getBody());
    }

    public static String getOAuth() {
        String body = grantType + '&' + clientId + '&' + clientSecret + '&' + type;

        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api-dev.univarsolutions.com/oauth2/getAccessToken');
        req.setMethod('GET');

        req.setBody(body);

        HttpResponse res = new Http().send(req);

        System.debug(res.getBody());
        System.debug(res.getStatus());
        String authCode;

        if(res.getStatusCode() == 200) {
            DWIntegrationAuth auth = new DWIntegrationAuth();

            auth = auth.parse(res.getBody());
            System.debug(auth);
            authCode = auth.access_token;
        }

        return authCode;
    }


    public class DWIntegrationAuth {
        public String access_token;
        public String token_type;
        public Integer expires_in;
        public String scope;

        public DWIntegrationAuth parse(String json) {
            return (DWIntegrationAuth) System.JSON.deserialize(json, DWIntegrationAuth.class);
        }
    }

    public class DWCustomerCompliants {
        public String complaintID;
        public DateTime closedDate;
        public DateTime complaintStart;
        public String customerID;
        public String customerName;
        public String materialID;
        public String materialName;
        public String plantID;
        public String responsible;
        public String salesOfficeID;
        public String shortText;
        public String status;
        public String qMSDText;
        public String usePlantName;
        public String useMatVertical;
        public String useSalesOffice;
        public String useRespGID;
        public String keyAccount;


        public List<DWCustomerCompliants> parse(String json) {
            return (List<DWCustomerCompliants>) System.JSON.deserialize(json, List<DWCustomerCompliants>.class);
        }
    }

    public class DWCustomerOTIFs {
        public String material;
        public String univarProduct;
        public String cPP;
        public DateTime month;
        public Decimal value;

        public List<DWCustomerOTIFs> parse(String json) {
            return (List<DWCustomerOTIFs>) System.JSON.deserialize(json, List<DWCustomerOTIFs>.class);
        }
    }

    public class DWSalesHistory {
        public String type;
        public Decimal val;
        public Decimal sales;
        public Decimal gP;
        public Decimal gPPerTonne;
        public Decimal gPPerc;

        public List<DWSalesHistory> parse(String json) {
            return (List<DWSalesHistory>) System.JSON.deserialize(json, List<DWSalesHistory>.class);
        }
    }

    public class DWWaitedAverageDays {
        public String material;
        public Decimal wAD12MHO;
        public Decimal wAD6MHO;
        public Decimal wAD3MHO;
        public Decimal wAD1MHO;
        public Decimal overdue;

        public List<DWWaitedAverageDays> parse(String json) {
            return (List<DWWaitedAverageDays>) System.JSON.deserialize(json, List<DWWaitedAverageDays>.class);
        }
    }


    public class DWIntegrationException extends Exception{

    }

    public String name;
    public String emailAddress;
    public Boolean enabled;
}