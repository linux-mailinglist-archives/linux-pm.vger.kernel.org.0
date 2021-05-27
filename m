Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D3239274C
	for <lists+linux-pm@lfdr.de>; Thu, 27 May 2021 08:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbhE0GXV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 May 2021 02:23:21 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:64220 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229611AbhE0GXU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 27 May 2021 02:23:20 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1622096507; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=ZsOoxzJB/hW7m7oMPe7Q/pMXsno0+4bu4SJySzTXZPo=; b=S3kiFDutb16/0CJEgygJezug3R3y0ElMa7iKJUpT9nITLqpR1pxQcaPo8o91D0CtQBiPmqxb
 hTJ2pGz/zihuOmgSZNjqj0xTFn0lC1oqGLD0PooBXmOxXysQpz9QwCmWkklieBc8knn11oTS
 Hax3gP639bwGH/Je/3iF9KVD3Wg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 60af3a6c063320cd13854115 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 27 May 2021 06:21:32
 GMT
Sender: rnayak=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2C9F3C433D3; Thu, 27 May 2021 06:21:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.50.22.147] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 373FAC433D3;
        Thu, 27 May 2021 06:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 373FAC433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v2 1/3] dt-bindings: power: Introduce
 'assigned-performance-states' property
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        bjorn.andersson@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, swboyd@chromium.org,
        rojay@codeaurora.org
References: <1622095949-2014-1-git-send-email-rnayak@codeaurora.org>
 <1622095949-2014-2-git-send-email-rnayak@codeaurora.org>
 <20210527061603.cuy5q2jo3pfom7vf@vireshk-i7>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <79465de8-5704-0f58-c2e7-8fb6f6fc9b5d@codeaurora.org>
Date:   Thu, 27 May 2021 11:51:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210527061603.cuy5q2jo3pfom7vf@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 5/27/2021 11:46 AM, Viresh Kumar wrote:
> On 27-05-21, 11:42, Rajendra Nayak wrote:
>> While most devices within power-domains which support performance states,
>> scale the performance state dynamically, some devices might want to
>> set a static/default performance state while the device is active.
>> These devices typically would also run off a fixed clock and not support
>> dynamically scaling the device's performance, also known as DVFS techniques.
>> Add a property 'assigned-performance-states' which client devices can
>> use to set this default performance state on their power-domains.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> ---
>>   .../devicetree/bindings/power/power-domain.yaml    | 50 ++++++++++++++++++++++
>>   1 file changed, 50 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/power/power-domain.yaml b/Documentation/devicetree/bindings/power/power-domain.yaml
>> index aed51e9..88cebf2 100644
>> --- a/Documentation/devicetree/bindings/power/power-domain.yaml
>> +++ b/Documentation/devicetree/bindings/power/power-domain.yaml
>> @@ -66,6 +66,19 @@ properties:
>>         by the given provider should be subdomains of the domain specified
>>         by this binding.
>>   
>> +  assigned-performance-states:
> 
> Why is this named assigned and not "default"? Just curious :)

I took the cue from assigned-clock-rates/assigned-clock-parents but i am perfectly
fine calling it default-performance-states as well :)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
