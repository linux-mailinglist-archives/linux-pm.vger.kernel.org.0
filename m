Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC588C1CB
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2019 22:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfHMUG1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Aug 2019 16:06:27 -0400
Received: from vps.xff.cz ([195.181.215.36]:57938 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbfHMUG1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 13 Aug 2019 16:06:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1565726784; bh=BJj4IKkIVoRjnCmUwYtLOi3KBn/hCwT44LH7rC3kdoM=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=E3Pt3KdLd9W8HHq139AvIwYXOeG0lTAHVvI2JcIzZ1HZ915O+TzrXrcXhszIYQiUf
         uL64qv/She2OnBWhhScfJWgnm/L6Rbj4BNLcLnR4AaHzhUkA3fdth+dcQo2e0fJFGh
         BH/DXYmITMyqoSUb2Ghke0tTeWnHpqBU6p6VzpZk=
Date:   Tue, 13 Aug 2019 22:06:23 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Frank Lee <tiny.windzz@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Jonathan.Cameron@huawei.com,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        rui.zhang@intel.com, "David S. Miller" <davem@davemloft.net>,
        arm-linux <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 08/18] thermal: sun8i: support mod clocks
Message-ID: <20190813200623.2dmxcwibuyolnuhh@core.my.home>
Mail-Followup-To: Vasily Khoruzhick <anarsoul@gmail.com>,
        Frank Lee <tiny.windzz@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Jonathan.Cameron@huawei.com,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        rui.zhang@intel.com, "David S. Miller" <davem@davemloft.net>,
        arm-linux <linux-arm-kernel@lists.infradead.org>
References: <20190810052829.6032-1-tiny.windzz@gmail.com>
 <20190810052829.6032-9-tiny.windzz@gmail.com>
 <CA+E=qVfp-rProxOwX__J6jM-pZ9g_SmeuOCOgvC_5DJVQw4OGw@mail.gmail.com>
 <CAEExFWubLqtPZ=ZKJTCb6x2-PeYebXb3sr-t-XvtrLJTRiUU1A@mail.gmail.com>
 <CA+E=qVf9V9iTvCfXXyjqKeviCJOvYpKUO8qw6cQsKqoaRmdKYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+E=qVf9V9iTvCfXXyjqKeviCJOvYpKUO8qw6cQsKqoaRmdKYQ@mail.gmail.com>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 12, 2019 at 04:54:15PM -0700, Vasily Khoruzhick wrote:
