Return-Path: <linux-pm+bounces-19229-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 090099F1C0C
	for <lists+linux-pm@lfdr.de>; Sat, 14 Dec 2024 03:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C423B161A06
	for <lists+linux-pm@lfdr.de>; Sat, 14 Dec 2024 02:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531CC11712;
	Sat, 14 Dec 2024 02:15:37 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483B91C36;
	Sat, 14 Dec 2024 02:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734142537; cv=none; b=Ar0O9ZLdsS8lO/oeghtORdgsW/F+fexC6wv33aX69GdsSROd2Dm2TPuaHFOIE7gRgvmqToRXiVfJZ7v7Ul+knkrtVBxVlgRhIMnwKSFtqGpYUA3SwTz5rycRqFA/2Dy+rF9FoiFE2tVDH92fMsJJTc4j9D+hYkKl/ScxIGaX64I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734142537; c=relaxed/simple;
	bh=g+HuL+0XzIItvDQt3tpq+CBPvxYJY5YCw4d5QA8Eel4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7xPTEJXkmFNoE304DPnOirnG9UGHsvaCTO0/h6nlHJQqzhYk0gncC0umJkXkM+OljgHXsw1KQZizmOaHilni9m16cH28/W2NUY/5r+qbT+WWMqEJ/XNm5jUpOWSarCeHdJFI+Pr6vBuRe9WRzpXUIhSFFCzwgkaXDoJ3tESqsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21649a7bcdcso22965335ad.1;
        Fri, 13 Dec 2024 18:15:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734142534; x=1734747334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4eR1QQCmZ1YyL0J7ehuGJ45Hy8bOAg5ImJY1Jbwufg=;
        b=Je8ycSA/yUZ48+Wa8KVZ5qEiPGzGVijyJSiOE9ge6jBkb348o5qQiL8w2zeHP13t+w
         ah3Z2AjMKyHTQ4uJmXcJTo/bOyEQ2MaHkwu4b+Srv0ytHFY+cCTJFDL1Gu74dSEgzVjc
         ivi3wS6HYXuKviixKEwXqGCyk5dyZTmpiajHsLETl81L2JOtxRl7xDZrUZNoE8cW9M6E
         uFmE4zkCgYuN49RGmM3/lagHYAkQ4sU5X/QA7JK0EScimaldmS5P3kwl3UES2bUQs1y9
         KUsD+r3JiFsJX4ChXqyFcKLXtuftzaojaR2lvMlahkc+8dMVL9/5i4gtzP4BeZdyhiKu
         mFKA==
X-Forwarded-Encrypted: i=1; AJvYcCXNTEgrRTw5p/XuYOGMxdB8NaKPJwLYCtIJNzNzAqVuVtdJczUjCZccOFeXcpwCrNHbxU8PgDpNSdsiItg=@vger.kernel.org, AJvYcCXPeEoJiUL2YTwvlrIta4aFOvDwr1ruBImW4KTvMyp4MdrM4IF4uHwH1QPbKNwY5AKmLOZvaXXV79I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1xtvSnKXOLT2R4IsOuG//YKb0cw3qi/jCY3x/yVvg8omb5oJK
	fkR+imTB0dNHaonjHXlhCiGGoFr3TvHDf04kjyZvp/UaYw00q/hD
X-Gm-Gg: ASbGnctR59UiIWguiuYVihDdsFcZlAR8/X/oiCvc7VJqrt+NUBqpGXiAiQSfwZkIXj8
	je0mXQ84y+wmDoZKSXXjZ7kbpowOMdL2idrCbmXupPZR1RpF6nuIoZNczX4kRZGibFNvwJL8Rox
	NKINiIQ8W5Ejl7XqM4C3o5Jk2wTMvySTPrryCYHUzQt3r4msJIDgjvPHT5EsJnsUtb4ec46ofh9
	sm97uG6BEIWQjErmCWTbY8BEoBmj8svJ7hSezXHUhCPHF6txpTsOTHLXpiGhHp5Y8FClnwyhKk=
X-Google-Smtp-Source: AGHT+IHIcQgXQhQJMCuswOjRYUA99uTtFZHjXNcTKxRLSX2I/ZKpfNQeUkyXvmRu4r3/mCNrHOA5WA==
X-Received: by 2002:a17:902:ec90:b0:216:2bd7:1c2e with SMTP id d9443c01a7336-218929b780bmr60927435ad.18.1734142534260;
        Fri, 13 Dec 2024 18:15:34 -0800 (PST)
