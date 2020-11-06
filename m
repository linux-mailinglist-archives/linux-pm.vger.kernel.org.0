Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 980162A944D
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 11:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgKFK0m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 05:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbgKFK0E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 05:26:04 -0500
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BC8C0613D2
        for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2020 02:26:04 -0800 (PST)
Received: by mail-vk1-xa42.google.com with SMTP id t67so133216vkb.8
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2020 02:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HSC97YNOlN2kUh5wdqOB/lybRqmpts3XhUMXVzBRpuU=;
        b=WVh1sV7yTyGnxFKwH/kCFJLI0h+xKJLCEKlfhXMjzg8UywCK08uPFzALrz6uq9v7rg
         x+XpUNuSHdsZJCwYaK4K1KknKsNCC05506QxKcbMSr6MfzBOOjqvzzdOGZWg9fTZKPK0
         hBkFJs3I6pjmGsbpA1/V5mShpiM1BPXboGdbn//dpAMyFEWLt2WkYa6ErIHd0X+UGA1e
         pGPA/JhWGaCiamS3+eVyGQUuVYA38sq3AYFWm0gyO5qxzhD/jzFAhBhmuOW5SiLEmWI0
         vXmP8C/EAzW9gR8Y6mJx/r+GKeuTiIdQkWKKpAVFiXt0igDVfmI0iRBZlozAcFQPJT4d
         2gNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HSC97YNOlN2kUh5wdqOB/lybRqmpts3XhUMXVzBRpuU=;
        b=QhAkAH9uX41UHO1bLdBAl6Fx4m+rkPTgvCZEXQy7YSMkB48bzu9RjrXWxAWZ6Ts/b3
         5qLXYATcB3oowKu+J2pMM33o2X842/3vqhBklYZxDCq1mO8GtFcCQJ2zsxwA0Fq38nw1
         ARPKYnjNcgVKdjDEmEbRZT1OcKS65uVU0sA8q/fld6Q4tPtVo4F9ouDnh5tTWtMz8mrB
         Je7yqHR7evZFdU7MCscNPN9CSdvlcUiUQUOPova7e2TdBC1e2mwVcWbpfI+anTq6qSv/
         r2nw4Z/I1eC+H30FByWbSUwgHSddjt+tFtyQ3k0HOQVPR5aN8snDVPU1D5MDGCL9gCY1
         XoTQ==
X-Gm-Message-State: AOAM533a3gmptgTqy+yJyz8/c977RfPunqo7QVljMvD7bcMtv1Wk68D6
        G15pZP7K7vkJQrmVGxZACxYszbi+/z+FrMPpBVBypQ==
X-Google-Smtp-Source: ABdhPJxdd1JSJRrUFF8pCsDcmoIO/ZpQ8q6imT4S/76iQuVwhK6KvpfjyD+DN9xfVBgmD7tDT/UUnyaOS/+J6hvUGd4=
X-Received: by 2002:a05:6122:10eb:: with SMTP id m11mr518387vko.8.1604658363558;
 Fri, 06 Nov 2020 02:26:03 -0800 (PST)
MIME-Version: 1.0
References: <684ff01900180c0a40ec307dacc673b24eab593b.1604643714.git.viresh.kumar@linaro.org>
 <1012a98950355bd5a52424668050a17c3430cbe0.1604643714.git.viresh.kumar@linaro.org>
