Return-Path: <linux-pm+bounces-10641-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3877A927F53
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 02:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 642EB1C22397
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 00:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6132717F5;
	Fri,  5 Jul 2024 00:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="dU5MprSN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3C6ED9
	for <linux-pm@vger.kernel.org>; Fri,  5 Jul 2024 00:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720138931; cv=none; b=ZtjCOx5fW43qK1oW8/g77AVFC47NPK+cOuSQ2M4FJwaDpqmXMeYQCmt7R/P3rFefi3E113lIkTRN276Gy1Y6eC078uzntPVB/lfCWF0r44lpxaS0ArtZ6Lfvyt20x6PlinpP9x4yuekJeXQZDe4brQ7CQjfsKMEZ1ENgpcee6+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720138931; c=relaxed/simple;
	bh=HsjJxtfbTQPyq2x16Lmy4FQUwXd3PsjDgfeN6E6NqeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stkNrR5jZsnHwaK0o+QzaBsOS9Mp6hQRQcIfQjEYugGiM+vB597iDoRk9NfbVg/8aaTznvJ0Pq+mYKovzREmubin6gq3/YA8o9YxAxSpQT4/UfVC2tW5JusciowgNR08+FfvGUiuUZg9qWCV0A2P2INWcQEJ4Fh4zyIblAN1lE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=dU5MprSN; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ee7885aa5fso11919551fa.1
        for <linux-pm@vger.kernel.org>; Thu, 04 Jul 2024 17:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1720138927; x=1720743727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o623ORWAvJBn7up0k1SQlLqfsLuDL+TsI3SsUtdwat0=;
        b=dU5MprSN+e6OqVNoAjJ7f9yfrSBR0x+ZT01MX3Wym4FmnwAGRdFOjnkbGYxEexCFw7
         XFqZrhZAoGNfl5Y5+7hopypEFohno4IcdDZp0l7tALr13WoZaieHU2HwWTCYcT+GNc5Q
         upGmh0ETFq03bFfqk+MIOdKXTtIvxnBrYA/tD+zvzF81yWFMD+8ACHVfNLkrmWFtWzm+
         UejlaAukjCLr6CNSi38kP6lsVFAqgK0xfaYeyRvi1I9YCMkOXFky7SZ9H0x3v/CgDg9K
         AaWqWFlPzfpjZiNPmYCMVoo4Odkkv0SWgHU1XK8LyTXmwXCInJn8gEVcXQhddHcyA0gu
         ii3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720138927; x=1720743727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o623ORWAvJBn7up0k1SQlLqfsLuDL+TsI3SsUtdwat0=;
        b=kxnkzppu/T3SVxauel5TAJEadCwx4/zGpDhwUMqnI2aYDyuaaDCfsPSC/Unpn6ON0k
         4w2LUZPKx36LNULwBwBp8mSJC/RHgfte6vr5S/q2ajLZurveeK3ywRbvkrp7zs9wgJOl
         x6ksCE6Y2aoKTUkxBjMfRKfG7tDcpff0qWMarEeogT5T1ZhRoEIzc24iUGZJGiZIAs2T
         IHpFEYhc99OikTTjhTAZo0Mowj2UvSrNeut+JqrVP4p91mA6s9g9O4bJQMXUbiRMYQwx
         2vwP8uGPW2dbgLkqeNkRd/APXfPwo2e5NeAGgRmhTQzt/tx0Z0uwdjU4+JXa+izRKPns
         7g1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZjD1Rlgk/uJRMFLDNwOXoeXOJupub4UYZPDrKUDZneiRUXJFEMgvV+09DmHB7i1OxhMg9wH/dhx3HoHETP7tqgWYE7cEAq4U=
X-Gm-Message-State: AOJu0Yx24jNQQKJ5qgBFwy64jMU7pxMompK4EuFcixKk04ZZNu/ZyMYK
	LxT/MRdWUjXD5O+HVdeU+i+3lgnTzY9dV3tDGXdfMRQUC7bZDpWDPBOO0RETBkc=
X-Google-Smtp-Source: AGHT+IEeRPhPPavqMDdDaq2qhDtdIIeK9qTXoeIeONH0nAK74rQfQAtjU9/ED0inVF5J5QTVsnkzIw==
X-Received: by 2002:a2e:b0d1:0:b0:2ec:57c7:c740 with SMTP id 38308e7fff4ca-2ee8edffcc2mr20270911fa.39.1720138927355;
        Thu, 04 Jul 2024 17:22:07 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a251ef5sm40491345e9.36.2024.07.04.17.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 17:22:06 -0700 (PDT)
Date: Fri, 5 Jul 2024 01:22:05 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Hongyan Xia <hongyan.xia2@arm.com>,
	John Stultz <jstultz@google.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] sched: Consolidate cpufreq updates
Message-ID: <20240705002205.nnrgq7savzvsoqgl@airbuntu>
References: <20240619201409.2071728-1-qyousef@layalina.io>
 <f281ba07-d54a-460a-8f78-f7eb6bd8ed88@arm.com>
 <20240628015200.vw75huo53redgkzf@airbuntu>
 <d510f41a-1225-46d9-a2d7-ff9e6ff599d2@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d510f41a-1225-46d9-a2d7-ff9e6ff599d2@arm.com>

