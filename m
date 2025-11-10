Return-Path: <linux-pm+bounces-37723-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 759A9C4675F
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 13:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07BD63A1335
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 12:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8703090D5;
	Mon, 10 Nov 2025 12:06:57 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF72B2FE071
	for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 12:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762776417; cv=none; b=KoKCEnix7QWXK6NH/DoWBvAgNpDSit8uL2EYX+cLLoNpDeaFVFbT1mIJX6yvJWKcarLyWrNMDMHcMEVlWO+Bn74jE0HByhcI81U0irhPPQzajC9GjF4KORI2CQZzuSo0gPg/CyAurUdnA8YCdWaFEEzB81trq2EeOHUy4x8SkQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762776417; c=relaxed/simple;
	bh=hJDgXZ4BHt2bT688+VdsOlX+wwSbDJlt45xwSEqnRHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M4TBtp4t9r3sJiUl+eRzCLICM2x4WfmacCyo3UP+MEHoflMdPt29CkOmVsfYF4dVl3tZXU/LJ4fkKXN3Gu5rHAvjd+emO8ZnRuZpsMf+bDfz0yfPy6e4NId2uYWR1UaBH7Ypz2rD787qSxjsKF8EFaW8NIQyRYysvunZEk9+Ji4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AB69497;
	Mon, 10 Nov 2025 04:06:46 -0800 (PST)
Received: from [10.1.34.30] (e127648.arm.com [10.1.34.30])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 868A63F66E;
	Mon, 10 Nov 2025 04:06:52 -0800 (PST)
Message-ID: <0c018867-c092-4f8e-8f7a-32bb02de3ad5@arm.com>
Date: Mon, 10 Nov 2025 12:06:50 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression in TEO cpuidle governor between 6.6 and 6.12
To: Reka Norman <rekanorman@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, daniel.lezcano@linaro.org,
 linux-pm@vger.kernel.org
References: <CAEmPcwsNMNnNXuxgvHTQ93Mx-q3Oz9U57THQsU_qdcCx1m4w5g@mail.gmail.com>
 <a50064b2-e6aa-4237-a715-12f21a65e9a6@arm.com>
 <ed1e64dc-91c9-44d9-b3d3-9f142bcf7a8d@arm.com>
 <CAJZ5v0g9Jndez5y5i4pPW1C+qfj=4iiu51HV7Eb1dBGd1jg-CA@mail.gmail.com>
 <b910a35c-83aa-4050-9c6c-de40f13a2a55@arm.com>
 <CAJZ5v0h6qAgWkEad5OGM-V-HOE-1PwD_XqgsDWbnJNxLWOKDfA@mail.gmail.com>
 <CAEmPcws_pvYpzRMQfMyRPBw=7bUyYCcnP3BHN2H4wgUeLLszFg@mail.gmail.com>
 <CAJZ5v0i_ZUD1=3JDABJZ3fcdD7r8uMU36=mam8r2=1P02YksYw@mail.gmail.com>
 <f0a2492b-9cea-4450-88ca-be8f99f3e0fe@arm.com>
 <CAEmPcwvui5Cg5yoa9NEq5b3OZREb08tbmy4=f=adTLuLPBgGgw@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAEmPcwvui5Cg5yoa9NEq5b3OZREb08tbmy4=f=adTLuLPBgGgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/10/25 06:10, Reka Norman wrote:
