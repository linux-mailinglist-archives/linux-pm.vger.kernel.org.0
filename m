Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E76341E44
	for <lists+linux-pm@lfdr.de>; Fri, 19 Mar 2021 14:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhCSNaM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Mar 2021 09:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbhCSN34 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Mar 2021 09:29:56 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C75EC06174A
        for <linux-pm@vger.kernel.org>; Fri, 19 Mar 2021 06:29:56 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id a198so10007153lfd.7
        for <linux-pm@vger.kernel.org>; Fri, 19 Mar 2021 06:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ay8+re70p7qO5xYmhyLavBuuNKFjqNeoKnwbxsNb+ic=;
        b=JeW4Si1BWH2Sw0keq/AT/fzPU9Hsbiqbmwd2rMT2/NjpS5g0NWiRRAaqEKAlVmJW8k
         095vDkFLB3lVJgkJdGnXffEtDWd5SnCw1+7YwpExw1JCbATZG6cl+HJFxqUNpA0sA+mX
         jvIPSIOddklr8XaHZBDARb9cZY7rB3n8Bgd2GcLJ8nQT2twVcvLHMwA0O4PZWjAV67zk
         tV1OUn9MolLY8XlUixE7uqSOxAmPTJsDZHAFfdSIC9Slu0KxiUHorUC7bmIYrtqzn4uT
         1H291uMmFXmf2ULnKvM+qV7AI5FI4w0Eto7ccVNNuwByV5kfYiltbq/29HG4lfmgiIjg
         /P9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ay8+re70p7qO5xYmhyLavBuuNKFjqNeoKnwbxsNb+ic=;
        b=n9gC9IL49Zj7qW/SljidGwAnCh7EofmBnJwRzCFMZ9K+GoBYKX8o57CoNs5vgqO8KB
         66QXzx58fvUAHLAQZ/PETAOPN1MnBmK1UGAODL9HKqOK0r7UOIo33ZvicUyCaho4r4t2
         WvzZP79xAMT1awY1YWm9bD0UCretmSw827aR0pcSJmb7Gce157uc8R04XqZevup7y4cb
         H9UVYBwaVeEoX8FUAN56H7XXvC3VQeCJGQOxyu/QfabjYB+q/ZvcrI/Y+9ZqVAKcZ0y1
         TGw10S0r7wqOIn0oyzUqRo2n4qzANLknJATiIdnCUr5lC5ftYjmvBN5pjS7HVYCl2jux
         HD1g==
X-Gm-Message-State: AOAM530xFw+YtFVbmBKWtJQ/ZLaFrsEz//Fo/guz5OzPa9swqPi3ao0p
        4Qv7BIRJ3IUCBDAOsoXVkR+lAyGZx0bJcZTTaQKDNg==
X-Google-Smtp-Source: ABdhPJzNkiEF5AdCtll7EL6snVYgkeW5ayOtaBFQAj3JfSarNW6HxkVsnCJ1hIrN0hvk4Lb3VUkPY0z6DRCncy7KThg=
X-Received: by 2002:a05:6512:2386:: with SMTP id c6mr829947lfv.142.1616160594525;
 Fri, 19 Mar 2021 06:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <5448054.DvuYhMxLoT@kreacher> <2060154.irdbgypaU6@kreacher>
In-Reply-To: <2060154.irdbgypaU6@kreacher>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 19 Mar 2021 14:29:18 +0100
Message-ID: <CAPDyKFpK46raH4DqmTjYm1a1sQtss3BEM3BfVGYsYvNThj1b-g@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] PM: runtime: Defer suspending suppliers
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        "elaine.zhang" <zhangqing@rock-chips.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 18 Mar 2021 at 19:15, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Because the PM-runtime status of the device is not updated in
> __rpm_callback(), attempts to suspend the suppliers of the given
> device triggered by the rpm_put_suppliers() call in there may fail.
>
> To fix this (1) modify __rpm_callback() to avoid attempting to
> actually suspend the suppliers, but only decrease their PM-runtime
> usage counters and (2) make rpm_suspend() try to suspend the suppliers
> after changing the device's PM-runtime status, in analogy with the
> handling of the device's parent.
>
> Link: https://lore.kernel.org/linux-pm/CAPDyKFqm06KDw_p8WXsM4dijDbho4bb6T4k50UqqvR1_COsp8g@mail.gmail.com/
> Fixes: 21d5c57b3726 ("PM / runtime: Use device links")
> Reported-by: elaine.zhang <zhangqing@rock-chips.com>
> Diagnosed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Just a minor nitpick, see below. In any case:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/base/power/runtime.c |   45 +++++++++++++++++++++++++++++++++++++------
>  1 file changed, 39 insertions(+), 6 deletions(-)
>
> Index: linux-pm/drivers/base/power/runtime.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/runtime.c
> +++ linux-pm/drivers/base/power/runtime.c
> @@ -305,7 +305,7 @@ static int rpm_get_suppliers(struct devi
>         return 0;
>  }
>
> -static void rpm_put_suppliers(struct device *dev)
> +static void __rpm_put_suppliers(struct device *dev, bool try_to_suspend)
>  {
>         struct device_link *link;
>
> @@ -313,10 +313,30 @@ static void rpm_put_suppliers(struct dev
>                                 device_links_read_lock_held()) {
>
>                 while (refcount_dec_not_one(&link->rpm_active))
> -                       pm_runtime_put(link->supplier);
> +                       pm_runtime_put_noidle(link->supplier);
> +
> +               if (try_to_suspend)
> +                       pm_request_idle(link->supplier);
>         }
>  }
>
> +static void rpm_put_suppliers(struct device *dev)
> +{
> +       __rpm_put_suppliers(dev, true);
> +}
> +
> +static void rpm_try_to_suspend_suppliers(struct device *dev)

Maybe "rpm_suspend_suppliers" is sufficient for the name of the
function, but I have no strong opinion.

> +{
> +       struct device_link *link;
> +       int idx = device_links_read_lock();
> +
> +       list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
> +                               device_links_read_lock_held())
> +               pm_request_idle(link->supplier);
> +
> +       device_links_read_unlock(idx);
> +}
> +

[...]

Kind regards
Uffe
