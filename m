Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E8828EEE9
	for <lists+linux-pm@lfdr.de>; Thu, 15 Oct 2020 11:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388559AbgJOJAr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Oct 2020 05:00:47 -0400
Received: from foss.arm.com ([217.140.110.172]:48936 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388539AbgJOJAr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 15 Oct 2020 05:00:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E662AD6E;
        Thu, 15 Oct 2020 02:00:45 -0700 (PDT)
Received: from [10.57.48.138] (unknown [10.57.48.138])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 005E23F66B;
        Thu, 15 Oct 2020 02:00:42 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] Clarify abstract scale usage for power values in
 Energy Model, EAS and IPA
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, amitk@kernel.org,
        corbet@lwn.net, Dietmar.Eggemann@arm.com, qperret@google.com,
        dianders@chromium.org, mka@chromium.org, rnayak@codeaurora.org
References: <20201002114426.31277-1-lukasz.luba@arm.com>
 <d2960f6a-1805-1fb4-98ae-4a756d20370b@arm.com>
 <765e6603-b614-fb72-64ff-248b42474803@linaro.org>
 <b19c1f12-b7cf-fcae-4ebb-617019effe2e@arm.com>
 <55d3fb0f-f7d8-63c5-2bdb-53eaa62380e0@linaro.org>
 <f660731e-132b-2514-f526-d7123ed3522c@arm.com>
 <d04019bd-9e85-5f3e-2a1b-66780b8df3dc@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <3e3dd42c-48ac-7267-45c5-ca88205611bd@arm.com>
Date:   Thu, 15 Oct 2020 10:00:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <d04019bd-9e85-5f3e-2a1b-66780b8df3dc@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10/14/20 6:10 PM, Daniel Lezcano wrote:
> On 14/10/2020 17:24, Lukasz Luba wrote:
> 
> [ ... ]
> 
>> We have to update the EM doc about allowed abstract scale, which
>> implies EAS, IPA doc update with some information to the community that
>> these components can handle it.
>>
>> The script will just make developers life easier, but the current
>> documentation does not say anything about abstract scale.
> 
> ... yes, because there is no consistency across the source of power
> numbers and no tools to ensure DT power numbers consistency, yet.
> 
>>> In any case, if the DT is specifying real numbers, and SCMI abstract
>>> numbers or the opposite, obviously there is a conflict if we are using
>>> both.
>>
>> True, DT only allows real numbers (I have Rob's opinion regarding
>> patch 3/3).
>>
>> It's not that there is only SCMI which might use abstract scale. Qcom
>> already has it and other vendors will follow (not exposing real
>> numbers). They would register bogoWatts to EM because they know that EAS
>> can deal with both.
> 
> So vendors are using bogoWatts, despite the documentation.
> 
> By updating the documentation saying it supports the abstract values,
> that means every new framework, device with power values, will have to
> comply with that. How is it possible to add a device with power numbers
> if the existing ones are obfuscated ?

Good question. I've been thinking about this Qcom platform. If
someone after a while would like to add new device to EM e.g DSP
of that SoC, then it has to measure the real power and decode the
existing numbers for the CPUs. Then encode the new device power
numbers in the same way and register to EM.

> 
> With two subsystems using the energy model, evolving independently we
> can see there are conflicts. With more subsystems, that may become a
> source of confusion, especially with different contributors.
> 
> I think the energy model should stick to milliwatts and keep the
> documentation unchanged regarding this. And vendors should take the
> responsibility of not sticking to the documentation.
> 
>>> I suggest to fix the conflict first and provide the features to make the
>>> numbers more easy to share (like the script described above and/or the
>>> firmware file).
>>>
>>> Then with the right tools, everything can be documented.
>>>
>>
>> We cannot block one way of registration to EM when the other was used.
>> They might have correct and consistent numbers.
> 
> What is the rational of using two firmware power information ?

I mean, there is two ways to register into EM:
1) em_dev_register_perf_domain() - can bring milliWatts or bogoWatts
2) dev_pm_opp_of_register_em() - should bring only milliWatts


> 
>> It's up to the platform developers to choose the path:
>> - go with bogoWatts - if they are not allowed to expose sensitive
>>    information, use em_dev_register_perf_domain() in drivers, not DT;
>>    make sure everything that is needed works; check the doc, which
>>    sub-systems can handle it or needs some tuning (patches 1/3 and 2/3
>>    try to help here);
>> - use milliWatts - easier; DT is allowed; help from the community in
>>    reviews, possible results comparisons; both EM registration ways
>>    might be used;
>>
>> We cannot force vendors/OEM engineers to store milliWatts in the
>> Energy Model if these values are protected by some NDA.
> 
> If I am able to measure one real power value, (and I'm pretty sure it is
> quite possible), whatever which one, it is possible to deduce all the
> numbers with the linear scale. IMO that is a false debate. Anyway ...
> 
>> Your proposed
>> way of providing data into EM from user-space firmware.bin IMHO also
>> falls into the same bucket. That information would be accessible in EM
>> debugfs and they would avoid it.
> 
> I think you misunderstood my point.
> 
> There is the SCMI and the DT. Because there are two sources where it is
> impossible to know if they are using the same units, we are stuck to
> ensure a consistency for the kernel.
> 
> The platform should use:
>   - the SCMI only (scaled or real)
>   - the DT only (real)
>   [ - the firmware file only (scaled or real) ]
> 

Do you mean by SCMI - registration using em_dev_register_perf_domain() ?

> 
> As it is not possible to know if they are scaled or real, there is no
> choice except making them mutually exclusive.

So you propose a bit more restriction in registration EM, to not get
lost in the future. I also have these doubts. Let's consider it and
maybe agree.

I've recommended Qcom to use em_dev_register_perf_domain() when they
have this obfuscated power values. Then any developer in the future
who wants to add EM for a new device on that platform, should use the
em_dev_register_perf_domain().

In this case the flag in EM that you have proposed makes sense.
We probably need an argument 'bool abstract_scale' in the
em_dev_register_perf_domain(..., bool abstract_scale)
as a source of information.

We would allow to co-exist em_dev_register_perf_domain(..., false)
with dev_pm_opp_of_register_em() EM devices.

Is it make sense?

> 
>  From my POV, it is not adequate to let SCMI power information co-exists
> with the DT power information if we know they can be with different units.
> 
> I've just expressed my opinions:
> 
>   - vendors take responsibility of putting different units for the EM
> 
>   - Power numbers should come from the same source
> 
> 
> Up to Rafael to decide what to do with this documentation update.
> 
> Thanks
>    -- Daniel
> 
> 

Thank you for your valuable opinion.

Regards,
Lukasz
