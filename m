Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF0F2D5467
	for <lists+linux-pm@lfdr.de>; Thu, 10 Dec 2020 08:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbgLJHSL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Dec 2020 02:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387764AbgLJHSI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Dec 2020 02:18:08 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE08C0613CF
        for <linux-pm@vger.kernel.org>; Wed,  9 Dec 2020 23:17:28 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id b23so2333501vsp.9
        for <linux-pm@vger.kernel.org>; Wed, 09 Dec 2020 23:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TYrGtl0zgmQWmL60av2RB17570ZXsOx0vCKKTw9Dsrw=;
        b=zS705Pp/561tKtN9X1ufVrLj6OTOLr+IrhRi1kauURiKdS8ar8F/n9hq5FOHiLTBcq
         dyiIEkNbfR9W91qNnbhSdqVTfsaoR3B5dZyvFFSSghptZfEJfNcRjqJgDrPX2GgBGfQE
         V1dzyoRvPBCF+wP8jLRZsjpDH0T7Se02L/y9LpIRoImC+pw5qFrBQk5c/gfWsUnZqHMM
         Qrj7g0B8/OYcYzNWbstJ98PL/GGZa2YzH8WxFyEnwye3NUaXzcv3JZzGOKKX3WYKnZiP
         lNKkLfQ5YMFRCz+9UTj8arPO5TuVC5uL8HcZkvAwiu5dpWm1eZWh9yYbskhBmwJpXQmr
         0zNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TYrGtl0zgmQWmL60av2RB17570ZXsOx0vCKKTw9Dsrw=;
        b=E85VoOdUl4g6vU7esvMV8TtXjOp3bAEc+c5HhSyITcFhmwbiEdteYv78AzXD4PiygE
         Uce1TPHd33hWva6VcBN9xNyvmWbatrF8sX0ZRLgJOBgOWXJJm+H1OaNUQjaohO0dQqqF
         w34pwxTuxIxN9zvdDNnb24kdkMT5cz/nyJrPSayDtGJkT4eZHsnSqZV7xew5rp+WiPkn
         ePLK8Lf+zwrPia8MUcsAtot9PkcXCP2a2PXb9umFwEFFlW62aCL4ySaI1S1nUfYDTapS
         2jXmjVrX+5sp1/q0DRUcIVCMqc0d7tY3FLsfHB/BLsI9Uxxu8u3EIPUF0FQ9ZW/LULmD
         jRpA==
X-Gm-Message-State: AOAM530D8RgUbYx2aV+akF8EQSgnnWjbJ/0E+cUS7rgRW+QhLgxBbLBE
        LSx8te00W2tX+143OnguOR8wf1OQmeHgoESckJV2xA==
X-Google-Smtp-Source: ABdhPJwOEdMRhwz5a3/zyt5CWllJHt+nn5QXungtE2bUs7sUdRJO3pFIIlvw5kImbjdZ4vxf1EggnBGy4y4PgpnTUBQ=
X-Received: by 2002:a67:8c44:: with SMTP id o65mr6184829vsd.55.1607584647349;
 Wed, 09 Dec 2020 23:17:27 -0800 (PST)
MIME-Version: 1.0
References: <20201208191955.2466057-1-tstrudel@google.com>
In-Reply-To: <20201208191955.2466057-1-tstrudel@google.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 10 Dec 2020 08:16:49 +0100
Message-ID: <CAPDyKFruq+TCSOEOFTZF+Q00SiqggRHqc1NMugDbpJ-71r6K3g@mail.gmail.com>
Subject: Re: [PATCH v4] PM: domains: create debugfs nodes when adding power domains
To:     Thierry Strudel <tstrudel@google.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 8 Dec 2020 at 20:20, Thierry Strudel <tstrudel@google.com> wrote:
>
> debugfs nodes were created in genpd_debug_init alled in late_initcall
> preventing power domains registered though loadable modules to have
> a debugfs entry.
>
> Create/remove debugfs nodes when the power domain is added/removed
> to/from the internal gpd_list.
>
> Signed-off-by: Thierry Strudel <tstrudel@google.com>
> Change-Id: I8a2e0616746afe2a6bbd9c24bc3a0eaa84725a75

