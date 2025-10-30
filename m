Return-Path: <linux-pm+bounces-37104-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3BFC207E1
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 15:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD4EB18882E2
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 14:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B159288A2;
	Thu, 30 Oct 2025 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDpvnhp+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1670E37A3B0
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 14:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761832946; cv=none; b=kfXObYhDWnN42DvkwdC9xa65ZFr5cvrA189XA+IEUn0hPMyxjadFn7M9nz2wIw/lCq8tGtD0RYoGac56cMKiTbxdrTPWjVvGrzg3dkRprk+5/C38Xmx8EUCiA6cdq916GySOrzv1RuLbIZ4H9HHvwxH++4auvCOLP3wkR6D5NTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761832946; c=relaxed/simple;
	bh=zrEJir3QZ69fl7XO95NvsQ2L2LHYydUAe9JzZUEwjb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mzLSW1TqvJ/9EECsilYgBoDaAdJAJbXAAvZKnYhqEDmwF0nST1ZpbudHQE6jLn+Xpr8ibBx4huf+bKm6yinr35niiA23/32doTRxDwkLgWUHx31KYDN7wXhd/huv8cPx+OqID1qEpNUyvHl8gJUDdThFy3OY+r+VUYKPI9UfiFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDpvnhp+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8402C19423
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 14:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761832945;
	bh=zrEJir3QZ69fl7XO95NvsQ2L2LHYydUAe9JzZUEwjb4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KDpvnhp+QElMGFu/LD/Zy65L1wiIuN7biP44Eb0DCj6a1Coia9biitWtNHYR25uUK
	 seOsUrPZSIn+9NcQAN3R+zJM+Xe+3QzV0jYrOhYtPMVCdl+PcrWopi4qN5N1bFwpVr
	 7EIG92TsXd9dUMCGs8a4rd6D3zSBrCLMQ2xhCPXsmwHsRgucpTFL8pv3Qg/Dnf7xsw
	 NNapl4vBrXYgkvhZXzkg2ZMXQiiA1+cSrHeNrc+em5t5BPdnZS6Mtynj9m4kVv6Jos
	 i8QjwQFYMz8MBZfzfQnP6XasyInq+4j8yDzDONT36rUEPoFRM0ndbViTt+1mAI0UdJ
	 E2Qdn4JWiBdwQ==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-654eb78f721so534523eaf.1
        for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 07:02:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW/RtNjcHzMJLfBaizfC3wHodPO3WUQXHVOIycBhbw/ifOAd7oAFU7z560w13oZV3DldBcYV1P7uQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjGq7LZkF56N1RcQzamUdewoOrHTF5kMZw8M66aMIvPK6yc2dh
	9QLoCb5n4bJStqVPZ7xpPddZp3ZHLkNf+bSpV/fbEEfsbLhxPHqI+c1uzgo3ALOxe0pD2Glauiz
	vGYGkxDxmSbwu+GWjFfetbBTARBYO+xs=
X-Google-Smtp-Source: AGHT+IHpNyxa3JPbvIlx6+VsAOwQjUijIrBDh15VYrt5CLSpa/xte5uPTR2r1YP3AZ5c4XghWJKwcLqJndxmzCFm1Zw=
X-Received: by 2002:a05:6820:298f:b0:654:faee:1065 with SMTP id
 006d021491bc7-656823ecd13mr1171752eaf.5.1761832944954; Thu, 30 Oct 2025
 07:02:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016151929.75863-1-ulf.hansson@linaro.org>
 <20251016151929.75863-3-ulf.hansson@linaro.org> <CAJZ5v0hPUYoLFs=jZ10a1cX6TE1bmRF7CkBH1Ebejao9Hdfhnw@mail.gmail.com>
 <CAPDyKFrrhw5vMYLEWJ5LRphVzwPwjiU-n=tdbgOtOmFSXGd0GQ@mail.gmail.com>
 <CAJZ5v0g5p-8WrmNQ6-tvTEy50gVjfEMsmXxTK8bmLqafe30jKw@mail.gmail.com> <CAPDyKFo+U=oJVxXCDBN_WZLBpkwPgv_=qw96hauAttFnAQuPtw@mail.gmail.com>
In-Reply-To: <CAPDyKFo+U=oJVxXCDBN_WZLBpkwPgv_=qw96hauAttFnAQuPtw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 30 Oct 2025 15:02:13 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h_OFzmhcKohS3SNWwz_vwpq6frymXSSgFjk_K27ncSTg@mail.gmail.com>
X-Gm-Features: AWmQ_bnydkgoG27c4UFy_S4ZP7WUKzFOEv6WSzo-r1wl5axX8PWXvHqUZoKB_pY
Message-ID: <CAJZ5v0h_OFzmhcKohS3SNWwz_vwpq6frymXSSgFjk_K27ncSTg@mail.gmail.com>
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

