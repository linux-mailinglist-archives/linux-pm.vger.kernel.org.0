Return-Path: <linux-pm+bounces-21613-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A8FA2E139
	for <lists+linux-pm@lfdr.de>; Sun,  9 Feb 2025 23:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40AE37A26FB
	for <lists+linux-pm@lfdr.de>; Sun,  9 Feb 2025 22:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315BF1ACEAB;
	Sun,  9 Feb 2025 22:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="Gj0JdPaP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE2A82488
	for <linux-pm@vger.kernel.org>; Sun,  9 Feb 2025 22:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739140868; cv=none; b=r76YywUpN49inYBdw17BIZBiwknLBxCIU0fn/wGs1gMUUYnC+4Q0n+AfgGtrdHcg7NPsu2U16+o3wfUVofzWLEVAs2DqvLJAj/h87aKCTNDMeGhVTykRfDVECOJblB7YciZ3/H6+88YI9y3Jkgo1G1Zv+O1BUQQ5xgbbEahItbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739140868; c=relaxed/simple;
	bh=6ruZVA3bxLlRzF+OzQLdiUrPqM2Yw5EMFTbnIZGUw0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCXRHdwtYERrXHWFEF/EB0XovuFydxqwj5sjXRjxAOM96ZhcvwKeV215iI09WtKddQGZ5OJ736vy6/MpO1I6S4gS06Z02svoC7wOiLw22MO2ZPJkEz1DNqucnqraGr7eSPAXotmPmL1bNFDCOuAJLHwaUwwJokvpzyDgeqt1jNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=Gj0JdPaP; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4362f61757fso36944815e9.2
        for <linux-pm@vger.kernel.org>; Sun, 09 Feb 2025 14:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1739140865; x=1739745665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dHasac0wYJLewPwy6Z51oDe8X/xHbyu9X4ByX5A4/JA=;
        b=Gj0JdPaPboLpqFXB/W2ypVXlsu4RNcNiAXZZbU4yOz0aajwI3/HkhxaptjSAw/YKph
         iBVS6SAMJrr0Efc3sCbOT1HbU7PVrOZnd8wBqYGClGeYDEMFLU6fc6VzXQ/tHlXsxMKi
         7J+qv2Jyj3AKEHHe3PuBK7i6Z4IGgOc0HCCWLjo6UUTHXVDG4RV4OroFHw4xgz5akTlQ
         DOyDu5wuBdmnaNO71+A/fBo+IHfrmV728sybRUvr9esFA+DR2Xcot5hFoxF4gvfj+Jbo
         Dt/I6ReHWq3SDM7EV0FOXJyr3gXgiRJ5pJSl5L6x7O3Aj241SJzu076nj7btO2nG8c/H
         C5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739140865; x=1739745665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHasac0wYJLewPwy6Z51oDe8X/xHbyu9X4ByX5A4/JA=;
        b=KfLox+M4HBVMhbIBSSI3EBDu7pyxj9O5U53lab8OUDOl5HE1jXiAd80FTjOH43FWM4
         gjDaWYjWXjUBXnUFEMX/I0MjvRWrZkgPU77XTBZnGLINizoCqctQTfV1dQ6Id4W2vqAc
         kSjfzfHDAoX1G2fuQ8qz0EWxWg0RQhQSnPmUOchMjFrO2GQWg0Zuz9tNfPGinLVNyX8P
         xUklVam63vNldm5K1mAKSyK219BmnnDqFWnAGrxX/Oqsn0Vz3/9gTvgR/JTc13t1v9DS
         B8HNtLRK4Vh9SnYnznn/4hx6+yCXi7CHaGsa78ljB1DYTTO4y3D6dBwReHnpqJsBrc+M
         EvfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7o1/8TlndUSyiAKYV57hPnzMYRlRL00XvVK2Zckq2YCWjm3J7CmJDKcWgwU0Jx2o6zwPxrsCfZA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Yvjb4O6h2ahMD0a8+z63Oxsj5sLEf68zdIYbGmWBXH1lcBJc
	TrrcSu81NdoKvXwm7mYCeM1Wf7N8pv9d2oGJi3xS3mZW/8ermuq0bnQGouWViXw=
