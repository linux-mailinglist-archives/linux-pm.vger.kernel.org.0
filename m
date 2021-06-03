Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0156F399EDE
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jun 2021 12:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhFCKYS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Jun 2021 06:24:18 -0400
Received: from mail-vs1-f41.google.com ([209.85.217.41]:37656 "EHLO
        mail-vs1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhFCKYS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jun 2021 06:24:18 -0400
Received: by mail-vs1-f41.google.com with SMTP id f21so980306vsl.4
        for <linux-pm@vger.kernel.org>; Thu, 03 Jun 2021 03:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HZj1YmDHRFHyGui3V46aHOAvyRG6PWn5p5QSq+t/Sxs=;
        b=c3AseZS4j09a0iY+eIx2G1yCBM3n1YMIM2Su5OIsiSTN/0Hu9a25eSDguueFqMp+6n
         sffvvezMqhSeESoF/q+i2yR2CykLWdfAxzEsrKupN0jm/5+GYUHXNhItE/PQ7vC5O7Nk
         B6Nqk2MGk3zLt7omFEeNu1+n+cmBAK1aUYJ+gnuOz0ihKecx8GXTyMY9/s8LkGpXD9kr
         mbp4YQEC1PJzfONt1ftc/tvAT4lDTaNt34sZu/rguamSDBNXctivBMIWEweUrbVBxRw/
         yW1km3okWALCOWh9o3lWvR2A/fs1mEx+DKFJPThu0Yz6RdyzYSEfUUnxve9OJpfROCUU
         wh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HZj1YmDHRFHyGui3V46aHOAvyRG6PWn5p5QSq+t/Sxs=;
        b=g5NTRjAuLu0YCw4bCTK1WfpAMU7gG0YL9Cj2Hg+CuxKQj2ON87Nw8yKy8ntBDqhXUA
         UDFr5e+vPTdK+TL5nvHH8aFPSz/qcFv2yCUoruiccbQRdxWy8n/ONYmPvsg9R0Sn0sbB
         RnOSOlylBBNGejxEE+oS7d/i0/C+/vah1vob0bBq8NE3su+jGKpHOjntNkNhfGk/CYQm
         0HhulUJIAyc9I/gwj6+x6tGSCc5v4CSrsQgorLZQTWSShVe2wIlvC5UkHnhFemStO35W
         csFLofSC9VsIDxnFJLlqxF5K5eLPmOGw2nmvv0/uRp9p36B6U+Vs61Fq8eRUek8/EwsE
         StaA==
X-Gm-Message-State: AOAM532huAfjwjepuQDXKeoIvJ70xf/8V3V+F3hneiPiFSnRLCyuyYW1
        VvAEFuZchVjp94p8rEpLNjgMdKF7oB0KQi7ak35NTw==
X-Google-Smtp-Source: ABdhPJydQXTBpcslYdtvzVJQ9UsvRObyMknbITcawugdhN5RTjLW/IJHgRmQSeLQmbwpOFwL8TJ2+ewYjVKMJ8wuLJI=
X-Received: by 2002:a67:e359:: with SMTP id s25mr2076383vsm.55.1622715693804;
 Thu, 03 Jun 2021 03:21:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210603093438.138705-1-ulf.hansson@linaro.org> <20210603093438.138705-5-ulf.hansson@linaro.org>
In-Reply-To: <20210603093438.138705-5-ulf.hansson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Jun 2021 12:20:57 +0200
Message-ID: <CAPDyKFp2dKFQpLMgazXumCxf=FHQ9bdadXUkGsjiAwniF8p2dw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] PM: domains: Drop/restore performance state votes
 for devices at system PM
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

+ Mark Brown, Dmitry Baryshkov

On Thu, 3 Jun 2021 at 11:34, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Recent changes in genpd drops and restore performance state votes for
> devices during runtime PM.
>
> For the similar reasons, but to avoid the same kind of boilerplate code in
> device PM callbacks for system sleep in subsystems/drivers, let's drop and
> restore performance states votes in genpd for the attached devices during
> system sleep.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

