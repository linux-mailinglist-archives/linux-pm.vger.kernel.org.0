Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61784A1E38
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2019 17:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfH2PBz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Aug 2019 11:01:55 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:41581 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfH2PBy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Aug 2019 11:01:54 -0400
Received: by mail-ua1-f68.google.com with SMTP id x2so1250027uar.8
        for <linux-pm@vger.kernel.org>; Thu, 29 Aug 2019 08:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NhdYEGuBZ86MZbgbGE/dU1jehprguGgfst5LEcPzq1E=;
        b=k7qn4o8XRnCZKdy2eds9KzK+7DxiOfdnysWoofn67U6+ZwTG5CLIEKwFP0K2EmKGHE
         nOsavr3pXeV8GWqYxuQrHRoT/Rdt1LwUw1WQIG2am00YkKRAUsULLmRv+hLiOkfTR2yJ
         KsLagmm+cUP1b/g2RVJu+gf+h9UidaIu2nprXTXmzcBDUj45N1T8WfY2NVD0kLLbcatO
         e/a7a4YSORcoGXB3QxIi7WXgOkTzt2gIjVcBWMF6t1arie4jr5uKpqgqdM+2j6YPUBEM
         yTjqAMbrvFNvHjm2puTlitr0ZOBGQ2zh6eaJw58fuFEMHhrSr2hgEW/rBSaaYSAEpuNj
         Go3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NhdYEGuBZ86MZbgbGE/dU1jehprguGgfst5LEcPzq1E=;
        b=lfurHxDs+2XW68awNp9f9C2fQms+lzm7X8hmRVFmi1rL1d3LuKyNmpGihD5tA37VY5
         f3PJuBCvL0nBdivxd67rn1zrcAXW2TD57uVqmZi5PaW3AU+3pl0+KBEyFyx/Dfs9Zne6
         2uecopTXLhElTI3s3ezBZZWRRIkfMvXJps0SUp8WWdjufNIJqQBU8+O2+gbsiQrlHXmx
         u6uYpMeWUt62Lq7LR6fFMP6hrhk/Z5CQzKbDK52VPSQVN6g4PUm7JTbe+A1T5lVX1U/f
         bvNi9vzlVpryaNzuMqXRBrp59Lhu0MMT9ZWPYlUK/pBuBc+Io2dlkDqid0IZ8SdZDOV3
         s4/A==
X-Gm-Message-State: APjAAAWFk0vYh8NyM6TVLfaTLffE0Thqxt9DAO97OIXopXKgb0p/DKJk
        5rCvfWySI0EsM4jPblnEhIeG82FNc5yqfpROfgFbOg==
X-Google-Smtp-Source: APXvYqxX36/V1p1AnOLcNBaPvF+8VSLAe25idk7689J03ITjm6zTXAuxww8U5ctx3KXYHY+di9XDyCttpqmHxAUkcBg=
X-Received: by 2002:ab0:1562:: with SMTP id p31mr5086162uae.15.1567090913594;
 Thu, 29 Aug 2019 08:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190829144805.634-1-ulf.hansson@linaro.org>
In-Reply-To: <20190829144805.634-1-ulf.hansson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 29 Aug 2019 17:01:17 +0200
Message-ID: <CAPDyKFoh7k=BwExr5FPSYnd9bNOQcONW3Pdo_n-a5T8+Cm+PrA@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM / Domains: Simplify genpd_lookup_dev()
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 29 Aug 2019 at 16:48, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> genpd_lookup_dev(), is a bit unnecessary heavy, as it walks the gpd_list to
> try to find a valid PM domain corresponding to the device's attached genpd.
>
> Instead of walking the gpd_list, let's use the fact that a genpd always has
> the ->runtime_suspend() callback assigned to the genpd_runtime_suspend()
> function.
>
> While changing this, let's take the opportunity to also rename
> genpd_lookup_dev(), into dev_to_genpd_safe() to better reflect its purpose.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/domain.c | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index b063bc41b0a9..27592b73061d 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -149,29 +149,24 @@ static inline bool irq_safe_dev_in_no_sleep_domain(struct device *dev,
>         return ret;
>  }
>
> +static int genpd_runtime_suspend(struct device *dev);
> +
>  /*
>   * Get the generic PM domain for a particular struct device.
>   * This validates the struct device pointer, the PM domain pointer,
> - * and checks that the PM domain pointer is a real generic PM domain.
> + * and checks that the PM domain pointer is real generic PM domain.

Rafael, I thought I got rid of this line change. I can send a new
version - or if you manually just drop this line of change when
applying?

Kind regards
Uffe

>   * Any failure results in NULL being returned.
>   */
> -static struct generic_pm_domain *genpd_lookup_dev(struct device *dev)
> +static struct generic_pm_domain *dev_to_genpd_safe(struct device *dev)
>  {
> -       struct generic_pm_domain *genpd = NULL, *gpd;
> -
>         if (IS_ERR_OR_NULL(dev) || IS_ERR_OR_NULL(dev->pm_domain))
>                 return NULL;
>
> -       mutex_lock(&gpd_list_lock);
> -       list_for_each_entry(gpd, &gpd_list, gpd_list_node) {
> -               if (&gpd->domain == dev->pm_domain) {
> -                       genpd = gpd;
> -                       break;
> -               }
> -       }
> -       mutex_unlock(&gpd_list_lock);
> +       /* A genpd's always have its ->runtime_suspend() callback assigned. */
> +       if (dev->pm_domain->ops.runtime_suspend == genpd_runtime_suspend)
> +               return pd_to_genpd(dev->pm_domain);
>
> -       return genpd;
> +       return NULL;
>  }
>
>  /*
> @@ -1610,7 +1605,7 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
>   */
>  int pm_genpd_remove_device(struct device *dev)
>  {
> -       struct generic_pm_domain *genpd = genpd_lookup_dev(dev);
> +       struct generic_pm_domain *genpd = dev_to_genpd_safe(dev);
>
>         if (!genpd)
>                 return -EINVAL;
> --
> 2.17.1
>