Thierry, thanks for fixing this!

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
> v2: fix forward declaration and genpd_debugfs_dir being NULL - Ulf
> v3: remove extra trailing char added by mistake in v2 - kernel test robot
> v4: cleanup includes and regroup CONFIG_DEBUG_FS CPP blocks - Greg
>  drivers/base/power/domain.c | 73 +++++++++++++++++++++++--------------
>  1 file changed, 45 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 2cb5e04cf86c..49c87607cba7 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -21,6 +21,7 @@
>  #include <linux/suspend.h>
>  #include <linux/export.h>
>  #include <linux/cpu.h>
> +#include <linux/debugfs.h>
>
>  #include "power.h"
>
> @@ -210,6 +211,18 @@ static void genpd_sd_counter_inc(struct generic_pm_domain *genpd)
>  }
>
>  #ifdef CONFIG_DEBUG_FS
> +static struct dentry *genpd_debugfs_dir;
> +
> +static void genpd_debug_add(struct generic_pm_domain *genpd);
> +
> +static void genpd_debug_remove(struct generic_pm_domain *genpd)
> +{
> +       struct dentry *d;
> +
> +       d = debugfs_lookup(genpd->name, genpd_debugfs_dir);
> +       debugfs_remove(d);
> +}
> +
>  static void genpd_update_accounting(struct generic_pm_domain *genpd)
>  {
>         ktime_t delta, now;
> @@ -234,6 +247,8 @@ static void genpd_update_accounting(struct generic_pm_domain *genpd)
>         genpd->accounting_time = now;
>  }
>  #else
> +static inline void genpd_debug_add(struct generic_pm_domain *genpd) {}
> +static inline void genpd_debug_remove(struct generic_pm_domain *genpd) {}
>  static inline void genpd_update_accounting(struct generic_pm_domain *genpd) {}
>  #endif
>
> @@ -1827,6 +1842,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>
>         mutex_lock(&gpd_list_lock);
>         list_add(&genpd->gpd_list_node, &gpd_list);
> +       genpd_debug_add(genpd);
>         mutex_unlock(&gpd_list_lock);
>
>         return 0;
> @@ -1860,6 +1876,7 @@ static int genpd_remove(struct generic_pm_domain *genpd)
>                 kfree(link);
>         }
>
> +       genpd_debug_remove(genpd);
>         list_del(&genpd->gpd_list_node);
>         genpd_unlock(genpd);
>         cancel_work_sync(&genpd->power_off_work);
> @@ -2764,14 +2781,6 @@ core_initcall(genpd_bus_init);
>  /***        debugfs support        ***/
>
>  #ifdef CONFIG_DEBUG_FS
> -#include <linux/pm.h>
> -#include <linux/device.h>
> -#include <linux/debugfs.h>
> -#include <linux/seq_file.h>
> -#include <linux/init.h>
> -#include <linux/kobject.h>
> -static struct dentry *genpd_debugfs_dir;
> -
>  /*
>   * TODO: This function is a slightly modified version of rtpm_status_show
>   * from sysfs.c, so generalize it.
> @@ -3047,9 +3056,34 @@ DEFINE_SHOW_ATTRIBUTE(total_idle_time);
>  DEFINE_SHOW_ATTRIBUTE(devices);
>  DEFINE_SHOW_ATTRIBUTE(perf_state);
>
> -static int __init genpd_debug_init(void)
> +static void genpd_debug_add(struct generic_pm_domain *genpd)
>  {
>         struct dentry *d;
> +
> +       if (!genpd_debugfs_dir)
> +               return;
> +
> +       d = debugfs_create_dir(genpd->name, genpd_debugfs_dir);
> +
> +       debugfs_create_file("current_state", 0444,
> +                           d, genpd, &status_fops);
> +       debugfs_create_file("sub_domains", 0444,
> +                           d, genpd, &sub_domains_fops);
> +       debugfs_create_file("idle_states", 0444,
> +                           d, genpd, &idle_states_fops);
> +       debugfs_create_file("active_time", 0444,
> +                           d, genpd, &active_time_fops);
> +       debugfs_create_file("total_idle_time", 0444,
> +                           d, genpd, &total_idle_time_fops);
> +       debugfs_create_file("devices", 0444,
> +                           d, genpd, &devices_fops);
> +       if (genpd->set_performance_state)
> +               debugfs_create_file("perf_state", 0444,
> +                                   d, genpd, &perf_state_fops);
> +}
> +
> +static int __init genpd_debug_init(void)
> +{
>         struct generic_pm_domain *genpd;
>
>         genpd_debugfs_dir = debugfs_create_dir("pm_genpd", NULL);
> @@ -3057,25 +3091,8 @@ static int __init genpd_debug_init(void)
>         debugfs_create_file("pm_genpd_summary", S_IRUGO, genpd_debugfs_dir,
>                             NULL, &summary_fops);
>
> -       list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
> -               d = debugfs_create_dir(genpd->name, genpd_debugfs_dir);
> -
> -               debugfs_create_file("current_state", 0444,
> -                               d, genpd, &status_fops);
> -               debugfs_create_file("sub_domains", 0444,
> -                               d, genpd, &sub_domains_fops);
> -               debugfs_create_file("idle_states", 0444,
> -                               d, genpd, &idle_states_fops);
> -               debugfs_create_file("active_time", 0444,
> -                               d, genpd, &active_time_fops);
> -               debugfs_create_file("total_idle_time", 0444,
> -                               d, genpd, &total_idle_time_fops);
> -               debugfs_create_file("devices", 0444,
> -                               d, genpd, &devices_fops);
> -               if (genpd->set_performance_state)
> -                       debugfs_create_file("perf_state", 0444,
> -                                           d, genpd, &perf_state_fops);
> -       }
> +       list_for_each_entry(genpd, &gpd_list, gpd_list_node)
> +               genpd_debug_add(genpd);
>
>         return 0;
>  }
> --
> 2.29.2.576.ga3fc446d84-goog
>
