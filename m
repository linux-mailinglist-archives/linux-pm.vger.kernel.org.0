Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 613CCBDFF3
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2019 16:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731058AbfIYO0H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Sep 2019 10:26:07 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:46262 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730517AbfIYO0H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Sep 2019 10:26:07 -0400
Received: by mail-vk1-f196.google.com with SMTP id t128so642552vkd.13
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2019 07:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KExLbRsWWdPJsnH8bWIgRX1rh2usgvEjHrntBDpiVfQ=;
        b=QLlMUHsyDnd1j2CjnjpAE1eW4QYRhi5HeYN+Iw3SYZeZVvx5xLoFqKRU9yAPN7JxJh
         zvOjWoZZx95Dcnt7EOYc+Iug732Ed/91u0nklQRdOhfGDdCxHQWdjsgy7afc81haGUWa
         hRCt0MuhkIUsGxLO1xZlGsBbcn3cM4abpMr2sQbnb42mVHCNStm8FMePwmTQkmklrcL3
         vZ6n8Gtg9b6dsSnxeT1rkNqz3/UxGqUVxkzsTUnLwRMgKYC4aAvx1BvzIk4XeDBcbFFw
         lGXxR+8P7lfj5u63RAunafFF7p47dCqn/bWULcODSxyNiZ+HwQESM+s3O9/SduZM8Kxy
         5HuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KExLbRsWWdPJsnH8bWIgRX1rh2usgvEjHrntBDpiVfQ=;
        b=em2npXRvVg5nUcop8eyg6kW31NdMw5gDVPgD0vaxrEGUN4RRY54SKPAZWbx4dRcN6X
         SWpgeQQ/iU1zLQ/oSYuW1/YEu6/rv20CZY3BvgOjSz2EB9JdqOCSYIKNN2ud0gCg9d9N
         2tDYkWoiQl6AL7fawIhsfYRFc+sU71u4whBuYA4jmcBulol5vbUEG53L2fHvjH0kEPKC
         a7CQ/sYSIRhuF6wllLVkNW1XlO11Nc+g9pcYqJHTwx2XdyKBrK7cU2RngKnT/hF90js2
         7jsMfF+s+HZ7Adbjo0EgjbSqgyPEo9tlvjJk/V2xBDxTC5lCUYeZBmQ0mJ8xdg7XA7q2
         5DBg==
X-Gm-Message-State: APjAAAUXXW/hjxjBsj2grUcbtD9wTo05sD8efys+t9Fxl4A1oA9PCJxq
        clbWEXipMOT+5bJrP/Aw+Z4nYc3JAzRMJeyoQfgOSQ==
X-Google-Smtp-Source: APXvYqzGhoJpw7mxlMBhe3QOzlZ1DLZ8DVq7bG68xo8A7/FbgrR8bGCceM1K0y1gdVvTojaWCrWYtpk7WDFmxksLlJI=
X-Received: by 2002:ac5:cd4a:: with SMTP id n10mr2575096vkm.82.1569421566287;
 Wed, 25 Sep 2019 07:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <27c67867-d39e-a5c1-12aa-a1e6ba6e7c32@web.de>
In-Reply-To: <27c67867-d39e-a5c1-12aa-a1e6ba6e7c32@web.de>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 25 Sep 2019 07:25:53 -0700
Message-ID: <CAHLCerNQ4G43O0PM71V6tFSS11oxAGNJEkR0A44CCgRjWfgaag@mail.gmail.com>
Subject: Re: [PATCH] thermal: st: Use devm_platform_ioremap_resource() in st_mmap_regmap_init()
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Allison Randal <allison@lohutok.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Himanshu Jha <himanshujha199640@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 18, 2019 at 12:43 PM Markus Elfring <Markus.Elfring@web.de> wrote:
>
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 18 Sep 2019 21:32:14 +0200
>
> Simplify this function implementation by using a known wrapper function.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  drivers/thermal/st/st_thermal_memmap.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/drivers/thermal/st/st_thermal_memmap.c b/drivers/thermal/st/st_thermal_memmap.c
> index a824b78dabf8..d8ff46abd8eb 100644
> --- a/drivers/thermal/st/st_thermal_memmap.c
> +++ b/drivers/thermal/st/st_thermal_memmap.c
> @@ -121,15 +121,8 @@ static int st_mmap_regmap_init(struct st_thermal_sensor *sensor)
>  {
>         struct device *dev = sensor->dev;
>         struct platform_device *pdev = to_platform_device(dev);
> -       struct resource *res;
>
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       if (!res) {
> -               dev_err(dev, "no memory resources defined\n");
> -               return -ENODEV;
> -       }
> -
> -       sensor->mmio_base = devm_ioremap_resource(dev, res);
> +       sensor->mmio_base = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(sensor->mmio_base)) {
>                 dev_err(dev, "failed to remap IO\n");
>                 return PTR_ERR(sensor->mmio_base);
> --
> 2.23.0
>
