Return-Path: <linux-pm+bounces-3337-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D74D848D29
	for <lists+linux-pm@lfdr.de>; Sun,  4 Feb 2024 12:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FE99B21B17
	for <lists+linux-pm@lfdr.de>; Sun,  4 Feb 2024 11:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DC721A1C;
	Sun,  4 Feb 2024 11:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IJ+OQIem"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6641A708
	for <linux-pm@vger.kernel.org>; Sun,  4 Feb 2024 11:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707046371; cv=none; b=gF0Wyyry/2xp+7uRaf1dG+j5IVAvnaA8vFLGEIBqleh4zPI1bIHx4Aj8Rrej8hfmrKTzLCIPdZ2R+ndq1OSi4p7i48HcR6odI/16IhdUj9XfgSvznuD2XTw+UAcgcwyywL/G87CvNuRDb2xiJPekfOdxxBNuOYeleCFzEkVX3q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707046371; c=relaxed/simple;
	bh=dtJJMeLuY0bUbyEmCpnifVzW91I/05i2WH+f3om8AVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gQFdiYarCXyk+R0U004ZdnqJ+V0gyG1aytMZ8/M0wUIHhh8qftalrZL45I9/kPnyRBAMOM0hUht2s3MACtkt8tT30Qs0IFamlrHo1h1YL1odFmn/SDPa8wenEcpNtvak1ix2pyAdRyVNIOfn+0Ggv0mJBCd/EE3+A42KD1Bc21E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IJ+OQIem; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-295ff33ae32so2947036a91.2
        for <linux-pm@vger.kernel.org>; Sun, 04 Feb 2024 03:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707046369; x=1707651169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2rNtFddvkApJpasULvwKrDNjZfPFrzhjGQ7pCq+oMU=;
        b=IJ+OQIem6+tq2AhYn6wcoIbfTABfo5BfOb0W5A0jv798UOlaGKpnv1ki6M/crWvpry
         7Gxp8RS8gtskdIdv6VTBZMLTFqYD+etT+msrVlaZANzN4Fe8TgdRc6ifpXjflpHaDlQx
         ra4Bx1GcMCdWKYKxD4bit24v+bdVL6xhYk5Ep4tyZ8GhDLLeZAzZ69fCCiusN5au4dpV
         Pmwzh1ShCVijUHU1bNfCbPFvLbMKJYemkQxqok5vKUIutG2Y6ftN//w3PTlSE4pcgK4W
         ZGjLM8wBjR2bgTO7kOItPKJ/L8dwN0DZaHgWiZEfDFR9vVJHgR4PU8e0jaELwUC3ghRu
         nb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707046369; x=1707651169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2rNtFddvkApJpasULvwKrDNjZfPFrzhjGQ7pCq+oMU=;
        b=S3dwsRze7Y3JxdP2ZT4S4HvDr2EDPY+eK+No9uFYWQ813yncAjUupE0LyYorJvLQ2h
         md8hhyCg9LudhUp5gBNR6TDIiY0YrCvEmjFMvFfAtl5TKwyqzHmqv3MlHkKANSaB/oo3
         2GRdmVoBDdbGq0OY6K/2BXQZZmVeWQzYEmtz0vSEflBhxE3gUV4s/dk90gEKXRn7IFAM
         lDPhWl9IEnPjs5dVWSOhQbz/USS+D4rvG3WyfBtsa9Bwbaq/B7iDO2sUT5cREWHO1yBt
         9DRtN3iWLoKiNagH5Gel4GffRA5kqgPYgzsYMMzK1kMIoEh36kCEFe7Mxe47GebcTeZG
         TKdw==
X-Gm-Message-State: AOJu0YzXtloxNz/JAlh/waVAIuIQG3XQxzWmSJ6+EFsv9SNI8fbgTWGK
	d1JaXvNeYKv9mhoD1plMFtBLIVNMlLEk3itJU8wYG4aq1cDu54z5j26IPkhKMYX6FGXUOqa3uu3
	QH1aIDzepyXAPU8BAsD8Cz9o9o0/FnJuCwc204t+qVGP4Ha+B
