Return-Path: <linux-pm+bounces-12172-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4ACB950AAC
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 18:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 690181F217E4
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 16:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F18B1A257E;
	Tue, 13 Aug 2024 16:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lkEQTydc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801DA1A2C20
	for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2024 16:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723567444; cv=none; b=F9fZSMzDzwby/OrzfsRQcdO1B1PngOtOsKIEZe5uUl06TAcapyVZElVB6OmuxgHMEn24nuQZH/+Zur5svdF6XXEiKlFyBl8XwyyA5myhnklZc5cjZB4WTNwJWJlpsGEjH/LFY64uxkhKgWUglMJEkp/9F16zj1PHBstloNrWf6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723567444; c=relaxed/simple;
	bh=iZTPPeJPZnM6sKl9FJDEGL4dPSe78TNZpHUxAKuarRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VptFBCxv7j1GIS8ySMkMVrSIyxpDYOp1sEIg1Wh67zVRcIzEP25oGEwPAAi1TSqlaUEAp8CoMXdgHIvbtYlCxJAZB7rMKvt6H9Y5V6/jb1oLCr5d8Sr/fy0Tbenp7Z5WJqPkXgNd21RNAqHvk/eTQVZ2n/mUtLAzJzMnkqEiuQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lkEQTydc; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2cb56c2c30eso26227a91.1
        for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2024 09:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723567442; x=1724172242; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iZTPPeJPZnM6sKl9FJDEGL4dPSe78TNZpHUxAKuarRY=;
        b=lkEQTydcNoTZeaOl6HFdx7ukv3X4sDxvUcgropbAz9c9A6N4kga7ho+f5Y3qBQ+b3S
         QPpVTEWcxawEEcLgc3T87SSWtB1U++TZIwuCQIDeAhteBJ98hkH/+AdF/PbpZ3bi07+6
         63M0aThNP0oaK/x8PpgL/spQ6cJqntnF37SvLDFhdOjAYFpBQFc4CykOoS6ES2i+M+bR
         QPO6qJ+R1JqOUb5oGNbuaanfSWre+wKVjxvmQXCPobPjFgPBZjQvC8P5N3h7gzRskeOO
         s0HKR0RaEvYx0HfTzdY4pv1cVxtHkXwT/wXANoxxBIz9nB/dgJWKXhVw/5UQO5mdV6BM
         e5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723567442; x=1724172242;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iZTPPeJPZnM6sKl9FJDEGL4dPSe78TNZpHUxAKuarRY=;
        b=V3Mv2GGMG3uyq445uH9GslYs6sXipK5X9bzEfgaLEkvJFTw3A2nn34+Fl3oxcdYWiv
         R++f01OP8w1cxAZ8SNdqb0Bb1STI1TNTQufEu7ZQctlWC9fY5Jc/mkEFxLIn4olGRt7t
         yflYDMEIg8LNnfcTb95QaC59fzpRnJo1jA/heDvc0yI1QpmqTu3PKH7fHm8A1n7rS9dH
         c8PGRvf6zf3mowrRRmsyyvGqRhgSHgmNsbNG3LJgD5Bsmr2CLG64e5KA0Z+2maVyhCNz
         ThDkzFgPmgx139S/8qHkqJf+NKmS5VY4WWhiPr8OcFmj/X8jyW+Q1ijexhz0D4CsXCOr
         BRAg==
X-Forwarded-Encrypted: i=1; AJvYcCVzDrfTdP9i6f+IdsExMdMnGnlycpm3USmixJTr6cE1fZJxIJ09PexxJHKp1AFNNd0q2hlIX2QlgA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdHGMFGFrbl3QnC9WyqtZcQ8qEusoQrAHP34/HknZpsfhaca+c
	sLTr2ywkOs1blyp3t9mppEfw5XHvmpQAhclBuy6Kxoj1xRIlq+HGbk5rDr/zt/FttGrSrjBeO5p
	Tfr2MO6McjhyD3WSRmyQX4BrL4zRzhE5E55F8nw==
