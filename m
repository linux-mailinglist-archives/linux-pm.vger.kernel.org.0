Return-Path: <linux-pm+bounces-944-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F73280EB46
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 13:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCC2E28200F
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 12:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924155DF3F;
	Tue, 12 Dec 2023 12:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="j50qnq5n"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CFBC7
	for <linux-pm@vger.kernel.org>; Tue, 12 Dec 2023 04:10:27 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40c46d6784eso19639885e9.3
        for <linux-pm@vger.kernel.org>; Tue, 12 Dec 2023 04:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1702383025; x=1702987825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kqFH+oXtPJzwgBpoVNZnokoMTw6/cExkaaGTM4d3Nbo=;
        b=j50qnq5nisbWIKeqe1aq7yLm2vNU1xy410j0lUxXYgqGMPGOUJ7fsSTgMerVLKpja6
         LEMOr5WDwt6OWUKQNG8Dg2y9zOIb8bRFEHD/1Z4YWUvOaSZfAeeHNJ+jOWPtsgGNh9w/
         EXFtWRKzF0SOX6/iiYc3D8T1sDBsF8ZLtXD684GA2nln+fKMj3HrYZPhvLU3wK3IfL/M
         UlIhk040co+Vcs91Uq0ueUCL84D5jJsBZby+yzlLviZBlBXGL1CsHeQMjBIViHTV73C7
         I++MoAkOXs5cd7BvjG8lOyCy4mV4yGigmL/GfNMHWCgCKUY/vAZQQn5RChr80xslzP6W
         AH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702383025; x=1702987825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqFH+oXtPJzwgBpoVNZnokoMTw6/cExkaaGTM4d3Nbo=;
        b=sJeCBEa9DQqi3UH+ETwQZBGBc0azDLq9RPDZV2CWwwmrOHYwHsy5mttYo2dFeEj/5h
         7lmXxyn1OxpJpZH+uaLLDv2/jiuQ4kLu4zedJgWBYEkKKAA2jU6cdnIGIt8p25C/9Ejb
         V0XVDQJ8CJQrzvv2pzak6T2P2xnnpCYIg81trMBx9U2cY+km25T610B4cNWpa2UXSeFV
         3hW7ylPcb6z3vWQODx23e1CnJR22lV5zF6frigG1HmzzqlnNVLowLO3CE+NkO19FmDeg
         Lvg+LCrVUl3UbPYLLohrXVIdAol+C48TWMUKkrKQzPuSo8z2L/wMS1gffyKT8Y+oXhmU
         GscA==
X-Gm-Message-State: AOJu0Yzq9QmF5Qrh3faa2rHpJKVRtNwABFf/Trmmn8LHSVYS1z7S2gEW
	/gPN1RYCjYLkF4BWCfpANMtV9A==
X-Google-Smtp-Source: AGHT+IHxmkHsB45t4kksg3Zado7hMjvNhUr6X3TbSiIUJKXCu+mzV9EE0v5THi7znuGCo+8wAgNE0w==
X-Received: by 2002:a05:600c:4447:b0:40c:46eb:e6ae with SMTP id v7-20020a05600c444700b0040c46ebe6aemr1789965wmn.116.1702383025472;
        Tue, 12 Dec 2023 04:10:25 -0800 (PST)
Received: from airbuntu ([104.132.45.98])
        by smtp.gmail.com with ESMTPSA id g17-20020a05600c311100b0040c4535f1a2sm8432400wmo.39.2023.12.12.04.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 04:10:25 -0800 (PST)
Date: Tue, 12 Dec 2023 12:10:23 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-pm@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
	Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
	Chung-Kai Mei <chungkai@google.com>,
	Hongyan Xia <hongyan.xia2@arm.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/4] sched/fair: Be less aggressive in calling
 cpufreq_update_util()
Message-ID: <20231212121023.mehtligcuwcmjtz4@airbuntu>
References: <20231208015242.385103-1-qyousef@layalina.io>
 <20231208015242.385103-2-qyousef@layalina.io>
 <bc525124-da79-45af-a99b-ec4616b3fa6b@arm.com>
 <20231210205156.kausxdcwsydggwie@airbuntu>
 <8ee6425a-0a0e-4391-9fd3-8fe74c809772@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8ee6425a-0a0e-4391-9fd3-8fe74c809772@arm.com>

On 12/11/23 07:56, Lukasz Luba wrote:
> 
> 
> On 12/10/23 20:51, Qais Yousef wrote:
> > On 12/08/23 10:05, Lukasz Luba wrote:
> > > Hi Qais,
> > > 
> > > On 12/8/23 01:52, Qais Yousef wrote:
> > > 
> > > [snip]
> > > 
> > > > @@ -6704,14 +6677,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> > > >    	 */
> > > >    	util_est_enqueue(&rq->cfs, p);
> > > > -	/*
> > > > -	 * If in_iowait is set, the code below may not trigger any cpufreq
> > > > -	 * utilization updates, so do it here explicitly with the IOWAIT flag
> > > > -	 * passed.
> > > > -	 */
> > > > -	if (p->in_iowait)
> > > > -		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
> > > > -
> > > 
> > > Why this io wait boost is considered as the $subject says 'aggressive'
> > > calling?
> > 
> > This will trigger a frequency update along with the iowait boost. Did I miss
> > something?
> 
> Yes, it will change CPU freq and it was the main goal for this code
> path. We have tests which check how that works on different memory
> types.
> 
> Why do you want to remove it?

It seems you missed this hunk? I of course didn't remove it altogether if
that's what you mean :)

	@@ -6772,6 +6737,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
	 enqueue_throttle:
		assert_list_leaf_cfs_rq(rq);

	+       cpufreq_update_util(rq, p->in_iowait ? SCHED_CPUFREQ_IOWAIT : 0);
	+
		hrtick_update(rq);
	 }

> 
> Did you run some tests (e.g. fio, gallery, etc) to check if you still
> have a decent performance out some new ufs/nvme memories?

PCMark storage gives

before*: 29681
after: 30014

* no patches applied including remove-margins one


Cheers

--
Qais Yousef

> 
> Beata & Dietmar have presented at LPC2021 a proposal to have a per-task
> io boost, with a bit more controllable way of the trade off power vs.
> performance [1]. IMO the io wait boost could evolve, not simply die.
> 
> Regards,
> Lukasz
> 
> [1] https://lpc.events/event/11/contributions/1042/

