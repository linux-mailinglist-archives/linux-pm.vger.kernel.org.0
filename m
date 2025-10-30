Return-Path: <linux-pm+bounces-37094-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BB5C1FFD0
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 13:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 668C24E047C
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 12:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DB02F6169;
	Thu, 30 Oct 2025 12:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1dkYUuP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911CD2F546E
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 12:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761827022; cv=none; b=kyIEWIAlWZKfKIhdnHb7UdskHPYwn2lXvE379TfPrlunJPwKeaS1C6oOdGGxb8n9ZvoXI+yQBdUsblHfGgLhofob6y5ciNHY6Eh1yQc8VUlLYj5gq6QPhR3RJI9M3SKuhVE/LpUffh+BBkLZJinr3nzpHDav7Tbq5CkxndfgaPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761827022; c=relaxed/simple;
	bh=Jz9JRjLJ+V8hXGGZ8ONw7HbN/pET31PO1f3hsldZW90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tgt6AKQuW/lcu5d0qNcj080LwFZAlWtl53fQUbYRv08WZcT5pD0B6DG7IoH4m9kzLUPy/uILpLLfkUXBU58sIfmKX+Obe/Hg15ur1L+FGOBiRCiHfiUXSqrGC85PmTcn4Cw0e+wtFw/WRdmnWr6a3m7dyg38mMTYIeCiRugoyNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1dkYUuP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0F9C116B1
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 12:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761827022;
	bh=Jz9JRjLJ+V8hXGGZ8ONw7HbN/pET31PO1f3hsldZW90=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Y1dkYUuPGYJt4LP0DwKL1rIrlch/xv5OeFoe3sHXpxOaBo6JuhK3+QijzpF0E7u7F
	 C7rzdona9Q4OKNwi6bouFo4U2NfEJjbojL7xlateFvRYHzW9pEmc1jxD2+G2eG40Ml
	 c4cZme347mh3SmStCtOJ2H4gq5Ixtq9nHWLAIBwmMoMveGLM8Lszxqo+LlbGb/vowa
	 YtTlCLokEzNr5e7YXwQNaYXTW8TGggS31N/bvL5dObbRX4yajQ+YzEeait2P1u3svF
	 UQ0Upq2xMzMoJV94DKLxXHix66XM7efJeB/CqMD23jKfkrOKveXiK2GL9ylqnipWIr
	 5CprIvhyBN5og==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7c3e2221217so647721a34.3
        for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 05:23:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUeKaF1RwW5BWByt4VKiXCW/r30Ld/ndfDVpKcNOnSJk6TivUM4YsS7zmuoYtCVWdUyCR82OCxL9A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyr6VWOypKcup1UqbLty8cRfEVoue6Ly34fPmNtBphphf2nQ0e
	HJX27vEt/LXxmR0Y8++wBt5Yz8ClNLNvnTAxgBFODiO4E/dYGqEWuzN1jY66YBEqSFqxQBTLiVd
	v4EHxFmEaBSqKVqB3fxi+FvHK3RsKWKw=
X-Google-Smtp-Source: AGHT+IHamJvr710i/xm7TakozVG8IYoy8EFOaLfwGCcrFjLup0GVBYcrJOV5HC3vWdf2nEoIUSlxNwQHcEI5UNsv8rI=
X-Received: by 2002:a05:6830:83ac:b0:7c5:345f:60b0 with SMTP id
 46e09a7af769-7c6830df88emr3615633a34.18.1761827021456; Thu, 30 Oct 2025
 05:23:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016151929.75863-1-ulf.hansson@linaro.org>
 <20251016151929.75863-3-ulf.hansson@linaro.org> <CAJZ5v0hPUYoLFs=jZ10a1cX6TE1bmRF7CkBH1Ebejao9Hdfhnw@mail.gmail.com>
 <CAPDyKFrrhw5vMYLEWJ5LRphVzwPwjiU-n=tdbgOtOmFSXGd0GQ@mail.gmail.com>