X-Google-Smtp-Source: AGHT+IFz9jzB0wuOz3sFuvyDXoHJiyy6L4Daz+/p3eoq+br3Uxu6n24XOFcrxvfP7Az/p9eq38iw25rzVhmNQHyVc0A=
X-Received: by 2002:a17:90b:80e:b0:2c9:63fb:d3ab with SMTP id
 98e67ed59e1d1-2d3aa04c260mr374545a91.22.1723567441648; Tue, 13 Aug 2024
 09:44:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240728184551.42133-1-qyousef@layalina.io> <ca6b1db0-37d9-462e-87e4-d3bbd5eec7a3@arm.com>
 <CAKfTPtBWLe4hMBhJeSqvoW10dAF3Bgj+zcYGMgBfwUhkgytkEQ@mail.gmail.com>
 <CAKfTPtAJNjUe=4eQxq0M6==6O7dtJrw6rtwE6-xaWMJdSmfKcA@mail.gmail.com> <bfcd8175-c6bc-41a2-8ee9-93061e446c40@arm.com>
In-Reply-To: <bfcd8175-c6bc-41a2-8ee9-93061e446c40@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 13 Aug 2024 18:43:49 +0200
Message-ID: <CAKfTPtB0ePyT=st3KX0MCidUwLbYpgz0tSe0TbFJV316LV-b2g@mail.gmail.com>
Subject: Re: [PATCH v7] sched: Consolidate cpufreq updates
To: Christian Loehle <christian.loehle@arm.com>
Cc: Qais Yousef <qyousef@layalina.io>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Hongyan Xia <hongyan.xia2@arm.com>, 
	John Stultz <jstultz@google.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Aug 2024 at 18:26, Christian Loehle <christian.loehle@arm.com> wrote:
