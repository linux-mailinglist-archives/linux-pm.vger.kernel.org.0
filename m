Return-Path: <linux-pm+bounces-37111-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 13654C20D6E
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 16:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 963704E77A0
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 15:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA4F281531;
	Thu, 30 Oct 2025 15:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GG9E2/Mz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F31C35975
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 15:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761836854; cv=none; b=RqNaV3AB9UDJIRFNK9/vRujzjTQInsnXADa4/QBc8BiURjMCa2IAQJVUb/k76Ih7duDw2hD/R69r/mV20cp7jX9CVFUqwWQWssmmRQw2+RDjyhgZB+N7M5xciJXwQo+ipUrN94krMQZawU924u/D2+Emy23TvA4jLewazBByOho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761836854; c=relaxed/simple;
	bh=KgC6NGaxPUGhFrOoElnRrjEtaLMvolXJzHTEPQbdczI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cp3plpgQV9Cjsou+/PbYcagsXGDKLdgSt4TsN80/7xomXwjNZVugTsHg/Xo2x70GT01zgrvrB+S7FJR2nNQ2gcIk9uewQ/tB3ecj8HW2R/t8lWIf+qoTR4XBBHzbmgJXcKnb5gLXAP8EosuFlYM4UmRW/MYwUoZ1yfLegC/ZX4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GG9E2/Mz; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-63e0dd765a0so1256973d50.3
        for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 08:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761836851; x=1762441651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/0qQFK53Z808UpOfBzawR8nn77ahZxYZ7wJQicysac=;
        b=GG9E2/MzrJ5X/K7qiOPywoDN5gNNERJLnjxVOdwLKGz2+buTezc0JuPpvtTkQNlXzB
         Mkg0U12Y/4HDIqlkDxgNwBltxWeQQVKTAMVU6ZUp+FN8eTTkWDMiKSCspj5j6WNCUhdS
         xuQgxkOcVuiN2Nv4Xc9DXpGREXCa8wG27osI3szWWtso4xwJ/FYKR0Efh7cYTvwocieI
         5ZmLqk9GVAfFQ71dkJHvrLeyhn9+278FX9CPr9stwu/runr04bvm4249nbZfQTapJ3sr
         W4DzOCmt7GIZjzlGFxXzJmNvAGrEv7aKA+UMbfvX5QDSH1yhWVame+JGcKishVW6ZNdE
         zouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761836851; x=1762441651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p/0qQFK53Z808UpOfBzawR8nn77ahZxYZ7wJQicysac=;
        b=FLxgU33CUsLOVS2vu2K3GfKPj2bfH4C9h1rkDlypjBGe6XA5piWMD2kyZSrwPspcy9
         LAp5pIN7lbmAIWaHCwQ50dSxD8TKcAcBYNBzdMwnIXrgGzxHNBgOVTg/6R0F9ve879cX
         y5wIYaOsyDdLovXPx/f8n3beu8veQ4n/485LrsrAZxMAjWSiZAHyfvJQlXhnqnFgAD6l
         XPU+7ELdCGB9RRhYWwLEEGKaNSU4cU+L6Zi/ga5jQcqdw1bu7FY5JlkA9A/qpRsdFHSd
         EgQAihdhNcvFEsi0GwneLNvfbIvR8oWwefdoW4lGqQKZ36ns8MRFaOnyqUugAqgYzHEk
         UlGQ==
X-Gm-Message-State: AOJu0YwFn6Dvdz81I6RJgoUC/vKSqji2kS00xDBbWm2uULf8WIZTH1zR
	pVXAp8ZxOaiqPgebwy+UdvU3lVdyUiF6nQJPQ1o0Wlq5h6Y0L+jTsuoL0il5SrTml0noOFistpa
	G0DCMvrg/BQVlqJXzWpchw54dOignCkpJ0l1FsYEO9g==
X-Gm-Gg: ASbGncsl0C+VRhjDGjRrSTB61cDZWCCahunkmmZgUPBsv7EhOZRHyKaBq71udI5Qy/J
	DKEcuQYiA3eGVzCDWoMlOGhGRVanfL8/nkZBqZgYE67hEeXuLyNxlWwb+aDc3OFHgM6bHbvjJf1
	gblo6ISNjiiDpVliJ9peKvdamg6r/c7AkBLQfb0QOXGnQ8GW3gyuLxUR3+NuSSnnBtxQiv6HdVi
	5tKAjHP7dLCNJyfqdIkNZfjebQ2McxTmjOK+mRYtCrnNxq5LrskhOZl1DaqZnNp4cuzA8uY
X-Google-Smtp-Source: AGHT+IHwZeQM6nMpkYkA2CPqv9oK/9vEwPHsNTDG8rhtyVjbEhzSyhoshV1VLbQwrEg2tNCMdGKVAjInor1CjxpjwvI=
X-Received: by 2002:a05:690c:7485:b0:77f:b51f:6dc1 with SMTP id
 00721157ae682-786390d326emr58823157b3.52.1761836851141; Thu, 30 Oct 2025
 08:07:31 -0700 (PDT)
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
 <CAPDyKFo+U=oJVxXCDBN_WZLBpkwPgv_=qw96hauAttFnAQuPtw@mail.gmail.com> <CAJZ5v0h_OFzmhcKohS3SNWwz_vwpq6frymXSSgFjk_K27ncSTg@mail.gmail.com>
In-Reply-To: <CAJZ5v0h_OFzmhcKohS3SNWwz_vwpq6frymXSSgFjk_K27ncSTg@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 30 Oct 2025 16:06:54 +0100
X-Gm-Features: AWmQ_bm9uMnGPY7sEux-ZkYeKqC5RFvljpSjFuS7qdYT0K3F97bgxn2HpiYjwQo
Message-ID: <CAPDyKFqs_Mn57SxPNy5_e56LuFxx3KkfJfHqgg9_wp77rpn7Pw@mail.gmail.com>
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

