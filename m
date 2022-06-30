Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E0E562350
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jun 2022 21:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236961AbiF3Thf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jun 2022 15:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236950AbiF3The (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jun 2022 15:37:34 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D509140E7A;
        Thu, 30 Jun 2022 12:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656617848; x=1688153848;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gZreJKV+oMv/NDuxMdMPpFmRx9/TyNbeHXnP+CefYZM=;
  b=omKGcov1tXyi4JgK5Mpnhlc+ardIzrZph60kTVDg0XuuYbRW2xjxX8Au
   mxgALTa9ZxCBXbhxsVzJ1Z/W2ug7xA3YN+b3X7j2tp8z+lS6X4mHDg1Nr
   v/jKOzOAsmXYWiYczqr4k3hzflyXCJxKddWyB8kLwrWvIypvNXMDFXl4+
   s=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 30 Jun 2022 12:37:28 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 12:37:28 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 30 Jun 2022 12:37:27 -0700
Received: from [10.134.66.165] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 30 Jun
 2022 12:37:27 -0700
Message-ID: <0f4eb095-efc2-f7cf-af84-1c381d53382a@quicinc.com>
Date:   Thu, 30 Jun 2022 12:37:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] dt-bindings: power: reset: qcom-pon: update "reg"
 property details
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <corbet@lwn.net>, <sre@kernel.org>, <robh+dt@kernel.org>
CC:     <vkoul@kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        David Collins <quic_collinsd@quicinc.com>
References: <20220628015845.28751-1-quic_amelende@quicinc.com>
 <1576e17a-add4-83b4-3847-458fea9fd831@linaro.org>
From:   Anjelique Melendez <quic_amelende@quicinc.com>
In-Reply-To: <1576e17a-add4-83b4-3847-458fea9fd831@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/29/2022 3:35 AM, Krzysztof Kozlowski wrote:
> On 28/06/2022 03:58, Anjelique Melendez wrote:
>> From: David Collins <quic_collinsd@quicinc.com>
>>
>> Update the description of "reg" property to add the PON_PBS base
>> address along with PON_HLOS base address.  Also add "reg-names"
>> property description.
>>
>> Signed-off-by: David Collins <quic_collinsd@quicinc.com>
>> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
>> ---
>>
>> New patch series to sperate this patch from applied patches.
>> Last comments from original patch series can be found
>> https://lore.kernel.org/linux-arm-msm/27515993-18f3-8891-4835-9b6a8d7f86b0@quicinc.com/
>>
>> changes since v1:
>>   - Updated path which was missing Documention/devicetree prefix
>>   - Updated CC list
>>   
>>  ../bindings/power/reset/qcom,pon.yaml | 20 +++++++++++++++++++-
>>  1 file changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
>> index 353f155d..1d8cf900 100644
>> --- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
>> +++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
>> @@ -26,8 +26,26 @@ properties:
>>        - qcom,pm8998-pon
>>  
>>    reg:
>> -    maxItems: 1
>> +    description: |
>> +      Specifies the SPMI base address for the PON (power-on) peripheral.  For
>> +      PMICs that have the PON peripheral (GEN3) split into PON_HLOS and PON_PBS
>> +      (e.g. PMK8350), this can hold addresses of both PON_HLOS and PON_PBS
>> +      peripherals.  In that case, the PON_PBS address needs to be specified to
>> +      facilitate software debouncing on some PMICs.
> 
> You need separate compatibles for that and constraints (allOf:if:then)
> for each variant.
> 
So I have been looking into using the separate compatible strings however
have run into a few problems.

The compatible strings in this binding relate to the parent pon device,
while gen1/gen2/gen3 relate to the children devices.
For example, qcom,pm8941-resin/qcpm,pm8941-pwrkey are gen1/gen2 children
and defined under a parent pon device with the "qcom,pm8998-pon" compatible string
but qcom,pmk8350-resin/pmk8350-resin are gen3 children and would also be defined
under a parent pon device with the "qcom,pm8998-pon" compatible string.
Currently the children do not define their own "reg" property and will use the
register(s) address(es) defined for their parent[1].
Because of this we are unable to use the compatibles to separate the constraints
for gen1/gen2 vs gen3.

There are two possible suggestions we came up with that could solve this.
1. Add a new compatible string to this binding such as "qcom,pmk8350-pon". We would then
place all gen3 children devices under this compatible string thus being able to use
allOf:if:then for the constraints.This would also require a few changes within
driver/power/supply/qcom,pon.c. 

2. reg-names is not consumed by anything but rather used for clarification
for users as what the register(s) address relates to. We could get rid of
the property and simply have "reg" with minItem:1 and maxItem:2.


Would love to hear your thoughts or other suggestions you may have!

Thanks,
Anjelique

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/input/misc/pm8941-pwrkey.c?h=v5.19-rc4#n274
>> +    minItems: 1
>> +    maxItems: 2
>>  
>> +  reg-names:
>> +    description: |
>> +      For PON GEN1 and GEN2, it should be "pon". For PON GEN3 it should include
>> +      "pon_hlos" and optionally "pon_pbs".
>> +    minItems: 1
>> +    maxItems: 2
>> +    items:
>> +      anyOf:
>> +        - const: pon_hlos
>> +        - const: pon_pbs
>> +        - const: pon
> 
> First, you missed Rob's comment, that names should be without "pon" prefix.
> 
> Second, uUnfortunately this cannot be such flexible. Items have to be
> strictly ordered. You mentioned in description something about gen1/2/3,
> so probably what you want per-variant, specific list
> 
> Best regards,
> Krzysztof
