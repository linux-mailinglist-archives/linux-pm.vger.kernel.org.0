Return-Path: <linux-pm+bounces-13420-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5C2969E4F
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 14:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 334BA287FA2
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 12:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D521CA6A3;
	Tue,  3 Sep 2024 12:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZhEJafBA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FB51CA687
	for <linux-pm@vger.kernel.org>; Tue,  3 Sep 2024 12:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725367725; cv=none; b=YnCs52mD6F52rix7k6OdZTC8fsmqVdzUv2KSlCDcKZiasyxTep7LC+9ELudMzMsGqGS+yF3eNXcWJWgowdi55/xrD1SV1CiMIOOJ08ij9FAjUJstRIc8362n0josGR6DpJSfV4HeQ5GQ3gNQTqodqY45Op+6U8ZlP4n0ImF7mJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725367725; c=relaxed/simple;
	bh=sAx+Uc/fmfmW8W3oB3SyU8lQhPLkmf/xd9J+I9e1tIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TZ/zuSHv9Mzd59u/QC1LuppEgLdWaaBT7jOjbJpPiOmlOwIcbU6xl8bzVmh5P6P/j6aFMipXVTrApeV+Wy3Fi9VJb+HOo5jwho8HmIqfOclTSVGpYs2Ek7+Ytt83VGVyyz+0xxEC5lsNQWb+2yqH+U1laNYkYHV+Z2GzMQLpTC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZhEJafBA; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2059112f0a7so13758825ad.3
        for <linux-pm@vger.kernel.org>; Tue, 03 Sep 2024 05:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725367723; x=1725972523; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HZZH1YqkOpH09mugMgFcfroQPHP+w3Y22Xtsixkm+tk=;
        b=ZhEJafBA84SzcPlJYFNmRpNj7TMsftEvBq9CoD62JIEEC5loJ29UHSzR1KYq5rtZI5
         vTaTaR+Y/cZZkRggdJ/8rDHV+oVcgW0NeygItStYY0BRFMNm5Xs+fINEdan0LFEi+3fL
         8pJkTAoXCZtCgaGya/Nj8YaGiY1qyZPNw7V/UEWsDFKrWpmqjEwvsxbiVJg0B2XPywyQ
         dKxk0Ni+8pTLV91U6g2acQoBLKaP8NECP2tZ+4C6Rx3eUvi/rOqBOi67wclsb/Wi03m/
         DiHy1GG2OHw7guLPWOrG/yO4Y6b8U8cUO5/u01eJmUCf/K7OWpImcpLR8R6/0DW09KqD
         TeMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725367723; x=1725972523;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HZZH1YqkOpH09mugMgFcfroQPHP+w3Y22Xtsixkm+tk=;
        b=WyO4D2hzwhGMkgimO9YAHuKQs+iBTDeR/E7VHwEYuxXFWL/wDNjT/CUuW8Yamuy+OC
         x+SzIZxjPL5kR+ONYOugBa8DWaFXih5/L76WOJqcZOmYiDMlNbPNTYlLvz3rL3R03m2X
         sSUlS37mZ61aRAgB9lIQ71avyJvXfvFHd7/XQE1QlTpW8XknyWAKyfMA/pjs5+cilutm
         ylfvMWjhSgHx0CNJGmQtAHsaoLSHdSAuWsrQIHsrqTH4Qs8fG9de8Nfb7A5XwN42r6RS
         PdNbr9BpMq7td9g7kD1fQ7mhB05Low69dsh/aWGOyLUHw2BoYn7cLZWHnhIrI+Gz4+0h
         XDtg==
X-Forwarded-Encrypted: i=1; AJvYcCXBGZQ+9dR2Wz5oYj3sdYZLrTaOkj7Xk9E5VJV/CNFCcD5YACovtg6DYUMmfRGh0ImJgpe3PJKLYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxwoEa5GZJrR39TvaWKuo4HtKc3JwzAKOdVRxDU0IuazEZ/BfEP
	70xS/AbfGTFf+qG5n+tl8p4XQ/nXEaD1m7Omlg/YBYpT770CGkKzzbJ9BTjhChasqfBjA/lhrWp
	DPbRjnMG9I3zMzBWmiXcKHJQhO414QBSQZdjTBw==
