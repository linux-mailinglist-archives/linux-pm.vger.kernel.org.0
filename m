Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2818D1167C
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 11:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfEBJUd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 May 2019 05:20:33 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:45302 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfEBJUd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 May 2019 05:20:33 -0400
Received: by mail-ua1-f65.google.com with SMTP id o33so461943uae.12
        for <linux-pm@vger.kernel.org>; Thu, 02 May 2019 02:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xElEiZiW+8pu34Zn/H1CxAQ/kgDPK4LUq386AHxjTlQ=;
        b=TSrUyX60EKf6hnSX7n348JqnAjc7CBmjuRHTMxv8ZRRlCVrqQpxWKtDVQRN2PvXIO3
         ZHmMt3HUk46j0W0Be7mbksA7LdN5DH+kttwaGS4VTFHt6vtKiJxdNvs67mUOWzvK55TD
         yP5cSjNs++Ak6Lor67tyTxHuTl0TxNnsThe0ya0HJEBaKOytky5uV4oga/GqfRT2Vhfy
         6RhHVOfgzNEnkNTfARi/sWriYwMuRwmYgO0Dl7dhzYxQ9pgHkxeeb0yRb/qsPvPdRLj1
         vVKzHaBNxKHOjyfkiJv+9dQAROaEq1XkwGtGvx/nN9qx0Qy5knNQYuLBDeTVeIzVjrVE
         m7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xElEiZiW+8pu34Zn/H1CxAQ/kgDPK4LUq386AHxjTlQ=;
        b=UJXcUxuDtZ1svZnnDDBMY3kWADZUqjdC5Y40PUV7k26f/XE4pBb1ngFbgn554IGo8n
         nvtFVaxPnkeCH9PTVUcRFgT67NIgjt8+NfzTEqa3MDXst+4a8kAaVob3iPNvrmg1KaUK
         5cs3A1uMB7aO5+dKQyAidgWhwfqSr8rnm57B5X8eROGaR0iI6NeDqUcM9T1q358t28Uw
         YhtCD9YPdtw20wzDjgXe5QdRMzRNW9jPhozSGdt0mN8ZN91AyzTv7a3ZrZgHbJczR/fT
         QkJ304hIsb64S2+QLcnzUj6U9aYm385UaAkwZXtbz5XukgRNDHHjcYxayWJxsC1F37RW
         IU5A==
X-Gm-Message-State: APjAAAW43EOaklfCELIHSNtWu9TM3SWLC/cjYFTIwyVabg4web4q8Gtp
        PiaiScE8tRe5pB8sJ/Rk8h12zw0J8M67scgLS13qHw==
X-Google-Smtp-Source: APXvYqxK5+VCynD8AlQT1IPEh2GNHLKAOGm07nTDMrk1pHiwKvHvUgYfslLeMERoH23TMyIaN1jJYB6R96qGLM5DQa0=
X-Received: by 2002:ab0:2a53:: with SMTP id p19mr1214638uar.100.1556788831779;
 Thu, 02 May 2019 02:20:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556636234.git.leonard.crestez@nxp.com> <30247a52be55c3cb31d16b8ac0710d3ad51eea09.1556636234.git.leonard.crestez@nxp.com>
In-Reply-To: <30247a52be55c3cb31d16b8ac0710d3ad51eea09.1556636234.git.leonard.crestez@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 2 May 2019 11:19:55 +0200
Message-ID: <CAPDyKFr7wOpS9OCsy_ENxoXuEeGujY5A9DjnG0O+UiD5s51+mw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] PM / Domains: Add GENPD_FLAG_RPM_ALWAYS_ON flag
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 30 Apr 2019 at 17:06, Leonard Crestez <leonard.crestez@nxp.com> wrote:
>
> This is for power domains which can only be powered off for suspend but
> not as part of runtime PM.
>
> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/domain.c | 8 ++++++--
>  include/linux/pm_domain.h   | 4 ++++
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 7a6aa2318915..33c30c1e6a30 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -126,10 +126,11 @@ static const struct genpd_lock_ops genpd_spin_ops = {
>  #define genpd_status_on(genpd)         (genpd->status == GPD_STATE_ACTIVE)
>  #define genpd_is_irq_safe(genpd)       (genpd->flags & GENPD_FLAG_IRQ_SAFE)
>  #define genpd_is_always_on(genpd)      (genpd->flags & GENPD_FLAG_ALWAYS_ON)
>  #define genpd_is_active_wakeup(genpd)  (genpd->flags & GENPD_FLAG_ACTIVE_WAKEUP)
>  #define genpd_is_cpu_domain(genpd)     (genpd->flags & GENPD_FLAG_CPU_DOMAIN)
> +#define genpd_is_rpm_always_on(genpd)  (genpd->flags & GENPD_FLAG_RPM_ALWAYS_ON)
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
> +                       genpd_is_rpm_always_on(genpd) ||
> +                       atomic_read(&genpd->sd_count) > 0)
>                 return -EBUSY;
>
>         list_for_each_entry(pdd, &genpd->dev_list, list_node) {
>                 enum pm_qos_flags_status stat;
>
> @@ -1810,11 +1813,12 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>                 genpd->dev_ops.stop = pm_clk_suspend;
>                 genpd->dev_ops.start = pm_clk_resume;
>         }
>
>         /* Always-on domains must be powered on at initialization. */
> -       if (genpd_is_always_on(genpd) && !genpd_status_on(genpd))
> +       if ((genpd_is_always_on(genpd) || genpd_is_rpm_always_on(genpd)) &&
> +                       !genpd_status_on(genpd))
>                 return -EINVAL;
>
>         if (genpd_is_cpu_domain(genpd) &&
>             !zalloc_cpumask_var(&genpd->cpus, GFP_KERNEL))
>                 return -ENOMEM;
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 0e8e356bed6a..b21f35f0ee2e 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -51,16 +51,20 @@
>   *                             deploy idle power management support for CPUs
>   *                             and groups of CPUs. Note that, the backend
>   *                             driver must then comply with the so called,
>   *                             last-man-standing algorithm, for the CPUs in the
>   *                             PM domain.
> + *
> + * GENPD_FLAG_RPM_ALWAYS_ON:   Instructs genpd to always keep the PM domain
> + *                             powered on except for system suspend.
>   */
>  #define GENPD_FLAG_PM_CLK       (1U << 0)
>  #define GENPD_FLAG_IRQ_SAFE     (1U << 1)
>  #define GENPD_FLAG_ALWAYS_ON    (1U << 2)
>  #define GENPD_FLAG_ACTIVE_WAKEUP (1U << 3)
>  #define GENPD_FLAG_CPU_DOMAIN   (1U << 4)
> +#define GENPD_FLAG_RPM_ALWAYS_ON (1U << 5)
>
>  enum gpd_status {
>         GPD_STATE_ACTIVE = 0,   /* PM domain is active */
>         GPD_STATE_POWER_OFF,    /* PM domain is off */
>  };
> --
> 2.17.1
>
