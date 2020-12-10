Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18AA2D658B
	for <lists+linux-pm@lfdr.de>; Thu, 10 Dec 2020 19:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393183AbgLJSwO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Dec 2020 13:52:14 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40079 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389034AbgLJSwE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Dec 2020 13:52:04 -0500
Received: by mail-ot1-f67.google.com with SMTP id j12so5877418ota.7;
        Thu, 10 Dec 2020 10:51:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F0H1TzAjvIzYsJAy+fTpFnPknlK7exRsj/j22fyx0oc=;
        b=mc1lrAbPagqUvNOVIP8HkFcGDJcREwIPPsYvi4OkH40O98ygHYJyMLk5IH7YKWGX6v
         W1A2lv22fyNkux1bwUusIATCAvY5dKWrRIXSOTUrJDvmOtRBklC67uqITsaBOTNu/Jme
         yo0Qo9XvKzYlVr1S0XkwgI//VMwYot8RQJucOovwIFbwnC9x+iQH0QnBzVpV8WnOGD42
         ljrxoTVHtbYvRmgyVXMvOFgA2IxmyYS6CCdgw2rPq3Ggiy7GgWnmT/j1tQ2CSCjpv/wa
         NgIVIHwPLSvN8hWT7bqd2TFiixLbN9k4z178Kwaeh9DH8eDBoQyX3bQ1kZdsP4P1sFOr
         Q8Jg==
X-Gm-Message-State: AOAM531/itFNzxyA/HaMTwZL0Wm5ApTY6hSBZsbpXjCiUZNiVyuj330O
        CkiATXKEXdBgfRtFFykt6HzI/kAqOdw1s7nPDXg=
X-Google-Smtp-Source: ABdhPJy363h3FnSgXJqtDTmFqIk78iXCR7xBOrDlBH1fM9Mvj47Vc889HC7dFY+6k3yGsmlASqWja0anJEwpkIVKYjs=
X-Received: by 2002:a9d:67da:: with SMTP id c26mr6971668otn.321.1607626282604;
 Thu, 10 Dec 2020 10:51:22 -0800 (PST)
MIME-Version: 1.0
References: <20201208191955.2466057-1-tstrudel@google.com> <CAPDyKFruq+TCSOEOFTZF+Q00SiqggRHqc1NMugDbpJ-71r6K3g@mail.gmail.com>
In-Reply-To: <CAPDyKFruq+TCSOEOFTZF+Q00SiqggRHqc1NMugDbpJ-71r6K3g@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Dec 2020 19:51:11 +0100
Message-ID: <CAJZ5v0jPJPY3VXqc-wFzbKHiRR_DiEr2asG_ObAh_bT-3mwuDA@mail.gmail.com>
Subject: Re: [PATCH v4] PM: domains: create debugfs nodes when adding power domains
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Strudel <tstrudel@google.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 10, 2020 at 8:18 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 8 Dec 2020 at 20:20, Thierry Strudel <tstrudel@google.com> wrote:
> >
> > debugfs nodes were created in genpd_debug_init alled in late_initcall
> > preventing power domains registered though loadable modules to have
> > a debugfs entry.
> >
> > Create/remove debugfs nodes when the power domain is added/removed
> > to/from the internal gpd_list.
> >
> > Signed-off-by: Thierry Strudel <tstrudel@google.com>
> > Change-Id: I8a2e0616746afe2a6bbd9c24bc3a0eaa84725a75
>
> Thierry, thanks for fixing this!
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Applied now (as 5.11-rc material), thanks!

