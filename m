Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5D8215A66E
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 11:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgBLKcv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 05:32:51 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:32826 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgBLKcv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2020 05:32:51 -0500
Received: by mail-ot1-f68.google.com with SMTP id b18so1431780otp.0;
        Wed, 12 Feb 2020 02:32:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gzv9rt4/sNqw8bJZ2qsq654js0pdgt12w5ZQU73AU3k=;
        b=Mh1sLVZt+D8gsL7IxIkjsA7q6wmOMGNgxfTe286J6KfCVyEthFRWT8vDWe3MMqFuUJ
         bfPHvatcdxwUC6s7fV2oB46SRlbDcFTCQdbcJ4uyV7lqKBlHQ3S7g0E91SpitwjFyhrI
         anFLefv1Kfp6vNECrzbEFJfkkVivUS53CotdK2nDtXojjOmM5dCzelxo8QsJfTCx5b3i
         u8EWrclg0ce6uXFJLbSTJzgBzxCdmX6TDpiizY5FsC5eWbUsgflIgKOG4d7LtMie2cNM
         xMx0FFT4pqLiopmYlI91Q1CMLjr6jmrmNnE49wYpj0hflBXdkiT7dOGvtxLzd4XHloMc
         SYkA==
X-Gm-Message-State: APjAAAXBORr/c8gi4O9PqfjUZpUJR9Qy0UOTz29edcoO12y9yGGQRcwH
        Nq+bYWe8gSTYWZFl/r2b0K0Emv3+Jl1F11sdezg=
X-Google-Smtp-Source: APXvYqyy0kS7yyyUWf4LuMflnzcOEsRX4eqdYDT7PPvW+fTKcUJ6nyzjykovZhYc07IsNLnHlvxZIEw2/zbxRrszOjs=
X-Received: by 2002:a9d:7559:: with SMTP id b25mr8433715otl.189.1581503570435;
 Wed, 12 Feb 2020 02:32:50 -0800 (PST)
MIME-Version: 1.0
References: <1654227.8mz0SueHsU@kreacher> <1759702.XAW9B0MHEz@kreacher>
In-Reply-To: <1759702.XAW9B0MHEz@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 12 Feb 2020 11:32:39 +0100
Message-ID: <CAJZ5v0g7H=hQPZ18qtzXv_c_w_QL1i4vuKcogygipcH2vz689Q@mail.gmail.com>
Subject: Re: [PATCH 16/28] drm: i915: Call cpu_latency_qos_*() instead of pm_qos_*()
To:     intel-gfx <intel-gfx@lists.freedesktop.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Feb 12, 2020 at 12:40 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> Call cpu_latency_qos_add/update/remove_request() instead of
> pm_qos_add/update/remove_request(), respectively, because the
> latter are going to be dropped.
>
> No intentional functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Please note that the whole series is available here:

https://lore.kernel.org/linux-pm/1654227.8mz0SueHsU@kreacher/

