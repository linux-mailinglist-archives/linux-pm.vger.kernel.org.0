Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1983FE089
	for <lists+linux-pm@lfdr.de>; Wed,  1 Sep 2021 18:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344256AbhIARAs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Sep 2021 13:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234349AbhIARAs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Sep 2021 13:00:48 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27376C061575
        for <linux-pm@vger.kernel.org>; Wed,  1 Sep 2021 09:59:51 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id x27so357987lfu.5
        for <linux-pm@vger.kernel.org>; Wed, 01 Sep 2021 09:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t8WjY9xngdUy6OvsDh3/CWFvSQy2KcaCN1sVzYIar00=;
        b=GS9PQ5ZBAKPkQP+GbdP9U8KYEp0JuiDw6ovyYgLIEonW1pM+FuqnDLYZ2cm3pvnwZL
         yc64UVYyxiF+SC6Ylw/JFukJUMZmNnOebrnE95FYllALz+gIio0GjLywZ/PfRBr+C7Yx
         0k2SEEWUJX0q9LZSLaxlXyhNESAAFATbY+oXq5dC6WLP1Q28tOK4o4qY0eo9qn7Xc3lv
         FKyv/A6LWEUYJu5M4S8Zp93EyYDVw98DzqaC0dFGNhiRYzgtPncZFfS7h3xzbPNAqhhp
         C3IPjUkmJOoITRrQmWj0PI2MwdZxyJ8mCj8hvZavMLBQ7Se3ew8xo/pUOMISbDlu1Zux
         PQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t8WjY9xngdUy6OvsDh3/CWFvSQy2KcaCN1sVzYIar00=;
        b=rUkd9Ga1Pqn5r0lcrBtFcQb2R8iiRdMpnS8U1K8et13/K9QQnxuGSFqwHCIGeIkkhh
         9sFea28rV1x3trmecwbRqQThqcx9yznMkZhqBvqWprzZAclR7Ma47sa021SuV/YQJcBn
         ip63vJAN9sV6ofVOKPKG3G+i4mK3bt6ZNqjhC+zWZ9FtLefLvc6XyuYcJCvgBVv26THr
         lxSqPAbKy9hKBiey0rsI7GBipPil2/ouaTr8d2T1ehStP6zy/TOz3xRhXCeGEZJ1x0d5
         LdW67P8LJHaCATqoFOw3BGGpytnGA4pecZiMC/00ITxawc4FoqPRNfd6jhyLnvx0mTQR
         qpKg==
X-Gm-Message-State: AOAM533EW6joYsJ75X7olvigKxECWhisCWBDX/wj4hEjeG3vqh6zRtBB
        Yim2xDDQOKi4xrDLX3Pj4QfKBC+ociZKlUMtt6HZnQ==
X-Google-Smtp-Source: ABdhPJyny3XUrz8jbRp3Axy8yyjybmKwnX+mvzOZ21GwLJ+Qmr/zVkOylsu+PJqahnQ7P5+FmIoBXBgYhvv2uqMajGE=
X-Received: by 2002:a05:6512:1084:: with SMTP id j4mr309860lfg.113.1630515589441;
 Wed, 01 Sep 2021 09:59:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210831135450.26070-1-digetx@gmail.com> <20210831135450.26070-5-digetx@gmail.com>
In-Reply-To: <20210831135450.26070-5-digetx@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 1 Sep 2021 18:59:12 +0200
Message-ID: <CAPDyKFp4M30y9UB5Ss54ZfNjL_a6nqbka6Dq7xtGNzb2Mg8WrA@mail.gmail.com>
Subject: Re: [PATCH v10 4/8] PM: domains: Add dev_get_performance_state() callback
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 31 Aug 2021 at 15:57, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> Add optional dev_get_performance_state() callback that retrieves
> performance state of a device attached to a power domain. The new callback
> returns performance states of the given device, which should be read out
> from hardware.
>
> GENPD core assumes that initially performance state of all devices is
> zero and consumer device driver is responsible for management of the
> performance state. GENPD core now manages performance state across RPM
> suspend/resume of consumer devices by dropping and restoring the state,
> this allowed to move a part of performance management code into GENPD
> core out of consumer drivers. The part that hasn't been moved to GENPD
> core yet is the initialization of the performance state.
>
> Hardware may be preprogrammed to a specific performance state which
> isn't zero initially, hence the PD's performance state is inconsistent
> with hardware at the init time. This requires each consumer driver to
> explicitly sync the state. For some platforms this is a boilerplate code
> replicated by each driver.
>
> The new callback allows GENPD core to initialize the performance state,
> allowing to remove the remaining boilerplate code from consumer drivers.
> Now, when consumer device is resumed for the first time, the performance
> state is either already set by GENPD core or it will be set in accordance
> to the hardware state that was retrieved using the new callback when device
> was attached to a power domain. Still, consumer drivers are free to override
> the initial performance state configured by GENPD, if necessary.

Thanks for improving the commit message, it makes much better sense now!

