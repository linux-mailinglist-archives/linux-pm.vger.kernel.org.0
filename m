Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9401D3EA3FB
	for <lists+linux-pm@lfdr.de>; Thu, 12 Aug 2021 13:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236942AbhHLLq7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Aug 2021 07:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236966AbhHLLqz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Aug 2021 07:46:55 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F2AC061798
        for <linux-pm@vger.kernel.org>; Thu, 12 Aug 2021 04:46:30 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a4so2689909uae.6
        for <linux-pm@vger.kernel.org>; Thu, 12 Aug 2021 04:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Li6Qo5zcok5kTevKrkrYxFbzzzVN+1df3M6EKH96DQY=;
        b=RNbWXlKWGUZ5Gu8YUajYcRIb+Xv4D8NceBjRRKNZhd1XG2IJ14TE9YhRRHfwXq4oBr
         lexhVUQ2ZF5Ij4X6XE2Lsl+glyICNska4km8u56UbpytJfQtaLeWk2ZKoH8VARkl6xSi
         07NCc8bTcW6i04nSwJL2TZW4dVXXIv3NYQpQBJgwjzPjdnE4G5LLwkWxOhtiTDQ0bV/K
         ooBJLoNnBfU9P7xhLI/1Lf0y/9Dx14qI+4iFJPd23iyHpi+YdRIe7yxn13SlruURiPRd
         y8TYyo7L8phdTya0qMNKBtc6bysO3nRJIuIRQrim9sGMeZqQbpQWBoZlISj9GeE4KrB9
         S6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Li6Qo5zcok5kTevKrkrYxFbzzzVN+1df3M6EKH96DQY=;
        b=EQNIj+QU9pwfpEACI5vJA6ZsocgQeKEWTfUOzO9fqTQNRDqdnzPHbg5Fl/RN1QgouU
         Tiv8Pr72DO/4kLl7QtVFCkH6paahft1if3cm9TUmuclzMsTor4UWZyDzRtS2C/DNrRrP
         CyVjAuMvsRUIBJFSKjZ+aGldwD5+vu9pV/6qXMk3RSJ7gqDHfb43RbHrhrHCN9mcjt4i
         EqmUFUmjNSez8guft5qfIMRdvOzdlcWdHNXO1AHwzSFrgXvazKVTztlYRWi6aiaorlky
         XrKZmg1dOGiles4zsejDoW2mTQQAeSEMx7y/hoFYmeI/uenZSDXyMT+Fa2GhlZifZTlT
         jgrw==
X-Gm-Message-State: AOAM531qBlWRoweARTtWLTGfP/0PEIOEhGqla7GlrPmM+dZc6sZxlfhX
        c8yunb2PQ1wrR9KIidelL7ax1cvlF3HfcwhopjOcvQ==
X-Google-Smtp-Source: ABdhPJzvNYxqQb9U2XzfKJb2/JItP1FPhUV8vpIOaA9YTfYMDRGdK0KfjV4OKmu7Lj/gbe7ApYmb8BRwlwsQK4OS04I=
X-Received: by 2002:ab0:60c9:: with SMTP id g9mr1725311uam.100.1628768789146;
 Thu, 12 Aug 2021 04:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <1628767642-4008-1-git-send-email-rnayak@codeaurora.org> <1628767642-4008-3-git-send-email-rnayak@codeaurora.org>
In-Reply-To: <1628767642-4008-3-git-send-email-rnayak@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 12 Aug 2021 13:45:52 +0200
Message-ID: <CAPDyKFqruKGya1tbPjzAA=eO5v3Gipt2DH6RBbMi6e_vXmA+dw@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] PM / Domains: Add support for 'required-opps' to
 set default perf state
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Dmitry Osipenko <digetx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 12 Aug 2021 at 13:28, Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
> Some devices within power domains with performance states do not
> support DVFS, but still need to vote on a default/static state
> while they are active. They can express this using the 'required-opps'
> property in device tree, which points to the phandle of the OPP
> supported by the corresponding power-domains.
>
> Add support to parse this information from DT and then set the
> specified performance state during attach and drop it on detach.
> runtime suspend/resume callbacks already have logic to drop/set
> the vote as needed and should take care of dropping the default
> perf state vote on runtime suspend and restore it back on runtime
> resume.
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/base/power/domain.c | 30 ++++++++++++++++++++++++++++--
>  include/linux/pm_domain.h   |  1 +
>  2 files changed, 29 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index a934c67..e1c8994 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2598,6 +2598,12 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
>
>         dev_dbg(dev, "removing from PM domain %s\n", pd->name);
>
> +       /* Drop the default performance state */
> +       if (dev_gpd_data(dev)->default_pstate) {
> +               dev_pm_genpd_set_performance_state(dev, 0);
> +               dev_gpd_data(dev)->default_pstate = 0;
> +       }
> +
>         for (i = 1; i < GENPD_RETRY_MAX_MS; i <<= 1) {
>                 ret = genpd_remove_device(pd, dev);
>                 if (ret != -EAGAIN)
> @@ -2637,6 +2643,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>  {
>         struct of_phandle_args pd_args;
>         struct generic_pm_domain *pd;
> +       int pstate;
>         int ret;
>
>         ret = of_parse_phandle_with_args(dev->of_node, "power-domains",
> @@ -2675,10 +2682,29 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>                 genpd_unlock(pd);
>         }
>
> -       if (ret)
> +       if (ret) {
>                 genpd_remove_device(pd, dev);
> +               return -EPROBE_DEFER;
> +       }
>
> -       return ret ? -EPROBE_DEFER : 1;
> +       /* Set the default performance state */
> +       pstate = of_get_required_opp_performance_state(dev->of_node, index);
> +       if (pstate < 0 && pstate != -ENODEV) {
> +               ret = pstate;
> +               goto err;
> +       } else if (pstate > 0) {
> +               ret = dev_pm_genpd_set_performance_state(dev, pstate);
> +               if (ret)
> +                       goto err;
> +               dev_gpd_data(dev)->default_pstate = pstate;
> +       }
> +       return 1;
> +
> +err:
> +       dev_err(dev, "failed to set required performance state for power-domain %s: %d\n",
> +               pd->name, ret);
> +       genpd_remove_device(pd, dev);
> +       return ret;
>  }
>
>  /**
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 21a0577..67017c9 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -198,6 +198,7 @@ struct generic_pm_domain_data {
>         struct notifier_block *power_nb;
>         int cpu;
>         unsigned int performance_state;
> +       unsigned int default_pstate;
>         unsigned int rpm_pstate;
>         ktime_t next_wakeup;
>         void *data;
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
