Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E7D2427B8
	for <lists+linux-pm@lfdr.de>; Wed, 12 Aug 2020 11:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgHLJhm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Aug 2020 05:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgHLJhl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Aug 2020 05:37:41 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5712C061787
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2020 02:37:40 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r4so1366852wrx.9
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2020 02:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xUJA54KTzQJyhxDXIqR9ReX2WN+bK5CjNuAWDhsdb8w=;
        b=crr6oK1RJrz1nT63FwEgbS3gquu/Ncq38lBd42GrnhhkTBXb4cMsIlG2foOG5WIA8O
         WkSv44SczGIHDr0xQlOkRWLczZs2351YnlOSc/9gsjx0xFZJRC7wcaB7NoFJsWsGG+SN
         SmsMBj7Jo5Dj4AXLZjJeu86fS842ynrwKjltjgDHVc97wIM0xMlbrGgFu23CA43WZEqK
         JluWeEigpXi6/Zq/Dk5dOHooEgLZQJFZYbRixqFTNYsugm2NhqJb7gSCxy2lM10cX9e1
         mT9KIr53nqS+l1kKtdPhUZ2wzeIcpbb64uuZIZ0X9Ks7YmGuJOwkG3Tl09d+rKzm2r/a
         m42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xUJA54KTzQJyhxDXIqR9ReX2WN+bK5CjNuAWDhsdb8w=;
        b=TcQ58ljcFox1JbzV8hkx5NcJzfHtWsT06txtOH4QsUTF5f6cUfqZljGHkQ6HKvyv4b
         n1VmwZ6aqE1EyZWzSjMMRS7A+qsGw8+CXtesXsX0Tuc4Mmoi8NS+9gcQi52uXZCeANVG
         YKqxt0HCf3G9RFPUO9zw3SYcwzcQVN5DpnV446H6FMXE6pIhDEpvOcmNPHlyHsSBEmKO
         qQCBUHuhRHouoxpJGgyqxwlJWGdlnMDd+K4YYCeQpYWG8gvC7Oo6cfKGJdg08nKtaD6Z
         LurI4qhEStLqgYO2P0OIyTUi0j2y3BJ3w1tUXIdjTtk3SuygwAXkFgZDMF/0Fb/uqXq3
         BrYg==
X-Gm-Message-State: AOAM532/Umu002qKneqAJxJNBOHJCXLu6SK8kav+o48dh7TEjCWvKnqp
        Y8e5LsZTEfbb3SV+lA+HG4GY5zr70UPNL+g6i4rLwcZJ
X-Google-Smtp-Source: ABdhPJzyVACqW0P5GX9T7WEr0tB2SFQ6077mmdaufTh9FO15OFL7AzToRKYCZQO33CyJbC41uGaJ5fCGYkTuz7UxjFw=
X-Received: by 2002:a5d:43c4:: with SMTP id v4mr34386550wrr.426.1597225059226;
 Wed, 12 Aug 2020 02:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <1596541616-27688-1-git-send-email-rnayak@codeaurora.org> <1596541616-27688-3-git-send-email-rnayak@codeaurora.org>
In-Reply-To: <1596541616-27688-3-git-send-email-rnayak@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 12 Aug 2020 11:37:03 +0200
Message-ID: <CAPDyKFoRv49jKi-4UW6EVyAzo1emb=rs2h7CWavON+JoXXh1kA@mail.gmail.com>
Subject: Re: [PATCH 2/3] PM / Domains: Add support for 'assigned-performance-states'
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 4 Aug 2020 at 13:47, Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
> For devices which have 'assigned-performance-states' specified in DT,
> set the specified performance state during attach and drop it on detach.
> Also drop/set as part of runtime suspend/resume callbacks.

To allow flexibility, I would prefer to keep the performance state
being orthogonal to the power on/off state for a genpd.

Therefore, I am wondering if this is better handled by the consumer
driver instead?

