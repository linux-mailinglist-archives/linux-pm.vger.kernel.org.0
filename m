Return-Path: <linux-pm+bounces-34498-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1275B539F9
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 19:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 816C73B0C6D
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 17:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651BD35FC20;
	Thu, 11 Sep 2025 17:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CheQUR/i"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FBB35FC18
	for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 17:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757610476; cv=none; b=g/ClF9dEnDJd0queqJIdPrA8t1k+iIiefe2iowQHer2QPOQa4e0EzBPK6ru1S6x5I1hjOcH7XGa0tv2wju1zd+3Zn5ASRL0tRyHn4BPcTgm2eu9C3zNi7ETWvr86uloHvCx8KwX6PSHSM2dHlVwEguKDlYZipxUPxuuSpMCEBOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757610476; c=relaxed/simple;
	bh=hegmbTdn1yNC2UBMwnCcFb/Ouc5cQ0RQwUD/oCv3AUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tr0mJruBF59f4GQqoV/id8JMO9o7Q5GV4AOB/t0lREwoD/mC6Kb2O9f1bXtGdJAPZEohQv3yloIxX5txc/0G4hmtdB98lDrgZgBfTdShNiIHT9r71/rwIMGfJ9dWlQA1ZBPi5LRBGwVM6y20U8t94SkeGpo854vMojI32R+O4Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CheQUR/i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1995C4CEFA
	for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 17:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757610474;
	bh=hegmbTdn1yNC2UBMwnCcFb/Ouc5cQ0RQwUD/oCv3AUI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CheQUR/iGx5FEuclHQn8fvVBJb+v09aAJZeHAeYpoHEaihoOaHiUSIvDW3wlCdbcX
	 CyDQCLcIqm5YMUjWhySZPl5HxCFQorjanUufWx9Ziz9WFjuk6TYHnaPrLRXb+7xhli
	 FMBURZrAD+uMmHqLzGH8ViqUa3Dd+0dO01bUETPI2PfP/lctQdH0ixw0W5IfuFWZvt
	 nZcpExqyHbKaKsBH0AfhrQuxtWMDIfsOUQKumNqCPluQs8b5zhGdgBi0HTCky6Srrz
	 kVbOl+O0iOswbv99re0GKoXOl2QUD+GUos9X3Cgn5oV67LnVgCe6zzATJ/KGyTTLpN
	 JxHiMalba6hJA==
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-74595f3852cso710664a34.0
        for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 10:07:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVfVR+FlywTOeU54ahV4I3r5b9wNX2oldbMr/10oKTXAP8hXwK5EHjdPIbdRR9O0GbAEyrOcP9RcA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKk+oiLIiAuaxwShZkgqVZu79t8Ps89SwwL4CAwgO0B3ixMh+S
	jw6hlPpzLuMZ21WulWuOWVzDv7r52Ar9PUbRTZj3B5fwKxKq+VqPY771bCe2Gf5AA+tmr/ihkeS
	x5C/ckqP0KPSEY1r2jmvUeNpmMzmvzoU=
X-Google-Smtp-Source: AGHT+IHz7kFoI9nYZzdWf0EGe+F1PRDSTVqUP4uQIQDaa3hMRCOhQvgGPrv71EgXCT3iu5J7L2/KGoniXH5P7s/3qFs=
X-Received: by 2002:a05:6830:67e3:b0:745:a336:7265 with SMTP id
 46e09a7af769-7534fe7141amr183400a34.0.1757610474026; Thu, 11 Sep 2025
 10:07:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2804546.mvXUDI8C0e@rafael.j.wysocki> <2244365.irdbgypaU6@rafael.j.wysocki>
 <aMLaEwBHwiDhgaWM@localhost.localdomain>
