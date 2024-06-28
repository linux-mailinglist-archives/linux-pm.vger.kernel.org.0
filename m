Return-Path: <linux-pm+bounces-10158-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA1291B4C7
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 03:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26BF01C216DB
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 01:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD1514277;
	Fri, 28 Jun 2024 01:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="kJmtjvL+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CBE1400A
	for <linux-pm@vger.kernel.org>; Fri, 28 Jun 2024 01:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719539525; cv=none; b=eSF0sMNdnsWzCUBStDteJM4RR3d0FoPR/vOc2Dkwgju1AW5PDY+xKBO7YCDJ2sF1LcO04N4BhiWJWWcYDrfhPQ66fXGbCiRspa6gEhI+S6evyljCLcp+L/auzhHoBobseqkeyc6YTCggs53tafhvu+H8CnkTr0rasz2TZIHMrF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719539525; c=relaxed/simple;
	bh=NpbEpSTdbFRJ9jSFWZ/I6EHnZGo1rDdUX9yvuPzZo9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvvvaGm1i7Ho8QyS6fxrwQ3CxXMsxTI8nUD/XtilfqF3EXp+XXDpeNjLTd2PPwTyhxJm1Dw8ibYzSlLHARmkVt0qwr7WfHdA/3K4uEzwCKGYXxOFmAWv1H842I33nsYM0yiMkJMPZ24PBnU3RZLHBzvvvabrYYNwjYFjGmNuE+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=kJmtjvL+; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42564a0d3ceso811755e9.0
        for <linux-pm@vger.kernel.org>; Thu, 27 Jun 2024 18:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1719539522; x=1720144322; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lvyvL7sSYnWF73nZZ2R616gtm5dM5S1yjRMp5jsz2YI=;
        b=kJmtjvL+kVCEkCfyC1ayjD/WwmfNnhKUAR4bq3uhhKNc7YHljTeOTM4hyvbejxo9ds
         Fd04uOYUIDWMglySRWlSqcP/B8P6tGkHkw5AaTFmp5IYyF1/oiuEHm3zubFW09+ZQ1tS
         bRiH7xmNjvzE4tfQkEpMKOpu3nvzZOP7RWilRuFvjuUyzB10kGKKdhoG3gZdak6p7yVD
         fOn/a7TgG20Ut6aOLRq0TVFV4+zyvxVKvMoToU8dRsmKdQcRStEG7TsTGPnC45EtGqu0
         zEnCkySaxXmDWE5IRDETh76XkyWKoUv4/nRSZfLeS2m4NI2Kugdh9eJ0wJl6qZNCbKaC
         13Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719539522; x=1720144322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvyvL7sSYnWF73nZZ2R616gtm5dM5S1yjRMp5jsz2YI=;
        b=OJmzibVht+Hfb6qbrL5aKwOl4HMsmVm3pykemo9/KcYRiYV1vDm2XhwnzDg3/ZF3m3
         nrhZdSzfwJ70E4+4L9TNuS3zlFEvWnt5MqIe0/3NYsZA9FXRaYlKKYwxsDG8Jrs+GN8C
         sdapwnM9LArLwyPwSDOCgT2zCLyp5vOjN3Jg+b76oaXfIc4nGD+C3AlMwkc0FLOFjJKW
         SlaRltx7Ffx/QAS2vN9HpprDo4jk7nFv0v/19iCf6WwllITecxEcRTo7CVNg1oGhR7FR
         r/nXTBgJMD5vvuMeVMKST1vk51Gg35SGH8un6Z4p7cqqMwhqtg07lZnOzDmGiEOiJHrs
         lb4A==
X-Forwarded-Encrypted: i=1; AJvYcCXnPnERIaOuuSJIXkGW7GpHWn0WjVXmP6dcYTJlXQm4GsuaSfIWGWA3RlGEJfsZ3ofr5iykU//rLX1XttqJzsRqaEETZMsCnzM=
X-Gm-Message-State: AOJu0YzHgTN/OiQJdoTMajPL3RTIid6Rn0cBcWEoFGUewlChtWZTgZ5W
	vAZGpi+68/S64u9LzIJH1KNbAAuB3UCYhbowFuxOrx33n1vPgY7ALoKgMz9D/+E=
X-Google-Smtp-Source: AGHT+IHTJZg+LuweCmL8WGATnVT0JLoi2AWTzn3z8vnE4MboAjk01OaoXqEm1/sLrVCaDrDFi6rfbQ==
X-Received: by 2002:a05:600c:19d3:b0:425:6b77:f5e0 with SMTP id 5b1f17b1804b1-4256b77f81cmr6169465e9.31.1719539522295;
        Thu, 27 Jun 2024 18:52:02 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b097bcbsm13809025e9.35.2024.06.27.18.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 18:52:01 -0700 (PDT)
Date: Fri, 28 Jun 2024 02:52:00 +0100
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
Message-ID: <20240628015200.vw75huo53redgkzf@airbuntu>
References: <20240619201409.2071728-1-qyousef@layalina.io>
 <f281ba07-d54a-460a-8f78-f7eb6bd8ed88@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f281ba07-d54a-460a-8f78-f7eb6bd8ed88@arm.com>

