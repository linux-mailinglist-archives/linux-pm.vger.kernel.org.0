Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F74028E339
	for <lists+linux-pm@lfdr.de>; Wed, 14 Oct 2020 17:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389189AbgJNPYx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Oct 2020 11:24:53 -0400
Received: from foss.arm.com ([217.140.110.172]:51604 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389108AbgJNPYx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 14 Oct 2020 11:24:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B82ED6E;
        Wed, 14 Oct 2020 08:24:48 -0700 (PDT)
Received: from [10.57.50.223] (unknown [10.57.50.223])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BD1A3F71F;
        Wed, 14 Oct 2020 08:24:44 -0700 (PDT)
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
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <f660731e-132b-2514-f526-d7123ed3522c@arm.com>
Date:   Wed, 14 Oct 2020 16:24:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <55d3fb0f-f7d8-63c5-2bdb-53eaa62380e0@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10/14/20 12:23 PM, Daniel Lezcano wrote:
> On 14/10/2020 11:08, Lukasz Luba wrote:
>> Hi Daniel,
>>
>> On 10/14/20 9:22 AM, Daniel Lezcano wrote:
>>>
>>> Hi Lukasz,
>>>
>>> On 09/10/2020 11:16, Lukasz Luba wrote:
>>>> Hi Rafael,
>>>>
>>>> On 10/2/20 12:44 PM, Lukasz Luba wrote:
>>>>> Hi all,
>>>>>
>>>>> The Energy Model supports power values expressed in an abstract scale.
>>>>> This has an impact on Intelligent Power Allocation (IPA) and should be
>>>>> documented properly. There is also a need to update the DT binding for
>>>>> the
>>>>> 'sustainable-power' and allow it to have abstract scale as well.
>>>>>
>>>>> Changes:
>>>>> v2:
>>>>> - updated sustainable power section in IPA documentation
>>>>> - updated DT binding for the 'sustainable-power'
>>>>>
>>>>> The v1 of the patch set and related discussion can be found in [1].
>>>>>
>>>>> Regards,
>>>>> Lukasz Luba
>>>>>
>>>>> [1]
>>>>> https://lore.kernel.org/linux-doc/20200929121610.16060-1-lukasz.luba@arm.com/
>>>>>
>>>>>
>>>>>
>>>>> Lukasz Luba (3):
>>>>>      docs: Clarify abstract scale usage for power values in Energy Model
>>>>>      PM / EM: update the comments related to power scale
>>>>>      dt-bindings: thermal: update sustainable-power with abstract scale
>>>>>
>>>>>     .../devicetree/bindings/thermal/thermal-zones.yaml  | 13
>>>>> +++++++++----
>>>>>     .../driver-api/thermal/power_allocator.rst          | 13
>>>>> ++++++++++++-
>>>>>     Documentation/power/energy-model.rst                | 13
>>>>> +++++++++++++
>>>>>     Documentation/scheduler/sched-energy.rst            |  5 +++++
>>>>>     include/linux/energy_model.h                        | 11 +++++------
>>>>>     kernel/power/energy_model.c                         |  2 +-
>>>>>     6 files changed, 45 insertions(+), 12 deletions(-)
>>>>>
>>>>
>>>> Could you take patch 1/3 and patch 2/3 via your PM tree,
>>>> please? I will be very grateful.
>>>>
>>>> These patches just update the documentation and comments regarding
>>>> an issue that we can have: bogoWatts in the Energy Model (and we
>>>> already have). One of the drawbacks is that we cannot derive real energy
>>>> from these numbers. Will see how this would evolve.
>>>
>>> The purpose of the energy model is to provide these power numbers.
>>>
>>> If the SoC vendors do not want to share those numbers, then better to
>>> not use the energy model at all.
>>>
>>> If they want to use the EAS and the IPA at all costs without sharing the
>>> power numbers, then it is up to them to take responsibility of providing
>>> consistent numbers, not the community to document how to hack the energy
>>> model.
>>>
>>> And that is even more true as mentioned by Doug: the power numbers are
>>> not impossible to measure.
>>>
>>> Documenting the scale values give the opportunity to the SoC vendor to
>>> never share the power numbers, and even worst, that implies all the
>>> existing and future frameworks based on the energy model (and its
>>> evolution) *must* comply with these dummy values. That is the promise of
>>> a real pain.
>>>
>>> IMO, we must keep a strong constraint on the power values for the energy
>>> model.
>>>
>>> However, nothing prevents to write a recipe on a website explaining how
>>> to use the energy model without the power numbers with a big warning
>>> that could not work in the future if the energy model evolves or it
>>> could be incompatible with the IPA.
>>>
>>> I suggest to solve the energy model main issue: the SoC vendor do not
>>> want to share the power numbers. Why not give the opportunity to load a
>>> firmware where the power numbers will be ? The firmware could be in a
>>> vendor partition for example.
>>>
>>>
>>
>> I understand your concerns. Unfortunately, the reality is that the
>> bogoWatts are there. I had discussion about it a few days ago with
>> Rajendra and Doug [1], where I was also opposed to allow bogoValue
>> coming from DT 'dynamic-power-coefficient'. But I have discussed it
>> internally and we allow, because developers would do it anyway.
> 
> With all respects, 'internal discussions' is like out of tree kernels:
> for the community, they don't exist :)
> 
> The development process in opensource is, by essence, public.

Please don't get me wrong. I just wanted to say that this issue has been
discussed in Arm Power team and presented here in public (and it's not
my private view - but the team) responding to community questions.

> 
> That said, if the developers want to use abstract values, up to them to
> make sure it is consistent with the existing framework.
> 
> Why do you need to document that and involve the community
> responsibility by adding these information in the Documentation even if
> you know different frameworks could be incompatible ?

The community asked for better documentation [1].
'I believe relative values work perfectly fine for scheduling decisions'
	Rajendra
(who was right, EAS works fine, but it is not documented)

It started from the discussion there, then discussion on v1 of this
patch set.

So it's the Community who wanted to know more information about 'real'
vs 'abstract' scale for power and the EM registration process.
They made a point and I had to consult it with my team.

> 
> 
>> Regarding your question with firmware where the power numbers can be
>> stored. Unfortunately, it is quite opposite, FW might want to hide it.
> 
> No, I meant a firmware file, called by request_firmware(). So instead of
> having the power numbers in the DT, so published with the kernel, they
> are in the SoC vendor's partition in the firmware file, like
> 'energy_model.bin'.
> 
> Then when the energy model is initialized, it will try to request an
> energy model firmware file.
> 
> That gives the opportunity to the SoC vendor to put the power numbers in
> the file and distribute it with the product.

Yes, but it will not protect EM from vendors writing bogoWatts in there.

> 
>> We even allow bogoWatts to come from firmware, the SCMI spec:
>> (4.5.1 Performance domain management protocol background)
>> 'The power can be expressed in mW or in an abstract scale. Vendors are
>> not obliged to reveal power costs if it is undesirable, but a linear
>> scale is required.'
>> The callback which does this is not able to check if the value is a
>> bogoWatt [2].
> 
> So the definition is clear: '... linear scale is required'. So that
> implies *all* power numbers for all devices defined in the SCMI. It is
> up to the SoC vendor to provide the right numbers.

Yes, we wanted to add this to the documentation to make it clear.

> 
> The EM / IPA / EAS do not have to care about the values.

Community developers are asking about it: if IPA or EAS can handle it.
Thus this documentation update.

> 
>> EAS can handle EM with bogoWatts, as I described in the patch.
>> IPA has some issues: 'sustainable-power' in DT (which shouldn't be used
>> when EM devices use abstract scale) but sysfs interface can be used.
> 
> Here the platform is mixing the numbers from different firmwares with
> different units.
> 
> Why not make things consistent ? If the power numbers are coming from
> the SCMI, then ignore the ones coming from the DT, no? That should be
> simpler now that we have the energy model used for devfreq and cpufreq.

The numbers coming from SCMI might be also real mW, the spec allows to
be either milliWatts or bogoWatts. So we cannot block SCMI in your
example.

> 
> May be add a flag in the energy model giving the origin of the data?

I think the flag could cause wrong assumptions.

> 
>> This patch set just align the SCMI spec with EM, EAS, IPA
>> documentation and already present platforms which use it.
> 
> Actually, it is the opposite, the patch aligns EAS and EM to the SCMI
> spec, but we end up with IPA based on the EM/SCMI & DT and EAS based on
> EM/SCMI, right ?

Yes, correct, it aligns EAS, EM with SCMI spec and also community
driver. It makes it clear that EM, EAS allows abstract scale for all
drivers not only SCMI (like Qcom with values not exposing sensitive
information (milliWatts)).

> 
> That is the root cause of the incompatibility.

The patch 3/3 from this series is dropped. Just the IPA documentation is
going to be updated (patch 1/3). It should be, because in EM abstract
scale is allowed and we use EM in IPA.
DT binding for 'sustainable-power' stays as is.

> 
>> I hope that the real milliWatts would come to EM via the DT
>> 'dynamic-power-coefficient' and function dev_pm_opp_of_register_em().
>> But no guaranties as you can see in [1].
> 
> It is not a kernel problem if inconsistent values are specified in the DT.
> 
> May be make developer life easier by submitting a script which will take
> a device tree, check all power numbers, and consistently abstract them.
> The developer will write the real values in the DT, test everything is
> working fine, then run the script which will make the 'linear scale' of
> all the power numbers and convert them to bogoWatt (with different
> properties name, so watt and bogowatt mix can be detected).

Do you mean a new property in DT? Which would handle the bogoWatts?

IMHO DT describes only the HW, using it as a helper for SW abstractions
abuses it. It already has these 'sust. power', 'dynamic-power-coeff.'
and 'capacity-dmips-mhz'. I think Rob will also be against another
stuff fixing our 'generic' software.

We have to update the EM doc about allowed abstract scale, which
implies EAS, IPA doc update with some information to the community that
these components can handle it.

The script will just make developers life easier, but the current
documentation does not say anything about abstract scale.

> 
> In any case, if the DT is specifying real numbers, and SCMI abstract
> numbers or the opposite, obviously there is a conflict if we are using both.

True, DT only allows real numbers (I have Rob's opinion regarding
patch 3/3).

It's not that there is only SCMI which might use abstract scale. Qcom
already has it and other vendors will follow (not exposing real
numbers). They would register bogoWatts to EM because they know that EAS
can deal with both.

> 
> I suggest to fix the conflict first and provide the features to make the
> numbers more easy to share (like the script described above and/or the
> firmware file).
> 
> Then with the right tools, everything can be documented.
> 

We cannot block one way of registration to EM when the other was used.
They might have correct and consistent numbers.

It's up to the platform developers to choose the path:
- go with bogoWatts - if they are not allowed to expose sensitive
   information, use em_dev_register_perf_domain() in drivers, not DT;
   make sure everything that is needed works; check the doc, which
   sub-systems can handle it or needs some tuning (patches 1/3 and 2/3
   try to help here);
- use milliWatts - easier; DT is allowed; help from the community in
   reviews, possible results comparisons; both EM registration ways
   might be used;

We cannot force vendors/OEM engineers to store milliWatts in the
Energy Model if these values are protected by some NDA. Your proposed
way of providing data into EM from user-space firmware.bin IMHO also
falls into the same bucket. That information would be accessible in EM
debugfs and they would avoid it.

Regards,
Lukasz

[1] 
https://lore.kernel.org/linux-devicetree/248bb01e-1746-c84c-78c4-3cf7d2541a70@codeaurora.org/
