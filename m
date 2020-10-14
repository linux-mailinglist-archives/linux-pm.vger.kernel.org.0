Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92C528DC63
	for <lists+linux-pm@lfdr.de>; Wed, 14 Oct 2020 11:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgJNJIm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Oct 2020 05:08:42 -0400
Received: from foss.arm.com ([217.140.110.172]:56728 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbgJNJIm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 14 Oct 2020 05:08:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB72A30E;
        Wed, 14 Oct 2020 02:08:40 -0700 (PDT)
Received: from [10.57.50.223] (unknown [10.57.50.223])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CE0D3F73C;
        Wed, 14 Oct 2020 02:08:37 -0700 (PDT)
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
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <b19c1f12-b7cf-fcae-4ebb-617019effe2e@arm.com>
Date:   Wed, 14 Oct 2020 10:08:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <765e6603-b614-fb72-64ff-248b42474803@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On 10/14/20 9:22 AM, Daniel Lezcano wrote:
> 
> Hi Lukasz,
> 
> On 09/10/2020 11:16, Lukasz Luba wrote:
>> Hi Rafael,
>>
>> On 10/2/20 12:44 PM, Lukasz Luba wrote:
>>> Hi all,
>>>
>>> The Energy Model supports power values expressed in an abstract scale.
>>> This has an impact on Intelligent Power Allocation (IPA) and should be
>>> documented properly. There is also a need to update the DT binding for
>>> the
>>> 'sustainable-power' and allow it to have abstract scale as well.
>>>
>>> Changes:
>>> v2:
>>> - updated sustainable power section in IPA documentation
>>> - updated DT binding for the 'sustainable-power'
>>>
>>> The v1 of the patch set and related discussion can be found in [1].
>>>
>>> Regards,
>>> Lukasz Luba
>>>
>>> [1]
>>> https://lore.kernel.org/linux-doc/20200929121610.16060-1-lukasz.luba@arm.com/
>>>
>>>
>>> Lukasz Luba (3):
>>>     docs: Clarify abstract scale usage for power values in Energy Model
>>>     PM / EM: update the comments related to power scale
>>>     dt-bindings: thermal: update sustainable-power with abstract scale
>>>
>>>    .../devicetree/bindings/thermal/thermal-zones.yaml  | 13 +++++++++----
>>>    .../driver-api/thermal/power_allocator.rst          | 13 ++++++++++++-
>>>    Documentation/power/energy-model.rst                | 13 +++++++++++++
>>>    Documentation/scheduler/sched-energy.rst            |  5 +++++
>>>    include/linux/energy_model.h                        | 11 +++++------
>>>    kernel/power/energy_model.c                         |  2 +-
>>>    6 files changed, 45 insertions(+), 12 deletions(-)
>>>
>>
>> Could you take patch 1/3 and patch 2/3 via your PM tree,
>> please? I will be very grateful.
>>
>> These patches just update the documentation and comments regarding
>> an issue that we can have: bogoWatts in the Energy Model (and we
>> already have). One of the drawbacks is that we cannot derive real energy
>> from these numbers. Will see how this would evolve.
> 
> The purpose of the energy model is to provide these power numbers.
> 
> If the SoC vendors do not want to share those numbers, then better to
> not use the energy model at all.
> 
> If they want to use the EAS and the IPA at all costs without sharing the
> power numbers, then it is up to them to take responsibility of providing
> consistent numbers, not the community to document how to hack the energy
> model.
> 
> And that is even more true as mentioned by Doug: the power numbers are
> not impossible to measure.
> 
> Documenting the scale values give the opportunity to the SoC vendor to
> never share the power numbers, and even worst, that implies all the
> existing and future frameworks based on the energy model (and its
> evolution) *must* comply with these dummy values. That is the promise of
> a real pain.
> 
> IMO, we must keep a strong constraint on the power values for the energy
> model.
> 
> However, nothing prevents to write a recipe on a website explaining how
> to use the energy model without the power numbers with a big warning
> that could not work in the future if the energy model evolves or it
> could be incompatible with the IPA.
> 
> I suggest to solve the energy model main issue: the SoC vendor do not
> want to share the power numbers. Why not give the opportunity to load a
> firmware where the power numbers will be ? The firmware could be in a
> vendor partition for example.
> 
> 

I understand your concerns. Unfortunately, the reality is that the
bogoWatts are there. I had discussion about it a few days ago with
Rajendra and Doug [1], where I was also opposed to allow bogoValue
coming from DT 'dynamic-power-coefficient'. But I have discussed it
internally and we allow, because developers would do it anyway.

Regarding your question with firmware where the power numbers can be
stored. Unfortunately, it is quite opposite, FW might want to hide it.
We even allow bogoWatts to come from firmware, the SCMI spec:
(4.5.1 Performance domain management protocol background)
'The power can be expressed in mW or in an abstract scale. Vendors are
not obliged to reveal power costs if it is undesirable, but a linear
scale is required.'
The callback which does this is not able to check if the value is a
bogoWatt [2].

EAS can handle EM with bogoWatts, as I described in the patch.
IPA has some issues: 'sustainable-power' in DT (which shouldn't be used
when EM devices use abstract scale) but sysfs interface can be used.

This patch set just align the SCMI spec with EM, EAS, IPA
documentation and already present platforms which use it.

I hope that the real milliWatts would come to EM via the DT
'dynamic-power-coefficient' and function dev_pm_opp_of_register_em().
But no guaranties as you can see in [1].

Regards,
Lukasz

[1] 
https://lore.kernel.org/linux-pm/62540312-65a2-b6d9-86ce-b4deaaa913c1@codeaurora.org/
[2] 
https://elixir.bootlin.com/linux/v5.9/source/drivers/cpufreq/scmi-cpufreq.c#L118