X-Google-Smtp-Source: AGHT+IF6EuzW5/ZBE9dzhHMQpazM/7+4392PolAM+1PoR9T9WKAjfN9BKYSPwtpIiijND0l+lqZ852QiGESF3BW3mog=
X-Received: by 2002:a17:90b:100e:b0:296:20fb:9d0d with SMTP id
 gm14-20020a17090b100e00b0029620fb9d0dmr9930551pjb.28.1707046368838; Sun, 04
 Feb 2024 03:32:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208002342.367117-1-qyousef@layalina.io> <20231208002342.367117-9-qyousef@layalina.io>
 <Zbk0DhibX0oDLk1s@vingu-book> <20240201222428.xd2sylnz66wrczal@airbuntu>
In-Reply-To: <20240201222428.xd2sylnz66wrczal@airbuntu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Sun, 4 Feb 2024 12:32:36 +0100
Message-ID: <CAKfTPtBeiqgndxzVu=hu3awbejpsKehww5GvNcB3p57A9mmg=g@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] sched/pelt: Introduce PELT multiplier
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>, 
	Rick Yiu <rickyiu@google.com>, Chung-Kai Mei <chungkai@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 1 Feb 2024 at 23:24, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 01/30/24 18:38, Vincent Guittot wrote:
> > Le vendredi 08 d=C3=A9c. 2023 =C3=A0 00:23:42 (+0000), Qais Yousef a =
=C3=A9crit :
> > > From: Vincent Donnefort <vincent.donnefort@arm.com>
> > >
> > > The new sched_pelt_multiplier boot param allows a user to set a clock
> > > multiplier to x2 or x4 (x1 being the default). This clock multiplier
> > > artificially speeds up PELT ramp up/down similarly to use a faster
> > > half-life than the default 32ms.
> > >
> > >   - x1: 32ms half-life
> > >   - x2: 16ms half-life
> > >   - x4: 8ms  half-life
> > >
> > > Internally, a new clock is created: rq->clock_task_mult. It sits in t=
he
> > > clock hierarchy between rq->clock_task and rq->clock_pelt.
> > >
> > > The param is set as read only and can only be changed at boot time vi=
a
> > >
> > >     kernel.sched_pelt_multiplier=3D[1, 2, 4]
> > >
> > > PELT has a big impact on the overall system response and reactiveness=
 to
