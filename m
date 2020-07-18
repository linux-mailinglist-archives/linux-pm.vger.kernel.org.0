Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A42224781
	for <lists+linux-pm@lfdr.de>; Sat, 18 Jul 2020 02:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbgGRAlF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jul 2020 20:41:05 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:31485 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728206AbgGRAlE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jul 2020 20:41:04 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595032863; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=iNKJj+TLzkBnI4NSsc5gA6qzfp4yaENwEEBOKVBFHZM=; b=WHGKiTFz37FpUq/nLAZiwwbROQNX4hbLfeg5omPUZlvOMvtB7TSg/prKfWuzqb5LLmdSSxzu
 LCReocvCezUPjQzkT6ryIOAX4lndbT2bbDQLn6GXBwgIVqy0MGFE07WYqgkTMOnBPuFX91AD
 6cDwwL39Jow56r1lzVtSlKYL2a4=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f12451fe3bee125108f0b55 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 18 Jul 2020 00:41:03
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C3AFEC433CB; Sat, 18 Jul 2020 00:41:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,NICE_REPLY_A,
        SPF_NONE,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.117] (ip70-179-20-127.sd.sd.cox.net [70.179.20.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BF392C433C9;
        Sat, 18 Jul 2020 00:41:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BF392C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mdtipton@codeaurora.org
Subject: Re: [PATCH v2 2/6] dt-bindings: interconnect: Add property to set BCM
 TCS wait behavior
To:     Rob Herring <robh@kernel.org>
Cc:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200710015652.19206-1-mdtipton@codeaurora.org>
 <20200710015652.19206-3-mdtipton@codeaurora.org>
 <20200710163119.GA2753833@bogus>
From:   Mike Tipton <mdtipton@codeaurora.org>
Message-ID: <43a0638a-ea3d-eb96-16d0-524148f86bc3@codeaurora.org>
Date:   Fri, 17 Jul 2020 17:41:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710163119.GA2753833@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/10/2020 9:31 AM, Rob Herring wrote:
> On Thu, Jul 09, 2020 at 06:56:48PM -0700, Mike Tipton wrote:
>> Add "qcom,tcs-wait" property to set which TCS should wait for completion
>> when triggering.
>>
>> Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
>> ---
>>   .../bindings/interconnect/qcom,bcm-voter.yaml       | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
>> index 5971fc1df08d..f0c3d6b01831 100644
>> --- a/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
>> @@ -21,6 +21,16 @@ properties:
>>       enum:
>>         - qcom,bcm-voter
>>   
>> +  qcom,tcs-wait:
>> +    description: |
>> +      Optional mask of which TCSs (Triggered Command Sets) wait for completion
>> +      upon triggering. In most cases, it's necessary to wait in both the AMC
>> +      and WAKE sets to ensure resources are available before use. If a specific
>> +      RSC and its use cases can ensure sufficient delay by other means, then
>> +      this can be overridden to reduce latencies.
> 
> I have no idea what any of this means to provide any meaningful comment.
> 
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    default: QCOM_ICC_TAG_ACTIVE_ONLY
> 
> Can't use defines here.

What's the recommended alternative? The meaning isn't obvious as a raw 
number (3). We expect the defines to be used in the dt files themselves 
(see example below). Is this just a restriction for the `default` 
documentation specifically? I could just mention the default behavior in 
the description I suppose, but that seems to defeat the purpose of 
having a separate `default` key.

> 
>> +
>>   required:
>>     - compatible
>>   
>> @@ -39,7 +49,10 @@ examples:
>>     # as defined in Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
>>     - |
>>   
>> +    #include <dt-bindings/interconnect/qcom,icc.h>
>> +
>>       disp_bcm_voter: bcm_voter {
>>           compatible = "qcom,bcm-voter";
>> +        qcom,tcs-wait = <QCOM_ICC_TAG_AMC>;
>>       };
>>   ...
>> -- 
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project
>>
