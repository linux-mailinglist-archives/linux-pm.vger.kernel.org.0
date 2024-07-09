Return-Path: <linux-pm+bounces-10819-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4117692B184
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 09:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 593501C216C8
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 07:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041BD149C65;
	Tue,  9 Jul 2024 07:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IwZgr6ze"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632DBC148
	for <linux-pm@vger.kernel.org>; Tue,  9 Jul 2024 07:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720511381; cv=none; b=KYiTvlOn7i+fcSsmNERKb2Su9d7q596lMzMhph/ra4NFEs/T7g7TkfORadxLAfZmAvvGpScr6LIcvYkNP3FxqRz2r7T1UkHGylJtR98cQipfhHjaszxW4usze5Ro7Wi9D4Q2/xWg8lN5faeKxSj+eE6TGQA3sOcEMJvl85J2z9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720511381; c=relaxed/simple;
	bh=ORIDWCZW+nLVv0yi5atZdPkxAx4F0xQ2MBKeSXLwc1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hc3mQKNHY2gSPvkDfbTkxfrmnlWWGlL0WtwFMt5sZ1kkoKBBnlcMbOp1+y/DxoTnLBlrkdRGGPfrbBYSOGxtbZRM6v6UuKW+cSLuDmmvCd5U3LH/aRmRJgAjSL4VrYA+H6LbLvNBgo/25uh/TYgQg1QE6DhJBCR/4/dQTgu+SM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IwZgr6ze; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fb1c918860so38551965ad.1
        for <linux-pm@vger.kernel.org>; Tue, 09 Jul 2024 00:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720511380; x=1721116180; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S7gQvlQ7nmc33EZc3TAmGWy4QTOZnTUv37897hEicL4=;
        b=IwZgr6zeHIvBlBqaOL0cZP9tohiV3nrsP4Lkj32mDAN3ZvDN/ougRmM2EevlAzlrcs
         NpPVjm2WXorkaOVZ+Qd+Y4Inq/yIdFTatl60rlNsCJGUcbjAbhNY4K2nY8PkN+zwoJ8W
         QoLPpGxfoXn9kcJQrGf6g914J6OspIUGUHzz7X4fhNJzbMwMuWSkqYoRFIn4qOEk+0UW
         7oD07TTk4a6ckV0lWqkyv+BVqeZujhdJawI6C9BUZbZLFljKU2m/xAuRuGHibCSDJA9D
         x5zfmLtgvp9dLq7/NHuoNrgQ1eKJO0yKmvqNHRcRPP/vCWrUIrk2EJenDMngmn+1nNE/
         GoDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720511380; x=1721116180;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S7gQvlQ7nmc33EZc3TAmGWy4QTOZnTUv37897hEicL4=;
        b=WZolB3dP1HfFAfmWRRcG5mDYcbkhC6rL4oU3vP+RHpePWco4cQVYJWrrAZh6uOr7dR
         CYJEikwCaxe5mIxJCNTF59IIK4szB9Quo4vSKvBLrdr6spmgSZtrLOlUVf+YmumJjoI+
         hIgIcTiyghPH6QqeHQiCl909GYEDAb4NNQTwrvYJjuAoN7LuT/12zkhtLY9CEKuHGKnu
         AiaqT1SGkNxtbuBnQbi1OSFl3VWJ+sbZFlKbpiWji7zk5WoZuUbvfj+UvDebDY57Bu2L
         o0d0fMiDyzy28QavygSmFf+rRS4AyRVMYwUaEp7jO2HOCtmG+9VhKcaiFgbb+P0gFWsi
         HcZw==
X-Forwarded-Encrypted: i=1; AJvYcCVjgH1KOGcFqUmdagQQuCxienyh4OhAHTdGMmxaNxiDWYVhcVcLYtmB9KzaNh3myk/M6DNKEO6wOcupnQ7GqxTaXxL3Tc4qRwk=
X-Gm-Message-State: AOJu0Yy02Y4bNn6hgq5ouzQ1zlXwuT+Df4sO01IRUi2sQP5Xwlxm/+6X
	qgI5zpkzGhoxAZ7+nnOPdIy3lfky//vBtZ7MblaWIloxbJ+q9juDfjpiqyvpGRETdgn/1EulwYQ
	FwfXCN/TOZTQzV3cY8CRlvgUsUu6vg2fRxmrezg==
X-Google-Smtp-Source: AGHT+IFWbqCvJuj1LIc7RqlWDt4HZWrqbAM52x3de0fwb24xn3/Ksr8TOgjeS8qKRlF+fONP9MjMW4/IF6nKIgQmPPs=
X-Received: by 2002:a17:90a:b313:b0:2c8:f3b5:7dd1 with SMTP id
 98e67ed59e1d1-2ca3a7e6762mr2250952a91.16.1720511379662; Tue, 09 Jul 2024
 00:49:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619201409.2071728-1-qyousef@layalina.io> <f281ba07-d54a-460a-8f78-f7eb6bd8ed88@arm.com>
 <20240628015200.vw75huo53redgkzf@airbuntu> <d510f41a-1225-46d9-a2d7-ff9e6ff599d2@arm.com>
 <20240705002205.nnrgq7savzvsoqgl@airbuntu> <2e988929-142c-4e69-8e2e-2f3e64c9f08c@arm.com>
