Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE153E274E
	for <lists+linux-pm@lfdr.de>; Fri,  6 Aug 2021 11:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhHFJc4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Aug 2021 05:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244420AbhHFJc4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Aug 2021 05:32:56 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA357C06179B
        for <linux-pm@vger.kernel.org>; Fri,  6 Aug 2021 02:32:40 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id k24so4826378vsg.9
        for <linux-pm@vger.kernel.org>; Fri, 06 Aug 2021 02:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hG7ad08wIaDvmaneskOxS98xzOuakO0shjMfqcJhf/0=;
        b=hMu6wdmsIydv5n9UioqGMhi3NdWSB/gd114kREAS+K9yylruPgSJndFExuw8ozfeGO
         GdtAjzm8rBOTxnmkHvqbu7kIjYoIlQVlFMcJu6gZwcMsEnTfAgWtR5bOCu8ULScBXQJJ
         VcVw53SwVoCGiEySclc/39VPhrTmkILFH5aNXYcXbTYJcXc84+XPdsNGt04gU3EXEknv
         987It+qBSY6m5j60ObfZ1xEocKkPVA3EMrVmgLpNOp2DRns9mVHCVAA1aakeRdTw5JoO
         Z4/7cRQBAk228VIIWMTo+Wx8N4HchVa6WWVCZYoGpKP+CER9LgvANl5oVUC3K7A2/y04
         5OPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hG7ad08wIaDvmaneskOxS98xzOuakO0shjMfqcJhf/0=;
        b=eKGMSPJarNKl3/4h6ENeIDJmkmMsFIaQfBpK0/+7wm7CI163opHjvt7JqdgCUDeuL/
         flK/fC2LUX0frv1Xzf8MJ+a2lLOnBwCwh+tzxiPl5LLM02WHWSvodigOnr5LTtconvfi
         OanRuFd6kcPU4sZvUqJ+Fq/vBl+4oIy+MfjhD58zdc9wG1sVIdOehZ9K/8tnGJQenJF6
         D7xRJ9+Ha4++Rbfn9K6gvyNGm9ttl/C3PQyMjOJJPVxkuiMMzMV7QVCa6JODQoPg5zPB
         TmApjhfibaeW7NltXoBvdPaea9+m0NLya/aNaTi2GLi5z3mBcpsd1VZbCdfRFXvkQJ/B
         HMfw==
X-Gm-Message-State: AOAM531kAoWpZPdYjlQt9DIHiWfIvk5d8UXQhxJP8Db2/y2Q8kvINYhA
        gyWCHAWV0Auh05y9k5JtuYkVjCppJ/31tiwklEayFA==
X-Google-Smtp-Source: ABdhPJynKc93n6ipIB8hMXdJbwfMvreyYjrVW9QsyI+/iIksqcj/6XpbRPGThpwYkyD6MPj4X1c9cqd6zqik6xU3kn8=
X-Received: by 2002:a67:7c14:: with SMTP id x20mr8347304vsc.42.1628242359627;
 Fri, 06 Aug 2021 02:32:39 -0700 (PDT)
MIME-Version: 1.0
References: <1628074696-7979-1-git-send-email-rnayak@codeaurora.org> <1628074696-7979-2-git-send-email-rnayak@codeaurora.org>
In-Reply-To: <1628074696-7979-2-git-send-email-rnayak@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 6 Aug 2021 11:32:03 +0200
Message-ID: <CAPDyKFrebwt5=S7hqXvcqRvt+-EXLcVmRSRZt1uPf-9n7_pRDg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] PM / Domains: Add support for 'required-opps' to
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
        Stephan Gerhold <stephan@gerhold.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 4 Aug 2021 at 12:58, Rajendra Nayak <rnayak@codeaurora.org> wrote:
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
> ---
>  drivers/base/power/domain.c | 28 ++++++++++++++++++++++++++--
>  include/linux/pm_domain.h   |  1 +
>  2 files changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index a934c67..b9b5a9b 100644
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
> @@ -2637,6 +2643,8 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>  {
>         struct of_phandle_args pd_args;
>         struct generic_pm_domain *pd;
> +       struct device_node *np;
> +       int pstate;
>         int ret;
>
>         ret = of_parse_phandle_with_args(dev->of_node, "power-domains",
> @@ -2675,10 +2683,26 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>                 genpd_unlock(pd);
>         }
>
> -       if (ret)
> +       if (ret) {
>                 genpd_remove_device(pd, dev);
> +               return -EPROBE_DEFER;
> +       }
> +
> +       /* Set the default performance state */
> +       np = dev->of_node;
> +       if (of_parse_phandle(np, "required-opps", index)) {

Looks like Viresh thinks it's a good idea to drop the error print in
of_get_required_opp_performance_state() when there is no
"required-opps" specifier.

Would you mind folding in a patch for that in the series, so this code
can be simplified according to our earlier discussions?

> +               pstate = of_get_required_opp_performance_state(np, index);
> +               if (pstate < 0) {
> +                       ret = pstate;
> +                       dev_err(dev, "failed to set required performance state for power-domain %s: %d\n",
> +                               pd->name, ret);
> +               } else {
> +                       dev_pm_genpd_set_performance_state(dev, pstate);
> +                       dev_gpd_data(dev)->default_pstate = pstate;
> +               }
> +       }
>
> -       return ret ? -EPROBE_DEFER : 1;
> +       return ret ? ret : 1;
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

Other than the above, this looks good to me!

Kind regards
Uffe