> > > change. Smaller PELT HF means it'll require less time to reach the
> > > maximum performance point of the system when the system become fully
> > > busy; and equally shorter time to go back to lowest performance point
> > > when the system goes back to idle.
> > >
> > > This faster reaction impacts both dvfs response and migration time
> > > between clusters in HMP system.
> > >
> > > Smaller PELT values are expected to give better performance at the co=
st
> > > of more power. Under powered systems can particularly benefit from
> > > smaller values. Powerful systems can still benefit from smaller value=
s
> > > if they want to be tuned towards perf more and power is not the major
> > > concern for them.
> > >
> > > This combined with respone_time_ms from schedutil should give the use=
r
> > > and sysadmin a deterministic way to control the triangular power, per=
f
> > > and thermals for their system. The default response_time_ms will half
> > > as PELT HF halves.
> > >
> > > Update approximate_{util_avg, runtime}() to take into account the PEL=
T
> > > HALFLIFE multiplier.
> > >
> > > Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> > > Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > > [Converted from sysctl to boot param and updated commit message]
> > > Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> > > ---
> > >  kernel/sched/core.c  |  2 +-
> > >  kernel/sched/pelt.c  | 52 ++++++++++++++++++++++++++++++++++++++++++=
--
> > >  kernel/sched/pelt.h  | 42 +++++++++++++++++++++++++++++++----
> > >  kernel/sched/sched.h |  1 +
> > >  4 files changed, 90 insertions(+), 7 deletions(-)
> > >
> >
> > ...
> >
> > > +__read_mostly unsigned int sched_pelt_lshift;
> > > +static unsigned int sched_pelt_multiplier =3D 1;
> > > +
> > > +static int set_sched_pelt_multiplier(const char *val, const struct k=
ernel_param *kp)
> > > +{
> > > +   int ret;
> > > +
> > > +   ret =3D param_set_int(val, kp);
> > > +   if (ret)
> > > +           goto error;
> > > +
> > > +   switch (sched_pelt_multiplier)  {
> > > +   case 1:
> > > +           fallthrough;
> > > +   case 2:
> > > +           fallthrough;
> > > +   case 4:
> > > +           WRITE_ONCE(sched_pelt_lshift,
> > > +                      sched_pelt_multiplier >> 1);
> > > +           break;
> > > +   default:
> > > +           ret =3D -EINVAL;
> > > +           goto error;
> > > +   }
> > > +
> > > +   return 0;
> > > +
> > > +error:
> > > +   sched_pelt_multiplier =3D 1;
> > > +   return ret;
> > > +}
> > > +
> > > +static const struct kernel_param_ops sched_pelt_multiplier_ops =3D {
> > > +   .set =3D set_sched_pelt_multiplier,
> > > +   .get =3D param_get_int,
> > > +};
> > > +
> > > +#ifdef MODULE_PARAM_PREFIX
> > > +#undef MODULE_PARAM_PREFIX
> > > +#endif
> > > +/* XXX: should we use sched as prefix? */
> > > +#define MODULE_PARAM_PREFIX "kernel."
> > > +module_param_cb(sched_pelt_multiplier, &sched_pelt_multiplier_ops, &=
sched_pelt_multiplier, 0444);
> > > +MODULE_PARM_DESC(sched_pelt_multiplier, "PELT HALFLIFE helps control=
 the responsiveness of the system.");
> > > +MODULE_PARM_DESC(sched_pelt_multiplier, "Accepted value: 1 32ms PELT=
 HALIFE - roughly 200ms to go from 0 to max performance point (default).");
> > > +MODULE_PARM_DESC(sched_pelt_multiplier, "                2 16ms PELT=
 HALIFE - roughly 100ms to go from 0 to max performance point.");
> > > +MODULE_PARM_DESC(sched_pelt_multiplier, "                4  8ms PELT=
 HALIFE - roughly  50ms to go from 0 to max performance point.");
> > > +
> > >  /*
> > >   * Approximate the new util_avg value assuming an entity has continu=
ed to run
> > >   * for @delta us.
> >
> > ...
> >
> > > +
> > >  static inline void
> > > -update_rq_clock_pelt(struct rq *rq, s64 delta) { }
> > > +update_rq_clock_task_mult(struct rq *rq, s64 delta) { }
> > >
> > >  static inline void
> > >  update_idle_rq_clock_pelt(struct rq *rq) { }
> > > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > > index bbece0eb053a..a7c89c623250 100644
> > > --- a/kernel/sched/sched.h
> > > +++ b/kernel/sched/sched.h
> > > @@ -1029,6 +1029,7 @@ struct rq {
> > >     u64                     clock;
> > >     /* Ensure that all clocks are in the same cache line */
> > >     u64                     clock_task ____cacheline_aligned;
> > > +   u64                     clock_task_mult;
> >
> > I'm not sure that we want yet another clock and this doesn't apply for =
irq_avg.
> >
> > What about the below is simpler and I think cover all cases ?
>
> Looks better, yes. I'll change to this and if no issues come up I'll add =
your
> signed-off-by if that's okay with you for the next version.

Yes, that's okay

>
>
> Thanks!
>
> --
> Qais Yousef
>
> >
> > diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> > index f951c44f1d52..5cdd147b7abe 100644
> > --- a/kernel/sched/pelt.c
> > +++ b/kernel/sched/pelt.c
> > @@ -180,6 +180,7 @@ static __always_inline int
> >  ___update_load_sum(u64 now, struct sched_avg *sa,
> >                 unsigned long load, unsigned long runnable, int running=
)
> >  {
> > +     int time_shift;
> >       u64 delta;
> >
> >       delta =3D now - sa->last_update_time;
> > @@ -195,12 +196,17 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
> >       /*
> >        * Use 1024ns as the unit of measurement since it's a reasonable
> >        * approximation of 1us and fast to compute.
> > +      * On top of this, we can change the half-time period from the de=
fault
> > +      * 32ms to a shorter value. This is equivalent to left shifting t=
he
> > +      * time.
> > +      * Merge both right and left shifts in one single right shift
> >        */
> > -     delta >>=3D 10;
> > +     time_shift =3D 10 - sched_pelt_lshift;
> > +     delta >>=3D time_shift;
> >       if (!delta)
> >               return 0;
> >
> > -     sa->last_update_time +=3D delta << 10;
> > +     sa->last_update_time +=3D delta << time_shift;
> >
> >       /*
> >        * running is a subset of runnable (weight) so running can't be s=
et if
> >
> >
> >
> > >     u64                     clock_pelt;
> > >     unsigned long           lost_idle_time;
> > >     u64                     clock_pelt_idle;
> > > --
> > > 2.34.1
> > >

