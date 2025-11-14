Return-Path: <linux-pm+bounces-38041-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A7861C5DC84
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 16:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7E004F92DD
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 14:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A88132572C;
	Fri, 14 Nov 2025 14:47:32 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6100A324B1A
	for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2025 14:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763131652; cv=none; b=KxNbz83IaPInQUvn3UErlUmV/HliFRXhFH7FmN2k3GOaKFyRB+8fvH/q5eXZPYSao+i+F6u8Is4c1h5/5LkLoFwcJh66t0Td7APoDJEd/87D8GsQplP70HFfFQDDY59hR4/5K5fGaDp7jA84d5nut7X1nv2ZamcDjd4CDgxx+j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763131652; c=relaxed/simple;
	bh=uxxkaP3xyJhPewhp2M2gtNPKoipqqNY/A9MBrjcC1K8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bvmxhy8PO3tQc7eYr4EAiKznfJpo1KbUGssXUclCTZKXf97j64zeethriAjXwcRYM5xE9/dGtO+uo5rOsxjZB2G1l2xzLzl/6ZtdVKyRGtQOtZIg2xAANb1UFbq3cpnwRXh+foOwTszg671QgnGoDag3Wbnu6nkKGWAP5UKoSM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 242951063;
	Fri, 14 Nov 2025 06:47:22 -0800 (PST)
Received: from [10.1.35.10] (e127648.arm.com [10.1.35.10])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D3253F5A1;
	Fri, 14 Nov 2025 06:47:28 -0800 (PST)
Message-ID: <fcf1584a-7e15-4aec-b302-b94cfa168e11@arm.com>
Date: Fri, 14 Nov 2025 14:47:26 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cpuidle: governors: teo: Rework the handling of tick
 wakeups
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Reka Norman <rekanorman@chromium.org>
Cc: daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
References: <CAEmPcwsNMNnNXuxgvHTQ93Mx-q3Oz9U57THQsU_qdcCx1m4w5g@mail.gmail.com>
 <00928b9d-7189-4929-afc9-7684fc5ef531@arm.com>
 <ca45366d-4c85-4802-8a35-886a6f69d10d@arm.com>
 <6228387.lOV4Wx5bFT@rafael.j.wysocki>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <6228387.lOV4Wx5bFT@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/13/25 16:56, Rafael J. Wysocki wrote:
