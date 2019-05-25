Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 648BB2A6D7
	for <lists+linux-pm@lfdr.de>; Sat, 25 May 2019 21:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfEYTyV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 25 May 2019 15:54:21 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43472 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfEYTyU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 25 May 2019 15:54:20 -0400
Received: by mail-oi1-f196.google.com with SMTP id t187so9383842oie.10;
        Sat, 25 May 2019 12:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MiFSpRCSp24Ovn+p+q+QqpmdaSoOgSym7akYhtXt+h8=;
        b=TAWdiDzE7CU0f6ehW5cYCYaClprWPXR9y9MbZYEbuUP4so0d7Zy5eRj+Ip6tvfu1Vt
         G+LwiVWoOX8FbqhTrbfH2oGSx8xN60n9Gs2Lu13dLEfN/ZuNBBT27nduRMVsDk6jjGVg
         dDBsELMenH0f4u3ulcDUylwIBz6NQjBJ4n2m+qObQeI4s+P/vqSTp0bZjT6ieX3dReLB
         7RzFP/ZDb+J6i91w88qxgQeR2NhYedJSkKE9CIJGfDWkNV0YZcMhBczI0Dst/fdh5F6i
         UCTb4Svj6/l1un1jEWM9CYU41RYR8NHKxia7YBUlGaK/0Gsg3/tdsyxjQ+gUt/fIowzS
         BGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MiFSpRCSp24Ovn+p+q+QqpmdaSoOgSym7akYhtXt+h8=;
        b=uOtKZLoncgBgMisauKhwyh37fryk48C/Q9lg9ECq7g+YkaLpqL5eRURyEBS4oXT8lU
         JIomgzVMtdeirJmyavio3FatKH9aUdqx1twAd/QiXUVs8M4vWkkrgp9JLPvZRpx3GQdM
         zNWo3cJ/HAYGJDZxHZSHZN5XCNmZXyv3QU6MjiYT3LcvnOq8xWTbEOcfvDOAuxPKQgo8
         nFaD7dBzR48U9hRcAwOscFUsc3Eihjv0juStVi4l5BE/a5gNvcY6Kz/C4p0ma4rxjW5d
         tiqaErB0VN3b9Bwifk3Cjsc+uq1q43cCIdRx7oGNYlERZ0GFOwwHWLiBDeOo/DJMTTYS
         2+Fw==
X-Gm-Message-State: APjAAAUhOQlT4oqoXZYPBvOfDGKICdEkTV1JCkeAgpeQBIz8ftyaM5sN
        M9S2df3M2QrqCmijmGnKm1kXrVPxcMY1b3DFLTQ=
X-Google-Smtp-Source: APXvYqxC3tWZGGyDyNmsSGvqCq/nSAwp9yvM8hPorR7bIHGAKxlyQ2kmVjiRL4SvmyG/zMD0uE/oyKHqvCch/0yfawg=
X-Received: by 2002:aca:38d4:: with SMTP id f203mr10741251oia.88.1558814059186;
 Sat, 25 May 2019 12:54:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190512082614.9045-1-tiny.windzz@gmail.com> <20190512082614.9045-3-tiny.windzz@gmail.com>
 <20190512221612.ubmknvim4utnqpl4@core.my.home> <CAEExFWv5A5mhpV7afQT=AaYx2ko5QnfbM6HvfuTgT1Na=ssOcw@mail.gmail.com>
 <20190516182936.h6xdzp3gtg4ikave@core.my.home> <CAEExFWvDO3wJd6wp1hFudf3EGF0NixgKAwAd5-b1=VLF+7-jCw@mail.gmail.com>
 <20190519142239.eolisexp5mrdyafz@core.my.home> <CAEExFWsc_YB8NORW4ULfuoicL=xr_oAdtHSaxz4ELv53qvCAsQ@mail.gmail.com>
In-Reply-To: <CAEExFWsc_YB8NORW4ULfuoicL=xr_oAdtHSaxz4ELv53qvCAsQ@mail.gmail.com>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Sat, 25 May 2019 12:53:52 -0700
Message-ID: <CA+E=qVeq4XcQXo1vw-kYJ5eo94sF+n75ZM2kdF7szxOzZEGafQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] thermal: sun50i: add thermal driver for h6
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     rui.zhang@intel.com, Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Miller <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan.Cameron@huawei.com,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        paulmck@linux.ibm.com, Andy Gross <andy.gross@linaro.org>,
        Olof Johansson <olof@lixom.net>, bjorn.andersson@linaro.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        marc.w.gonzalez@free.fr, Stefan Wahren <stefan.wahren@i2se.com>,
        enric.balletbo@collabora.com,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, May 25, 2019 at 11:48 AM Frank Lee <tiny.windzz@gmail.com> wrote:
