Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3C378BC9
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 14:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387857AbfG2Maf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 08:30:35 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39382 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387854AbfG2Maf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jul 2019 08:30:35 -0400
Received: by mail-lj1-f196.google.com with SMTP id v18so58364599ljh.6;
        Mon, 29 Jul 2019 05:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cpWcb3Uhfu+s0OodVAvfJxjTZHHYbM0UrZo3CU2SdEY=;
        b=odKDRUqKPIEcxXLs3V/xWUxjJ54t7ma9vvT91Vm9ESMwyy0O/5WMqlMIXpN78831US
         0P9844Pd/txItVVfaSMTDzYiJXeCQU5e+T6t/bnia2oroc0umpepJjrCqOcZ9Znv/Izf
         710OJAl+8ONWuRhfcVXOKn3VPWWT61XihC6aXw9MI0RRL/0HCUAFcrKcQ21NklkfdmW+
         kQQqN3VKRL9fPUZjPQeTmYTxroMIIBT6k1C5qNmnwkZw8VwDtvjLoFjdOF02k1dOnhMy
         vWC3JuAzZ1ee6GYgYyf66rKJSCe9Xjb5AZXROWm8tkeGn8l76myzduvlnzR1ZGZiDQGF
         K0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cpWcb3Uhfu+s0OodVAvfJxjTZHHYbM0UrZo3CU2SdEY=;
        b=V5OnitcXU7uHmS1Lk/JnrcYpWVJW/sokmY4tf5MIhJENk/phu0gWcIYOuqjthOOprO
         AfxIDbar6w3kGNtevXp76K3VvYbmIV3Ie+5EUtwqqnlSsC+R2GvY3ia63d5Qbjqrucfh
         wAGnsDOd6bbpg/feVW3mxau1z0A3+6/h7Xvh7tGEYL0m4YxU56GEIMLuvn000Ctghq8J
         0Kz62b5hIr3vEmELQr1lInB30uLSfj6/L8ccCQVfRAAGTQcQrtrr5KnEZ8UZ1ov9fl0X
         IDor3ltYm920bvYgmK70V8/7DL0SLLRhBgupVETQMdbTEC/5+qAjIQqdyUxd3H/wt9PH
         2alA==
X-Gm-Message-State: APjAAAUs5bj07vO8bOj3kutDEY4hK39qM35fihZL5mR3GHPrDWBAsJVy
        PeJeLknmaHtBQ13XqngyKMbRbP3A1rN+g5BdTKphtET+WVE=
X-Google-Smtp-Source: APXvYqx/3Ua0jj+6CAWReswNT3QrHMjC0MbyyLVN/yjIF9mIV287N15K4SoJcu20NrKAMBsnsU9bbqWvKSs0tCxXAms=
X-Received: by 2002:a2e:8650:: with SMTP id i16mr58277768ljj.178.1564403432632;
 Mon, 29 Jul 2019 05:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190729083915.4855-1-Anson.Huang@nxp.com> <20190729083915.4855-4-Anson.Huang@nxp.com>
In-Reply-To: <20190729083915.4855-4-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 29 Jul 2019 09:30:36 -0300
Message-ID: <CAOMZO5AgP0BrHyFKz78rsEz1XQMgSNzMmtTV6Q+GYtCGBiFMEQ@mail.gmail.com>
Subject: Re: [PATCH V2 4/4] thermal: qoriq: Add clock operations
To:     Yongcai Huang <Anson.Huang@nxp.com>
Cc:     "rui.zhang" <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Anson,

On Mon, Jul 29, 2019 at 6:04 AM <Anson.Huang@nxp.com> wrote:
>
> From: Anson Huang <Anson.Huang@nxp.com>
>
> Some platforms like i.MX8MQ has clock control for this module,
> need to add clock operations to make sure the driver is working
> properly.

I haven't seen this series earlier, and I have sent a similar patch
for Guido to test.

Since this patch solves a hang problem, I would suggest that this one
becomes the first of the series.

Also, the "clk: imx8mq: Remove CLK_IS_CRITICAL flag for
IMX8MQ_CLK_TMU_ROOT" should only be applied after this one in order to
avoid the hang.

>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Guido G=C3=BCnther <agx@sigxcpu.org>
> ---
> Changes since V1:
>         - use devm_clk_get_optional() instead of devm_clk_get().
> ---
>  drivers/thermal/qoriq_thermal.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_ther=
mal.c
> index 2b2f79b..0ae45c0 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -2,6 +2,7 @@
>  //
>  // Copyright 2016 Freescale Semiconductor, Inc.
>
> +#include <linux/clk.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/err.h>
> @@ -72,6 +73,7 @@ struct qoriq_sensor {
>
>  struct qoriq_tmu_data {
>         struct qoriq_tmu_regs __iomem *regs;
> +       struct clk *clk;
>         bool little_endian;
>         struct qoriq_sensor     *sensor[SITES_MAX];
>  };
> @@ -208,6 +210,16 @@ static int qoriq_tmu_probe(struct platform_device *p=
dev)
>                 return PTR_ERR(data->regs);
>         }
>
> +       data->clk =3D devm_clk_get_optional(&pdev->dev, NULL);
> +       if (IS_ERR(data->clk))
> +               return PTR_ERR(data->clk);
> +
> +       ret =3D clk_prepare_enable(data->clk);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Failed to enable clock\n");
> +               return ret;
> +       }
> +
>         qoriq_tmu_init_device(data);    /* TMU initialization */
>
>         ret =3D qoriq_tmu_calibration(pdev);      /* TMU calibration */

In case of failure the TMU clock should be disabled in the error path.

Thanks