> On Thursday, November 13, 2025 4:43:18 PM CET Christian Loehle wrote:
>> On 11/12/25 18:33, Christian Loehle wrote:
>>> On 11/12/25 14:16, Rafael J. Wysocki wrote:
>>>> On Wed, Nov 12, 2025 at 3:03 PM Christian Loehle
>>>> <christian.loehle@arm.com> wrote:
>>>>>
>>>>> On 11/12/25 13:32, Rafael J. Wysocki wrote:
>>>>>> On Tue, Nov 11, 2025 at 6:20 PM Christian Loehle
>>>>>> <christian.loehle@arm.com> wrote:
>>>>>>>
>>>>>>> On 11/11/25 11:48, Rafael J. Wysocki wrote:
>>>>>>>> On Tue, Nov 11, 2025 at 11:48 AM Christian Loehle
>>>>>>>> <christian.loehle@arm.com> wrote:
>>>>>>>>>
>>>>>>>>> On 11/11/25 10:00, Christian Loehle wrote:
>>>>>>
>>>>>> [...]
>>>>>>
>>>>>>>>>> I see two issues:
>>>>>>>>>> 1) Because of DECAY_SHIFT 3 values < 8 cannot decay (I guess this wouldn't really be an issue without 2))
>>>>>>>>
>>>>>>>> This shouldn't be a problem.
>>>>>>>
>>>>>>> Agreed, it should be a non-issue. Nonetheless if this wasn't the case $subject would've likely
>>>>>>> never been an issue.
>>>>>>
>>>>>> Well, I think that the leftovers can be cleared when they become less than 8.
>>>>>>
>>>>>>>>
>>>>>>>>>> 2) if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) isn't an appropriate check, it will
>>>>>>>>>> exclude the state if it its idx_hit_sum make up the vast majority of cpu_data->total (i.e. it would
>>>>>>>>>> have been a really good candidate actually).
>>>>>>>>
>>>>>>>> Well, it would exclude the state if the sum of hits for the states
>>>>>>>> below it is large enough.  This is questionable (because why would
>>>>>>>> hits matter here), but I attempted to make the change below and
>>>>>>>> somebody reported a regression IIRC.
>>>>>>>>
>>>>>>>> This check is related to the problem at hand though (see below).
>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> I lightly tested the below, it seems to be at least comparable to mainline teo.
>>>>>>>>>> (the documentation/comments would need adapting too, of course)
>>>>>>>>>>
>>>>>>>>>> -----8<-----
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
>>>>>>>>>> index bfa55c1eab5b..f8f76e3b8364 100644
>>>>>>>>>> --- a/drivers/cpuidle/governors/teo.c
>>>>>>>>>> +++ b/drivers/cpuidle/governors/teo.c
>>>>>>>>>> @@ -355,7 +355,7 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>>>>>>>>>>          * all of the deeper states, a shallower idle state is likely to be a
>>>>>>>>>>          * better choice.
>>>>>>>>>>          */
>>>>>>>>>> -       if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) {
>>>>>>>>>> +       if (2 * idx_intercept_sum > idx_hit_sum) {
>>>>>>>>>>                 int first_suitable_idx = idx;
>>>>>>>>>>
>>>>>>>>>>                 /*
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> ... nevermind the patch, idx_hit_sum is of course the sum of 0...idx-1.
>>>>>>>>> Maybe something like this, again lightly tested:
>>>>>>>>>
>>>>>>>>> -----8<-----
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
>>>>>>>>> index 173ddcac540a..6bfb9cedb75e 100644
>>>>>>>>> --- a/drivers/cpuidle/governors/teo.c
>>>>>>>>> +++ b/drivers/cpuidle/governors/teo.c
>>>>>>>>> @@ -383,13 +395,15 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>>>>>>>>>                  * has been stopped already into account.
>>>>>>>>>                  */
>>>>>>>>>                 intercept_sum = 0;
>>>>>>>>> +               hit_sum = 0;
>>>>>>>>>
>>>>>>>>>                 for (i = idx - 1; i >= 0; i--) {
>>>>>>>>>                         struct teo_bin *bin = &cpu_data->state_bins[i];
>>>>>>>>>
>>>>>>>>>                         intercept_sum += bin->intercepts;
>>>>>>>>> +                       hit_sum += bin->hits;
>>>>>>>>>
>>>>>>>>> -                       if (2 * intercept_sum > idx_intercept_sum) {
>>>>>>>>> +                       if (2 * intercept_sum > cpu_data->total || 2 * hit_sum > cpu_data->total) {
>>>>>>>>>                                 /*
>>>>>>>>>                                  * Use the current state unless it is too
>>>>>>>>>                                  * shallow or disabled, in which case take the
>>>>>>>>
>>>>>>>> This will only matter after the deepest state has been rejected
>>>>>>>> already and on the system in question this means selecting state 0 no
>>>>>>>> matter what.
>>>>>>>>
>>>>>>>
>>>>>>> Ah, right!
>>>>>>>
>>>>>>>
>>>>>>>> The pre-6.12 behavior can be explained if tick wakeups are taken into account.
>>>>>>>>
>>>>>>>> Namely, when state 0 is chosen (because of the check mentioned above),
>>>>>>>> the tick is not stopped and the sleep length is KTIME_MAX.  If the
>>>>>>>> subsequent wakeup is a tick one, it will be counted as a hit on the
>>>>>>>> deepest state (and it will contribute to the total sum in the check
>>>>>>>> mentioned above).  Then, at one point, cpu_data->total will be large
>>>>>>>> enough and the deepest state will become the candidate one.  If
>>>>>>>> tick_nohz_get_sleep_length() returns a large value at that point, the
>>>>>>>> tick will be stopped and the deepest state will be entered.  Nirvana
>>>>>>>> ensues.
>>>>>>>
>>>>>>> So fundamentally we will have to count tick-wakeups as a) nothing, which
>>>>>>> doesn't allow us to ever break out of the intercept logic that caused us
>>>>>>> to leave the tick on b) intercepts, which is bonkers and doesn't allow us
>>>>>>> to ever break out and c) hits == sleep_length would've been accurate.
>>>>>>> Of course counting a tick wakeup as a hit for sleep_length negates the
>>>>>>> intercept logic.
>>>>>>
>>>>>> Not quite.  The intercept logic is there for wakeups other than tick
>>>>>> wakeups and timer wakeups.
>>>>>>
>>>>>> I actually think that tick wakeups can be counted as hits on the
>>>>>> deepest available state - maybe only when tick wakeups dominate the
>>>>>> wakeup pattern - but generally this is not unreasonable: When the
>>>>>> wakeup pattern is dominated by tick wakeups, this by itself is a good
>>>>>> enough reason to stop the tick.
>>>>>
>>>>> (assuming HZ=1000 below but it doesn't matter)
>>>>> That will exclude any 'intercept' logic from having much effect if the
>>>>> avg idle duration is >TICK_NSEC/2, which is potentially still quite a bit
>>>>> off from state1 residency, like in Reka's case here.
>>>>> That's why I thought it would cause unreasonable regressions here.
>>>>> I'll give it a go as well though!
>>>>
>>>> Thanks!
>>>>
>>>> Note that I'd prefer to add a check if tick wakeups dominate the
>>>> wakeup pattern before setting sleep_length_ns to KTIME_MAX though.
>>>> I'd first like to know how the Reka's system reacts to the more
>>>> drastic variant of this change.
>>>
>>> Below are my usual tests, it's definitely visible but the impact is limited
>>> on this platform anyway. I think if we gate the KTIME_MAX setting behind
>>> the "tick wakeup dominate" it should be acceptable!
>>> Let's see what Reka reports.
>>>
>> Forgot to post the full results, anyway as expected with mtdblock (a very slow
>> / low frequent wakeup scenario) the impact becomes clearly visible.
>> Still hopeful that the more conservative approach will be acceptable!
> 
> Speaking of which, the patch to test is appended below, but it doesn't apply
> directly on top of the mainline.  It is based on some other patches that have
> been posted recently, so here's a git branch with all of the requisite
> material:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git cpuidle-teo-testing
> 
> Reka, please try this one and let us know how it goes.
> 
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH v1] cpuidle: governors: teo: Rework the handling of tick wakeups
> 
> If the wakeup pattern is clearly dominated by tick wakeups, count those
> wakeups as hits on the deepest available idle state to increase the
> likelihood of stopping the tick, especially on systems where there are
> only 2 usable idle states and the tick can only be stopped when the
> deeper state is selected.

Maybe a sentence on the consequence that without this we may be ever-stuck in
the intercept logic.

> 
> This change is expected to reduce power on some systems where state 0 is
> selected relatively often even though they are almost idle.
> 

Should be a fixes tag, but I think it's a lot earlier than just
4b20b07ce72f ("cpuidle: teo: Don't count non-existent intercepts")

> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpuidle/governors/teo.c |   39 ++++++++++++++++++++++++---------------
>  1 file changed, 24 insertions(+), 15 deletions(-)
> 
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -133,17 +133,19 @@ struct teo_bin {
>   * @sleep_length_ns: Time till the closest timer event (at the selection time).
>   * @state_bins: Idle state data bins for this CPU.
>   * @total: Grand total of the "intercepts" and "hits" metrics for all bins.
> + * @total_tick: Wakeups by the scheduler tick.
>   * @tick_intercepts: "Intercepts" before TICK_NSEC.
>   * @short_idles: Wakeups after short idle periods.
> - * @artificial_wakeup: Set if the wakeup has been triggered by a safety net.
> + * @tick_wakeup: Set if the last wakeup was by the scheduler tick.
>   */
>  struct teo_cpu {
>  	s64 sleep_length_ns;
>  	struct teo_bin state_bins[CPUIDLE_STATE_MAX];
>  	unsigned int total;
> +	unsigned int total_tick;
>  	unsigned int tick_intercepts;
>  	unsigned int short_idles;
> -	bool artificial_wakeup;
> +	bool tick_wakeup;
>  };
>  
>  static DEFINE_PER_CPU(struct teo_cpu, teo_cpus);
> @@ -172,9 +174,10 @@ static void teo_update(struct cpuidle_dr
>  
>  	teo_decay(&cpu_data->short_idles);
>  
> -	if (cpu_data->artificial_wakeup) {
> +	if (dev->poll_time_limit) {
> +		dev->poll_time_limit = false;
>  		/*
> -		 * If one of the safety nets has triggered, assume that this
> +		 * Polling state timeout has triggered, so assume that this
>  		 * might have been a long sleep.
>  		 */
>  		measured_ns = S64_MAX;
> @@ -223,6 +226,21 @@ static void teo_update(struct cpuidle_dr
>  	cpu_data->total = total + PULSE;
>  
>  	teo_decay(&cpu_data->tick_intercepts);
> +
> +	teo_decay(&cpu_data->total_tick);
> +	if (cpu_data->tick_wakeup) {
> +		cpu_data->total_tick += PULSE;
> +		/*
> +		 * If tick wakeups dominate the wakeup pattern, count this one
> +		 * as a hit on the deepest available idle state to increase the
> +		 * likelihood of stopping the tick.
> +		 */
> +		if (3 * cpu_data->total_tick > 2 * cpu_data->total) {
> +			cpu_data->state_bins[drv->state_count-1].hits += PULSE;
> +			return;
> +		}
> +	}
> +

What if this state happens to be disabled?
If we're walking through the states anyway to find the deepest non-disabled one,
I think the first non-disabled above TICK_NSEC might be an even better choice?

>  	/*
>  	 * If the measured idle duration falls into the same bin as the sleep
>  	 * length, this is a "hit", so update the "hits" metric for that bin.
> @@ -512,18 +530,9 @@ static void teo_reflect(struct cpuidle_d
>  {
>  	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
>  
> +	cpu_data->tick_wakeup = tick_nohz_idle_got_tick();
> +
>  	dev->last_state_idx = state;
> -	if (dev->poll_time_limit ||
> -	    (tick_nohz_idle_got_tick() && cpu_data->sleep_length_ns > TICK_NSEC)) {
> -		/*
> -		 * The wakeup was not "genuine", but triggered by one of the
> -		 * safety nets.
> -		 */
> -		dev->poll_time_limit = false;
> -		cpu_data->artificial_wakeup = true;
> -	} else {
> -		cpu_data->artificial_wakeup = false;
> -	}
>  }

The result is definitely still visible, especially looking at the belows, but I'd say
this is in a reasonable range.
Tested-by: Christian Loehle <christian.loehle@arm.com>

device     gov        iter     iops      idles  idle_miss      ratio     belows     aboves
mmcblk1    teo-m      0      2354     648224        134      0.000        107         27
mmcblk1    teo-m      1      2334     644228         65      0.000         45         20
mmcblk1    teo-m      2      2331     640746         45      0.000         40          5
mmcblk1    teo-tickw  0      2352     596914        676      0.001        669          7
mmcblk1    teo-tickw  1      2331     617500       1553      0.003       1540         13
mmcblk1    teo-tickw  2      2330     613358       1733      0.003       1683         50
mmcblk2    teo-m      0      5702     854292        348      0.000        322         26
mmcblk2    teo-m      1      5657     640504        133      0.000         72         61
mmcblk2    teo-m      2      5651     704356        772      0.001        687         85
mmcblk2    teo-tickw  0      5704     871038       1744      0.002       1712         32
mmcblk2    teo-tickw  1      5617     476288       1791      0.004       1744         47
mmcblk2    teo-tickw  2      5640     632406       3225      0.005       3216          9
nvme0n1    teo-m      0     11446     832564         89      0.000         51         38
nvme0n1    teo-m      1     10568     780452        149      0.000         72         77
nvme0n1    teo-m      2     10505     777496        148      0.000         75         73
nvme0n1    teo-tickw  0     10614     756866       1531      0.002       1482         49
nvme0n1    teo-tickw  1     10583     750434       1427      0.002       1334         93
nvme0n1    teo-tickw  2     11229     796942       1658      0.002       1586         72
sda        teo-m      0      1271     869172        318      0.000        315          3
sda        teo-m      1      1271     798090       1209      0.002       1037        172
sda        teo-m      2      1270     807612         45      0.000         34         11
sda        teo-tickw  0      1269     786656        163      0.000        136         27
sda        teo-tickw  1      1270     779824       1515      0.002       1499         16
sda        teo-tickw  2      1271     600052       1610      0.003       1572         38
nullb0     teo-m      0    103325     105674        156      0.001         96         60
nullb0     teo-m      1    103421     111596         32      0.000         26          6
nullb0     teo-m      2    102145     112404        493      0.004        309        184
nullb0     teo-tickw  0    102055      77872       1672      0.021       1620         52
nullb0     teo-tickw  1    103397      77576       1636      0.021       1599         37
nullb0     teo-tickw  2    103637      87288       1733      0.020       1596        137
mtdblock3  teo-m      0       258     748824       1613      0.002       1600         13
mtdblock3  teo-m      1       258     765398        447      0.001        431         16
mtdblock3  teo-m      2       255     917614       3061      0.003       3044         17
mtdblock3  teo-tickw  0       261     289448       2035      0.007       2031          4
mtdblock3  teo-tickw  1       257     830352       2020      0.002       1986         34
mtdblock3  teo-tickw  2       260     392622       2868      0.007       2854         14


test       gov        i     score  %change    idles  idle_miss  miss_rt   belows   aboves
schbench   teo-m      0       194    0      27068         54      0.002         48          6
schbench   teo-m      1       213   10      27380          6      0.000          5          1
schbench   teo-m      2       195    0      24892          2      0.000          2          0
schbench   teo-m      3       194   -0      25356         20      0.001         17          3
schbench   teo-m      4       195    0      24966          7      0.000          7          0
schbench   teo-tickw  0       195    0      24226         48      0.002         47          1
schbench   teo-tickw  1       192   -1      25324         42      0.002         39          3
schbench   teo-tickw  2       192   -1      25214         43      0.002         42          1
schbench   teo-tickw  3       198    2      24658         59      0.002         57          2
schbench   teo-tickw  4       192   -1      25293         48      0.002         45          3
ebizzy     teo-m      0     10686    0       1120         12      0.011         10          2
ebizzy     teo-m      1     10720    0       1282         14      0.011         14          0
ebizzy     teo-m      2     10691    0       1078         11      0.010         11          0
ebizzy     teo-m      3     10666   -0       1306         15      0.011         12          3
ebizzy     teo-m      4     10699    0       1328          9      0.007          8          1
ebizzy     teo-tickw  0     10684   -0        902         11      0.012         11          0
ebizzy     teo-tickw  1     10704    0       1032         20      0.019         20          0
ebizzy     teo-tickw  2     10684   -0        914         22      0.024         18          4
ebizzy     teo-tickw  3     10681   -0       1208         46      0.038         43          3
ebizzy     teo-tickw  4     10702    0       1014         20      0.020         19          1
adrestia   teo-m      0        12    0     103750         19      0.000         16          3
adrestia   teo-m      1        12    0     104082         20      0.000         19          1
adrestia   teo-m      2        12    0     103830         22      0.000         12         10
adrestia   teo-m      3        12    0     104088         26      0.000         18          8
adrestia   teo-m      4        12    0     103740         24      0.000         18          6
adrestia   teo-tickw  0        12    0     102792         17      0.000         17          0
adrestia   teo-tickw  1        12    0     103020         39      0.000         38          1
adrestia   teo-tickw  2        12    0     102870         28      0.000         27          1
adrestia   teo-tickw  3        12    0     102746         32      0.000         30          2
adrestia   teo-tickw  4        12    0     102926         34      0.000         23         11

