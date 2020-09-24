Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2402768AF
	for <lists+linux-pm@lfdr.de>; Thu, 24 Sep 2020 08:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgIXGJp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Sep 2020 02:09:45 -0400
Received: from z5.mailgun.us ([104.130.96.5]:53446 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726683AbgIXGJp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 24 Sep 2020 02:09:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600927783; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=BSw8uLG6fAIxSKQlCXzX+qNRyeNk83mkcoyVybEKS/k=; b=KoKRdj9B6FYpKkXT4Efb5eU/9jYVXmX3u1BYM82TCvgY/aZqiqBIOb83W85U5OcPrrW9iBGB
 rCzhFe1nWaCzHbF/Jd65shHQNod/iTTJKwsfRq/+eXIr83dMA9VtQdZGDBkpEoiGYv3LoWFu
 95SbI2avvgmdQ5yU2NZG4jteb1o=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f6c3827c2a5b66eb961de57 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 24 Sep 2020 06:09:43
 GMT
Sender: rnayak=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0F581C433FE; Thu, 24 Sep 2020 06:09:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.0.118] (unknown [49.207.198.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F007AC433C8;
        Thu, 24 Sep 2020 06:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F007AC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: is 'dynamic-power-coefficient' expected to be based on 'real'
 power measurements?
To:     Matthias Kaehlcke <mka@chromium.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-pm@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>
References: <248bb01e-1746-c84c-78c4-3cf7d2541a70@codeaurora.org>
 <20200915172444.GA2771744@google.com>
 <406d5d4e-d7d7-8a37-5501-119b734facb3@linaro.org>
 <20200915175808.GB2771744@google.com>
 <27785351-ba14-dc92-6761-d64962c29596@linaro.org>
 <b0d32e2b-1e21-b921-2d5f-335abafd0a37@arm.com>
 <20200916164840.GI2771744@google.com>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <c8367a0e-ee58-37f3-b306-648ddc0a3e2b@codeaurora.org>
Date:   Thu, 24 Sep 2020 11:39:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200916164840.GI2771744@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 9/16/2020 10:18 PM, Matthias Kaehlcke wrote:
> On Wed, Sep 16, 2020 at 10:53:48AM +0100, Lukasz Luba wrote:
>>
>>
>> On 9/15/20 9:55 PM, Daniel Lezcano wrote:
>>> On 15/09/2020 19:58, Matthias Kaehlcke wrote:
>>>> On Tue, Sep 15, 2020 at 07:50:10PM +0200, Daniel Lezcano wrote:
>>>>> On 15/09/2020 19:24, Matthias Kaehlcke wrote:
>>>>>> +Thermal folks
>>>>>>
>>>>>> Hi Rajendra,
>>>>>>
>>>>>> On Tue, Sep 15, 2020 at 11:14:00AM +0530, Rajendra Nayak wrote:
>>>>>>> Hi Rob,
>>>>>>>
>>>>>>> There has been some discussions on another thread [1] around the DPC (dynamic-power-coefficient) values
>>>>>>> for CPU's being relative vs absolute (based on real power) and should they be used to derive 'real' power
>>>>>>> at various OPPs in order to calculate things like 'sustainable-power' for thermal zones.
>>>>>>> I believe relative values work perfectly fine for scheduling decisions, but with others using this for
>>>>>>> calculating power values in mW, is there a need to document the property as something that *has* to be
>>>>>>> based on real power measurements?
>>>>>>
>>>>>> Relative values may work for scheduling decisions, but not for thermal
>>>>>> management with the power allocator, at least not when CPU cooling devices
>>>>>> are combined with others that specify their power consumption in absolute
>>>>>> values. Such a configuration should be supported IMO.
>>>>>
>>>>> The energy model is used in the cpufreq cooling device and if the
>>>>> sustainable power is consistent with the relative values then there is
>>>>> no reason it shouldn't work.
>>>>
>>>> Agreed on thermal zones that exclusively use CPUs as cooling devices, but
>>>> what when you have mixed zones, with CPUs with their pseudo-unit and e.g. a
>>>> GPU that specifies its power in mW?
>>>
>>> Well, if a SoC vendor decides to mix the units, then there is nothing we
>>> can do.
>>>
>>> When specifying the power numbers available for the SoC, they could be
>>> all scaled against the highest power number.
>>>
>>> There are so many factors on the hardware, the firmware, the kernel and
>>> the userspace sides having an impact on the energy efficiency, I don't
>>> understand why SoC vendors are so shy to share the power numbers...
>>>
>>
>> Unfortunately (because it might confuse engineers in some cases like
>> this one), even in the SCMI spec DEN0056B [1] we have this statement
>> which allows to expose an 'abstract scale' values from firmware:
>> '4.5.1 Performance domain management protocol background
>> ...The power can be expressed in mW or in an abstract scale. Vendors
>> are not obliged to reveal power costs if it is undesirable, but a linear
>> scale is required.'
>>
>> This is the source of our Energy Model values when we use SCMI cpufreq
>> driver [2].
>>
>> So this might be an issue in the future, when some SoC vendor decides to
>> not expose the real mW, but the phone OEM would then take the SoC and
>> try to add some other cooling device into the thermal zone. That new
>> device is not part of the SCMI perf but some custom and has the real mW.
>>
>> Do you think Daniel it should be somewhere documented in the kernel
>> thermal that the firmware might silently populate EM with 'abstract
>> scale'? Then special care should be taken when combining new
>> cooling devices.
>>
>> Regards,
>> Lukasz
>>
>> [1] https://developer.arm.com/documentation/den0056/b/?lang=en
>> [2] https://elixir.bootlin.com/linux/latest/source/drivers/cpufreq/scmi-cpufreq.c#L121
> 
> If an 'abstract scale' is explicitly allowed I think it should be documented
> to avoid confusion and make engineers aware of the peril of combining cooling
> devices of different types in the same thermal zone.

Rob, we should perhaps also document this as part of the DT bindings document
to be consistent, that an abstract scale is allowed when specifying the DPC
values in DT.
if you agree, I can spin a quick patch to update the documentation.

thanks,
Rajendra


-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