> > ---
> > v2: fix forward declaration and genpd_debugfs_dir being NULL - Ulf
> > v3: remove extra trailing char added by mistake in v2 - kernel test robot
> > v4: cleanup includes and regroup CONFIG_DEBUG_FS CPP blocks - Greg
> >  drivers/base/power/domain.c | 73 +++++++++++++++++++++++--------------
> >  1 file changed, 45 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index 2cb5e04cf86c..49c87607cba7 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/suspend.h>
> >  #include <linux/export.h>
> >  #include <linux/cpu.h>
> > +#include <linux/debugfs.h>
> >
> >  #include "power.h"
> >
> > @@ -210,6 +211,18 @@ static void genpd_sd_counter_inc(struct generic_pm_domain *genpd)
> >  }
> >
> >  #ifdef CONFIG_DEBUG_FS
> > +static struct dentry *genpd_debugfs_dir;
> > +
> > +static void genpd_debug_add(struct generic_pm_domain *genpd);
> > +
> > +static void genpd_debug_remove(struct generic_pm_domain *genpd)
> > +{
> > +       struct dentry *d;
> > +
> > +       d = debugfs_lookup(genpd->name, genpd_debugfs_dir);
> > +       debugfs_remove(d);
> > +}
> > +
> >  static void genpd_update_accounting(struct generic_pm_domain *genpd)
> >  {
> >         ktime_t delta, now;
> > @@ -234,6 +247,8 @@ static void genpd_update_accounting(struct generic_pm_domain *genpd)
> >         genpd->accounting_time = now;
> >  }
> >  #else
> > +static inline void genpd_debug_add(struct generic_pm_domain *genpd) {}
> > +static inline void genpd_debug_remove(struct generic_pm_domain *genpd) {}
> >  static inline void genpd_update_accounting(struct generic_pm_domain *genpd) {}
> >  #endif
> >
> > @@ -1827,6 +1842,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
> >
> >         mutex_lock(&gpd_list_lock);
> >         list_add(&genpd->gpd_list_node, &gpd_list);
> > +       genpd_debug_add(genpd);
> >         mutex_unlock(&gpd_list_lock);
> >
> >         return 0;
> > @@ -1860,6 +1876,7 @@ static int genpd_remove(struct generic_pm_domain *genpd)
> >                 kfree(link);
> >         }
> >
> > +       genpd_debug_remove(genpd);
> >         list_del(&genpd->gpd_list_node);
> >         genpd_unlock(genpd);
> >         cancel_work_sync(&genpd->power_off_work);
> > @@ -2764,14 +2781,6 @@ core_initcall(genpd_bus_init);
> >  /***        debugfs support        ***/
> >
> >  #ifdef CONFIG_DEBUG_FS
> > -#include <linux/pm.h>
> > -#include <linux/device.h>
> > -#include <linux/debugfs.h>
> > -#include <linux/seq_file.h>
> > -#include <linux/init.h>
> > -#include <linux/kobject.h>
> > -static struct dentry *genpd_debugfs_dir;
> > -
> >  /*
> >   * TODO: This function is a slightly modified version of rtpm_status_show
> >   * from sysfs.c, so generalize it.
> > @@ -3047,9 +3056,34 @@ DEFINE_SHOW_ATTRIBUTE(total_idle_time);
> >  DEFINE_SHOW_ATTRIBUTE(devices);
> >  DEFINE_SHOW_ATTRIBUTE(perf_state);
> >
> > -static int __init genpd_debug_init(void)
> > +static void genpd_debug_add(struct generic_pm_domain *genpd)
> >  {
> >         struct dentry *d;
> > +
> > +       if (!genpd_debugfs_dir)
> > +               return;
> > +
> > +       d = debugfs_create_dir(genpd->name, genpd_debugfs_dir);
> > +
> > +       debugfs_create_file("current_state", 0444,
> > +                           d, genpd, &status_fops);
> > +       debugfs_create_file("sub_domains", 0444,
> > +                           d, genpd, &sub_domains_fops);
> > +       debugfs_create_file("idle_states", 0444,
> > +                           d, genpd, &idle_states_fops);
> > +       debugfs_create_file("active_time", 0444,
> > +                           d, genpd, &active_time_fops);
> > +       debugfs_create_file("total_idle_time", 0444,
> > +                           d, genpd, &total_idle_time_fops);
> > +       debugfs_create_file("devices", 0444,
> > +                           d, genpd, &devices_fops);
> > +       if (genpd->set_performance_state)
> > +               debugfs_create_file("perf_state", 0444,
> > +                                   d, genpd, &perf_state_fops);
> > +}
> > +
> > +static int __init genpd_debug_init(void)
> > +{
> >         struct generic_pm_domain *genpd;
> >
> >         genpd_debugfs_dir = debugfs_create_dir("pm_genpd", NULL);
> > @@ -3057,25 +3091,8 @@ static int __init genpd_debug_init(void)
> >         debugfs_create_file("pm_genpd_summary", S_IRUGO, genpd_debugfs_dir,
> >                             NULL, &summary_fops);
> >
> > -       list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
> > -               d = debugfs_create_dir(genpd->name, genpd_debugfs_dir);
> > -
> > -               debugfs_create_file("current_state", 0444,
> > -                               d, genpd, &status_fops);
> > -               debugfs_create_file("sub_domains", 0444,
> > -                               d, genpd, &sub_domains_fops);
> > -               debugfs_create_file("idle_states", 0444,
> > -                               d, genpd, &idle_states_fops);
> > -               debugfs_create_file("active_time", 0444,
> > -                               d, genpd, &active_time_fops);
> > -               debugfs_create_file("total_idle_time", 0444,
> > -                               d, genpd, &total_idle_time_fops);
> > -               debugfs_create_file("devices", 0444,
> > -                               d, genpd, &devices_fops);
> > -               if (genpd->set_performance_state)
> > -                       debugfs_create_file("perf_state", 0444,
> > -                                           d, genpd, &perf_state_fops);
> > -       }
> > +       list_for_each_entry(genpd, &gpd_list, gpd_list_node)
> > +               genpd_debug_add(genpd);
> >
> >         return 0;
> >  }
> > --
> > 2.29.2.576.ga3fc446d84-goog
> >