Received: from sultan-box.localdomain ([142.147.89.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1dcb447sm4145825ad.68.2024.12.13.18.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 18:15:33 -0800 (PST)
Date: Fri, 13 Dec 2024 18:15:29 -0800
From: "Sultan Alsawaf (unemployed)" <sultan@kerneltoast.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Beata Michalska <Beata.Michalska@arm.com>,
	Qais Yousef <qyousef@layalina.io>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH 2/2] cpufreq: schedutil: Ignore rate limit when scaling
 up with FIE present
Message-ID: <Z1zqQaH6aoCsW3UL@sultan-box.localdomain>
References: <20241212015734.41241-1-sultan@kerneltoast.com>
 <a383eb2a-7752-4c2c-8792-dda9a05b2a53@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a383eb2a-7752-4c2c-8792-dda9a05b2a53@arm.com>

On Thu, Dec 12, 2024 at 12:06:20PM +0000, Christian Loehle wrote:
> On 12/12/24 01:57, Sultan Alsawaf wrote:
> > From: "Sultan Alsawaf (unemployed)" <sultan@kerneltoast.com>
> 
> Hi Sultan,
> (Adding further CCs that might be interested in this)
> Good to see some input here again, if it becomes a regular thing,
> which I would welcome, you might want to look into git send-email
> or b4 relay, at least in my inbox this series looks strange.
> Also no cover letter.

Hi Christian,

Thank you for the encouraging words! :-)

Sorry about the strangeness. I knew better and should've sent a cover letter;
when I saw how the series looked on the list a few minutes after sending it, I
grimaced and realized my mistake. FWIW, I did use git send-email, but I hadn't
heard about b4; thanks for the tip!

> > 
> > When schedutil disregards a frequency transition due to the transition rate
> > limit, there is no guaranteed deadline as to when the frequency transition
> > will actually occur after the rate limit expires. For instance, depending
> > on how long a CPU spends in a preempt/IRQs disabled context, a rate-limited
> > frequency transition may be delayed indefinitely, until said CPU reaches
> > the scheduler again. This also hurts tasks boosted via UCLAMP_MIN.
> 
> Realistically this will be the tick at worst for the systems you care about,
> I assume.

Typically, yes, especially so with PREEMPT_RT. It can get quite bad otherwise if
preempt/IRQs are disabled for a while, e.g. a common offender is zone->lock in
the page allocator.

> > 
> > For frequency transitions _down_, this only poses a theoretical loss of
> > energy savings since a CPU may remain at a higher frequency than necessary
> > for an indefinite period beyond the rate limit expiry.
> 
> theoretical?

I can't think of a realistic way to measure these lost energy savings, much less
reclaim them.

> > 
> > For frequency transitions _up_, however, this poses a significant hit to
> > performance when a CPU is stuck at an insufficient frequency for an
> > indefinitely long time. In latency-sensitive and bursty workloads
> > especially, a missed frequency transition up can result in a significant
> > performance loss due to a CPU operating at an insufficient frequency for
> > too long.
> 
> The term significant implies you have some numbers, please go ahead and
> share them then.

On a Pixel 9 with fast_switch (that I implemented myself), and AMU-driven FIE:

Test command:

	taskset 40 perf stat --repeat 10 -e cycles,instructions,task-clock perf bench sched messaging -g 50

The last Cortex-A720 core in the PD of three A720 cores is tested, with
rate_limit_us set to 2000.

Before this patch, schedutil:
----------------------------
 Performance counter stats for 'perf bench sched messaging -g 50' (10 runs):

        9121062386      cycles                           #    2.541 GHz                      ( +-  1.17% )
       10863940366      instructions                     #    1.22  insn per cycle           ( +-  0.20% )
           3577.62 msec task-clock                       #    0.991 CPUs utilized            ( +-  0.82% )

            3.6108 +- 0.0294 seconds time elapsed  ( +-  0.81% )

After this patch, schedutil:
----------------------------
 Performance counter stats for 'perf bench sched messaging -g 50' (10 runs):

        8577233522      cycles                           #    2.538 GHz                      ( +-  0.73% )
       10514835388      instructions                     #    1.26  insn per cycle           ( +-  0.08% )
           3533.64 msec task-clock                       #    1.039 CPUs utilized            ( +-  0.67% )

            3.4005 +- 0.0238 seconds time elapsed  ( +-  0.70% )

With performance governor:
--------------------------
 Performance counter stats for 'perf bench sched messaging -g 50' (10 runs):

        8712516777      cycles                           #    2.653 GHz                      ( +-  0.84% )
       10543289262      instructions                     #    1.24  insn per cycle           ( +-  0.10% )
           3358.74 msec task-clock                       #    1.017 CPUs utilized            ( +-  0.84% )

            3.3028 +- 0.0283 seconds time elapsed  ( +-  0.86% )

There is an improvement of about 6% with schedutil after this patch. These
results are very consistent across several runs.

> I'm not sure if you're aware of Qais' series that also intends to ignore the
> rate-limit (in certain cases).
> https://lore.kernel.org/lkml/20240728184551.42133-1-qyousef@layalina.io/

I was unaware, thanks for the link.

I read through the cover letter and code, and my initial thought is that
task_tick_fair() is too slow to cover fair tasks' needs. Given that a PELT
period is ~1 ms, there can be several load updates in between ticks.

I also think that Qais' series permits too many frequency updates too quickly,
for example when switching from RT/DL to a fair task. On systems with a lot of
threaded IRQs (or PREEMPT_RT), I can imagine this results in the frequency
bouncing around a lot.