On 06/25/24 14:58, Dietmar Eggemann wrote:

> > @@ -4917,6 +4927,84 @@ static inline void __balance_callbacks(struct rq *rq)
> >  
> >  #endif
> >  
> > +static __always_inline void
> > +__update_cpufreq_ctx_switch(struct rq *rq, struct task_struct *prev)
> > +{
> > +#ifdef CONFIG_CPU_FREQ
> > +	if (prev && prev->dl.flags & SCHED_FLAG_SUGOV) {
> > +		/* Sugov just did an update, don't be too aggressive */
> > +		return;
> > +	}
> > +
> > +	/*
> > +	 * RT and DL should always send a freq update. But we can do some
> > +	 * simple checks to avoid it when we know it's not necessary.
> > +	 *
> > +	 * iowait_boost will always trigger a freq update too.
> > +	 *
> > +	 * Fair tasks will only trigger an update if the root cfs_rq has
> > +	 * decayed.
> > +	 *
> > +	 * Everything else should do nothing.
> > +	 */
> > +	switch (current->policy) {
> > +	case SCHED_NORMAL:
> > +	case SCHED_BATCH:
> 
> What about SCHED_IDLE tasks?

I didn't think they matter from cpufreq perspective. These tasks will just run
at whatever the idle system is happen to be at and have no specific perf
requirement since they should only run when the system is idle which a recipe
for starvation anyway?

> 
> > +		if (unlikely(current->in_iowait)) {
> > +			cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT | SCHED_CPUFREQ_FORCE_UPDATE);
> > +			return;
> > +		}
> > +
> > +#ifdef CONFIG_SMP
> > +		if (unlikely(rq->cfs.decayed)) {
> > +			rq->cfs.decayed = false;
> > +			cpufreq_update_util(rq, 0);
> > +			return;
> > +		}
> > +#else
> > +		cpufreq_update_util(rq, 0);
> > +#endif
> 
> We can have !CONFIG_SMP and CONFIG_FAIR_GROUP_SCHED systems. Does this
> mean on those systems we call cpufreq_update_util() for each cfs_rq of
> the hierarchy where on CONFIG_SMP we only do this for the root cfs_rq?

No. This is called on context switch only and hierarchy doesn't matter here. We
just do it unconditionally for UP since we only track the decayed at cfs_rq
level and I didn't think it's worth trying to make it at rq level.

> 
> [...]
> 
> > @@ -4744,8 +4716,8 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
> >  	if (se->avg.last_update_time && !(flags & SKIP_AGE_LOAD))
> >  		__update_load_avg_se(now, cfs_rq, se);
> >  
> > -	decayed  = update_cfs_rq_load_avg(now, cfs_rq);
> > -	decayed |= propagate_entity_load_avg(se);
> > +	cfs_rq->decayed |= update_cfs_rq_load_avg(now, cfs_rq);
> > +	cfs_rq->decayed |= propagate_entity_load_avg(se);
> >  
> >  	if (!se->avg.last_update_time && (flags & DO_ATTACH)) {
> >  
> > @@ -4766,11 +4738,8 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
> >  		 */
> >  		detach_entity_load_avg(cfs_rq, se);
> >  		update_tg_load_avg(cfs_rq);
> > -	} else if (decayed) {
> > -		cfs_rq_util_change(cfs_rq, 0);
> > -
> > -		if (flags & UPDATE_TG)
> > -			update_tg_load_avg(cfs_rq);
> > +	} else if (cfs_rq->decayed && (flags & UPDATE_TG)) {
> > +		update_tg_load_avg(cfs_rq);
> >  	}
> >  }
> 
> You set cfs_rq->decayed for each taskgroup level but you only reset it
> for the root cfs_rq in __update_cpufreq_ctx_switch() and task_tick_fair()?

Yes. We only care about using it for root level. Tracking the information at
cfs_rq level is the most natural way to do it as this is what update_load_avg()
is acting on.

> 
> [...]
> 
> > @@ -8418,6 +8378,14 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
> >  	if (pick_eevdf(cfs_rq) == pse)
> >  		goto preempt;
> >  
> > +nopreempt:
> > +#ifdef CONFIG_SMP
> > +	if (rq->cfs.decayed && rq->cfs.h_nr_running > 1)
> > +		cpufreq_update_util(rq, SCHED_CPUFREQ_TASK_ENQUEUED);
> 
> Why don't you set rq->cfs.decayed to false here as well?
> 
> Is it because the request might fail in sugov_should_update_freq() in
> case 'delta_ns < sysctl_sched_base_slice'?

Yes. This call is likely to fail and we don't have a way to get a feedback to
know whether it went through or not.

FWIW I already have a patch that I considered sending along this submission
but opted not to as it'll make things too complicated.

But FWIW, I make cpufreq_update_util() return a bool to indicate whether
cpufreq update has happened or not and this helps to reset rq->cfs.decayed more
accurately in all call site like this one. But I think this should be another
independent patch.


Thanks!

--
Qais Yousef

