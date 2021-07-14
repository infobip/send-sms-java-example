package com.infobip.api.code.examples;

import com.infobip.ApiClient;
import com.infobip.ApiException;
import com.infobip.api.SendSmsApi;
import com.infobip.model.SmsAdvancedTextualRequest;
import com.infobip.model.SmsDestination;
import com.infobip.model.SmsResponse;
import com.infobip.model.SmsResponseDetails;
import com.infobip.model.SmsTextualMessage;

import java.util.Collections;

public class SendSmsWithLib {
    private static final String BASE_URL = System.getenv("IB_ENDPOINT_URL");
    private static final String API_KEY = System.getenv("IB_TOKEN");
    private static final String API_KEY_PREFIX = "IBSSO";

    public static void main(String[] args) {

        String receiverPhoneNumber = "insert_receiver_phone_number_here";

        ApiClient apiClient = new ApiClient();
        apiClient.setApiKeyPrefix(API_KEY_PREFIX);
        apiClient.setApiKey(API_KEY);
        apiClient.setBasePath(BASE_URL);

        SendSmsApi sendSmsApi = new SendSmsApi(apiClient);

        SmsTextualMessage smsMessage = new SmsTextualMessage()
                .from("InfoSMS")
                .addDestinationsItem(new SmsDestination().to(receiverPhoneNumber))
                .text("This is a dummy SMS message sent using infobip-api-java-client");

        SmsAdvancedTextualRequest smsMessageRequest = new SmsAdvancedTextualRequest().messages(
                Collections.singletonList(smsMessage)
        );

        try {
            SmsResponse smsResponse = sendSmsApi.sendSmsMessage(smsMessageRequest);
            SmsResponseDetails responseDetails = smsResponse.getMessages().get(0);
            System.out.println(responseDetails.getStatus());
            System.out.println(responseDetails.getMessageId());
        } catch (ApiException apiException) {
            System.out.println(apiException.getCode());
            System.out.println(apiException.getResponseBody());
        }
    }
}
