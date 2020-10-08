Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB07B2875E3
	for <lists+linux-pm@lfdr.de>; Thu,  8 Oct 2020 16:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730401AbgJHOVF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Oct 2020 10:21:05 -0400
Received: from foss.arm.com ([217.140.110.172]:60076 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729992AbgJHOVE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Oct 2020 10:21:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87C1A1063;
        Thu,  8 Oct 2020 07:21:03 -0700 (PDT)
Received: from [10.57.48.204] (unknown [10.57.48.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D7FB3F70D;
        Thu,  8 Oct 2020 07:21:00 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] dt-bindings: thermal: update sustainable-power
 with abstract scale
To:     Doug Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dietmar.Eggemann@arm.com, Quentin Perret <qperret@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20201002114426.31277-1-lukasz.luba@arm.com>
 <20201002114426.31277-4-lukasz.luba@arm.com>
 <CAD=FV=UbNP5-G1z95F37Fmv8=n0JPSSwnPQO_K==WpAc4vAHWQ@mail.gmail.com>
 <e9b6fc5a-45d3-168d-db38-6c068da26f6b@arm.com>
 <CAD=FV=Xkg1zpsMW5rERbibnjrgY6opZi8Z9DUFkWebb7NHtU5w@mail.gmail.com>
 <bc5d21c1-ea84-9132-2e52-ae84fbb0515a@arm.com>
 <CAD=FV=VfA8AB3BZk8Ykkhigv9eGijzu4zuA6KdXk0K5UG0yCCQ@mail.gmail.com>
 <CAL_JsqJ37TVk4=E1DyZuhfH1jZ7wyauGLucSH7XW9wkeT3PSgg@mail.gmail.com>
 <CAD=FV=Vy641h5KNLKipC1n=tgjp7a3HGHw0odY9fNpwdqorrAg@mail.gmail.com>
 <CAL_JsqJ=brfbLiTm9D+p2N0Az-gcStbYj=RS2EaG50dHo0-5WA@mail.gmail.com>
 <CAD=FV=XF_kqr0=vBqHVT4RWB8NWx0kHoFnap-smxtv_m+GQvSg@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <45fae8cd-0635-41dc-c744-3c9833bf6492@arm.com>
Date:   Thu, 8 Oct 2020 15:20:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=XF_kqr0=vBqHVT4RWB8NWx0kHoFnap-smxtv_m+GQvSg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10/7/20 10:40 PM, Doug Anderson wrote:
> Hi,
> 
> On Wed, Oct 7, 2020 at 6:26 AM Rob Herring <robh+dt@kernel.org> wrote:
>>
>> On Tue, Oct 6, 2020 at 8:17 PM Doug Anderson <dianders@chromium.org> wrote:
>>>
>>> Hi,
>>>
>>> On Tue, Oct 6, 2020 at 3:24 PM Rob Herring <robh+dt@kernel.org> wrote:
>>>>
>>>> On Fri, Oct 2, 2020 at 12:39 PM Doug Anderson <dianders@chromium.org> wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> On Fri, Oct 2, 2020 at 9:40 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>>>>
>>>>>> On 10/2/20 4:47 PM, Doug Anderson wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On Fri, Oct 2, 2020 at 8:13 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>>>>>>
>>>>>>>> Hi Doug,
>>>>>>>>
>>>>>>>> On 10/2/20 3:31 PM, Doug Anderson wrote:
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> On Fri, Oct 2, 2020 at 4:45 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>>>>>>>>
>>>>>>>>>> Update the documentation for the binding 'sustainable-power' and allow
>>>>>>>>>> to provide values in an abstract scale. It is required when the cooling
>>>>>>>>>> devices use an abstract scale for their power values.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>>>>>>>>>> ---
>>>>>>>>>>     .../devicetree/bindings/thermal/thermal-zones.yaml  | 13 +++++++++----
>>>>>>>>>>     1 file changed, 9 insertions(+), 4 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
>>>>>>>>>> index 3ec9cc87ec50..4d8f2e37d1e6 100644
>>>>>>>>>> --- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
>>>>>>>>>> +++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
>>>>>>>>>> @@ -99,10 +99,15 @@ patternProperties:
>>>>>>>>>>           sustainable-power:
>>>>>>>>>>             $ref: /schemas/types.yaml#/definitions/uint32
>>>>>>>>>>             description:
>>>>>>>>>> -          An estimate of the sustainable power (in mW) that this thermal zone
>>>>>>>>>> -          can dissipate at the desired control temperature. For reference, the
>>>>>>>>>> -          sustainable power of a 4-inch phone is typically 2000mW, while on a
>>>>>>>>>> -          10-inch tablet is around 4500mW.
>>>>>>>>>> +          An estimate of the sustainable power (in mW or in an abstract scale)
>>>>>>>>>> +         that this thermal zone can dissipate at the desired control
>>>>>>>>>> +         temperature. For reference, the sustainable power of a 4-inch phone
>>>>>>>>>> +         is typically 2000mW, while on a 10-inch tablet is around 4500mW.
>>>>>>>>>> +
>>>>>>>>>> +         It is possible to express the sustainable power in an abstract
>>>>>>>>>> +         scale. This is the case when the related cooling devices use also
>>>>>>>>>> +         abstract scale to express their power usage. The scale must be
>>>>>>>>>> +         consistent.
>>>>>>>>>
>>>>>>>>> Two thoughts:
>>>>>>>>>
>>>>>>>>> 1. If we're going to allow "sustainable-power" to be in abstract
>>>>>>>>> scale, why not allow "dynamic-power-coefficient" to be in abstract
>>>>>>>>> scale too?  I assume that the whole reason against that originally was
>>>>>>>>> the idea of device tree purity, but if we're allowing the abstract
>>>>>>>>> scale here then there seems no reason not to allow it for
>>>>>>>>> "dynamic-power-coefficient".
>>>>>>>>
>>>>>>>> With this binding it's a bit more tricky.
>>>>>>>> I also have to discuss a few things internally. This requirement of
>>>>>>>> uW/MHz/V^2 makes the code easier also for potential drivers
>>>>>>>> like GPU (which are going to register the devfreq cooling with EM).
>>>>>>>>
>>>>>>>> Let me think about it, but for now I would just update these bits.
>>>>>>>> These are required to proper IPA operation, the dyn.-pow.-coef. is a
>>>>>>>> nice to have and possible next step.
>>>>>>>
>>>>>>> I guess the problem is that Rajendra is currently planning to remove
>>>>>>> all the "dynamic-power-coefficient" values from device tree right now
>>>>>>> and move them to the source code because the numbers we currently have
>>>>>>> in the device tree _are_ in abstract scale and thus violate the
>>>>>>> bindings.  Moving this to source code won't help us get to more real
>>>>>>> power numbers (since it'll still be abstract scale), it'll just be
>>>>>>> pure churn.  If we're OK with the abstract scale in general then we
>>>>>>> should allow it everywhere and not add churn for no reason.
>>>>>>
>>>>>> IIUC he is still going to use the Energy Model, but with different
>>>>>> registration function. We have such a driver: scmi-cpufreq.c, which
>>>>>> uses em_dev_register_perf_domain(). He can still use EM, EAS, IPA
>>>>>> not violating anything.
>>>>>
>>>>> Right.  He's going to take the exact same "abstract scale" numbers
>>>>> that he has today and take them out of device tree and put them in the
>>>>> cpufreq driver.  Doing so magically makes it so that he's not
>>>>> violating anything since "abstract scale" is not currently allowed in
>>>>> device tree but is allowed in the cpufreq driver.  I'm not saying that
>>>>> he's doing anything wrong, I'm just saying that it's pointless churn.
>>>>> If we're OK with "abstract scale" in one place in the device tree we
>>>>> should be OK with it everywhere in the device tree.  Then Rajendra
>>>>> wouldn't need his patch at all and he could leave his numbers in the
>>>>> device tree.
>>>>>
>>>>>
>>>>>> The real problem that we want to address is with sustainable-power in
>>>>>> IPA. It is used in power budget calculation and if the devices operate
>>>>>> in abstract scale, then there is an issue.
>>>>>> There are two options to get that value:
>>>>>> 1. from DT, which can have optimized value, stored by OEM engineer
>>>>>> 2. from IPA estimation code, which just calculates it as a sum of
>>>>>> minimum OPP power for each cooling device.
>>>>>>
>>>>>> The 2nd option might not be the best for a platform, so vendor/OEM
>>>>>> engineer might want to provide a better value in DT -> 1st option.
>>>>>> This is currently against the binding description and I have to fix it.
>>>>>
>>>>> Right, things are already broken today because a SoC vendor could
>>>>> (without violating any rules) provide their SoC core
>>>>> "dynamic-power-coefficient" in "abstract scale" in code and there
>>>>> would be no way to for a board to (without violating DT bindings)
>>>>> specify a "sustainable-power".  ...so, in that sense, your patch does
>>>>> provide a benefit even if we don't make any changes to the rules for
>>>>> "sustainable-power".  All I'm saying is that if these new rules for
>>>>> allowing an abstract scale for "sustainable-power" in the device tree
>>>>> are OK that it should _also_ be OK to add new rules to allow an
>>>>> abstract scale for "dynamic-power-coefficient".
>>>>
>>>> Didn't we beat this one to death with "dynamic-power-coefficient"?
>>>
>>> We did?  Where / when?
>>
>> https://lore.kernel.org/r/1448288921-30307-1-git-send-email-juri.lelli@arm.com/
> 
> Thanks for the reference.
> 
> 
>>> I'm not sure I was involved, but right now
>>> both "sustainable-power" and "dynamic-power-coefficient" are still
>>> defined in the device tree to be in real units, not abstract scale.
>>> Are you saying that we beat it to death and decided that it needed to
>>> be in real units, or we beat it to death and decided that abstract
>>> scale was OK and we just didn't put it in the bindings?
>>
>> The former.
> 
> OK.  So I suppose this is a NAK to Lukasz's patch.  It also means that:

I also consider this as a NAK for this patch 3/3, but other two can go.
It will be also NAK for dt-binding change adding 'abstract scale'
description to "dynamic-power-coefficient", so I won't post it.

> 
> * The power numbers that landed in the sc7180 devicetree violate
> what's documented in the bindings.
> 
> * While Rajendra can fix this by moving the numbers out of devicetree
> and into code, it doesn't really help us because there will be no way
> to allow boards to specify their "sustainable-power" in code.
> 
> * Anyone who is using the "abstract scale" provided by firmware or by
> code is in the same boat.  There's no way for a board to specify
> "sustainable-power" that will match this "abstract scale" without
> violating the devicetree bindings.
> 
> Obviously the easiest way to fix this is to just move everyone off of
> "abstract scale".
> 
> If someone else has other bright ideas I'm all ears.

To summarize, we allow abstract scale to be in EM, EAS and IPA.
For EM/EAS it is possible have this via
em_dev_register_perf_domain()
IPA would also get these devices with abstract scale, but the DT
"sustainable-power" would not be aligned, so might be not set in DT.
For that, what would help:
- IPA internal code for sustainable power estimation
- thermal sysfs interface for IPA 'sustainable_power'

In this case I think patch 1/3 and 2/3 can go into upstream.
This one (patch 3/3) can be dropped.

Thank you Rob and Doug for this discussion.

Regards,
Lukasz

