Return-Path: <linux-pm+bounces-946-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F7680EBE2
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 13:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5B281F21321
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 12:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D655A0F1;
	Tue, 12 Dec 2023 12:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="GBVibhOE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2133094
	for <linux-pm@vger.kernel.org>; Tue, 12 Dec 2023 04:34:05 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40c3ca9472dso35710425e9.2
        for <linux-pm@vger.kernel.org>; Tue, 12 Dec 2023 04:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1702384443; x=1702989243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qH4GCN8NP4UVplIzZIjeXaAMe6hOa3JIwifkIum0yHg=;
        b=GBVibhOEE0UssfV0zCqleJgi0XberOscf9zrYx5SEO4qjDwGzK9+jheAGm4SfQLBbc
         PHbh1zL8ELb/C8tIn6ro4CJ+cwOitaSGXz9p1/ej0wQT8rIyk5tUjEotLd3Ekg7CFQQ+
         dfFGmSnjMvmNIR/2kcLktZpHT7C6iT9GedykCwFdp0Z/0Gjxa3GRddefGWWsi9WRdzMk
         T2xYXpRMLQUxUNhh1I007vv/Yh8is4VHQQEQWTbjPBLp2B8t+Ac5MJCebHUvKmyn6JiO
         57gA9osXH0OytJYbO5xrm7CdKBAdutcFb0O7ywvBTa6X2rUUomXn1CCe0hLebVD9oDbY
         ffNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702384443; x=1702989243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qH4GCN8NP4UVplIzZIjeXaAMe6hOa3JIwifkIum0yHg=;
        b=us7u6gs4JZxXmCZfaFiJDlN9Ey7pHSAIns3GBUCE3vBR0uJ+aC1/LzpYlhMfJG2/NH
         uDOEm9DbiGwFw2yNMiemc77G/q151PtI6Po9qDBtkGzwFuzAPSPXpGvh2rz5BM01h9Cs
         WX7g5qDUlFjfpHNIKtcrc8gPdnFRIlmHGh+2xb05IvxDvFuSVh+JMWT/M3868VVyJVaz
         pHtY2ntmMfEmhGHTVCIseVvRkrA+HSL/UEaRKDoJ5At9gU2TxSOf686nB8AxKW6GutBK
         aw2UUvLGIO6QJhALX/3e0smCbg+W2syt3s3H30C3HhL9j6e1Fnofzu6j1lLFrNNbz75n
         5IWg==
X-Gm-Message-State: AOJu0YwO1zLt9kbp6rHv9muzHA36Xd9V5tphqVzklIF8xKe9asZ0+bIN
	R9upWG7DhnJnZl0vaHBmCVDyPw==
X-Google-Smtp-Source: AGHT+IGRuSiXo4gnt47yVdBgsk0sabo0j0/ahhZxmVi0ieVByY4Q6AaNQZNsy8oRZlELdKe1PmpnPg==
X-Received: by 2002:a05:600c:4195:b0:40c:243f:c36a with SMTP id p21-20020a05600c419500b0040c243fc36amr2248385wmh.206.1702384443328;
        Tue, 12 Dec 2023 04:34:03 -0800 (PST)
Received: from airbuntu ([104.132.45.98])
        by smtp.gmail.com with ESMTPSA id f9-20020a05600c154900b0040c4be1af17sm4932733wmg.21.2023.12.12.04.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 04:34:02 -0800 (PST)
Date: Tue, 12 Dec 2023 12:34:01 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
	Rick Yiu <rickyiu@google.com>, Chung-Kai Mei <chungkai@google.com>,
	Hongyan Xia <hongyan.xia2@arm.com>
Subject: Re: [PATCH 1/4] sched/fair: Be less aggressive in calling
 cpufreq_update_util()
Message-ID: <20231212123401.xmggng7dtxvdxqj6@airbuntu>
References: <20231208015242.385103-1-qyousef@layalina.io>
 <20231208015242.385103-2-qyousef@layalina.io>
 <739492e4-b9a3-4c55-82e6-60b02d489c5f@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <739492e4-b9a3-4c55-82e6-60b02d489c5f@arm.com>

On 12/11/23 18:47, Christian Loehle wrote:
> On 08/12/2023 01:52, Qais Yousef wrote:
> > Due to the way code is structured, it makes a lot of sense to trigger
> > cpufreq_update_util() from update_load_avg(). But this is too aggressive
> > as in most cases we are iterating through entities in a loop to
> > update_load_avg() in the hierarchy. So we end up sending too many
> > request in an loop as we're updating the hierarchy.
> 
> If this is actually less aggressive heavily depends on the workload,
> I can argue the patch is more aggressive, as you call cpufreq_update_util
> at every enqueue and dequeue, instead of just at enqueue.
> For an I/O workload it is definitely more aggressive, see below.

I could have unwittingly broken something. Thanks for the report!

