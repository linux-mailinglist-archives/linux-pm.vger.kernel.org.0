Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F66C272B8B
	for <lists+linux-pm@lfdr.de>; Mon, 21 Sep 2020 18:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgIUQSa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Sep 2020 12:18:30 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39120 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgIUQSa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Sep 2020 12:18:30 -0400
Received: by mail-oi1-f194.google.com with SMTP id c13so17585471oiy.6;
        Mon, 21 Sep 2020 09:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nbC7uccKDJ1WRncXvD6/krY9wssuSRXhmd3VlyR43es=;
        b=nk6vyjkfkomXFTgk4hRoDlLqf6oS4BV5Te0CwwxQndH+jSoJaJzQGhA7SBRT9oBBI1
         VAsCVZCnjgc7XUKPYNEv8gEjI3+jcTurwVciOeUFanHQ6Mors1cjY74mw8DEzun4j9pg
         RfSMvLfe8N4EtKJfTCb0skNtJKM65iFvbgSLqAFYkshlf5pxo4eBuRGrhrdvCB/WR7Kp
         pzDsCAe9A0n43mi6M4eQtve7OxNlKN02A2e3TV74xjsletwTUw1b7XwFm2S7fzBjSff4
         cuSV9c2Qy5tab+jz0dyw1VMCdOvOhqH/HHXPb76bRGSqfyIu1HHlgzACKz8TnlVqSWlJ
         FpyQ==
X-Gm-Message-State: AOAM533N71mLyYFRbkNaUWx3++5qd5OwvpuxFY9n9S5Vq02IZybP9Ted
        IBSs1q1elyWlFWlU673SCTDHf+Xu0YvHSl1Xr/A=
X-Google-Smtp-Source: ABdhPJzk678teRbfi+MQPJejkzv4hFdqqIqhrmGw3zIKWNvilPbFXuEtEACgA8TivFAZDLWbBOcAN+05du/9R940FD0=
X-Received: by 2002:a05:6808:491:: with SMTP id z17mr116123oid.110.1600705109159;
 Mon, 21 Sep 2020 09:18:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200821204921.32536-1-sibis@codeaurora.org>
In-Reply-To: <20200821204921.32536-1-sibis@codeaurora.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Sep 2020 18:18:17 +0200
Message-ID: <CAJZ5v0gdMroJY0d9n2+_P2uhBNw1xp5yn=jhxdejDLq0WmkPTA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PM / Domains: Add GENPD_FLAG_NO_SUSPEND/RESUME flags
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Gross <agross@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        "Nayak, Rajendra" <rnayak@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Aug 21, 2020 at 10:49 PM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> Add GENPD_FLAG_NO_SUSPEND/RESUME flags to instruct genpd to keep the
> status of the PM domain unaltered during suspend/resume respectively.
> The flags are aimed at power domains coupled to co-processors which
> enter low-power modes independent to that of the application processor.
>
> Specifically the flags are to be used by the power domains exposed
> by the AOSS QMP driver linked to modem, adsp, cdsp remoteprocs. These
> power domains are used to notify the Always on Subsystem (AOSS) that
> a particular co-processor is up. AOSS uses this information to wait
> for the co-processors to suspend before starting its sleep sequence.
> The application processor powers off these power domains only if the
> co-processor has crashed or powered off and remains unaltered during
> system suspend/resume.
>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Applied with the Ulf's R-by along with the [2/2] as 5.10 material, thanks!

> ---
>
> V2:
>  * Add more info in commit msg and description [Uffe/Kevin/Stephen]
>  * Rename and split functionality into two flags [Uffe]
>  * Drop R-b/T-b
>
>  drivers/base/power/domain.c |  6 ++++--
>  include/linux/pm_domain.h   | 10 ++++++++++
>  2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 2cb5e04cf86cd..a5df5916f30f8 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -129,6 +129,8 @@ static const struct genpd_lock_ops genpd_spin_ops = {
>  #define genpd_is_active_wakeup(genpd)  (genpd->flags & GENPD_FLAG_ACTIVE_WAKEUP)
>  #define genpd_is_cpu_domain(genpd)     (genpd->flags & GENPD_FLAG_CPU_DOMAIN)
>  #define genpd_is_rpm_always_on(genpd)  (genpd->flags & GENPD_FLAG_RPM_ALWAYS_ON)
> +#define genpd_is_no_suspend(genpd)     (genpd->flags & GENPD_FLAG_NO_SUSPEND)
> +#define genpd_is_no_resume(genpd)      (genpd->flags & GENPD_FLAG_NO_RESUME)
>
>  static inline bool irq_safe_dev_in_no_sleep_domain(struct device *dev,
>                 const struct generic_pm_domain *genpd)
> @@ -949,7 +951,7 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
>  {
>         struct gpd_link *link;
>
> -       if (!genpd_status_on(genpd) || genpd_is_always_on(genpd))
> +       if (!genpd_status_on(genpd) || genpd_is_always_on(genpd) || genpd_is_no_suspend(genpd))
>                 return;
>
>         if (genpd->suspended_count != genpd->device_count
> @@ -991,7 +993,7 @@ static void genpd_sync_power_on(struct generic_pm_domain *genpd, bool use_lock,
>  {
>         struct gpd_link *link;
>
> -       if (genpd_status_on(genpd))
> +       if (genpd_status_on(genpd) || genpd_is_no_resume(genpd))
>                 return;
>
>         list_for_each_entry(link, &genpd->child_links, child_node) {
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index ee11502a575b0..568abdf2e89cf 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -55,6 +55,14 @@
>   *
>   * GENPD_FLAG_RPM_ALWAYS_ON:   Instructs genpd to always keep the PM domain
>   *                             powered on except for system suspend.
> + *
> + * GENPD_FLAG_NO_SUSPEND:      Instructs genpd to keep the PM domain powered
> + *                             on during suspend (if it's already powered on)
> + *                             and runtime PM controlled otherwise.
> + *
> + * GENPD_FLAG_NO_RESUME:       Instructs genpd to keep the PM domain powered
> + *                             off during resume (if it's already powered off)
> + *                             and runtime PM controlled otherwise.
>   */
>  #define GENPD_FLAG_PM_CLK       (1U << 0)
>  #define GENPD_FLAG_IRQ_SAFE     (1U << 1)
> @@ -62,6 +70,8 @@
>  #define GENPD_FLAG_ACTIVE_WAKEUP (1U << 3)
>  #define GENPD_FLAG_CPU_DOMAIN   (1U << 4)
>  #define GENPD_FLAG_RPM_ALWAYS_ON (1U << 5)
> +#define GENPD_FLAG_NO_SUSPEND   (1U << 6)
> +#define GENPD_FLAG_NO_RESUME    (1U << 7)
>
>  enum gpd_status {
>         GPD_STATE_ACTIVE = 0,   /* PM domain is active */
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
