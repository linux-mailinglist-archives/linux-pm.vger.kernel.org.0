Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D23321BAB
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2019 18:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfEQQfL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 May 2019 12:35:11 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:51911 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfEQQfK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 May 2019 12:35:10 -0400
Received: by mail-it1-f195.google.com with SMTP id m3so9168675itl.1;
        Fri, 17 May 2019 09:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=k3eLPJeFfTPv6TDvaqkmkbLRpKbPkalLozF0uKgDS0w=;
        b=a655/08pvA5tAEYJxcg8wgkRU0hsAMqB0mXWuqtMtdvgNCbMuUP9B3X6dotZ6kLaiS
         R1H/lm3y+/WgbsK24NoYfJvZAeVDOJWcXFUkXz5YX8aoOultAe4JHcXGVoEjGx4qTMZC
         QMRXdkkggogxS/Xfu132Ukr93FYGAXS6w4myVLum3ttDhkTZ3eUivku7XTO4YnKcqpdL
         2YqucLNb7zrvr46crgHA6h9IG/dFEG82Cehlcp+JqfQalNiLmRqNxNQXKUkX1gmrP4co
         ggb0iBorZVzcQ9GiqvuNATt/2nSpUpda5btDqL2RpDp+i6C20Fa6Is5119dMApE6oQ9c
         UEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=k3eLPJeFfTPv6TDvaqkmkbLRpKbPkalLozF0uKgDS0w=;
        b=an9MgPNrAMM/mdG4ACsfNAvm+UFAMTVTIadutAcU8ebyzdn/juOlCOOZbIr5HoaLMb
         xpA9lSP0yy12YgIteBVQwIQCj/Oen8wqtcsmd9X0BoZuw2gJM/WxeXXPET3uwSNtrgkN
         T1JwZ3ARiCIeu+xSGJRKKsGIBAJzwNS5jTjYHr0bIatogGzNFLOZSBmlVgPqgGyjv9bX
         fFqZt+OSiG7Qt7nMBBtOgeOUNtyYcaK584/BTJyVAA5gJ79/HBIHLO6kOyrL5TQs7Cq1
         OB2E3L5M5XHWzr7eQbXh7KyqKX/Z1c/KzUVQ3ANDTUE8kfzKUf3MfKXLSZvhSP6tNBTV
         9zuQ==
X-Gm-Message-State: APjAAAWMaVK51snNA73mgveMklbQJwx8bI4M9SAVTiS2oSkIigPeN5yy
        zlaNvyi7+FKYUjGDGqjyl12sZKC6uqD/XHW4BYg=
X-Google-Smtp-Source: APXvYqzDym+y/WmoJ7mUwnMdhz5ZNgY4qEk+9h4TgQdw2Wcyk7OG0owfEtQTfsiZZUF6M67quXcikzQQAqQXIcmZU8w=
X-Received: by 2002:a24:ac49:: with SMTP id m9mr11819158iti.174.1558110909642;
 Fri, 17 May 2019 09:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190512082614.9045-1-tiny.windzz@gmail.com> <20190512082614.9045-3-tiny.windzz@gmail.com>
 <20190512221612.ubmknvim4utnqpl4@core.my.home> <CAEExFWv5A5mhpV7afQT=AaYx2ko5QnfbM6HvfuTgT1Na=ssOcw@mail.gmail.com>
 <20190516182936.h6xdzp3gtg4ikave@core.my.home>
In-Reply-To: <20190516182936.h6xdzp3gtg4ikave@core.my.home>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Sat, 18 May 2019 00:34:57 +0800
Message-ID: <CAEExFWvDO3wJd6wp1hFudf3EGF0NixgKAwAd5-b1=VLF+7-jCw@mail.gmail.com>
Subject: Re: [PATCH 2/3] thermal: sun50i: add thermal driver for h6
To:     Frank Lee <tiny.windzz@gmail.com>, rui.zhang@intel.com,
        Eduardo Valentin <edubezval@gmail.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

HI,