On Thu, 30 Oct 2025 at 15:02, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Oct 30, 2025 at 1:32=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > On Thu, 30 Oct 2025 at 13:23, Rafael J. Wysocki <rafael@kernel.org> wro=
te:
> > >
> > > On Thu, Oct 30, 2025 at 1:00=E2=80=AFPM Ulf Hansson <ulf.hansson@lina=
ro.org> wrote:
> > > >
> > > > On Thu, 30 Oct 2025 at 11:45, Rafael J. Wysocki <rafael@kernel.org>=
 wrote:
> > > > >
> > > > > On Thu, Oct 16, 2025 at 5:19=E2=80=AFPM Ulf Hansson <ulf.hansson@=
linaro.org> wrote:
> > > > > >
> > > > > > A CPU system-wakeup QoS limit may have been requested by user-s=
pace. To
> > > > > > avoid breaking this constraint when entering a low-power state =
during
> > > > > > s2idle through genpd, let's extend the corresponding genpd gove=
rnor for
> > > > > > CPUs. More precisely, during s2idle let the genpd governor sele=
ct a
> > > > > > suitable low-power state, by taking into account the QoS limit.
> > > > > >
> > > > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > > ---
> > > > > >
> > > > > > Changes in v2:
> > > > > >         - Limite the change to the genpd governor for CPUs.
> > > > > >
> > > > > > ---
> > > > > >  drivers/pmdomain/core.c     | 10 ++++++++--
> > > > > >  drivers/pmdomain/governor.c | 27 +++++++++++++++++++++++++++
> > > > > >  include/linux/pm_domain.h   |  1 +
> > > > > >  3 files changed, 36 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> > > > > > index 61c2277c9ce3..4fd546ef0448 100644
> > > > > > --- a/drivers/pmdomain/core.c
> > > > > > +++ b/drivers/pmdomain/core.c
> > > > > > @@ -1425,8 +1425,14 @@ static void genpd_sync_power_off(struct =
generic_pm_domain *genpd, bool use_lock,
> > > > > >                         return;
> > > > > >         }
> > > > > >
> > > > > > -       /* Choose the deepest state when suspending */
> > > > > > -       genpd->state_idx =3D genpd->state_count - 1;
> > > > > > +       if (genpd->gov && genpd->gov->system_power_down_ok) {
> > > > > > +               if (!genpd->gov->system_power_down_ok(&genpd->d=
omain))
> > > > > > +                       return;
> > > > > > +       } else {
> > > > > > +               /* Default to the deepest state. */
> > > > > > +               genpd->state_idx =3D genpd->state_count - 1;
> > > > > > +       }
> > > > > > +
> > > > > >         if (_genpd_power_off(genpd, false)) {
> > > > > >                 genpd->states[genpd->state_idx].rejected++;
> > > > > >                 return;
> > > > > > diff --git a/drivers/pmdomain/governor.c b/drivers/pmdomain/gov=
ernor.c
> > > > > > index 39359811a930..bd1b9d66d4a5 100644
> > > > > > --- a/drivers/pmdomain/governor.c
> > > > > > +++ b/drivers/pmdomain/governor.c
> > > > > > @@ -415,9 +415,36 @@ static bool cpu_power_down_ok(struct dev_p=
m_domain *pd)
> > > > > >         return false;
> > > > > >  }
> > > > > >
> > > > > > +static bool cpu_system_power_down_ok(struct dev_pm_domain *pd)
> > > > > > +{
> > > > > > +       s64 constraint_ns =3D cpu_wakeup_latency_qos_limit() * =
NSEC_PER_USEC;
> > > > >
> > > > > I'm not sure why genpd needs to take cpu_wakeup_latency_qos_limit=
()
> > > > > into account directly.
> > > > >
> > > > > It should be told by cpuidle which state has been selected on the=
 CPU
> > > > > side and it should not go any deeper than that anyway.
> > > >
> > > > For PSCI OS-initiated mode, cpuidle doesn't know about the states t=
hat
> > > > may be shared among a group of CPUs.
> > > >
> > > > Instead, those states are controlled through the PM domain topology=
 by
> > > > genpd and its governor, hence this is needed too.
> > >
> > > All right, but I'd like to understand how all of that works.
> > >
> > > So cpuidle selects a state to enter for the given CPU and then genpd
> > > is invoked.  It has to take the exit latency of that state into
> > > account, so it doesn't go too deep.  How does it do that?
> >
> > Depending on the state selected, in cpuidle-psci.c we may end up
> > calling __psci_enter_domain_idle_state() (only for the deepest
> > CPU-state).
> >
> > For s2idle this means we call dev_pm_genpd_suspend|resume(), to manage
> > the reference counting of the PM domains via genpd. This then may lead
> > to that genpd_sync_power_off() tries to select a state by calling the
> > new governor function above.
> >
> > Did that make sense?
>
> So IIUC this will only happen if the deepest idle state is selected in
> which case the cpu_wakeup_latency_qos_limit() value is greater than
> the exit latency of that state, but it may still need to be taken into
> account when selecting the domain state.  However, this means that the

Correct.

> exit latency number for the deepest idle state is too low (it should
> represent the worst-case exit latency which means the maximum domain
> exit latency in this particular case).

Yes, from the cpuidle state-selection point of view, but how is that a prob=
lem?

If the genpd-governor doesn't find a suitable "domain-idle-state", we
fallback to using the one cpuidle selected.

>
> Moreover, it looks like the "runtime" cpuidle has the same problem, doesn=
't it?

It works in a very similar way, but I fail to understand why you think
there is a problem.

Kind regards
Uffe

