Return-Path: <linux-pm+bounces-37091-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F07C1FE89
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 13:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C3EE84EA560
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 12:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39720311959;
	Thu, 30 Oct 2025 12:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QtYY+ZQJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697723101B4
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 12:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761825657; cv=none; b=SBDRi5gW/Cjrmc2s5rBLpjFTqOALrPdyXPdeADc6Qa5UIHb6ylYgjuMKx+gJCzvbARDcTuEsQQBiQeWfFFQuOwQLIqD86xmljhHUtkT+U0paNItuGpW7TCULU0QFnDdeNZHAFElPmp4nFr49pzIJtntyAZPnU0aIdp8joGXKOLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761825657; c=relaxed/simple;
	bh=54SyMZmH9FzqDh3N6pERYFSkeeuyUtOdVategN+oUys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RmziPDLZVlx4v45MGPm0ZEY6pElSL7jUhQN1110Zk45944hXjJJfSsJeyEBPU6xmJj00f3Vpplb7o9DUjyt5M7s1Kdrn+3X79RK05xRcY7IAkCQ8Z4I2pVULlIq3kf2jl/RaOVfkTZJHNXsbq/7b7+OA9A7ZR2f7XvD9qu/q6f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QtYY+ZQJ; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-63f5c80eebdso1153038d50.0
        for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 05:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761825654; x=1762430454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYhr+HJoJMveWqyfy1hd4hqSptnsc9NzPc3D13MI1rI=;
        b=QtYY+ZQJYSRqX8OQ4HoqevwWKz7kWA4frgFQ8FcOdA7j56XJO4bH5Jdb49PUnSzKtv
         mw0k8SfRPpXbnvNZT1OueagQoppVvxRczBMM/kpLQjL6HgW+E5iepiOW1C+ko4ofczIs
         bjvFKAc4U2ca2DeCIX/NSwm4Lc+zsxJg1Qiu05bK8qzdzanuUrBnX34XqUuj0I0etRX/
         yBfz0RGU8lIXopGnAelc/48FF+CoxE3lRKtxb7N+bpY/1hJPDRjMwQRKPszN9wqBc3ss
         5j/3NURIcAJlR005XYxbZaejBzRk5edGymeeDT0dDGZT47ukT9IEhIuK0Qa/wZ+YQolT
         xvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761825654; x=1762430454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYhr+HJoJMveWqyfy1hd4hqSptnsc9NzPc3D13MI1rI=;
        b=d5NkET8Vnqd3HJlOJ9qa+rNs0yZQwC+UxnUpnTvoYgtifWIcUdviag/eBsKe8l97CR
         29EOYED7CzvA16TTdMUJN5d3Up+uUNpdrVSPdqLH6RmMim72E3KzWOadIUN7XYnuNeuR
         2xcGitZP5212gNMo8G8DQUFhfcWQDfpaDa4bcXJaTjQKqCv2pRPKolN/cTYMCHwC7fTm
         b/+iJAx+2U36Ad0IxPST5GgEgi5KU1OsklTJzFGnvk4vIo2q5GbtI5Dzio0ioVp4U3Nk
         6wRgx+p040PjnEM29Bs31158ooVrpamktOoig+i+sX78LNZsUH0j6pw5Ce5/NZ8CnMNd
         9rrA==
X-Gm-Message-State: AOJu0YwoCrQH/eCXO2JxCiFl26bnTsFfB3lPEEaoH7GVoJdzjHHh0ozP
	ZxfG+QZncWSo5/yYxF5whWXcAjJ+yMIb82mcQ5hlBqT4qHCSWmLtCWf1y6VoM0NjY5qv2wwPluy
	kcL1bZIz2eM4a06MJuOZl7FA1GcXohtAwmPqyl8s/sA==
X-Gm-Gg: ASbGncv8XUbF21P/S6cVmHF88/epmLyFUreZKxBXkdgMHDy+Ir8vhgETiirQW05rUvf
	b67Z81wF0HL22/hDlngyH/M8CRlk3vDHpAWmDYj3KT7mHeBQLKmNt43S53vihch21aGXvpimRCW
	ibhcl7+aIOKfQR0fNvowR35zrmyOBcwkXNzOxri3xQw5YWNlOlKwG7yU+nu9OvfdAjnGj/26Ru7
	CN1hSD98FwFmGSxSVU2HPY0vfSueUHjXSjbYXiJBHjAQUiajgGV7o+fcyMX7mNbPxuhRV2y
X-Google-Smtp-Source: AGHT+IFwU/yW4XfdKrYJwcw+jhqWch8gVaIaJykFOJyUFdNyOSYXkVDyBqdwwTYt9pux6tibMDjm2VozzhLd0d/xGaU=
X-Received: by 2002:a05:690e:2492:b0:63d:46db:b470 with SMTP id
 956f58d0204a3-63f76e18befmr3996375d50.58.1761825654314; Thu, 30 Oct 2025
 05:00:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016151929.75863-1-ulf.hansson@linaro.org>
 <20251016151929.75863-3-ulf.hansson@linaro.org> <CAJZ5v0hPUYoLFs=jZ10a1cX6TE1bmRF7CkBH1Ebejao9Hdfhnw@mail.gmail.com>
