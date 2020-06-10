Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079BF1F5726
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jun 2020 16:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgFJO51 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jun 2020 10:57:27 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33077 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgFJO50 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jun 2020 10:57:26 -0400
Received: by mail-ot1-f67.google.com with SMTP id n6so1945370otl.0
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2020 07:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XdFkClp6SPDyznRFLoHA1XPaZyu1TjJ5om4wXazdiH0=;
        b=OAU+uiCd2cU0TpqJ1DEHvNR6TChe1Fmbl8B9tAZnHoQv5cv26iGFTyrkid5PTfALRK
         gXhHzsfow/pbFBfXT+LeBfc0OOEbNLA8ZdXYcMz5pN6rteEYVZpmX7EhA8X8Rh8xzblO
         o49IxUS9royZP2KJoz2ksfzj6pF972jp36KvlcvHVQ7Uj28I8RbekOj+loe9c2xxMo52
         YO3l9hBYHXfTIhWITrsIjDvkvh4Lwtqqvik+VEJV+jmLdtUh0BQBKQW25Li8NCtmArZV
         80UtNdKRe37UUoYsgcpG0+hyYZNTKRKmHJkA6xuo2cKClTvJG/1eS44Fu+Tw2WpfV5Zn
         /7fg==
X-Gm-Message-State: AOAM53049VWgr53Bzui/pXAT+BLTrUfZjA3gq+S5+HPUGfHMb6NlBtwv
        LBiYOBk16M6YhKX5vjQ7KQIhhGYEFp1KHajkyiI=
X-Google-Smtp-Source: ABdhPJxa2HKqwICHesYLpFNsF2QtJgDJ1SLOc4daKgdM4e8exdCOTn3djCUN/hE7dvq8B8Zztbqmzw71VueWKGN5z54=
X-Received: by 2002:a9d:be6:: with SMTP id 93mr2848359oth.167.1591801044952;
 Wed, 10 Jun 2020 07:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200610143943.12548-1-gustav.wiklander@axis.com>
In-Reply-To: <20200610143943.12548-1-gustav.wiklander@axis.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 10 Jun 2020 16:57:14 +0200
Message-ID: <CAJZ5v0jTBYxbgrMw161NUJNOyTZ_LW75e3Hs=MGfz7-z9Pftig@mail.gmail.com>
Subject: Re: [PATCH] PM / Domains: Add module ref count for each consumer
To:     Gustav Wiklander <gustav.wiklander@axis.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@axis.com, Gustav Wiklander <gustavwi@axis.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 10, 2020 at 4:39 PM Gustav Wiklander
<gustav.wiklander@axis.com> wrote:
>
> From: Gustav Wiklander <gustavwi@axis.com>
>
> Currently a pm_domain can be unloaded without regard for consumers.
> This patch adds a module dependecy for every registered consumer.
> Now a power domain driver can only be unloaded if no consumers are
> registered.
>
> Signed-off-by: Gustav Wiklander <gustavwi@axis.com>

The genpd code is not modular, though.

What problem exactly are you trying to address?

> ---
>  drivers/base/power/domain.c | 11 ++++++++++-
>  include/linux/pm_domain.h   |  2 ++
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 0a01df608849..80723f6d5e6b 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1499,11 +1499,18 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
>         if (IS_ERR(gpd_data))
>                 return PTR_ERR(gpd_data);
>
> +       if (!try_module_get(genpd->owner)) {
> +               ret = -ENODEV;
> +               goto out;
> +       }
> +
>         gpd_data->cpu = genpd_get_cpu(genpd, base_dev);
>
>         ret = genpd->attach_dev ? genpd->attach_dev(genpd, dev) : 0;
> -       if (ret)
> +       if (ret) {
> +               module_put(genpd->owner);
>                 goto out;
> +       }
>
>         genpd_lock(genpd);
>
> @@ -1579,6 +1586,8 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
>
>         genpd_free_dev_data(dev, gpd_data);
>
> +       module_put(genpd->owner);
> +
>         return 0;
>
>   out:
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 9ec78ee53652..777c1b30e5af 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -9,6 +9,7 @@
>  #define _LINUX_PM_DOMAIN_H
>
>  #include <linux/device.h>
> +#include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/pm.h>
>  #include <linux/err.h>
> @@ -93,6 +94,7 @@ struct opp_table;
>
>  struct generic_pm_domain {
>         struct device dev;
> +       struct module *owner;           /* Module owner of the PM domain */
>         struct dev_pm_domain domain;    /* PM domain operations */
>         struct list_head gpd_list_node; /* Node in the global PM domains list */
>         struct list_head master_links;  /* Links with PM domain as a master */
> --
> 2.11.0
>
