Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D90E729F100
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 17:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgJ2QQC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Oct 2020 12:16:02 -0400
Received: from foss.arm.com ([217.140.110.172]:40076 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgJ2QQC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 29 Oct 2020 12:16:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90AA6139F;
        Thu, 29 Oct 2020 09:16:00 -0700 (PDT)
Received: from [10.57.13.20] (unknown [10.57.13.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 490853F66E;
        Thu, 29 Oct 2020 09:15:56 -0700 (PDT)
Subject: Re: [PATCH v3 0/4] Clarify abstract scale usage for power values in
 Energy Model, EAS and IPA
To:     Doug Anderson <dianders@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        morten.rasmussen@arm.com, Quentin Perret <qperret@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>
References: <20201019140601.3047-1-lukasz.luba@arm.com>
 <CAD=FV=UYeo_rWBDRu-53Aw2OeY1NCgCuUJkocRM8xL+OCbJDug@mail.gmail.com>
 <62430cb9-eaab-b215-0eec-d35d3c625406@arm.com>
 <CAD=FV=VA=tYzvb2-WQOJz7UGq-459R4+6xfuPQ-h-iMCKPP9vQ@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <3ba6ff0a-b4b0-159d-4d38-296652a80b08@arm.com>
Date:   Thu, 29 Oct 2020 16:15:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=VA=tYzvb2-WQOJz7UGq-459R4+6xfuPQ-h-iMCKPP9vQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10/29/20 3:39 PM, Doug Anderson wrote:
> Hi,
> 
> On Thu, Oct 29, 2020 at 5:37 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> On 10/20/20 1:15 AM, Doug Anderson wrote:
>>> Hi,
>>>
>>> On Mon, Oct 19, 2020 at 7:06 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>>
>>>> Hi all,
>>>>
>>>> The Energy Model supports power values expressed in an abstract scale.
>>>> This has an impact on Intelligent Power Allocation (IPA) and should be
>>>> documented properly. Kernel sub-systems like EAS, IPA and DTPM
>>>> (new comming PowerCap framework) would use the new flag to capture
>>>> potential miss-configuration where the devices have registered different
>>>> power scales, thus cannot operate together.
>>>>
>>>> There was a discussion below v2 of this patch series, which might help
>>>> you to get context of these changes [2].
>>>>
>>>> The agreed approach is to have the DT as a source of power values expressed
>>>> always in milli-Watts and the only way to submit with abstract scale values
>>>> is via the em_dev_register_perf_domain() API.
>>>>
>>>> Changes:
>>>> v3:
>>>> - added boolean flag to struct em_perf_domain and registration function
>>>>     indicating if EM holds real power values in milli-Watts (suggested by
>>>>     Daniel and aggreed with Quentin)
>>>> - updated documentation regarding this new flag
>>>> - dropped DT binding change for 'sustainable-power'
>>>> - added more maintainers on CC (due to patch 1/4 touching different things)
>>>> v2 [2]:
>>>> - updated sustainable power section in IPA documentation
>>>> - updated DT binding for the 'sustainable-power'
>>>> v1 [1]:
>>>> - simple documenation update with new 'abstract scale' in EAS, EM, IPA
>>>>
>>>> Regards,
>>>> Lukasz Luba
>>>>
>>>> [1] https://lore.kernel.org/linux-doc/20200929121610.16060-1-lukasz.luba@arm.com/
>>>> [2] https://lore.kernel.org/lkml/20201002114426.31277-1-lukasz.luba@arm.com/
>>>>
>>>> Lukasz Luba (4):
>>>>     PM / EM: Add a flag indicating units of power values in Energy Model
>>>>     docs: Clarify abstract scale usage for power values in Energy Model
>>>>     PM / EM: update the comments related to power scale
>>>>     docs: power: Update Energy Model with new flag indicating power scale
>>>>
>>>>    .../driver-api/thermal/power_allocator.rst    | 13 +++++++-
>>>>    Documentation/power/energy-model.rst          | 30 +++++++++++++++----
>>>>    Documentation/scheduler/sched-energy.rst      |  5 ++++
>>>>    drivers/cpufreq/scmi-cpufreq.c                |  3 +-
>>>>    drivers/opp/of.c                              |  2 +-
>>>>    include/linux/energy_model.h                  | 20 ++++++++-----
>>>>    kernel/power/energy_model.c                   | 26 ++++++++++++++--
>>>>    7 files changed, 81 insertions(+), 18 deletions(-)
>>>
>>> While I don't feel like I have enough skin in the game to make any
>>> demands, I'm definitely not a huge fan of this series still.  I am a
>>> fan of documenting reality, but (to me) trying to mix stuff like this
>>> is just going to be adding needless complexity.  From where I'm
>>> standing, it's a lot more of a pain to specify these types of numbers
>>> in the firmware than it is to specify them in the device tree.  They
>>
>> When you have SCMI, you receive power values from FW directly, not using
>> DT.
>>
>>> are harder to customize per board, harder to spin, and harder to
>>> specify constraints for everything in the system (all heat generators,
>>> all cooling devices, etc).  ...and since we already have a way to
>>> specify this type of thing in the device tree and that's super easy
>>> for people to do, we're going to end up with weird mixes / matches of
>>> numbers coming from different locations and now we've got to figure
>>> out which numbers we can use when and which to ignore.  Ick.
>>
>> This is not that bad as you described. When you have SCMI and FW
>> all your perf domains should be aligned to the same scale.
>> In example, you have 4 little CPU, 3 big CPUs, 1 super big CPU,
>> 1 GPU, 1 DSP. For all of them the SCMI get_power callback should return
>> consistent values. You don't have to specify anything else or rev-eng.
>> Then a client like EAS would use those values from CPUs to estimate
>> energy and this works fine. Another client: IPA, which would use
>> all of them and also works fine.
> 
> I guess I'm confused.  When using SCMI and FW, are there already code
> paths to get the board-specific "sustainable-power" from SCMI and FW?
> 
> I know that "sustainable-power" is not truly necessary.  IIRC some of
> the code assumes that the lowest power state of all components must be
> sustainable and uses that.  However, though this makes the code work,
> it's far from ideal.  I don't want to accept a mediocre solution here.

As you said, sustainable power would be estimated when it is not coming
from DT. Currently it would be done based on lowest allowed OPPs. I am
trying to address this by marking OPP as sustainable [1]. The estimation 
would be more accurate (and also the derived coefficients).

> 
> In any case, I'm saying that even if "sustainable-power" can come from
> firmware, it's not as ideal of a place for it to live.  Maybe my
> experience on Chromebooks is different from the rest of upstream, but
> it's generally quite easy to adjust the device tree for a board and
> much harder to convince firmware folks to put a board-specific table
> of values.

The sysfs (which is there) is even easier for this adjustment than DT.

> 
> 
>>> In my opinion the only way to allow for mixing and matching the
>>> bogoWatts and real Watts would be to actually have units and the
>>> ability to provide a conversion factor somewhere.  Presumably that
>>> might give you a chance of mixing and matching if someone wants to
>>> provide some stuff in device tree and get other stuff from the
>>> firmware.  Heck, I guess you could even magically figure out a
>>> conversion factor if someone provides device tree numbers for
>>> something that was already registered in SCMI, assuming all the SCMI
>>> numbers are consistent with each other...
>>
>> What you demand here is another code path, just to support revers
>> engineered power values for SCMI devices, which are stored in DT.
>> Then the SCMI protocol code and drivers should take them into account
>> and abandon standard implementation and use these values to provide
>> 'hacked' power numbers to EM. Am I right?
>> It is not going to happen.
> 
> Quite honestly, all I want to be able to do is to provide a
> board-specific "sustainable-power" and have it match with the
> power-coefficients.  Thus:
> 
> * If device tree accepted abstract scale, we'd be done and I'd shut
> up.  ...but Rob has made it quite clear that this is a no-go.
> 
> * If it was super easy to add all these values into firmware for a
> board and we could totally remove these from the device tree, I'd
> grumble a bit about firmware being a terrible place for this but at
> least we'd have a solution and we'd be done and I'd shut up.  NOTE: I
> don't know ATF terribly well, but I'd guess that this needs to go
> there?  Presumably part of this is convincing firmware folks to add
> this board-specific value there...

The SCMI spec that we are talking supports 'sustained performance'
level for each performance domain. You can check doc [2] table 11
for the definition. In SCMI there is no concept of 'sustainable-power'
which would substitute the missing DT value. But we can estimate it
more accurately based on sustainable OPP.
You can check how I am going to feed that FW value into the OPP in patch
4/4 of [3]. I am also working on improved estimation patch set v4 for
IPA (some description of an issue in v2 [4], latest v3 is here [5]),
which is using the proposed sustainable OPP concept (Viresh mentioned
he would like to see the user of that).

As you can see, I am not going to leave you with this issue ;)

Regards,
Lukasz


[1] 
https://lore.kernel.org/linux-pm/20201028140847.1018-1-lukasz.luba@arm.com/
[2] https://developer.arm.com/documentation/den0056/b
[3] 
https://lore.kernel.org/linux-pm/20201028140847.1018-5-lukasz.luba@arm.com/
[4] 
https://lore.kernel.org/linux-pm/5f682bbb-b250-49e6-dbb7-aea522a58595@arm.com/
[5] https://lore.kernel.org/lkml/20201009135850.14727-1-lukasz.luba@arm.com/

> 
> -Doug
> 
