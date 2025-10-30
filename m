Return-Path: <linux-pm+bounces-37087-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05890C1FA01
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 11:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 868B83BCCA6
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 10:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DB2314D27;
	Thu, 30 Oct 2025 10:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsKNXlGS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CDC2206AC
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 10:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761821111; cv=none; b=Z4dgF0o6ZD+DA4PiJjypYh/es2Bdw4I8pFD+McXAJDD0K8RBkrDeCmFNxdJ9aqhf/EmVDtb27nTEO8FjjofhPVFxj+bb53zO1JWtsrK7X+G6XlC+iN/IcoZymmzCQLpSKbwpvpQXkrmWVeiqSNaBlrzxYafrAUx85oMP4Brz8IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761821111; c=relaxed/simple;
	bh=kDZJex61sWjLiqVb3qJeITth/PMvNL5VNldecXJ/H4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YowSt8aWGD1P8UiHjOdRoubU5taoA7HSQWAp02FRxGBxvcPAN7hjIpCSo7k8XfPwulFMWYU3VsqAYhTeHoi8KmwYU+LtYXvwpa6E9F26EVPyMCsCL/xHiCTq8AigxUl/4rGYb0H7/4a8nZHbblR7X3DUiFtJJ12DxwTehphfmbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsKNXlGS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97387C4CEF1
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 10:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761821110;
	bh=kDZJex61sWjLiqVb3qJeITth/PMvNL5VNldecXJ/H4c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PsKNXlGSbAna+TIx+H4y9oZVfrgkw5e/ata/7W03N+mUa9sfH0dOKkpgHCU1HUbqP
	 D1IAWWN9U6DiavGMd8nGgYIaAo950mj7cCqi5OmPmgkpaxcG5Cw1eSCghavKgS5iLD
	 6Jg1W7RN+Xy0G/Hh0+u8UCvDSE0plap5JzbbIrJKd1ujFrVyhP9PaDzOiW4rdAQPMQ
	 w7ZhPDHbRHdjeYZ62Hba2OzaBsjl4IU0V7wpG3dbAf4iPkT8G6IFxbHJrf06NgmGQE
	 l5zcydzbeimDdWiE4joR+6TcyATYnBo6X27/ssId9kM90cYD+/t+QGjhr8P3st3D20
	 M72eB53SyZ21w==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6567542a9e2so239537eaf.0
        for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 03:45:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW5AApXHUKpwG1K8v/vVOmemKrIq0/jLfFG54i9d3hT4xpbN9Bpue+iNquFRCaGaPdJioMQLMHK6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+HIZcGmix3Ki5Blle1oUrjEvHtrklViniVZaRf7jROrRxFYbH
	te/3dX51mHUsINNojCV7qA1cUYM0ft28kVmdoYRi8pq9XUvM9yv40wUx9enzI/bw0w0Y7/yOCqI
	0eGuNpMvXRuyahqu4MabWjuOCkpGjK+c=
X-Google-Smtp-Source: AGHT+IFknkAGTskMUdjpwIHm/zqyOAs6MpHxUVMLUgqEIuqY7qKNu68fLVYOyH+hSP9v0IEvxTIDt1kXoSHcjPIHewE=
X-Received: by 2002:a05:6820:308d:b0:654:f7f9:6887 with SMTP id
 006d021491bc7-65677db8d66mr2606976eaf.0.1761821109930; Thu, 30 Oct 2025
 03:45:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016151929.75863-1-ulf.hansson@linaro.org> <20251016151929.75863-3-ulf.hansson@linaro.org>
In-Reply-To: <20251016151929.75863-3-ulf.hansson@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 30 Oct 2025 11:44:56 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hPUYoLFs=jZ10a1cX6TE1bmRF7CkBH1Ebejao9Hdfhnw@mail.gmail.com>
X-Gm-Features: AWmQ_blIb5xsRo-F9snUMbaEBJNNnLCkWAWdNfTcZWmTi5mkGniG5fF0ucDkDu4
Message-ID: <CAJZ5v0hPUYoLFs=jZ10a1cX6TE1bmRF7CkBH1Ebejao9Hdfhnw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] pmdomain: Respect the CPU system-wakeup QoS limit
 during s2idle
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Kevin Hilman <khilman@baylibre.com>, Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Saravana Kannan <saravanak@google.com>, 
	Maulik Shah <quic_mkshah@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, 
	Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 5:19=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> A CPU system-wakeup QoS limit may have been requested by user-space. To
