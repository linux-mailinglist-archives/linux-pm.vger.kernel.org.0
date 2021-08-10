Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0993E589D
	for <lists+linux-pm@lfdr.de>; Tue, 10 Aug 2021 12:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239918AbhHJKxB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Aug 2021 06:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239915AbhHJKw5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Aug 2021 06:52:57 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3345FC061798
        for <linux-pm@vger.kernel.org>; Tue, 10 Aug 2021 03:52:33 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id a1so12035439vsd.12
        for <linux-pm@vger.kernel.org>; Tue, 10 Aug 2021 03:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kkC6vw/nIsxxorXLh8xAxP8AQ/juulGmKbgNcn598kM=;
        b=Wyodofo3ec7HGMQX6ROxwP+EDUe7LkX2JkuC7wrFDWeE5S6f2RBX9C+wsJ67kIdVZ+
         GUFrVSQE877bA5rQCXfWX4VoCROmqNuHTNnOrbv8Dj1AofW5PZ+PSjoTIiS4OLsd2fFy
         +HTK6UrqkJaUpYMIeandEufnw4s2/SiLWUWADQLCAZMZ4M5pnmMVQ//pQFvsHYgchN/t
         1H7sYE0vtYW1qK9nA0pjWVInyPHZZqjzLcQ4ntpuGF8feFmkG3uFDrNChksVg1gUi5dS
         JQmY+ZMdINzS+EOjXYvVAlMogswniXugiWoHrFgViRHu44QIYysz7ee2xyuoZymUH6Zq
         64/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kkC6vw/nIsxxorXLh8xAxP8AQ/juulGmKbgNcn598kM=;
        b=ntIcumnhC8sL/9vC+HcDRi8pL/+mgo8c2ZmuAYFkgoMAK1IYJaogp2Q2cA3K7oKPuU
         89cbNoij1itFqq3YPR7ayJ8qKqfUSsQ7FaGzq9by+LYpeWiuMhidG4DSXAI04Gi81qle
         QrsJCMB1ARTzF7UrgJnf5swzw6HSKX/WwxdLbR5KZxrIWlJEEUfkWAYtBZrbNBq+99mA
         kPERMEuUteHuvfZVwLj14Kp/J34xMyS3nbhGi+2jNaWSsPd6tbR3WK4/paoGqdTKcfXD
         tgVDDqZUUEZlWW4we6P2UCRw6q+CbeGcCYPLuhxOqIaFmYuBEj1n66rpi/EwVYlrGIMS
         K+6g==
X-Gm-Message-State: AOAM530ZgIGW0xNw6xW96QHvu79R0bRQx9gLo+ENR+LENIw1ENPp1yeo
        dVOUIA/PMLO1TsaEcxalx0omGK/ReXcRIGEcdSbIvg==
X-Google-Smtp-Source: ABdhPJye8YsENzn2QTr+QGf2ceGs5HIzAA5tCOQptgpVORihDxyhMk/3vtGO4r3gAvsv3bnAwwsAZxlq8qZHgYITBsM=
X-Received: by 2002:a67:e901:: with SMTP id c1mr4585011vso.42.1628592751731;
 Tue, 10 Aug 2021 03:52:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210701232728.23591-1-digetx@gmail.com> <20210701232728.23591-3-digetx@gmail.com>
 <CAPDyKFrtWDYJo_NjS8306Z9ykbg7XZ55jC9hKEBMGkcrx1=4kQ@mail.gmail.com>
 <1034458d-78e0-5036-e278-6fee5d0d75ac@gmail.com> <CAPDyKFoafAk72Kw6X7626Niduaii0V5VM4dGSWmq+e3JTh7VRg@mail.gmail.com>
 <a5dfdf59-f5b5-d28e-6b02-b0c860ba8d80@gmail.com> <CAPDyKFq+ExjbGrN=yUUXPKfN_fGrwY6EAYn9a6VUFFU_VjhC=g@mail.gmail.com>
 <6741262b-386b-7635-fd42-ebd4f877fddd@gmail.com>
