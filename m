Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6A0242737
	for <lists+linux-pm@lfdr.de>; Wed, 12 Aug 2020 11:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgHLJLR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Aug 2020 05:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbgHLJLQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Aug 2020 05:11:16 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC02C061787
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2020 02:11:16 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l2so1302310wrc.7
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2020 02:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5JuupEkp5vod5HA205R9gxX6KMWGdIQCej3+1g8f03s=;
        b=USymMjrzE5SS30e13s++ZulJ4UxF8cO7xOEECOXqe5PQdc4o/pM7q96P8uhG/K8JsR
         vra5IZXOoU4ZU1ack01V3mvQ6LSvUyDe8VGmKu0E9wGUo6Wt39e2iowmhwwsz7AHGjsg
         Vm69i4ZbFNSjhuYj7f57xSTxYjhNvwvscsMImG2BPP9969+HvDWu1WKXmBGN8FXQReVa
         EIF1VJIjwjlLMlw4Yq9ukjVy8qzaoq9r/79AJ7htqqXtD6b4Mb8iQ7lIB6o+0VgNBRua
         YlkUeYM5yJJUC44Ygu23l0z7DDQrYr+H2jc3uRHsg3+XMA1WBr4KfOWhSCGkticoikIz
         EvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5JuupEkp5vod5HA205R9gxX6KMWGdIQCej3+1g8f03s=;
        b=PL+iW+wqxHUIlyRnyowui9kTCSqQ8hYRpfYEUCxteih7eFAYHZjc7FbTQGSBVDYyae
         BjVHefhWpJczx49Ti9MhnaYkAd6ztGeAcEQQ+kKuCLgtC4T7gVQJHxcluM3nx3b6j0TT
         G/u0xNrx+EFU1Cc3+XYXk7BXk1YR4eJhmnFz6hFv2HJn5DytdxOm69QbG3gnWrnF2HEO
         moF7UgTXXf5u4Cfj/CRhnqwS2O7QTDsy6uLof7CdF/BnE+WRrC+atUUHh0lS4fl6Txgx
         4sAmasuEDuVKN6RERfNErkAtuWmUaLwoEDm/SSvzylD5ZQQ81qVHujeBKomEx+MzcpmU
         RQ+Q==
X-Gm-Message-State: AOAM532328vpewseN+FsZPnz08PME7BSW/wRR6qrL/87E2BrDBAAsadx
        ZpAP5o9erhUrqZ4BDNQy5BJJ81cp4kbnhKJShNiSqw==
X-Google-Smtp-Source: ABdhPJxSYn57aBvxRMTSZ5fhuCgjCRJB77iTZyOHH6wA5r3SVDJbWMSFqMbPNZVWfTwffREQggHHiadxZW8Jf1XYbgk=
X-Received: by 2002:a05:6000:1203:: with SMTP id e3mr33611384wrx.324.1597223474540;
 Wed, 12 Aug 2020 02:11:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200727093047.8274-1-stephan@gerhold.net>
