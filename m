Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41392E08A7
	for <lists+linux-pm@lfdr.de>; Tue, 22 Dec 2020 11:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbgLVKRO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Dec 2020 05:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgLVKRN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Dec 2020 05:17:13 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6780C0617A6
        for <linux-pm@vger.kernel.org>; Tue, 22 Dec 2020 02:16:32 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id t15so4202660ual.6
        for <linux-pm@vger.kernel.org>; Tue, 22 Dec 2020 02:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u5D4oaP+JyGDPSb5WD4EuJeM/Elf3dZ4EodFXX528gc=;
        b=XHvHqeKa4f5S3ZMQwF+XbsSahoWji54NKrDKtC70gW9jpnAzV8KCOix9B6sAYkTFeu
         qkXR7dC+xfiuzWUVi3cjABIyYirBlztXcul6mzc8iGE44nzw0YWC8DgU9KoUf66n729h
         mHsWarTvF7tedEim39AkgFLTE3OBbAXfROriGw8lfuT5toIQqBTPpsloJfIyhEEIAdHd
         LtxHe+FhIOrU0fBxrUBpsJRWNOxkDsCQM2ARsW30Baf+NuX+Mw7XW+6+UIzTcb3BbpMa
         9zRAwcJ65vdO8bn+rPEkhC7dtHT7pQ+xbZ/6jdc8d/i/N6hC74JinJ3a7ttGItVfZ9ye
         AFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u5D4oaP+JyGDPSb5WD4EuJeM/Elf3dZ4EodFXX528gc=;
        b=MHihcRmjLrByt1IwG6xg42tmB0ImRiYvjEBzfxNaPCwfN66jkStBbiLqSVAfwocJMo
         LGczSwXW4iPI7VMXTkMZxERb/qrxam+KbI2fQIjW32ciM38Z2Fwa0kU8BR7dWO5yWeZG
         hvqbNLi8rhhSBJCfEEL4d8KdWL0Zc+FH4wS33m8Btq6mnCz3ONM4ct0GvWUZgmD9Tbsu
         V43vh3FkP4DbCreixZtFwc9a8MOoBo1Qz95DIk2LRzYbOGGbESoyOoRXnPbfkkmKCAl6
         WeADY2e/voNsplx3b26lEwDUx2ut5WLi+k6olMID4VT+LvxWqcK58RHGwUdKiTwIPUM/
         gEHg==
X-Gm-Message-State: AOAM53380Ob62rRKdb+6oxSEjER+pLv/pjFB/3xZ60hjwBFsPDewS2lQ
        Ghy2GCBApuRDzjTwpybgFLa9uz/EHOy9FU2emi2fCg==
X-Google-Smtp-Source: ABdhPJxiRcSJBC4CEnePGDAgwS/4NSlqkH6AzmAhcu5CZfPF7aE+ubk+PHahFP+ebjYTTVgdBUk3iEJFFBOkZ4f7+mo=
X-Received: by 2002:a9f:2213:: with SMTP id 19mr14433313uad.15.1608632192033;
 Tue, 22 Dec 2020 02:16:32 -0800 (PST)
MIME-Version: 1.0
References: <20201216175056.19554-1-ilina@codeaurora.org>
In-Reply-To: <20201216175056.19554-1-ilina@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 22 Dec 2020 11:15:55 +0100
Message-ID: <CAPDyKFrdZTd0mWHYhk13uyNWoxqjkO_iSni_TC5uir-PpgxSpw@mail.gmail.com>
Subject: Re: [PATCH] PM / Domains: allow domain idle states to be disabled
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 16 Dec 2020 at 18:51, Lina Iyer <ilina@codeaurora.org> wrote:
>
> In order to debug critical domain and device power issues, it may be
> necessary to disallow certain idle states at runtime. Let the device
> disallow a domain idle state before suspending.The domain governor shall
> check for the 'disabled' flag while determining the domain idle state.

For debug purposes, you might as well just set a dev PM Qos latency
request that corresponds to the state you want to disable. This will
then prevent the genpd governor from selecting the state.

Kind regards
Uffe

>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
>  drivers/base/power/domain.c          | 30 ++++++++++++++++++++++++++++
>  drivers/base/power/domain_governor.c |  3 +++
>  include/linux/pm_domain.h            |  7 +++++++
>  3 files changed, 40 insertions(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 191539a8e06d..e4e7ab75bdea 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1926,6 +1926,36 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
>  }
>  EXPORT_SYMBOL_GPL(pm_genpd_remove_subdomain);
>
> +/**
> + * dev_pm_genpd_disable_idle_state - Disallow a PM domain's idle state
> + *
> + * @dev: device attached to the PM domain
> + * @idx: index of the PM domain's idle state to be disabled
> + * @disable: enable/disable idle state
> + *
> + * Allow a PM domain's idle state to be disabled. Disabled idle states will
> + * be ignored by the domain governor when entering idle. Devices would
> + * invoke this before calling runtime suspend.
> + */
> +int dev_pm_genpd_disable_idle_state(struct device *dev, unsigned int idx, bool disable)
> +{
> +       struct generic_pm_domain *genpd;
> +
> +       genpd = dev_to_genpd_safe(dev);
> +       if (!genpd)
> +               return -ENODEV;
> +
> +       if (idx >= genpd->state_count)
> +               return -EINVAL;
> +
> +       genpd_lock(genpd);
> +       genpd->states[idx].disabled = disable;
> +       genpd_unlock(genpd);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_genpd_disable_idle_state);
> +
>  static void genpd_free_default_power_state(struct genpd_power_state *states,
>                                            unsigned int state_count)
>  {
> diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
> index 2afb7fa90d5d..8decd17c5a6a 100644
> --- a/drivers/base/power/domain_governor.c
> +++ b/drivers/base/power/domain_governor.c
> @@ -175,6 +175,9 @@ static bool __default_power_down_ok(struct dev_pm_domain *pd,
>         s64 min_off_time_ns;
>         s64 off_on_time_ns;
>
> +       if (genpd->states[state].disabled)
> +               return false;
> +
>         off_on_time_ns = genpd->states[state].power_off_latency_ns +
>                 genpd->states[state].power_on_latency_ns;
>
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index a41aea9d1c06..3d251b5b461a 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -101,6 +101,7 @@ struct genpd_power_state {
>         struct fwnode_handle *fwnode;
>         ktime_t idle_time;
>         void *data;
> +       bool disabled;
>  };
>
>  struct genpd_lock_ops;
> @@ -233,6 +234,7 @@ int dev_pm_genpd_add_notifier(struct device *dev, struct notifier_block *nb);
>  int dev_pm_genpd_remove_notifier(struct device *dev);
>  void genpd_enable_next_wakeup(struct generic_pm_domain *genpd, bool enable);
>  int dev_pm_genpd_set_next_wakeup(struct device *dev, ktime_t next);
> +int dev_pm_genpd_disable_idle_state(struct device *dev, unsigned int idx, bool disable);
>
>  extern struct dev_power_governor simple_qos_governor;
>  extern struct dev_power_governor pm_domain_always_on_gov;
> @@ -300,6 +302,11 @@ static inline int dev_pm_genpd_set_next_wakeup(struct device *dev, ktime_t next)
>         return -EOPNOTSUPP;
>  }
>
> +static inline int dev_pm_genpd_disable_idle_state(struct device *dev, unsigned int idx, bool disable)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
>  #define simple_qos_governor            (*(struct dev_power_governor *)(NULL))
>  #define pm_domain_always_on_gov                (*(struct dev_power_governor *)(NULL))
>  #endif
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