After a second thought, it looks like we maybe should defer to apply
this final patch of the series. At least until we figured out how to
address the below issue:

So, I noticed that we have things like "regulator-fixed-domain", that
uses "required-opps" to enable/disable a regulator through the
dev_pm_set_performance_state() interface. We likely don't want to drop
the performance state internally in genpd when genpd_suspend_noirq()
gets called, for the corresponding struct device for the regulator.

I guess if genpd should drop performance states like $subject patch
suggest, we need some kind of additional coordination, that allows a
subsystem/driver to inform genpd when it should avoid it. Or something
along those lines.

Kind regards
Uffe

> ---
>
> Changes in v2:
>         - Rebased.
>         - A few cosmetic changes.
>
> ---
>  drivers/base/power/domain.c | 9 +++++++++
>  include/linux/pm_domain.h   | 1 +
>  2 files changed, 10 insertions(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index e5d97174c254..a33e5b341f3f 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1171,6 +1171,7 @@ static int genpd_prepare(struct device *dev)
>   */
>  static int genpd_finish_suspend(struct device *dev, bool poweroff)
>  {
> +       struct generic_pm_domain_data *gpd_data = dev_gpd_data(dev);
>         struct generic_pm_domain *genpd;
>         int ret = 0;
>
> @@ -1201,6 +1202,7 @@ static int genpd_finish_suspend(struct device *dev, bool poweroff)
>         }
>
>         genpd_lock(genpd);
> +       gpd_data->pm_pstate = genpd_drop_performance_state(dev);
>         genpd->suspended_count++;
>         genpd_sync_power_off(genpd, true, 0);
>         genpd_unlock(genpd);
> @@ -1245,6 +1247,7 @@ static int genpd_resume_noirq(struct device *dev)
>         genpd_lock(genpd);
>         genpd_sync_power_on(genpd, true, 0);
>         genpd->suspended_count--;
> +       genpd_restore_performance_state(dev, dev_gpd_data(dev)->pm_pstate);
>         genpd_unlock(genpd);
>
>         if (genpd->dev_ops.stop && genpd->dev_ops.start &&
> @@ -1364,6 +1367,7 @@ static int genpd_restore_noirq(struct device *dev)
>         }
>
>         genpd_sync_power_on(genpd, true, 0);
> +       genpd_restore_performance_state(dev, dev_gpd_data(dev)->pm_pstate);
>         genpd_unlock(genpd);
>
>         if (genpd->dev_ops.stop && genpd->dev_ops.start &&
> @@ -1409,23 +1413,28 @@ static void genpd_complete(struct device *dev)
>  static void genpd_switch_state(struct device *dev, bool suspend)
>  {
>         struct generic_pm_domain *genpd;
> +       struct generic_pm_domain_data *gpd_data;
>         bool use_lock;
>
>         genpd = dev_to_genpd_safe(dev);
>         if (!genpd)
>                 return;
>
> +       gpd_data = dev_gpd_data(dev);
> +
>         use_lock = genpd_is_irq_safe(genpd);
>
>         if (use_lock)
>                 genpd_lock(genpd);
>
>         if (suspend) {
> +               gpd_data->pm_pstate = genpd_drop_performance_state(dev);
>                 genpd->suspended_count++;
>                 genpd_sync_power_off(genpd, use_lock, 0);
>         } else {
>                 genpd_sync_power_on(genpd, use_lock, 0);
>                 genpd->suspended_count--;
> +               genpd_restore_performance_state(dev, gpd_data->pm_pstate);
>         }
>
>         if (use_lock)
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 21a0577305ef..f6e9dc28621c 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -199,6 +199,7 @@ struct generic_pm_domain_data {
>         int cpu;
>         unsigned int performance_state;
>         unsigned int rpm_pstate;
> +       unsigned int pm_pstate;
>         ktime_t next_wakeup;
>         void *data;
>  };
> --
> 2.25.1
>
