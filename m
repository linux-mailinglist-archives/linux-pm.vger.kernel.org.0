Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACBD287D8E
	for <lists+linux-pm@lfdr.de>; Thu,  8 Oct 2020 22:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgJHU7O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Oct 2020 16:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgJHU7O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Oct 2020 16:59:14 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F6EC0613D2;
        Thu,  8 Oct 2020 13:59:13 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id t18so7156678ilo.12;
        Thu, 08 Oct 2020 13:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Q/EQhcs1vcXl6exyIHWBGzBWdidXnM11CQoUo331TY=;
        b=KAZn8tcJYLP4ydNypVbG3Ck4t+RM6ez2oUOjMq+su6SeXb0XTSriximubAzYXzInw5
         Og3jih//hLjpNmULRctgGP6DboBokziw76yj4uuI095a1pBLWOl7Px8DdNY8kmnaao0+
         f/IeKu8AEbyF6kk8DITlH7ehMIjgZFlRTTX9eZT81tCaCnvv1ckJvJjN1/dB5KBPDqSC
         58X8WdFdo+M1knd2VYnpkJvVHwU2yXUYccrTIgziHZMqPLFzwn3OtgDkJsPn6E7Vj4xA
         +aMCK+m/rKui3CdhiFBEnj7mHOtY4h+AWX2tcwihUcOCEHgdSCn1PZfaSQgvebW5AtUy
         yukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Q/EQhcs1vcXl6exyIHWBGzBWdidXnM11CQoUo331TY=;
        b=stITGCmOv61yhU/gLYjWf9OzSY5lOEWi54iIXrVb6uJazR6ueeIH7vymSgBaMkT6Mq
         RFlU90E2TrcWdjtOM734yXAmUhzCVI+RLeJIuZ5+EZMXw6sN4qodB7uUEXlatPN3v/Qx
         jJWhMppWoLyDtTu6WUsuQa9QDDCEStFi+Kyl1uEiW6o+4kdS83bL1p8p8zFyQGLo/L/J
         RMkxKT+zBWJxuEe+62XbETYWS0RZLbprOAlkEtAonUbkrLIK2YMavJCzKisGtm7ScUsQ
         OXK+TfR91+Zm18U22ywMx9JeWXWcnaT3rIu4l5BZYYQdIWUV6kYos16I7fclwxYUzMQN
         29ng==
X-Gm-Message-State: AOAM532Gw2AeLa7T2DMkx4R2mrTPUZUumvJiGw4BOy7KL0z0URX0mUM1
        HCWhdcSialZyfS8JtmcVsf9+J09dutsB9PewgJM9pVg1poI=
X-Google-Smtp-Source: ABdhPJzPN71Uweb2NW0+SHEvtXJUe+jkBXhHFgRUldBdFWWCKN+x53Q6fjP3BNAJzXUq3qESPxCM4O7wQlRZ4c0bDOc=
X-Received: by 2002:a92:d906:: with SMTP id s6mr7883981iln.89.1602190752682;
 Thu, 08 Oct 2020 13:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200911123157.759379-1-aford173@gmail.com>
In-Reply-To: <20200911123157.759379-1-aford173@gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 8 Oct 2020 15:59:01 -0500
Message-ID: <CAHCN7xK2TQsjFUCty2TFgx9HsPMvuuSF6ae5iKCouWFsv7Npzw@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: ti-soc-thermal: Enable addition power management
To:     linux-pm@vger.kernel.org, Linux-OMAP <linux-omap@vger.kernel.org>
Cc:     Adam Ford-BE <aford@beaconembedded.com>,
        kernel test robot <lkp@intel.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 11, 2020 at 7:32 AM Adam Ford <aford173@gmail.com> wrote:
>
> The bandgap sensor can be idled when the processor is too, but it
> isn't currently being done, so the power consumption of OMAP3
> boards can elevated if the bangap sensor is enabled.
>
> This patch attempts to use some additional power management
> to idle the clock to the bandgap when not needed.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Tested-by: Andreas Kemnade <andreas@kemnade.info> # GTA04
> ---
> V3:  bandgap_omap_cpu_notifier is only defined when CONFIG_PM_SLEEP
>      is enabled, so make all references to it also depend on
>      CONFIG_PM_SLEEP as well
>

Gentle nudge on this one.  It was in the queue for a while, and got
lost, then resurrected again.

thanks

adam

