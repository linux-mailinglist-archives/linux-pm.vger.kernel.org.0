Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA4E0888CC
	for <lists+linux-pm@lfdr.de>; Sat, 10 Aug 2019 08:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbfHJGRP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Aug 2019 02:17:15 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:32840 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfHJGRO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Aug 2019 02:17:14 -0400
Received: by mail-ot1-f68.google.com with SMTP id q20so140948366otl.0;
        Fri, 09 Aug 2019 23:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GFQESJU0HLdydkYi11prZWb0uKl8NCE/OD8DthGkiqE=;
        b=f+3F7E1eh0XF4E+DiMuJruDYCrdAxIWvreWv1xMzoCqqFDrKDsFZbsz4DqpLVIM5q4
         B0UIQGGgOvdLbbMpmHHEBM7aabze/uBMEOBO5BTq2VAM/RwVghSrIBLEZLan0b2rYKTA
         FLHRlmM51F48KNsXTFkXPTO3locOu5bpiuxxX7uwvMVgfIXquX/0XcbHl908xUz8rR3Z
         LbQXf8GVeCqWKnjhwh+E/Ud0+e2VBckJ6Hdlg+EmikqVaSIrGItSoetXFbMHwPDqJTi7
         Kth46OfyhGtUvnTzQ6zxhNBVi4ewZRdFcoEDGUgqozTIZeuKmUgOwXRyA3PJtt2eDlp8
         O2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GFQESJU0HLdydkYi11prZWb0uKl8NCE/OD8DthGkiqE=;
        b=qdniQkQ3qQ3mXy0e9LuW0SUR20WjCIxFETEbeIKPD45F4rwWBjCsOmTjWi1sgBVZ1u
         8MzKIiWmG1EShcgx+8V+S/RZXEzd6zK7Enclpem5JlBqOdR03hb6WghxmZPUF4FjOrTF
         AsumlkinZh4OVZraLX7r52gbZOiVWCJkkypwWUuoXh36vzgAwdmW4N1e8wL0icpb4Hf6
         nRBNcyL/+foBRZ1nE8f15L48OH9q7O6lzpobY/VN5NGOGBnU8Xy8HnNyjSm/kD0br99q
         vMOkdmcsGJRWB8l2pnnYvVWB2A5jyiCiBgdAIR+1zjP04p/GwAhuSbc+8IY8LyWeH/z+
         zfuQ==
X-Gm-Message-State: APjAAAXTsx8yM7fkn3SUBzE2rXKNpD4vziTP7mBZCNJSYS3lCuTLPlUZ
        qy2spPG2+OGZYnBtPpINvSy0uqKhnjAardPU560=
X-Google-Smtp-Source: APXvYqyHHWc+Ae3MZP5usnRpiYzR1mL1m3YZLNpeSjJ0StHZktGgRfPkbbXhPSuFohfq/eXEokgAUj1A9vc9DkA86io=
X-Received: by 2002:a9d:4109:: with SMTP id o9mr19424717ote.353.1565417833721;
 Fri, 09 Aug 2019 23:17:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190810052829.6032-1-tiny.windzz@gmail.com> <20190810052829.6032-9-tiny.windzz@gmail.com>
In-Reply-To: <20190810052829.6032-9-tiny.windzz@gmail.com>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Fri, 9 Aug 2019 23:16:48 -0700
Message-ID: <CA+E=qVfp-rProxOwX__J6jM-pZ9g_SmeuOCOgvC_5DJVQw4OGw@mail.gmail.com>
Subject: Re: [PATCH v5 08/18] thermal: sun8i: support mod clocks
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     rui.zhang@intel.com, Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan.Cameron@huawei.com,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Aug 9, 2019 at 10:31 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> H3 has extra clock, so introduce something in ths_thermal_chip/ths_device
> and adds the process of the clock.
>
> This is pre-work for supprt it.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/thermal/sun8i_thermal.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
> index b934bc81eba7..6f4294c2aba7 100644
> --- a/drivers/thermal/sun8i_thermal.c
> +++ b/drivers/thermal/sun8i_thermal.c
> @@ -54,6 +54,7 @@ struct tsensor {
>  };
>
>  struct ths_thermal_chip {
> +       bool            has_mod_clk;
>         int             sensor_num;
>         int             offset;
>         int             scale;
> @@ -69,6 +70,7 @@ struct ths_device {
>         struct regmap                           *regmap;
>         struct reset_control                    *reset;
>         struct clk                              *bus_clk;
> +       struct clk                              *mod_clk;
>         struct tsensor                          sensor[MAX_SENSOR_NUM];
>  };
>
> @@ -274,6 +276,12 @@ static int sun8i_ths_resource_init(struct ths_device *tmdev)
>         if (IS_ERR(tmdev->bus_clk))
>                 return PTR_ERR(tmdev->bus_clk);
>
> +       if (tmdev->chip->has_mod_clk) {
> +               tmdev->mod_clk = devm_clk_get(&pdev->dev, "mod");
> +               if (IS_ERR(tmdev->mod_clk))
> +                       return PTR_ERR(tmdev->mod_clk);
> +       }
> +
>         ret = reset_control_deassert(tmdev->reset);
>         if (ret)
>                 return ret;
> @@ -282,12 +290,18 @@ static int sun8i_ths_resource_init(struct ths_device *tmdev)
>         if (ret)
>                 goto assert_reset;
>
> -       ret = sun50i_ths_calibrate(tmdev);
> +       ret = clk_prepare_enable(tmdev->mod_clk);

You have to set rate of modclk before enabling it since you can't rely
on whatever bootloader left for you.

Also I found that parameters you're using for PC_TEMP_PERIOD, ACQ0 and
ACQ1 are too aggressive and may result in high interrupt rate to the
point when it may stall RCU. I changed driver a bit to use params from
Philipp Rossak's work (modclk set to 4MHz, PC_TEMP_PERIOD is 7, ACQ0
is 255, ACQ1 is 63) and it fixed RCU stalls for me, see [1] for
details.

[1] https://github.com/anarsoul/linux-2.6/commit/46b8bb0fe2ccd1cd88fa9181a2ecbf79e8d513b2


>         if (ret)
>                 goto bus_disable;
>
> +       ret = sun50i_ths_calibrate(tmdev);
> +       if (ret)
> +               goto mod_disable;
> +
>         return 0;
>
> +mod_disable:
> +       clk_disable_unprepare(tmdev->mod_clk);
>  bus_disable:
>         clk_disable_unprepare(tmdev->bus_clk);
>  assert_reset:
> @@ -395,6 +409,7 @@ static int sun8i_ths_remove(struct platform_device *pdev)
>  {
>         struct ths_device *tmdev = platform_get_drvdata(pdev);
>
> +       clk_disable_unprepare(tmdev->mod_clk);
>         clk_disable_unprepare(tmdev->bus_clk);
>         reset_control_assert(tmdev->reset);
>
> --
> 2.17.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
