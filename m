Return-Path: <linux-pm+bounces-37129-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4889C21B42
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 19:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E40B0406524
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 18:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80A72FCC0F;
	Thu, 30 Oct 2025 18:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sl6Je7xU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928EE25FA13
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 18:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847876; cv=none; b=H6D5Oo5X6ys9dCMwhhxFTdMsX7vEmPF4TumAMn1t8Qd8G62i7/5dLRfyd5sT4JvD6tpfBKYNAuSPOM+nbu+hMSHbRYLIC8BJRS+K2oBxO/4e19AreXw7IjAnusBOdVAaiaxSJj2ukkATYzx+t+81riwLtREFb1ghHpOiA9YYHKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847876; c=relaxed/simple;
	bh=uUizPZKluk7Jwn3HpmewDS0Fy2cfvBUvG9HSQEUfK4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b04NrghcVjZ3fnZmqoiQlcJYNbsbfrZAYTuSlHRsR0R+6Ff6DePAkIrOnkOsjNqqWB0wYh0yVEu+EzoaH/2EC7yEP/euYQQc+Kt6/+Ze5UPc9fdAlkWEtG/tGYDbd0RkAgEYjO2q0qyTAQBEgfsS76lSowbtN68Kyg6E+6Kssuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sl6Je7xU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C7CC4AF0B
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 18:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761847876;
	bh=uUizPZKluk7Jwn3HpmewDS0Fy2cfvBUvG9HSQEUfK4o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sl6Je7xUwBhTrJqbH4Zqa7uVjdz8vDZ4/W6UsoybPqgR29GjGQzhoV+upQWv6vV7f
	 0RIAnAxQk89PdojrLXBEkSrpPU6ekHpvfQJKGSgUdVHOvghkacCa/dcoMa6WksRhIM
	 ppBmnNTaDObXIHQuFmpdWhAbFa0V0dkUTmOJlGB6YcsBPqXd1HLEsWXRM4KbmikwmA
	 0PHYJ9R3rniP+uoOFd7qPjQjiHi0aVI22tseIpEs+8vfkm1UnyHb6NuVBXHgRBsbLF
	 EwHUh8BAsaHT3iCtmE8V+WE2Figt1PGOEx1Sr59tN1gZqnW6BrquPuQITMpyInXCEE
	 cPaPzkZdyjy9w==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4491510f005so375567b6e.2
        for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 11:11:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXU5ZCmOt+BKcFL9GKvTuMwxdUc43fwx8kdN605KhBRVBLA4txwudYRoJc5aR+e1rvLd3ERrYq8pg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxYSNl/O0/N2MLEZx5Cn+M2Gk7BXm1l/yLQ6He4q5DzNnUKJgG
	xs9FogZHqYU1fdiSdKpbq5odx4KZsB0XtryF1rlTtwLK+eqplDDG8ib+y/9fbShMNh2CzaOm0cS
	qoonRr4zSlysLCFZmwWCSHo6jvN3GUDk=
X-Google-Smtp-Source: AGHT+IHW0nlsfsQxxGRyJgN07O4vnJjHufNj/PwIMwcNbkhmcasizwXLwJVkiitD3Ek49r3QecRqAhv+R7Y03Q/iMc0=
X-Received: by 2002:a05:6808:189e:b0:44f:8f02:8a50 with SMTP id
 5614622812f47-44f95e19ca9mr316111b6e.12.1761847875470; Thu, 30 Oct 2025
 11:11:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016151929.75863-1-ulf.hansson@linaro.org>
 <20251016151929.75863-3-ulf.hansson@linaro.org> <CAJZ5v0hPUYoLFs=jZ10a1cX6TE1bmRF7CkBH1Ebejao9Hdfhnw@mail.gmail.com>
 <CAPDyKFrrhw5vMYLEWJ5LRphVzwPwjiU-n=tdbgOtOmFSXGd0GQ@mail.gmail.com>
 <CAJZ5v0g5p-8WrmNQ6-tvTEy50gVjfEMsmXxTK8bmLqafe30jKw@mail.gmail.com>
 <CAPDyKFo+U=oJVxXCDBN_WZLBpkwPgv_=qw96hauAttFnAQuPtw@mail.gmail.com>
 <CAJZ5v0h_OFzmhcKohS3SNWwz_vwpq6frymXSSgFjk_K27ncSTg@mail.gmail.com> <CAPDyKFqs_Mn57SxPNy5_e56LuFxx3KkfJfHqgg9_wp77rpn7Pw@mail.gmail.com>
