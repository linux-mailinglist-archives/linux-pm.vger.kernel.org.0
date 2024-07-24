Return-Path: <linux-pm+bounces-11374-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DAA93B879
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2024 23:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F5CF1C216D7
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2024 21:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E5B137932;
	Wed, 24 Jul 2024 21:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="wNbIo+n2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC106F068
	for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2024 21:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721856180; cv=none; b=YVZJITSuT5vPRlO445UZdSDcEhiWbNWeoxaD1I9vv4gcsc4Wnp8PLq00TsCZ04YPUe547Gy+05CZhogi67OBh59Hv1B7+NTRYr3s4bEdcLvnjxXtouef5awIgW70T8khwVHSuZLTaU5qtvH3QbN1uGdAd7RW7K+FOoRq71Rb7pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721856180; c=relaxed/simple;
	bh=d2ZXc3BVYryftX80w9yEHKwmvcNM6iE4MYP9fO5lBmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/MQeWn7ZgsNlm7CnM6hwPdogHsbsLdAPsBkOn4F2vCrtdEmXCErDrtkG9XCI9c6ac5kzdyv5qZUSHx7FzT9USCYmiEPD1vAx7f+IZgL6L/cKTqtpv69Lan8gygFhP9E7bQA3ml/yX0/kCHunDc03XEEluyvhegHv+PE7caU5eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=wNbIo+n2; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4266f344091so1540405e9.0
        for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2024 14:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1721856177; x=1722460977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T6aiLXEDYk3KMRYdq7G0ukFaw3QC1+sc4hDsUq9CI+c=;
        b=wNbIo+n2y0bJjjmogJ0KbfFJMKx6V8+PrGdVGJ6hl7VIhTwgX7z+4JUKuChdPCkQHj
         YQdv7Or56KwNzKKVY3INH79ttvAkxC2ZPkS5wekoatpYHbiSk0UbxX+E4W9GGaYJxzhX
         zB0wqUXMHj4avonDyR44sodMR0x0y3RdqUwvVY+ncDIg+ShRmQt9nIb8ys5S1aA6LEOJ
         hWtBQ30vn0blNHveXZfEkt6842z9uVCm4e1jxW9Rpg4WOjNMmXoN6n91/4R62gi1qN27
         l8L6TAmp1L8nud1l3+fY0d3jbagaTkArTwF/nm5eV0+9p/G4T802WEWRn5uoXc71/sF7
         ic/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721856177; x=1722460977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6aiLXEDYk3KMRYdq7G0ukFaw3QC1+sc4hDsUq9CI+c=;
        b=G9NkUatTCivbLc3N6l0PhiB5ncxAg/Ugoy7uwc5y/UQRr0YQB/qZltUWtWb3d4cBTd
         0nf9ioKquANYN5OhOXDtnGY+AFov3pLnOooImYr1rha1/HhMunX6/k8NZf1iq2iUzJ5b
         feTgnooxsSyssi9HbGbeGmcq9I78MShaLGoTq9mFInc0aLmnICl4tYiwxWwbvVzJ+s7W
         RNYBLN9qWBzEZOSUyvfQr87oq6BWQyUcyjmZCLDrPhFhZQltpeWt7ckKBhyXgCJqWnNA
         FQRcNTTLf7WYs5qxV9NbcKamtYt7uH7+c8vUK5lwbNtUkwmyX6ANom1ZnoH2CTiirVJu
         iaWw==
X-Forwarded-Encrypted: i=1; AJvYcCU2ZlXkZ1WaSRsnq0VdU2504UxsB7nyQ85ZI+3OHwrkmJQlK888rqYP92orsFbyiv0a2DvUhPvzdHd3cnFPtbnziviPZXqGMSA=
X-Gm-Message-State: AOJu0Yx2fI7gjl6n417GBQ8Nkq45wFlbGeS+bu0cW68W+7gILLPoixST
	LifU0/KZPyd4vRmYJM84bdTpmuZQVfLg1i19o98kp6M92qSGtpWZRewpapft9k0=
