Return-Path: <linux-pm+bounces-107-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8E97F598F
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 08:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54D142816B9
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 07:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B1718637;
	Thu, 23 Nov 2023 07:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d0Vbu6y0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE887E7
	for <linux-pm@vger.kernel.org>; Wed, 22 Nov 2023 23:47:53 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2802b744e52so1279984a91.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Nov 2023 23:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700725673; x=1701330473; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2tnacSsEzYa51ZlaGyK1ojaRlmZcj0/ixkOd70T8dg=;
        b=d0Vbu6y0PEw2LZNM9GP05slLpLb4Y5WYnlL/fyUGpX1vmD5SdAnGitR8MpuARcBhOE
         +8981knXr0OtnpmBm536/+fBXaWVIVa3VkI7l0aJfbh+EZnhMlHun26Sh9yq5L4XcRCI
         yOg8bGn8rEP2p5qY9sGkAE/ZE5G++s2Jra1NCB94t8WlCwJT8Dxa2VKVBRavK3zXu8mm
         qjE6k7J2kVimcokbl+Zs3e+2o3O7aLtqnZeaO5WB4SNh84oqMsjydmFAji45TV2pCRCK
         M7wxIZj94BZ1VEAcpVZmjgaKOcmTJOhrYFX7A6DTdnWRk3gjRjSolZXtZgsvsOy//hTg
         mbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700725673; x=1701330473;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q2tnacSsEzYa51ZlaGyK1ojaRlmZcj0/ixkOd70T8dg=;
        b=NV18c/rrgjqgU8OpiGoARUkgGtcz6vT0dUloVNpWO54IHeCUjVyavIYATNHpIVgo3I
         MZ5jkAy9Gqjf+PhCkn1C7aulDmiGZTMLHYoFxlXJlIJdPa02VzHuzeWahqjm2x+Q7Twx
         LcInfXHzUxHle3q1Rh4DH9p2POIJRf5fovaMw/9MomGbpHtzAZcjSxpx0EobZ7+IAWYD
         VACyYclfQE528rj0r0aUMdAt6xxvOE+aAe2Zh5u4BFr0a4H8nQMOAro48wRqTVVuC3zd
         KUlCEkRsGsnfQUtihtu0CvWJoatHSm4wOID/i3Pxp2h7rHLAd7vxdlcx6ghPVNsLmvMw
         YHHg==
X-Gm-Message-State: AOJu0YyIwjP3HLjMax7esWaheghks5mJ68i1CkcADzkrvJ/VP0Acs0z+
	DhOyCIWnqXlmMK7+Sj2AMntf5tnUsbgDKEDyLAGRGA==
X-Google-Smtp-Source: AGHT+IGkk8ZRZsV1LXij5Bfg7YKfFMnZXaF6Ux0a2LIY47nYfss1C6+eIsNNiH3HE53PQrtjwzilEAq4XhkHK9gaSbA=
X-Received: by 2002:a17:90a:dc08:b0:285:6622:ed1 with SMTP id
 i8-20020a17090adc0800b0028566220ed1mr1217400pjv.10.1700725673299; Wed, 22 Nov
 2023 23:47:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103131821.1176294-1-vincent.guittot@linaro.org>
 <20231103131821.1176294-2-vincent.guittot@linaro.org> <20231114205422.k5m6y4m5vnw7dvzj@airbuntu>
 <CAKfTPtDMEes6V2xRHavAwWrVuiZBdFAsaaxv9=-psAZCTPQWKg@mail.gmail.com> <20231121211725.gaekv6svnqdiq5l4@airbuntu>
In-Reply-To: <20231121211725.gaekv6svnqdiq5l4@airbuntu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 23 Nov 2023 08:47:42 +0100
Message-ID: <CAKfTPtDzAZMcuWOYYOOAjCyvrOQiqyHZJBFVbACAvTqo+pU1gQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] sched/schedutil: Rework performance estimation
To: Qais Yousef <qyousef@layalina.io>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, rafael@kernel.org, 
	viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, lukasz.luba@arm.com, wyes.karny@amd.com, 
	beata.michalska@arm.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Nov 2023 at 23:01, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 11/22/23 08:38, Vincent Guittot wrote:
