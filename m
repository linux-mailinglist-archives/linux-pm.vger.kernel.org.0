Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11A9711C831
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2019 09:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbfLLI3F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Dec 2019 03:29:05 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:41865 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbfLLI3F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Dec 2019 03:29:05 -0500
Received: by mail-vs1-f65.google.com with SMTP id f8so951117vsq.8
        for <linux-pm@vger.kernel.org>; Thu, 12 Dec 2019 00:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XgxCnRiTfja1L+B6Xn0JuIUwn0x0QrtKVBtLGuTEljg=;
        b=gVztby/BHQJ9PZBKa3D0z7om1skfkDzVsuhBRH82k9/hXT9aRdfZ6KGtjWHOutFleq
         uF1WSfJ8tUrou3WPu+hDg5If+SNIO2Ufb6a+9pPgHemfEqDmvBGYc79gx+x1N0w8G0b1
         l1mEnz/PBcmVnZppUrc7t6d4FNIcEk6K6weCBa6/VehlKZP6Ob5UcMo1iORqF65cBM/c
         Iv41qh9jbeSX7tFgULRbU1bGCyznTNPQrmyJqJoywgSrOx082uCOuDCRoTAmQ/wANuxW
         GK/IyyFBIHd5E9Li4OslsbEGWt4pWiS40vkZpksi5880AnShIACe0dpD/onBAzjlkhvw
         nHlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XgxCnRiTfja1L+B6Xn0JuIUwn0x0QrtKVBtLGuTEljg=;
        b=NfG9/Ib9bmzJKFTdaLsnj2p7M0HhBp6hkvTRV9eiKutzdKFTGvsnGpvlOa1YKdoWmc
         JCtE6Gvoto9Fccdueu8/7mXT9Kn2qedUXbg+yf3r2neMzQ0q6RHvkk9asS8VERAmxZRA
         gk97GfN4SPw88BfOg9QLVgL7FFe6hRCPd+1mebRSY1N6QKgmcSlWpAwHGQNtg2gwsCLi
         qELD+58bmZd49NfXG9msaInY/eJC24VjV6mrU1Gdoabcu680TbLwc9Xntv+44DtzQHY+
         jqBi8O7oHzLCoUJ0cvXTvcUriLirh+/vnUYY1nuoovf9FaMR+E1N5vizUdBn4TkXCdyd
         xncQ==
X-Gm-Message-State: APjAAAUIxpM8HbC5Nt4s31iXmIR7f7y27bPiX3EEZ6VidFu/nZnO6lQF
        FEixr46zcYiWLOFIN4+vafd0d2/x5PYqZGnK/1oODg==
X-Google-Smtp-Source: APXvYqxwBVwLqxEvOxIflOhsGsMSkYb6lfxJt1tosG6/eY6xpGyjucXTvEj741coTmOODqT107Q/DNxtylHdDzMIdYA=
X-Received: by 2002:a67:7acd:: with SMTP id v196mr5961661vsc.95.1576139344363;
 Thu, 12 Dec 2019 00:29:04 -0800 (PST)
MIME-Version: 1.0
References: <20191212061702.BFE2D6E85603@corona.crabdance.com>
In-Reply-To: <20191212061702.BFE2D6E85603@corona.crabdance.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Thu, 12 Dec 2019 13:58:52 +0530
Message-ID: <CAHLCerOHjAEEA1BpUqPdZvFwHMy11SqC+ZtjdFyManu7iOpBXA@mail.gmail.com>
Subject: Re: [RESEND PATCH] thermal: rockchip: enable hwmon
To:     schaecsn@gmx.net
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Linux PM list <linux-pm@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        linux-rockchip@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 12, 2019 at 11:47 AM Stefan Schaeckeler <schaecsn@gmx.net> wrote:
>
> By default, of-based thermal drivers do not enable hwmon.
> Explicitly enable hwmon for both, the soc and gpu temperature
> sensor.

Is there any reason you need to expose this in hwmon?

> Signed-off-by: Stefan Schaeckeler <schaecsn@gmx.net>
>
> ---
>  drivers/thermal/rockchip_thermal.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> index 343c2f5c5a25..e47c60010259 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -19,6 +19,8 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/pinctrl/consumer.h>
>
> +#include "thermal_hwmon.h"
> +
>  /**
>   * If the temperature over a period of time High,
>   * the resulting TSHUT gave CRU module,let it reset the entire chip,
> @@ -1321,8 +1323,15 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
>
>         thermal->chip->control(thermal->regs, true);
>
> -       for (i = 0; i < thermal->chip->chn_num; i++)
> +       for (i = 0; i < thermal->chip->chn_num; i++) {
>                 rockchip_thermal_toggle_sensor(&thermal->sensors[i], true);
> +               thermal->sensors[i].tzd->tzp->no_hwmon = false;
> +               error = thermal_add_hwmon_sysfs(thermal->sensors[i].tzd);
> +               if (error)
> +                       dev_warn(&pdev->dev,
> +                                "failed to register sensor %d with hwmon: %d\n",
> +                                i, error);
> +       }
>
>         platform_set_drvdata(pdev, thermal);
>
> @@ -1344,6 +1353,7 @@ static int rockchip_thermal_remove(struct platform_device *pdev)
>         for (i = 0; i < thermal->chip->chn_num; i++) {
>                 struct rockchip_thermal_sensor *sensor = &thermal->sensors[i];
>
> +               thermal_remove_hwmon_sysfs(sensor->tzd);
>                 rockchip_thermal_toggle_sensor(sensor, false);
>         }
>
> --
> 2.24.0
>
