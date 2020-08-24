Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E444124FC55
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 13:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgHXLMV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 07:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgHXLMD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 07:12:03 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58254C061574
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 04:12:03 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id a13so4200958vso.12
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 04:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z5//TYxZEOCDa9uWvHD+L7cx/6ym8bakqnq3Q8GLwSg=;
        b=R1EqGgYF8Wxxa2OwrltVEoRoT3rNWtuEFWR6lyfr5X9wcp3Im26/m7Scaz4YYlu8ud
         IrOmpZb4PpTZT6UqYQB23SgX9z4JcO0NqTrpu/0kFNLiCuNZXJ9pjlRRKqDHlQfvsfMW
         c2j1qiSCOBPmi51xjgk/CRV4JtxIX79CGluGEvJnPPBoQIieM8LxAe8kBONTLfT8/X3S
         8sOVtXqvkgN8x2A15SYhcoE/C0Br1LyjHtTE8/paLLhLI2Vr7mvzg20doVSltIlYq/3F
         gCC4j7vCcVqPU72PvEypC18575bEpDXhKnyzclOH4LN8kdUrYzBSEU5/n3CQgzntABON
         4UbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z5//TYxZEOCDa9uWvHD+L7cx/6ym8bakqnq3Q8GLwSg=;
        b=PhM5NEM4R3sAqo+kCrO0jKrIxSTukN18s3Ub6JBMDbwuCU/LVEgaREvjKNaHh83mjC
         /zhLx1C1hdqn/XjN7hqzPuV5M/9m9tEs6xnVHrMcG8mUl3l21y/n0G4f6zAgjv4rS6WX
         vHv/uTVMGiyRKKZkre0uVj+h6VRbMq1lycnVoEVuG2ysr9edhv1qwQEkEvDUqo2rz2Io
         gKHLRKKn8uf209sMthXHx5qW5wgPiVZezQsU0cQWq9/4eOVlqQc4QDLJepRnysiwgXX0
         0NRNiHh9V1rBpfb9E94DvsTbHAaUXKGi8/c+kZD6nkqy5WgrohNXYeMfgwjon2KC5Hzv
         uSOQ==
X-Gm-Message-State: AOAM531YELNQoX06WKPKRCQ0FNIFtp0FuT1QgNRP7qCIldlFYd3ZxjGv
        xIRHbDV7G4qEhfs+Af3etDhaGwa5nUN02eTRov2lWg==
X-Google-Smtp-Source: ABdhPJze/D9HVcYXvdcyq/7lNrWTczFdsDI21S3RCgmJznLBy+cBgBLCFL3jGBjQHDoxy6kyph7U84dFDrb0p3LTFE0=
X-Received: by 2002:a67:fd0a:: with SMTP id f10mr1836903vsr.35.1598267522158;
 Mon, 24 Aug 2020 04:12:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200821204921.32536-1-sibis@codeaurora.org>
In-Reply-To: <20200821204921.32536-1-sibis@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 Aug 2020 13:11:26 +0200
Message-ID: <CAPDyKFoXzskRW7W_7EHQatQ=-OeAaLGTdzUx0FtY96=bZXt6aw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PM / Domains: Add GENPD_FLAG_NO_SUSPEND/RESUME flags
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Gross <agross@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 21 Aug 2020 at 22:49, Sibi Sankar <sibis@codeaurora.org> wrote:
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

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Although, I would like Stephen's question to get an answer in the
other thread, before this gets applied.

Kind regards
Uffe

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
