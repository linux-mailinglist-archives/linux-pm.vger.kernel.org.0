Return-Path: <linux-pm+bounces-101-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 608067F52EC
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 23:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 922611C20AF0
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 22:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9611D6A7;
	Wed, 22 Nov 2023 22:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="CUUhkC3a"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F46010C
	for <linux-pm@vger.kernel.org>; Wed, 22 Nov 2023 14:01:22 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4094301d505so1305255e9.2
        for <linux-pm@vger.kernel.org>; Wed, 22 Nov 2023 14:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1700690480; x=1701295280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Co9LVBS9UVls7Yfkp1g/G/0zm2miePVKqu+VmR9GULg=;
        b=CUUhkC3aCNRMDb7cJsp1Oyp8W6ggrDS9JgXsHVHKqv+tKKoOTr8pcHEK8//WWQUhrU
         /YVjA70bMuYOW30W9zyOc+nXyCwfiIF8New3QYQz6Ge3DhwEe4c+kMxFQNks1ip7SAz4
         zRW3rJRKomcseyprsbdRPDE/0bCDSX5am7pztquxlUMPjqLTor0OC7Uc+t6ZsbUbz2wL
         giV44mkKIaHH9Il5jSLgAni47wYvwJuXIBba4eAGl8rmidmvszjuBiMdKZpiuSfP5PNs
         ymoOO3Il3fZ9WvxZ9uITDn4+IRUq4x/zMu2yJHKlHy1U/NVA9XcZWO3DPAOmPMY5AU2+
         iGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700690480; x=1701295280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Co9LVBS9UVls7Yfkp1g/G/0zm2miePVKqu+VmR9GULg=;
        b=RuKH2d/s8wEVBjoPMJro0HlhDTcNDSEl6mz43zRCMoBBO+zCb9BifBDNJZByUhdSW8
         BPVHMynxFLaSQ8QPIMiEOwQFTM6WsZjRD/p5U2w35TeQdLL6wGy2RIbQyQB3zb8YDs7v
         Vyo85L+dQOVyCLmPeOX9RStPmDk5o9zf6xYTi/tHg+eJwY0ezzOHLIsCAthUn6zH5YUm
         6tKtlIYdcKuMp2sCNzHRRoFqAzVAvo+kJY+5/LoklsmdnFENZbqiGMr84PMVKdQSkxGi
         M3wFz/5UaZ0iHzceDEDf4mFyHHd3iQ9JHGZfKbsxk1wVe0x/O1zRbkKeVdWPT7GAz9JW
         yuvA==
X-Gm-Message-State: AOJu0YwCnl+FAEQBpwGOzFYuhu2zwfrgQXIvvsEnY8sURTHSqpVIUSyT
	uWFWLOipEFhclbehA1ffpIbXXA==
X-Google-Smtp-Source: AGHT+IH4rB5Gnc+aWlXBbdw4olewehGSvln615Pk9fVGk663855Rnwjbt7cGY19KNvWtTEqtko92WA==
X-Received: by 2002:a05:600c:4514:b0:409:787b:5ab5 with SMTP id t20-20020a05600c451400b00409787b5ab5mr2834278wmo.23.1700690480328;
        Wed, 22 Nov 2023 14:01:20 -0800 (PST)
Received: from airbuntu (host109-151-228-202.range109-151.btcentralplus.com. [109.151.228.202])
        by smtp.gmail.com with ESMTPSA id u11-20020a05600c19cb00b0040a507f546fsm709634wmq.8.2023.11.22.14.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 14:01:19 -0800 (PST)
Date: Tue, 21 Nov 2023 21:17:25 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	rafael@kernel.org, viresh.kumar@linaro.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	lukasz.luba@arm.com, wyes.karny@amd.com, beata.michalska@arm.com
Subject: Re: [PATCH v3 1/2] sched/schedutil: Rework performance estimation
Message-ID: <20231121211725.gaekv6svnqdiq5l4@airbuntu>
References: <20231103131821.1176294-1-vincent.guittot@linaro.org>
 <20231103131821.1176294-2-vincent.guittot@linaro.org>
 <20231114205422.k5m6y4m5vnw7dvzj@airbuntu>
 <CAKfTPtDMEes6V2xRHavAwWrVuiZBdFAsaaxv9=-psAZCTPQWKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtDMEes6V2xRHavAwWrVuiZBdFAsaaxv9=-psAZCTPQWKg@mail.gmail.com>

