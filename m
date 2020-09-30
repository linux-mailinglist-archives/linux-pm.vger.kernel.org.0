Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0947327EA8A
	for <lists+linux-pm@lfdr.de>; Wed, 30 Sep 2020 16:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730234AbgI3OEG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Sep 2020 10:04:06 -0400
Received: from foss.arm.com ([217.140.110.172]:36946 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730104AbgI3OEF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 30 Sep 2020 10:04:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01F2F30E;
        Wed, 30 Sep 2020 07:04:05 -0700 (PDT)
Received: from [10.57.54.5] (unknown [10.57.54.5])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 801673F6CF;
        Wed, 30 Sep 2020 07:04:02 -0700 (PDT)
Subject: Re: [PATCH 1/2] docs: Clarify abstract scale usage for power values
 in Energy Model
To:     Rajendra Nayak <rnayak@codeaurora.org>,
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
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <1f713ff6-32f6-4ea6-b7f7-4c61f097cf2a@arm.com>
Date:   Wed, 30 Sep 2020 15:04:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <62540312-65a2-b6d9-86ce-b4deaaa913c1@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 9/30/20 11:55 AM, Rajendra Nayak wrote:
> 
> On 9/30/2020 1:55 PM, Lukasz Luba wrote:
>> Hi Douglas,
>>
>> On 9/30/20 12:53 AM, Doug Anderson wrote:
>>> Hi,
>>>
>>> On Tue, Sep 29, 2020 at 5:16 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>>
>>>> The Energy Model (EM) can store power values in milli-Watts or in 
>>>> abstract
>>>> scale. This might cause issues in the subsystems which use the EM for
>>>> estimating the device power, such as:
>>>> - mixing of different scales in a subsystem which uses multiple
>>>>    (cooling) devices (e.g. thermal Intelligent Power Allocation (IPA))
>>>> - assuming that energy [milli-Joules] can be derived from the EM power
>>>>    values which might not be possible since the power scale doesn't 
>>>> have to
>>>>    be in milli-Watts
>>>>
>>>> To avoid misconfiguration add the needed documentation to the EM and
>>>> related subsystems: EAS and IPA.
>>>>
>>>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>>>> ---
>>>>   .../driver-api/thermal/power_allocator.rst          |  8 ++++++++
>>>>   Documentation/power/energy-model.rst                | 13 
>>>> +++++++++++++
>>>>   Documentation/scheduler/sched-energy.rst            |  5 +++++
>>>>   3 files changed, 26 insertions(+)
>>>
>>> I haven't read through these files in massive detail, but the quick
>>> skim makes me believe that your additions seem sane.  In general, I'm
>>> happy with documenting reality, thus:
>>>
>>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>>
>> Thank you for the review.
>>
>>>
>>> I will note: you haven't actually updated the device tree bindings.
>>> Thus, presumably, anyone who is specifying these numbers in the device
>>> tree is still supposed to specify them in a way that mW can be
>>> recovered, right?  Said another way: nothing about your patches makes
>>> it OK to specify numbers in device trees using an "abstract scale",
>>> right?
>>
>> For completeness, we are talking here about the binding from:
>> Documentation/devicetree/bindings/arm/cpus.yaml
>> which is 'dynamic-power-coefficient'. Yes, it stays untouched, also the
>> unit (uW/MHz/V^2) which then allows to have mW in the power
>> values in the EM.
> 
> So for platforms where 'dynamic-power-coefficient' is specified in 
> device tree,
> its always expected to be derived from 'real' power numbers on these 
> platforms in
> 'real' mW?

Yes, the purpose and the name of that binding was only for 'real'
power in mW.

> 
> Atleast on Qualcomm platforms we have these numbers scaled, so in 
> essence it
> can't be used to derive 'real' mW values. That said we also do not have 
> any of
> the 'platform might face potential issue of mixing devices in one 
> thermal zone
> of two scales' problem.

If you have these numbers scaled, then it's probably documented
somewhere in your docs for your OEMs, because they might assume it's in
uW/MHz/V^2 (according to the bindings doc). If not, they probably
realized it during the measurements and comparison (that the power in
EM is not what they see on the power meter).
This binding actually helps those developers who take the experiments
and based on measured power values, store derived coefficient.
Everyone can just measure in local setup and compare the results
easily, speaking the same language (proposing maybe a patch adjusting
the value in DT).

> 
> So the question is, can such platforms still use 
> 'dynamic-power-coefficient'
> in device tree and create an abstract scale? The other way of doing this 
> would
> be to *not* specify this value in device tree and have these values 
> stored in the
> cpufreq driver and register a custom callback to do the math.

But then we would also have to change the name of that binding.

I'd recommend you the second way that you've described. It will avoid
your OEMs confusion. In your cpufreq driver you can simply register
to EM using the em_dev_register_perf_domain(). In your local
callback you can do whatever you need (read driver array, firmware,
DT, scale or not, etc).
The helper code in dev_pm_opp_of_register_em() is probably not suited
for your use case (when you don't want to share the real power of the
SoC).

> 
> It just feels like jumping through hoops just to deal with the fact that 
> the
> device tree bindings say its expected to be in mW and can't be abstract.
> 

I don't want to add more confusion into the EM power values topic.
Overloading the meaning of that binding would create more mess.

Regards,
Lukasz
