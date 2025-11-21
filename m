Return-Path: <linux-pm+bounces-38384-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 12913C7AEBC
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 17:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A47CC4EDCF2
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 16:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9178B2EA168;
	Fri, 21 Nov 2025 16:43:04 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F411862;
	Fri, 21 Nov 2025 16:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763743384; cv=none; b=uJreNSaRMPpo/WzZjYW153FYKrALVXcH1AmaWJFAt6rZn9l/SJtBmYTEIVdxwQ7xSGyaaL1dNkPtvbLZA4rc4wbNqufXMAC0enyVfCWQByY6ewJQiCAf2qqq7mf4fe6kvAw+PbqyYJn2GYmsd0/vceQ9UcJE6llgYSCfd0ENwS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763743384; c=relaxed/simple;
	bh=8GEWfQcGXbMWz9/EnvRP5Z8D+uCCbXqNO5e9+JcJeuM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=irHtA3HUklpQNESNvg4LKpu1+ndL1L4PZyt1efNcBow88JskOjFGh0r7hk/8s25Bx3VLnx3EMkbFAOZ+ppE5AgZWHhTrXaTZTbPbF7vS0UVqou9kfu8mdDPq0q1ARQ2xCv2CuiKoix4R39vUjpE6O6Jo6VgnUtQz6oi+NM0WlGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19F1E339;
	Fri, 21 Nov 2025 08:42:54 -0800 (PST)
