Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8CD2188DE
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jul 2020 15:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgGHNV2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jul 2020 09:21:28 -0400
Received: from vps.xff.cz ([195.181.215.36]:51474 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729147AbgGHNV2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Jul 2020 09:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1594214485; bh=U0WR2nFkpJx01kvx97N0svEG1PoUvQLse/Iz6UEIF6o=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=Yc33ukwUgxe3p/96KYESmRhcx5gU501uy7YW/oh+rAfvjilZRBXvapbETWR/8CTfu
         qWlEM2h9+rYSdSCB9HuS5hck5XGd/fbmPrC6/YWALp6YS7uS3NSJPUqkmKi/Qz29vH
         MyM/a3yOixCKCaHURD2NS2gr5gGI2NmflX2frvXE=
Date:   Wed, 8 Jul 2020 15:21:24 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     linux-sunxi@googlegroups.com,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:ALLWINNER THERMAL DRIVER" <linux-pm@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] thermal: sun8i: Be loud when probe fails
Message-ID: <20200708132124.3b3iaavms43o622g@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Frank Lee <tiny.windzz@gmail.com>, linux-sunxi@googlegroups.com,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        "open list:ALLWINNER THERMAL DRIVER" <linux-pm@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200708105527.868987-1-megous@megous.com>
 <CAEExFWvR4QnAQsXBnxk3V776P+YVJzs4PU-HWJ7dfo4B6cdtkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEExFWvR4QnAQsXBnxk3V776P+YVJzs4PU-HWJ7dfo4B6cdtkg@mail.gmail.com>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 08, 2020 at 07:55:40PM +0800, Frank Lee wrote:
> HI Ondrej,
> On Wed, Jul 8, 2020 at 6:55 PM Ondrej Jirman <megous@megous.com> wrote:
> >
> > I noticed several mobile Linux distributions failing to enable the
> > thermal regulation correctly, because the kernel is silent
> > when thermal driver fails to probe. Add enough error reporting
> > to debug issues and warn users in case thermal sensor is failing
> > to probe.
> >
> > Failing to notify users means, that SoC can easily overheat under
> > load.
> >
> > Signed-off-by: Ondrej Jirman <megous@megous.com>
> > ---
> >  drivers/thermal/sun8i_thermal.c | 55 ++++++++++++++++++++++++++-------
> >  1 file changed, 43 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
> > index 74d73be16496..9065e79ae743 100644
> > --- a/drivers/thermal/sun8i_thermal.c
> > +++ b/drivers/thermal/sun8i_thermal.c
> > @@ -287,8 +287,12 @@ static int sun8i_ths_calibrate(struct ths_device *tmdev)
> >
> >         calcell = devm_nvmem_cell_get(dev, "calibration");
> >         if (IS_ERR(calcell)) {
> > +               dev_err(dev, "Failed to get calibration nvmem cell (%ld)\n",
> > +                       PTR_ERR(calcell));
> > +
> >                 if (PTR_ERR(calcell) == -EPROBE_DEFER)
> >                         return -EPROBE_DEFER;
> > +
> >                 /*
> >                  * Even if the external calibration data stored in sid is
> >                  * not accessible, the THS hardware can still work, although
> > @@ -308,6 +312,8 @@ static int sun8i_ths_calibrate(struct ths_device *tmdev)
> >         caldata = nvmem_cell_read(calcell, &callen);
> >         if (IS_ERR(caldata)) {
> >                 ret = PTR_ERR(caldata);
> > +               dev_err(dev, "Failed to read calibration data (%d)\n",
> > +                       ret);
> >                 goto out;
> >         }
> >
> > @@ -330,23 +336,35 @@ static int sun8i_ths_resource_init(struct ths_device *tmdev)
> >                 return PTR_ERR(base);
> >
> >         tmdev->regmap = devm_regmap_init_mmio(dev, base, &config);
> > -       if (IS_ERR(tmdev->regmap))
> > +       if (IS_ERR(tmdev->regmap)) {
> > +               dev_err(dev, "Failed to init regmap (%ld)\n",
> > +                       PTR_ERR(tmdev->regmap));
> >                 return PTR_ERR(tmdev->regmap);
> > +       }
> >
> >         if (tmdev->chip->has_bus_clk_reset) {
> >                 tmdev->reset = devm_reset_control_get(dev, NULL);
> > -               if (IS_ERR(tmdev->reset))
> > +               if (IS_ERR(tmdev->reset)) {
> > +                       dev_err(dev, "Failed to get reset (%ld)\n",
> > +                               PTR_ERR(tmdev->reset));
> >                         return PTR_ERR(tmdev->reset);
> > +               }
> >
> >                 tmdev->bus_clk = devm_clk_get(&pdev->dev, "bus");
> > -               if (IS_ERR(tmdev->bus_clk))
> > +               if (IS_ERR(tmdev->bus_clk)) {
> > +                       dev_err(dev, "Failed to get bus clock (%ld)\n",
> > +                               PTR_ERR(tmdev->bus_clk));
> >                         return PTR_ERR(tmdev->bus_clk);
> > +               }
> >         }
> >
> >         if (tmdev->chip->has_mod_clk) {
> >                 tmdev->mod_clk = devm_clk_get(&pdev->dev, "mod");
> > -               if (IS_ERR(tmdev->mod_clk))
> > +               if (IS_ERR(tmdev->mod_clk)) {
> > +                       dev_err(dev, "Failed to get mod clock (%ld)\n",
> > +                               PTR_ERR(tmdev->mod_clk));
> >                         return PTR_ERR(tmdev->mod_clk);
> > +               }
> >         }
> >
> >         ret = reset_control_deassert(tmdev->reset);
> > @@ -471,8 +489,12 @@ static int sun8i_ths_register(struct ths_device *tmdev)
> >                                                              i,
> >                                                              &tmdev->sensor[i],
> >                                                              &ths_ops);
> > -               if (IS_ERR(tmdev->sensor[i].tzd))
> > +               if (IS_ERR(tmdev->sensor[i].tzd)) {
> > +                       dev_err(tmdev->dev,
> > +                               "Failed to register sensor %d (%ld)\n",
> > +                               i, PTR_ERR(tmdev->sensor[i].tzd));
> >                         return PTR_ERR(tmdev->sensor[i].tzd);
> > +               }
> >
> >                 if (devm_thermal_add_hwmon_sysfs(tmdev->sensor[i].tzd))
> >                         dev_warn(tmdev->dev,
> > @@ -501,19 +523,21 @@ static int sun8i_ths_probe(struct platform_device *pdev)
> >
> >         ret = sun8i_ths_resource_init(tmdev);
> >         if (ret)
> > -               return ret;
> > +               goto err_out;
> >
> >         irq = platform_get_irq(pdev, 0);
> > -       if (irq < 0)
> > -               return irq;
> > +       if (irq < 0) {
> > +               ret = irq;
> > +               goto err_out;
> > +       }
> >
> >         ret = tmdev->chip->init(tmdev);
> >         if (ret)
> > -               return ret;
> > +               goto err_out;
> >
> >         ret = sun8i_ths_register(tmdev);
> >         if (ret)
> > -               return ret;
> > +               goto err_out;
> >
> >         /*
> >          * Avoid entering the interrupt handler, the thermal device is not
> > @@ -523,10 +547,17 @@ static int sun8i_ths_probe(struct platform_device *pdev)
> >         ret = devm_request_threaded_irq(dev, irq, NULL,
> >                                         sun8i_irq_thread,
> >                                         IRQF_ONESHOT, "ths", tmdev);
> > -       if (ret)
> > -               return ret;
> > +       if (ret) {
> > +               dev_err(dev, "Failed to request irq (%d)\n", ret);
> > +               goto err_out;
> > +       }
> >
> > +       dev_info(dev, "Thermal sensor ready!\n");
> >         return 0;
> > +
> > +err_out:
> > +       dev_err(dev, "Failed to probe thermal sensor (%d)\n", ret);
> 
> When the driver fails, there will be this print. Isn't it superfluous
> for you to add these？
> 
> sun8i-thermal: probe of 5070400.thermal-sensor failed with error

There's no such failure message in the case I investigated, which is
EPROBE_DEFER failure waiting for nvmem driver that never loads,
because it's not configured by the user to build.

regards,
	o.

> 
> Yangtao
