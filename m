Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EACFDED7
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2019 11:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfD2JLj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Apr 2019 05:11:39 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:41816 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbfD2JLj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2019 05:11:39 -0400
Received: by mail-ua1-f68.google.com with SMTP id s30so14779uas.8
        for <linux-pm@vger.kernel.org>; Mon, 29 Apr 2019 02:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=asEe05QML5luh9BkHoaqsaC4xpJfu815zEv+T/idjic=;
        b=SRDYkKT4r4FbZt2UW9vSOSC4A+6AkmqH2u7dMpzN3NIznkVEpleLEFASjo6Vf2FJmW
         yvOGfMUBULgT5Y7H6M0Q0xGDaan8e8l9GXIuazjv4tsS6Rnl6iGwvEJTeoP0hjcM6tls
         P3FT4awK7iqjKaSlWeL06aRFXjxVMThlsJ1vB9m9Ku91pCMmz40oZ3Lu/nyN/L/+0rvn
         PK2n/2tk4tDoPIrScG5zjw4/Nr5nQ3ehRAuCDDU+mW+BVSW92t/MQnfliClwND4DCJZg
         hBJTtQOxVK6w/3hoYDkP2sfMJW94JeYvNxOPaLkCrd4kiI3aL3bAci4WDw5FdO4J695L
         6Iig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=asEe05QML5luh9BkHoaqsaC4xpJfu815zEv+T/idjic=;
        b=i8gLf5ZkOFSEaP4y+L5uorqWANiI2qMyJjks4VE9ZJ0cM0s/hwxh+uT2PerTbQDOeG
         pn5bWOAfTwkKlCQHjYJ3lXh8r8DyttOqdl8diH5VxQrm9Vk5g028PSGy5rCRPS2rRXRF
         LwZBzq+9Jh3uQikuBudYBWddMntzkMqkDVzUXFweNFG+vKTAXTKSloub7VvHTYw8nhj9
         4C1KGMes4kUxUviBrVLrYdlUBuv1ERx3P56uceVFuPYSpOIoGU+0WQoKyT6w63CQ2B7w
         J7gN27e9dHiDnGzaVrgEbx6SNSfdpxesu2Xc18sEWnpIVrEJvVSb0c+yZUS4/Vlgk8cy
         BpAg==
X-Gm-Message-State: APjAAAW7nscJnPjuVgMw+fylPDTwxxjdeNPjAlcYnPPKFOr6ZXKvgn1m
        vydyF27+s9MbRyZbsLqC0IFZqMYI5qwdB2Iq661t4g==
X-Google-Smtp-Source: APXvYqw+Rx9ZZiHnKbSEQh57ahNSu2ujZISqgE/dNALPtLQdwUPVCFJVaxJi5MK+UwBtKhg4V2Gv3tUqE/HKwolbJ0Q=
X-Received: by 2002:ab0:2b13:: with SMTP id e19mr5345382uar.15.1556529098072;
 Mon, 29 Apr 2019 02:11:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556313614.git.leonard.crestez@nxp.com> <68ccb5a90d1d2a596e7ed94ba3245171f013c781.1556313614.git.leonard.crestez@nxp.com>
