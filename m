Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7B374D818
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jul 2023 15:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbjGJNr0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Jul 2023 09:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbjGJNrZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jul 2023 09:47:25 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFBDFA;
        Mon, 10 Jul 2023 06:47:23 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36AAuL6G004354;
        Mon, 10 Jul 2023 13:47:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=VuzxAZWTO9XALPcGxBjzo5XE0a0pOhGmpguTa4nLSlA=;
 b=SNht0G50pjgxBgrX4ZElfOZILoncLEBZi0f7LEbnHa1+dv/gJAO/AmzTjxifEFFn7ToZ
 YJsONylBuV57YqHEXikrDYRCuYSR2+SbzN/Z1zFcfJQEBBD0ikRHY5IqyGFo/rX5HtZP
 hd5D/vEUMJd2hVtFR2I8e9PZNWRuyJWqJIKj3YwHZ3pf/qkILeoO+nrHoZfFSTUaPsvI
 +nQh4FOvEOdTSti7jWXp4gLNCKl78rb4kLlLw23yN59Kot04XWWKisM3ZP8pDqQwMe47
 G1pF48PqdccwpWJTu8ZyqjWf8MJGCd0/747O0/WsX9Wu+7taqzJxFJgpGBG9CSg7zsmS jw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rrgnngf87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 13:47:17 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36ADlGIL009647
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 13:47:16 GMT
Received: from [10.201.3.91] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 10 Jul
 2023 06:47:11 -0700
Message-ID: <8661411f-ea47-2a7a-ceb4-6c37978c3a75@quicinc.com>
Date:   Mon, 10 Jul 2023 19:17:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6/6] thermal/drivers/tsens: Add IPQ5332 support
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <amitk@kernel.org>,
        <thara.gopinath@gmail.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>
References: <20230710103735.1375847-1-quic_ipkumar@quicinc.com>
 <20230710103735.1375847-7-quic_ipkumar@quicinc.com>
 <96e52c65-6216-91ba-8d2b-197f86433d98@linaro.org>
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
In-Reply-To: <96e52c65-6216-91ba-8d2b-197f86433d98@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MCcel9Mt9WF8SJY-RlsWx1iTNBGMtY3R
X-Proofpoint-GUID: MCcel9Mt9WF8SJY-RlsWx1iTNBGMtY3R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307100124
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 7/10/2023 4:54 PM, Dmitry Baryshkov wrote:
> On 10/07/2023 13:37, Praveenkumar I wrote:
>> IPQ5332 uses tsens v2.3.3 IP and it is having combined interrupt as
>> like IPQ8074. But as the SoCs does not have RPM, kernel needs to
>> take care of sensor enablement and calibration. Hence introduced
>> new ops and data for IPQ5332 and reused the feature_config from
>> IPQ8074.
>>
>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> ---
>>   drivers/thermal/qcom/tsens-v2.c | 13 +++++++++++++
>>   drivers/thermal/qcom/tsens.c    |  3 +++
>>   drivers/thermal/qcom/tsens.h    |  2 +-
>>   3 files changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/qcom/tsens-v2.c 
>> b/drivers/thermal/qcom/tsens-v2.c
>> index db48b1d95348..8b6e3876fd2c 100644
>> --- a/drivers/thermal/qcom/tsens-v2.c
>> +++ b/drivers/thermal/qcom/tsens-v2.c
>> @@ -237,6 +237,19 @@ struct tsens_plat_data data_ipq8074 = {
>>       .fields    = tsens_v2_regfields,
>>   };
>>   +static const struct tsens_ops ops_ipq5332_v2 = {
>
> Please drop v2. It is unclear if it refers to tsens being v2 or being 
> specific to ipq5332 v2.
Sure, will drop v2.
>
>> +    .init        = init_common,
>> +    .get_temp    = get_temp_tsens_valid,
>> +    .calibrate    = tsens_v2_calibration,
>> +};
>> +
>> +struct tsens_plat_data data_ipq5332 = {
>> +    .sensors_to_en    = 0xF800,
>
> This doesn't seem to match the offsets that you have enabled in the DTSI.
In order to overcome the DT binding check failure, added all the 
available QFPROM offsets in the DTSI. Else DT binding check failing on 
"nvmem-cell-names".
>
>> +    .ops        = &ops_ipq5332_v2,
>> +    .feat        = &ipq8074_feat,
>> +    .fields        = tsens_v2_regfields,
>> +};
>> +
>>   /* Kept around for backward compatibility with old msm8996.dtsi */
>>   struct tsens_plat_data data_8996 = {
>>       .num_sensors    = 13,
>> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
>> index 169690355dad..e8ba2901cda8 100644
>> --- a/drivers/thermal/qcom/tsens.c
>> +++ b/drivers/thermal/qcom/tsens.c
>> @@ -1140,6 +1140,9 @@ static const struct of_device_id tsens_table[] = {
>>       }, {
>>           .compatible = "qcom,ipq8074-tsens",
>>           .data = &data_ipq8074,
>> +    }, {
>> +        .compatible = "qcom,ipq5332-tsens",
>> +        .data = &data_ipq5332,
>>       }, {
>>           .compatible = "qcom,mdm9607-tsens",
>>           .data = &data_9607,
>> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
>> index f8897bc8944e..36040f9beebc 100644
>> --- a/drivers/thermal/qcom/tsens.h
>> +++ b/drivers/thermal/qcom/tsens.h
>> @@ -701,6 +701,6 @@ extern struct tsens_plat_data data_8226, 
>> data_8909, data_8916, data_8939, data_8
>>   extern struct tsens_plat_data data_tsens_v1, data_8976, data_8956;
>>     /* TSENS v2 targets */
>> -extern struct tsens_plat_data data_8996, data_ipq8074, data_tsens_v2;
>> +extern struct tsens_plat_data data_8996, data_ipq8074, data_ipq5332, 
>> data_tsens_v2;
>>     #endif /* __QCOM_TSENS_H__ */
>
--
Thanks,
Praveenkumar