>
> On 8/13/24 09:27, Vincent Guittot wrote:
> > On Tue, 13 Aug 2024 at 10:25, Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> >>
> >> On Mon, 5 Aug 2024 at 17:35, Christian Loehle <christian.loehle@arm.com> wrote:
> >>>
> >>> On 7/28/24 19:45, Qais Yousef wrote:
> >>>> Improve the interaction with cpufreq governors by making the
> >>>> cpufreq_update_util() calls more intentional.
> >>>>
> >>>> At the moment we send them when load is updated for CFS, bandwidth for
> >>>> DL and at enqueue/dequeue for RT. But this can lead to too many updates
> >>>> sent in a short period of time and potentially be ignored at a critical
> >>>> moment due to the rate_limit_us in schedutil.
> >>>>
> >>>> For example, simultaneous task enqueue on the CPU where 2nd task is
> >>>> bigger and requires higher freq. The trigger to cpufreq_update_util() by
> >>>> the first task will lead to dropping the 2nd request until tick. Or
> >>>> another CPU in the same policy triggers a freq update shortly after.
> >>>>
> >>>> Updates at enqueue for RT are not strictly required. Though they do help
> >>>> to reduce the delay for switching the frequency and the potential
> >>>> observation of lower frequency during this delay. But current logic
> >>>> doesn't intentionally (at least to my understanding) try to speed up the
> >>>> request.
> >>>>
> >>>> To help reduce the amount of cpufreq updates and make them more
> >>>> purposeful, consolidate them into these locations:
> >>>>
> >>>> 1. context_switch()
> >>>> 2. task_tick_fair()
> >>>> 3. sched_balance_update_blocked_averages()
> >>>> 4. on sched_setscheduler() syscall that changes policy or uclamp values
> >>>> 5. on check_preempt_wakeup_fair() if wakeup preemption failed
> >>>> 6. on __add_running_bw() to guarantee DL bandwidth requirements.
> >>>>
> >>>> The update at context switch should help guarantee that RT get the right
> >>>> frequency straightaway when they're RUNNING. As mentioned though the
> >>>> update will happen slightly after enqueue_task(); though in an ideal
> >>>> world these tasks should be RUNNING ASAP and this additional delay
> >>>> should be negligible. For fair tasks we need to make sure we send
> >>>> a single update for every decay for the root cfs_rq. Any changes to the
> >>>> rq will be deferred until the next task is ready to run, or we hit TICK.
> >>>> But we are guaranteed the task is running at a level that meets its
> >>>> requirements after enqueue.
> >>>>
> >>>> To guarantee RT and DL tasks updates are never missed, we add a new
> >>>> SCHED_CPUFREQ_FORCE_UPDATE to ignore the rate_limit_us. If we are
> >>>> already running at the right freq, the governor will end up doing
> >>>> nothing, but we eliminate the risk of the task ending up accidentally
> >>>> running at the wrong freq due to rate_limit_us.
> >>>>
> >>>> Similarly for iowait boost, we ignore rate limits. We also handle a case
> >>>> of a boost reset prematurely by adding a guard in sugov_iowait_apply()
> >>>> to reduce the boost after 1ms which seems iowait boost mechanism relied
> >>>> on rate_limit_us and cfs_rq.decayed preventing any updates to happen
> >>>> soon after iowait boost.
> >>>>
> >>>> The new SCHED_CPUFREQ_FORCE_UPDATE should not impact the rate limit
> >>>> time stamps otherwise we can end up delaying updates for normal
> >>>> requests.
> >>>
> >>> Hi Qais,
> >>> the idea of SCHED_CPUFREQ_FORCE_UPDATE and the possiblity of spamming
> >>> freq updates still bothered me so let me share my thoughts even though
> >>> it might be niche enough for us not to care.
> >>>
> >>> 1. On fast_switch systems, assuming they are fine with handling the
> >>> actual updates, we have a bit more work on each context_switch() and
> >>> some synchronisation, too. That should be fine, if anything there's
> >>> some performance regression in a couple of niche cases.
> >>>
> >>> 2. On !fast_switch systems this gets more interesting IMO. So we have
> >>> a sugov DEADLINE task wakeup for every (in a freq-diff resulting)
> >>> update request. This task will preempt whatever and currently will
> >>> pretty much always be running on the CPU it ran last on (so first CPU
> >>> of the PD).
> >>
> >> The !fast_switch is a bit of concern for me too but not for the same
> >> reason and maybe the opposite of yours IIUC your proposal below:
> >>
> >> With fast_switch we have the following sequence:
> >>
> >> sched_switch() to task A
> >> cpufreq_driver_fast_switch -> write new freq target
> >> run task A
> >>
> >> This is pretty straight forward but we have the following sequence
> >> with !fast_switch
> >>
> >> sched_switch() to task A
> >> queue_irq_work -> raise an IPI on local CPU
> >> Handle IPI -> wakeup and queue sugov dl worker on local CPU (always
> >> with 1 CPU per PD)
> >> sched_switch() to sugov dl task
> >> __cpufreq_driver_target() which can possibly block on a lock
> >> sched_switch() to task A
> >> run task A
> >>
> >
> > sent a bit too early
> >
> >> We can possibly have 2 context switch and one IPi for each "normal"
> >> context switch which is not really optimal
> >
> > It would be good to find a way to skip the spurious back and forth
> > between the normal task and sugov
>
> Just to confirm I understand your concern correctly, that's more or
> less the behavior without Qais' patch as well though, isn't it?
> Ignoring the move from "This happens at enqueue" vs. "this
> happens at context switch".

without Qais patch, we save a useless context switch to task A

enqueue task A
queue_irq_work -> raise an IPI on local CPU
Handle IPI -> wakeup and queue sugov dl worker on local CPU (always
with 1 CPU per PD)
 sched_switch() to sugov dl task
__cpufreq_driver_target() which can possibly block on a lock
sched_switch() to task A


> Since sugov doesn't queue any work if the desired frequency doesn't
> change I imagine it's not too bad?
> Or are you more concerned that the work is queued multiple times
> simultaneously for multiple CPUs of the same PD? If so we can
> work around that with the work_in_progress state to at least limit
> that window by a lot.
>
> [snip]