On Thu, Oct 30, 2025 at 1:32=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Thu, 30 Oct 2025 at 13:23, Rafael J. Wysocki <rafael@kernel.org> wrote=
:
> >
> > On Thu, Oct 30, 2025 at 1:00=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro=
.org> wrote:
> > >
> > > On Thu, 30 Oct 2025 at 11:45, Rafael J. Wysocki <rafael@kernel.org> w=
rote:
> > > >
> > > > On Thu, Oct 16, 2025 at 5:19=E2=80=AFPM Ulf Hansson <ulf.hansson@li=
naro.org> wrote:
> > > > >
> > > > > A CPU system-wakeup QoS limit may have been requested by user-spa=
ce. To
> > > > > avoid breaking this constraint when entering a low-power state du=
ring
> > > > > s2idle through genpd, let's extend the corresponding genpd govern=
or for
> > > > > CPUs. More precisely, during s2idle let the genpd governor select=
 a
> > > > > suitable low-power state, by taking into account the QoS limit.
> > > > >
> > > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > ---
> > > > >
> > > > > Changes in v2:
> > > > >         - Limite the change to the genpd governor for CPUs.
> > > > >
> > > > > ---
> > > > >  drivers/pmdomain/core.c     | 10 ++++++++--
> > > > >  drivers/pmdomain/governor.c | 27 +++++++++++++++++++++++++++
> > > > >  include/linux/pm_domain.h   |  1 +
> > > > >  3 files changed, 36 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> > > > > index 61c2277c9ce3..4fd546ef0448 100644
> > > > > --- a/drivers/pmdomain/core.c
> > > > > +++ b/drivers/pmdomain/core.c
> > > > > @@ -1425,8 +1425,14 @@ static void genpd_sync_power_off(struct ge=
neric_pm_domain *genpd, bool use_lock,
> > > > >                         return;
> > > > >         }
> > > > >
> > > > > -       /* Choose the deepest state when suspending */
> > > > > -       genpd->state_idx =3D genpd->state_count - 1;
> > > > > +       if (genpd->gov && genpd->gov->system_power_down_ok) {
> > > > > +               if (!genpd->gov->system_power_down_ok(&genpd->dom=
ain))
> > > > > +                       return;
> > > > > +       } else {
> > > > > +               /* Default to the deepest state. */
> > > > > +               genpd->state_idx =3D genpd->state_count - 1;
> > > > > +       }
> > > > > +
> > > > >         if (_genpd_power_off(genpd, false)) {
> > > > >                 genpd->states[genpd->state_idx].rejected++;
> > > > >                 return;
> > > > > diff --git a/drivers/pmdomain/governor.c b/drivers/pmdomain/gover=
nor.c
> > > > > index 39359811a930..bd1b9d66d4a5 100644
> > > > > --- a/drivers/pmdomain/governor.c
> > > > > +++ b/drivers/pmdomain/governor.c
> > > > > @@ -415,9 +415,36 @@ static bool cpu_power_down_ok(struct dev_pm_=
domain *pd)
> > > > >         return false;
> > > > >  }
> > > > >
> > > > > +static bool cpu_system_power_down_ok(struct dev_pm_domain *pd)
> > > > > +{
> > > > > +       s64 constraint_ns =3D cpu_wakeup_latency_qos_limit() * NS=
EC_PER_USEC;
> > > >
> > > > I'm not sure why genpd needs to take cpu_wakeup_latency_qos_limit()
> > > > into account directly.
> > > >
> > > > It should be told by cpuidle which state has been selected on the C=
PU
> > > > side and it should not go any deeper than that anyway.
> > >
> > > For PSCI OS-initiated mode, cpuidle doesn't know about the states tha=
t
> > > may be shared among a group of CPUs.
> > >
> > > Instead, those states are controlled through the PM domain topology b=
y
> > > genpd and its governor, hence this is needed too.
> >
> > All right, but I'd like to understand how all of that works.
> >
> > So cpuidle selects a state to enter for the given CPU and then genpd
> > is invoked.  It has to take the exit latency of that state into
> > account, so it doesn't go too deep.  How does it do that?
>
> Depending on the state selected, in cpuidle-psci.c we may end up
> calling __psci_enter_domain_idle_state() (only for the deepest
> CPU-state).
>
> For s2idle this means we call dev_pm_genpd_suspend|resume(), to manage
> the reference counting of the PM domains via genpd. This then may lead
> to that genpd_sync_power_off() tries to select a state by calling the
> new governor function above.
>
> Did that make sense?

So IIUC this will only happen if the deepest idle state is selected in
which case the cpu_wakeup_latency_qos_limit() value is greater than
the exit latency of that state, but it may still need to be taken into
account when selecting the domain state.  However, this means that the
exit latency number for the deepest idle state is too low (it should
represent the worst-case exit latency which means the maximum domain
exit latency in this particular case).

Moreover, it looks like the "runtime" cpuidle has the same problem, doesn't=
 it?

