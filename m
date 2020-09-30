Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAD027EDC0
	for <lists+linux-pm@lfdr.de>; Wed, 30 Sep 2020 17:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725799AbgI3Ps1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Sep 2020 11:48:27 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:29581 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgI3PsZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 30 Sep 2020 11:48:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601480904; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=YWeQIL8fxk/H6GlCrRVI/PVv6gN/aHmAPprkx25W8cE=; b=B5pcyh4uGymW8WcAniE2pjmXuuiGeZ4o+3BaS4wka39HFWy4pM0DsFVkNTwhHGQekzTpYZ3N
 5PC6Ko7gy9JMhFBRpqPZKnrfsW9cx8H7W4I/K4o53q0AVIImQx6TXJX1Del4IZgNfYPYPBAD
 jfMfzQ8YeU9Qi4p0/wP9TiHohQ8=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f74a8c79025c3a797474d3d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 30 Sep 2020 15:48:23
 GMT
Sender: rnayak=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B98CBC433CB; Wed, 30 Sep 2020 15:48:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.0.118] (unknown [49.207.198.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 824FFC433C8;
        Wed, 30 Sep 2020 15:48:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 824FFC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH 1/2] docs: Clarify abstract scale usage for power values
 in Energy Model
To:     Lukasz Luba <lukasz.luba@arm.com>,
        Doug Anderson <dianders@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dietmar.Eggemann@arm.com, Quentin Perret <qperret@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20200929121610.16060-1-lukasz.luba@arm.com>
 <CAD=FV=UnNkjMiOc0DZE7+OM3-Kr1ZRynxSerdA=ifbyGiRa2Zw@mail.gmail.com>
 <a1d1fe2a-485f-a21e-2f91-9b609223aa5a@arm.com>
 <62540312-65a2-b6d9-86ce-b4deaaa913c1@codeaurora.org>
 <1f713ff6-32f6-4ea6-b7f7-4c61f097cf2a@arm.com>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <b74a5907-47dc-6c3c-3da8-94959af07ea8@codeaurora.org>
Date:   Wed, 30 Sep 2020 21:18:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1f713ff6-32f6-4ea6-b7f7-4c61f097cf2a@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 9/30/2020 7:34 PM, Lukasz Luba wrote:
> 
> 
> On 9/30/20 11:55 AM, Rajendra Nayak wrote:
>>
>> On 9/30/2020 1:55 PM, Lukasz Luba wrote:
>>> Hi Douglas,
>>>
>>> On 9/30/20 12:53 AM, Doug Anderson wrote:
>>>> Hi,
>>>>
>>>> On Tue, Sep 29, 2020 at 5:16 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>>>
>>>>> The Energy Model (EM) can store power values in milli-Watts or in abstract
>>>>> scale. This might cause issues in the subsystems which use the EM for
>>>>> estimating the device power, such as:
>>>>> - mixing of different scales in a subsystem which uses multiple
>>>>>    (cooling) devices (e.g. thermal Intelligent Power Allocation (IPA))
>>>>> - assuming that energy [milli-Joules] can be derived from the EM power
>>>>>    values which might not be possible since the power scale doesn't have to
>>>>>    be in milli-Watts
>>>>>
>>>>> To avoid misconfiguration add the needed documentation to the EM and
>>>>> related subsystems: EAS and IPA.
>>>>>
>>>>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>>>>> ---
>>>>>   .../driver-api/thermal/power_allocator.rst          |  8 ++++++++
>>>>>   Documentation/power/energy-model.rst                | 13 +++++++++++++
>>>>>   Documentation/scheduler/sched-energy.rst            |  5 +++++
>>>>>   3 files changed, 26 insertions(+)
>>>>
>>>> I haven't read through these files in massive detail, but the quick
>>>> skim makes me believe that your additions seem sane.  In general, I'm
>>>> happy with documenting reality, thus:
>>>>
>>>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>>>
>>> Thank you for the review.
>>>
>>>>
>>>> I will note: you haven't actually updated the device tree bindings.
>>>> Thus, presumably, anyone who is specifying these numbers in the device
>>>> tree is still supposed to specify them in a way that mW can be
>>>> recovered, right?  Said another way: nothing about your patches makes
>>>> it OK to specify numbers in device trees using an "abstract scale",
>>>> right?
>>>
>>> For completeness, we are talking here about the binding from:
>>> Documentation/devicetree/bindings/arm/cpus.yaml
>>> which is 'dynamic-power-coefficient'. Yes, it stays untouched, also the
>>> unit (uW/MHz/V^2) which then allows to have mW in the power
>>> values in the EM.
>>
>> So for platforms where 'dynamic-power-coefficient' is specified in device tree,
>> its always expected to be derived from 'real' power numbers on these platforms in
>> 'real' mW?
> 
> Yes, the purpose and the name of that binding was only for 'real'
> power in mW.
> 
>>
>> Atleast on Qualcomm platforms we have these numbers scaled, so in essence it
>> can't be used to derive 'real' mW values. That said we also do not have any of
>> the 'platform might face potential issue of mixing devices in one thermal zone
>> of two scales' problem.
> 
> If you have these numbers scaled, then it's probably documented
> somewhere in your docs for your OEMs, because they might assume it's in
> uW/MHz/V^2 (according to the bindings doc). If not, they probably
> realized it during the measurements and comparison (that the power in
> EM is not what they see on the power meter).
> This binding actually helps those developers who take the experiments
> and based on measured power values, store derived coefficient.
> Everyone can just measure in local setup and compare the results
> easily, speaking the same language (proposing maybe a patch adjusting
> the value in DT).
> 
>>
>> So the question is, can such platforms still use 'dynamic-power-coefficient'
>> in device tree and create an abstract scale? The other way of doing this would
>> be to *not* specify this value in device tree and have these values stored in the
>> cpufreq driver and register a custom callback to do the math.
> 
> But then we would also have to change the name of that binding.
> 
> I'd recommend you the second way that you've described. It will avoid
> your OEMs confusion. In your cpufreq driver you can simply register
> to EM using the em_dev_register_perf_domain(). In your local
> callback you can do whatever you need (read driver array, firmware,
> DT, scale or not, etc).
> The helper code in dev_pm_opp_of_register_em() is probably not suited
> for your use case (when you don't want to share the real power of the
> SoC).

Got it, thanks for the clarification. I will get the cpufreq driver updated
to use em_dev_register_perf_domain() with a custom callback and get rid of these
values from device tree.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