On 11/22/23 08:38, Vincent Guittot wrote:

> > > +unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
> > > +                              unsigned long min,
> > > +                              unsigned long max)
> > > +{
> > > +     struct rq *rq = cpu_rq(cpu);
> > > +
> > > +     if (rt_rq_is_runnable(&rq->rt))
> > > +             return max;
> >
> > I think this breaks old behavior. When uclamp_is_used() the frequency of the RT
> > task is determined by uclamp_min; but you revert this to the old behavior where
> > we always return max, no? You should check for !uclamp_is_used(); otherwise let
> > the rest of the function exec as usual.
> 
> Yes, I made a shortcut assuming that max would be adjusted to the max
> allowed freq for RT task whereas it's the min freq that is adjusted by
> uclamp and that should also be adjusted without uclamp. Let me fix
> that in effective_cpu_util and remove this early return from
> sugov_effective_cpu_perf()

+1

> > Can we rename this function please? It is not mapping anything, but applying
> > a dvfs headroom (I suggest apply_dvfs_headroom()). Which would make the comment
> > also unnecessary ;-)
> 
> I didn't want to add unnecessary renaming which often confuses
> reviewers so I kept  the current function name. But this can the be
> rename in a follow up patch

Okay.

> > >  static void sugov_get_util(struct sugov_cpu *sg_cpu)
> > >  {
> > > -     unsigned long util = cpu_util_cfs_boost(sg_cpu->cpu);
> > > -     struct rq *rq = cpu_rq(sg_cpu->cpu);
> > > +     unsigned long min, max, util = cpu_util_cfs_boost(sg_cpu->cpu);
> > >
> > > -     sg_cpu->bw_dl = cpu_bw_dl(rq);
> > > -     sg_cpu->util = effective_cpu_util(sg_cpu->cpu, util,
> > > -                                       FREQUENCY_UTIL, NULL);
> > > +     util = effective_cpu_util(sg_cpu->cpu, util, &min, &max);
> > > +     sg_cpu->bw_min = map_util_perf(min);
> >
> > Hmm. I don't think we need to apply_dvfs_headroom() to min here. What's the
> > rationale to give headroom for min perf requirement? I think the headroom is
> > only required for actual util.
> 
> This headroom only applies for bw_min that is used with
> cpufreq_driver_adjust_perf(). Currently it only takes cpu_bw_dl()

It is also used in ignore_dl_rate_limit() - which is the user that caught my
eyes more.

I have to admit, I always get caught out with the new adjust_perf stuff. The
down side of working on older LTS kernels for prolonged time :p

> which seems too low because IRQ can preempt DL. So I added the average
> irq utilization into bw_min which is only an estimate and needs some
> headroom. That being said I can probably stay with current behavior
> for now and remove headroom

I think this is more logical IMHO. DL should never need any headroom. And irq
needing headroom is questionable everytime I think about it. Does an irq storm
need a dvfs headroom? I don't think it's a clear cut answer, but I tend towards
no.

> > And is it right to mix irq and uclamp_min with bw_min which is for DL? We might
> 
> cpu_bw_dl() is not the actual utilization by DL task but the computed
> bandwidth which can be seen as min performance level

Yep. That's why I am not in favour of a dvfs headroom for DL.

But what I meant here is that in effective_cpu_util(), where we populate min
and max we have

	if (min) {
	        /*
	         * The minimum utilization returns the highest level between:
	         * - the computed DL bandwidth needed with the irq pressure which
	         *   steals time to the deadline task.
	         * - The minimum performance requirement for CFS and/or RT.
	         */
	        *min = max(irq + cpu_bw_dl(rq), uclamp_rq_get(rq, UCLAMP_MIN));

So if there was an RT/CFS task requesting a UCLAMP_MIN of 1024 for example,
bw_min will end up being too high, no?

Should we add another arg to sugov_effective_cpu_perf() to populate bw_min too
for the single user who wants it?


Thanks!

--
Qais Yousef