X-Gm-Gg: ASbGncszW3UveYZ64cSDYA2MaF+4qV1HcCdNAGggnH8Lm7uyCfM2QhPKg/2LRqXEIcM
	+pv+K5/XgXuPEuj2mfRpwlKKTyGQ6zHS86t7PyPOfpAMkt1/MmUNbw8BouIA6762qVptiD6XhDY
	8FvpM94hVn0Uun5sa6j473mb7/gF012qZNjvHB2N2hc20Ez7VnIZXiNu+SaDK7VIdeB1UkFuUE2
	RLM0UcAVw648bAq8PiagPqbppmtaSN3gDiQryWauodhAnxalYlqgKuWLFsEL46gys2+p5ai9Ef8
	FTfdsM2XkXJc8QQO8jnr6TtioBBqXNavK7Kq74xhPdkxLChny2Ie/Ltp8E/gLH4ogzLF
X-Google-Smtp-Source: AGHT+IGXZt3Ti6ujWiCdM42O58wvb3IFYJsSvKFFb2omeKnKDpprFfF4GuoED6fO3Lq/cfXFY5hZzw==
X-Received: by 2002:a05:600c:511f:b0:435:d22:9c9e with SMTP id 5b1f17b1804b1-439249a8402mr83411675e9.19.1739140864613;
        Sun, 09 Feb 2025 14:41:04 -0800 (PST)
Received: from airbuntu (host109-154-33-115.range109-154.btcentralplus.com. [109.154.33.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390daf451fsm164902735e9.28.2025.02.09.14.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 14:41:04 -0800 (PST)
Date: Sun, 9 Feb 2025 22:41:03 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Hongyan Xia <hongyan.xia2@arm.com>,
	John Stultz <jstultz@google.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] sched: Consolidate cpufreq updates
Message-ID: <20250209224103.gcvli5zbdx67d4ad@airbuntu>
References: <20240728184551.42133-1-qyousef@layalina.io>
 <100c682c-57e0-4dad-86ca-e430f28eb7f3@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <100c682c-57e0-4dad-86ca-e430f28eb7f3@arm.com>

On 10/11/24 10:34, Christian Loehle wrote:

> > @@ -796,7 +802,8 @@ int __sched_setscheduler(struct task_struct *p,
> >  		__setscheduler_params(p, attr);
> >  		__setscheduler_prio(p, newprio);
> >  	}
> > -	__setscheduler_uclamp(p, attr);
> > +
> > +	update_cpufreq = __setscheduler_uclamp(p, attr);
> >  
> >  	if (queued) {
> >  		/*
> > @@ -811,7 +818,18 @@ int __sched_setscheduler(struct task_struct *p,
> >  	if (running)
> >  		set_next_task(rq, p);
> >  
> > -	check_class_changed(rq, p, prev_class, oldprio);
> > +	update_cpufreq |= check_class_changed(rq, p, prev_class, oldprio);
> > +
> > +	/*
> > +	 * Changing class or uclamp value implies requiring to send cpufreq
> > +	 * update.
> > +	 */
> > +	if (update_cpufreq) {
> > +		if (running)
> > +			update_cpufreq_current(rq);
> > +		else if (queued)
> > +			cpufreq_update_util(rq, SCHED_CPUFREQ_TASK_ENQUEUED);
> > +	}
> 
> cpufreq_update_util() -> sugov_should_update_freq() -> cpufreq_this_cpu_can_update()
> relies on smp_processor_id(), should this move this below the
> preempt_disable() to avoid sending an update from an illegal CPU?

We are holding the task_rq_lock() with interrupts disabled, we should be okay
no?

Did you see an actual warning from LOCKDEP?

