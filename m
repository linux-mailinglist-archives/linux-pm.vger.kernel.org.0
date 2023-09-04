Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0AC7914B8
	for <lists+linux-pm@lfdr.de>; Mon,  4 Sep 2023 11:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352644AbjIDJ2b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Sep 2023 05:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjIDJ2a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Sep 2023 05:28:30 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A60B18D;
        Mon,  4 Sep 2023 02:28:27 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3847qnJJ016758;
        Mon, 4 Sep 2023 09:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dHSeTJ8qyo7II+cTEjTn3YYF2/d7aYJKF5QdA04W/wA=;
 b=QOukjCHt4foQnwLrIDrxwmYIy4GSHfRh4XHCwHdx3PyTIMqqA81Sbw2U8N1opZlklRMU
 6yqfSeNAHFZqAQalF6EcWvr/Q/eWaCyboubwD9L8zVEuepb5gT94Bkb2HdTnGFSm38Gi
 RTc6gIaP7eGTF8mmt9w37utAHfMIbT8NMN99pVWLrVjx7vXvzaSyAE4tStWDVRSBxfhM
 m4lkerwj8UNmEmDK3sSTodZ32BWhXHGrLn8ac485/0XRzo0LeXS2866ITw+4EcpUaEZl
 UtkrJua/LCr4VOQK2Sl6/UTta2ybnWs9AOlntCJzxMBS6qavJ0B0+n1n4AcKfRb8aB3x qg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3suw50u02b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Sep 2023 09:28:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3849SAsa024974
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Sep 2023 09:28:10 GMT
Received: from [10.217.216.47] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 4 Sep
 2023 02:28:05 -0700
Message-ID: <f37d2dd8-d625-048e-9c21-bba710b40086@quicinc.com>
Date:   Mon, 4 Sep 2023 14:57:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 4/6] clk: qcom: Use HW_CTRL_TRIGGER flag to switch
 video GDSC to HW mode
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>
CC:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Andy Gross" <agross@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        Taniya Das <tdas@qti.qualcomm.com>, <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>
References: <20230816145741.1472721-1-abel.vesa@linaro.org>
 <20230816145741.1472721-5-abel.vesa@linaro.org>
 <2fc0d771-cee2-4826-a62a-56ed4bfad3a2@linaro.org>
 <ZOXiUzxfs1cj3SWT@linaro.org>
 <07e93a9d-69ac-41b7-aa21-b855b97bf801@linaro.org>
 <ef1439f8-4a9b-53b4-34be-1229b39d2310@quicinc.com>
 <8257f7b3-dfb8-4683-85de-600f3b1ed54b@linaro.org>
Content-Language: en-US
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <8257f7b3-dfb8-4683-85de-600f3b1ed54b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: viwiA0owfd7w1Vn0wPtxqXNg9vGIJMER
X-Proofpoint-ORIG-GUID: viwiA0owfd7w1Vn0wPtxqXNg9vGIJMER
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_07,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 mlxlogscore=730 clxscore=1015
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309040085
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 9/2/2023 5:33 PM, Konrad Dybcio wrote:
> On 28.08.2023 08:48, Jagadeesh Kona wrote:
>>
>>
>> On 8/26/2023 4:17 PM, Konrad Dybcio wrote:
>>> On 23.08.2023 12:41, Abel Vesa wrote:
>>>> On 23-08-16 19:56:46, Konrad Dybcio wrote:
>>>>> On 16.08.2023 16:57, Abel Vesa wrote:
>>>>>> From: Jagadeesh Kona <quic_jkona@quicinc.com>
>>>>>>
>>>>>> The current HW_CTRL flag switches the video GDSC to HW control mode as
>>>>>> part of GDSC enable itself, instead of that use HW_CTRL_TRIGGER flag to
>>>>>> give consumer drivers more control and switch the GDSC mode as and when
>>>>>> required.
>>>>>>
>>>>>> HW_CTRL_TRIGGER flag allows consumer drivers to switch the video GDSC to
>>>>>> HW/SW control modes at runtime using dev_pm_genpd_set_hwmode API.
>>>>>>
>>>>>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>>>>>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>>>>>> ---
>>>>> Do we have any use for the HW_CTRL flag?
>>>>>
>>>>> Perhaps it should be renamed to HW_CTRL_ALWAYS?
>>>>>
>>>>> Or even better, *if and only if* that is necessary, add a common
>>>>> property like "always_hw_managed" to the genpd code?
>>>>
>>>> The HW_CTRL flag is still needed for the consumers that expect the GDSC
>>>> to be have the HW control bit set right after it gets enabled.
>>> Guess the correct question here would be.. Are there any?
>>>
>>
>> Yes, Display GDSC(mdss_gdsc) is required to be controlled always in HW control mode when it is enabled.
> Oh really?
> 
> Looking at msm-5.10 techpack, only the SDE RSC driver seems to
> trigger regulator fast mode (so, enabling gdsc hw_ctrl on downstream).
> 

Yes, on downstream, display GDSC has only one consumer(SDE RSC driver) 
and there are no other consumers. SDE RSC driver switches the GDSC to hw 
control mode once GDSC is enabled and leaves it in hw control mode. Thanks!

Regards,
Jagadeesh

> Konrad