On Fri, May 17, 2019 at 2:29 AM Ond=C5=99ej Jirman <megous@megous.com> wrot=
e:
>
> Hi Yangtao,
>
> thank you for work on this driver.
>
> On Fri, May 17, 2019 at 02:06:53AM +0800, Frank Lee wrote:
> > HI Ond=C5=99ej,
> >
> > On Mon, May 13, 2019 at 6:16 AM Ond=C5=99ej Jirman <megous@megous.com> =
wrote:
> > > > +
> > > > +/* Temp Unit: millidegree Celsius */
> > > > +static int tsens_reg2temp(struct tsens_device *tmdev,
> > > > +                           int reg)
> > >
> > > Please name all functions so that they are more clearly identifiable
> > > in stack traces as belonging to this driver. For example:
> > >
> > >   sun8i_ths_reg2temp
> > >
> > > The same applies for all tsens_* functions below. tsens_* is too
> > > generic.
> >
> > Done but no sun8i_ths_reg2temp.
> >
> > ths_reg2tem() should be a generic func.
> > I think it should be suitable for all platforms=EF=BC=8C so no platform=
 prefix.
>
> You've missed my point. The driver name is sun8i_thermal and if you get
> and oops from the kernel you'll get a stack trace where there are just fu=
nction
> names. If you use too generic function names, it will not be clear which
> driver is oopsing.
>
>   - sun8i_ths_reg2temp will tell you much more clearly where to search th=
an
>   - ths_reg2temp
>
> Of course you can always grep, but most thermal drivers are thermal senso=
r (ths)
> drivers, and if multiple of them used this too-generic naming scheme you'=
d
> have hard time debugging.
>
> Look at other thermal drivers. They usually encode driver name in the fun=
ction
> names to help with identification (even if these are static driver-local
> functions).
>

Can we change to sunxi_ths_ prefix?

> > > > +static int tsens_probe(struct platform_device *pdev)
> > > > +{
> > > > +     struct tsens_device *tmdev;
> > > > +     struct device *dev =3D &pdev->dev;
> > > > +     int ret;
> > > > +
> > > > +     tmdev =3D devm_kzalloc(dev, sizeof(*tmdev), GFP_KERNEL);
> > > > +     if (!tmdev)
> > > > +             return -ENOMEM;
> > > > +
> > > > +     tmdev->dev =3D dev;
> > > > +     tmdev->chip =3D of_device_get_match_data(&pdev->dev);
> > > > +     if (!tmdev->chip)
> > > > +             return -EINVAL;
> > > > +
> > > > +     ret =3D tsens_init(tmdev);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     ret =3D tsens_register(tmdev);
> > > > +     if (ret)
> > > > +             return ret;
> > >
> > > Why split this out of probe into separate functions?
> > >
> > > > +     ret =3D tmdev->chip->enable(tmdev);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     platform_set_drvdata(pdev, tmdev);
> > > > +
> > > > +     return ret;
> > > > +}
> > > > +
> > > > +static int tsens_remove(struct platform_device *pdev)
> > > > +{
> > > > +     struct tsens_device *tmdev =3D platform_get_drvdata(pdev);
> > > > +
> > > > +     tmdev->chip->disable(tmdev);
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static int sun50i_thermal_enable(struct tsens_device *tmdev)
> > > > +{
> > > > +     int ret, val;
> > > > +
> > > > +     ret =3D reset_control_deassert(tmdev->reset);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     ret =3D clk_prepare_enable(tmdev->bus_clk);
> > > > +     if (ret)
> > > > +             goto assert_reset;
> > > > +
> > > > +     ret =3D tsens_calibrate(tmdev);
> > > > +     if (ret)
> > > > +             return ret;
> > >
> > > If this fails (it may likely fail with EPROBE_DEFER) you are leaving =
reset
> > > deasserted, and clock enabled.
> > >
> > > Overall, I think, reset/clock management and nvmem reading will be co=
mmon
> > > to all the HW variants, so it doesn't make much sense splitting it ou=
t
> > > of probe into separate functions, and makes it more error prone.
> >
> > Our long-term goal is to support all platforms.
> > Bacicallt there is a differencr between each generation.
> > So I feel it necessary to isolate these differences.
> >
> > Maybe:
> > At some point, we can draw a part of the public part and platform
> > difference into different
> > files. something like qcom thermal driver.
>
> I understand, but I wrote ths drivers for H3/H5/A83T and it so far it loo=
ks like
> all of them would share these 3 calls.
>
> You'll be enabling clock/reset and callibrating everywhere. So putting th=
is to
> per-SoC function seems premature.

In fact, enalbe and disable are the suspend and resume functions.(PM
callback will be added in the future)
When exiting from s2ram, the register will become the initial value.
We need to do all the work, enabling reset/clk ,calibrating and
initializing other reg.

So I think it is no need to put enabling reset/clk and calibrating to
probe func, and I'd like
to keep enable and disable func.

>
> thank you and regards,
>         o.
>
> > Regards,
> > Yangtao
