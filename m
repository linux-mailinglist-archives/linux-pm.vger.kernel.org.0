Return-Path: <linux-pm+bounces-30577-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78ADBB0023F
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 14:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 829764E183B
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 12:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F00D2586C7;
	Thu, 10 Jul 2025 12:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJ1BGpoz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F140B256C8A;
	Thu, 10 Jul 2025 12:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752151403; cv=none; b=ryz+JNjg5sYSBhgb7qa9AM/+kti3NiwqSxfl5raDNLedU+yMSBv7nOcTIX6N9DE1vlwexJRq7WGam6cQl1qd8Fa8JVYnhPMUu9/s8rt7CEaX5LFfZPnQi0y27ywmYyBdaXQQUc9RNAI6Jl3s2BbfPG3iCn7T4lUbcP1RlgYv5GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752151403; c=relaxed/simple;
	bh=7LR3M2vikCU+8V3dzM8Tw6EVYtXDLd4AoVMr55GULjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UPy+htJFH//upH2geeMFw2kAoEos84Om6GlXYt4v0TDp2JNzicbd233Dsk4hV5wbYvPWnuFtPDxkjV83m9coGALuVnnN6U0KdT4AAPrWFr+iO1F+TlprkzqN6JgoUEbfXBXkwqLZrbNjOhjILm2X+DsTgsMLyDHzHnDeD8V7Mms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJ1BGpoz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C21CC4CEE3;
	Thu, 10 Jul 2025 12:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752151402;
	bh=7LR3M2vikCU+8V3dzM8Tw6EVYtXDLd4AoVMr55GULjw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FJ1BGpozCVVV/FBzKD0hW+Z29tOJ6dQ8DkK+GFFFMP/yxMvN2aMm8e2QEw538QLTG
	 VuqY/S8iMxOfFGvb6XGP8+2ZUHa9+jaC9X9Ee6J5FVidJ7l/o1qz7bYL7P7JYn+aNM
	 dgg4GuwNecn6qUlJ40ce/WTvWQHjUABK91Xl96FK2HSMp4eNDJQudTmut7uDU4l1B4
	 a6Kx3GoktfUZCLrcdXCnbjCFw5R2boGTCFI6EC4hmDkbB2eWptIDFiUqH7bKBHxxI7
	 reJmUlZYLxnCCMWDoGs1CCKm7ZXFZvMmE2NijU1tZdu3nxVdvHTJQO5Ulxi6tBH538
	 +vJdq4kMEy70Q==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6119cd1a154so468110eaf.0;
        Thu, 10 Jul 2025 05:43:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVn+kc+TJVAkgPsfUxaZIqC189P+of/w/SSfGnefyH+mCSEGkSrMbfo0oPH8OIWyF2G0qTzylTnwys6lFw=@vger.kernel.org, AJvYcCW6KfAemclkYe/tclMrzFk7ADIVy2jbevSPmakBj51z88keMYwHhi6hV43QQBaGOUJKqMz9evtVJOQJphBipBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI3EunCRCH0pu00z3N6EkY7VdKPD0wnguC1Aeiknl5+F7o+/49
	pY/kTPcbXB6Hk+1rJEpqrnEXydNT4dB8khMDRLuMGk7gdfEif3+W6yp3+y1lmwnhghQU6PIqDgo
	5iPU7c6OOng2JxLnk0ScUBnXfQ5tLwFM=
X-Google-Smtp-Source: AGHT+IFvhWbPLYj4eyYbQzXbtE0MeMQJy/KvVIVtLmYaFaOZV9FQroiaEG97GUORa6EBLnC28282joaDVpduBrWrdBE=
X-Received: by 2002:a05:6871:e494:b0:2b8:306f:c5ad with SMTP id
 586e51a60fabf-2ff108aa4e7mr1575018fac.13.1752151401837; Thu, 10 Jul 2025
 05:43:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709154728.733920-1-daniel.lezcano@linaro.org>
In-Reply-To: <20250709154728.733920-1-daniel.lezcano@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 10 Jul 2025 14:43:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ixk5hZPPQc_1rDLMTzjh=KpMQF_A2U=HehMTuNSMQwtQ@mail.gmail.com>
X-Gm-Features: Ac12FXwvOAzyR1Avk5_RiGzd1H44RHJhITCmhz1WTwrDf6J5CAzXGMv8nRwyvJ4
Message-ID: <CAJZ5v0ixk5hZPPQc_1rDLMTzjh=KpMQF_A2U=HehMTuNSMQwtQ@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: psci: Fix cpuhotplug routine with PREEMPT_RT=y
To: Daniel Lezcano <daniel.lezcano@linaro.org>, sudeep.holla@arm.com, ulf.hansson@linaro.org
Cc: linux-pm@vger.kernel.org, linux-rt-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Raghavendra Kakarla <quic_rkakarla@quicinc.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, 
	"open list:Real-time Linux (PREEMPT_RT)" <linux-rt-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 5:47=E2=80=AFPM Daniel Lezcano <daniel.lezcano@linar=