> I would mostly agree with your below argument regarding FIE and did lean
> towards dropping it altogether. The main issue I had with Qais' series
> was !fast_switch platforms and the resulting preemption by the DL task
> (Often on a remote, possibly idle CPU of the same perf-domain).
> Unlimited frequency updates can really hurt both power and throughput there.
> 
> Fortunately given the low-pass filter nature of PELT, without some special
> workloads, most calls to cpufreq_update_util() are dropped because there
> is no resulting frequency change anyway.
> 
> You keeping the rate-limit when reducing the frequency might be enough to
> work around the issue though. I will run some experiments like I did for
> Qais' series.

Yeah, my thinking is that always allowing updates _only_ when increasing the
frequency naturally bounds the number of possible updates in a given period. You
can't keep going up forever, unless you have a CPU with a ridiculously huge
number of discrete frequency steps. :-)

> I'll also go and check for unintended changes in iowait boost (that
> interacts with the rate-limit too).

Thanks!

> > 
> > When support for the Frequency Invariant Engine (FIE) _isn't_ present, a
> > rate limit is always required for the scheduler to compute CPU utilization
> > with some semblance of accuracy: any frequency transition that occurs
> > before the previous transition latches would result in the scheduler not
> > knowing the frequency a CPU is actually operating at, thereby trashing the
> > computed CPU utilization.
> > 
> > However, when FIE support _is_ present, there's no technical requirement to
> > rate limit all frequency transitions to a cpufreq driver's reported
> > transition latency. With FIE, the scheduler's CPU utilization tracking is
> > unaffected by any frequency transitions that occur before the previous
> > frequency is latched.
> > 
> > Therefore, ignore the frequency transition rate limit when scaling up on
> > systems where FIE is present. This guarantees that transitions to a higher
> > frequency cannot be indefinitely delayed, since they simply cannot be
> > delayed at all.
> > 
> > Signed-off-by: Sultan Alsawaf (unemployed) <sultan@kerneltoast.com>
> > ---
> >  kernel/sched/cpufreq_schedutil.c | 35 +++++++++++++++++++++++++++-----
> >  1 file changed, 30 insertions(+), 5 deletions(-)
> > 
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index e51d5ce730be..563baab89a24 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -59,10 +59,15 @@ static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
> >  
> >  /************************ Governor internals ***********************/
> >  
> > -static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
> > +static bool sugov_should_rate_limit(struct sugov_policy *sg_policy, u64 time)
> >  {
> > -	s64 delta_ns;
> > +	s64 delta_ns = time - sg_policy->last_freq_update_time;
> > +
> > +	return delta_ns < sg_policy->freq_update_delay_ns;
> > +}
> >  
> > +static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
> > +{
> >  	/*
> >  	 * Since cpufreq_update_util() is called with rq->lock held for
> >  	 * the @target_cpu, our per-CPU data is fully serialized.
> > @@ -87,17 +92,37 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
> >  		return true;
> >  	}
> >  
> > -	delta_ns = time - sg_policy->last_freq_update_time;
> > +	/*
> > +	 * When frequency-invariant utilization tracking is present, there's no
> > +	 * rate limit when increasing frequency. Therefore, the next frequency
> > +	 * must be determined before a decision can be made to rate limit the
> > +	 * frequency change, hence the rate limit check is bypassed here.
> > +	 */
> > +	if (arch_scale_freq_invariant())
> > +		return true;
> >  
> > -	return delta_ns >= sg_policy->freq_update_delay_ns;
> > +	return !sugov_should_rate_limit(sg_policy, time);
> >  }
> >  
> >  static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
> >  				   unsigned int next_freq)
> >  {
> > +	/*
> > +	 * When a frequency update isn't mandatory (!need_freq_update), the rate
> > +	 * limit is checked again upon frequency reduction because systems with
> > +	 * frequency-invariant utilization bypass the rate limit check entirely
> > +	 * in sugov_should_update_freq(). This is done so that the rate limit
> > +	 * can be applied only for frequency reduction when frequency-invariant
> > +	 * utilization is present. Now that the next frequency is known, the
> > +	 * rate limit can be selectively applied to frequency reduction on such
> > +	 * systems. A check for arch_scale_freq_invariant() is omitted here
> > +	 * because unconditionally rechecking the rate limit is cheaper.
> > +	 */
> >  	if (sg_policy->need_freq_update)
> >  		sg_policy->need_freq_update = false;
> > -	else if (sg_policy->next_freq == next_freq)
> > +	else if (next_freq == sg_policy->next_freq ||
> > +		 (next_freq < sg_policy->next_freq &&
> > +		  sugov_should_rate_limit(sg_policy, time)))
> >  		return false;
> >  
> >  	sg_policy->next_freq = next_freq;
> 
> Code seems to match your description FWIW.
> Maybe the comments could be trimmed somewhat.

How's this for the sugov_update_next_freq() comment?
	/*
	 * When a frequency update isn't mandatory, the rate limit is checked
	 * again upon frequency reduction because systems with frequency
	 * invariance bypass the rate limit check in sugov_should_update_freq().
	 * This is done so that the rate limit can be applied only for frequency
	 * reduction. A check for arch_scale_freq_invariant() is omitted here
	 * because unconditionally rechecking the rate limit is cheaper.
	 */

> Regards,
> Christian

Thanks,
Sultan