Received: from [10.57.73.129] (unknown [10.57.73.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 739DC3F73B;
	Fri, 21 Nov 2025 08:42:59 -0800 (PST)
Message-ID: <4345086e-d68b-47eb-adfa-939a7c6514ba@arm.com>
Date: Fri, 21 Nov 2025 16:42:57 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: stable 6.6: commit "sched/cpufreq: Rework schedutil governor
 performance estimation' causes a regression
From: Christian Loehle <christian.loehle@arm.com>
To: Yu-Che Cheng <giver@chromium.org>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lukasz Luba <lukasz.luba@arm.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <q2dp7jlblofwkmkufjdysgu2ggv6g4cvhkah3trr5wamxymngm@p2mn4r7vyo77>
 <86d759a5-9a96-49ff-9f75-8b56e2626d65@arm.com>
 <2ktr5znjidilpxm2ycixunqlmhu253xwov4tpnb2qablrsqmbv@ysacm5nbcjw7>
 <CAKfTPtBBtMysuYgBYZR2EH=WPR7X5F_RRzGmf94UhyDiGmmqCg@mail.gmail.com>
 <CAKchOA03GKXMUbfVvEXtyp3=-t0mWOzQVHNkB6F9QsMfTzCofA@mail.gmail.com>
 <6e50830f-a1b8-452a-86a7-1621cd3968ce@arm.com>
Content-Language: en-US
In-Reply-To: <6e50830f-a1b8-452a-86a7-1621cd3968ce@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/21/25 16:35, Christian Loehle wrote:
> On 11/21/25 15:37, Yu-Che Cheng wrote:
>> Hi Vincent,
>>
>> On Fri, Nov 21, 2025 at 10:00 PM Vincent Guittot <vincent.guittot@linaro.org>
>> wrote:
>>>
>>> On Fri, 21 Nov 2025 at 04:55, Sergey Senozhatsky
>>> <senozhatsky@chromium.org> wrote:
>>>>
>>>> Hi Christian,
>>>>
>>>> On (25/11/20 10:15), Christian Loehle wrote:
>>>>> On 11/20/25 04:45, Sergey Senozhatsky wrote:
>>>>>> Hi,
>>>>>>
>>>>>> We are observing a performance regression on one of our arm64
>> boards.
>>>>>> We tracked it down to the linux-6.6.y commit ada8d7fa0ad4
>> ("sched/cpufreq:
>>>
>>> You mentioned that you tracked down to linux-6.6.y but which kernel
>>> are you using ?
>>>
>>
>> We're using ChromeOS 6.6 kernel, which is currently on top of linux-v6.6.99.
>> But we've tested that the performance regression still happens on exactly
>> the same scheduler codes (`kernel/sched`) as upstream v6.6.99, compared to
>> those on v6.6.88.
>>
>>>>>> Rework schedutil governor performance estimation").
>>>>>>
>>>>>> UI speedometer benchmark:
>>>>>> w/commit:   395  +/-38
>>>>>> w/o commit: 439  +/-14
>>>>>>
>>>>>
>>>>> Hi Sergey,
>>>>> Would be nice to get some details. What board?
>>>>
>>>> It's an MT8196 chromebook.
>>>>
>>>>> What do the OPPs look like?
>>>>
>>>> How do I find that out?
>>>
>>> In /sys/kernel/debug/opp/cpu*/
>>> or
>>> /sys/devices/system/cpu/cpufreq/policy*/scaling_available_frequencies
>>> with related_cpus
>>>
>>
>> The energy model on the device is:
>>
>> CPU0-3:
>> +------------+------------+
>> | freq (khz) | power (uw) |
>> +============+============+
>> |     339000 |      34362 |
>> |     400000 |      42099 |
>> |     500000 |      52907 |
>> |     600000 |      63795 |
>> |     700000 |      74747 |
>> |     800000 |      88445 |
>> |     900000 |     101444 |
>> |    1000000 |     120377 |
>> |    1100000 |     136859 |
>> |    1200000 |     154162 |
>> |    1300000 |     174843 |
>> |    1400000 |     196833 |
>> |    1500000 |     217052 |
>> |    1600000 |     247844 |
>> |    1700000 |     281464 |
>> |    1800000 |     321764 |
>> |    1900000 |     352114 |
>> |    2000000 |     383791 |
>> |    2100000 |     421809 |
>> |    2200000 |     461767 |
>> |    2300000 |     503648 |
>> |    2400000 |     540731 |
>> +------------+------------+
>>
>> CPU4-6:
>> +------------+------------+
>> | freq (khz) | power (uw) |
>> +============+============+
>> |     622000 |     131738 |
>> |     700000 |     147102 |
>> |     800000 |     172219 |
>> |     900000 |     205455 |
>> |    1000000 |     233632 |
>> |    1100000 |     254313 |
>> |    1200000 |     288843 |
>> |    1300000 |     330863 |
>> |    1400000 |     358947 |
>> |    1500000 |     400589 |
>> |    1600000 |     444247 |
>> |    1700000 |     497941 |
>> |    1800000 |     539959 |
>> |    1900000 |     584011 |
>> |    2000000 |     657172 |
>> |    2100000 |     746489 |
>> |    2200000 |     822854 |
>> |    2300000 |     904913 |
>> |    2400000 |    1006581 |
>> |    2500000 |    1115458 |
>> |    2600000 |    1205167 |
>> |    2700000 |    1330751 |
>> |    2800000 |    1450661 |
>> |    2900000 |    1596740 |
>> |    3000000 |    1736568 |
>> |    3100000 |    1887001 |
>> |    3200000 |    2048877 |
>> |    3300000 |    2201141 |
>> +------------+------------+
>>
>> CPU7:
>>
>> +------------+------------+
>> | freq (khz) | power (uw) |
>> +============+============+
>> |     798000 |     320028 |
>> |     900000 |     330714 |
>> |    1000000 |     358108 |
>> |    1100000 |     384730 |
>> |    1200000 |     410669 |
>> |    1300000 |     438355 |
>> |    1400000 |     469865 |
>> |    1500000 |     502740 |
>> |    1600000 |     531645 |
>> |    1700000 |     560380 |
>> |    1800000 |     588902 |
>> |    1900000 |     617278 |
>> |    2000000 |     645584 |
>> |    2100000 |     698653 |
>> |    2200000 |     744179 |
>> |    2300000 |     810471 |
>> |    2400000 |     895816 |
>> |    2500000 |     985234 |
>> |    2600000 |    1097802 |
>> |    2700000 |    1201162 |
>> |    2800000 |    1332076 |
>> |    2900000 |    1439847 |
>> |    3000000 |    1575917 |
>> |    3100000 |    1741987 |
>> |    3200000 |    1877346 |
>> |    3300000 |    2161512 |
>> |    3400000 |    2437879 |
>> |    3500000 |    2933742 |
>> |    3600000 |    3322959 |
>> |    3626000 |    3486345 |
>> +------------+------------+
>>
>>>>
>>>>> Does this system use uclamp during the benchmark? How?
>>>>
>>>> How do I find that out?
>>>
>>> it can be set per cgroup
>>> /sys/fs/cgroup/system.slice/<name>/cpu.uclam.min|max
>>> or per task with sched_setattr()
>>>
>>> You most probably use it because it's the main reason for ada8d7fa0ad4
>>> to remove wrong overestimate of OPP
>>>
>>
>> For the speedometer case, yes, we set the uclamp.min to 20 for the whole
>> browser and UI (chrome).
>> There's no system-wide uclamp settings though.
> 
> (From Sergey's traces)
> Per-cluster time‑weighted average frequency base => revert:
> little (cpu0–3, max 2.4 GHz): 0.746 GHz => 1.132 GHz (+51.6%)
> mid (cpu4–6, max 3.3 GHz): 1.043 GHz => 1.303 GHz (+24.9%)
> big (cpu7, max 3.626 GHz): 2.563 GHz => 3.116 GHz (+21.6%)
> 
> And in particular time spent at OPPs (base => revert):
> Big core at upper 10%: 29.6% => 61.5%
> little cluster at 339 MHz: 50.1% => 1.0% 

Sorry, should be 1.0% => 50.1% 

> 
> Interesting that a uclamp.min of 20 (which shouldn't really have
> much affect on big CPU at all, with or without headroom AFAICS?)
> makes such a big difference here?

Can we get a sched_switch / sched_migrate / sched_wakeup trace for this?
Perfetto would also do if that is better for you.

> 
>>
>> But we also found other performance regressions in an Android guest VM,
>> where there's no uclamp for the VM and vCPU processes from the host side.
>> Particularly, the RAR extraction throughput reduces about 20% in the RAR
>> app (from RARLAB).
>> Although it's hard to tell if this is some sort of a side-effect of the UI
>> regression as the UI is also running at the same time.
>>
> I'd be inclined to say that is because of the vastly different DVFS from the
> UI workload, yes.
> 