Kind regards
Uffe

>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  drivers/base/power/domain.c | 27 +++++++++++++++++++++++++++
>  include/linux/pm_domain.h   |  1 +
>  2 files changed, 28 insertions(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 0a01df60..8704823 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -810,6 +810,10 @@ static int genpd_runtime_suspend(struct device *dev)
>         if (irq_safe_dev_in_no_sleep_domain(dev, genpd))
>                 return 0;
>
> +       /* Drop the assigned performance state */
> +       if (dev_gpd_data(dev)->assigned_pstate)
> +               dev_pm_genpd_set_performance_state(dev, 0);
> +
>         genpd_lock(genpd);
>         genpd_power_off(genpd, true, 0);
>         genpd_unlock(genpd);
> @@ -829,6 +833,7 @@ static int genpd_runtime_resume(struct device *dev)
>  {
>         struct generic_pm_domain *genpd;
>         struct gpd_timing_data *td = &dev_gpd_data(dev)->td;
> +       unsigned int assigned_pstate = dev_gpd_data(dev)->assigned_pstate;
>         bool runtime_pm = pm_runtime_enabled(dev);
>         ktime_t time_start;
>         s64 elapsed_ns;
> @@ -857,6 +862,9 @@ static int genpd_runtime_resume(struct device *dev)
>         if (ret)
>                 return ret;
>
> +       /* Set the assigned performance state */
> +       if (assigned_pstate)
> +               dev_pm_genpd_set_performance_state(dev, assigned_pstate);
>   out:
>         /* Measure resume latency. */
>         time_start = 0;
> @@ -890,6 +898,8 @@ static int genpd_runtime_resume(struct device *dev)
>  err_poweroff:
>         if (!pm_runtime_is_irq_safe(dev) ||
>                 (pm_runtime_is_irq_safe(dev) && genpd_is_irq_safe(genpd))) {
> +               if (assigned_pstate)
> +                       dev_pm_genpd_set_performance_state(dev, 0);
>                 genpd_lock(genpd);
>                 genpd_power_off(genpd, true, 0);
>                 genpd_unlock(genpd);
> @@ -2405,6 +2415,12 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
>
>         dev_dbg(dev, "removing from PM domain %s\n", pd->name);
>
> +       /* Drop the assigned performance state */
> +       if (dev_gpd_data(dev)->assigned_pstate) {
> +               dev_pm_genpd_set_performance_state(dev, 0);
> +               dev_gpd_data(dev)->assigned_pstate = 0;
> +       }
> +
>         for (i = 1; i < GENPD_RETRY_MAX_MS; i <<= 1) {
>                 ret = genpd_remove_device(pd, dev);
>                 if (ret != -EAGAIN)
> @@ -2442,6 +2458,7 @@ static void genpd_dev_pm_sync(struct device *dev)
>  static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>                                  unsigned int index, bool power_on)
>  {
> +       unsigned int assigned_pstate;
>         struct of_phandle_args pd_args;
>         struct generic_pm_domain *pd;
>         int ret;
> @@ -2485,6 +2502,16 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>         if (ret)
>                 genpd_remove_device(pd, dev);
>
> +       /* Set the assigned performance state */
> +       if (!of_property_read_u32_index(base_dev->of_node,
> +                                       "assigned-performance-states",
> +                                       index, &assigned_pstate)) {
> +               if (assigned_pstate) {
> +                       dev_pm_genpd_set_performance_state(dev, assigned_pstate);
> +                       dev_gpd_data(dev)->assigned_pstate = assigned_pstate;
> +               }
> +       }
> +
>         return ret ? -EPROBE_DEFER : 1;
>  }
>
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 9ec78ee..4a415ee 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -180,6 +180,7 @@ struct generic_pm_domain_data {
>         struct notifier_block nb;
>         int cpu;
>         unsigned int performance_state;
> +       unsigned int assigned_pstate;
>         void *data;
>  };
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