In-Reply-To: <1012a98950355bd5a52424668050a17c3430cbe0.1604643714.git.viresh.kumar@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 6 Nov 2020 11:25:27 +0100
Message-ID: <CAPDyKFrTJbTrSMW30wN5Kbk4=yDAMF37HR2+9MKybkyDW0f8hQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] opp: Don't create an OPP table from dev_pm_opp_get_opp_table()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 6 Nov 2020 at 07:25, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> It has been found that some users (like cpufreq-dt and others on LKML)
> have abused the helper dev_pm_opp_get_opp_table() to create the OPP
> table instead of just finding it, which is the wrong thing to do. This
> routine was meant for OPP core's internal working and exposed the whole
> functionality by mistake.
>
> Change the scope of dev_pm_opp_get_opp_table() to only finding the
> table. The internal helpers _opp_get_opp_table*() are thus renamed to
> _add_opp_table*(), dev_pm_opp_get_opp_table_indexed() is removed (as we
> don't need the index field for finding the OPP table) and so the only
> user, genpd, is updated.
>
> Note that the prototype of _add_opp_table() was already left in opp.h by
> mistake when it was removed earlier and so we weren't required to add it
> now.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/domain.c |  2 +-
>  drivers/opp/core.c          | 27 +++++++++++++--------------
>  drivers/opp/of.c            |  4 ++--
>  drivers/opp/opp.h           |  1 +
>  include/linux/pm_opp.h      |  1 -
>  5 files changed, 17 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 743268996336..92b750b865d5 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2249,7 +2249,7 @@ int of_genpd_add_provider_onecell(struct device_node *np,
>                          * Save table for faster processing while setting
>                          * performance state.
>                          */
> -                       genpd->opp_table = dev_pm_opp_get_opp_table_indexed(&genpd->dev, i);
> +                       genpd->opp_table = dev_pm_opp_get_opp_table(&genpd->dev);
>                         WARN_ON(IS_ERR(genpd->opp_table));
>                 }
>
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 9915e8487f0b..b24f685823ae 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1138,7 +1138,7 @@ void _get_opp_table_kref(struct opp_table *opp_table)
>   * uses the opp_tables_busy flag to indicate if another creator is in the middle
>   * of adding an OPP table and others should wait for it to finish.
>   */
> -static struct opp_table *_opp_get_opp_table(struct device *dev, int index)
> +struct opp_table *_add_opp_table_indexed(struct device *dev, int index)
>  {
>         struct opp_table *opp_table;
>
> @@ -1188,17 +1188,16 @@ static struct opp_table *_opp_get_opp_table(struct device *dev, int index)
>         return opp_table;
>  }
>
> -struct opp_table *dev_pm_opp_get_opp_table(struct device *dev)
> +struct opp_table *_add_opp_table(struct device *dev)
>  {
> -       return _opp_get_opp_table(dev, 0);
> +       return _add_opp_table_indexed(dev, 0);
>  }
> -EXPORT_SYMBOL_GPL(dev_pm_opp_get_opp_table);
>
> -struct opp_table *dev_pm_opp_get_opp_table_indexed(struct device *dev,
> -                                                  int index)
> +struct opp_table *dev_pm_opp_get_opp_table(struct device *dev)
>  {
> -       return _opp_get_opp_table(dev, index);
> +       return _find_opp_table(dev);
>  }
> +EXPORT_SYMBOL_GPL(dev_pm_opp_get_opp_table);
>
>  static void _opp_table_kref_release(struct kref *kref)
>  {
> @@ -1627,7 +1626,7 @@ struct opp_table *dev_pm_opp_set_supported_hw(struct device *dev,
>  {
>         struct opp_table *opp_table;
>
> -       opp_table = dev_pm_opp_get_opp_table(dev);
> +       opp_table = _add_opp_table(dev);
>         if (IS_ERR(opp_table))
>                 return opp_table;
>
> @@ -1686,7 +1685,7 @@ struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name)
>  {
>         struct opp_table *opp_table;
>
> -       opp_table = dev_pm_opp_get_opp_table(dev);
> +       opp_table = _add_opp_table(dev);
>         if (IS_ERR(opp_table))
>                 return opp_table;
>
> @@ -1779,7 +1778,7 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
>         struct regulator *reg;
>         int ret, i;
>
> -       opp_table = dev_pm_opp_get_opp_table(dev);
> +       opp_table = _add_opp_table(dev);
>         if (IS_ERR(opp_table))
>                 return opp_table;
>
> @@ -1887,7 +1886,7 @@ struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name)
>         struct opp_table *opp_table;
>         int ret;
>
> -       opp_table = dev_pm_opp_get_opp_table(dev);
> +       opp_table = _add_opp_table(dev);
>         if (IS_ERR(opp_table))
>                 return opp_table;
>
> @@ -1955,7 +1954,7 @@ struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev,
>         if (!set_opp)
>                 return ERR_PTR(-EINVAL);
>
> -       opp_table = dev_pm_opp_get_opp_table(dev);
> +       opp_table = _add_opp_table(dev);
>         if (IS_ERR(opp_table))
>                 return opp_table;
>
> @@ -2039,7 +2038,7 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
>         int index = 0, ret = -EINVAL;
>         const char **name = names;
>
> -       opp_table = dev_pm_opp_get_opp_table(dev);
> +       opp_table = _add_opp_table(dev);
>         if (IS_ERR(opp_table))
>                 return opp_table;
>
> @@ -2204,7 +2203,7 @@ int dev_pm_opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
>         struct opp_table *opp_table;
>         int ret;
>
> -       opp_table = dev_pm_opp_get_opp_table(dev);
> +       opp_table = _add_opp_table(dev);
>         if (IS_ERR(opp_table))
>                 return PTR_ERR(opp_table);
>
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 9faeb83e4b32..c718092757d9 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -974,7 +974,7 @@ int dev_pm_opp_of_add_table(struct device *dev)
>         struct opp_table *opp_table;
>         int ret;
>
> -       opp_table = dev_pm_opp_get_opp_table_indexed(dev, 0);
> +       opp_table = _add_opp_table_indexed(dev, 0);
>         if (IS_ERR(opp_table))
>                 return PTR_ERR(opp_table);
>
> @@ -1029,7 +1029,7 @@ int dev_pm_opp_of_add_table_indexed(struct device *dev, int index)
>                         index = 0;
>         }
>
> -       opp_table = dev_pm_opp_get_opp_table_indexed(dev, index);
> +       opp_table = _add_opp_table_indexed(dev, index);
>         if (IS_ERR(opp_table))
>                 return PTR_ERR(opp_table);
>
> diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
> index ebd930e0b3ca..4ced7ffa8158 100644
> --- a/drivers/opp/opp.h
> +++ b/drivers/opp/opp.h
> @@ -224,6 +224,7 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp, struct opp_table *o
>  int _opp_add_v1(struct opp_table *opp_table, struct device *dev, unsigned long freq, long u_volt, bool dynamic);
>  void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, int last_cpu);
>  struct opp_table *_add_opp_table(struct device *dev);
> +struct opp_table *_add_opp_table_indexed(struct device *dev, int index);
>  void _put_opp_list_kref(struct opp_table *opp_table);
>
>  #ifdef CONFIG_OF
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index dbb484524f82..1435c054016a 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -90,7 +90,6 @@ struct dev_pm_set_opp_data {
>  #if defined(CONFIG_PM_OPP)
>
>  struct opp_table *dev_pm_opp_get_opp_table(struct device *dev);
> -struct opp_table *dev_pm_opp_get_opp_table_indexed(struct device *dev, int index);
>  void dev_pm_opp_put_opp_table(struct opp_table *opp_table);
>
>  unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp);
> --
> 2.25.0.rc1.19.g042ed3e048af
>