In-Reply-To: <20200727093047.8274-1-stephan@gerhold.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 12 Aug 2020 11:10:38 +0200
Message-ID: <CAPDyKFq9bbMZD7ifF=ipfBD3ayiLuc6RPwW8_RWZBxMGv_WZkw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] opp: Allow dev_pm_opp_get_opp_table() to return -EPROBE_DEFER
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Niklas Cassel <nks@flawful.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 27 Jul 2020 at 11:31, Stephan Gerhold <stephan@gerhold.net> wrote:
>
> The OPP core manages various resources, e.g. clocks or interconnect paths.
> These resources are looked up when the OPP table is allocated once
> dev_pm_opp_get_opp_table() is called the first time (either directly
> or indirectly through one of the many helper functions).
>
> At this point, the resources may not be available yet, i.e. looking them
> up will result in -EPROBE_DEFER. Unfortunately, dev_pm_opp_get_opp_table()
> is currently unable to propagate this error code since it only returns
> the allocated OPP table or NULL.
>
> This means that all consumers of the OPP core are required to make sure
> that all necessary resources are available. Usually this happens by
> requesting them, checking the result and releasing them immediately after.
>
> For example, we have added "dev_pm_opp_of_find_icc_paths(dev, NULL)" to
> several drivers now just to make sure the interconnect providers are
> ready before the OPP table is allocated. If this call is missing,
> the OPP core will only warn about this and then attempt to continue
> without interconnect. This will eventually fail horribly, e.g.:
>
>     cpu cpu0: _allocate_opp_table: Error finding interconnect paths: -517
>     ... later ...
>     of: _read_bw: Mismatch between opp-peak-kBps and paths (1 0)
>     cpu cpu0: _opp_add_static_v2: opp key field not found
>     cpu cpu0: _of_add_opp_table_v2: Failed to add OPP, -22
>
> This example happens when trying to use interconnects for a CPU OPP
> table together with qcom-cpufreq-nvmem.c. qcom-cpufreq-nvmem calls
> dev_pm_opp_set_supported_hw(), which ends up allocating the OPP table
> early. To fix the problem with the current approach we would need to add
> yet another call to dev_pm_opp_of_find_icc_paths(dev, NULL).
> But actually qcom-cpufreq-nvmem.c has nothing to do with interconnects...
>
> This commit attempts to make this more robust by allowing
> dev_pm_opp_get_opp_table() to return an error pointer. Fixing all
> the usages is trivial because the function is usually used indirectly
> through another helper (e.g. dev_pm_opp_set_supported_hw() above).
> These other helpers already return an error pointer.
>
> The example above then works correctly because set_supported_hw() will
> return -EPROBE_DEFER, and qcom-cpufreq-nvmem.c already propagates that
> error. It should also be possible to remove the remaining usages of
> "dev_pm_opp_of_find_icc_paths(dev, NULL)" from other drivers as well.
>
> Note that this commit currently only handles -EPROBE_DEFER for the
> clock/interconnects within _allocate_opp_table(). Other errors are just
> ignored as before. Eventually those should be propagated as well.
>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
> I wasn't sure if the changes in drivers/base/power/domain.c
> should be made in a separate commit, but they need to be made together
> with the other changes.

I would suggest to move the changes in drivers/base/power/domain.c
into a separate patch, still part of the series, but let it preceed
$subject patch.

>
> Also note that this is RFC because this is just something I got really
> frustrated about. There might be situations where this won't work correctly...?
> ---
>  drivers/base/power/domain.c | 28 ++++++++++++++++++-----

The above changes look good to me.

For the below, at a quick look I have no objections, but I am
deferring to Viresh to have a closer look.

Kind regards
Uffe

