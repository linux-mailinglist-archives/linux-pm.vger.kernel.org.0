Return-Path: <linux-pm+bounces-37169-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C99A8C2467C
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 11:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D81A4E5C69
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 10:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FE733E350;
	Fri, 31 Oct 2025 10:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OP8Y0iNg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1CA334372
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 10:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761905994; cv=none; b=F6NAcC/G18wWOSxdj2jz8Ix6v7kq3QARsWOfR9EVDUTK9psTdoqp9df4+0aDpYGyFdf9qZUrrKx1xY5EsJZUj1iwwuyltMIcbScJ3GFGKZuJf1AvCZuIu7oeRDO3Q5CbIxryanQRqyu+E+LTtyXdATQHAGZQNubOGuOzj21lXkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761905994; c=relaxed/simple;
	bh=vYEp5LCQLKcZt/AJH9FMShktlCjD0MSMpUC07j93mL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MHQcHmnKVXpiiB/+/PHkY6+RTfYkgQUI+cTwxWN9aUP9ym0ErhMfGkCvtoegSCaFYZ6e8/MHYAezmIHIAJuCr1Ix1y7V/t778Rc93LZGifXh6GVjfqMY4CWI4l33b6sDSROMQpXpo1qhjFiuWp34LUtrPswuU2ePlXtX2YUg00k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OP8Y0iNg; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7864ab69f01so5668817b3.3
        for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 03:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761905992; x=1762510792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPKXKxyxHjncQ9cjShE0Ho84jnqExLGCProdqRHO1kU=;
        b=OP8Y0iNgHOYlUJu+BQ2U1RvXgGXeCeFpMEtRqFQOshuqjn6lq4aUcdN9BdWM8U8XjG
         Pm0ay4iWZRmsGDl/yD8x8lgRNhJFDDAFBhSlfkhRKxv87WHHBU/9dzzXPvO1/PqH2G0n
         B2APsIa/lmc7w/0dRsHf5mitHZasXSPlaKgDcIQdwc+NT4zfdVHWrhNI/YX05+61QRnc
         JXaNO3kjYL3IPeonQG2FuvJ+EObIGduwLQiA3Ss3gEMSvKR1A6N/o7nyBAW6/Eu2AXF7
         QkcddyRamLY1kpugY7vJP9LUtOINgTv2z5J8T/Tp1IbxDBVqP0Z43X1dfi/A7Ox5gLlz
         Wxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761905992; x=1762510792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aPKXKxyxHjncQ9cjShE0Ho84jnqExLGCProdqRHO1kU=;
        b=kR9X+Fxa3DySkevx7UvEmMU+RCBa2irXL1YfzVspD7UjO2MLQQyDVcPnIdb45+2pYs
         osGmILrXlXmQoeDMF64u54BeFQZLd2CJ3bIa9ZemrnTDM7CI/MksGxwDtDp36PflHkh6
         zfXF8G7iiWy3oqldYrM546wL2mXvThkZ1KT/Dvfid81JvHhGKSFlsMjPQ6HXSQU3A5d9
         RwjaT5tNaoXuJZuTz/SDkum2Q3oTdtBrTal53yWFp01hDMEyuRHqmN7m5ggL6tl7Pw45
         1QMAK0Fcs4A40JgxLeQMD75pviH7bpRtHTXuDw+twQJyjsWPOL23FbIMoFU4rtYGaVUT
         5Xkg==
X-Gm-Message-State: AOJu0Yxun9dmt3Ij7hWToLWK+xZKH/BlCbWjzvJ0EXYnGtsX1ME8pksZ
	jD5ngfkwO++W9d4cvCVLEUzV+FUztNkyvoQK5rMeF4YekvK/ms372MB1d51+uhxfqYpWsQ+YGOt
	wXuxIHgivJbcEyw7x0mpt/B5rWcnpIB/gQugXe1rfrPh2zagvIj+nUP4=
X-Gm-Gg: ASbGncujGjLzj2y8nnvi8PeMyf2weQhipHoRZpnk7Uoux461n/s3L2RZ+lU96NibaQ0
	ckushCnR433h4y1ycu7ZWFTKDKM0aqzp9WC9HRjVWF2dlAJgX3iXOJvbpV5TGdN0Z/Uaigu1nVU
	c28wM6XkwWtiJzDkvS4olB27l9Jva3QcDXTTvxE2Azer2MXUg2OvqwRcY5+0yPyHSlkNvVBx0mp
	Kp1dvoR3IYIZoDxySNyH6wJYcnC7x/twpKny6im/0lgOSulljHCkpw9NjihNw==