> ---
>  drivers/gpu/drm/i915/display/intel_dp.c |  4 ++--
>  drivers/gpu/drm/i915/i915_drv.c         | 12 +++++-------
>  drivers/gpu/drm/i915/intel_sideband.c   |  5 +++--
>  3 files changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index c7424e2a04a3..208457005a11 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -1360,7 +1360,7 @@ intel_dp_aux_xfer(struct intel_dp *intel_dp,
>          * lowest possible wakeup latency and so prevent the cpu from going into
>          * deep sleep states.
>          */
> -       pm_qos_update_request(&i915->pm_qos, 0);
> +       cpu_latency_qos_update_request(&i915->pm_qos, 0);
>
>         intel_dp_check_edp(intel_dp);
>
> @@ -1488,7 +1488,7 @@ intel_dp_aux_xfer(struct intel_dp *intel_dp,
>
>         ret = recv_bytes;
>  out:
> -       pm_qos_update_request(&i915->pm_qos, PM_QOS_DEFAULT_VALUE);
> +       cpu_latency_qos_update_request(&i915->pm_qos, PM_QOS_DEFAULT_VALUE);
>
>         if (vdd)
>                 edp_panel_vdd_off(intel_dp, false);
> diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
> index f7385abdd74b..74481a189cfc 100644
> --- a/drivers/gpu/drm/i915/i915_drv.c
> +++ b/drivers/gpu/drm/i915/i915_drv.c
> @@ -502,8 +502,7 @@ static int i915_driver_early_probe(struct drm_i915_private *dev_priv)
>         mutex_init(&dev_priv->backlight_lock);
>
>         mutex_init(&dev_priv->sb_lock);
> -       pm_qos_add_request(&dev_priv->sb_qos,
> -                          PM_QOS_CPU_DMA_LATENCY, PM_QOS_DEFAULT_VALUE);
> +       cpu_latency_qos_add_request(&dev_priv->sb_qos, PM_QOS_DEFAULT_VALUE);
>
>         mutex_init(&dev_priv->av_mutex);
>         mutex_init(&dev_priv->wm.wm_mutex);
> @@ -568,7 +567,7 @@ static void i915_driver_late_release(struct drm_i915_private *dev_priv)
>         vlv_free_s0ix_state(dev_priv);
>         i915_workqueues_cleanup(dev_priv);
>
> -       pm_qos_remove_request(&dev_priv->sb_qos);
> +       cpu_latency_qos_remove_request(&dev_priv->sb_qos);
>         mutex_destroy(&dev_priv->sb_lock);
>  }
>
> @@ -1226,8 +1225,7 @@ static int i915_driver_hw_probe(struct drm_i915_private *dev_priv)
>                 }
>         }
>
> -       pm_qos_add_request(&dev_priv->pm_qos, PM_QOS_CPU_DMA_LATENCY,
> -                          PM_QOS_DEFAULT_VALUE);
> +       cpu_latency_qos_add_request(&dev_priv->pm_qos, PM_QOS_DEFAULT_VALUE);
>
>         intel_gt_init_workarounds(dev_priv);
>
> @@ -1273,7 +1271,7 @@ static int i915_driver_hw_probe(struct drm_i915_private *dev_priv)
>  err_msi:
>         if (pdev->msi_enabled)
>                 pci_disable_msi(pdev);
> -       pm_qos_remove_request(&dev_priv->pm_qos);
> +       cpu_latency_qos_remove_request(&dev_priv->pm_qos);
>  err_mem_regions:
>         intel_memory_regions_driver_release(dev_priv);
>  err_ggtt:
> @@ -1296,7 +1294,7 @@ static void i915_driver_hw_remove(struct drm_i915_private *dev_priv)
>         if (pdev->msi_enabled)
>                 pci_disable_msi(pdev);
>
> -       pm_qos_remove_request(&dev_priv->pm_qos);
> +       cpu_latency_qos_remove_request(&dev_priv->pm_qos);
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/i915/intel_sideband.c b/drivers/gpu/drm/i915/intel_sideband.c
> index cbfb7171d62d..0648eda309e4 100644
> --- a/drivers/gpu/drm/i915/intel_sideband.c
> +++ b/drivers/gpu/drm/i915/intel_sideband.c
> @@ -60,7 +60,7 @@ static void __vlv_punit_get(struct drm_i915_private *i915)
>          * to the Valleyview P-unit and not all sideband communications.
>          */
>         if (IS_VALLEYVIEW(i915)) {
> -               pm_qos_update_request(&i915->sb_qos, 0);
> +               cpu_latency_qos_update_request(&i915->sb_qos, 0);
>                 on_each_cpu(ping, NULL, 1);
>         }
>  }
> @@ -68,7 +68,8 @@ static void __vlv_punit_get(struct drm_i915_private *i915)
>  static void __vlv_punit_put(struct drm_i915_private *i915)
>  {
>         if (IS_VALLEYVIEW(i915))
> -               pm_qos_update_request(&i915->sb_qos, PM_QOS_DEFAULT_VALUE);
> +               cpu_latency_qos_update_request(&i915->sb_qos,
> +                                              PM_QOS_DEFAULT_VALUE);
>
>         iosf_mbi_punit_release();
>  }
> --
> 2.16.4
>
>
>
>
>