>  drivers/opp/core.c          | 45 ++++++++++++++++++++++---------------
>  drivers/opp/of.c            |  8 +++----
>  3 files changed, 53 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 2cb5e04cf86c..c50f2de952c4 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2044,8 +2044,9 @@ int of_genpd_add_provider_simple(struct device_node *np,
>         if (genpd->set_performance_state) {
>                 ret = dev_pm_opp_of_add_table(&genpd->dev);
>                 if (ret) {
> -                       dev_err(&genpd->dev, "Failed to add OPP table: %d\n",
> -                               ret);
> +                       if (ret != -EPROBE_DEFER)
> +                               dev_err(&genpd->dev, "Failed to add OPP table: %d\n",
> +                                       ret);
>                         goto unlock;
>                 }
>
> @@ -2054,7 +2055,14 @@ int of_genpd_add_provider_simple(struct device_node *np,
>                  * state.
>                  */
>                 genpd->opp_table = dev_pm_opp_get_opp_table(&genpd->dev);
> -               WARN_ON(!genpd->opp_table);
> +               if (IS_ERR(genpd->opp_table)) {
> +                       if (PTR_ERR(genpd->opp_table) != -EPROBE_DEFER)
> +                               dev_err(&genpd->dev, "Failed to get OPP table: %pe\n",
> +                                       genpd->opp_table);
> +
> +                       dev_pm_opp_of_remove_table(&genpd->dev);
> +                       goto unlock;
> +               }
>         }
>
>         ret = genpd_add_provider(np, genpd_xlate_simple, genpd);
> @@ -2111,8 +2119,9 @@ int of_genpd_add_provider_onecell(struct device_node *np,
>                 if (genpd->set_performance_state) {
>                         ret = dev_pm_opp_of_add_table_indexed(&genpd->dev, i);
>                         if (ret) {
> -                               dev_err(&genpd->dev, "Failed to add OPP table for index %d: %d\n",
> -                                       i, ret);
> +                               if (ret != -EPROBE_DEFER)
> +                                       dev_err(&genpd->dev, "Failed to add OPP table for index %d: %d\n",
> +                                               i, ret);
>                                 goto error;
>                         }
>
> @@ -2121,7 +2130,14 @@ int of_genpd_add_provider_onecell(struct device_node *np,
>                          * performance state.
>                          */
>                         genpd->opp_table = dev_pm_opp_get_opp_table_indexed(&genpd->dev, i);
> -                       WARN_ON(!genpd->opp_table);
> +                       if (IS_ERR(genpd->opp_table)) {
> +                               if (PTR_ERR(genpd->opp_table) != -EPROBE_DEFER)
> +                                       dev_err(&genpd->dev, "Failed to get OPP table: %pe\n",
> +                                               genpd->opp_table);
> +
> +                               dev_pm_opp_of_remove_table(&genpd->dev);
> +                               goto error;
> +                       }
>                 }
>
>                 genpd->provider = &np->fwnode;
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 9d7fb45b1786..45d24de75e0e 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1063,7 +1063,7 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
>          */
>         opp_table = kzalloc(sizeof(*opp_table), GFP_KERNEL);
>         if (!opp_table)
> -               return NULL;
> +               return ERR_PTR(-ENOMEM);
>
>         mutex_init(&opp_table->lock);
>         mutex_init(&opp_table->genpd_virt_dev_lock);
> @@ -1074,8 +1074,8 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
>
>         opp_dev = _add_opp_dev(dev, opp_table);
>         if (!opp_dev) {
> -               kfree(opp_table);
> -               return NULL;
> +               ret = -ENOMEM;
> +               goto err;
>         }
>
>         _of_init_opp_table(opp_table, dev, index);
> @@ -1087,13 +1087,18 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
>                 if (ret != -EPROBE_DEFER)
>                         dev_dbg(dev, "%s: Couldn't find clock: %d\n", __func__,
>                                 ret);
> +               else
> +                       goto err;
>         }
>
>         /* Find interconnect path(s) for the device */
>         ret = dev_pm_opp_of_find_icc_paths(dev, opp_table);
> -       if (ret)
> +       if (ret) {
> +               if (ret == -EPROBE_DEFER)
> +                       goto err;
>                 dev_warn(dev, "%s: Error finding interconnect paths: %d\n",
>                          __func__, ret);
> +       }
>
>         BLOCKING_INIT_NOTIFIER_HEAD(&opp_table->head);
>         INIT_LIST_HEAD(&opp_table->opp_list);
> @@ -1102,6 +1107,10 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
>         /* Secure the device table modification */
>         list_add(&opp_table->node, &opp_tables);
>         return opp_table;
> +
> +err:
> +       kfree(opp_table);
> +       return ERR_PTR(ret);
>  }
>
>  void _get_opp_table_kref(struct opp_table *opp_table)
> @@ -1568,8 +1577,8 @@ struct opp_table *dev_pm_opp_set_supported_hw(struct device *dev,
>         struct opp_table *opp_table;
>
>         opp_table = dev_pm_opp_get_opp_table(dev);
> -       if (!opp_table)
> -               return ERR_PTR(-ENOMEM);
> +       if (IS_ERR(opp_table))
> +               return opp_table;
>
>         /* Make sure there are no concurrent readers while updating opp_table */
>         WARN_ON(!list_empty(&opp_table->opp_list));
> @@ -1627,8 +1636,8 @@ struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name)
>         struct opp_table *opp_table;
>
>         opp_table = dev_pm_opp_get_opp_table(dev);
> -       if (!opp_table)
> -               return ERR_PTR(-ENOMEM);
> +       if (IS_ERR(opp_table))
> +               return opp_table;
>
>         /* Make sure there are no concurrent readers while updating opp_table */
>         WARN_ON(!list_empty(&opp_table->opp_list));
> @@ -1720,8 +1729,8 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
>         int ret, i;
>
>         opp_table = dev_pm_opp_get_opp_table(dev);
> -       if (!opp_table)
> -               return ERR_PTR(-ENOMEM);
> +       if (IS_ERR(opp_table))
> +               return opp_table;
>
>         /* This should be called before OPPs are initialized */
>         if (WARN_ON(!list_empty(&opp_table->opp_list))) {
> @@ -1830,8 +1839,8 @@ struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name)
>         int ret;
>
>         opp_table = dev_pm_opp_get_opp_table(dev);
> -       if (!opp_table)
> -               return ERR_PTR(-ENOMEM);
> +       if (IS_ERR(opp_table))
> +               return opp_table;
>
>         /* This should be called before OPPs are initialized */
>         if (WARN_ON(!list_empty(&opp_table->opp_list))) {
> @@ -1898,8 +1907,8 @@ struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev,
>                 return ERR_PTR(-EINVAL);
>
>         opp_table = dev_pm_opp_get_opp_table(dev);
> -       if (!opp_table)
> -               return ERR_PTR(-ENOMEM);
> +       if (!IS_ERR(opp_table))
> +               return opp_table;
>
>         /* This should be called before OPPs are initialized */
>         if (WARN_ON(!list_empty(&opp_table->opp_list))) {
> @@ -1979,8 +1988,8 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
>         const char **name = names;
>
>         opp_table = dev_pm_opp_get_opp_table(dev);
> -       if (!opp_table)
> -               return ERR_PTR(-ENOMEM);
> +       if (IS_ERR(opp_table))
> +               return opp_table;
>
>         /*
>          * If the genpd's OPP table isn't already initialized, parsing of the
> @@ -2150,8 +2159,8 @@ int dev_pm_opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
>         int ret;
>
>         opp_table = dev_pm_opp_get_opp_table(dev);
> -       if (!opp_table)
> -               return -ENOMEM;
> +       if (IS_ERR(opp_table))
> +               return PTR_ERR(opp_table);
>
>         /* Fix regulator count for dynamic OPPs */
>         opp_table->regulator_count = 1;
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 0430290670ab..d8b623cc015a 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -947,8 +947,8 @@ int dev_pm_opp_of_add_table(struct device *dev)
>         int ret;
>
>         opp_table = dev_pm_opp_get_opp_table_indexed(dev, 0);
> -       if (!opp_table)
> -               return -ENOMEM;
> +       if (IS_ERR(opp_table))
> +               return PTR_ERR(opp_table);
>
>         /*
>          * OPPs have two version of bindings now. Also try the old (v1)
> @@ -1002,8 +1002,8 @@ int dev_pm_opp_of_add_table_indexed(struct device *dev, int index)
>         }
>
>         opp_table = dev_pm_opp_get_opp_table_indexed(dev, index);
> -       if (!opp_table)
> -               return -ENOMEM;
> +       if (IS_ERR(opp_table))
> +               return PTR_ERR(opp_table);
>
>         ret = _of_add_opp_table_v2(dev, opp_table);
>         if (ret)
> --
> 2.27.0
>