> On Mon, Aug 12, 2019 at 4:46 PM Frank Lee <tiny.windzz@gmail.com> wrote:
> >
> > HI Vasily,
> >
> > On Sat, Aug 10, 2019 at 2:17 PM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> > >
> > > On Fri, Aug 9, 2019 at 10:31 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
> > > >
> > > > H3 has extra clock, so introduce something in ths_thermal_chip/ths_device
> > > > and adds the process of the clock.
> > > >
> > > > This is pre-work for supprt it.
> > > >
> > > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > > ---
> > > >  drivers/thermal/sun8i_thermal.c | 17 ++++++++++++++++-
> > > >  1 file changed, 16 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
> > > > index b934bc81eba7..6f4294c2aba7 100644
> > > > --- a/drivers/thermal/sun8i_thermal.c
> > > > +++ b/drivers/thermal/sun8i_thermal.c
> > > > @@ -54,6 +54,7 @@ struct tsensor {
> > > >  };
> > > >
> > > >  struct ths_thermal_chip {
> > > > +       bool            has_mod_clk;
> > > >         int             sensor_num;
> > > >         int             offset;
> > > >         int             scale;
> > > > @@ -69,6 +70,7 @@ struct ths_device {
> > > >         struct regmap                           *regmap;
> > > >         struct reset_control                    *reset;
> > > >         struct clk                              *bus_clk;
> > > > +       struct clk                              *mod_clk;
> > > >         struct tsensor                          sensor[MAX_SENSOR_NUM];
> > > >  };
> > > >
> > > > @@ -274,6 +276,12 @@ static int sun8i_ths_resource_init(struct ths_device *tmdev)
> > > >         if (IS_ERR(tmdev->bus_clk))
> > > >                 return PTR_ERR(tmdev->bus_clk);
> > > >
> > > > +       if (tmdev->chip->has_mod_clk) {
> > > > +               tmdev->mod_clk = devm_clk_get(&pdev->dev, "mod");
> > > > +               if (IS_ERR(tmdev->mod_clk))
> > > > +                       return PTR_ERR(tmdev->mod_clk);
> > > > +       }
> > > > +
> > > >         ret = reset_control_deassert(tmdev->reset);
> > > >         if (ret)
> > > >                 return ret;
> > > > @@ -282,12 +290,18 @@ static int sun8i_ths_resource_init(struct ths_device *tmdev)
> > > >         if (ret)
> > > >                 goto assert_reset;
> > > >
> > > > -       ret = sun50i_ths_calibrate(tmdev);
> > > > +       ret = clk_prepare_enable(tmdev->mod_clk);
> > >
> > > You have to set rate of modclk before enabling it since you can't rely
> > > on whatever bootloader left for you.
> > >
> > > Also I found that parameters you're using for PC_TEMP_PERIOD, ACQ0 and
> > > ACQ1 are too aggressive and may result in high interrupt rate to the
> > > point when it may stall RCU. I changed driver a bit to use params from
> > > Philipp Rossak's work (modclk set to 4MHz, PC_TEMP_PERIOD is 7, ACQ0
> > > is 255, ACQ1 is 63) and it fixed RCU stalls for me, see [1] for
> > > details.
> >
> > Why is the RCU stall happening, is it caused by a deadlock?
> > Can you provide log information and your configuration?
> > I am a bit curious.
> 
> It's not deadlock, I believe it just can't handle that many interrupts
> when running at lowest CPU frequency. Even with Philipp's settings
> there's ~20 interrupts a second from ths. I don't remember how many
> interrupts were there with your settings.
> 
> Unfortunately there's nothing interesting in backtraces, I'm using
> Pine64-LTS board.

Recently there was a similar issue, with buggy CCU driver that caused
CIR interrupts being fired constantly, and it also resulted in RCU
stalls. Looks like a comon cause of RCU stalls.

THS timing settings probably need to be made specific to the SoC, because
I noticed that the same settings lead to wildly different timings on
different SoCs.

It would be good to measure how often ths interrupt fires with this driver
on various SoCs.

20 times a second and more sounds like overkill. I'd expect a useful
range to be at most 5-10 times a second. That should be enough to stop
overheating the SoC due to suddenly increased load, even without a
heatsink.

regards,
	o.

> > Thx,
> > Yangtao
> >
> > >
> > > [1] https://github.com/anarsoul/linux-2.6/commit/46b8bb0fe2ccd1cd88fa9181a2ecbf79e8d513b2
> > >
> > >
> > > >         if (ret)
> > > >                 goto bus_disable;
> > > >
> > > > +       ret = sun50i_ths_calibrate(tmdev);
> > > > +       if (ret)
> > > > +               goto mod_disable;
> > > > +
> > > >         return 0;
> > > >
> > > > +mod_disable:
> > > > +       clk_disable_unprepare(tmdev->mod_clk);
> > > >  bus_disable:
> > > >         clk_disable_unprepare(tmdev->bus_clk);
> > > >  assert_reset:
> > > > @@ -395,6 +409,7 @@ static int sun8i_ths_remove(struct platform_device *pdev)
> > > >  {
> > > >         struct ths_device *tmdev = platform_get_drvdata(pdev);
> > > >
> > > > +       clk_disable_unprepare(tmdev->mod_clk);
> > > >         clk_disable_unprepare(tmdev->bus_clk);
> > > >         reset_control_assert(tmdev->reset);
> > > >
> > > > --
> > > > 2.17.1
> > > >
> > > >
> > > > _______________________________________________
> > > > linux-arm-kernel mailing list
> > > > linux-arm-kernel@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