>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/base/power/domain.c | 90 +++++++++++++++++++++++++++++++------
>  include/linux/pm_domain.h   |  2 +
>  2 files changed, 79 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 5db704f02e71..598528abce01 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2644,12 +2644,85 @@ static void genpd_dev_pm_sync(struct device *dev)
>         genpd_queue_power_off_work(pd);
>  }
>
> +static int genpd_dev_get_current_performance_state(struct device *dev,
> +                                                  struct device *base_dev,
> +                                                  unsigned int index,
> +                                                  bool *state_default,
> +                                                  bool *suspended)
> +{
> +       struct generic_pm_domain *pd = dev_to_genpd(dev);
> +       int ret;
> +
> +       ret = of_get_required_opp_performance_state(dev->of_node, index);
> +       if (ret < 0 && ret != -ENODEV && ret != -EOPNOTSUPP) {
> +               dev_err(dev, "failed to get required performance state for power-domain %s: %d\n",
> +                       pd->name, ret);
> +
> +               return ret;
> +       } else if (ret >= 0) {
> +               *state_default = true;
> +
> +               return ret;
> +       }
> +
> +       if (pd->dev_get_performance_state) {
> +               ret = pd->dev_get_performance_state(pd, base_dev);
> +               if (ret >= 0)
> +                       *suspended = pm_runtime_status_suspended(base_dev);
> +               else
> +                       dev_err(dev, "failed to get performance state of %s for power-domain %s: %d\n",
> +                               dev_name(base_dev), pd->name, ret);
> +
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static int genpd_dev_initialize_performance_state(struct device *dev,
> +                                                 struct device *base_dev,
> +                                                 unsigned int index)
> +{
> +       struct generic_pm_domain *pd = dev_to_genpd(dev);
> +       bool state_default = false, suspended = false;
> +       int pstate, err;
> +
> +       pstate = genpd_dev_get_current_performance_state(dev, base_dev, index,
> +                                                        &state_default,
> +                                                        &suspended);
> +       if (pstate <= 0)
> +               return pstate;
> +
> +       /*
> +        * If device is suspended, then performance state will be applied
> +        * on RPM-resume. This prevents potential extra power consumption
> +        * if device won't be resumed soon.
> +        *
> +        * If device is known to be active at the moment, then the performance
> +        * state should be updated immediately to sync state with hardware.
> +        */
> +       if (suspended) {
> +               dev_gpd_data(dev)->rpm_pstate = pstate;
> +       } else {
> +               err = dev_pm_genpd_set_performance_state(dev, pstate);
> +               if (err) {
> +                       dev_err(dev, "failed to set performance state for power-domain %s: %d\n",
> +                               pd->name, err);
> +                       return err;
> +               }
> +
> +               if (state_default)
> +                       dev_gpd_data(dev)->default_pstate = pstate;
> +       }
> +
> +       return 0;
> +}

As I kind of indicated in my previous reply on the earlier version, I
think the above code can be made a lot less complicated. Although,
perhaps I may be missing some points.

Anyway, I will post a couple patches, later this evening or tomorrow,
to show more exactly what I had in mind. Let's see if that can work
for you.

> +
>  static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>                                  unsigned int index, bool power_on)
>  {
>         struct of_phandle_args pd_args;
>         struct generic_pm_domain *pd;
> -       int pstate;
>         int ret;
>
>         ret = of_parse_phandle_with_args(dev->of_node, "power-domains",
> @@ -2693,22 +2766,13 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>                 return -EPROBE_DEFER;
>         }
>
> -       /* Set the default performance state */
> -       pstate = of_get_required_opp_performance_state(dev->of_node, index);
> -       if (pstate < 0 && pstate != -ENODEV && pstate != -EOPNOTSUPP) {
> -               ret = pstate;
> +       ret = genpd_dev_initialize_performance_state(dev, base_dev, index);
> +       if (ret)
>                 goto err;
> -       } else if (pstate > 0) {
> -               ret = dev_pm_genpd_set_performance_state(dev, pstate);
> -               if (ret)
> -                       goto err;
> -               dev_gpd_data(dev)->default_pstate = pstate;
> -       }
> +
>         return 1;
>
>  err:
> -       dev_err(dev, "failed to set required performance state for power-domain %s: %d\n",
> -               pd->name, ret);
>         genpd_remove_device(pd, dev);
>         return ret;
>  }
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 67017c9390c8..0a4dd4986f34 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -133,6 +133,8 @@ struct generic_pm_domain {
>                                                  struct dev_pm_opp *opp);
>         int (*set_performance_state)(struct generic_pm_domain *genpd,
>                                      unsigned int state);
> +       int (*dev_get_performance_state)(struct generic_pm_domain *genpd,
> +                                        struct device *dev);
>         struct gpd_dev_ops dev_ops;
>         s64 max_off_time_ns;    /* Maximum allowed "suspended" time. */
>         ktime_t next_wakeup;    /* Maintained by the domain governor */
> --
> 2.32.0
>

Kind regards
Uffe
