Return-Path: <linux-pm+bounces-36087-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCA9BDAC1C
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 19:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEF9D18A2A73
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 17:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1985304BC3;
	Tue, 14 Oct 2025 17:19:59 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06B02FC86C;
	Tue, 14 Oct 2025 17:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760462399; cv=none; b=gj5Jy47rjKZPGEkxVX70g1L4HPKVm5VowlVxbVdvoA11ZhQzwjMZou6Mczp7+vsKYnLWsElHxbj3xYvRnjKKjT7irnC2GzZDLe0lqNjTXX2GN/V6GmNGhKSIapHo/nwW2UmKmS4H6WEhpWeyzzS9P5/FARHBZ3adRlS7wgtR/co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760462399; c=relaxed/simple;
	bh=+Rok64GjH6bMzjCNLJns+E/72zeS8NKwoze0SUab/P0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WpmDhUWNdQhJ5OUgkAwVpOi8Xhja11OkDd98UfTvjco/4amlj0sD46xiSSBJslHZX38MYr2q8JXcdvpOvR/EJNYKDs3KSPhOsflWtiDFOdB4KMD1SQH6B0928X9xktEQmmdgG4ri+4s6ul04+amTU5DEdq2XZnAP++HlLY4oJ5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D193B1A9A;
	Tue, 14 Oct 2025 10:19:47 -0700 (PDT)
Received: from [10.1.36.66] (unknown [10.1.36.66])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 847AB3F66E;
	Tue, 14 Oct 2025 10:19:53 -0700 (PDT)
Message-ID: <e9eb077b-3253-49be-b997-a07dcde86cdc@arm.com>
Date: Tue, 14 Oct 2025 18:19:51 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Sasha Levin <sashal@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org
References: <36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7>
 <08529809-5ca1-4495-8160-15d8e85ad640@arm.com>
 <2zreguw4djctgcmvgticnm4dctcuja7yfnp3r6bxaqon3i2pxf@thee3p3qduoq>
 <8da42386-282e-4f97-af93-4715ae206361@arm.com>
 <nd64xabhbb53bbqoxsjkfvkmlpn5tkdlu3nb5ofwdhyauko35b@qv6in7biupgi>
 <49cf14a1-b96f-4413-a17e-599bc1c104cd@arm.com>
 <CAJZ5v0hGu-JdwR57cwKfB+a98Pv7e3y36X6xCo=PyGdD2hwkhQ@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJZ5v0hGu-JdwR57cwKfB+a98Pv7e3y36X6xCo=PyGdD2hwkhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/14/25 16:54, Rafael J. Wysocki wrote:
