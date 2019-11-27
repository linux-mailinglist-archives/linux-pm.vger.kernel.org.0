Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A30D10B706
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2019 20:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfK0TtA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Nov 2019 14:49:00 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34237 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbfK0Ts7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Nov 2019 14:48:59 -0500
Received: by mail-oi1-f196.google.com with SMTP id l136so5577367oig.1;
        Wed, 27 Nov 2019 11:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hJQOsjHUQwGyDgldLtvmDQQC956sPZlhFuJn6q/Fye4=;
        b=UHQm3Z4sQErDpbdcFsI5LZbvUBE5BhMXUdsIzb7O41xb6Fspwq2A1/BPVDQTjXSLdr
         ikEI2AYLU+Ctu05Qf5u6bYWG5Lv63zshN411Mdsn1W+4fPFdDgMahME+EZCOJoU1CwJE
         35v5Ycykph2Hq7xeEUKlTOBl/6E7kGL1nu5zSgrq7Xb8TN+sHbdlAw19oDeYA+AjLBgT
         uqu17Y9ld56yXwu9aHlpdmiTJDgzKXhhd9fayPZmR2GSNicg68x2CeUBNU6BukSF4B2/
         Uwsg1kCy2nPtULkc6eJeqq+y+2aHS3iyXlg2wQC2DR7fcJBxqjd2FJ5aYi/hj+VnLm4B
         SzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hJQOsjHUQwGyDgldLtvmDQQC956sPZlhFuJn6q/Fye4=;
        b=QaHD+RerXlEbPYM4n6A8VwJ9OZVVK/RhJt+DqGmML2sko89/4xWurfwlDEMT2oUFE3
         xYc5fX8hGfsP4IVIShKsvHQuj6sE+2Ox8nAu1Ap8GW744nGnEv6nz6uANZYBy+0piLDU
         +dDpy29jjPaSXHOFrAJ08PpRiggBdUpmHnhOOvqTu0aAiM/iasroqgL1memOTLt6h8fV
         Kb1n6aMcR4d37sVe7ylkNSim1hOI9fRrZbquZGYKOYtLnpbzLI9+V0T0i9v45iwn4ETF
         gdPdWtugEKZvtOT16dxlWrnfXXNTteIyY7y9xePEZLCVnGf9VKpIblOMZBmOnhwc78Cx
         5K2Q==
X-Gm-Message-State: APjAAAX+HR+/5qD/3xjvBwuQOSXccxsSz8xuDOAW2a6x5jXdd2WIR1qk
        rXBlG6wDRkXH63z/o19SBtEe0aLVMrw3xOmluwg=
X-Google-Smtp-Source: APXvYqyED1U8iGKLv5Q8myGQWskAymaEmPDOweek/ULUMOk2izeVMnMgtOcUrHFsfo71UXovu5AJlOMgACDpkBnTwd4=
X-Received: by 2002:aca:5e03:: with SMTP id s3mr5733588oib.88.1574884137631;
 Wed, 27 Nov 2019 11:48:57 -0800 (PST)
MIME-Version: 1.0
References: <20191127052935.1719897-1-anarsoul@gmail.com> <20191127052935.1719897-2-anarsoul@gmail.com>
 <20191127111419.z5hfu5soxceiivg6@core.my.home> <20191127173547.ch3pcv3lxgdcrfnu@gilmour.lan>
 <CAEExFWvG-Af4qtUrxQV4ssNQCVQAmpXfxB+92wX+6ZxUNfX-Jw@mail.gmail.com>
In-Reply-To: <CAEExFWvG-Af4qtUrxQV4ssNQCVQAmpXfxB+92wX+6ZxUNfX-Jw@mail.gmail.com>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Wed, 27 Nov 2019 11:48:32 -0800
Message-ID: <CA+E=qVcdwQO3Y8ismmBN-gRVNMs1Thx+TPLqstKM9fYf2_0qFQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/7] thermal: sun8i: add thermal driver for H6/H5/H3/A64/A83T/R40
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 27, 2019 at 11:44 AM Frank Lee <tiny.windzz@gmail.com> wrote:
>
> Hello Vasily,
>
> Thank you very much for your work on this.
> This looks good to me.

Thanks!

> By the way, I would like to ask comments about adding the following code.

Can we add it as follow up patch? I don't think that I have a device
with working suspend to test it and I'm hesitant to add any code that
I can't test.

>
> diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
> index c0ed60782b11..579dde5e0701 100644
> --- a/drivers/thermal/sun8i_thermal.c
> +++ b/drivers/thermal/sun8i_thermal.c
> @@ -629,11 +629,63 @@ static const struct of_device_id of_ths_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, of_ths_match);
>
> +static int __maybe_unused sun8i_thermal_suspend(struct device *dev)
> +{
> + struct ths_device *tmdev; = dev_get_drvdata(dev);
> +
> + clk_disable(tmdev->mod_clk);
> + clk_disable(tmdev->bus_clk);
> +
> + reset_control_assert(tmdev->reset);
> +
> + return 0;
> +}
> +
> +static int __maybe_unused sun8i_thermal_resume(struct device *dev)
> +{
> + struct ths_device *tmdev; = dev_get_drvdata(dev);
> + int error;
> +
> + error = reset_control_deassert(tmdev->reset);
> + if (error)
> + return error;
> +
> + error = clk_enable(tmdev->bus_clk);
> + if (error)
> + goto assert_reset;
> +
> + clk_set_rate(tmdev->mod_clk, 24000000);
> + error = clk_enable(tmdev->mod_clk);
> + if (error)
> + goto bus_disable;
> +
> + sun8i_ths_calibrate(tmdev);
> +
> + ret = tmdev->chip->init(tmdev);
> + if (ret)
> + goto mod_disable;
> +
> + return 0;
> +
> +mod_disable:
> + clk_disable(tmdev->mod_clk);
> +bus_disable:
> + clk_disable(tmdev->bus_clk);
> +assert_reset:
> + reset_control_assert(tmdev->reset);
> +
> + return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(sun8i_thermal_pm_ops,
> + sun8i_thermal_suspend, sun8i_thermal_resume);
> +
>  static struct platform_driver ths_driver = {
>   .probe = sun8i_ths_probe,
>   .remove = sun8i_ths_remove,
>   .driver = {
>   .name = "sun8i-thermal",
> + .pm = &sun8i_thermal_pm_ops,
>   .of_match_table = of_ths_match,
>   },
>  };
>
> Yangtao