In-Reply-To: <CAJZ5v0hPUYoLFs=jZ10a1cX6TE1bmRF7CkBH1Ebejao9Hdfhnw@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 30 Oct 2025 13:00:18 +0100
X-Gm-Features: AWmQ_bnuwcTo-TKxCKTICjYTi0fReGMRRxtUnecDAZkaCnbnabFy1JC0dBcmgJ4
Message-ID: <CAPDyKFrrhw5vMYLEWJ5LRphVzwPwjiU-n=tdbgOtOmFSXGd0GQ@mail.gmail.com>
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

On Thu, 30 Oct 2025 at 11:45, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Oct 16, 2025 at 5:19=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > A CPU system-wakeup QoS limit may have been requested by user-space. To
> > avoid breaking this constraint when entering a low-power state during
> > s2idle through genpd, let's extend the corresponding genpd governor for
> > CPUs. More precisely, during s2idle let the genpd governor select a
> > suitable low-power state, by taking into account the QoS limit.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v2:
> >         - Limite the change to the genpd governor for CPUs.
> >
> > ---
> >  drivers/pmdomain/core.c     | 10 ++++++++--
> >  drivers/pmdomain/governor.c | 27 +++++++++++++++++++++++++++
> >  include/linux/pm_domain.h   |  1 +
> >  3 files changed, 36 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> > index 61c2277c9ce3..4fd546ef0448 100644
> > --- a/drivers/pmdomain/core.c
> > +++ b/drivers/pmdomain/core.c
> > @@ -1425,8 +1425,14 @@ static void genpd_sync_power_off(struct generic_=
pm_domain *genpd, bool use_lock,
> >                         return;
> >         }
> >
> > -       /* Choose the deepest state when suspending */
> > -       genpd->state_idx =3D genpd->state_count - 1;
> > +       if (genpd->gov && genpd->gov->system_power_down_ok) {
> > +               if (!genpd->gov->system_power_down_ok(&genpd->domain))
> > +                       return;
> > +       } else {
> > +               /* Default to the deepest state. */
> > +               genpd->state_idx =3D genpd->state_count - 1;
> > +       }
> > +
> >         if (_genpd_power_off(genpd, false)) {
> >                 genpd->states[genpd->state_idx].rejected++;
> >                 return;
> > diff --git a/drivers/pmdomain/governor.c b/drivers/pmdomain/governor.c
> > index 39359811a930..bd1b9d66d4a5 100644
> > --- a/drivers/pmdomain/governor.c
> > +++ b/drivers/pmdomain/governor.c
> > @@ -415,9 +415,36 @@ static bool cpu_power_down_ok(struct dev_pm_domain=
 *pd)
> >         return false;
> >  }
> >
> > +static bool cpu_system_power_down_ok(struct dev_pm_domain *pd)
> > +{
> > +       s64 constraint_ns =3D cpu_wakeup_latency_qos_limit() * NSEC_PER=
_USEC;
>
> I'm not sure why genpd needs to take cpu_wakeup_latency_qos_limit()
> into account directly.
>
> It should be told by cpuidle which state has been selected on the CPU
> side and it should not go any deeper than that anyway.

For PSCI OS-initiated mode, cpuidle doesn't know about the states that
may be shared among a group of CPUs.

Instead, those states are controlled through the PM domain topology by
genpd and its governor, hence this is needed too.

>
> > +       struct generic_pm_domain *genpd =3D pd_to_genpd(pd);
> > +       int state_idx =3D genpd->state_count - 1;
> > +
> > +       if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN)) {
> > +               genpd->state_idx =3D state_idx;
> > +               return true;
> > +       }
> > +
> > +       /* Find the deepest state for the latency constraint. */
> > +       while (state_idx >=3D 0) {
> > +               s64 latency_ns =3D genpd->states[state_idx].power_off_l=
atency_ns +
> > +                                genpd->states[state_idx].power_on_late=
ncy_ns;
> > +
> > +               if (latency_ns <=3D constraint_ns) {
> > +                       genpd->state_idx =3D state_idx;
> > +                       return true;
> > +               }
> > +               state_idx--;
> > +       }
> > +
> > +       return false;
> > +}
> > +
> >  struct dev_power_governor pm_domain_cpu_gov =3D {
> >         .suspend_ok =3D default_suspend_ok,
> >         .power_down_ok =3D cpu_power_down_ok,
> > +       .system_power_down_ok =3D cpu_system_power_down_ok,
> >  };
> >  #endif
> >
> > diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> > index f67a2cb7d781..93ba0143ca47 100644
> > --- a/include/linux/pm_domain.h
> > +++ b/include/linux/pm_domain.h
> > @@ -153,6 +153,7 @@ enum genpd_sync_state {
> >  };
> >
> >  struct dev_power_governor {
> > +       bool (*system_power_down_ok)(struct dev_pm_domain *domain);
> >         bool (*power_down_ok)(struct dev_pm_domain *domain);
> >         bool (*suspend_ok)(struct device *dev);
> >  };
> > --
> > 2.43.0
> >

Kind regards
Uffe

