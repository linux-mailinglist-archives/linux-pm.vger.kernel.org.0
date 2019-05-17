Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95FEA2148D
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2019 09:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbfEQHgt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 May 2019 03:36:49 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:55927 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727500AbfEQHgs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 May 2019 03:36:48 -0400
X-Originating-IP: 80.215.154.25
Received: from localhost (unknown [80.215.154.25])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 93CA424000E;
        Fri, 17 May 2019 07:36:35 +0000 (UTC)
Date:   Fri, 17 May 2019 09:36:34 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     rui.zhang@intel.com, Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, robh+dt@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
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
        enric.balletbo@collabora.com, Linux PM <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] thermal: sun50i: add thermal driver for h6
Message-ID: <20190517073634.izdmba3yqvxviyg3@flea>
References: <20190512082614.9045-1-tiny.windzz@gmail.com>
 <20190512082614.9045-3-tiny.windzz@gmail.com>
 <20190512133930.t5txssl7mou2gljt@flea>
 <CAEExFWvcMbiCJ4HD0UAtv1P6AuBJ=oUdmhu886BNZhrRz483Ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k3cws7k6b2j4fvaj"
Content-Disposition: inline
In-Reply-To: <CAEExFWvcMbiCJ4HD0UAtv1P6AuBJ=oUdmhu886BNZhrRz483Ug@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--k3cws7k6b2j4fvaj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 17, 2019 at 01:51:56AM +0800, Frank Lee wrote:
> > > +struct sun50i_thermal_chip {
> > > +     int     sensor_num;
> > > +     int     offset;
> > > +     int     scale;
> > > +     int     ft_deviation;
> > > +     int     temp_calib_base;
> > > +     int     temp_data_base;
> > > +     int     (*enable)(struct tsens_device *tmdev);
> > > +     int     (*disable)(struct tsens_device *tmdev);
> > > +};
> >
> > I'm not super fond of having a lot of quirks that are not needed. If
> > we ever need those quirks when adding support for a new SoC, then
> > yeah, we should totally have some, but only when and if it's needed.
> >
> > Otherwise, the driver is more complicated for no particular reason.
>
> This is unavoidable because of the difference in soc.

I know, but this isn't my point.

My point is that at this time of the driver development, we don't know
what is going to be needed to support all of those SoCs.

Some of the parameters you added might not be needed, some parameters
might be missing, we don't know. So let's keep it simple for now.

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
> > > +
> > > +     ret = tmdev->chip->enable(tmdev);
> > > +     if (ret)
> > > +             return ret;
> > >
> > > +     platform_set_drvdata(pdev, tmdev);
> >
> > Your registration should be the very last thing you do. Otherwise, you
> > have a small window where the get_temp callback can be called, but the
> > driver will not be functional yet.
>
> No. Anyway, ths data qcquisition is ms level.

That's kind of irrelevant. There's nothing preventing get_temp to be
called right away.

> > > +     ret = tsens_calibrate(tmdev);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     /*
> > > +      * clkin = 24MHz
> > > +      * T acquire = clkin / (SUN50I_THS_CTRL0_T_ACQ + 1)
> > > +      *           = 20us
> > > +      */
> > > +     regmap_write(tmdev->regmap, SUN50I_THS_CTRL0,
> > > +                  SUN50I_THS_CTRL0_T_ACQ(479));
> > > +     /* average over 4 samples */
> > > +     regmap_write(tmdev->regmap, SUN50I_H6_THS_MFC,
> > > +                  SUN50I_THS_FILTER_EN |
> > > +                  SUN50I_THS_FILTER_TYPE(1));
> > > +     /* period = (SUN50I_H6_THS_PC_TEMP_PERIOD + 1) * 4096 / clkin; ~10ms */
> > > +     regmap_write(tmdev->regmap, SUN50I_H6_THS_PC,
> > > +                  SUN50I_H6_THS_PC_TEMP_PERIOD(58));
> > > +     /* enable sensor */
> > > +     val = GENMASK(tmdev->chip->sensor_num - 1, 0);
> > > +     regmap_write(tmdev->regmap, SUN50I_H6_THS_ENABLE, val);
> > > +
> > > +     return 0;
> > > +
> > > +assert_reset:
> > > +     reset_control_assert(tmdev->reset);
> > > +
> > > +     return ret;
> >
> > Can't we do that with runtime_pm?
>
> Saving energy doesn't make much sense compared to system security.

I'm not sure what you mean by security.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--k3cws7k6b2j4fvaj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXN5kggAKCRDj7w1vZxhR
xSjEAP0ROb9O13AokItNEnWe0Lv3GDFB7l31wQEb3cxsP3Vh7QEAr1e8+X/0WwOo
AWNOgr6T4osFIe+fzrg7yYJbVXsPogc=
=AWAL
-----END PGP SIGNATURE-----

--k3cws7k6b2j4fvaj--
