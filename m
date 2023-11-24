Return-Path: <linux-pm+bounces-173-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C687F7361
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 13:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B98701C20862
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 12:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952F320324;
	Fri, 24 Nov 2023 12:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MfE8dzLZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1282D69
	for <linux-pm@vger.kernel.org>; Fri, 24 Nov 2023 04:05:04 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2839c113cbcso1412936a91.3
        for <linux-pm@vger.kernel.org>; Fri, 24 Nov 2023 04:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700827504; x=1701432304; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wjNxGhDjeKHr8F+xhjRBHs3YO4GliXKBdRwWaSk3GKU=;
        b=MfE8dzLZQcG1CRnGxbR8zziMX2mT5XCZGDQgRQB3U/IylnJ+su4WeHQn9g/IYFjMoi
         BC6lb2rgAdCN09fU8Z9e6o34e0Pp0z7maYJIv4A0e1GN8tTzgKyThWSaSXieATG6BWo0
         W4b9B3hHjqgGvb0UcidkQBvSSZsfVc7FAM98GRVqxW98UyZxh/a9M+pbGbNgGOHvCVTe
         jCPIG5UZUPpggMXlSTs+Jdy7lYeh0vCfqMYPnHT/7d+HM9m5qSsp1JxSKxlX44lmy8gp
         rU7Y7MXR0KO2BluYpCJXHUZubcVPkq5/B5i0G29V8XjW074Ix2aEI4c3Wkb55q76YPeX
         nj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700827504; x=1701432304;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wjNxGhDjeKHr8F+xhjRBHs3YO4GliXKBdRwWaSk3GKU=;
        b=NVmhQKO9TOSJn8dmjWot0EIOwiJTU1CDNcKS+Pa0vik7R/Sp0bXdTWwyYRHjfa7HI6
         WFlfrJIXNTv2569rt7a87xGJWKaP03IAbBv5v7jrBVM8GXdtIL5nV17pPoo5O03TvgE0
         EiZMmcOvPcnCicLimB3dPewZSrcCrML7wBVRwX8PH/J7QASATS7Qzo4sAIvYu+rokKiJ
         I4s0YoykNKLBHatSOuaQoP0l4dJ/zeoDpEB3Cp6gF+UiApNHBRwh3IE8X+OKwcr4md9P
         M7UdjAE2HacoiQ7eDY3Zl85U8a6IP8HfqUT3rgTLLSP6X/R0mhoZojsKg15HtzQZwrTU
         itig==
X-Gm-Message-State: AOJu0Yx8hF6wFzS//ocRZx5ZsRqliduMIZvIDzR+T+drVVivTIxDp0Gq
	pF777oZuQfWg8ION8HLBZA+duFTXBrlKky5AaapkrQ==
X-Google-Smtp-Source: AGHT+IGfI00XUBg9W37CEeOxcztc7n4FsUxF8vdKml0nObvAljFCEHzKMeMA5CxV/dmnrjuRxI47Mlkt+955LYAWVOQ=
X-Received: by 2002:a17:90b:4f4d:b0:285:24bb:457c with SMTP id
 pj13-20020a17090b4f4d00b0028524bb457cmr2934120pjb.26.1700827504096; Fri, 24
 Nov 2023 04:05:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122140119.472110-1-vincent.guittot@linaro.org> <4a005396-46fd-443c-be15-6fe0e2a1dea5@arm.com>
In-Reply-To: <4a005396-46fd-443c-be15-6fe0e2a1dea5@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 24 Nov 2023 13:04:51 +0100
Message-ID: <CAKfTPtCAZWp7tRgTpwJmyEAkyN65acmYrfu9naEUpBZVWNTcQA@mail.gmail.com>
Subject: Re: [PATCH] sched/pelt: avoid underestimate of task utilization
To: Hongyan Xia <hongyan.xia2@arm.com>
Cc: lukasz.luba@arm.com, mingo@redhat.com, mgorman@suse.de, 
	rostedt@goodmis.org, bristot@redhat.com, peterz@infradead.org, 
	rafael@kernel.org, vschneid@redhat.com, dietmar.eggemann@arm.com, 
	juri.lelli@redhat.com, bsegall@google.com, qyousef@layalina.io, 
	viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 24 Nov 2023 at 11:44, Hongyan Xia <hongyan.xia2@arm.com> wrote:
>
> On 22/11/2023 14:01, Vincent Guittot wrote:
> > [...]
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 07f555857698..eeb505d28905 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4774,6 +4774,11 @@ static inline unsigned long task_util(struct task_struct *p)
> >       return READ_ONCE(p->se.avg.util_avg);
> >   }
> >
> > +static inline unsigned long task_runnable(struct task_struct *p)
> > +{
> > +     return READ_ONCE(p->se.avg.runnable_avg);
> > +}
> > +
> >   static inline unsigned long _task_util_est(struct task_struct *p)
> >   {
> >       struct util_est ue = READ_ONCE(p->se.avg.util_est);
> > @@ -4892,6 +4897,14 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
> >       if (task_util(p) > arch_scale_cpu_capacity(cpu_of(rq_of(cfs_rq))))
> >               return;
> >
> > +     /*
> > +      * To avoid underestimate of task utilization, skip updates of ewma if
> > +      * we cannot grant that thread got all CPU time it wanted.
> > +      */
> > +     if ((ue.enqueued + UTIL_EST_MARGIN) < task_runnable(p))
> > +             goto done;
> > +
> > +
>
> Actually, does this also skip util_est increases as well, assuming no
> FASTUP? When a task is ramping up, another task could join and then
> blocks this task from ramping up its util_est.
>
> Or do we think this is intended behavior for !FASTUP?

sched_feat(UTIL_EST_FASTUP) has been there to disable faster ramp up
in case of regression but I'm not aware of anybody having to disable
it during the last 3 year so we should just delete the sched_feat()
and make faster ramp up  permanent.

>
> >       /*
> >        * Update Task's estimated utilization
> >        *

