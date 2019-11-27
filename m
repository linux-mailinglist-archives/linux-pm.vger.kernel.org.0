Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2D7610C028
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2019 23:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfK0WYa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Nov 2019 17:24:30 -0500
Received: from vps.xff.cz ([195.181.215.36]:33888 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbfK0WYa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 27 Nov 2019 17:24:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1574893467; bh=03v6MvLb4Npw9AjFHB6zyIbUbdm8FNg3ot9ZMiWCnvw=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=SZtJFJb99qPrcwh17WvZ7KCnSMzXBjnAnvHpu7Gn3xSDHVbhUiaRVRhlTirhzYsKX
         FZGf0WqtJx2bGpPWY8QtMbI6X9uvKcrlp5LJzPW9WjyQa/bG20uXYeqqn0Y+6Xqoz1
         BjXvrmC8WC92tmr7mgjROc7CyUWoyPncd+CpV7BY=
Date:   Wed, 27 Nov 2019 23:24:27 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Frank Lee <tiny.windzz@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 1/7] thermal: sun8i: add thermal driver for
 H6/H5/H3/A64/A83T/R40
Message-ID: <20191127222427.coyeggbxs5miioxn@core.my.home>
Mail-Followup-To: Vasily Khoruzhick <anarsoul@gmail.com>,
        Frank Lee <tiny.windzz@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20191127052935.1719897-1-anarsoul@gmail.com>
 <20191127052935.1719897-2-anarsoul@gmail.com>
 <20191127111419.z5hfu5soxceiivg6@core.my.home>
 <20191127173547.ch3pcv3lxgdcrfnu@gilmour.lan>
 <CAEExFWvG-Af4qtUrxQV4ssNQCVQAmpXfxB+92wX+6ZxUNfX-Jw@mail.gmail.com>
 <CA+E=qVcdwQO3Y8ismmBN-gRVNMs1Thx+TPLqstKM9fYf2_0qFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+E=qVcdwQO3Y8ismmBN-gRVNMs1Thx+TPLqstKM9fYf2_0qFQ@mail.gmail.com>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 27, 2019 at 11:48:32AM -0800, Vasily Khoruzhick wrote:
> On Wed, Nov 27, 2019 at 11:44 AM Frank Lee <tiny.windzz@gmail.com> wrote:
> >
> > Hello Vasily,
> >
> > Thank you very much for your work on this.
> > This looks good to me.
> 
> Thanks!
> 
> > By the way, I would like to ask comments about adding the following code.
> 
> Can we add it as follow up patch? I don't think that I have a device
> with working suspend to test it and I'm hesitant to add any code that
> I can't test.

I have, but it doesn't use any of the clocks and resets, so it wouldn't
test this fully, and basicaly doesn't need re-calibration at all, probably.

So that may be one feedback. On a83t, I'd made these callbacks a no-op.

regards,
	o.

> >
> > diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
> > index c0ed60782b11..579dde5e0701 100644
> > --- a/drivers/thermal/sun8i_thermal.c
> > +++ b/drivers/thermal/sun8i_thermal.c
> > @@ -629,11 +629,63 @@ static const struct of_device_id of_ths_match[] = {
> >  };
> >  MODULE_DEVICE_TABLE(of, of_ths_match);
> >
> > +static int __maybe_unused sun8i_thermal_suspend(struct device *dev)
> > +{
> > + struct ths_device *tmdev; = dev_get_drvdata(dev);
> > +
> > + clk_disable(tmdev->mod_clk);
> > + clk_disable(tmdev->bus_clk);
> > +
> > + reset_control_assert(tmdev->reset);
> > +
> > + return 0;
> > +}
> > +
> > +static int __maybe_unused sun8i_thermal_resume(struct device *dev)
> > +{
> > + struct ths_device *tmdev; = dev_get_drvdata(dev);
> > + int error;
> > +
> > + error = reset_control_deassert(tmdev->reset);
> > + if (error)
> > + return error;
> > +
> > + error = clk_enable(tmdev->bus_clk);
> > + if (error)
> > + goto assert_reset;
> > +
> > + clk_set_rate(tmdev->mod_clk, 24000000);
> > + error = clk_enable(tmdev->mod_clk);
> > + if (error)
> > + goto bus_disable;
> > +
> > + sun8i_ths_calibrate(tmdev);
> > +
> > + ret = tmdev->chip->init(tmdev);
> > + if (ret)
> > + goto mod_disable;
> > +
> > + return 0;
> > +
> > +mod_disable:
> > + clk_disable(tmdev->mod_clk);
> > +bus_disable:
> > + clk_disable(tmdev->bus_clk);
> > +assert_reset:
> > + reset_control_assert(tmdev->reset);
> > +
> > + return 0;
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(sun8i_thermal_pm_ops,
> > + sun8i_thermal_suspend, sun8i_thermal_resume);
> > +
> >  static struct platform_driver ths_driver = {
> >   .probe = sun8i_ths_probe,
> >   .remove = sun8i_ths_remove,
> >   .driver = {
> >   .name = "sun8i-thermal",
> > + .pm = &sun8i_thermal_pm_ops,
> >   .of_match_table = of_ths_match,
> >   },
> >  };
> >
> > Yangtao
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