In-Reply-To: <CAPDyKFqs_Mn57SxPNy5_e56LuFxx3KkfJfHqgg9_wp77rpn7Pw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 30 Oct 2025 19:11:03 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jTVZtyV2yeFNpGo4TnZY79CH_fpaSbVq1T9BJ0BohZsg@mail.gmail.com>
X-Gm-Features: AWmQ_bn8g4XPjHgN-vPCtJtXbq8yiQaaFqzBPArGiQe8U_U8Qc85RIkrxzmOK1A
Message-ID: <CAJZ5v0jTVZtyV2yeFNpGo4TnZY79CH_fpaSbVq1T9BJ0BohZsg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] pmdomain: Respect the CPU system-wakeup QoS limit
 during s2idle
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Kevin Hilman <khilman@baylibre.com>, Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Saravana Kannan <saravanak@google.com>, 
	Maulik Shah <quic_mkshah@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, 
	Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 4:07=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Thu, 30 Oct 2025 at 15:02, Rafael J. Wysocki <rafael@kernel.org> wrote=
:
> >
> > On Thu, Oct 30, 2025 at 1:32=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro=
.org> wrote:
> > >
> > > On Thu, 30 Oct 2025 at 13:23, Rafael J. Wysocki <rafael@kernel.org> w=
rote:
> > > >
> > > > On Thu, Oct 30, 2025 at 1:00=E2=80=AFPM Ulf Hansson <ulf.hansson@li=
naro.org> wrote:
> > > > >
> > > > > On Thu, 30 Oct 2025 at 11:45, Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
> > > > > >
> > > > > > On Thu, Oct 16, 2025 at 5:19=E2=80=AFPM Ulf Hansson <ulf.hansso=
n@linaro.org> wrote:
> > > > > > >
> > > > > > > A CPU system-wakeup QoS limit may have been requested by user=
-space. To
> > > > > > > avoid breaking this constraint when entering a low-power stat=
e during
> > > > > > > s2idle through genpd, let's extend the corresponding genpd go=
vernor for
> > > > > > > CPUs. More precisely, during s2idle let the genpd governor se=
lect a
> > > > > > > suitable low-power state, by taking into account the QoS limi=
t.
> > > > > > >
> > > > > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > > > ---
> > > > > > >
> > > > > > > Changes in v2:
> > > > > > >         - Limite the change to the genpd governor for CPUs.
> > > > > > >
> > > > > > > ---
> > > > > > >  drivers/pmdomain/core.c     | 10 ++++++++--
> > > > > > >  drivers/pmdomain/governor.c | 27 +++++++++++++++++++++++++++
> > > > > > >  include/linux/pm_domain.h   |  1 +
> > > > > > >  3 files changed, 36 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.=
c
> > > > > > > index 61c2277c9ce3..4fd546ef0448 100644
> > > > > > > --- a/drivers/pmdomain/core.c
> > > > > > > +++ b/drivers/pmdomain/core.c
> > > > > > > @@ -1425,8 +1425,14 @@ static void genpd_sync_power_off(struc=
t generic_pm_domain *genpd, bool use_lock,
> > > > > > >                         return;
> > > > > > >         }
> > > > > > >
> > > > > > > -       /* Choose the deepest state when suspending */
> > > > > > > -       genpd->state_idx =3D genpd->state_count - 1;
> > > > > > > +       if (genpd->gov && genpd->gov->system_power_down_ok) {
> > > > > > > +               if (!genpd->gov->system_power_down_ok(&genpd-=
>domain))
> > > > > > > +                       return;
> > > > > > > +       } else {
> > > > > > > +               /* Default to the deepest state. */
> > > > > > > +               genpd->state_idx =3D genpd->state_count - 1;
> > > > > > > +       }
> > > > > > > +
> > > > > > >         if (_genpd_power_off(genpd, false)) {
> > > > > > >                 genpd->states[genpd->state_idx].rejected++;
> > > > > > >                 return;
> > > > > > > diff --git a/drivers/pmdomain/governor.c b/drivers/pmdomain/g=
overnor.c
> > > > > > > index 39359811a930..bd1b9d66d4a5 100644
> > > > > > > --- a/drivers/pmdomain/governor.c
> > > > > > > +++ b/drivers/pmdomain/governor.c
> > > > > > > @@ -415,9 +415,36 @@ static bool cpu_power_down_ok(struct dev=
_pm_domain *pd)
> > > > > > >         return false;
> > > > > > >  }
> > > > > > >
> > > > > > > +static bool cpu_system_power_down_ok(struct dev_pm_domain *p=
d)
> > > > > > > +{
> > > > > > > +       s64 constraint_ns =3D cpu_wakeup_latency_qos_limit() =
* NSEC_PER_USEC;
> > > > > >
> > > > > > I'm not sure why genpd needs to take cpu_wakeup_latency_qos_lim=
it()
> > > > > > into account directly.
> > > > > >
> > > > > > It should be told by cpuidle which state has been selected on t=
he CPU
> > > > > > side and it should not go any deeper than that anyway.
> > > > >
> > > > > For PSCI OS-initiated mode, cpuidle doesn't know about the states=
 that
> > > > > may be shared among a group of CPUs.
> > > > >
> > > > > Instead, those states are controlled through the PM domain topolo=
gy by
> > > > > genpd and its governor, hence this is needed too.
> > > >
> > > > All right, but I'd like to understand how all of that works.
> > > >
> > > > So cpuidle selects a state to enter for the given CPU and then genp=
d
> > > > is invoked.  It has to take the exit latency of that state into
> > > > account, so it doesn't go too deep.  How does it do that?
> > >
> > > Depending on the state selected, in cpuidle-psci.c we may end up
> > > calling __psci_enter_domain_idle_state() (only for the deepest
> > > CPU-state).
> > >
> > > For s2idle this means we call dev_pm_genpd_suspend|resume(), to manag=
e
> > > the reference counting of the PM domains via genpd. This then may lea=
d
> > > to that genpd_sync_power_off() tries to select a state by calling the
> > > new governor function above.
> > >
> > > Did that make sense?
> >
> > So IIUC this will only happen if the deepest idle state is selected in
> > which case the cpu_wakeup_latency_qos_limit() value is greater than
> > the exit latency of that state, but it may still need to be taken into
> > account when selecting the domain state.  However, this means that the
>
> Correct.
>
> > exit latency number for the deepest idle state is too low (it should
> > represent the worst-case exit latency which means the maximum domain
> > exit latency in this particular case).
>
> Yes, from the cpuidle state-selection point of view, but how is that a pr=
oblem?

It is confusing.  Otherwise, for s2idle, I guess it is not a big deal.

I guess what happens is that genpd has a range of states with
different latency values to choose from and it is not practical to
expose all of them as CPU idle states, so you end up exposing just one
of them with the lowest latency value to allow cpuidle to involve
genpd often enough.

If that's the case, I'd make a note of that somewhere if I were you,
or people will routinely get confused by it.

> If the genpd-governor doesn't find a suitable "domain-idle-state", we
> fallback to using the one cpuidle selected.
>
> >
> > Moreover, it looks like the "runtime" cpuidle has the same problem, doe=
sn't it?
>
> It works in a very similar way, but I fail to understand why you think
> there is a problem.

There is a problem because it may violate a "runtime" latency constraint.

Say you expose 2 CPU idle states, a shallow one and a genpd one.  The
advertised exit latency of the genpd state is X and the current
latency constraint is Y > X.  The genpd state is selected and genpd
doesn't look at the cpuidle_governor_latency_req() return value, so it
chooses a real state with exit latency Z > Y.

To a minimum, genpd should be made aware of
cpuidle_governor_latency_req(), but even then cpuidle governors take
exit latency into consideration in their computations, so things may
get confused somewhat.