X-Google-Smtp-Source: AGHT+IFm3uVYuFwfUyq54Z9j4F2qJ4GTgcqVgTksVXU8kl3ThNq9N7/lfxkomuLbdw301dh0Jz8D6A==
X-Received: by 2002:a05:600c:4f14:b0:426:6960:34ac with SMTP id 5b1f17b1804b1-42805747073mr1219295e9.36.1721856176687;
        Wed, 24 Jul 2024 14:22:56 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42805730e68sm3329255e9.9.2024.07.24.14.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 14:22:56 -0700 (PDT)
Date: Wed, 24 Jul 2024 22:22:55 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Hongyan Xia <hongyan.xia2@arm.com>,
	John Stultz <jstultz@google.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] sched: Consolidate cpufreq updates
Message-ID: <20240724212255.mfr2ybiv2j2uqek7@airbuntu>
References: <20240619201409.2071728-1-qyousef@layalina.io>
 <CAKfTPtBQnTJQaU6iYCz3JhZ0Y=MjyM7oZ3Ug_SNfyZ0AwVPXJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtBQnTJQaU6iYCz3JhZ0Y=MjyM7oZ3Ug_SNfyZ0AwVPXJQ@mail.gmail.com>

On 07/09/24 09:48, Vincent Guittot wrote:
> On Wed, 19 Jun 2024 at 22:14, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > Improve the interaction with cpufreq governors by making the
> > cpufreq_update_util() calls more intentional.
> >
> > At the moment we send them when load is updated for CFS, bandwidth for
> > DL and at enqueue/dequeue for RT. But this can lead to too many updates
> > sent in a short period of time and potentially be ignored at a critical
> > moment due to the rate_limit_us in schedutil.
> >
> > For example, simultaneous task enqueue on the CPU where 2nd task is
> > bigger and requires higher freq. The trigger to cpufreq_update_util() by
> > the first task will lead to dropping the 2nd request until tick. Or
> > another CPU in the same policy triggers a freq update shortly after.
> >
> > Updates at enqueue for RT are not strictly required. Though they do help
> > to reduce the delay for switching the frequency and the potential
> > observation of lower frequency during this delay. But current logic
> > doesn't intentionally (at least to my understanding) try to speed up the
> > request.
> >
> > To help reduce the amount of cpufreq updates and make them more
> > purposeful, consolidate them into these locations:
> >
> > 1. context_switch()
> > 2. task_tick_fair()
> > 3. update_blocked_averages()
> > 4. on syscall that changes policy or uclamp values
> > 5. on check_preempt_wakeup_fair() if wakeup preemption failed
> 
> So this above is the new thing to take care of enqueues that generate
> sudden updates of util_est and could require a frequency change, isn't
> it ?

Yes.

> 
> >
> > The update at context switch should help guarantee that DL and RT get
> > the right frequency straightaway when they're RUNNING. As mentioned
> > though the update will happen slightly after enqueue_task(); though in
> > an ideal world these tasks should be RUNNING ASAP and this additional
> 
> That's probably ok for RT although it means possibly running up to the
> switch at lowest frequency but I suppose it's not a big concern as it
> is already the case if the RT task will end up on a different CPU than
> the local one.
> 
> I'm more concerned about DL tasks. cpu_bw_dl() reflects the min
> bandwidth/capacity to run all enqueued DL tasks in time. The dl
> bandwidth is updated when a DL task is enqueued and this
> bandwidth/capacity should be applied immediately and not at the next
> context switch otherwise you will not have enough bandwidth if the
> newly enqueued DL task does not preempt current DL task

Hmm. Yes.

I moved the DL updates to __add_running_bw() with the new FORCE_UDPATE flag to
ensure rate limit doesn't accidentally block it. No need for an update at
dequeue though as the context switch will handle that.