>
> > > > +unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
> > > > +                              unsigned long min,
> > > > +                              unsigned long max)
> > > > +{
> > > > +     struct rq *rq = cpu_rq(cpu);
> > > > +
> > > > +     if (rt_rq_is_runnable(&rq->rt))
> > > > +             return max;
> > >
> > > I think this breaks old behavior. When uclamp_is_used() the frequency of the RT
> > > task is determined by uclamp_min; but you revert this to the old behavior where
> > > we always return max, no? You should check for !uclamp_is_used(); otherwise let
> > > the rest of the function exec as usual.
> >
> > Yes, I made a shortcut assuming that max would be adjusted to the max
> > allowed freq for RT task whereas it's the min freq that is adjusted by
> > uclamp and that should also be adjusted without uclamp. Let me fix
> > that in effective_cpu_util and remove this early return from
> > sugov_effective_cpu_perf()
>
> +1
>
> > > Can we rename this function please? It is not mapping anything, but applying
> > > a dvfs headroom (I suggest apply_dvfs_headroom()). Which would make the comment
> > > also unnecessary ;-)
> >
> > I didn't want to add unnecessary renaming which often confuses
> > reviewers so I kept  the current function name. But this can the be
> > rename in a follow up patch
>
> Okay.
>
> > > >  static void sugov_get_util(struct sugov_cpu *sg_cpu)
> > > >  {
> > > > -     unsigned long util = cpu_util_cfs_boost(sg_cpu->cpu);
> > > > -     struct rq *rq = cpu_rq(sg_cpu->cpu);
> > > > +     unsigned long min, max, util = cpu_util_cfs_boost(sg_cpu->cpu);
> > > >
> > > > -     sg_cpu->bw_dl = cpu_bw_dl(rq);
> > > > -     sg_cpu->util = effective_cpu_util(sg_cpu->cpu, util,
> > > > -                                       FREQUENCY_UTIL, NULL);
> > > > +     util = effective_cpu_util(sg_cpu->cpu, util, &min, &max);
> > > > +     sg_cpu->bw_min = map_util_perf(min);
> > >
> > > Hmm. I don't think we need to apply_dvfs_headroom() to min here. What's the
> > > rationale to give headroom for min perf requirement? I think the headroom is
> > > only required for actual util.
> >
> > This headroom only applies for bw_min that is used with
> > cpufreq_driver_adjust_perf(). Currently it only takes cpu_bw_dl()
>
> It is also used in ignore_dl_rate_limit() - which is the user that caught my
> eyes more.
>
> I have to admit, I always get caught out with the new adjust_perf stuff. The
> down side of working on older LTS kernels for prolonged time :p
>
> > which seems too low because IRQ can preempt DL. So I added the average
> > irq utilization into bw_min which is only an estimate and needs some
> > headroom. That being said I can probably stay with current behavior
> > for now and remove headroom
>
> I think this is more logical IMHO. DL should never need any headroom. And irq
> needing headroom is questionable everytime I think about it. Does an irq storm
> need a dvfs headroom? I don't think it's a clear cut answer, but I tend towards
> no.
>
> > > And is it right to mix irq and uclamp_min with bw_min which is for DL? We might
> >
> > cpu_bw_dl() is not the actual utilization by DL task but the computed
> > bandwidth which can be seen as min performance level
>
> Yep. That's why I am not in favour of a dvfs headroom for DL.
>
> But what I meant here is that in effective_cpu_util(), where we populate min
> and max we have
>
>         if (min) {
>                 /*
>                  * The minimum utilization returns the highest level between:
>                  * - the computed DL bandwidth needed with the irq pressure which
>                  *   steals time to the deadline task.
>                  * - The minimum performance requirement for CFS and/or RT.
>                  */
>                 *min = max(irq + cpu_bw_dl(rq), uclamp_rq_get(rq, UCLAMP_MIN));
>
> So if there was an RT/CFS task requesting a UCLAMP_MIN of 1024 for example,
> bw_min will end up being too high, no?

But at the end, we want at least uclamp_min for cfs or rt just like we
want at least DL bandwidth for DL tasks

>
> Should we add another arg to sugov_effective_cpu_perf() to populate bw_min too
> for the single user who wants it?
>
>
> Thanks!
>
> --
> Qais Yousef