X-Google-Smtp-Source: AGHT+IFsTiLTA6cpzlCTzrmxVqWzDKcCRkhAd4TjVbco+5uODr6qAdgcAAlWDTr7vSuTaJZgkuQGUU1CQMg4deAauaI=
X-Received: by 2002:a05:690c:b88:b0:785:c415:6a8 with SMTP id
 00721157ae682-786485304f1mr22769367b3.56.1761905991904; Fri, 31 Oct 2025
 03:19:51 -0700 (PDT)
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
 <CAJZ5v0h_OFzmhcKohS3SNWwz_vwpq6frymXSSgFjk_K27ncSTg@mail.gmail.com>
 <CAPDyKFqs_Mn57SxPNy5_e56LuFxx3KkfJfHqgg9_wp77rpn7Pw@mail.gmail.com> <CAJZ5v0jTVZtyV2yeFNpGo4TnZY79CH_fpaSbVq1T9BJ0BohZsg@mail.gmail.com>
In-Reply-To: <CAJZ5v0jTVZtyV2yeFNpGo4TnZY79CH_fpaSbVq1T9BJ0BohZsg@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 31 Oct 2025 11:19:15 +0100
X-Gm-Features: AWmQ_bn_ES3pms530igeilc5LJpLblVGtlMFWIl2LYJGbqgHLcd8baXCa4JRQcs
Message-ID: <CAPDyKFoPzFqbXo1nD_6r-mW+OYUHSdH+P19ov-0kjb8znLYtYw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] pmdomain: Respect the CPU system-wakeup QoS limit
 during s2idle
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, 
	Peter Zijlstra <peterz@infradead.org>, Kevin Hilman <khilman@baylibre.com>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Saravana Kannan <saravanak@google.com>, 
	Maulik Shah <quic_mkshah@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, 
	Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 30 Oct 2025 at 19:11, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Oct 30, 2025 at 4:07=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > On Thu, 30 Oct 2025 at 15:02, Rafael J. Wysocki <rafael@kernel.org> wro=
te:
> > >
> > > On Thu, Oct 30, 2025 at 1:32=E2=80=AFPM Ulf Hansson <ulf.hansson@lina=
ro.org> wrote:
> > > >
> > > > On Thu, 30 Oct 2025 at 13:23, Rafael J. Wysocki <rafael@kernel.org>=
 wrote:
