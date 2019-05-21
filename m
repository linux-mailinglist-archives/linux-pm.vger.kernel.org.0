Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2821B24C9C
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2019 12:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfEUK1Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 May 2019 06:27:25 -0400
Received: from vps.xff.cz ([195.181.215.36]:38106 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbfEUK1Z (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 21 May 2019 06:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1558434441; bh=H6MrKqqtdax1I2XXyrIgpDdBNiCoz5e/dUQ3W4MknQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m29HCqX2SN+8L1d5/7f5EvQHqPXlEn9XXs31rwizmVmEdBITHL/a3TU6OMvTBHDcw
         yUjXEsxaziEiajsSIS0H84WyhAC2+H0eBJWcb+jZqN2avYXfv90LK3Q1e+1qfkVgAJ
         uJODrBg6bk4nHXnynQwSIMwDEaWMaD5TL+M7adhA=
Date:   Tue, 21 May 2019 12:27:21 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Frank Lee <tiny.windzz@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        catalin.marinas@arm.com, will.deacon@arm.com,
        bjorn.andersson@linaro.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        paulmck@linux.ibm.com, stefan.wahren@i2se.com,
        Linux PM <linux-pm@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andy Gross <andy.gross@linaro.org>, rui.zhang@intel.com,
        devicetree@vger.kernel.org, marc.w.gonzalez@free.fr,
        Eduardo Valentin <edubezval@gmail.com>,
        enric.balletbo@collabora.com, robh+dt@kernel.org,
        Jonathan.Cameron@huawei.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        olof@lixom.net, David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/3] thermal: sun50i: add thermal driver for h6
Message-ID: <20190521102721.5hgks6guzlhubj6d@core.my.home>
Mail-Followup-To: Maxime Ripard <maxime.ripard@bootlin.com>,
        Frank Lee <tiny.windzz@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, catalin.marinas@arm.com,
        will.deacon@arm.com, bjorn.andersson@linaro.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        paulmck@linux.ibm.com, stefan.wahren@i2se.com,
        Linux PM <linux-pm@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andy Gross <andy.gross@linaro.org>, rui.zhang@intel.com,
        devicetree@vger.kernel.org, marc.w.gonzalez@free.fr,
        Eduardo Valentin <edubezval@gmail.com>,
        enric.balletbo@collabora.com, robh+dt@kernel.org,
        Jonathan.Cameron@huawei.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        olof@lixom.net, David Miller <davem@davemloft.net>
References: <20190512082614.9045-1-tiny.windzz@gmail.com>
 <20190512082614.9045-3-tiny.windzz@gmail.com>
 <20190512133930.t5txssl7mou2gljt@flea>
 <CAEExFWvcMbiCJ4HD0UAtv1P6AuBJ=oUdmhu886BNZhrRz483Ug@mail.gmail.com>
 <20190517073634.izdmba3yqvxviyg3@flea>
 <CAEExFWtNhTqLR+v3o6vn0Y4L65i_XsrEeiex6DNLEPEkhseCjA@mail.gmail.com>
 <20190521080515.qlni2lnmcwh7itl7@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190521080515.qlni2lnmcwh7itl7@flea>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Maxime,

On Tue, May 21, 2019 at 10:05:15AM +0200, Maxime Ripard wrote:
> On Sat, May 18, 2019 at 01:27:39AM +0800, Frank Lee wrote:
> > On Fri, May 17, 2019 at 3:36 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Fri, May 17, 2019 at 01:51:56AM +0800, Frank Lee wrote:
> > > > > > +struct sun50i_thermal_chip {
> > > > > > +     int     sensor_num;
> > > > > > +     int     offset;
> > > > > > +     int     scale;
> > > > > > +     int     ft_deviation;
> > > > > > +     int     temp_calib_base;
> > > > > > +     int     temp_data_base;
> > > > > > +     int     (*enable)(struct tsens_device *tmdev);
> > > > > > +     int     (*disable)(struct tsens_device *tmdev);
> > > > > > +};
> > > > >
> > > > > I'm not super fond of having a lot of quirks that are not needed. If
> > > > > we ever need those quirks when adding support for a new SoC, then
> > > > > yeah, we should totally have some, but only when and if it's needed.
> > > > >
> > > > > Otherwise, the driver is more complicated for no particular reason.
> > > >
> > > > This is unavoidable because of the difference in soc.
> > >
> > > I know, but this isn't my point.
> > >
> > > My point is that at this time of the driver development, we don't know
> > > what is going to be needed to support all of those SoCs.
> > >
> > > Some of the parameters you added might not be needed, some parameters
> > > might be missing, we don't know. So let's keep it simple for now.
> > >
> > > > > > +static int tsens_probe(struct platform_device *pdev)
> > > > > > +{
> > > > > > +     struct tsens_device *tmdev;
> > > > > > +     struct device *dev = &pdev->dev;
> > > > > > +     int ret;
> > > > > > +
> > > > > > +     tmdev = devm_kzalloc(dev, sizeof(*tmdev), GFP_KERNEL);
> > > > > > +     if (!tmdev)
> > > > > > +             return -ENOMEM;
> > > > > > +
> > > > > > +     tmdev->dev = dev;
> > > > > > +     tmdev->chip = of_device_get_match_data(&pdev->dev);
> > > > > > +     if (!tmdev->chip)
> > > > > > +             return -EINVAL;
> > > > > > +
> > > > > > +     ret = tsens_init(tmdev);
> > > > > > +     if (ret)
> > > > > > +             return ret;
> > > > > > +
> > > > > > +     ret = tsens_register(tmdev);
> > > > > > +     if (ret)
> > > > > > +             return ret;
> > > > > > +
> > > > > > +     ret = tmdev->chip->enable(tmdev);
> > > > > > +     if (ret)
> > > > > > +             return ret;
> > > > > >
> > > > > > +     platform_set_drvdata(pdev, tmdev);
> > > > >
> > > > > Your registration should be the very last thing you do. Otherwise, you
> > > > > have a small window where the get_temp callback can be called, but the
> > > > > driver will not be functional yet.
> > > >
> > > > No. Anyway, ths data qcquisition is ms level.
> > >
> > > That's kind of irrelevant. There's nothing preventing get_temp to be
> > > called right away.
> >
> > As Ondřej said,
> >
> > Registration after enabling will lead to call tz update on non-registered tz
> > from an interrupt handler.
> 
> I'm probably missing something but you're not using the interrupts, so
> how could an interrupt handler call it?
> 
> Also, other drivers seem to be doing that just fine (mtk_thermal for
> example), so surely there's a way?

Last version is using the interrupts.

Drivers do it in various ways. For example imx_thermal (and others like
hisi_thermal) does it the suggested way. It enables interrupts after thermal
zone registration, so that IRQ handler doesn't get invoked before the tzd is
registered.

regards,
	o.

> > > > > > +     ret = tsens_calibrate(tmdev);
> > > > > > +     if (ret)
> > > > > > +             return ret;
> > > > > > +
> > > > > > +     /*
> > > > > > +      * clkin = 24MHz
> > > > > > +      * T acquire = clkin / (SUN50I_THS_CTRL0_T_ACQ + 1)
> > > > > > +      *           = 20us
> > > > > > +      */
> > > > > > +     regmap_write(tmdev->regmap, SUN50I_THS_CTRL0,
> > > > > > +                  SUN50I_THS_CTRL0_T_ACQ(479));
> > > > > > +     /* average over 4 samples */
> > > > > > +     regmap_write(tmdev->regmap, SUN50I_H6_THS_MFC,
> > > > > > +                  SUN50I_THS_FILTER_EN |
> > > > > > +                  SUN50I_THS_FILTER_TYPE(1));
> > > > > > +     /* period = (SUN50I_H6_THS_PC_TEMP_PERIOD + 1) * 4096 / clkin; ~10ms */
> > > > > > +     regmap_write(tmdev->regmap, SUN50I_H6_THS_PC,
> > > > > > +                  SUN50I_H6_THS_PC_TEMP_PERIOD(58));
> > > > > > +     /* enable sensor */
> > > > > > +     val = GENMASK(tmdev->chip->sensor_num - 1, 0);
> > > > > > +     regmap_write(tmdev->regmap, SUN50I_H6_THS_ENABLE, val);
> > > > > > +
> > > > > > +     return 0;
> > > > > > +
> > > > > > +assert_reset:
> > > > > > +     reset_control_assert(tmdev->reset);
> > > > > > +
> > > > > > +     return ret;
> > > > >
> > > > > Can't we do that with runtime_pm?
> > > >
> > > > Saving energy doesn't make much sense compared to system security.
> > >
> > > I'm not sure what you mean by security.
> >
> > Protect system hardware from damage.
> 
> The point of runtime_pm is to keep the device on as long as it is
> used, so it wouldn't change anything there.
> 
> I mean, you can even enable it in the probe if you want, my point is
> that the hooks that you have are exact equivalents to the one provided
> by runtime_pm already, so there's no need to define them in the first
> place.
> 
> Maxime
> 
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com



> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