In-Reply-To: <CAPDyKFrrhw5vMYLEWJ5LRphVzwPwjiU-n=tdbgOtOmFSXGd0GQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 30 Oct 2025 13:23:30 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g5p-8WrmNQ6-tvTEy50gVjfEMsmXxTK8bmLqafe30jKw@mail.gmail.com>
X-Gm-Features: AWmQ_bnGj_ZpkDvhDL2XMlBX3KkZvqe9pUjj2Kjkm43ptwIFQgzWuDPvfjCzwSQ
Message-ID: <CAJZ5v0g5p-8WrmNQ6-tvTEy50gVjfEMsmXxTK8bmLqafe30jKw@mail.gmail.com>
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

On Thu, Oct 30, 2025 at 1:00=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Thu, 30 Oct 2025 at 11:45, Rafael J. Wysocki <rafael@kernel.org> wrote=
:
> >
> > On Thu, Oct 16, 2025 at 5:19=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro=
.org> wrote:
> > >
> > > A CPU system-wakeup QoS limit may have been requested by user-space. =
To
> > > avoid breaking this constraint when entering a low-power state during
> > > s2idle through genpd, let's extend the corresponding genpd governor f=
or
> > > CPUs. More precisely, during s2idle let the genpd governor select a
> > > suitable low-power state, by taking into account the QoS limit.
> > >
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >
> > > Changes in v2:
> > >         - Limite the change to the genpd governor for CPUs.
> > >
> > > ---
> > >  drivers/pmdomain/core.c     | 10 ++++++++--
> > >  drivers/pmdomain/governor.c | 27 +++++++++++++++++++++++++++
> > >  include/linux/pm_domain.h   |  1 +
> > >  3 files changed, 36 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> > > index 61c2277c9ce3..4fd546ef0448 100644
> > > --- a/drivers/pmdomain/core.c
> > > +++ b/drivers/pmdomain/core.c
> > > @@ -1425,8 +1425,14 @@ static void genpd_sync_power_off(struct generi=
c_pm_domain *genpd, bool use_lock,
> > >                         return;
> > >         }
> > >
> > > -       /* Choose the deepest state when suspending */
> > > -       genpd->state_idx =3D genpd->state_count - 1;
> > > +       if (genpd->gov && genpd->gov->system_power_down_ok) {
> > > +               if (!genpd->gov->system_power_down_ok(&genpd->domain)=
)
> > > +                       return;
> > > +       } else {
> > > +               /* Default to the deepest state. */
> > > +               genpd->state_idx =3D genpd->state_count - 1;
> > > +       }
> > > +
> > >         if (_genpd_power_off(genpd, false)) {
> > >                 genpd->states[genpd->state_idx].rejected++;
> > >                 return;
> > > diff --git a/drivers/pmdomain/governor.c b/drivers/pmdomain/governor.=
c
> > > index 39359811a930..bd1b9d66d4a5 100644
> > > --- a/drivers/pmdomain/governor.c
> > > +++ b/drivers/pmdomain/governor.c
> > > @@ -415,9 +415,36 @@ static bool cpu_power_down_ok(struct dev_pm_doma=
in *pd)
> > >         return false;
> > >  }
> > >
> > > +static bool cpu_system_power_down_ok(struct dev_pm_domain *pd)
> > > +{
> > > +       s64 constraint_ns =3D cpu_wakeup_latency_qos_limit() * NSEC_P=
ER_USEC;
> >
> > I'm not sure why genpd needs to take cpu_wakeup_latency_qos_limit()
> > into account directly.
> >
> > It should be told by cpuidle which state has been selected on the CPU
> > side and it should not go any deeper than that anyway.
>
> For PSCI OS-initiated mode, cpuidle doesn't know about the states that
> may be shared among a group of CPUs.
>
> Instead, those states are controlled through the PM domain topology by
> genpd and its governor, hence this is needed too.

All right, but I'd like to understand how all of that works.

So cpuidle selects a state to enter for the given CPU and then genpd
is invoked.  It has to take the exit latency of that state into
account, so it doesn't go too deep.  How does it do that?

