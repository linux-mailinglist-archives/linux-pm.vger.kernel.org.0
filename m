Return-Path: <linux-pm+bounces-30787-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA015B03D0E
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 13:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E267917E4DD
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 11:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B53246760;
	Mon, 14 Jul 2025 11:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d9+90KlZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2742246763
	for <linux-pm@vger.kernel.org>; Mon, 14 Jul 2025 11:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752491607; cv=none; b=ipCZeu/Lkq0DiUBblSAiRHTfFFmmTZ1O3Rh+bYJZUXluYdNm6wTNsEltMwzwEdyYNPHjizUST44hd7Xo9S2rO1vmJ4pjYJV27tbPazsH/a2NDNhW+k4mKVy9FUofLH5Sf++y12P4lpcVb65Lgj9gGAr9xBpDJEP4gOYKD+/6zMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752491607; c=relaxed/simple;
	bh=ZA5jvG8pGJZD7/FvjspI+R76IwjgXaVGgj+MLHimBqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R3A9Kzs1vgBJlARtClfg5JE6JKa6WU8bqD8ZB8d3wN+uqa0W9WW4ntoA5IQ+UOITZrGpTeKnYDLMfugk/C/nbIbCga2F+1tUWVRG5BRV8tThrXW/NjeZzWB1jPMGU2k/+toNDtke1oesHmq/+eRsUZNgnh90gT8UJR62skYPl8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d9+90KlZ; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-714067ecea3so31769117b3.0
        for <linux-pm@vger.kernel.org>; Mon, 14 Jul 2025 04:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752491604; x=1753096404; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iYsZgpGyc92tylgoOl1ueE7I+vTEL4X4JFlPanY31ls=;
        b=d9+90KlZTNhEkbRePV8b79DVkIpZB1prC6b7Q6d6bJLi6v2PTmfpw/r58fWKWJqpo1
         q3V63iRbDQDjJd7LU7ZmDYqZKzGsWjPmE9cZnkyNoB1MQpnbtdseWlSvZlNCrGvwEIz5
         xwfJ4rXEZtR03/Gg6HDUr3IW0ereXNCnrn5FnocHQ/TZ9ZaHvXRAURfnngGvpUVU0Y/I
         1IHSp8dxnaTjHAN7Q2wMFzv5mlo0T+8yzbGuYH8aTJxCTsv8yEf1El/QDLoOBJ2kL8oS
         8i3d1Qw5328OahATc8Z9uOt6a+Ktr3XLJELVAx0jkHRenMSahIUOHg9CKe9EO4sk0Dsy
         ouSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752491604; x=1753096404;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iYsZgpGyc92tylgoOl1ueE7I+vTEL4X4JFlPanY31ls=;
        b=uNcA+x9jVO9nAlz9S0jAixOzhH+ca8tB+6I0vIc9Hed8kQB7ZiU4qHGGSWMJZpWXxZ
         Ll2HkMw9hbooCC11cesgDC7WMzvKBeNnkXM64Q5ssVSGuaGuwRfRKfb27udo4tf5YwUr
         2hzZJHPi639UZjX6DPRSCDqWQ7WwG/6jL2jO8WaI+r+wrq8EmxKL7KuDP7mrYu23I58V
         6xLvr9dmEtZSq4gD928ksuWvdPs7vOVS9qhs5K0ELIPK4bWVLMeXS/TUNUc4HGDV8y3G
         aKplwVTI3wkWQutP1km5yBWWGsfeYcN2q3fljG0MZ+ICHErUQ3IyqdYCJslvcP9vNZdG
         f/fg==
X-Forwarded-Encrypted: i=1; AJvYcCXPJmY4YF0yHyuuhpwgd1AekJ+8/WdU971qVPEpBjHYFf71PU6t7CFXW8DvEKsjRvqpiADunKA5Cw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy85EoAgJTFtfXqRJbQh+KgUTBwaESuCdDK4fFLlVzFR3lsl5Fq
	t083XIFyTJWe5f8t8iIM5Yq0TX8W92dNVZE+Zi2O5Ii12xsXFho+K2S0IOZ1eyciVjjR62V+0rg
	ZFMQRrOD4r+31EduIjCOFedoB2iZuVJ29rntHWnxs1Q==
X-Gm-Gg: ASbGncvTwx8D1AOhh/cKHvr3nOeSJqZHD5dvdn1JoiClPqI2fLXTrvm8KdUWH24YZwH
	k+RFjBo0inOmt7xuKibnTXO4w17x1uRjwAsKK+TArgQR95NOrLwrHaGuFvzqHVW2P2FXhc+4WnZ
	ClHzexKltC+WeiowSwTLF2h+K2gpEag1t4F8cozDs7N3LzZF/1/+/00avCXRMPNr/1a826M/QQQ
	iCN3c98
