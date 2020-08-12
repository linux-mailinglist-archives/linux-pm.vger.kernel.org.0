Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26632427D6
	for <lists+linux-pm@lfdr.de>; Wed, 12 Aug 2020 11:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgHLJpp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Aug 2020 05:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgHLJpp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Aug 2020 05:45:45 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6ECC061788
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2020 02:45:44 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f12so1373353wru.13
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2020 02:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uTy4yxB/Sy2GGkpTfgcW5WshNn/nrvlwrV1YyVelTU4=;
        b=O4fnuMvWm+m/y/xQ0sZI/HIuQwooizkMH82l/TS46A58WPBrGQ2fg1RcF7FPXOc/uN
         wGvqCpbqCqZ94aojOfgfjR8gSTqFgSaPWYpwCLTXoskRKo+nASOq98bW4AGubTGej9xz
         8KKXSAtg3QNIgTKlvF/fHwA7OyVUVO5PumRwCtfguGmzxiLLoqDWSQA4ueyXzTj0lPZR
         uJyVkhOx+/09BOmXvnZCyHW1BLepSasJY6gnEXnqJ8hePPtH0KAFLS24Erk1233a6h6N
         tRMZItKx6uepKGjsGt6n2V1ast7orB2wzRS6HFa0euRuxOgUAcqU91Bk0CY+m8Gmgqze
         6uGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uTy4yxB/Sy2GGkpTfgcW5WshNn/nrvlwrV1YyVelTU4=;
        b=FJ/sSpexkdxhDJiNOXW8E1P9GabmtkcrizA+BPlDzSPCxbSeUUISTD18yJ8u+T7YOL
         5aw8lDP8fz6pkkD6RGGPZqyz/2csrlaLdH+IPxo673y1THvxDRFsW/CeScVLabJwjuPv
         ic07bTQX+DwZGbF9FqphhhwkTnxME/3Hgr23W8+EtZvUDzSCmKJRuIQTQJ670E9B4yh4
         NMj91MSI2z2JD1/xXhPYZvPqmpfXG1i1vh3BOxU0gWOwDhjFC+VNsNGCrk2o6/B7g4M9
         mLunONG0q7uEW3lOderVvhJLgyA+dSwPGOCuPgqE08dz2SCSQkrWumeX28anQM+YD8u0
         LYrQ==
X-Gm-Message-State: AOAM531YJn6mJJrWvxw5tWRjS5deriJbAlGhdMGodCYHVXk/zzqcNTv2
        uuI4N5YKkn10Vv9mc/SQ2BJv2Mbi+bGaSz+nPR6IpQ==
X-Google-Smtp-Source: ABdhPJweHtfwdTZ/38ShtwHpwcAIIJYfGimC5tyUNMlQ+k4jS8cib5W994DhMFiRcslMHtBRQJDioz2En/eBT/O5qWQ=
X-Received: by 2002:a05:6000:1203:: with SMTP id e3mr33739356wrx.324.1597225543416;
 Wed, 12 Aug 2020 02:45:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200811190252.10559-1-sibis@codeaurora.org>
In-Reply-To: <20200811190252.10559-1-sibis@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 12 Aug 2020 11:45:06 +0200
Message-ID: <CAPDyKFqNMEtHwcJFxYQP5H1Yjrsr1T3UUZoXes69EthSjAYs2A@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM / Domains: Add GENPD_FLAG_SUSPEND_ON flag
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Gross <agross@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Kevin Hilman <khilman@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 11 Aug 2020 at 21:03, Sibi Sankar <sibis@codeaurora.org> wrote:
>
> This is for power domains which needs to stay powered on for suspend
> but can be powered on/off as part of runtime PM. This flag is aimed at
> power domains coupled to remote processors which enter suspend states
> independent to that of the application processor. Such power domains
> are turned off only on remote processor crash/shutdown.

As Kevin also requested, please elaborate more on the use case.

Why exactly must the PM domain stay powered on during system suspend?
Is there a wakeup configured that needs to be managed - or is there a
co-processor/FW behaviour that needs to be obeyed to?

Kind regards
Uffe

>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  drivers/base/power/domain.c | 3 ++-
>  include/linux/pm_domain.h   | 5 +++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 2cb5e04cf86cd..ba78ac4a450d4 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -129,6 +129,7 @@ static const struct genpd_lock_ops genpd_spin_ops = {
>  #define genpd_is_active_wakeup(genpd)  (genpd->flags & GENPD_FLAG_ACTIVE_WAKEUP)
>  #define genpd_is_cpu_domain(genpd)     (genpd->flags & GENPD_FLAG_CPU_DOMAIN)
>  #define genpd_is_rpm_always_on(genpd)  (genpd->flags & GENPD_FLAG_RPM_ALWAYS_ON)
> +#define genpd_is_suspend_on(genpd)     (genpd->flags & GENPD_FLAG_SUSPEND_ON)
>
>  static inline bool irq_safe_dev_in_no_sleep_domain(struct device *dev,
>                 const struct generic_pm_domain *genpd)
> @@ -949,7 +950,7 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
>  {
>         struct gpd_link *link;
>
> -       if (!genpd_status_on(genpd) || genpd_is_always_on(genpd))
> +       if (!genpd_status_on(genpd) || genpd_is_always_on(genpd) || genpd_is_suspend_on(genpd))
>                 return;
>
>         if (genpd->suspended_count != genpd->device_count
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index ee11502a575b0..3002a2d68936a 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -55,6 +55,10 @@
>   *
>   * GENPD_FLAG_RPM_ALWAYS_ON:   Instructs genpd to always keep the PM domain
>   *                             powered on except for system suspend.
> + *
> + * GENPD_FLAG_SUSPEND_ON:      Instructs genpd to keep the PM domain powered
> + *                             on during suspend and runtime PM controlled
> + *                             otherwise.
>   */
>  #define GENPD_FLAG_PM_CLK       (1U << 0)
>  #define GENPD_FLAG_IRQ_SAFE     (1U << 1)
> @@ -62,6 +66,7 @@
>  #define GENPD_FLAG_ACTIVE_WAKEUP (1U << 3)
>  #define GENPD_FLAG_CPU_DOMAIN   (1U << 4)
>  #define GENPD_FLAG_RPM_ALWAYS_ON (1U << 5)
> +#define GENPD_FLAG_SUSPEND_ON   (1U << 6)
>
>  enum gpd_status {
>         GPD_STATE_ACTIVE = 0,   /* PM domain is active */
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