> On Tue, Oct 14, 2025 at 5:11 PM Christian Loehle
> <christian.loehle@arm.com> wrote:
>>
>> On 10/14/25 12:55, Sergey Senozhatsky wrote:
>>> On (25/10/14 11:25), Christian Loehle wrote:
>>>> On 10/14/25 11:23, Sergey Senozhatsky wrote:
>>>>> On (25/10/14 10:50), Christian Loehle wrote:
>>>>>>> Upstream fixup fa3fa55de0d ("cpuidle: governors: menu: Avoid using
>>>>>>> invalid recent intervals data") doesn't address the problems we are
>>>>>>> observing.  Revert seems to be bringing performance metrics back to
>>>>>>> pre-regression levels.
>>>>>>
>>>>>> Any details would be much appreciated.
>>>>>> How do the idle state usages differ with and without
>>>>>> "cpuidle: menu: Avoid discarding useful information"?
>>>>>> What do the idle states look like in your platform?
>>>>>
>>>>> Sure, I can run tests.  How do I get the numbers/stats
>>>>> that you are asking for?
>>>>
>>>> Ideally just dump
>>>> cat /sys/devices/system/cpu/cpu*/cpuidle/state*/*
>>>> before and after the test.
>>>
>>> OK, got some data for you.  The terminology being used here is as follows:
>>>
>>> - 6.1-base
>>>   is 6.1 stable with a9edb700846 "cpuidle: menu: Avoid discarding useful information"
>>>
>>> - 6.1-base-fixup
>>>   is 6.1 stable with a9edb700846 and fa3fa55de0d6 "cpuidle: governors:
>>>   menu: Avoid using invalid recent intervals data" cherry-pick
>>>
>>> - 6.1-revert
>>>   is 6.1 stable with a9edb700846 reverted (and no fixup commit, obviously)
>>>
>>> Just to show the scale of regression, results of some of the benchmarks:
>>>
>>>   6.1-base:           84.5
>>>   6.1-base-fixup:     76.5
>>>   6.1-revert:         59.5
>>>
>>>   (lower is better, 6.1-revert has the same results as previous stable
>>>   kernels).
>> This immediately threw me off.
>> The fixup was written for a specific system which had completely broken
>> cpuidle. It shouldn't affect any sane system significantly.
>> I double checked the numbers and your system looks fine, in fact none of
>> the tests had any rejected cpuidle occurrences. So functionally base and
>> base-fixup are identical for you. The cpuidle numbers are also reasonably
>> 'in the noise', so just for the future some stats would be helpful on those
>> scores.
>>
>> I can see a huge difference between base and revert in terms of cpuidle,
>> so that's enough for me to take a look, I'll do that now.
>> (6.1-revert has more C3_ACPI in favor of C1_ACPI.)
>>
>> (Also I can't send this email without at least recommending teo instead of menu
>> for your platform / use-cases, if you deemed it unfit I'd love to know what
>> didn't work for you!)
> 
> Well, yeah.
> 
> So I've already done some analysis.
> 
> There are 4 C-states, POLL, C1, C6 and C10 (at least that's what the
> MWAIT hints tell me).
> 
> This is how many times each of them was requested during the workload
> run on base 6.1.y:
> 
> POLL: 21445
> C1: 2993722
> C6: 767029
> C10: 736854
> 
> and in percentage of the total idle state requests:
> 
> POLL: 0,47%
> C1: 66,25%
> C6: 16,97%
> C10: 16,31%
> 
> With the problematic commit reverted, this became
> 
> POLL: 16092
> C1: 2452591
> C6: 750933
> C10: 1150259
> 
> and (again) in percentage of the total:
> 
> POLL: 0,37%
> C1: 56,12%
> C6: 17,18%
> C10: 26,32%
> 
> Overall, POLL is negligible and the revet had no effect on the number
> of times C6 was requested.  The difference is for C1 and C10 and it's
> 10% in both cases, but going in opposite directions so to speak: C1
> was requested 10% less and C10 was requested 10% more after the
> revert.
> 
> Let's see how this corresponds to the residency numbers.
> 
> For base 6.1.y there was
> 
> POLL: 599883
> C1: 732303748
> C6: 576785253
> C10: 2020491489
> 
> and in percentage of the total
> 
> POLL: 0,02%
> C1: 21,99%
> C6: 17,32%
> C10: 60,67%
> 
> After the revert it became
> 
> POLL: 469451
> C1: 517623465
> C6: 508945687
> C10: 2567701673
> 
> and in percentage of the total
> 
> POLL: 0,01%
> C1: 14,40%
> C6: 14,16%
> C10: 71,43%
> 
> so with the revert the CPUs spend around 7% more time in deep idle
> states (C6 and C10 combined).
> 
> I have to say that this is consistent with the intent of the
> problematic commit, which is to reduce the number of times the deepest
> idle state is requested although it is likely to be too deep.
> 
> However, on the system in question this somehow causes performance to
> drop significantly (even though shallow idle states are used more
> often which should result in lower average idle state exit latency and
> better performance).
> 
> One possible explanation is that this somehow affects turbo
> frequencies.  That is, requesting shallower idle states on idle CPUs
> prevents the other CPUs from getting sufficiently high turbo.
> 
> Sergey, can you please run the workload under turbostat on the base
> 6.1.y and on 6.1.y with the problematic commit reverted and send the
> turbostat output from both runs (note: turbostat needs to be run as
> root)?

That's the most plausible explanation and would also be my guess.
FWIW most of the C3_ACPI (== C10) with revert are objectively wrong
with 78% idle misses (they were already pretty high with base around 72.5%).

I'll leave this here for easier following:

===== 6.1-base: after minus before deltas (aggregated across CPUs) =====
+---------+-------------+------------+--------------+---------------+------------+------------+---------+
|   state | time_diff_s | usage_diff | avg_resid_us | rejected_diff | above_diff | below_diff | share_% |
+---------+-------------+------------+--------------+---------------+------------+------------+---------+
|    POLL |       0.600 |     21,445 |         28.0 |             0 |          0 |     19,846 |    0.02 |
| C1_ACPI |     732.304 |  2,993,722 |        244.6 |             0 |      3,816 |    280,613 |   21.99 |
| C2_ACPI |     576.785 |    767,029 |        752.0 |             0 |    272,105 |        453 |   17.32 |
| C3_ACPI |   2,020.491 |    736,854 |      2,742.1 |             0 |    534,424 |          0 |   60.67 |
|   TOTAL |   3,330.180 |  4,519,050 |              |             0 |    810,345 |    300,912 |  100.00 |
+---------+-------------+------------+--------------+---------------+------------+------------+---------+

===== 6.1-revert: after minus before deltas (aggregated across CPUs) =====
+---------+-------------+------------+--------------+---------------+------------+------------+---------+
|   state | time_diff_s | usage_diff | avg_resid_us | rejected_diff | above_diff | below_diff | share_% |
+---------+-------------+------------+--------------+---------------+------------+------------+---------+
|    POLL |       0.469 |     16,092 |         29.2 |             0 |          0 |     14,855 |    0.01 |
| C1_ACPI |     517.623 |  2,452,591 |        211.1 |             0 |      4,109 |    150,500 |   14.40 |
| C2_ACPI |     508.946 |    750,933 |        677.8 |             0 |    327,457 |        427 |   14.16 |
| C3_ACPI |   2,567.702 |  1,150,259 |      2,232.3 |             0 |    895,311 |          0 |   71.43 |
|   TOTAL |   3,594.740 |  4,369,875 |              |             0 |  1,226,877 |    165,782 |  100.00 |
+---------+-------------+------------+--------------+---------------+------------+------------+---------+

===== 6.1-revert minus 6.1-base (state-by-state deltas of the deltas) =====
+---------+-----------+----------+----------+---------------+----------+----------+
|   state | Δshare_pp |   Δusage |  Δtime_s | Δavg_resid_us |   Δabove |   Δbelow |
+---------+-----------+----------+----------+---------------+----------+----------+
|    POLL |     -0.00 |   -5,353 |   -0.130 |           1.2 |       +0 |   -4,991 |
| C1_ACPI |     -7.59 | -541,131 | -214.680 |         -33.6 |     +293 | -130,113 |
| C2_ACPI |     -3.16 |  -16,096 |  -67.840 |         -74.2 |  +55,352 |      -26 |
| C3_ACPI |    +10.76 | +413,405 |  547.210 |        -509.8 | +360,887 |       +0 |
|   TOTAL |     +0.00 | -149,175 |  264.560 |               | +416,532 | -135,130 |
+---------+-----------+----------+----------+---------------+----------+----------+