> V2: Fix issue where variable stating the suspend mode isn't being
>     properly set and cleared.
>
> diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> index ab19ceff6e2a..5e596168ba73 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> @@ -25,10 +25,20 @@
>  #include <linux/of_platform.h>
>  #include <linux/of_irq.h>
>  #include <linux/io.h>
> +#include <linux/cpu_pm.h>
> +#include <linux/device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/pm.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
>
>  #include "ti-bandgap.h"
>
>  static int ti_bandgap_force_single_read(struct ti_bandgap *bgp, int id);
> +#ifdef CONFIG_PM_SLEEP
> +static int bandgap_omap_cpu_notifier(struct notifier_block *nb,
> +                                 unsigned long cmd, void *v);
> +#endif
>
>  /***   Helper functions to access registers and their bitfields   ***/
>
> @@ -1008,6 +1018,11 @@ int ti_bandgap_probe(struct platform_device *pdev)
>                 }
>         }
>
> +#ifdef CONFIG_PM_SLEEP
> +       bgp->nb.notifier_call = bandgap_omap_cpu_notifier;
> +       cpu_pm_register_notifier(&bgp->nb);
> +#endif
> +
>         return 0;
>
>  remove_last_cooling:
> @@ -1041,7 +1056,9 @@ int ti_bandgap_remove(struct platform_device *pdev)
>         struct ti_bandgap *bgp = platform_get_drvdata(pdev);
>         int i;
>
> -       /* First thing is to remove sensor interfaces */
> +       cpu_pm_unregister_notifier(&bgp->nb);
> +
> +       /* Remove sensor interfaces */
>         for (i = 0; i < bgp->conf->sensor_count; i++) {
>                 if (bgp->conf->sensors[i].unregister_cooling)
>                         bgp->conf->sensors[i].unregister_cooling(bgp, i);
> @@ -1150,9 +1167,43 @@ static int ti_bandgap_suspend(struct device *dev)
>         if (TI_BANDGAP_HAS(bgp, CLK_CTRL))
>                 clk_disable_unprepare(bgp->fclock);
>
> +       bgp->is_suspended = true;
> +
>         return err;
>  }
>
> +static int bandgap_omap_cpu_notifier(struct notifier_block *nb,
> +                                 unsigned long cmd, void *v)
> +{
> +       struct ti_bandgap *bgp;
> +
> +       bgp = container_of(nb, struct ti_bandgap, nb);
> +
> +       spin_lock(&bgp->lock);
> +       switch (cmd) {
> +       case CPU_CLUSTER_PM_ENTER:
> +               if (bgp->is_suspended)
> +                       break;
> +               ti_bandgap_save_ctxt(bgp);
> +               ti_bandgap_power(bgp, false);
> +               if (TI_BANDGAP_HAS(bgp, CLK_CTRL))
> +                       clk_disable(bgp->fclock);
> +               break;
> +       case CPU_CLUSTER_PM_ENTER_FAILED:
> +       case CPU_CLUSTER_PM_EXIT:
> +               if (bgp->is_suspended)
> +                       break;
> +               if (TI_BANDGAP_HAS(bgp, CLK_CTRL))
> +                       clk_enable(bgp->fclock);
> +               ti_bandgap_power(bgp, true);
> +               ti_bandgap_restore_ctxt(bgp);
> +               break;
> +       }
> +       spin_unlock(&bgp->lock);
> +
> +       return NOTIFY_OK;
> +}
> +
>  static int ti_bandgap_resume(struct device *dev)
>  {
>         struct ti_bandgap *bgp = dev_get_drvdata(dev);
> @@ -1161,6 +1212,7 @@ static int ti_bandgap_resume(struct device *dev)
>                 clk_prepare_enable(bgp->fclock);
>
>         ti_bandgap_power(bgp, true);
> +       bgp->is_suspended = false;
>
>         return ti_bandgap_restore_ctxt(bgp);
>  }
> diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.h b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
> index fce4657e9486..ed0ea4b17b25 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-bandgap.h
> +++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
> @@ -12,6 +12,10 @@
>  #include <linux/spinlock.h>
>  #include <linux/types.h>
>  #include <linux/err.h>
> +#include <linux/cpu_pm.h>
> +#include <linux/device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/pm.h>
>
>  struct gpio_desc;
>
> @@ -203,6 +207,8 @@ struct ti_bandgap {
>         int                             irq;
>         struct gpio_desc                *tshut_gpiod;
>         u32                             clk_rate;
> +       struct notifier_block           nb;
> +       unsigned int is_suspended:1;
>  };
>
>  /**
> --
> 2.25.1
>
