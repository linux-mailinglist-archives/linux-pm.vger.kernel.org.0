Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2535DE2B7
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2019 05:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfJUDmR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 20 Oct 2019 23:42:17 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34166 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfJUDmR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 20 Oct 2019 23:42:17 -0400
Received: by mail-ot1-f67.google.com with SMTP id m19so9813733otp.1;
        Sun, 20 Oct 2019 20:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WwNptKCIXL03KfSFCpNDwIbTOrNecFxUXSvyhNwAF1o=;
        b=jscOCbkjE3LquQhr7FG795+BMFTVVG2o+MrpONMzll+dZHgml9UVKKywOM11jtVQ9G
         G0pPHO2D3Z4goJjzQDJ6mVayZFO/XQKpUr4B6p2iB/9Rw5sEeHBLKhxCi+1s2TiK0ZnC
         yqb30CTY6qgDCosbTHPdxUOr7Ak2of3UwhDe7s0vzy9s2fSZEnpiCa1HioM/50qWoBYO
         lZeJbjYC3pitteLMVAgUjiteaXTHrkQB1kNYha/0moX96pzJorblUYGiNaP8gYbt0yqL
         +k05oWfsViznKQSKY7ZU+chTOqQsDaJAQ9X4Vs+3S+DqBnPhuiejy7NLL0gmo+id2jRb
         wF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WwNptKCIXL03KfSFCpNDwIbTOrNecFxUXSvyhNwAF1o=;
        b=cThitBYbjmi6OXCYUvszGd/wRFwHDH+tTFncIQRZIedKwn41o/F+wiuzQT6T64ZJ2h
         TipjmFGRmoOr5fB0f3W3+tyxhmWlqBfGaA9FKoC8TkFvF90zQYjpNrfICqMZ82y7QEv7
         TsPFkJYrWaY5WjhbyE6kF8tfTo7BXKJNb4kHAYTW9vQub65u3du13wDODafRjZ/UUDER
         uQkFg3uZPgcLg/yDLnXpX57/KF5jWkHVS7cDWeSA4HpwqcOvnuToY+Dfgy8eMRLeK9yz
         nV/jeBUvCPTQI9bKcKUGSEv5Sf3eCdPfW1CBZUIQa6EqE8qDYirWtv+vbgAeCKdzT6XL
         nXJg==
X-Gm-Message-State: APjAAAVNtPmx716+X7ArJuuS8FEhhCWhVbfbud477PdICCtcQpAQq4Ru
        GDi9pNxYlDb2l3e/2HQUyt+lGU7GEHXSgh4XQcU=
X-Google-Smtp-Source: APXvYqwbDxAiumFveeAyDjAcA3RuuZXJIQxgx57k3J8A7n30HzjoSDQpOnDmk3kxMRr3wyH5kUdKJVwmYd9QxetBhXo=
X-Received: by 2002:a9d:3ec:: with SMTP id f99mr15783897otf.353.1571629334258;
 Sun, 20 Oct 2019 20:42:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190810052829.6032-1-tiny.windzz@gmail.com> <20190810052829.6032-9-tiny.windzz@gmail.com>
 <CA+E=qVfp-rProxOwX__J6jM-pZ9g_SmeuOCOgvC_5DJVQw4OGw@mail.gmail.com>
 <CAEExFWubLqtPZ=ZKJTCb6x2-PeYebXb3sr-t-XvtrLJTRiUU1A@mail.gmail.com>
 <CA+E=qVf9V9iTvCfXXyjqKeviCJOvYpKUO8qw6cQsKqoaRmdKYQ@mail.gmail.com>
 <20190813200623.2dmxcwibuyolnuhh@core.my.home> <CA+E=qVd-hz68VhL0n+3-HDNua2QsT0dOVY9mRjhb5e5+tBW5Fg@mail.gmail.com>
 <CAEExFWueWPOvXoE+zj67DuKWeamcLgawfOxanfPp6Jyo9Envzg@mail.gmail.com>
In-Reply-To: <CAEExFWueWPOvXoE+zj67DuKWeamcLgawfOxanfPp6Jyo9Envzg@mail.gmail.com>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Sun, 20 Oct 2019 20:41:48 -0700
Message-ID: <CA+E=qVchu9=Qjp9k3QxQ-Dd1oKnfTKQan7AZfbA5k3qk-1N+6A@mail.gmail.com>
Subject: Re: [PATCH v5 08/18] thermal: sun8i: support mod clocks
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
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

