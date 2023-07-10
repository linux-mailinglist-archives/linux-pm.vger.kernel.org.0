Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0095574D7D7
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jul 2023 15:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbjGJNf2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Jul 2023 09:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjGJNfO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jul 2023 09:35:14 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F58A1A5;
        Mon, 10 Jul 2023 06:35:06 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36ABvhbM012399;
        Mon, 10 Jul 2023 13:35:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=kzl5gisDIR/NRZODjnhW8rsioevrElewY+aNDPpkL4s=;
 b=hSeNl5C4mShiLf+4hoFO0vre7tLJdMpm9DDmIVdOzIDy1wZ+Bimio3xyyyJmfOyvFMy8
 raPpBJDhsQjI3fU1031F6FdKsJeuY6LqY+aXbdNKYfLNV6fI8q9pyL9WJrkfEV1rsm2B
 WwtShcJpuT1NQFFlB8UGkxFd3b3XCwAq6i/7xf1B04c0KRLmIyANM0vD/enb7mTE0jc2
 llhrHrEhkYuJ8YL7N6Pg/W/j7GvmXUWNm+4FdZODpPuAgTuUp3ZBbka6BgQiP/V8iazK
 2q58C+GIaVHpqhVP/7bZQRMQytK5YNo2PR6LkYIP6WasdGIOE4oIeAUo+bzVhTEv7bEM 4A== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rre730yg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 13:35:01 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36ADZ0d8020988
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 13:35:00 GMT
Received: from [10.201.3.91] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 10 Jul
 2023 06:34:55 -0700
Message-ID: <01149ed4-8a8c-e0e0-d140-1f17a1f0c1fd@quicinc.com>
Date:   Mon, 10 Jul 2023 19:04:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/6] arm64: dts: qcom: ipq5332: Add thermal zone nodes
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>, <amitk@kernel.org>,
        <thara.gopinath@gmail.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>
References: <20230710103735.1375847-1-quic_ipkumar@quicinc.com>
 <20230710103735.1375847-6-quic_ipkumar@quicinc.com>
 <3f6ab4b4-b5f5-5807-0cb4-8ae782bd6044@linaro.org>
 <b1346bc7-4bf0-e885-c3d4-6fac01516bf4@linaro.org>
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
In-Reply-To: <b1346bc7-4bf0-e885-c3d4-6fac01516bf4@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oUEiWXcNYLAhfC5kpTcoIDRcEq_RmHt0
X-Proofpoint-ORIG-GUID: oUEiWXcNYLAhfC5kpTcoIDRcEq_RmHt0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 phishscore=0
 mlxscore=0 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307100122
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 7/10/2023 5:44 PM, Konrad Dybcio wrote:
> On 10.07.2023 13:23, Dmitry Baryshkov wrote:
>> On 10/07/2023 13:37, Praveenkumar I wrote:
>>> This patch adds thermal zone nodes for sensors present in
>>> IPQ5332.
>>>
>>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>>> ---
>>>    arch/arm64/boot/dts/qcom/ipq5332.dtsi | 72 +++++++++++++++++++++++++++
>>>    1 file changed, 72 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>>> index a1e3527178c0..8b276aeca53e 100644
>>> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>>> @@ -527,4 +527,76 @@ timer {
>>>                     <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>>>                     <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>>>        };
>>> +
>>> +    thermal-zones {
>>> +        rfa-0-thermal{
> thermal {
In all other DTS, name is 'thermal-zones". Hence followed the same.
>
>>> +            polling-delay-passive = <0>;
>>> +            polling-delay = <0>;
>>> +            thermal-sensors = <&tsens 11>;
>>> +
>>> +            trips {
> Indentation seems off, tab size for kernel code is 8 spaces.
Sure, will check the indent and update in next patch.
>
> Konrad
>>> +                rfa-0-critical {
>>> +                    temperature = <125000>;
>>> +                    hysteresis = <1000>;
>>> +                    type = "critical";
>>> +                };
>>> +            };
>>> +        };
>>> +
>>> +        rfa-1-thermal {
>>> +            polling-delay-passive = <0>;
>>> +            polling-delay = <0>;
>>> +            thermal-sensors = <&tsens 12>;
>>> +
>>> +            trips {
>>> +                rfa-1-critical {
>>> +                    temperature = <125000>;
>>> +                    hysteresis = <1000>;
>>> +                    type = "critical";
>>> +                };
>>> +            };
>>> +        };
>>> +
>>> +        misc-thermal {
>>> +            polling-delay-passive = <0>;
>>> +            polling-delay = <0>;
>>> +            thermal-sensors = <&tsens 13>;
>>> +
>>> +            trips {
>>> +                misc-critical {
>>> +                    temperature = <125000>;
>>> +                    hysteresis = <1000>;
>>> +                    type = "critical";
>>> +                };
>>> +            };
>>> +        };
>>> +
>>> +        cpu-top-thermal {
>>> +            polling-delay-passive = <0>;
>>> +            polling-delay = <0>;
>>> +            thermal-sensors = <&tsens 14>;
>>> +
>>> +            trips {
>>> +                cpu-top-critical {
>>> +                    temperature = <125000>;
>>> +                    hysteresis = <1000>;
>>> +                    type = "critical";
>>> +                };
>>> +            };
>> Could you please add a passive cooling devices for the CPU?
>>
>>> +        };
>>> +
>>> +        top-glue-thermal {
>>> +            polling-delay-passive = <0>;
>>> +            polling-delay = <0>;
>>> +            thermal-sensors = <&tsens 15>;
>>> +
>>> +            trips {
>>> +                top-glue-critical {
>>> +                    temperature = <125000>;
>>> +                    hysteresis = <1000>;
>>> +                    type = "critical";
>>> +                };
>>> +            };
>>> +        };
>>> +    };
>>>    };
--
Thanks,
Praveenkumar
