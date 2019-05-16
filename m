Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 470D320EA7
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2019 20:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfEPS3j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 May 2019 14:29:39 -0400
Received: from vps.xff.cz ([195.181.215.36]:38730 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726357AbfEPS3j (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 May 2019 14:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1558031376; bh=+nSXq6K8D525DqumN8hX/hXw6BuzgBYTSZ5zpX1yqMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DvT1vnFG1JzohjaD6Ipxouz0agYvhmjyLA4av1glnZElsR6SKmCs24cQ3jDKBcXeY
         EiTHL44Sla99BoABrvWO89x5ew6seLkkze3Xo+O1l3rl+9VkiFIC86sMICKadMHXsh
         3qL1H4pV+dSAgYzGYTsYIn3r79CJOpqw9CKrUunI=
Date:   Thu, 16 May 2019 20:29:36 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     rui.zhang@intel.com, Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, robh+dt@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, catalin.marinas@arm.com,
        will.deacon@arm.com, David Miller <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan.Cameron@huawei.com,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        paulmck@linux.ibm.com, Andy Gross <andy.gross@linaro.org>,
        olof@lixom.net, bjorn.andersson@linaro.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        marc.w.gonzalez@free.fr, stefan.wahren@i2se.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 2/3] thermal: sun50i: add thermal driver for h6
Message-ID: <20190516182936.h6xdzp3gtg4ikave@core.my.home>
Mail-Followup-To: Frank Lee <tiny.windzz@gmail.com>, rui.zhang@intel.com,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, robh+dt@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, catalin.marinas@arm.com,
        will.deacon@arm.com, David Miller <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan.Cameron@huawei.com,
        Nicolas Ferre <nicolas.ferre@microchip.com>, paulmck@linux.ibm.com,
        Andy Gross <andy.gross@linaro.org>, olof@lixom.net,
        bjorn.andersson@linaro.org, Jagan Teki <jagan@amarulasolutions.com>,
        marc.w.gonzalez@free.fr, stefan.wahren@i2se.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20190512082614.9045-1-tiny.windzz@gmail.com>
 <20190512082614.9045-3-tiny.windzz@gmail.com>
 <20190512221612.ubmknvim4utnqpl4@core.my.home>
 <CAEExFWv5A5mhpV7afQT=AaYx2ko5QnfbM6HvfuTgT1Na=ssOcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEExFWv5A5mhpV7afQT=AaYx2ko5QnfbM6HvfuTgT1Na=ssOcw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Yangtao,

thank you for work on this driver.

On Fri, May 17, 2019 at 02:06:53AM +0800, Frank Lee wrote:
> HI Ondřej,
> 
> On Mon, May 13, 2019 at 6:16 AM Ondřej Jirman <megous@megous.com> wrote:
> > > +
> > > +/* Temp Unit: millidegree Celsius */
> > > +static int tsens_reg2temp(struct tsens_device *tmdev,
> > > +                           int reg)
> >
> > Please name all functions so that they are more clearly identifiable
> > in stack traces as belonging to this driver. For example:
> >
> >   sun8i_ths_reg2temp
> >
> > The same applies for all tsens_* functions below. tsens_* is too
> > generic.
> 
> Done but no sun8i_ths_reg2temp.
> 
> ths_reg2tem() should be a generic func.
> I think it should be suitable for all platforms， so no platform prefix.

You've missed my point. The driver name is sun8i_thermal and if you get
and oops from the kernel you'll get a stack trace where there are just function
names. If you use too generic function names, it will not be clear which
driver is oopsing.

  - sun8i_ths_reg2temp will tell you much more clearly where to search than
  - ths_reg2temp

Of course you can always grep, but most thermal drivers are thermal sensor (ths)
drivers, and if multiple of them used this too-generic naming scheme you'd
have hard time debugging.

Look at other thermal drivers. They usually encode driver name in the function
names to help with identification (even if these are static driver-local
functions).

> > > +static int tsens_probe(struct platform_device *pdev)
> > > +{
> > > +     struct tsens_device *tmdev;
> > > +     struct device *dev = &pdev->dev;
> > > +     int ret;
> > > +
> > > +     tmdev = devm_kzalloc(dev, sizeof(*tmdev), GFP_KERNEL);
> > > +     if (!tmdev)
> > > +             return -ENOMEM;
> > > +
> > > +     tmdev->dev = dev;
> > > +     tmdev->chip = of_device_get_match_data(&pdev->dev);
> > > +     if (!tmdev->chip)
> > > +             return -EINVAL;
> > > +
> > > +     ret = tsens_init(tmdev);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     ret = tsens_register(tmdev);
> > > +     if (ret)
> > > +             return ret;
> >
> > Why split this out of probe into separate functions?
> >
> > > +     ret = tmdev->chip->enable(tmdev);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     platform_set_drvdata(pdev, tmdev);
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +static int tsens_remove(struct platform_device *pdev)
> > > +{
> > > +     struct tsens_device *tmdev = platform_get_drvdata(pdev);
> > > +
> > > +     tmdev->chip->disable(tmdev);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int sun50i_thermal_enable(struct tsens_device *tmdev)
> > > +{
> > > +     int ret, val;
> > > +
> > > +     ret = reset_control_deassert(tmdev->reset);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     ret = clk_prepare_enable(tmdev->bus_clk);
> > > +     if (ret)
> > > +             goto assert_reset;
> > > +
> > > +     ret = tsens_calibrate(tmdev);
> > > +     if (ret)
> > > +             return ret;
> >
> > If this fails (it may likely fail with EPROBE_DEFER) you are leaving reset
> > deasserted, and clock enabled.
> >
> > Overall, I think, reset/clock management and nvmem reading will be common
> > to all the HW variants, so it doesn't make much sense splitting it out
> > of probe into separate functions, and makes it more error prone.
> 
> Our long-term goal is to support all platforms.
> Bacicallt there is a differencr between each generation.
> So I feel it necessary to isolate these differences.
> 
> Maybe:
> At some point, we can draw a part of the public part and platform
> difference into different
> files. something like qcom thermal driver.

I understand, but I wrote ths drivers for H3/H5/A83T and it so far it looks like
all of them would share these 3 calls.

You'll be enabling clock/reset and callibrating everywhere. So putting this to
per-SoC function seems premature.

thank you and regards,
	o.

> Regards,
> Yangtao
