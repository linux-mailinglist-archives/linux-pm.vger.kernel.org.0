Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F629311D4B
	for <lists+linux-pm@lfdr.de>; Sat,  6 Feb 2021 14:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbhBFNDH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 6 Feb 2021 08:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhBFNCx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 6 Feb 2021 08:02:53 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7184AC06174A;
        Sat,  6 Feb 2021 05:02:13 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id g3so4999558plp.2;
        Sat, 06 Feb 2021 05:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=244Z31oFAGzpSNuKHU/MicO/I2Za+TwL6w/zVd76MAk=;
        b=bFQVwTF2ZFuahwv0jbueMJrPC0wnR0Oax7RoEG4zTQJB8ZOgHu5HkuMl/YOpJM7Zd4
         FbANCvdVMqv9Le8tb2kojJvs6ZU/cQnb5+/q43VCVMCqQhHXyXlmf4dCrJ3/Y9iy7wKD
         DPZr42XftDjfBPnfdqbnGoXZRqLxmbFg1uYMVudDl1pfAA+0jVd7oNVPtPDKEm3d55ot
         b9kETIAFlpH+oZAVK9xGVlD5pQb/hmvJrkwX8d9ard613CKERDaj0MlG+Y5PUuRqew2i
         o39b3Hi7Xu8vU8q235XjtEkWY+DjdGA7Vnfd0uD29weQLfI10OE8DAKEqS11G9x5xUut
         rlQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=244Z31oFAGzpSNuKHU/MicO/I2Za+TwL6w/zVd76MAk=;
        b=uCN0XVNWyC/zPffSSk9+LzKOrUDuLMK4FjN5MBiJzGf3ge99nLAEelt/+96uAMduDs
         GIgxE02dRkwwEW1RanGjoSnnaLEKr7SNjsFNwPxyVeBwh84aE1EEue4vv8ZBk2W+shLz
         haCFmT29wc1vLwxzIzo8NjG8F+fEO2v26vRto3KONM7pCSlenZArpSKVRHysREUkJREX
         aqWkkb4NUJMW2N0d++0VCK4X14I1R+uEWD4Bq8YUx2dKIVEArUpR19aVxMaEmAUlhO7b
         qN/ZaqOqsKxlEdugC9DO/mY3LenjSzUDMfddNyn1AusBHHFTa5JaMEzYs76APpB7iFMt
         YAzw==
X-Gm-Message-State: AOAM530Qa0KLYrglAaaPuepGVfukb3REZhUsZJFMKzEe5sXhA8O5+cyg
        2vNddrgEU32qqy0UYwSWhciZZUSoJs/nwNIATRidWPkg2Qw0Ew==
X-Google-Smtp-Source: ABdhPJyxbFHu+UGLahBUTUE/OWXOERPk/pXNqgcXBx59xCm5Rosl6nfiFoN4hdwIXtQfYi6ONha8gr1diFQVN4LNV3c=
X-Received: by 2002:a17:90a:5601:: with SMTP id r1mr8523311pjf.236.1612616532713;
 Sat, 06 Feb 2021 05:02:12 -0800 (PST)
MIME-Version: 1.0
References: <20210205134534.49200-1-tony@atomide.com> <20210205134534.49200-4-tony@atomide.com>
In-Reply-To: <20210205134534.49200-4-tony@atomide.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Sat, 6 Feb 2021 07:02:01 -0600
Message-ID: <CAHCN7x+ckhB1q+LrRCvLaf2eMjdQzj0b9+x-2Zt-eKjbiNkoRg@mail.gmail.com>
Subject: Re: [PATCH 3/4] thermal: ti-soc-thermal: Simplify polling with iopoll
To:     Tony Lindgren <tony@atomide.com>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>, linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Carl Philipp Klemm <philipp@uvos.xyz>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Sebastian Reichel <sre@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 5, 2021 at 7:45 AM Tony Lindgren <tony@atomide.com> wrote:
>
> We can use iopoll for checking the EOCZ (end of conversion) bit. And with
> this we now also want to handle the timeout errors properly.
>
> For omap3, we need about 1.2ms for the single mode sampling to wait for
> EOCZ down, so let's use 1.5ms timeout there. Waiting for sampling to start
> is faster and we can use 1ms timeout.
>
> Cc: Adam Ford <aford173@gmail.com>
> Cc: Carl Philipp Klemm <philipp@uvos.xyz>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: H. Nikolaus Schaller <hns@goldelico.com>
> Cc: Merlijn Wajer <merlijn@wizzup.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
> Cc: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

For the series,

Tested-by: Adam Ford <aford173@gmail.com> #logicpd-torpedo-37xx-devkit

> ---
>  drivers/thermal/ti-soc-thermal/ti-bandgap.c | 30 ++++++++++-----------
>  1 file changed, 14 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> --- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> @@ -15,7 +15,6 @@
>  #include <linux/kernel.h>
>  #include <linux/interrupt.h>
>  #include <linux/clk.h>
> -#include <linux/delay.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/err.h>
> @@ -27,6 +26,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/of_irq.h>
>  #include <linux/io.h>
> +#include <linux/iopoll.h>
>  #include <linux/cpu_pm.h>
>  #include <linux/device.h>
>  #include <linux/pm_runtime.h>
> @@ -604,7 +604,9 @@ static int
>  ti_bandgap_force_single_read(struct ti_bandgap *bgp, int id)
>  {
>         struct temp_sensor_registers *tsr = bgp->conf->sensors[id].registers;
> -       u32 counter;
> +       void __iomem *temp_sensor_ctrl = bgp->base + tsr->temp_sensor_ctrl;
> +       int error;
> +       u32 val;
>
>         /* Select continuous or single conversion mode */
>         if (TI_BANDGAP_HAS(bgp, MODE_CONFIG)) {
> @@ -619,26 +621,22 @@ ti_bandgap_force_single_read(struct ti_bandgap *bgp, int id)
>                 RMW_BITS(bgp, id, temp_sensor_ctrl, bgap_soc_mask, 1);
>
>                 /* Wait for EOCZ going up */
> -               counter = 1000;
> -               while (--counter) {
> -                       if (ti_bandgap_readl(bgp, tsr->temp_sensor_ctrl) &
> -                           tsr->bgap_eocz_mask)
> -                               break;
> -                       udelay(1);
> -               }
> +               error = readl_poll_timeout_atomic(temp_sensor_ctrl, val,
> +                                                 val & tsr->bgap_eocz_mask,
> +                                                 1, 1000);
> +               if (error)
> +                       dev_warn(bgp->dev, "eocz timed out waiting high\n");
>
>                 /* Clear Start of Conversion if available */
>                 RMW_BITS(bgp, id, temp_sensor_ctrl, bgap_soc_mask, 0);
>         }
>
>         /* Wait for EOCZ going down, always needed even if no bgap_soc_mask */
> -       counter = 1000;
> -       while (--counter) {
> -               if (!(ti_bandgap_readl(bgp, tsr->temp_sensor_ctrl) &
> -                     tsr->bgap_eocz_mask))
> -                       break;
> -               udelay(1);
> -       }
> +       error = readl_poll_timeout_atomic(temp_sensor_ctrl, val,
> +                                         !(val & tsr->bgap_eocz_mask),
> +                                         1, 1500);
> +       if (error)
> +               dev_warn(bgp->dev, "eocz timed out waiting low\n");
>
>         return 0;
>  }
> --
> 2.30.0