> avoid breaking this constraint when entering a low-power state during
> s2idle through genpd, let's extend the corresponding genpd governor for
> CPUs. More precisely, during s2idle let the genpd governor select a
> suitable low-power state, by taking into account the QoS limit.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Changes in v2:
>         - Limite the change to the genpd governor for CPUs.
>
> ---
>  drivers/pmdomain/core.c     | 10 ++++++++--
>  drivers/pmdomain/governor.c | 27 +++++++++++++++++++++++++++
>  include/linux/pm_domain.h   |  1 +
>  3 files changed, 36 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 61c2277c9ce3..4fd546ef0448 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -1425,8 +1425,14 @@ static void genpd_sync_power_off(struct generic_pm=
_domain *genpd, bool use_lock,
>                         return;
>         }
>
> -       /* Choose the deepest state when suspending */
> -       genpd->state_idx =3D genpd->state_count - 1;
> +       if (genpd->gov && genpd->gov->system_power_down_ok) {
> +               if (!genpd->gov->system_power_down_ok(&genpd->domain))
> +                       return;
> +       } else {
> +               /* Default to the deepest state. */
> +               genpd->state_idx =3D genpd->state_count - 1;
> +       }
> +
>         if (_genpd_power_off(genpd, false)) {
>                 genpd->states[genpd->state_idx].rejected++;
>                 return;
> diff --git a/drivers/pmdomain/governor.c b/drivers/pmdomain/governor.c
> index 39359811a930..bd1b9d66d4a5 100644
> --- a/drivers/pmdomain/governor.c
> +++ b/drivers/pmdomain/governor.c
> @@ -415,9 +415,36 @@ static bool cpu_power_down_ok(struct dev_pm_domain *=
pd)
>         return false;
>  }
>
> +static bool cpu_system_power_down_ok(struct dev_pm_domain *pd)
> +{
> +       s64 constraint_ns =3D cpu_wakeup_latency_qos_limit() * NSEC_PER_U=
SEC;

I'm not sure why genpd needs to take cpu_wakeup_latency_qos_limit()
into account directly.

It should be told by cpuidle which state has been selected on the CPU
side and it should not go any deeper than that anyway.

> +       struct generic_pm_domain *genpd =3D pd_to_genpd(pd);
> +       int state_idx =3D genpd->state_count - 1;
> +
> +       if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN)) {
> +               genpd->state_idx =3D state_idx;
> +               return true;
> +       }
> +
> +       /* Find the deepest state for the latency constraint. */
> +       while (state_idx >=3D 0) {
> +               s64 latency_ns =3D genpd->states[state_idx].power_off_lat=
ency_ns +
> +                                genpd->states[state_idx].power_on_latenc=
y_ns;
> +
> +               if (latency_ns <=3D constraint_ns) {
> +                       genpd->state_idx =3D state_idx;
> +                       return true;
> +               }
> +               state_idx--;
> +       }
> +
> +       return false;
> +}
> +
>  struct dev_power_governor pm_domain_cpu_gov =3D {
>         .suspend_ok =3D default_suspend_ok,
>         .power_down_ok =3D cpu_power_down_ok,
> +       .system_power_down_ok =3D cpu_system_power_down_ok,
>  };
>  #endif
>
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index f67a2cb7d781..93ba0143ca47 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -153,6 +153,7 @@ enum genpd_sync_state {
>  };
>
>  struct dev_power_governor {
> +       bool (*system_power_down_ok)(struct dev_pm_domain *domain);
>         bool (*power_down_ok)(struct dev_pm_domain *domain);
>         bool (*suspend_ok)(struct device *dev);
>  };
> --
> 2.43.0
>