o.org> wrote:
>
> Currently cpu hotplug with the PREEMPT_RT option set in the kernel is
> not supported because the underlying generic power domain functions
> used in the cpu hotplug callbacks are incompatible from a lock point
> of view. This situation prevents the suspend to idle to reach the
> deepest idle state for the "cluster" as identified in the
> undermentioned commit.
>
> Use the compatible ones when PREEMPT_RT is enabled and remove the
> boolean disabling the hotplug callbacks with this option.
>
> With this change the platform can reach the deepest idle state
> allowing at suspend time to consume less power.
>
> Tested-on Lenovo T14s with the following script:
>
> echo 0 > /sys/devices/system/cpu/cpu3/online
> BEFORE=3D$(cat /sys/kernel/debug/pm_genpd/power-domain-cpu-cluster0/idle_=
states | grep S0 | awk '{ print $3 }') ;
> rtcwake -s 1 -m mem;
> AFTER=3D$(cat /sys/kernel/debug/pm_genpd/power-domain-cpu-cluster0/idle_s=
tates | grep S0 | awk '{ print $3 }');
> if [ $BEFORE -lt $AFTER ]; then
>     echo "Test successful"
> else
>     echo "Test failed"
> fi
> echo 1 > /sys/devices/system/cpu/cpu3/online
>
> Fixes: 1c4b2932bd62 ("cpuidle: psci: Enable the hierarchical topology for=
 s2idle on PREEMPT_RT")
> Cc: Raghavendra Kakarla <quic_rkakarla@quicinc.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

As per MAINTAINERS, this is for Ulf/Sudeep.

I can pick it up, but at least I need an ACK from them.

Thanks!

> ---
>  drivers/cpuidle/cpuidle-psci.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psc=
i.c
> index 4e1ba35deda9..b19bc60cc627 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -45,7 +45,6 @@ struct psci_cpuidle_domain_state {
>  static DEFINE_PER_CPU_READ_MOSTLY(struct psci_cpuidle_data, psci_cpuidle=
_data);
>  static DEFINE_PER_CPU(struct psci_cpuidle_domain_state, psci_domain_stat=
e);
>  static bool psci_cpuidle_use_syscore;
> -static bool psci_cpuidle_use_cpuhp;
>
>  void psci_set_domain_state(struct generic_pm_domain *pd, unsigned int st=
ate_idx,
>                            u32 state)
> @@ -124,8 +123,12 @@ static int psci_idle_cpuhp_up(unsigned int cpu)
>  {
>         struct device *pd_dev =3D __this_cpu_read(psci_cpuidle_data.dev);
>
> -       if (pd_dev)
> -               pm_runtime_get_sync(pd_dev);
> +       if (pd_dev) {
> +               if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> +                       pm_runtime_get_sync(pd_dev);
> +               else
> +                       dev_pm_genpd_resume(pd_dev);
> +       }
>
>         return 0;
>  }
> @@ -135,7 +138,11 @@ static int psci_idle_cpuhp_down(unsigned int cpu)
>         struct device *pd_dev =3D __this_cpu_read(psci_cpuidle_data.dev);
>
>         if (pd_dev) {
> -               pm_runtime_put_sync(pd_dev);
> +               if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> +                       pm_runtime_put_sync(pd_dev);
> +               else
> +                       dev_pm_genpd_suspend(pd_dev);
> +
>                 /* Clear domain state to start fresh at next online. */
>                 psci_clear_domain_state();
>         }
> @@ -196,9 +203,6 @@ static void psci_idle_init_cpuhp(void)
>  {
>         int err;
>
> -       if (!psci_cpuidle_use_cpuhp)
> -               return;
> -
>         err =3D cpuhp_setup_state_nocalls(CPUHP_AP_CPU_PM_STARTING,
>                                         "cpuidle/psci:online",
>                                         psci_idle_cpuhp_up,
> @@ -259,10 +263,8 @@ static int psci_dt_cpu_init_topology(struct cpuidle_=
driver *drv,
>          * s2ram and s2idle.
>          */
>         drv->states[state_count - 1].enter_s2idle =3D psci_enter_s2idle_d=
omain_idle_state;
> -       if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +       if (!IS_ENABLED(CONFIG_PREEMPT_RT))
>                 drv->states[state_count - 1].enter =3D psci_enter_domain_=
idle_state;
> -               psci_cpuidle_use_cpuhp =3D true;
> -       }
>
>         return 0;
>  }
> @@ -339,7 +341,6 @@ static void psci_cpu_deinit_idle(int cpu)
>
>         dt_idle_detach_cpu(data->dev);
>         psci_cpuidle_use_syscore =3D false;
> -       psci_cpuidle_use_cpuhp =3D false;
>  }
>
>  static int psci_idle_init_cpu(struct device *dev, int cpu)
> --
> 2.43.0
>