In-Reply-To: <6741262b-386b-7635-fd42-ebd4f877fddd@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Aug 2021 12:51:55 +0200
Message-ID: <CAPDyKFpJhX51rOnvbYTmj9Akd+xX+b7xcSWt87UDrvMEfYOZ7Q@mail.gmail.com>
Subject: Re: [PATCH v7 02/37] soc/tegra: pmc: Implement attach_dev() of power
 domain drivers
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 10 Aug 2021 at 01:56, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 09.08.2021 17:15, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >> We did that in a previous versions of this series where drivers were
> >> calling devm_tegra_core_dev_init_opp_table() helper during the probe t=
o
> >> initialize performance state of the domain. Moving OPP state
> >> initialization into central place made drivers cleaner by removing the
> >> boilerplate code.
> > I am not against doing this in a central place, like $subject patch
> > suggests. As a matter of fact, it makes perfect sense to me.
> >
> > However, what I am concerned about, is that you require to use genpd
> > internal data structures to do it. I think we should try to avoid
> > that.
>
> Alright, what do you think about this:
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index a934c679e6ce..5faed62075e9 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2669,12 +2669,37 @@ static int __genpd_dev_pm_attach(struct device *d=
ev, struct device *base_dev,
>         dev->pm_domain->detach =3D genpd_dev_pm_detach;
>         dev->pm_domain->sync =3D genpd_dev_pm_sync;
>
> +       if (pd->default_performance_state) {
> +               unsigned int default_pstate;
> +
> +               ret =3D pd->default_performance_state(pd, dev);
> +               if (ret < 0) {
> +                       dev_err(dev, "failed to get default performance s=
tate for PM domain %s: %d\n",
> +                               pd->name, ret);
> +                       goto out;
> +               }

Adding a new callback seems reasonable to support this.

> +
> +               default_pstate =3D ret;
> +
> +               if (power_on) {
> +                       ret =3D dev_pm_genpd_set_performance_state(dev, d=
efault_pstate);

However, this is more questionable to me.

First, I don't think we should care about whether this is "power_on"
or not. At this point, performance states are treated orthogonal to
idle states in genpd. We may decide to change that in some way, but
that deserves a different change.

Second, I don't think we should call
dev_pm_genpd_set_performance_state() from here. It's probably better
handled from the genpd callback itself, if/when needed.

That said, perhaps the new callback should just return a regular error
code and zero on success, rather than the current performance state.
See more below.

> +                       if (ret) {
> +                               dev_err(dev, "failed to set default perfo=
rmance state %u for PM domain %s: %d\n",
> +                                       default_pstate, pd->name, ret);
> +                               goto out;
> +                       }
> +               } else {
> +                       dev_gpd_data(dev)->rpm_pstate =3D default_pstate;

No, this isn't the right thing to do.

It looks like you are trying to use the ->rpm_pstate for
synchronization with runtime PM for consumer drivers. This is fragile
as it depends on the runtime PM deployment in the consumer driver. I
think you should look at ->rpm_pstate as a variable solely for
managing save/restore of the performance state for the device, during
runtime suspend/resume in genpd.

Synchronization of a vote for a performance state for a device, needs
to be managed by calling dev_pm_genpd_set_performance_state() - or by
calling an OPP function that calls it, like dev_pm_opp_set_rate(), for
example.

> +               }
> +       }
> +
>         if (power_on) {
>                 genpd_lock(pd);
>                 ret =3D genpd_power_on(pd, 0);
>                 genpd_unlock(pd);
>         }
>
> +out:
>         if (ret)
>                 genpd_remove_device(pd, dev);
>
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index 81d1f019fa0c..9efb55f52462 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -518,15 +518,14 @@ static const char * const tegra_emc_compats[] =3D {
>   * We retrieve clock rate of the attached device and initialize domain's
>   * performance state in accordance to the clock rate.
>   */
> -static int tegra_pmc_pd_attach_dev(struct generic_pm_domain *genpd,
> -                                  struct device *dev)
> +static int tegra_pmc_genpd_default_perf_state(struct generic_pm_domain *=
genpd,
> +                                             struct device *dev)
>  {
> -       struct generic_pm_domain_data *gpd_data =3D dev_gpd_data(dev);
>         struct opp_table *opp_table, *pd_opp_table;
>         struct generic_pm_domain *core_genpd;
>         struct dev_pm_opp *opp, *pd_opp;
> -       unsigned long rate, state;
>         struct gpd_link *link;
> +       unsigned long rate;
>         struct clk *clk;
>         u32 hw_version;
>         int ret;
> @@ -633,8 +632,7 @@ static int tegra_pmc_pd_attach_dev(struct generic_pm_=
domain *genpd,
>          * RPM-resume of the device.  This means that drivers don't need =
to
>          * explicitly initialize performance state.
>          */
> -       state =3D pm_genpd_opp_to_performance_state(&core_genpd->dev, pd_=
opp);
> -       gpd_data->rpm_pstate =3D state;
> +       ret =3D pm_genpd_opp_to_performance_state(&core_genpd->dev, pd_op=
p);

I don't see how this avoids tegra_pmc_genpd_default_perf_state() from
having to walk &genpd->child_links.

That's still an issue, right?

>         dev_pm_opp_put(pd_opp);
>
>  put_pd_opp_table:
> @@ -1383,7 +1381,7 @@ static int tegra_powergate_add(struct tegra_pmc *pm=
c, struct device_node *np)
>
>         pg->id =3D id;
>         pg->genpd.name =3D np->name;
> -       pg->genpd.attach_dev =3D tegra_pmc_pd_attach_dev;
> +       pg->genpd.default_performance_state =3D tegra_pmc_genpd_default_p=
erf_state;
>         pg->genpd.power_off =3D tegra_genpd_power_off;
>         pg->genpd.power_on =3D tegra_genpd_power_on;
>         pg->pmc =3D pmc;
> @@ -1500,7 +1498,7 @@ static int tegra_pmc_core_pd_add(struct tegra_pmc *=
pmc, struct device_node *np)
>                 return -ENOMEM;
>
>         genpd->name =3D np->name;
> -       genpd->attach_dev =3D tegra_pmc_pd_attach_dev;
> +       genpd->default_performance_state =3D tegra_pmc_genpd_default_perf=
_state;
>         genpd->set_performance_state =3D tegra_pmc_core_pd_set_performanc=
e_state;
>         genpd->opp_to_performance_state =3D tegra_pmc_core_pd_opp_to_perf=
ormance_state;
>
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 21a0577305ef..cd4867817ca5 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -143,6 +143,8 @@ struct generic_pm_domain {
>                           struct device *dev);
>         void (*detach_dev)(struct generic_pm_domain *domain,
>                            struct device *dev);
> +       int (*default_performance_state)(struct generic_pm_domain *domain=
,
> +                                        struct device *dev);
>         unsigned int flags;             /* Bit field of configs for genpd=
 */
>         struct genpd_power_state *states;
>         void (*free_states)(struct genpd_power_state *states,
>
> >> I can revert back to the previous variant, although this variant works
> >> well too.
> > I looked at that code and in that path we end up calling
> > dev_pm_opp_set_rate(), after it has initialized the opp table for the
> > device.
> >
> > Rather than doing the OF parsing above to find out the current state
> > for the device, why can't you just call dev_pm_opp_set_rate() to
> > initialize a proper vote instead?
> >
>
> For some devices clock rate is either preset by bootloader, or by clk dri=
ver, or by assigned-clocks in a device-tree. And then I don't see what's th=
e difference in comparison to initialization for the current rate.
>
> For some devices, like memory controller, we can't just change the clock =
rate because it's a complex procedure and some boards will use fixed rate, =
but the power vote still must be initialized.

I am not saying you should change the clock rate. The current code
path that runs via devm_tegra_core_dev_init_opp_table() just calls
clk_get_rate and then dev_pm_opp_set_rate() with the current rate to
vote for the corresponding OPP level. Right?

Isn't this exactly what you want? No?

Kind regards
Uffe