In-Reply-To: <2e988929-142c-4e69-8e2e-2f3e64c9f08c@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 9 Jul 2024 09:49:28 +0200
Message-ID: <CAKfTPtD4og8CDZzVd-=o7agcchQe8Q6GMWgiz5bDfdAepnX9Wg@mail.gmail.com>
Subject: Re: [PATCH v6] sched: Consolidate cpufreq updates
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Qais Yousef <qyousef@layalina.io>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	Christian Loehle <christian.loehle@arm.com>, Hongyan Xia <hongyan.xia2@arm.com>, 
	John Stultz <jstultz@google.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jul 2024 at 13:50, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 05/07/2024 02:22, Qais Yousef wrote:
> > On 07/04/24 12:12, Dietmar Eggemann wrote:
> >> On 28/06/2024 03:52, Qais Yousef wrote:
> >>> On 06/25/24 14:58, Dietmar Eggemann wrote:
> >>>
> >>>>> @@ -4917,6 +4927,84 @@ static inline void __balance_callbacks(struct rq *rq)
> >>>>>
> >>>>>  #endif
> >>>>>
> >>>>> +static __always_inline void
> >>>>> +__update_cpufreq_ctx_switch(struct rq *rq, struct task_struct *prev)
> >>>>> +{
> >>>>> +#ifdef CONFIG_CPU_FREQ
> >>>>> + if (prev && prev->dl.flags & SCHED_FLAG_SUGOV) {
> >>>>> +         /* Sugov just did an update, don't be too aggressive */
> >>>>> +         return;
> >>>>> + }
> >>>>> +
> >>>>> + /*
> >>>>> +  * RT and DL should always send a freq update. But we can do some
> >>>>> +  * simple checks to avoid it when we know it's not necessary.
> >>>>> +  *
> >>>>> +  * iowait_boost will always trigger a freq update too.
> >>>>> +  *
> >>>>> +  * Fair tasks will only trigger an update if the root cfs_rq has
> >>>>> +  * decayed.
> >>>>> +  *
> >>>>> +  * Everything else should do nothing.
> >>>>> +  */
> >>>>> + switch (current->policy) {
> >>>>> + case SCHED_NORMAL:
> >>>>> + case SCHED_BATCH:
> >>>>
> >>>> What about SCHED_IDLE tasks?
> >>>
> >>> I didn't think they matter from cpufreq perspective. These tasks will just run
> >>> at whatever the idle system is happen to be at and have no specific perf
> >>> requirement since they should only run when the system is idle which a recipe
> >>> for starvation anyway?
> >>
> >> Not sure we talk about the same thing here? idle_sched_class vs.
> >> SCHED_IDLE policy (FAIR task with a tiny weight of WEIGHT_IDLEPRIO).
> >
> > Yes I am referring to SCHED_IDLE policy too. What is your expectation? AFAIK
> > the goal of this policy to run when there's nothing else needs running.
>
> IMHO, SCHED_IDLE tasks fight with all the other FAIR task over the
> resource rq. I would include SCHED_IDLE into this switch statement next
> to SCHED_NORMAL and SCHED_BATCH.
> What do you do if only SCHED_IDLE FAIR tasks are runnable? They probably
> also want to have their CPU frequency needs adjusted.

I agree SCHED_IDLE means do not preempt SCHED_NORMAL and SCHED_BATCH
but not do run at a random frequency

>
> [...]
>
> >>>>> @@ -4766,11 +4738,8 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
> >>>>>            */
> >>>>>           detach_entity_load_avg(cfs_rq, se);
> >>>>>           update_tg_load_avg(cfs_rq);
> >>>>> - } else if (decayed) {
> >>>>> -         cfs_rq_util_change(cfs_rq, 0);
> >>>>> -
> >>>>> -         if (flags & UPDATE_TG)
> >>>>> -                 update_tg_load_avg(cfs_rq);
> >>>>> + } else if (cfs_rq->decayed && (flags & UPDATE_TG)) {
> >>>>> +         update_tg_load_avg(cfs_rq);
> >>>>>   }
> >>>>>  }
> >>>>
> >>>> You set cfs_rq->decayed for each taskgroup level but you only reset it
> >>>> for the root cfs_rq in __update_cpufreq_ctx_switch() and task_tick_fair()?
> >>>
> >>> Yes. We only care about using it for root level. Tracking the information at
> >>> cfs_rq level is the most natural way to do it as this is what update_load_avg()
> >>> is acting on.
> >>
> >> But IMHO this creates an issue with those non-root cfs_rq's within
> >
> > I am not seeing the issue, could you expand on what is it?
>
> I tried to explained it in the 4 lines below. With a local 'decayed'
> update_cfs_rq_load_avg() and propagate_entity_load_avg() set it every
> time update_load_avg() gets called. And this then determines whether
> update_tg_load_avg() is called on this cfs_rq later in update_load_avg().
>
> The new code:
>
>   cfs_rq->decayed |= update_cfs_rq_load_avg() (*)
>   cfs_rq->decayed |= propagate_entity_load_avg()
>
> will not reset 'cfs_rq->decayed' for non-root cfs_rq's.
>
> (*) You changed this in v3 from:
>
>   cfs_rq->decayed  = update_cfs_rq_load_avg()
>
>
> >> update_load_avg() itself. They will stay decayed after cfs_rq->decayed
> >> has been set to 1 once and will never be reset to 0. So with UPDATE_TG
> >> update_tg_load_avg() will then always be called on those non-root
> >> cfs_rq's all the time.
> >
> > We could add a check to update only the root cfs_rq. But what do we gain? Or
> > IOW, what is the harm of unconditionally updating cfs_rq->decayed given that we
> > only care about the root cfs_rq? I see more if conditions and branches which
> > I am trying to avoid.
>
> Yes, keep 'decayed' local and add a:
>
>     if (cfs_rq == &rq_of(cfs_rq)->cfs)
>         cfs_rq->decayed = decayed
>
>
>
>
>

