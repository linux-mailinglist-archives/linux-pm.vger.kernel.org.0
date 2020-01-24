Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9AB148CC5
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2020 18:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730753AbgAXRNN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jan 2020 12:13:13 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:64102 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729868AbgAXRNN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jan 2020 12:13:13 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579885992; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=B2BoRn1ryER+fUQ1g+nNgthwJ2vmziLBlbBsrK0ABns=; b=Ph9iIgBtUgQSWsvLu3qWq5p2pDk2OonofbLFWEZxyiYKi8LJP2Eb2dMGWgo3Qon256gxaqif
 +U/Y9BOVD3IUBlpvyw+E0+1QpTDCmNSAoBLEtoN75a61ozpwrPCDNdOcYVhjwLhDLVNCn6ZU
 Bzvkl5lfym7gZaowyJ8HbVF+yv0=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2b25a7.7f93eb392d88-smtp-out-n03;
 Fri, 24 Jan 2020 17:13:11 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 181FBC447AC; Fri, 24 Jan 2020 17:13:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [10.226.59.103] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rkumbako)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 33CF1C447A2;
        Fri, 24 Jan 2020 17:13:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 33CF1C447A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rkumbako@codeaurora.org
Subject: Re: [PATCH] drivers: thermal: step_wise: add support for hysteresis
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, swboyd@chromium.org, j-keerthy@ti.com,
        thara.gopinath@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>
Cc:     Lina Iyer <ilina@codeaurora.org>, linux-pm@vger.kernel.org
References: <8e812065f4a76325097c5f9c17f3386736d8c1d4.1574315190.git.amit.kucheria@linaro.org>
 <962d48d2-87fd-1236-0623-148352a98de6@linaro.org>
 <4f75a862-4525-fe11-ed03-f53a13926c15@codeaurora.org>
 <211a066d-f801-fb21-a14d-2b00765d2547@linaro.org>
From:   Ram Chandrasekar <rkumbako@codeaurora.org>
Message-ID: <79a9c316-ee21-4a8c-ce98-9bbc0ff1f537@codeaurora.org>
Date:   Fri, 24 Jan 2020 10:13:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <211a066d-f801-fb21-a14d-2b00765d2547@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 1/9/2020 3:46 PM, Daniel Lezcano wrote:
> On 08/01/2020 01:31, Ram Chandrasekar wrote:
>>
>>
>> On 12/11/2019 6:35 AM, Daniel Lezcano wrote:
>>> On 21/11/2019 06:50, Amit Kucheria wrote:
>>>> From: Ram Chandrasekar <rkumbako@codeaurora.org>
>>>>
>>>> Currently, step wise governor increases the mitigation when the
>>>> temperature goes above a threshold and decreases the mitigation when the
>>>> temperature goes below the threshold.
>>>>
>>>> If there is a case where the
>>>> temperature is wavering around the threshold, the mitigation will be
>>>> applied and removed every iteration, which is not very efficient.
>>>>
>>>> The use of hysteresis temperature could avoid this ping-pong of
>>>> mitigation by relaxing the mitigation to happen only when the
>>>> temperature goes below this lower hysteresis value.
>>>
>>> What I'm worried about is how the hysteresis is used in the current
>>> code, where the destination of this data is to set the value in the
>>> sensor hardware if it is supported.
>>>
>>> Using the hysteresis in the governor seems like abusing the initial
>>> purpose of this information.
>>>
>>> Moreover, the hysteresis creates a gray area where the above algorithm
>>> (DROPPING && !throttle) => state-- or (RAISING && throttle) => state++
>>> may drop the performances because we will continue mitigating even below
>>> the threshold.
>>>
>>> As the governor is an open-loop controller, I'm not sure if we can do
>>> something except adding some kind of low pass filter to prevent
>>> mitigation bounces.
>>>
>>
>> We have two different use cases for the step wise algorithm, and the
>> hysteresis makes sense only in one.
>>
>> For example, say we are controlling CPU junction temperature at 95C.
>> When using step wise, mitigation is applied iteratively and there is a
>> possibility that temperature can shoot up before the algorithm can reach
>> an optimal mitigation level to keep the temperature near threshold.
>>
>> In order to help this state machine, we use a second back stop rule in
>> the same thermal zone at a higher temperature (say 105C) with a
>> hysteresis of 10C to mitigate CPU to a fixed value, by specifying
>> upper/lower limit to be the same. The idea is that the second rule will
>> place a hard hammer to bring the temperature down close to 95C and then
>> it will remove the mitigation. Once mitigation is removed, the junction
>> temperature rule state machine will re-adjust from that point to an
>> optimal mitigation level. The junction temperature rule doesn’t use
>> hysteresis.
>>
>> Another example is skin temperature mitigation for mobile devices, where
>> the step wise algorithm with hysteresis just reduces the operating max
>> frequency to a fixed value, when the threshold is reached. And the
>> junction temperature rule starts mitigating from this operating max.
>>
>> That is the reason we have not generalized or mandated the hysteresis
>> usage in this patch. The idea is to use it selectively based on use case.
> 
> Did you ever try the IPA governor?
> 
> 
Yes. We understand IPA could bring down the power/frequency cap multiple 
levels compared to step wise which is doing iteratively. With cooling 
device weights this makes IPA good for skin temperature control. But 
when we evaluated IPA, we found step wise is giving a better performance 
compared to IPA for localized junction temperature rules. Additionally, 
step wise for the junction temperature rule is easier to tune with fewer 
parameters. With these additional enhancements, step wise turned out to 
be a better choice for local junction temperature rules.