In-Reply-To: <aMLaEwBHwiDhgaWM@localhost.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 11 Sep 2025 19:07:42 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h3eWw3B15SamchCVWfxfEEbOOgjm4ZbmkTt9ijZvvHMA@mail.gmail.com>
X-Gm-Features: Ac12FXw2h4F5WqWDGdQx79WJRXefZH6-kLNIMbIhFCvYNYkK5mZJ6omJ417od6g
Message-ID: <CAJZ5v0h3eWw3B15SamchCVWfxfEEbOOgjm4ZbmkTt9ijZvvHMA@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] cpuidle: governors: menu: Special-case nohz_full CPUs
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Christian Loehle <christian.loehle@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 4:17=E2=80=AFPM Frederic Weisbecker <frederic@kerne=
l.org> wrote:
>
> Le Wed, Aug 13, 2025 at 12:29:51PM +0200, Rafael J. Wysocki a =C3=A9crit =
:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > When the menu governor runs on a nohz_full CPU and there are no user
> > space timers in the workload on that CPU, it ends up selecting idle
> > states with target residency values above TICK_NSEC all the time due to
> > a tick_nohz_tick_stopped() check designed for a different use case.
> >
> > Namely, on nohz_full CPUs the fact that the tick has been stopped does
> > not actually mean anything in particular, whereas in the other case it
> > indicates that previously the CPU was expected to be idle sufficiently
> > long for the tick to be stopped, so it is not unreasonable to expect
> > it to be idle beyond the tick period length again.
>
> I understand what you mean but it may be hard to figure out for
> reviewers. Can we rephrase it to something like:
>
> When nohz_full is not running, the fact that the tick is stopped
> indicates the CPU has been idle for sufficiently long so that
> nohz has deferred it to the next timer callback. So it is
> not unreasonable to expect the CPU to be idle beyond the tick
> period length again.
>
> However when nohz_full is running, the CPU may enter idle with the
> tick already stopped. But this doesn't tell anything about the future
> CPU's idleness.

Sure, thanks for the hint.

> >
> > In some cases, this behavior causes latency in the workload to grow
> > undesirably.  It may also cause the workload to consume more energy
> > than necessary if the CPU does not spend enough time in the selected
> > deep idle states.
> >
> > Address this by amending the tick_nohz_tick_stopped() check in question
> > with a tick_nohz_full_cpu() one to avoid using the time till the next
> > timer event as the predicted_ns value all the time on nohz_full CPUs.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpuidle/governors/menu.c |   12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > --- a/drivers/cpuidle/governors/menu.c
> > +++ b/drivers/cpuidle/governors/menu.c
> > @@ -293,8 +293,18 @@
> >        * in a shallow idle state for a long time as a result of it.  In=
 that
> >        * case, say we might mispredict and use the known time till the =
closest
> >        * timer event for the idle state selection.
> > +      *
> > +      * However, on nohz_full CPUs the tick does not run as a rule and=
 the
> > +      * time till the closest timer event may always be effectively in=
finite,
> > +      * so using it as a replacement for the predicted idle duration w=
ould
> > +      * effectively always cause the prediction results to be discarde=
d and
> > +      * deep idle states to be selected all the time.  That might intr=
oduce
> > +      * unwanted latency into the workload and cause more energy than
> > +      * necessary to be consumed if the discarded prediction results a=
re
> > +      * actually accurate, so skip nohz_full CPUs here.
> >        */
> > -     if (tick_nohz_tick_stopped() && predicted_ns < TICK_NSEC)
> > +     if (tick_nohz_tick_stopped() && !tick_nohz_full_cpu(dev->cpu) &&
> > +         predicted_ns < TICK_NSEC)
> >               predicted_ns =3D data->next_timer_ns;
>
> So, when !tick_nohz_full_cpu(dev->cpu), what is the purpose of this tick =
stopped
> special case?
>
> Is it because the next dynamic tick is a better prediction than the typic=
al
> interval once the tick is stopped?

When !tick_nohz_full_cpu(dev->cpu), the tick is a safety net against
getting stuck in a shallow idle state for too long.  In that case, if
the tick is stopped, the safety net is not there and it is better to
use a deep state.

However, data->next_timer_ns is a lower limit for the idle state
target residency because this is when the next timer is going to
trigger.

> Does that mean we might become more "pessimistic" concerning the predicte=
d idle
> time for nohz_full CPUs?

Yes, and not just we might, but we do unless the idle periods in the
workload are "long".

> I guess too shallow C-states are still better than too deep but there sho=
uld be
> a word about that introduced side effect (if any).

Yeah, I agree.

That said, on a nohz_full CPU there is no safety net against getting
stuck in a shallow idle state because the tick is not present.  That's
why currently the governors don't allow shallow states to be used on
nohz_full CPUs.

The lack of a safety net is generally not a problem when the CPU has
been isolated to run something doing real work all the time, with
possible idle periods in the workload, but there are people who
isolate CPUs for energy-saving reasons and don't run anything on them
on purpose.  For those folks, the current behavior to select deep idle
states every time is actually desirable.

So there are two use cases that cannot be addressed at once and I'm
thinking about adding a control knob to allow the user to decide which
way to go.

