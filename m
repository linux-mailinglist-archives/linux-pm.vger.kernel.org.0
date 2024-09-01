Return-Path: <linux-pm+bounces-13308-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C529967B9B
	for <lists+linux-pm@lfdr.de>; Sun,  1 Sep 2024 20:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E983E281EDE
	for <lists+linux-pm@lfdr.de>; Sun,  1 Sep 2024 18:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2399F17E919;
	Sun,  1 Sep 2024 18:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="C5a7o7RK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F63827713
	for <linux-pm@vger.kernel.org>; Sun,  1 Sep 2024 18:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725213675; cv=none; b=Q205KLPCwXVj64nKmtIfFqoGQwJYLBnI3f2DbEb6oT7mlH9eIc4aLzST4DELKso1SYgVRoeCqObQisUhEyQJi73VeRwGIEu1ierLQfjy2xcGtHssmIKl13iuftHXI2ZqNoRbpLej0yiOfd9CNgKeIoUsejYoG2qUhc3vY6bopsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725213675; c=relaxed/simple;
	bh=oEo8ZMYGVwRLV4zPkeTF7nlpuqkAvjIleDFWxbKsMw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=er2x6GlY5chC/WBi0lO/hXbqpNszXzTGhzfkzYi7vry9b7yxJfSCoku2GZWndcdR4hQ4IsyNMOoWORB/P1SpKTY7SzCbmH1jUGiz6W0k2NDraZKfmGzuKGl4k48fwbff9ha2Xf27Dt1tyGPjemh+SeOw6KiNyQrfjv4iwTA01o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=C5a7o7RK; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5becd359800so3491678a12.0
        for <linux-pm@vger.kernel.org>; Sun, 01 Sep 2024 11:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1725213672; x=1725818472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mkg7uL0slKF2tnvKNsdIOWdMQ5c3Le9QMStE2DbR0pc=;
        b=C5a7o7RKEzVQmVntbFDu9WNiIxbaMYdFYg7ERH345x9NMubaf/ExvOdUUMcmlvBKJh
         Z1ncMAr3pwrQic6nGYtOoJnR8OluA3I0M3WoVO2Ahc2pvVNYwNmEt/99+0hYCFmCMDeZ
         FfcPe2FYbhbaKQaIeWn1wXP5E8rH5lkgJamgwqhpn4F+QG8uzZPXTQmXLh4Rpw6V3Pir
         kePL8CKk3zZWlwodT/OTG4JrqZ4v2p8uxb7CC90otd+DPHIoUSpAEyksCvPtrhmxp6Ul
         CtUPsgi73DgsqJQdh7xzvUSSRa+yApP9GnWL+DOQr+XcZFHE01in+5yGEf2FD3t9AnMr
         ZbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725213672; x=1725818472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkg7uL0slKF2tnvKNsdIOWdMQ5c3Le9QMStE2DbR0pc=;
        b=O6PpIULymBZ3iTFL4cG5kpE18kZ3yCjxSrrIxNX0GB0aN4FS+W7TINMpFH/qKd8gmd
         NueUdVBFhxwa6EufEmHCNTpaSN6mEuK3wnVer1+2V9+CQNW9UaKE6rZvGFeIzFDRYKbr
         z/2pJi/+5TH0GR7lRSqrKNfx/Yl/JIm1dceUq0Xa8izWrHS8HabDzwF1vS3dQ/LUPIsT
         ylpbhcWSx7IDlCpd2slsHn7dbvHPpXTlJv52R/wgopGIXA8k9cO2m7LD+zWZ4r7LF5Eo
         Te93xlyI4+eBR4OoiekWWNm1k63KyCtG/690vjIZvuQMO9w0W7RQ3HDo2VRplfrIN/tI
         Zq6A==
X-Forwarded-Encrypted: i=1; AJvYcCWXbS24KS8Hwk9yXFA34gRdsdVYiFtZEol5tv7j59Ib6KdEHxWVCUQyW/yyCiisedUfCJG2MarOwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQQqDAku0+WdPvB6AYSo7pEnMqBFDmIuH3mOgB2OIlYH65RUqd
	FrYNvUcRIRAvXlWFgzp6m0KuQgRFltVn6Ys6llpqyPk+eaNwtLEplxezdbCslhY=