>
> HI Ond=C5=99ej,
>
> On Sun, May 19, 2019 at 10:22 PM Ond=C5=99ej Jirman <megous@megous.com> w=
rote:
> >
> > Hello Yangtao,
> >
> > On Sat, May 18, 2019 at 12:34:57AM +0800, Frank Lee wrote:
> > > HI,
> > >
> > > On Fri, May 17, 2019 at 2:29 AM Ond=C5=99ej Jirman <megous@megous.com=
> wrote:
> > > >
> > > > Hi Yangtao,
> > > >
> > > > thank you for work on this driver.
> > > >
> > > > On Fri, May 17, 2019 at 02:06:53AM +0800, Frank Lee wrote:
> > > > > HI Ond=C5=99ej,
> > > > >
> > > > > On Mon, May 13, 2019 at 6:16 AM Ond=C5=99ej Jirman <megous@megous=
.com> wrote:
> > > > > > > +
> > > > > > > +/* Temp Unit: millidegree Celsius */
> > > > > > > +static int tsens_reg2temp(struct tsens_device *tmdev,
> > > > > > > +                           int reg)
> > > > > >
> > > > > > Please name all functions so that they are more clearly identif=
iable
> > > > > > in stack traces as belonging to this driver. For example:
> > > > > >
> > > > > >   sun8i_ths_reg2temp
> > > > > >
> > > > > > The same applies for all tsens_* functions below. tsens_* is to=
o
> > > > > > generic.
> > > > >
> > > > > Done but no sun8i_ths_reg2temp.
> > > > >
> > > > > ths_reg2tem() should be a generic func.
> > > > > I think it should be suitable for all platforms=EF=BC=8C so no pl=
atform prefix.
> > > >
> > > > You've missed my point. The driver name is sun8i_thermal and if you=
 get
> > > > and oops from the kernel you'll get a stack trace where there are j=
ust function
> > > > names. If you use too generic function names, it will not be clear =
which
> > > > driver is oopsing.
> > > >
> > > >   - sun8i_ths_reg2temp will tell you much more clearly where to sea=
rch than
> > > >   - ths_reg2temp
> > > >
> > > > Of course you can always grep, but most thermal drivers are thermal=
 sensor (ths)