> On Mon, Nov 10, 2025 at 7:35 AM Christian Loehle
> <christian.loehle@arm.com> wrote:
>>
>> On 11/7/25 11:35, Rafael J. Wysocki wrote:
>>> On Fri, Nov 7, 2025 at 4:28 AM Reka Norman <rekanorman@chromium.org> wrote:
>>>>
>>>> On Fri, Nov 7, 2025 at 7:33 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>>>
>>>>> On Thu, Nov 6, 2025 at 12:13 PM Christian Loehle
>>>>> <christian.loehle@arm.com> wrote:
>>>>>>
>>>>>> On 11/5/25 20:48, Rafael J. Wysocki wrote:
>>>>>>> On Wed, Nov 5, 2025 at 12:24 AM Christian Loehle
>>>>>>> <christian.loehle@arm.com> wrote:
>>>>>>>>
>>>>>>>> On 11/4/25 09:03, Christian Loehle wrote:
>>>>>>>>> On 11/4/25 03:36, Reka Norman wrote:
>>>>>>>>>> Hi,
>>>>>>>>>>
>>>>>>>>>> I’m seeing a regression in the TEO governor between 6.6 and 6.12. At
>>>>>>>>>> 6.12, when the system is idle it’s spending almost 100% of time in
>>>>>>>>>> WFI, compared to about 6% at 6.6. At mainline it has improved compared
>>>>>>>>>> to 6.12 but is still a lot worse than 6.6, spending about 50% in WFI.
>>>>>>>>>>
>>>>>>>>>> The system is a ChromeOS device with Mediatek MT8196.
>>>>>>>>>>
>>>>>>>>>> Bisecting showed the specific commit which caused the regression is:
>>>>>>>>>> 4b20b07ce72f ("cpuidle: teo: Don't count non-existent intercepts")
>>>>>>>>>>
>>>>>>>>>> I’ve attached sysfs dumps showing the issue. All were taken a couple
>>>>>>>>>> of minutes after boot, with the device having been idle since boot.
>>>>>>>>>> The cases tested are:
>>>>>>>>>> cpuidle_6_6.txt      = 6.6 kernel
>>>>>>>>>> cpuidle_6_12.txt     = 6.6 kernel with teo commits up to 6.12
>>>>>>>>>> cpuidle_mainline.txt = 6.6 kernel with teo commits up to mainline
>>>>>>>>>>
>>>>>>>>>> Summary of the percentage time spent in each state (averaged across CPUs):
>>>>>>>>>>
>>>>>>>>>> |            |   6.6 |  6.12 | mainline |
>>>>>>>>>> |------------|------:|------:|---------:|
>>>>>>>>>> | WFI        |  6.02 | 99.94 |    56.84 |
>>>>>>>>>> | cpuoff     | 11.02 |     0 |     0.65 |
>>>>>>>>>> | clusteroff | 82.96 |  0.05 |    42.51 |
>>>>>>>>>> | s2idle     |     0 |     0 |        0 |
>>>>>>>>>>
>>>>>>>>>> Any help would be much appreciated. Let me know if there's any other
>>>>>>>>>> debugging information I should provide.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> That's not good.
>>>>>>>>> If the system is mostly idle (only boot activity but dumps are taken after
>>>>>>>>> ~3mins?), what is causing the wakeups? Even in 6.6 There are definitely more
>>>>>>>>> than I would've expected?
>>>>>>>>> I noticed that clusteroff and cpuoff have equal residency, which is
>>>>>>>>> obviously a bit awkward for cpuidle, but shouldn't be relevant to your issue.
>>>>>>>>>
>>>>>>>>> I'm a bit puzzled by your bisect results.
>>>>>>>>> 4b20b07ce72f ("cpuidle: teo: Don't count non-existent intercepts")
>>>>>>>>> made the intercept logic *less* prone to count (false) intercepts, yet it
>>>>>>>>> seems to count more of them? (resulting in more WFI).
>>>>>>>>> I'll think about it some more, for now of course a trace would be very
>>>>>>>>> helpful. (cpuidle events, ipi_raise, irqs?)
>>>>>>>>> Are there ever any latency constraints set?
>>>>>>>>>
>>>>>>>>> FWIW the mainline results look the most reasonable, from a 30000 feet view
>>>>>>>>> anyway:
>>>>>>>>> Cluster       State           above   below   usage   above%  below%
>>>>>>>>> LITTLE        cpuoff-l        ~75     ~65     ~140    23%     20%
>>>>>>>>> LITTLE        clusteroff-l    ~800    0       ~100    89%     0%
>>>>>>>>> MID   cpuoff-m        ~3–4    ~15     ~20     15%     55%
>>>>>>>>> MID   clusteroff-m    ~1300   0       ~4000   24%     0%
>>>>>>>>> BIG   cpuoff-b        0       1       1       —       —
>>>>>>>>> BIG   clusteroff-b    ~800    0       ~1900   30%     0%
>>>>>>>>>
>>>>>>>>> (WFI seems mostly the correct choice for little CPUs, that's fine, the energy
>>>>>>>>> savings compared to cpuoff should be marginal anyway.)
>>>>>>>>>
>>>>>>>>> Do you mind trying:
>>>>>>>>> 13ed5c4a6d9c cpuidle: teo: Skip getting the sleep length if wakeups are very frequent
>>>>>>>>> on 6.12?
>>>>>>>>>
>>>>>>>>
>>>>>>>> So just thinking out loud, the only case I can actually thing of to explain your
>>>>>>>> bisect to 4b20b07ce72f ("cpuidle: teo: Don't count non-existent intercepts")
>>>>>>>> is that the workload essentially changed dramatically because of our calls
>>>>>>>> to tick_nohz_get_sleep_length() now.
>>>>>>>> I'm not sure how likely I think that is, but I'm lacking imagination for another
>>>>>>>> cause. That's why results with
>>>>>>>> 13ed5c4a6d9c ("cpuidle: teo: Skip getting the sleep length if wakeups are very frequent")
>>>>>>>> would be interesting.
>>>>>>>
>>>>>>> My current theory is that this issue is related to the
>>>>>>> tick_nohz_get_sleep_length() overhead and the way "intercepts" are
>>>>>>> distinguished from "hits" in teo.
>>>>>>>
>>>>>>> Namely, teo assumes that its own overhead is negligible and so it
>>>>>>> counts a given event as an "intercept" if the measured time spent in
>>>>>>> the idle state (with the exit latency roughly taken into account)
>>>>>>> falls into a different "state bin" than the sleep length (the expected
>>>>>>> time till the next timer).  However, the sleep length is computed as a
>>>>>>> difference between the upcoming timer wakeup event time and
>>>>>>> ts->idle_entrytime, so it actually includes the time taken by
>>>>>>> tick_nohz_next_event().  If the latter is significant, it may
>>>>>>> contribute to the difference seen by teo_update() and cause extra
>>>>>>> "intercepts" to appear.
>>>>>>
>>>>>> Right, additionally with psci pc-mode and the exposed clusteroff states we end
>>>>>> up vastly exaggerating the wakeup latency (i.e. underestimating the actual idle time)
>>>>>> for three reasons:
>>>>>> - wakeup latency = entry+exit latency (worst case: pay full latencies on both
>>>>>> even though for most cases we don't incur the entry latency)
>>>>>> - Wakeup latency is a worst-case and often is more like 2x-3x of the average.
>>>>>> - We use the (higher) clusteroff values even though the clusteroff state couldn't
>>>>>> possibly have been entered as not the entire cluster is idle.
>>>>>>
>>>>>> Nonetheless these are all just a "intercept counting is significantly more likely"
>>>>>> while the results show not a single state >0 entered => the intercept logic
>>>>>> probably triggers every cpuidle entry.
>>>>>
>>>>> It has to for this to happen, if timers are not frequent enough.
>>>>>
>>>>>> Feels like there should be an issue in the feedback loop.
>>>>>
>>>>> I'm wondering what the issue could be though.  The change in commit
>>>>> 4b20b07ce72f only affects the cases when idle state 0 is about to be
>>>>> selected and it only really changes the sleep length value from
>>>>> KTIME_MAX to something more realistic (but it still may be KTIME_MAX).
>>>>>
>>>>> It may turn an "intercept" into a "hit", but only if the CPU is not
>>>>> woken up by the tick because those cases had been already counted as
>>>>> "hits" before commit 4b20b07ce72f.
>>>>>
>>>>> Now, if the majority of wakeups in the workload are tick wakeups, the
>>>>> only real difference appears to be the presence of
>>>>> tick_nohz_get_sleep_length() in that code path.
>>>>>
>>>>> Frankly, I would try to remove the update of cpu_data->sleep_length_ns
>>>>> right before the "goto out_tick" statement (in 6.12 that should be
>>>>> line 426) and see what happens.
>>>>
>>>> Just tried this quickly. Results attached. It goes back to behaving
>>>> the same as 6.6 - about 2% WFI.
>>>
>>> Thanks for checking this!  It means that the
>>> tick_nohz_get_sleep_length() overhead doesn't matter here that much.
>>>
>>> Instead of making the change above, can you please try the 6.12
>>> equivalent of the attached patch?
>>>
>>> Or alternatively, apply this one to the mainline and see if it changes
>>> the idle states selection proportions?
> 
> It doesn't seem to have an effect. Results are attached for both 6.12
> (6_12_teo_reflect) and mainline (mainline_teo_reflect). 6.12 is still
> 100% WFI and mainline is about 20% WFI on average, the same as before.
> 
>>
>> I don't quite follow this.
>> While I don't really believe that the tick_nohz_get_sleep_length() overhead
>> plays a role here, how does removing that assignment prove it isn't?
>>
>> The below (if that's what you meant) might lead to the overhead being optimized
>> out? [1]
> 
> Oh true. I tried the diff below instead (which I think should avoid
> that?). This also behaves the same as 6.6. Results attached as
> 6_12_sleep_length2.

Thanks for testing

> 
> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
> index 173ddcac540a..3c9595bc6c80 100644
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -427,8 +427,7 @@ static int teo_select(struct cpuidle_driver *drv,
> struct cpuidle_device *dev,
>                  * We have to query the sleep length here otherwise we don't
>                  * know after wakeup if our guess was correct.
>                  */
> -               duration_ns = tick_nohz_get_sleep_length(&delta_tick);
> -               cpu_data->sleep_length_ns = duration_ns;
> +               volatile s64 __maybe_unused duration_volatile_ns =
> tick_nohz_get_sleep_length(&delta_tick);
>                 goto out_tick;
>         }
> 
>> I'd be curious if [2] behaves like 6.12. So far I haven't been able to
>> reproduce the issue Reka is seeing.
> 
> Results with [2] attached as 6_12_sleep_length3. Yes, it behaves like 6.12.
> 

Hmm interesting.

>> There's one oddity that immediately came to mind: state1 and state2 having
>> the same residency (slightly different latency though), but when I set these
>> as such teo works fine. So I don't think it is an issue here.
>>
>> If Rafael's patch fixes the issue I'd still be curious what the predicted sleep
>> length values are here (they must be <1ms, but do in fact never trigger?).
> 
> In case it's helpful, I've attached a trace (trace_duration.dat) which
> includes a trace_printk of the duration_ns at this point (on top of
> unmodified 6.12).
While I was gonna ask for this anyway, it's not that useful (duration_ns is some
time in the far future, most wakeups are obviously ticks).
May I ask you to run the following hopefully one last time, just to check if we're
not missing something here:

-----8<-----

diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
index 173ddcac540a..f4cd648133e7 100644
--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -237,6 +237,28 @@ static void teo_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
        else
                cpu_data->state_bins[idx_duration].intercepts += PULSE;
 
+       if (dev->cpu == 7) {
+               char buf[1024];
+               size_t off;
+
+               off = scnprintf(buf, sizeof(buf),
+                     "cpu=%d last_state_idx=%d state_count=%u "
+                     "total=%u sleep_len_ns=%llu last_residency_ns=%llu measured_ns=%llu "
+                     "lat_ns=%llu idx_timer=%d idx_duration=%d tick_hits=%u | bins:",
+                     dev->cpu, dev->last_state_idx, drv->state_count, cpu_data->total,
+                     cpu_data->sleep_length_ns, dev->last_residency_ns, measured_ns,
+                     drv->states[dev->last_state_idx].exit_latency_ns,
+                     idx_timer, idx_duration, cpu_data->tick_hits);
+
+               for (i = 0; i < drv->state_count && off < sizeof(buf); i++) {
+                       struct teo_bin *bin = &cpu_data->state_bins[i];
+
+                       off += scnprintf(buf + off, sizeof(buf) - off,
+                                     " [%d]h=%u,i=%u,tr=%lld", i, bin->hits,
+                                     bin->intercepts, drv->states[i].target_residency_ns);
+               }
+               trace_printk("teo_update %s\n", buf);
+       }
 end:
        cpu_data->total += PULSE;
 }