> > -static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
> > +static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time,
> > +                                    unsigned int flags)
> >  {
> >         s64 delta_ns;
> >
> > +       delta_ns = time - sg_policy->last_freq_update_time;
> > +
> > +       /*
> > +        * We want to update cpufreq at context switch, but on systems with
> > +        * long TICK values, this can happen after a long time while more tasks
> > +        * would have been added meanwhile leaving us potentially running at
> > +        * inadequate frequency for extended period of time.
> > +        *
> > +        * This logic should only apply when new fair task was added to the
> > +        * CPU, we'd want to defer to context switch as much as possible, but
> > +        * to avoid the potential delays mentioned above, let's check if this
> > +        * additional tasks warrants sending an update sooner.
> > +        *
> > +        * We want to ensure there's at least an update every
> > +        * sysctl_sched_base_slice.
> > +        */
> > +       if (likely(flags & SCHED_CPUFREQ_TASK_ENQUEUED)) {
> > +               if (delta_ns < sysctl_sched_base_slice)
> 
> I'm not sure that this is the right condition. This value seems quite
> long to me and not that much different from a 4ms tick. Should we use
> the 1024us of the pelt

I thought about using 1ms, but opted for this. Comparing against NSEC_PER_MSEC
now. I think our base_slice should be 1ms by default, but maybe I am trying to
do too much in one go :)

> 
> Also, I run the use case that I ran previously and I have cases where
> we wait more than 4.5 ms between the enqueue of the big task and the
> freq update (with a 1ms tick period) so There are probably some corner
> cases which are not correctly handled.
> 
> My use case is 2 tasks running on the same cpu. 1 short task A running
> 500us with a period of 19457us and 1 long task B running 19000 us with
> a period of 139777us. The periods are set to never be in sync with the
> tick which is 1 ms. There are cases when task B wakes up while task A
> is already running and doesn't preempt A and the freq update happens
> only 4.5ms after task B wakes up and task A went back to sleep whereas
> we should switch immediatly from 760Mhz to 1958 Mhz

Thanks for that. From what I see we have two problems:

1. rq->cfs.decayed is not set to true after the new enqueue.
2. rate_limit_us can still block the update and there's nothing we can do
   aboutu this here.

I could reproduce the problem without my patch by the way.

When we fail to preempt, I force rq->cfs.decayed be true always now. Not sure
if we're hitting another bug or decayed can be false sometimes after an
enqueue.

> > @@ -614,6 +619,7 @@ int __sched_setscheduler(struct task_struct *p,
> >         int retval, oldprio, newprio, queued, running;
> >         const struct sched_class *prev_class;
> >         struct balance_callback *head;
> > +       bool update_cpufreq;
> >         struct rq_flags rf;
> >         int reset_on_fork;
> >         int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
> > @@ -796,7 +802,8 @@ int __sched_setscheduler(struct task_struct *p,
> >                 __setscheduler_params(p, attr);
> >                 __setscheduler_prio(p, newprio);
> >         }
> > -       __setscheduler_uclamp(p, attr);
> > +
> > +       update_cpufreq = __setscheduler_uclamp(p, attr);
> >
> >         if (queued) {
> >                 /*
> > @@ -811,7 +818,14 @@ int __sched_setscheduler(struct task_struct *p,
> >         if (running)
> >                 set_next_task(rq, p);
> >
> > -       check_class_changed(rq, p, prev_class, oldprio);
> > +       update_cpufreq |= check_class_changed(rq, p, prev_class, oldprio);
> > +
> > +       /*
> > +        * Changing class or uclamp value implies requiring to send cpufreq
> > +        * update.
> > +        */
> > +       if (update_cpufreq && running)
> 
> Why running ? it should be queued as we are max aggregating

The new logic is to ignore changes at enqueue but defer them to context switch
when a task is RUNNING.

That said, we do actually send an update if we fail to preempt now at enqueue.
I will do something similar here for queued task to match the new logic.


Thanks!

--
Qais Yousef

> 
> > +               update_cpufreq_current(rq);
> >
> >         /* Avoid rq from going away on us: */
> >         preempt_disable();
> > --
> > 2.34.1
> >

