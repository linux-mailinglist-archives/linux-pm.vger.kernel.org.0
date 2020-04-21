Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAE31B28E0
	for <lists+linux-pm@lfdr.de>; Tue, 21 Apr 2020 16:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbgDUOAr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Apr 2020 10:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728285AbgDUOAq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Apr 2020 10:00:46 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7EBC061A10
        for <linux-pm@vger.kernel.org>; Tue, 21 Apr 2020 07:00:46 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id g184so8478240vsc.0
        for <linux-pm@vger.kernel.org>; Tue, 21 Apr 2020 07:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ufO0oc55SP4ppmrO49IkerUiLNfh37ywo2Lik40Adk=;
        b=kCcz+VvyC/0IdI5gEKgvRf59mDcFEWTu/D1Ov9OACQKF1YEkdo/czGTGb09gPZe9nz
         CfsRp2cuik7vLYUVXc/zRZIz/M1iAydX8PM+/hsH0pTD5HFXabDTfMSk9eFgJkf3ycO7
         HwuB5lGEuv0muapa9Iicl4fVKvJVOBKTUwZNnrjM1HewRbx4nfgTaatf1/BoG80s61zW
         zUZqNfnUAgdZ4NNjRfNyQ7RzgUiJnjKAU5TERSmQGAsn+H+9jQpQp0sn66wVsw8QKIBy
         9i+kJngnYZVql2Yc/4MY3Wcxtw20Jw09IHP0gKmV2Uy8DOQ/gPTUZZAHunscQ2NmHS2m
         LbgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ufO0oc55SP4ppmrO49IkerUiLNfh37ywo2Lik40Adk=;
        b=P4Sr1bu0/AS/FJ7iEj9mbCdxkbTsTT+gc7Mq+fgh5jEAVqSHVDm5KlnuIbd/60oWpm
         WfgtrXk0FfG+jCODJsPBIUmxJZyKTNiOo1mpAC5ZQLWD4j9vAyELczEzAf/qFLOqtKA/
         dOUlbjlNbmbw6hfis4VWFxvjvGRjF/Xb7kGKgm7keF1gAoefIRePFlmiLucbiJZtfMU5
         zrh4mkGOP1oFIYoK6/3O+THjMlsvbn8fOl5kpAWHY38ifKFfFVQtIlztEWTSqJLgJW3/
         5jAcpFGRgDcUEaUYjfkE/BeM8FfLaEShuVQ/huHo8fGseEQehye4KFTXBjPQfY3upvxm
         rw6A==
X-Gm-Message-State: AGi0PuaZkXCk8JmxachSAKZ4W8j3uV0XNWeaalVAYMI5DsE7jfDHQmkr
        dPcRxhyBbBYiFOIsoGRslbxjy1u3Vof2sgKboGeL2Q==
X-Google-Smtp-Source: APiQypIQv+t4aZS0+jM79vzmZ4/jT5P5I5xj04qZzFmgC4QPVEnzYfRtjHR37+JUUyx2j+WbklBp5MY8qqFQMsGI4Pk=
X-Received: by 2002:a67:8b09:: with SMTP id n9mr15252066vsd.191.1587477645532;
 Tue, 21 Apr 2020 07:00:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200304121943.28989-1-daniel.baluta@oss.nxp.com> <20200304121943.28989-2-daniel.baluta@oss.nxp.com>
In-Reply-To: <20200304121943.28989-2-daniel.baluta@oss.nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 21 Apr 2020 16:00:09 +0200
Message-ID: <CAPDyKFp6KLuuuVFcEWGxn5NkuDSkhM-MjRiiYj_zC4mFxhOBag@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] PM / domains: Introduce multi PM domains helpers
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        ranjani.sridharan@linux.intel.com,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        alsa-devel@alsa-project.org, Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Kevin Hilman <khilman@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        paul.olaru@nxp.com, dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, shengjiu.wang@nxp.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 4 Mar 2020 at 13:20, Daniel Baluta <daniel.baluta@oss.nxp.com> wrote:
>
> From: Daniel Baluta <daniel.baluta@nxp.com>
>
> This patch introduces helpers support for multi PM domains.
>
> API consists of:
>
> 1) dev_multi_pm_attach - powers up all PM domains associated with a given
> device. Because we can attach one PM domain per device, we create
> virtual devices (children of initial device) and associate PM domains
> one per virtual device.
>
> 2) dev_multi_pm_detach - detaches all virtual devices from PM domains
> attached with.
>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

First, apologize for the delay.

In general I don't mind adding helpers that can be used to decrease
open coding. However, in this case, I wonder how useful the helpers
would really be.

More precisely, according to the information I have, a device may not
always need all of its PM domains to be turned on together, but
perhaps only a subset of them. Depending on the current use case that
is running.

Of course, some cases follow your expectations, but as stated, some
others do not.

Do you have an idea how many users that would be able to switch to
these new APIs as of today?

Kind regards
Uffe

