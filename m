Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD0F2CF00D
	for <lists+linux-pm@lfdr.de>; Fri,  4 Dec 2020 15:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgLDOvT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Dec 2020 09:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgLDOvT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Dec 2020 09:51:19 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4349C0613D1
        for <linux-pm@vger.kernel.org>; Fri,  4 Dec 2020 06:50:38 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id s9so6879322ljo.11
        for <linux-pm@vger.kernel.org>; Fri, 04 Dec 2020 06:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f0J6AHzHvgSJje9MUX/6z03gYFKNVcHvTlp7jdV7RVQ=;
        b=xciDesjBUC8YYttJVDx1kSCpAWa3xjUXjv7aWKRUDoGDXx26aOvZ9B+Ajn6cW5/cwv
         10ZrQqodCvHBWLamAa12ZJ8k/pLIJ4qBAXBK2OfZm/QdKL0SnDlTAFv8unzKgGLcSf+a
         0HsrAatw0mIOX0aRpZFF1EmuYvpYB45Q2ga6I3j4byHMqXKbbsKAM5On5mv0cZkSSSxw
         /kNVlKaW6ueD6K83QPVXgs9dWr97uCyhhasxYBQRvHuFcCUN6SZojxvvsHBfFZGeT0G0
         v2TMqqQs66vzdEGqr9Ta67KhdNL5wOJu6G1VoHfwSTCZ2gds4fEIknj32sK+JoT508zN
         T08g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f0J6AHzHvgSJje9MUX/6z03gYFKNVcHvTlp7jdV7RVQ=;
        b=hNQdITUP6CM9Nkd5DDsEBlH2LEM21Y7p9BLZLGTq9CByWUYJemKPkvxYSdZShnCQer
         i6vN4f/edSg5viwtEItm8PCzhKevwkYHIJqGgMj+NKKbr0QDD5fhDSJuFegI+hP7Jl1v
         HtNiCKaAurcksIluAkGfpQ+/bEPzvVVFmTZR1h0f5Gr6UAU9rgL+IQg6RLqN4AWBZKA5
         y6oBGj77VGQ48xCogwZUhq/adM7B6FS0zTZSP4/IbnHFm/VOUnKqGRsnyzCnrcjDYv53
         QrKgfEvMRJgpfiZMFrZXYBEBDekB4uCakrbEy+8s3Mh4bdcqeeKp5QUD8pkA2aFqGnIF
         Me5g==
X-Gm-Message-State: AOAM532760YiWX25jrjhIN48r6+yrb6aFfc9/Kq0Praf6YWCszXMSVVD
        Q/NL4kW8J8/sjd5kIk+I7wI9all35JU9Iw1Sw2J1eQ==
X-Google-Smtp-Source: ABdhPJx6XPrRvj0pg7o+a0ohJVaHzx1sSMyxpdhcBozRts9/1fZBNwCirrC+vp64hdL/9EsuoumPJcBsRtbGZsKidD8=
X-Received: by 2002:a2e:86d2:: with SMTP id n18mr3411588ljj.26.1607093437335;
 Fri, 04 Dec 2020 06:50:37 -0800 (PST)
MIME-Version: 1.0
References: <20201203233546.3482813-1-tstrudel@google.com>
In-Reply-To: <20201203233546.3482813-1-tstrudel@google.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 4 Dec 2020 15:49:59 +0100
Message-ID: <CAPDyKFoH+_7QJepcPwth_EcBKuj1iU7y7i5semd1QZDsVwT0ww@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: create debugfs nodes when adding power domains
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

On Fri, 4 Dec 2020 at 00:35, Thierry Strudel <tstrudel@google.com> wrote:
>
> debugfs nodes were created in genpd_debug_init alled in late_initcall
> preventing power domains registered though loadable modules to have
> a debugfs entry.
>
> Create/remove debugfs nodes when the power domain is added/removed
> to/from the internal gpd_list.
>
> Signed-off-by: Thierry Strudel <tstrudel@google.com>
> ---
>  drivers/base/power/domain.c | 61 ++++++++++++++++++++++++-------------
>  1 file changed, 39 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 743268996336..3f168ec93762 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1880,6 +1880,8 @@ static void genpd_lock_init(struct generic_pm_domain *genpd)
>         }
>  }
>
> +static void genpd_debug_add(struct generic_pm_domain *genpd);
> +
>  /**
>   * pm_genpd_init - Initialize a generic I/O PM domain object.
>   * @genpd: PM domain object to initialize.
> @@ -1954,12 +1956,15 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>
>         mutex_lock(&gpd_list_lock);
>         list_add(&genpd->gpd_list_node, &gpd_list);
> +       genpd_debug_add(genpd);
>         mutex_unlock(&gpd_list_lock);
>
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(pm_genpd_init);
>
> +static void genpd_debug_remove(struct generic_pm_domain *genpd);
> +

Please avoid these forward declarations. I think it's better to move
the code around.

>  static int genpd_remove(struct generic_pm_domain *genpd)
>  {
>         struct gpd_link *l, *link;
> @@ -1987,6 +1992,7 @@ static int genpd_remove(struct generic_pm_domain *genpd)
>                 kfree(link);
>         }
>
> +       genpd_debug_remove(genpd);
>         list_del(&genpd->gpd_list_node);
>         genpd_unlock(genpd);
>         cancel_work_sync(&genpd->power_off_work);
> @@ -3177,36 +3183,44 @@ DEFINE_SHOW_ATTRIBUTE(total_idle_time);
>  DEFINE_SHOW_ATTRIBUTE(devices);
>  DEFINE_SHOW_ATTRIBUTE(perf_state);
>
> -static int __init genpd_debug_init(void)
> +static void genpd_debug_add(struct generic_pm_domain *genpd)
>  {
>         struct dentry *d;
> -       struct generic_pm_domain *genpd;
>
> +       d = debugfs_create_dir(genpd->name, genpd_debugfs_dir);

What happens if "genpd_debugfs_dir" is NULL, which will be the case
until the late_initcall(genpd_debug_init) has been executed!?

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

[...]

Kind regards
Uffe