On 07/04/24 12:12, Dietmar Eggemann wrote:
> On 28/06/2024 03:52, Qais Yousef wrote:
> > On 06/25/24 14:58, Dietmar Eggemann wrote:
> > 
> >>> @@ -4917,6 +4927,84 @@ static inline void __balance_callbacks(struct rq *rq)
> >>>  
> >>>  #endif
> >>>  
> >>> +static __always_inline void
> >>> +__update_cpufreq_ctx_switch(struct rq *rq, struct task_struct *prev)
> >>> +{
> >>> +#ifdef CONFIG_CPU_FREQ
> >>> +	if (prev && prev->dl.flags & SCHED_FLAG_SUGOV) {
> >>> +		/* Sugov just did an update, don't be too aggressive */
> >>> +		return;
> >>> +	}
> >>> +
> >>> +	/*
> >>> +	 * RT and DL should always send a freq update. But we can do some
> >>> +	 * simple checks to avoid it when we know it's not necessary.
> >>> +	 *
> >>> +	 * iowait_boost will always trigger a freq update too.
> >>> +	 *
> >>> +	 * Fair tasks will only trigger an update if the root cfs_rq has
> >>> +	 * decayed.
> >>> +	 *
> >>> +	 * Everything else should do nothing.
> >>> +	 */
> >>> +	switch (current->policy) {
> >>> +	case SCHED_NORMAL:
> >>> +	case SCHED_BATCH:
> >>
> >> What about SCHED_IDLE tasks?
> > 
> > I didn't think they matter from cpufreq perspective. These tasks will just run
> > at whatever the idle system is happen to be at and have no specific perf
> > requirement since they should only run when the system is idle which a recipe
> > for starvation anyway?
> 
> Not sure we talk about the same thing here? idle_sched_class vs.
> SCHED_IDLE policy (FAIR task with a tiny weight of WEIGHT_IDLEPRIO).

Yes I am referring to SCHED_IDLE policy too. What is your expectation? AFAIK
the goal of this policy to run when there's nothing else needs running.

> 
> >>> +		if (unlikely(current->in_iowait)) {
> >>> +			cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT | SCHED_CPUFREQ_FORCE_UPDATE);
> >>> +			return;
> >>> +		}
> >>> +
> >>> +#ifdef CONFIG_SMP
> >>> +		if (unlikely(rq->cfs.decayed)) {
> >>> +			rq->cfs.decayed = false;
> >>> +			cpufreq_update_util(rq, 0);
> >>> +			return;
> >>> +		}
> >>> +#else
> >>> +		cpufreq_update_util(rq, 0);
> >>> +#endif
> >>
> >> We can have !CONFIG_SMP and CONFIG_FAIR_GROUP_SCHED systems. Does this
> >> mean on those systems we call cpufreq_update_util() for each cfs_rq of
> >> the hierarchy where on CONFIG_SMP we only do this for the root cfs_rq?
> > 
> > No. This is called on context switch only and hierarchy doesn't matter here. We
> > just do it unconditionally for UP since we only track the decayed at cfs_rq
> > level and I didn't think it's worth trying to make it at rq level.
> 
> OK, I see. The call in __update_cpufreq_ctx_switch() plus
> (task_tick_fair() and check_preempt_wakeup_fair()) are not related to a
> cfs_rq, but rather to the rq and/or task directly.
> 
> Currently we have the thing in update_load_avg() for !CONFIG_SMP and
> there we use cfs_rq_util_change() which only calls cpufreq_update_util()
> for root cfs_rq but this clearly has a cfs_rq context.
> 
> >> [...]
> >>
> >>> @@ -4744,8 +4716,8 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
> >>>  	if (se->avg.last_update_time && !(flags & SKIP_AGE_LOAD))
> >>>  		__update_load_avg_se(now, cfs_rq, se);
> >>>  
> >>> -	decayed  = update_cfs_rq_load_avg(now, cfs_rq);
> >>> -	decayed |= propagate_entity_load_avg(se);
> >>> +	cfs_rq->decayed |= update_cfs_rq_load_avg(now, cfs_rq);
> >>> +	cfs_rq->decayed |= propagate_entity_load_avg(se);
> >>>  
> >>>  	if (!se->avg.last_update_time && (flags & DO_ATTACH)) {
> >>>  
> >>> @@ -4766,11 +4738,8 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
> >>>  		 */
> >>>  		detach_entity_load_avg(cfs_rq, se);
> >>>  		update_tg_load_avg(cfs_rq);
> >>> -	} else if (decayed) {
> >>> -		cfs_rq_util_change(cfs_rq, 0);
> >>> -
> >>> -		if (flags & UPDATE_TG)
> >>> -			update_tg_load_avg(cfs_rq);
> >>> +	} else if (cfs_rq->decayed && (flags & UPDATE_TG)) {
> >>> +		update_tg_load_avg(cfs_rq);
> >>>  	}
> >>>  }
> >>
> >> You set cfs_rq->decayed for each taskgroup level but you only reset it
> >> for the root cfs_rq in __update_cpufreq_ctx_switch() and task_tick_fair()?
> > 
> > Yes. We only care about using it for root level. Tracking the information at
> > cfs_rq level is the most natural way to do it as this is what update_load_avg()
> > is acting on.
> 
> But IMHO this creates an issue with those non-root cfs_rq's within

I am not seeing the issue, could you expand on what is it?

> update_load_avg() itself. They will stay decayed after cfs_rq->decayed
> has been set to 1 once and will never be reset to 0. So with UPDATE_TG
> update_tg_load_avg() will then always be called on those non-root
> cfs_rq's all the time.

We could add a check to update only the root cfs_rq. But what do we gain? Or
IOW, what is the harm of unconditionally updating cfs_rq->decayed given that we
only care about the root cfs_rq? I see more if conditions and branches which
I am trying to avoid.

