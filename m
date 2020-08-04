Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E14123B8C0
	for <lists+linux-pm@lfdr.de>; Tue,  4 Aug 2020 12:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgHDK37 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Aug 2020 06:29:59 -0400
Received: from foss.arm.com ([217.140.110.172]:42282 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbgHDK37 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 4 Aug 2020 06:29:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3DEF1FB;
        Tue,  4 Aug 2020 03:29:58 -0700 (PDT)
Received: from [10.37.12.45] (unknown [10.37.12.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 123F83F718;
        Tue,  4 Aug 2020 03:29:56 -0700 (PDT)
Subject: Re: [PATCH 0/4] CPUFreq statistics retrieved by drivers
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        cristian.marussi@arm.com, rjw@rjwysocki.net
References: <20200729151208.27737-1-lukasz.luba@arm.com>
 <20200730085333.qubrsv7ufqninihd@vireshk-mac-ubuntu>
 <20200730091014.GA13158@bogus> <3b3a56e9-29ec-958f-fb3b-c689a9389d2f@arm.com>
 <20200804053502.35d3x3vnb3mggtqs@vireshk-mac-ubuntu>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <f784bf30-83a6-55ff-8fa6-f7bd2d4399b9@arm.com>
Date:   Tue, 4 Aug 2020 11:29:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200804053502.35d3x3vnb3mggtqs@vireshk-mac-ubuntu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 8/4/20 6:35 AM, Viresh Kumar wrote:
> On 30-07-20, 10:36, Lukasz Luba wrote:
>> On 7/30/20 10:10 AM, Sudeep Holla wrote:
>>> On Thu, Jul 30, 2020 at 02:23:33PM +0530, Viresh Kumar wrote:
>>>> On 29-07-20, 16:12, Lukasz Luba wrote:
>>>>> The existing CPUFreq framework does not tracks the statistics when the
>>>>> 'fast switch' is used or when firmware changes the frequency independently
>>>>> due to e.g. thermal reasons. However, the firmware might track the frequency
>>>>> changes and expose this to the kernel.
>>>>>
>>>>> This patch set aims to introduce CPUfreq statistics gathered by firmware
>>>>> and retrieved by CPUFreq driver. It would require a new API functions
>>>>> in the CPUFreq, which allows to poke drivers to get these stats.
>>>>>
>>>>> The needed CPUFreq infrastructure is in patch 1/4, patch 2/4 extends
>>>>> ARM SCMI protocol layer, patches 3/4, 4/4  modify ARM SCMI CPUFreq driver.
>>>>
>>>> Are you doing this for the fast switch case or because your platform
>>>> actually runs at frequencies which may be different from what cpufreq
>>>> core has requested ?
>>>>
>>>
>>> I think so.
>>
>> For both cases, but fast switch is major and present. Thermal is not
>> currently implemented in SCP FW, but might be in future.
> 
> Okay, lets simplify things a bit and merge things slowly upstream and merge only
> what is required right now.
> 
> IIUC, the only concern right now is to capture stats with fast switch ? Maybe we
> can do something else in that case and brainstorm a bit..

Correct, the fast switch is the only concern right now and not tracked. 
We could fill in that information with statistics data from firmware
with a cpufreq driver help.

I could make the if from patch 1/4 covering narrowed case, when
fast switch is present, check for drivers stats.
Something like:
-----------8<------------------------------------------------------------
if (policy->fast_switch_enabled)
	if (policy->has_driver_stats)
		return cpufreq_stats_present_driver_data(policy, buf);
	else
		return 0;
-------------->8----------------------------------------------------------

> 
>>>> I am also not sure what these tables should represent, what the
>>>> cpufreq core has decided for the CPUs or the frequencies we actually
>>>> run at, as these two can be very different for example if the hardware
>>>> runs at frequencies which don't match exactly to what is there in the
>>>> freq table. I believe these are rather to show what cpufreq and its
>>>> governors are doing with the CPUs.
>>>>
>>>
>>> Exactly, I raised similar point in internal discussion and asked Lukasz
>>> to take up the same on the list. I assume it was always what cpufreq
>>> requested rather than what was delivered. So will we break the userspace
>>> ABI if we change that is the main question.
>>
>> Thank you for confirmation. If that is the mechanism for tracking what
>> cpufreq governors are doing with the CPUs, then is clashes with
>> presented data in FW memory, because firmware is the governor.
> 
> Why is firmware the governor here ? Aren't you talking about the simple fast
> switch case only ?

I used a term 'governor' for the firmware because it makes the final
set for the frequency. It (FW) should respect the frequency value
set using the fast switch. I don't know how other firmware (e.g. Intel)
treats this fast switch value or if they even expose FW stats, though.

You can read about this statistics region in [1] at:
4.5.5 Performance domain statistics shared memory region

> 
> Over that, I think this cpufreq stats information isn't parsed by any tool right
> now and tweaking it a bit won't hurt anyone (like if we start capturing things a
> bit differently). So we may not want to worry about breaking userspace ABI here,
> if what we are looking to do is the right thing to do.

So, there is some hope... IMHO it would be better to have this cpufreq
stats in normal location, rather then in scmi debugfs.

> 
>>>> Over that I would like the userspace stats to work exactly as the way
>>>> they work right now, i.e. capture all transitions from one freq to
>>>> other, not just time-in-state. Also resetting of the stats from
>>>> userspace for example. All allocation and printing of the data must be
>>>> done from stats core, the only thing which the driver would do at the
>>>> end is updating the stats structure and nothing more. Instead of
>>>> reading all stats from the firmware, it will be much easier if you can
>>>> just get the information from the firmware whenever there is a
>>>> frequency switch and then we can update the stats the way it is done
>>>> right now. And that would be simple.
>>>>
>>>
>>> Good point, but notifications may not be lightweight. If that is no good,
>>> alternatively, I suggested to keep these firmware stats in a separate
>>> debugfs. Thoughts ?
>>
>> I agree that notifications might not be lightweight.
> 
> I am not sure what notifications are we talking about here.

There is a notification mechanism described in the SCMI spec [1] at
4.5.4 Notifications.
We were referring to that mechanism.

> 
>> Furthermore I think
>> this still clashes with the assumption that cpufreq governor decisions
>> are tracked in these statistics, not the firmware decision.
>>
>> In this case I think we would have to create debugfs.
>> Sudeep do you think these debugfs should be exposed from the protocol
>> layer:
>> drivers/firmware/arm_scmi/perf.c
>> or maybe from the cpufreq scmi driver? I would probably be safer to have
>> it in the cpufreq driver because we have scmi_handle there.
> 
> For the CPUs it would be better if we can keep things in cpufreq only, lets see
> how we go about it.
> 

If that would be only ARM SCMI debugfs directory, then we would like to
keep it in the scmi. We could re-use the code for devfreq (GPU)
device, which is also exposed as performance domain.

Thank you Viresh for your comments.

Regards,
Lukasz

[1] 
https://static.docs.arm.com/den0056/b/DEN0056B_System_Control_and_Management_Interface_v2_0.pdf
