Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4CD3764DE
	for <lists+linux-pm@lfdr.de>; Fri,  7 May 2021 14:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235922AbhEGMFe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 May 2021 08:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235460AbhEGMFe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 May 2021 08:05:34 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3FAC061574
        for <linux-pm@vger.kernel.org>; Fri,  7 May 2021 05:04:34 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id 66so4540957vsk.9
        for <linux-pm@vger.kernel.org>; Fri, 07 May 2021 05:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cQHsYCv/veghSWphtSoC5Y2vDR65oOelmQfRVgs2/nY=;
        b=xWIa52Ewjy8iAbEUz1PZVMFV+vl9x6urA4NnFkUj04WJ8ccEyDY9POZgIcJQttEd9d
         qGJXEoIxSz6WPMsRlGTW6nRKrnFMnfaZgHYcOdYKV3YscdLyoJQONjOk/w5Fmj4y2x2u
         G+y3Eg+Vpd9/Tje2+QZ2IORMVtx2qrbbDeUYZI0FoQkxPCAyrMFlw18+NcAx7EzZY/tR
         aKyxJRgkwkJXPWRmsw/u+TCSyLVJZ56IKlFkWVwJ7z1nBJ/vND9JfZr1wHvpt20cStiv
         zUpisAXnBTPB3skH3Nj17yo6s88+2bfu7jSNCGk3NIA+UQIbm7r+LqqFmPAduoEypUZ1
         hvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cQHsYCv/veghSWphtSoC5Y2vDR65oOelmQfRVgs2/nY=;
        b=jQt3YrQP1OuangCzgo+yOet7JcpBgnwIGtZaKJOpKUxQbvEu8XYyH2zjMOqpA9miJO
         lZcJ9ErBStDyecrMLorL98GhB5uxbJuGawprqvjIvr21EEfq2rKhazy7iE5F9EpCDAcs
         xXSyabulcJ+z7mw5iWaSLBV/NP4GdZ8uYLatl6zqjDp03SNbzMPOXs3N2TImkjZRhgpL
         oWS5pK9FssiOJYWHHH/SIEV1dgmdnp+5Aw26WMs8uuh3My5uJovqm3xGwmRLM45MuTG2
         xytwUFz8mIiDUQWgJKGcnPq3YsE4Ec/r4iz2wxw8R+QLqODy0wF1RirkgefHWyug/pS1
         JPEw==
X-Gm-Message-State: AOAM5309sFCXoK4t/Zm914eMeQoyoWSTQMDEal+DvEmkqhGBEWSI4Nhu
        jWHmWkMUa5hstFzgd94bgvbmboWC0GAL5kaHyNDeew==
X-Google-Smtp-Source: ABdhPJwM/BRpKmh0zWcpYmBXd8iYZX7X+0IZgY1frY8trVcEq+DpmrHdNypgNdSsBTfenafQZ0Hp2GJfD8IUw4d79r8=
X-Received: by 2002:a67:64c5:: with SMTP id y188mr7319294vsb.19.1620389073750;
 Fri, 07 May 2021 05:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210505110915.6861-1-tony@atomide.com>