X-Google-Smtp-Source: AGHT+IG8GSALtD4HNlPBTo4AnbCT7xBd3i5CBDh3kwgJfM8Pd+mjTIUNWIuKcS1euhjl5D1F5YDoKkiBRutyHk3K230=
X-Received: by 2002:a17:902:e848:b0:206:9ab3:2ec1 with SMTP id
 d9443c01a7336-2069ab336f0mr22068835ad.22.1725367723430; Tue, 03 Sep 2024
 05:48:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240728184551.42133-1-qyousef@layalina.io> <CAKfTPtBxFTxZQT=w6iexLEciHD736+ubLOd_PJnvXge09h-rXw@mail.gmail.com>
 <20240901180109.bqcgujqpdjsult5i@airbuntu>
In-Reply-To: <20240901180109.bqcgujqpdjsult5i@airbuntu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 3 Sep 2024 14:48:32 +0200
Message-ID: <CAKfTPtB1LFQF3kCQ67-5cu-eABbuWR19FC6sTnnPVane4D+EAA@mail.gmail.com>
Subject: Re: [PATCH v7] sched: Consolidate cpufreq updates
To: Qais Yousef <qyousef@layalina.io>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
	Christian Loehle <christian.loehle@arm.com>, Hongyan Xia <hongyan.xia2@arm.com>, 
	John Stultz <jstultz@google.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 1 Sept 2024 at 20:01, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 08/13/24 12:02, Vincent Guittot wrote:
> > >  void wakeup_preempt(struct rq *rq, struct task_struct *p, int flags)
> > > @@ -4913,6 +4923,93 @@ static inline void __balance_callbacks(struct rq *rq)
> > >
> > >  #endif
> > >
> > > +static __always_inline void
> > > +__update_cpufreq_ctx_switch(struct rq *rq, struct task_struct *prev)
> > > +{
> > > +#ifdef CONFIG_CPU_FREQ
> > > +       if (prev && prev->dl.flags & SCHED_FLAG_SUGOV) {
> > > +               /* Sugov just did an update, don't be too aggressive */
> > > +               return;
> > > +       }
> > > +
> > > +       /*
> > > +        * RT and DL should always send a freq update. But we can do some
> > > +        * simple checks to avoid it when we know it's not necessary.
> > > +        *
> > > +        * iowait_boost will always trigger a freq update too.
> > > +        *
> > > +        * Fair tasks will only trigger an update if the root cfs_rq has
> > > +        * decayed.
> > > +        *
> > > +        * Everything else should do nothing.
> > > +        */
> > > +       switch (current->policy) {
> > > +       case SCHED_NORMAL:
> > > +       case SCHED_BATCH:
> > > +       case SCHED_IDLE:
> > > +               if (unlikely(current->in_iowait)) {
> > > +                       cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT | SCHED_CPUFREQ_FORCE_UPDATE);
> > > +                       return;
> > > +               }
> > > +
> > > +#ifdef CONFIG_SMP
> > > +               /*
> > > +                * Send an update if we switched from RT or DL as they tend to
> > > +                * boost the CPU and we are likely able to reduce the freq now.
> > > +                */
> > > +               rq->cfs.decayed |= prev && (rt_policy(prev->policy) || dl_policy(prev->policy));
> > > +
> > > +               if (unlikely(rq->cfs.decayed)) {
> >
> > My previous use case of a task non preempting current with large
> > util_est is fixed with this version but I'm facing a new one a bit
> > similar because of waiting for the context switch and the decay to try
> > to update the frequency.
> >
> > When the task wakes up on an idle cpu, you wait for the decay to
> > update the freq but if the freq is low and the pelt has been updated
> > recently (less than 1024us) you can wait a long time before the next
> > decay and the freq update. This is a problem if the task's util_est is
> > large because you can stay several ms at low frequency before taking
> > into account task's util_est
>
> It is a symptom of the same problem. It seems we don't decay and we omit the
> cpufreq update.
>
> Why this was not a problem before? AFAICT we only send an update before my
> patch if we had a decay and I didn't change this condition. Were we just
> getting more lucky or did I change some behavior unwittingly?

I'm not able to reproduce this behavior with current code but I don't
know why the behavior is different to be honest

>
> The problem with my patch is that I do this unconditional only if we failed
> preemption check. But looks like I must enforce a cpufreq update after every
> enqueue. I think the overhead of not checking rq->cfs.decayed would be high if
> we always call a cpufreq update.
>
> I'll just set rq->cfs.decayaed in util_est_enqueue() which should address both
> use cases.
>
> Thanks!

