Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C12298C9C7
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2019 05:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfHNDBh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Aug 2019 23:01:37 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42061 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfHNDBh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Aug 2019 23:01:37 -0400
Received: by mail-oi1-f196.google.com with SMTP id o6so1718570oic.9;
        Tue, 13 Aug 2019 20:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=JldLSgRtBBxHBWQOR9/Op7zdWxFQRoEO7eprbvicojY=;
        b=WlTw0X+lDDkK3OWwBjw3XGwcyn83zxhuFTx1C/dPTO5g+56M2cE6hQKZhECyG/8qfE
         4M1kEwcEFUUGt0nf+SZzgScOOf4nQPkxsyy8K6TXtBOTo7gbDTWjipJMV8icLdkfVYfh
         PKWr9Fl6HA4bwv6pjv3W9GbIp7I8RKNUgumURAl8T1a2Bicojt3+SU/hLzh/nwykhS+8
         5mqvP7BMag9DSTBxoqRpq59LZAl593xM5xU5FO1M2zpWotESM04EjuEQwGtrYeto3Fx4
         yRk2oi5LSieYgI+hRfX4q7PGx8EOhmxIf1sClE9E7VvGFmn2BYlEnbjk/xi8Dv2dViC0
         suhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=JldLSgRtBBxHBWQOR9/Op7zdWxFQRoEO7eprbvicojY=;
        b=d8FvJmLEbVg2wr6uxVZfzq5t0m+Oju9YInwtnN3XyMTNnkvKgw8TASnJtw8mpCPoLy
         RtZzLdg6012fIE4p0z8lFKjI11HpVm4/IJozSZ0Lgqzajwjf/TCJTRudaxdkvl/3mbw9
         X6lhFRvcwxi5dsdoFA/SpzKm/l2OmGEl2nkW4BKKgW7BwmkGICIcHEsrZNKc78ABD4eN
         oss5VpP9wQuS5KLIBPTgMm3g4GqFFW7A9N7xW436eY4lv/ucHnjFdT1+SA8B3dexg06M
         LK4k9R/IwhnNg8ZwpncT535Dd5/gMR1j7OYe4Zq13sEWI3SgTaf/D3FrZlOat1IkVgCu
         WGXQ==
X-Gm-Message-State: APjAAAXvBFHZu8dlULtR5QqiVWpQC0erINdtZ1qQ7nJQ5mz93qTR0Tl3
        SMkpkLO428xyCLhq24jw82XYtHe/Rp/ifpnCYI8=
X-Google-Smtp-Source: APXvYqw9bx/8nkPjqknF7XY6B80tyPcjrTS+9WAO4WSz9iIwcoATg7FP7VyXf60IQz9sfC9Rqxz4I5A7ykIbv8yDURI=
X-Received: by 2002:a54:4e95:: with SMTP id c21mr3197457oiy.145.1565751696231;
 Tue, 13 Aug 2019 20:01:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190810052829.6032-1-tiny.windzz@gmail.com> <20190810052829.6032-9-tiny.windzz@gmail.com>
 <CA+E=qVfp-rProxOwX__J6jM-pZ9g_SmeuOCOgvC_5DJVQw4OGw@mail.gmail.com>
 <CAEExFWubLqtPZ=ZKJTCb6x2-PeYebXb3sr-t-XvtrLJTRiUU1A@mail.gmail.com>
 <CA+E=qVf9V9iTvCfXXyjqKeviCJOvYpKUO8qw6cQsKqoaRmdKYQ@mail.gmail.com> <20190813200623.2dmxcwibuyolnuhh@core.my.home>