In-Reply-To: <20210505110915.6861-1-tony@atomide.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 7 May 2021 14:03:57 +0200
Message-ID: <CAPDyKFp36huF2Gu19T+KvUm90xSsd97VDCxst1KT+Qf0F5Vm5g@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: Fix unpaired parent child_count for force_resume
To:     Tony Lindgren <tony@atomide.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 5 May 2021 at 13:09, Tony Lindgren <tony@atomide.com> wrote:
>
> As pm_runtime_need_not_resume() relies also on usage_count, it can return
> a different value in pm_runtime_force_suspend() compared to when called in
> pm_runtime_force_resume(). Different return values can happen if anything
> calls PM runtime functions in between, and causes the parent child_count
> to increase on every resume.
>
> So far I've seen the issue only for omapdrm that does complicated things
> with PM runtime calls during system suspend for legacy reasons:
>
> omap_atomic_commit_tail() for omapdrm.0
>  dispc_runtime_get()
>   wakes up 58000000.dss as it's the dispc parent
>    dispc_runtime_resume()
>     rpm_resume() increases parent child_count
>  dispc_runtime_put() won't idle, PM runtime suspend blocked
> pm_runtime_force_suspend() for 58000000.dss, !pm_runtime_need_not_resume()
>  __update_runtime_status()
> system suspended
> pm_runtime_force_resume() for 58000000.dss, pm_runtime_need_not_resume()
>  pm_runtime_enable() only called because of pm_runtime_need_not_resume()
> omap_atomic_commit_tail() for omapdrm.0
>  dispc_runtime_get()
>   wakes up 58000000.dss as it's the dispc parent
>    dispc_runtime_resume()
>     rpm_resume() increases parent child_count
>  dispc_runtime_put() won't idle, PM runtime suspend blocked
> ...
> rpm_suspend for 58000000.dss but parent child_count is now unbalanced
>
> Let's fix the issue by adding a flag for needs_force_resume and use it in
> pm_runtime_force_resume() instead of pm_runtime_need_not_resume().

Thanks for sharing the details, much appreciated.

>
> Additionally omapdrm system suspend could be simplified later on to avoid
> lots of unnecessary PM runtime calls and the complexity it adds. The
> driver can just use internal functions that are shared between the PM
> runtime and system suspend related functions.
>
> Fixes: 4918e1f87c5f ("PM / runtime: Rework pm_runtime_force_suspend/resume()")

Actually, I think the problem has been there from the beginning
(unless I am mistaken), when we introduced the functions. So maybe the
fixes tag isn't entirely correct.

Although, I certainly think we should tag this for stable kernels.

> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/runtime.c | 10 +++++++---
>  include/linux/pm.h           |  1 +
>  2 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1637,6 +1637,7 @@ void pm_runtime_init(struct device *dev)
>         dev->power.request_pending = false;
>         dev->power.request = RPM_REQ_NONE;
>         dev->power.deferred_resume = false;
> +       dev->power.needs_force_resume = 0;
>         INIT_WORK(&dev->power.work, pm_runtime_work);
>
>         dev->power.timer_expires = 0;
> @@ -1804,10 +1805,12 @@ int pm_runtime_force_suspend(struct device *dev)
>          * its parent, but set its status to RPM_SUSPENDED anyway in case this
>          * function will be called again for it in the meantime.
>          */
> -       if (pm_runtime_need_not_resume(dev))
> +       if (pm_runtime_need_not_resume(dev)) {
>                 pm_runtime_set_suspended(dev);
> -       else
> +       } else {
>                 __update_runtime_status(dev, RPM_SUSPENDED);
> +               dev->power.needs_force_resume = 1;
> +       }
>
>         return 0;
>
> @@ -1834,7 +1837,7 @@ int pm_runtime_force_resume(struct device *dev)
>         int (*callback)(struct device *);
>         int ret = 0;
>
> -       if (!pm_runtime_status_suspended(dev) || pm_runtime_need_not_resume(dev))
> +       if (!pm_runtime_status_suspended(dev) || !dev->power.needs_force_resume)
>                 goto out;
>
>         /*
> @@ -1853,6 +1856,7 @@ int pm_runtime_force_resume(struct device *dev)
>
>         pm_runtime_mark_last_busy(dev);
>  out:
> +       dev->power.needs_force_resume = 0;
>         pm_runtime_enable(dev);
>         return ret;
>  }
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -602,6 +602,7 @@ struct dev_pm_info {
>         unsigned int            idle_notification:1;
>         unsigned int            request_pending:1;
>         unsigned int            deferred_resume:1;
> +       unsigned int            needs_force_resume:1;
>         unsigned int            runtime_auto:1;
>         bool                    ignore_children:1;
>         unsigned int            no_callbacks:1;
> --
> 2.31.1