In-Reply-To: <68ccb5a90d1d2a596e7ed94ba3245171f013c781.1556313614.git.leonard.crestez@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 29 Apr 2019 11:11:02 +0200
Message-ID: <CAPDyKFpCCapBfNbsR1Q+nyg8aenVJWxj9qmTCCCfmONZR3t1sg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] PM / Domains: Add GENPD_FLAG_NO_RUNTIME_OFF flag
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Arulpandiyan Vadivel <Arulpandiyan_Vadivel@mentor.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 26 Apr 2019 at 23:38, Leonard Crestez <leonard.crestez@nxp.com> wrote:
>
> This is for power domains which can only be powered off for suspend but
> not as part of runtime PM.
>
> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/base/power/domain.c | 8 ++++++--
>  include/linux/pm_domain.h   | 4 ++++
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 189d7e14c611..f502218a0ddb 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -126,10 +126,11 @@ static const struct genpd_lock_ops genpd_spin_ops = {
>  #define genpd_status_on(genpd)         (genpd->status == GPD_STATE_ACTIVE)
>  #define genpd_is_irq_safe(genpd)       (genpd->flags & GENPD_FLAG_IRQ_SAFE)
>  #define genpd_is_always_on(genpd)      (genpd->flags & GENPD_FLAG_ALWAYS_ON)
>  #define genpd_is_active_wakeup(genpd)  (genpd->flags & GENPD_FLAG_ACTIVE_WAKEUP)
>  #define genpd_is_cpu_domain(genpd)     (genpd->flags & GENPD_FLAG_CPU_DOMAIN)
> +#define genpd_is_no_runtime_off(genpd) (genpd->flags & GENPD_FLAG_NO_RUNTIME_OFF)

May I suggest to switch the name to, GENPD_FLAG_RUNTIME_ON.

Other than that, this looks good to me!

Kind regards
Uffe

>
>  static inline bool irq_safe_dev_in_no_sleep_domain(struct device *dev,
>                 const struct generic_pm_domain *genpd)
>  {
>         bool ret;
> @@ -513,11 +514,13 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
>         /*
>          * Abort power off for the PM domain in the following situations:
>          * (1) The domain is configured as always on.
>          * (2) When the domain has a subdomain being powered on.
>          */
> -       if (genpd_is_always_on(genpd) || atomic_read(&genpd->sd_count) > 0)
> +       if (genpd_is_always_on(genpd) ||
> +                       genpd_is_no_runtime_off(genpd) ||
> +                       atomic_read(&genpd->sd_count) > 0)
>                 return -EBUSY;
>
>         list_for_each_entry(pdd, &genpd->dev_list, list_node) {
>                 enum pm_qos_flags_status stat;
>
> @@ -1813,11 +1816,12 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>                 genpd->dev_ops.stop = pm_clk_suspend;
>                 genpd->dev_ops.start = pm_clk_resume;
>         }
>
>         /* Always-on domains must be powered on at initialization. */
> -       if (genpd_is_always_on(genpd) && !genpd_status_on(genpd))
> +       if ((genpd_is_always_on(genpd) || genpd_is_no_runtime_off(genpd)) &&
> +                       !genpd_status_on(genpd))
>                 return -EINVAL;
>
>         if (genpd_is_cpu_domain(genpd) &&
>             !zalloc_cpumask_var(&genpd->cpus, GFP_KERNEL))
>                 return -ENOMEM;
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index bc82e74560ee..c9f3137e2c00 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -51,16 +51,20 @@
>   *                             deploy idle power management support for CPUs
>   *                             and groups of CPUs. Note that, the backend
>   *                             driver must then comply with the so called,
>   *                             last-man-standing algorithm, for the CPUs in the
>   *                             PM domain.
> + *
> + * GENPD_FLAG_NO_RUNTIME_OFF:  Instructs genpd to always keep the PM domain
> + *                             powered on except for system suspend.
>   */
>  #define GENPD_FLAG_PM_CLK       (1U << 0)
>  #define GENPD_FLAG_IRQ_SAFE     (1U << 1)
>  #define GENPD_FLAG_ALWAYS_ON    (1U << 2)
>  #define GENPD_FLAG_ACTIVE_WAKEUP (1U << 3)
>  #define GENPD_FLAG_CPU_DOMAIN   (1U << 4)
> +#define GENPD_FLAG_NO_RUNTIME_OFF (1U << 5) /* Never powered off by RPM */
>
>  enum gpd_status {
>         GPD_STATE_ACTIVE = 0,   /* PM domain is active */
>         GPD_STATE_POWER_OFF,    /* PM domain is off */
>  };
> --
> 2.17.1
>