> ---
>  drivers/base/power/common.c | 93 +++++++++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h   | 19 ++++++++
>  2 files changed, 112 insertions(+)
>
> diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
> index bbddb267c2e6..6d1f142833b1 100644
> --- a/drivers/base/power/common.c
> +++ b/drivers/base/power/common.c
> @@ -228,3 +228,96 @@ void dev_pm_domain_set(struct device *dev, struct dev_pm_domain *pd)
>         device_pm_check_callbacks(dev);
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_domain_set);
> +
> +/**
> + * dev_multi_pm_attach - power up device associated power domains
> + * @dev: The device used to lookup the PM domains
> + *
> + * Parse device's OF node to find all PM domains specifiers. For each power
> + * domain found, create a virtual device and associate it with the
> + * current power domain.
> + *
> + * This function should typically be invoked by a driver during the
> + * probe phase, in the case its device requires power management through
> + * multiple PM domains.
> + *
> + * Returns a pointer to @dev_multi_pm_domain_data if successfully attached PM
> + * domains, NULL when the device doesn't need a PM domain or when single
> + * power-domains exists for it, else an ERR_PTR() in case of
> + * failures.
> + */
> +struct dev_multi_pm_domain_data *dev_multi_pm_attach(struct device *dev)
> +{
> +       struct dev_multi_pm_domain_data *mpd, *retp;
> +       int num_domains;
> +       int i;
> +
> +       num_domains = of_count_phandle_with_args(dev->of_node, "power-domains",
> +                                                "#power-domain-cells");
> +       if (num_domains < 2)
> +               return NULL;
> +
> +       mpd = devm_kzalloc(dev, GFP_KERNEL, sizeof(*mpd));
> +       if (!mpd)
> +               return ERR_PTR(-ENOMEM);
> +
> +       mpd->dev = dev;
> +       mpd->num_domains = num_domains;
> +
> +       mpd->virt_devs = devm_kmalloc_array(dev, mpd->num_domains,
> +                                           sizeof(*mpd->virt_devs),
> +                                           GFP_KERNEL);
> +       if (!mpd->virt_devs)
> +               return ERR_PTR(-ENOMEM);
> +
> +       mpd->links = devm_kmalloc_array(dev, mpd->num_domains,
> +                                       sizeof(*mpd->links), GFP_KERNEL);
> +       if (!mpd->links)
> +               return ERR_PTR(-ENOMEM);
> +
> +       for (i = 0; i < mpd->num_domains; i++) {
> +               mpd->virt_devs[i] = dev_pm_domain_attach_by_id(dev, i);
> +               if (IS_ERR(mpd->virt_devs[i])) {
> +                       retp = (struct dev_multi_pm_domain_data *)
> +                               mpd->virt_devs[i];
> +                       goto exit_unroll_pm;
> +               }
> +               mpd->links[i] = device_link_add(dev, mpd->virt_devs[i],
> +                                               DL_FLAG_STATELESS |
> +                                               DL_FLAG_PM_RUNTIME |
> +                                               DL_FLAG_RPM_ACTIVE);
> +               if (!mpd->links[i]) {
> +                       retp = ERR_PTR(-ENOMEM);
> +                       dev_pm_domain_detach(mpd->virt_devs[i], false);
> +                       goto exit_unroll_pm;
> +               }
> +       }
> +       return mpd;
> +
> +exit_unroll_pm:
> +       while (--i >= 0) {
> +               device_link_del(mpd->links[i]);
> +               dev_pm_domain_detach(mpd->virt_devs[i], false);
> +       }
> +
> +       return retp;
> +}
> +EXPORT_SYMBOL(dev_multi_pm_attach);
> +
> +/**
> + * dev_multi_pm_detach - Detach a device from its PM domains.
> + * Each multi power domain is attached to a virtual children device
> + *
> + * @mpd: multi power domains data, contains the association between
> + * virtul device and PM domain
> + */
> +void dev_multi_pm_detach(struct dev_multi_pm_domain_data *mpd)
> +{
> +       int i;
> +
> +       for (i = 0; i < mpd->num_domains; i++) {
> +               device_link_del(mpd->links[i]);
> +               dev_pm_domain_detach(mpd->virt_devs[i], false);
> +       }
> +}
> +EXPORT_SYMBOL(dev_multi_pm_detach);
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 9ec78ee53652..5bcb35150af2 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -183,6 +183,13 @@ struct generic_pm_domain_data {
>         void *data;
>  };
>
> +struct dev_multi_pm_domain_data {
> +       struct device *dev; /* parent device */
> +       struct device **virt_devs; /* virtual children links */
> +       struct device_link **links; /*  links parent <-> virtual children */
> +       int num_domains;
> +};
> +
>  #ifdef CONFIG_PM_GENERIC_DOMAINS
>  static inline struct generic_pm_domain_data *to_gpd_data(struct pm_domain_data *pdd)
>  {
> @@ -369,18 +376,27 @@ struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
>
>  #ifdef CONFIG_PM
>  int dev_pm_domain_attach(struct device *dev, bool power_on);
> +struct dev_multi_pm_domain_data *dev_multi_pm_attach(struct device *dev);
>  struct device *dev_pm_domain_attach_by_id(struct device *dev,
>                                           unsigned int index);
>  struct device *dev_pm_domain_attach_by_name(struct device *dev,
>                                             const char *name);
>  void dev_pm_domain_detach(struct device *dev, bool power_off);
>  int dev_pm_domain_start(struct device *dev);
> +void dev_multi_pm_detach(struct dev_multi_pm_domain_data *mpd);
>  void dev_pm_domain_set(struct device *dev, struct dev_pm_domain *pd);
> +
>  #else
>  static inline int dev_pm_domain_attach(struct device *dev, bool power_on)
>  {
>         return 0;
>  }
> +
> +struct dev_multi_pm_domain_data *dev_multi_pm_attach(struct device *dev)
> +{
> +       return NULL;
> +}
> +
>  static inline struct device *dev_pm_domain_attach_by_id(struct device *dev,
>                                                         unsigned int index)
>  {
> @@ -396,6 +412,9 @@ static inline int dev_pm_domain_start(struct device *dev)
>  {
>         return 0;
>  }
> +
> +void dev_multi_pm_detach(struct dev_multi_pm_domain_data *mpd) {}
> +
>  static inline void dev_pm_domain_set(struct device *dev,
>                                      struct dev_pm_domain *pd) {}
>  #endif
> --
> 2.17.1
>