> 
> > 
> > Combine this with the rate limit in schedutil, we could end up
> > prematurely send up a wrong frequency update before we have actually
> > updated all entities appropriately.
> > [SNIP]
> 
> 
> > @@ -6704,14 +6677,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >  	 */
> >  	util_est_enqueue(&rq->cfs, p);
> >  
> > -	/*
> > -	 * If in_iowait is set, the code below may not trigger any cpufreq
> > -	 * utilization updates, so do it here explicitly with the IOWAIT flag
> > -	 * passed.
> > -	 */
> > -	if (p->in_iowait)
> > -		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
> > -
> >  	for_each_sched_entity(se) {
> >  		if (se->on_rq)
> >  			break;
> > @@ -6772,6 +6737,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >  enqueue_throttle:
> >  	assert_list_leaf_cfs_rq(rq);
> >  
> > +	cpufreq_update_util(rq, p->in_iowait ? SCHED_CPUFREQ_IOWAIT : 0);
> > +
> >  	hrtick_update(rq);
> >  }
> >  
> > @@ -6849,6 +6816,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >  
> >  dequeue_throttle:
> >  	util_est_update(&rq->cfs, p, task_sleep);
> > +	cpufreq_update_util(rq, 0);
> 
> This is quite critical, instead of only calling the update
> at enqueue (with SCHED_CPUFREQ_IOWAIT if applicable) it is
> now called at every enqueue and dequeue. The only way for

I think it was called at enqueue/dequeue before, but now it is done
unconditionally as I don't check for decay like before. It shouldn't change the
behavior as if there's no frequency change, then the governor will do nothing,
including not update last_update_time IIRC.

> schedutil (intel_pstate too?) to build up a value of
> iowait_boost > 128 is a large enough rate_limit_us, as even
> for just a in_iowait task the enqueue increases the boost and
> its own dequeue could reduce it already. For just a basic
> benchmark workload and 2000 rate_limit_us this doesn't seem
> to be that critical, anything below 200 rate_limit_us didn't

200us is too low. Does rk3399 support this? My pine64 has this SoC and
I remember it doesn't support fastswitch and the time to wake up the sugov
thread will be comparable to this before even trying to talk tot he hardware.

Not necessarily means that I don't have a bug in my code of course! :)

> show any iowait boosting > 128 anymore on my system.
> Of course if the workload does more between enqueue and
> dequeue (time until task issues next I/O) already larger
> values of rate_limit_us will disable any significant
> iowait boost benefit.

Hmm. It seems sugov_iowait_reset() is being called at the dequeue?

Tweaking the rate limit means short living tasks freq update at dequeue is
likely to be ignored by the governor.

The short value means it is likely to be taken into account.

Not sure if this is uncovering a bug somewhere else or I broke something.

> 
> Just to add some numbers to the story:
> fio --time_based --name=fiotest --filename=/dev/nvme0n1 --runtime=30 --rw=randread --bs=4k --ioengine=psync --iodepth=1
> fio --time_based --name=fiotest --filename=/dev/mmcblk2 --runtime=30 --rw=randread --bs=4k --ioengine=psync --iodepth=1
> 
> All results are sorted:
> With this patch and rate_limit_us=2000:
> (Second line is without iowait boosting, results are sorted):
> [3883, 3980, 3997, 4018, 4019]
> [2732, 2745, 2782, 2837, 2841]
> /dev/mmcblk2
> [4136, 4144, 4198, 4275, 4329]
> [2753, 2975, 2975, 2975, 2976]
> 
> Without this patch and rate_limit_us=2000:
> [3918, 4021, 4043, 4081, 4085]
> [2850, 2859, 2863, 2873, 2887]
> /dev/mmcblk2
> [4277, 4358, 4380, 4421, 4425]
> [2796, 3103, 3128, 3180, 3200]
> 
> With this patch and rate_limit_us=200:
> /dev/nvme0n1
> [2470, 2480, 2481, 2484, 2520]
> [2473, 2510, 2517, 2534, 2572]
> /dev/mmcblk2
> [2286, 2338, 2440, 2504, 2535]
> [2360, 2462, 2484, 2503, 2707]
> 
> Without this patch and rate_limit_us=200:
> /dev/nvme0n1
> [3880, 3956, 4010, 4013, 4016]
> [2732, 2867, 2937, 2937, 2939]
> /dev/mmcblk2
> [4783, 4791, 4821, 4855, 4860]
> [2653, 3091, 3095, 3166, 3202]

Was any other patch in this series or remove margin series applied or just this
one?

> 
> I'm currently working on iowait boosting and seeing where it's
> actually needed and how it could be improved, so always interested
> in anyone's thoughts.

One of the problems identified with iowait boost is that it is per-cpu; which
means tasks that are causing the iowait to happen will lose this boost when
migrated.

Arm was working on a way to help convert it to per-task. See Lukasz email.

> 
> (The second line here doesn't provide additional
> information, I left it in to compare for reproducibility).
> All with CONFIG_HZ=100 on an rk3399.

Your tick is 10ms?! sugov_iowait_reset() should return false then. I see now,
we undo the boost in sugov_iowait_apply().

There's room for improvement for sure. Thanks for the feedback!


Cheers

--
Qais Yousef

> 
> Best Regards,
> Christian
> 
> > [SNIP]