X-Google-Smtp-Source: AGHT+IGT5AyPhsmzSXVOxiitmS907DPKxIB7vmU+zeTaBmXmrVB48INX2SRDNaz9lLzb0C0ONDQnKA==
X-Received: by 2002:a05:6402:449a:b0:5be:e01c:6b5e with SMTP id 4fb4d7f45d1cf-5c243781e24mr2819633a12.35.1725213671783;
        Sun, 01 Sep 2024 11:01:11 -0700 (PDT)
Received: from airbuntu ([176.29.222.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c6a3easm4320678a12.6.2024.09.01.11.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 11:01:11 -0700 (PDT)
Date: Sun, 1 Sep 2024 19:01:09 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Hongyan Xia <hongyan.xia2@arm.com>,
	John Stultz <jstultz@google.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] sched: Consolidate cpufreq updates
Message-ID: <20240901180109.bqcgujqpdjsult5i@airbuntu>
References: <20240728184551.42133-1-qyousef@layalina.io>
 <CAKfTPtBxFTxZQT=w6iexLEciHD736+ubLOd_PJnvXge09h-rXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtBxFTxZQT=w6iexLEciHD736+ubLOd_PJnvXge09h-rXw@mail.gmail.com>

On 08/13/24 12:02, Vincent Guittot wrote:
> >  void wakeup_preempt(struct rq *rq, struct task_struct *p, int flags)
> > @@ -4913,6 +4923,93 @@ static inline void __balance_callbacks(struct rq *rq)
> >
> >  #endif
> >
> > +static __always_inline void
> > +__update_cpufreq_ctx_switch(struct rq *rq, struct task_struct *prev)
> > +{
> > +#ifdef CONFIG_CPU_FREQ
> > +       if (prev && prev->dl.flags & SCHED_FLAG_SUGOV) {
> > +               /* Sugov just did an update, don't be too aggressive */
> > +               return;
> > +       }
> > +
> > +       /*
> > +        * RT and DL should always send a freq update. But we can do some
> > +        * simple checks to avoid it when we know it's not necessary.
> > +        *
> > +        * iowait_boost will always trigger a freq update too.
> > +        *
> > +        * Fair tasks will only trigger an update if the root cfs_rq has
> > +        * decayed.
> > +        *
> > +        * Everything else should do nothing.
> > +        */
> > +       switch (current->policy) {
> > +       case SCHED_NORMAL:
> > +       case SCHED_BATCH:
> > +       case SCHED_IDLE:
> > +               if (unlikely(current->in_iowait)) {
> > +                       cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT | SCHED_CPUFREQ_FORCE_UPDATE);
> > +                       return;
> > +               }
> > +
> > +#ifdef CONFIG_SMP
> > +               /*
> > +                * Send an update if we switched from RT or DL as they tend to
> > +                * boost the CPU and we are likely able to reduce the freq now.
> > +                */
> > +               rq->cfs.decayed |= prev && (rt_policy(prev->policy) || dl_policy(prev->policy));
> > +
> > +               if (unlikely(rq->cfs.decayed)) {
> 
> My previous use case of a task non preempting current with large
> util_est is fixed with this version but I'm facing a new one a bit
> similar because of waiting for the context switch and the decay to try
> to update the frequency.
> 
> When the task wakes up on an idle cpu, you wait for the decay to
> update the freq but if the freq is low and the pelt has been updated
> recently (less than 1024us) you can wait a long time before the next
> decay and the freq update. This is a problem if the task's util_est is
> large because you can stay several ms at low frequency before taking
> into account task's util_est

It is a symptom of the same problem. It seems we don't decay and we omit the
cpufreq update.

Why this was not a problem before? AFAICT we only send an update before my
patch if we had a decay and I didn't change this condition. Were we just
getting more lucky or did I change some behavior unwittingly?

The problem with my patch is that I do this unconditional only if we failed
preemption check. But looks like I must enforce a cpufreq update after every
enqueue. I think the overhead of not checking rq->cfs.decayed would be high if
we always call a cpufreq update.

I'll just set rq->cfs.decayaed in util_est_enqueue() which should address both
use cases.

Thanks!