> > > > drivers, and if multiple of them used this too-generic naming schem=
e you'd
> > > > have hard time debugging.
> > > >
> > > > Look at other thermal drivers. They usually encode driver name in t=
he function
> > > > names to help with identification (even if these are static driver-=
local
> > > > functions).
> > > >
> > >
> > > Can we change to sunxi_ths_ prefix?
> >
> > It should probably match the driver name, but yes, that's better.
> >
> > > > > > > +static int tsens_probe(struct platform_device *pdev)
> > > > > > > +{
> > > > > > > +     struct tsens_device *tmdev;
> > > > > > > +     struct device *dev =3D &pdev->dev;
> > > > > > > +     int ret;
> > > > > > > +
> > > > > > > +     tmdev =3D devm_kzalloc(dev, sizeof(*tmdev), GFP_KERNEL)=
;
> > > > > > > +     if (!tmdev)
> > > > > > > +             return -ENOMEM;
> > > > > > > +
> > > > > > > +     tmdev->dev =3D dev;
> > > > > > > +     tmdev->chip =3D of_device_get_match_data(&pdev->dev);
> > > > > > > +     if (!tmdev->chip)
> > > > > > > +             return -EINVAL;
> > > > > > > +
> > > > > > > +     ret =3D tsens_init(tmdev);
> > > > > > > +     if (ret)
> > > > > > > +             return ret;
> > > > > > > +
> > > > > > > +     ret =3D tsens_register(tmdev);
> > > > > > > +     if (ret)
> > > > > > > +             return ret;
> > > > > >
> > > > > > Why split this out of probe into separate functions?
> > > > > >
> > > > > > > +     ret =3D tmdev->chip->enable(tmdev);
> > > > > > > +     if (ret)
> > > > > > > +             return ret;
> > > > > > > +
> > > > > > > +     platform_set_drvdata(pdev, tmdev);
> > > > > > > +
> > > > > > > +     return ret;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static int tsens_remove(struct platform_device *pdev)
> > > > > > > +{
> > > > > > > +     struct tsens_device *tmdev =3D platform_get_drvdata(pde=
v);
> > > > > > > +
> > > > > > > +     tmdev->chip->disable(tmdev);
> > > > > > > +
> > > > > > > +     return 0;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static int sun50i_thermal_enable(struct tsens_device *tmdev)
> > > > > > > +{
> > > > > > > +     int ret, val;
> > > > > > > +
> > > > > > > +     ret =3D reset_control_deassert(tmdev->reset);
> > > > > > > +     if (ret)
> > > > > > > +             return ret;
> > > > > > > +
> > > > > > > +     ret =3D clk_prepare_enable(tmdev->bus_clk);
> > > > > > > +     if (ret)
> > > > > > > +             goto assert_reset;
> > > > > > > +
> > > > > > > +     ret =3D tsens_calibrate(tmdev);
> > > > > > > +     if (ret)
> > > > > > > +             return ret;
> > > > > >
> > > > > > If this fails (it may likely fail with EPROBE_DEFER) you are le=
aving reset
> > > > > > deasserted, and clock enabled.
> > > > > >
> > > > > > Overall, I think, reset/clock management and nvmem reading will=
 be common
> > > > > > to all the HW variants, so it doesn't make much sense splitting=
 it out
> > > > > > of probe into separate functions, and makes it more error prone=
.
> > > > >
> > > > > Our long-term goal is to support all platforms.
> > > > > Bacicallt there is a differencr between each generation.
> > > > > So I feel it necessary to isolate these differences.
> > > > >
> > > > > Maybe:
> > > > > At some point, we can draw a part of the public part and platform
> > > > > difference into different
> > > > > files. something like qcom thermal driver.
> > > >
> > > > I understand, but I wrote ths drivers for H3/H5/A83T and it so far =
it looks like
> > > > all of them would share these 3 calls.
> > > >
> > > > You'll be enabling clock/reset and callibrating everywhere. So putt=
ing this to
> > > > per-SoC function seems premature.
> > >
> > > In fact, enalbe and disable are the suspend and resume functions.(PM
> > > callback will be added in the future)
> > > When exiting from s2ram, the register will become the initial value.
> > > We need to do all the work, enabling reset/clk ,calibrating and
> > > initializing other reg.
> > >
> > > So I think it is no need to put enabling reset/clk and calibrating to
> > > probe func, and I'd like
> > > to keep enable and disable func.
> >
> > I know, I don't think it needs to be per-soc. These actions are all sha=
red by
> > all SoCs. Maybe with an exception that some SoCs may need one more cloc=
k, but
> > that can be made optionally-required by some flag in struct sunxi_therm=
al_chip.
> >
> > Only highly SoC specific thing is configuring the THS registers for sam=
pling
> > frequency/averaging/enabling interrupts. The reset/clock enable is gene=
ric, and
> > already abstracted by the clock/reset framework.
> >
> > So what I suggest is having:
> >
> > sunxi_ths_enable()
> >         reset deassert
> >         bus clock prepare enable
> >         optionally module clock prepare enable (in the future)
> >         call per-soc calibration
> >         call per-soc setup callback
> >
> > sunxi_ths_disable()
> >         reset assert
> >         bus clock unprepare disable
> >         optionally module clock unprepare disable
> >
> > And if you could move devm_nvmem_cell_get to probe that should make per=
-SoC
> > calibration callback also less repetitive and could avoid undoing the e=
nable
> > in case it returns EPROBE_DEFER (which is possible).
> >
> > All this should make it easier to support PM in the future and add less
> > cumbersome to add support for A83T and H3/H5.
> >
> > BTW, what are your plans for more SoC support? I'd like to add support =
for
> > A83T and H3/H5, maybe even during the 5.3 cycle if this driver happens =
to land
> > early enough. If you don't have any plans I'll take it on.
> >
>
> I plan to support h3 and a33 later.
> Can you support other platforms?

I'll work on A64 once this driver lands.

> Cheers,
> Yangtao
>
> > thank you and regards,
> >         o.
> >
> > > >
> > > > thank you and regards,
> > > >         o.
> > > >
> > > > > Regards,
> > > > > Yangtao
> > >
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
