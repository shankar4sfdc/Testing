/**
 * This class handles Digital Sales Integration utility functions.
 *
 * @author      Created by 10200312 on 03/06/2021
 * @version     1.0
 */

public with sharing class DigitalSalesIntegrationUtilities {

    // Local static variables
    private static final String GRANTTYPE = 'grant_type=client_credentials';

    private static final String TYPE = 'type=OAuth2';
    private static final String TESTEMAIL = 'jim.bell@UnivarSolutions.com';
    public static final String XUSOLATR = 'x-usol-user';

    /**
     * This method will return the x required for Digital Sales Integration using OAuth2.0
     */
    public static String xUsolUserEmail() {
        Organization org = [select IsSandbox from Organization where Id =:UserInfo.getOrganizationId()];
        return (org.IsSandbox == true) ? TESTEMAIL : UserInfo.getUserEmail();
    }

    /**
     * This method will return the credentials required for Digital Sales Integration using OAuth2.0
     */
    public static API_Credential__mdt getAPIClientCredentials() {
        API_Credential__mdt apiCredentials = [Select
                                              Client_Id__c,
                                              Client_Secret__c,
                                              EndPointURLPrefix__c,
                                              EndPointShort__c
                                              from API_Credential__mdt
                                              where API_Name__c = 'Univar'
                                             ];
        return apiCredentials;
    }

    /**
     * This method will return the AccessToken required for Digital Sales Integration using OAuth2.0
     */
    public static String getOAuth() {

		String clientId = 'client_id=' + getAPIClientCredentials().Client_Id__c;
        String clientSecret = 'client_secret=' + getAPIClientCredentials().Client_Secret__c;
        String end_Point_Prefix = getAPIClientCredentials().EndPointShort__c;

        String body = GRANTTYPE + '&' + clientId + '&' + clientSecret + '&' + TYPE;

        HttpRequest req = new HttpRequest();
        req.setEndpoint(end_Point_Prefix + 'oauth2/getAccessToken');
        req.setMethod('GET');

        req.setBody(body);

        System.debug(req);
        System.debug(req.getBody());

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

}