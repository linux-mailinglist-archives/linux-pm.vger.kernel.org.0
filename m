Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B917221B31C
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 12:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgGJKTf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 06:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgGJKTf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2020 06:19:35 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E268C08C5CE
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2020 03:19:35 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id b77so2692193vsd.8
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2020 03:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kvljGXPC+E2fMTT3gzMOa+yWbquvAF9kobhlqHImqdw=;
        b=aKJgvhdEPt+wMtzb+0pCNFJdYY2qVqS2ARHTp52WGvLkf8ZDetqqKC6a7rcUF2HOCE
         iyaa33adVfAbrwdGZ7e7wckKuR06lH+wO+cbE6Wj+ojIkTj9iJv3tzqUjsMSdLyc9QxM
         XHhoTJdKZUXrG58gDve5kpTBH3WGdVpqvj96cw2+3sTZfnm4Q/pgGEckMjrC502ShDby
         BPAbulqTe2LLtl5uK5L5oNl9+6o4UufdIGG5+dtk/eiwfZZX9fqALTlQuNaAsKy45SOL
         JM72RHHof86O+CL69fYE+K6F6ZtR6RyH4bSDNFSGr34/PnxUyLF2pMGqSOP5XTr4VVWF
         VW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kvljGXPC+E2fMTT3gzMOa+yWbquvAF9kobhlqHImqdw=;
        b=L4SooXmkXRUCxXXu4kta1ZHIgHw/FCq9V/l255J0Aq8tp+d1FNrZiNhtJmcx5/HUwj
         RyvB6ieykFYkn6nQs0eKx/v60gWkm3cOQp1CMKMftX3FNFwVCGH+asRepSZ+w2U/u1ny
         ZOi0HWw/X009oYNDTcJV/WLjftj5YSwMgqZhM+4v6uejuydUyVH/IZSWLKycF4pHoiOM
         c0lBrhrvi9JomfqRdnQQ02Es1se6B6Jay6X7EKGcULmTd3Q1UQ6nlE8Xg+DzieJYoqB/
         7A5iXO+HJyymG8iqCx3PDWVImAkJF7nPb7+Mr4GPFJQnc1nQNUpeQU3X7N7vg5dtRsCt
         bY4g==
X-Gm-Message-State: AOAM531OyAHIqxKrWPirEU8cWPOiUpVWLYEcgJ+bk85MuRLevyQ+mNRE
        UgvQEC5yf/XCyJXKQMss9iXL+kidGuTqLu7znieaHA==
X-Google-Smtp-Source: ABdhPJy1o6oaKIQIjHCKfEyuWcfvchr3i2fgnXRdUmttLk7eq72yO8cFBv/eA340Zo0Vm999IqdS634MvUGxSs8eB0Y=
X-Received: by 2002:a67:f888:: with SMTP id h8mr30740789vso.165.1594376374286;
 Fri, 10 Jul 2020 03:19:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200610193156.20363-1-gustav.wiklander@axis.com>
In-Reply-To: <20200610193156.20363-1-gustav.wiklander@axis.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 10 Jul 2020 12:18:57 +0200
Message-ID: <CAPDyKFr_-ayyxAuzj92TwQmbcAVDrR6GSEQfD4HhWuUnseB0GA@mail.gmail.com>
Subject: Re: [PATCHv2] PM / Domains: Add module ref count for each consumer
To:     Gustav Wiklander <gustav.wiklander@axis.com>
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

On Wed, 10 Jun 2020 at 21:32, Gustav Wiklander
<gustav.wiklander@axis.com> wrote:
>
> From: Gustav Wiklander <gustavwi@axis.com>
>
> Currently a pm_domain can be unloaded without regard for consumers.
> This patch adds a module dependecy for every registered consumer.
> Now a power domain driver can only be unloaded if no consumers are
> registered.

According to the comments from Rafael, yes, this needs some further
clarifications.

Moreover, we also need to deal with module reference counters when
adding/removing subdomains. Also pointed out by Rafael.

>
> Signed-off-by: Gustav Wiklander <gustavwi@axis.com>
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

Please drop this new interface altogether. Instead we can just let the
caller of pm_genpd_init() to assign genpd->owner, rather than passing
it as a parameter.

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
> +
>  int pm_genpd_remove(struct generic_pm_domain *genpd);
>  int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
>
> --
> 2.11.0
>

Kind regards
Uffe