> > > > >
> > > > > On Thu, Oct 30, 2025 at 1:00=E2=80=AFPM Ulf Hansson <ulf.hansson@=
linaro.org> wrote:
> > > > > >
> > > > > > On Thu, 30 Oct 2025 at 11:45, Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> > > > > > >
> > > > > > > On Thu, Oct 16, 2025 at 5:19=E2=80=AFPM Ulf Hansson <ulf.hans=
son@linaro.org> wrote:
> > > > > > > >
> > > > > > > > A CPU system-wakeup QoS limit may have been requested by us=
er-space. To
> > > > > > > > avoid breaking this constraint when entering a low-power st=
ate during
> > > > > > > > s2idle through genpd, let's extend the corresponding genpd =
governor for
> > > > > > > > CPUs. More precisely, during s2idle let the genpd governor =
select a
> > > > > > > > suitable low-power state, by taking into account the QoS li=
mit.
> > > > > > > >
> > > > > > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > > > > ---
> > > > > > > >
> > > > > > > > Changes in v2:
> > > > > > > >         - Limite the change to the genpd governor for CPUs.
> > > > > > > >
> > > > > > > > ---
> > > > > > > >  drivers/pmdomain/core.c     | 10 ++++++++--
> > > > > > > >  drivers/pmdomain/governor.c | 27 +++++++++++++++++++++++++=
++
> > > > > > > >  include/linux/pm_domain.h   |  1 +
> > > > > > > >  3 files changed, 36 insertions(+), 2 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/cor=
e.c
> > > > > > > > index 61c2277c9ce3..4fd546ef0448 100644
> > > > > > > > --- a/drivers/pmdomain/core.c
> > > > > > > > +++ b/drivers/pmdomain/core.c
> > > > > > > > @@ -1425,8 +1425,14 @@ static void genpd_sync_power_off(str=
uct generic_pm_domain *genpd, bool use_lock,
> > > > > > > >                         return;
> > > > > > > >         }
> > > > > > > >
> > > > > > > > -       /* Choose the deepest state when suspending */
> > > > > > > > -       genpd->state_idx =3D genpd->state_count - 1;
> > > > > > > > +       if (genpd->gov && genpd->gov->system_power_down_ok)=
 {
> > > > > > > > +               if (!genpd->gov->system_power_down_ok(&genp=
d->domain))
> > > > > > > > +                       return;
> > > > > > > > +       } else {
> > > > > > > > +               /* Default to the deepest state. */
> > > > > > > > +               genpd->state_idx =3D genpd->state_count - 1=
;
> > > > > > > > +       }
> > > > > > > > +
> > > > > > > >         if (_genpd_power_off(genpd, false)) {
> > > > > > > >                 genpd->states[genpd->state_idx].rejected++;
> > > > > > > >                 return;
> > > > > > > > diff --git a/drivers/pmdomain/governor.c b/drivers/pmdomain=
/governor.c
> > > > > > > > index 39359811a930..bd1b9d66d4a5 100644
> > > > > > > > --- a/drivers/pmdomain/governor.c
> > > > > > > > +++ b/drivers/pmdomain/governor.c
> > > > > > > > @@ -415,9 +415,36 @@ static bool cpu_power_down_ok(struct d=
ev_pm_domain *pd)
> > > > > > > >         return false;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +static bool cpu_system_power_down_ok(struct dev_pm_domain =
*pd)
> > > > > > > > +{
> > > > > > > > +       s64 constraint_ns =3D cpu_wakeup_latency_qos_limit(=
) * NSEC_PER_USEC;
> > > > > > >
> > > > > > > I'm not sure why genpd needs to take cpu_wakeup_latency_qos_l=
imit()
> > > > > > > into account directly.
> > > > > > >
> > > > > > > It should be told by cpuidle which state has been selected on=
 the CPU
> > > > > > > side and it should not go any deeper than that anyway.
> > > > > >
> > > > > > For PSCI OS-initiated mode, cpuidle doesn't know about the stat=
es that
> > > > > > may be shared among a group of CPUs.
> > > > > >
> > > > > > Instead, those states are controlled through the PM domain topo=
logy by
> > > > > > genpd and its governor, hence this is needed too.
> > > > >
> > > > > All right, but I'd like to understand how all of that works.
> > > > >
> > > > > So cpuidle selects a state to enter for the given CPU and then ge=
npd
> > > > > is invoked.  It has to take the exit latency of that state into
> > > > > account, so it doesn't go too deep.  How does it do that?
> > > >
> > > > Depending on the state selected, in cpuidle-psci.c we may end up
> > > > calling __psci_enter_domain_idle_state() (only for the deepest
> > > > CPU-state).
> > > >
> > > > For s2idle this means we call dev_pm_genpd_suspend|resume(), to man=
age
> > > > the reference counting of the PM domains via genpd. This then may l=
ead
> > > > to that genpd_sync_power_off() tries to select a state by calling t=
he
> > > > new governor function above.
> > > >
> > > > Did that make sense?
> > >
> > > So IIUC this will only happen if the deepest idle state is selected i=
n
> > > which case the cpu_wakeup_latency_qos_limit() value is greater than
> > > the exit latency of that state, but it may still need to be taken int=
o
> > > account when selecting the domain state.  However, this means that th=
e
> >
> > Correct.
> >
> > > exit latency number for the deepest idle state is too low (it should
> > > represent the worst-case exit latency which means the maximum domain
> > > exit latency in this particular case).
> >
> > Yes, from the cpuidle state-selection point of view, but how is that a =
problem?
>
> It is confusing.  Otherwise, for s2idle, I guess it is not a big deal.
>
> I guess what happens is that genpd has a range of states with
> different latency values to choose from and it is not practical to
> expose all of them as CPU idle states, so you end up exposing just one
> of them with the lowest latency value to allow cpuidle to involve
> genpd often enough.

Yes, the states that are CPU specific are exposed to CPU-idle.

The states that are shared with other CPUs are managed by genpd,
because those need reference counting. Not even limited to CPUs.

>
> If that's the case, I'd make a note of that somewhere if I were you,
> or people will routinely get confused by it.

Documentation is always nice.

We have DT docs and the PSCI spec, but we lack proper documentation of
the whole genpd interface. Actually, I have started working on
documentation for genpd, but haven't reached the point of submitting a
patch for it.

>
> > If the genpd-governor doesn't find a suitable "domain-idle-state", we
> > fallback to using the one cpuidle selected.
> >
> > >
> > > Moreover, it looks like the "runtime" cpuidle has the same problem, d=
oesn't it?
> >
> > It works in a very similar way, but I fail to understand why you think
> > there is a problem.
>
> There is a problem because it may violate a "runtime" latency constraint.
>
> Say you expose 2 CPU idle states, a shallow one and a genpd one.  The
> advertised exit latency of the genpd state is X and the current
> latency constraint is Y > X.  The genpd state is selected and genpd
> doesn't look at the cpuidle_governor_latency_req() return value, so it
> chooses a real state with exit latency Z > Y.
>
> To a minimum, genpd should be made aware of
> cpuidle_governor_latency_req(), but even then cpuidle governors take
> exit latency into consideration in their computations, so things may
> get confused somewhat.

Please have a look at cpu_power_down_ok(), which is the function that
runs to select the domain-idle-state. It does take the constraints
into account during runtime, even it doesn't call
cpuidle_governor_latency_req() explicitly.

Kind regards
Uffe