On Sun, Aug 25, 2019 at 9:14 AM Frank Lee <tiny.windzz@gmail.com> wrote:
>
> HI Vasily,

Hi Yangtao,

Sorry for the late reply,

> On Wed, Aug 14, 2019 at 11:01 AM Vasily Khoruzhick <anarsoul@gmail.com> w=
rote:
> >
> > On Tue, Aug 13, 2019 at 1:06 PM Ond=C5=99ej Jirman <megous@megous.com> =
wrote:
> > >
> > > On Mon, Aug 12, 2019 at 04:54:15PM -0700, Vasily Khoruzhick wrote:
> > > > On Mon, Aug 12, 2019 at 4:46 PM Frank Lee <tiny.windzz@gmail.com> w=
rote:
> > > > >
> > > > > HI Vasily,
> > > > >
> > > > > On Sat, Aug 10, 2019 at 2:17 PM Vasily Khoruzhick <anarsoul@gmail=
.com> wrote:
> > > > > >
> > > > > > On Fri, Aug 9, 2019 at 10:31 PM Yangtao Li <tiny.windzz@gmail.c=
om> wrote:
> > > > > > >
> > > > > > > H3 has extra clock, so introduce something in ths_thermal_chi=
p/ths_device
> > > > > > > and adds the process of the clock.
> > > > > > >
> > > > > > > This is pre-work for supprt it.
> > > > > > >
> > > > > > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > > > > > ---
> > > > > > >  drivers/thermal/sun8i_thermal.c | 17 ++++++++++++++++-
> > > > > > >  1 file changed, 16 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/therma=
l/sun8i_thermal.c
> > > > > > > index b934bc81eba7..6f4294c2aba7 100644
> > > > > > > --- a/drivers/thermal/sun8i_thermal.c
> > > > > > > +++ b/drivers/thermal/sun8i_thermal.c
> > > > > > > @@ -54,6 +54,7 @@ struct tsensor {
> > > > > > >  };
> > > > > > >
> > > > > > >  struct ths_thermal_chip {
> > > > > > > +       bool            has_mod_clk;
> > > > > > >         int             sensor_num;
> > > > > > >         int             offset;
> > > > > > >         int             scale;
> > > > > > > @@ -69,6 +70,7 @@ struct ths_device {
> > > > > > >         struct regmap                           *regmap;
> > > > > > >         struct reset_control                    *reset;
> > > > > > >         struct clk                              *bus_clk;
> > > > > > > +       struct clk                              *mod_clk;
> > > > > > >         struct tsensor                          sensor[MAX_SE=
NSOR_NUM];
> > > > > > >  };
> > > > > > >
> > > > > > > @@ -274,6 +276,12 @@ static int sun8i_ths_resource_init(struc=
t ths_device *tmdev)
> > > > > > >         if (IS_ERR(tmdev->bus_clk))
> > > > > > >                 return PTR_ERR(tmdev->bus_clk);
> > > > > > >
> > > > > > > +       if (tmdev->chip->has_mod_clk) {
> > > > > > > +               tmdev->mod_clk =3D devm_clk_get(&pdev->dev, "=
mod");
> > > > > > > +               if (IS_ERR(tmdev->mod_clk))
> > > > > > > +                       return PTR_ERR(tmdev->mod_clk);
> > > > > > > +       }
> > > > > > > +
> > > > > > >         ret =3D reset_control_deassert(tmdev->reset);
> > > > > > >         if (ret)
> > > > > > >                 return ret;
> > > > > > > @@ -282,12 +290,18 @@ static int sun8i_ths_resource_init(stru=
ct ths_device *tmdev)
> > > > > > >         if (ret)
> > > > > > >                 goto assert_reset;
> > > > > > >
> > > > > > > -       ret =3D sun50i_ths_calibrate(tmdev);
> > > > > > > +       ret =3D clk_prepare_enable(tmdev->mod_clk);
> > > > > >
> > > > > > You have to set rate of modclk before enabling it since you can=
't rely
> > > > > > on whatever bootloader left for you.
> > > > > >
> > > > > > Also I found that parameters you're using for PC_TEMP_PERIOD, A=
CQ0 and
> > > > > > ACQ1 are too aggressive and may result in high interrupt rate t=
o the
> > > > > > point when it may stall RCU. I changed driver a bit to use para=
ms from
> > > > > > Philipp Rossak's work (modclk set to 4MHz, PC_TEMP_PERIOD is 7,=
 ACQ0
> > > > > > is 255, ACQ1 is 63) and it fixed RCU stalls for me, see [1] for
> > > > > > details.
> > > > >
> > > > > Why is the RCU stall happening, is it caused by a deadlock?
> > > > > Can you provide log information and your configuration?
> > > > > I am a bit curious.
> > > >
> > > > It's not deadlock, I believe it just can't handle that many interru=
pts
> > > > when running at lowest CPU frequency. Even with Philipp's settings
> > > > there's ~20 interrupts a second from ths. I don't remember how many
> > > > interrupts were there with your settings.
> > > >
> > > > Unfortunately there's nothing interesting in backtraces, I'm using
> > > > Pine64-LTS board.
> > >
> > > Recently there was a similar issue, with buggy CCU driver that caused
> > > CIR interrupts being fired constantly, and it also resulted in RCU
> > > stalls. Looks like a comon cause of RCU stalls.
> > >
> > > THS timing settings probably need to be made specific to the SoC, bec=
ause
> > > I noticed that the same settings lead to wildly different timings on
> > > different SoCs.
> > >
> > > It would be good to measure how often ths interrupt fires with this d=
river
> > > on various SoCs.
> > >
> > > 20 times a second and more sounds like overkill. I'd expect a useful
> > > range to be at most 5-10 times a second. That should be enough to sto=
p
> > > overheating the SoC due to suddenly increased load, even without a
> > > heatsink.
> >
> > Note that A64 has 3 sensors and each sensor has individual interrupt,
> > so technically it's 6-7 interrupts per sensor per second
>
> You only need to increase the value of the period to reduce the number
> of interrupts.
> Can you test the relationship between the period and the number of interr=
upts
> when the mod clock does not change and stays 24M?

I played a bit with your settings and 24M,

with PERIOD =3D 57 I get 26 interrupts / second
with 87 - 18 interrupts / second
with 116 - 12-15 interrupts / second.

I think we should use 116 for A64 since with it we get reasonable
number of ths interrupts in a second.

Regards,
Vasily

> Thx.
> Yangtao
>
> >
> > > regards,
> > >         o.
> > >
> > > > > Thx,
> > > > > Yangtao
> > > > >
> > > > > >
> > > > > > [1] https://github.com/anarsoul/linux-2.6/commit/46b8bb0fe2ccd1=
cd88fa9181a2ecbf79e8d513b2
> > > > > >
> > > > > >
> > > > > > >         if (ret)
> > > > > > >                 goto bus_disable;
> > > > > > >
> > > > > > > +       ret =3D sun50i_ths_calibrate(tmdev);
> > > > > > > +       if (ret)
> > > > > > > +               goto mod_disable;
> > > > > > > +
> > > > > > >         return 0;
> > > > > > >
> > > > > > > +mod_disable:
> > > > > > > +       clk_disable_unprepare(tmdev->mod_clk);
> > > > > > >  bus_disable:
> > > > > > >         clk_disable_unprepare(tmdev->bus_clk);
> > > > > > >  assert_reset:
> > > > > > > @@ -395,6 +409,7 @@ static int sun8i_ths_remove(struct platfo=
rm_device *pdev)
> > > > > > >  {
> > > > > > >         struct ths_device *tmdev =3D platform_get_drvdata(pde=
v);
> > > > > > >
> > > > > > > +       clk_disable_unprepare(tmdev->mod_clk);
> > > > > > >         clk_disable_unprepare(tmdev->bus_clk);
> > > > > > >         reset_control_assert(tmdev->reset);
> > > > > > >
> > > > > > > --
> > > > > > > 2.17.1
> > > > > > >
> > > > > > >
> > > > > > > _______________________________________________
> > > > > > > linux-arm-kernel mailing list
> > > > > > > linux-arm-kernel@lists.infradead.org
> > > > > > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > > >
> > > > _______________________________________________
> > > > linux-arm-kernel mailing list
> > > > linux-arm-kernel@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