X-Google-Smtp-Source: AGHT+IEo5nowTE/kmucDEHrishTa1XrYiiyuTFtayRgTTm+E8uO5OzwI/Scst1QOoi4vBiyg+Oy6sxmd+YJaGyA1WnM=
X-Received: by 2002:a05:690c:d19:b0:70d:ffaf:48df with SMTP id
 00721157ae682-717d786dda1mr175760437b3.3.1752491603539; Mon, 14 Jul 2025
 04:13:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709154728.733920-1-daniel.lezcano@linaro.org>
In-Reply-To: <20250709154728.733920-1-daniel.lezcano@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 14 Jul 2025 13:12:47 +0200
X-Gm-Features: Ac12FXxaeX7OXBuCkXJ-j03hUCK21Ze9ZEebSgiQ5mn7RsuZUrOhhvlhJZv3Zm8
Message-ID: <CAPDyKFp9up-okoVZf5j+LFvpCOFgLjS8FY1eEqoaDU8remD8Hg@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: psci: Fix cpuhotplug routine with PREEMPT_RT=y
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rafael@kernel.org, sudeep.holla@arm.com, linux-pm@vger.kernel.org, 
	linux-rt-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Raghavendra Kakarla <quic_rkakarla@quicinc.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	"open list:Real-time Linux (PREEMPT_RT)" <linux-rt-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Jul 2025 at 17:47, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
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
> BEFORE=$(cat /sys/kernel/debug/pm_genpd/power-domain-cpu-cluster0/idle_states | grep S0 | awk '{ print $3 }') ;
> rtcwake -s 1 -m mem;
> AFTER=$(cat /sys/kernel/debug/pm_genpd/power-domain-cpu-cluster0/idle_states | grep S0 | awk '{ print $3 }');
> if [ $BEFORE -lt $AFTER ]; then
>     echo "Test successful"
> else
>     echo "Test failed"
> fi
> echo 1 > /sys/devices/system/cpu/cpu3/online
>
> Fixes: 1c4b2932bd62 ("cpuidle: psci: Enable the hierarchical topology for s2idle on PREEMPT_RT")
> Cc: Raghavendra Kakarla <quic_rkakarla@quicinc.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Applied for fixes and by adding a stable-tag, thanks!

Kind regards
Uffe

> ---
>  drivers/cpuidle/cpuidle-psci.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> index 4e1ba35deda9..b19bc60cc627 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -45,7 +45,6 @@ struct psci_cpuidle_domain_state {
>  static DEFINE_PER_CPU_READ_MOSTLY(struct psci_cpuidle_data, psci_cpuidle_data);
>  static DEFINE_PER_CPU(struct psci_cpuidle_domain_state, psci_domain_state);
>  static bool psci_cpuidle_use_syscore;
> -static bool psci_cpuidle_use_cpuhp;
>
>  void psci_set_domain_state(struct generic_pm_domain *pd, unsigned int state_idx,
>                            u32 state)
> @@ -124,8 +123,12 @@ static int psci_idle_cpuhp_up(unsigned int cpu)
>  {
>         struct device *pd_dev = __this_cpu_read(psci_cpuidle_data.dev);
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
>         struct device *pd_dev = __this_cpu_read(psci_cpuidle_data.dev);
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
>         err = cpuhp_setup_state_nocalls(CPUHP_AP_CPU_PM_STARTING,
>                                         "cpuidle/psci:online",
>                                         psci_idle_cpuhp_up,
> @@ -259,10 +263,8 @@ static int psci_dt_cpu_init_topology(struct cpuidle_driver *drv,
>          * s2ram and s2idle.
>          */
>         drv->states[state_count - 1].enter_s2idle = psci_enter_s2idle_domain_idle_state;
> -       if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +       if (!IS_ENABLED(CONFIG_PREEMPT_RT))
>                 drv->states[state_count - 1].enter = psci_enter_domain_idle_state;
> -               psci_cpuidle_use_cpuhp = true;
> -       }
>
>         return 0;
>  }
> @@ -339,7 +341,6 @@ static void psci_cpu_deinit_idle(int cpu)
>
>         dt_idle_detach_cpu(data->dev);
>         psci_cpuidle_use_syscore = false;
> -       psci_cpuidle_use_cpuhp = false;
>  }
>
>  static int psci_idle_init_cpu(struct device *dev, int cpu)
> --
> 2.43.0
>