In-Reply-To: <20190813200623.2dmxcwibuyolnuhh@core.my.home>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Tue, 13 Aug 2019 20:01:10 -0700
Message-ID: <CA+E=qVd-hz68VhL0n+3-HDNua2QsT0dOVY9mRjhb5e5+tBW5Fg@mail.gmail.com>
Subject: Re: [PATCH v5 08/18] thermal: sun8i: support mod clocks
To:     Vasily Khoruzhick <anarsoul@gmail.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 13, 2019 at 1:06 PM Ond=C5=99ej Jirman <megous@megous.com> wrot=
e:
>
> On Mon, Aug 12, 2019 at 04:54:15PM -0700, Vasily Khoruzhick wrote:
> > On Mon, Aug 12, 2019 at 4:46 PM Frank Lee <tiny.windzz@gmail.com> wrote=
:
> > >
> > > HI Vasily,
> > >
> > > On Sat, Aug 10, 2019 at 2:17 PM Vasily Khoruzhick <anarsoul@gmail.com=
> wrote:
> > > >
> > > > On Fri, Aug 9, 2019 at 10:31 PM Yangtao Li <tiny.windzz@gmail.com> =
wrote:
> > > > >
> > > > > H3 has extra clock, so introduce something in ths_thermal_chip/th=
s_device
> > > > > and adds the process of the clock.
> > > > >
> > > > > This is pre-work for supprt it.
> > > > >
> > > > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > > > ---
> > > > >  drivers/thermal/sun8i_thermal.c | 17 ++++++++++++++++-
> > > > >  1 file changed, 16 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/su=
n8i_thermal.c
> > > > > index b934bc81eba7..6f4294c2aba7 100644
> > > > > --- a/drivers/thermal/sun8i_thermal.c
> > > > > +++ b/drivers/thermal/sun8i_thermal.c
> > > > > @@ -54,6 +54,7 @@ struct tsensor {
> > > > >  };
> > > > >
> > > > >  struct ths_thermal_chip {
> > > > > +       bool            has_mod_clk;
> > > > >         int             sensor_num;
> > > > >         int             offset;
> > > > >         int             scale;
> > > > > @@ -69,6 +70,7 @@ struct ths_device {
> > > > >         struct regmap                           *regmap;
> > > > >         struct reset_control                    *reset;
> > > > >         struct clk                              *bus_clk;
> > > > > +       struct clk                              *mod_clk;
> > > > >         struct tsensor                          sensor[MAX_SENSOR=
_NUM];
> > > > >  };
> > > > >
> > > > > @@ -274,6 +276,12 @@ static int sun8i_ths_resource_init(struct th=
s_device *tmdev)
> > > > >         if (IS_ERR(tmdev->bus_clk))
> > > > >                 return PTR_ERR(tmdev->bus_clk);
> > > > >
> > > > > +       if (tmdev->chip->has_mod_clk) {
> > > > > +               tmdev->mod_clk =3D devm_clk_get(&pdev->dev, "mod"=
);
> > > > > +               if (IS_ERR(tmdev->mod_clk))
> > > > > +                       return PTR_ERR(tmdev->mod_clk);
> > > > > +       }
> > > > > +
> > > > >         ret =3D reset_control_deassert(tmdev->reset);
> > > > >         if (ret)
> > > > >                 return ret;
> > > > > @@ -282,12 +290,18 @@ static int sun8i_ths_resource_init(struct t=
hs_device *tmdev)
> > > > >         if (ret)
> > > > >                 goto assert_reset;
> > > > >
> > > > > -       ret =3D sun50i_ths_calibrate(tmdev);
> > > > > +       ret =3D clk_prepare_enable(tmdev->mod_clk);
> > > >
> > > > You have to set rate of modclk before enabling it since you can't r=
ely
> > > > on whatever bootloader left for you.
> > > >
> > > > Also I found that parameters you're using for PC_TEMP_PERIOD, ACQ0 =
and
> > > > ACQ1 are too aggressive and may result in high interrupt rate to th=
e
> > > > point when it may stall RCU. I changed driver a bit to use params f=
rom
> > > > Philipp Rossak's work (modclk set to 4MHz, PC_TEMP_PERIOD is 7, ACQ=
0
> > > > is 255, ACQ1 is 63) and it fixed RCU stalls for me, see [1] for
> > > > details.
> > >
> > > Why is the RCU stall happening, is it caused by a deadlock?
> > > Can you provide log information and your configuration?
> > > I am a bit curious.
> >
> > It's not deadlock, I believe it just can't handle that many interrupts
> > when running at lowest CPU frequency. Even with Philipp's settings
> > there's ~20 interrupts a second from ths. I don't remember how many
> > interrupts were there with your settings.
> >
> > Unfortunately there's nothing interesting in backtraces, I'm using
> > Pine64-LTS board.
>
> Recently there was a similar issue, with buggy CCU driver that caused
> CIR interrupts being fired constantly, and it also resulted in RCU
> stalls. Looks like a comon cause of RCU stalls.
>
> THS timing settings probably need to be made specific to the SoC, because
> I noticed that the same settings lead to wildly different timings on
> different SoCs.
>
> It would be good to measure how often ths interrupt fires with this drive=
r
> on various SoCs.
>
> 20 times a second and more sounds like overkill. I'd expect a useful
> range to be at most 5-10 times a second. That should be enough to stop
> overheating the SoC due to suddenly increased load, even without a
> heatsink.

Note that A64 has 3 sensors and each sensor has individual interrupt,
so technically it's 6-7 interrupts per sensor per second

> regards,
>         o.
>
> > > Thx,
> > > Yangtao
> > >
> > > >
> > > > [1] https://github.com/anarsoul/linux-2.6/commit/46b8bb0fe2ccd1cd88=
fa9181a2ecbf79e8d513b2
> > > >
> > > >
> > > > >         if (ret)
> > > > >                 goto bus_disable;
> > > > >
> > > > > +       ret =3D sun50i_ths_calibrate(tmdev);
> > > > > +       if (ret)
> > > > > +               goto mod_disable;
> > > > > +
> > > > >         return 0;
> > > > >
> > > > > +mod_disable:
> > > > > +       clk_disable_unprepare(tmdev->mod_clk);
> > > > >  bus_disable:
> > > > >         clk_disable_unprepare(tmdev->bus_clk);
> > > > >  assert_reset:
> > > > > @@ -395,6 +409,7 @@ static int sun8i_ths_remove(struct platform_d=
evice *pdev)
> > > > >  {
> > > > >         struct ths_device *tmdev =3D platform_get_drvdata(pdev);
> > > > >
> > > > > +       clk_disable_unprepare(tmdev->mod_clk);
> > > > >         clk_disable_unprepare(tmdev->bus_clk);
> > > > >         reset_control_assert(tmdev->reset);
> > > > >
> > > > > --
> > > > > 2.17.1
> > > > >
> > > > >
> > > > > _______________________________________________
> > > > > linux-arm-kernel mailing list
> > > > > linux-arm-kernel@lists.infradead.org
> > > > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
