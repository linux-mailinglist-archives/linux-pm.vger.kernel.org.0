Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0471221A044
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jul 2020 14:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgGIMxZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jul 2020 08:53:25 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37833 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbgGIMxY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2020 08:53:24 -0400
Received: by mail-ot1-f66.google.com with SMTP id w17so1606935otl.4
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2020 05:53:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tybaUG3dV2gGq7iHm8ZuUmuJwb+ucFJsNwmDI5FbWTU=;
        b=CwqKTpBfNdlFxiRdeIK3CCgmZQ0VDvPHa1d7OBa7nefLzqFpMsOpYSrE6Y/gnWtRfV
         +NMUbqdHdRMepIJMAY4K2eHoHSxTLm3exsD2nSWHIlfmOXpK7NBwwq0wn0z3gocpgLjs
         +iUvQQGifyp1pvn2YTG9O4LE99dIJpZ6zw6tjUrgzRf+e1RiVBpDsT+y3pxVAg14Qwjm
         M4d3WThM81m8i/t0uJ8+CnDQTbv/jzHPwlIUA1/DvAjdmf4nYmEdU8Puc4d67ILRA1n8
         EV3Qm+vWdi5lf+EgsOW51XDsfYYJLfK+9zEifhgDNzxtTcMkz5rmp59vOIr2yxs/xaeK
         tRrw==
X-Gm-Message-State: AOAM531wylN5NXX40gdO78+vPckjPJ4IytFBgAvO70g9vaU1MMpYHkCI
        /05sD9DKd9dkSgzXqxpt4tBuWPYEc9PcXgxbRWQ=
X-Google-Smtp-Source: ABdhPJxySvxjYla/H8HLZi8jcIPj+jzq+emyfV4gi5Fm4F8Bssj7O9WP+gqsb7BTQUsPYDq/LKkREIQdE6mDF925pQ8=
X-Received: by 2002:a05:6830:30ba:: with SMTP id g26mr31570876ots.118.1594299203219;
 Thu, 09 Jul 2020 05:53:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200610193156.20363-1-gustav.wiklander@axis.com>
In-Reply-To: <20200610193156.20363-1-gustav.wiklander@axis.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Jul 2020 14:53:12 +0200
Message-ID: <CAJZ5v0g6CUbsGzK2oe+zFNM6Y8PCBSf4a282NEwnHVMKFW5YBA@mail.gmail.com>
Subject: Re: [PATCHv2] PM / Domains: Add module ref count for each consumer
To:     Gustav Wiklander <gustav.wiklander@axis.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@axis.com, Gustav Wiklander <gustavwi@axis.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 10, 2020 at 9:32 PM Gustav Wiklander
<gustav.wiklander@axis.com> wrote:
>
> From: Gustav Wiklander <gustavwi@axis.com>
>
> Currently a pm_domain can be unloaded without regard for consumers.

This is unclear.

What exactly do you mean by "pm_domain" here?  I think that this is a
driver providing the PM domain callbacks, right?  If so, that needs to
be stated directly.

> This patch adds a module dependecy for every registered consumer.

What does this mean?

> Now a power domain driver can only be unloaded if no consumers are
> registered.

I guess what you mean is that a module providing PM domain callbacks
cannot be unloaded as long as there are any devices in it, right?  The
assumption being that this is the module that initializes the domain.

What about subdomains?

> Signed-off-by: Gustav Wiklander <gustavwi@axis.com>

Ulf, any comments?

> ---
> Automated setting genpd->owner when calling pm_genpd_init.
> Similar to how usb_register_driver does it.
>
>  drivers/base/power/domain.c | 22 +++++++++++++++++-----
>  include/linux/pm_domain.h   | 10 ++++++++--
>  2 files changed, 25 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 0a01df608849..70c8b59bfed9 100644
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
> @@ -1755,15 +1764,17 @@ static void genpd_lock_init(struct generic_pm_domain *genpd)
>  }
>
>  /**
> - * pm_genpd_init - Initialize a generic I/O PM domain object.
> + * __pm_genpd_init - Initialize a generic I/O PM domain object.
>   * @genpd: PM domain object to initialize.
>   * @gov: PM domain governor to associate with the domain (may be NULL).
>   * @is_off: Initial value of the domain's power_is_off field.
> + * @owner: module owner of this power domain object.
>   *
>   * Returns 0 on successful initialization, else a negative error code.
>   */
> -int pm_genpd_init(struct generic_pm_domain *genpd,
> -                 struct dev_power_governor *gov, bool is_off)
> +int __pm_genpd_init(struct generic_pm_domain *genpd,
> +                 struct dev_power_governor *gov, bool is_off,
> +                 struct module *owner)
>  {
>         int ret;
>
> @@ -1777,6 +1788,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>         genpd->gov = gov;
>         INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
>         atomic_set(&genpd->sd_count, 0);
> +       genpd->owner = owner;
>         genpd->status = is_off ? GPD_STATE_POWER_OFF : GPD_STATE_ACTIVE;
>         genpd->device_count = 0;
>         genpd->max_off_time_ns = -1;
> @@ -1831,7 +1843,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>
>         return 0;
>  }
> -EXPORT_SYMBOL_GPL(pm_genpd_init);
> +EXPORT_SYMBOL_GPL(__pm_genpd_init);
>
>  static int genpd_remove(struct generic_pm_domain *genpd)
>  {
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 9ec78ee53652..21a3183e00bc 100644
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
> @@ -200,8 +202,12 @@ int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
>                            struct generic_pm_domain *subdomain);
>  int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
>                               struct generic_pm_domain *subdomain);
> -int pm_genpd_init(struct generic_pm_domain *genpd,
> -                 struct dev_power_governor *gov, bool is_off);
> +int __pm_genpd_init(struct generic_pm_domain *genpd,
> +                   struct dev_power_governor *gov, bool is_off,
> +                   struct module *module);
> +#define pm_genpd_init(genpd, gov, is_off) \
> +       __pm_genpd_init(genpd, gov, is_off, THIS_MODULE)

I'd prefer this to be a static inline function.

> +
>  int pm_genpd_remove(struct generic_pm_domain *genpd);
>  int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
>
> --

Thanks!
