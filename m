Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5D5D23861
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2019 15:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731266AbfETNip (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 May 2019 09:38:45 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39609 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbfETNip (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 May 2019 09:38:45 -0400
Received: by mail-qk1-f195.google.com with SMTP id z128so8814436qkb.6;
        Mon, 20 May 2019 06:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4sn2aNhSmWMF2bxaXlhtdrrD8MWB8zLabNnT30+rXN4=;
        b=KcgzAGA5TEDzFFBWGDWAFNeiLd9NNMqf4uaECaqxcXYCa1qvlE+IkMRR/7dzHa2d9N
         A6gd10ktaMwYZTW5XOaWR4f4NDEML2gpQPzXuLCmiEs3CXzm6KxshIZR0FPr0agP/w6e
         bpT45YHpj90Ru/F01/fZAUFpD5IwCIlVNmYl9tCsjE+m1X1H/rcsl3ryz+/drMo3e30b
         eveWPibVsL4VegNF/lyjAoAZo5MJjziMELluckprHhusFdkA6/z+Aq4bUijrIQXTSKWe
         PW08mM5Ru6QmMgPaov+duN9ychrfxubsp4cPqtqy354VlPeP92fNZ3CRqLpbSGiB5lJa
         DNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4sn2aNhSmWMF2bxaXlhtdrrD8MWB8zLabNnT30+rXN4=;
        b=ARA+clqKEtrhfuap76OCEzmy8WVh2jxEqL9NYgoR2w9qOMU1Y8sU0oUxdjVJi3xJDO
         Dm+zLJRVH2H4SyzcoWoGgAe2Zkx199FkEEZfc6xgQhriXC97FnrqycT7gm7AkpQI+2mW
         r66yRA2tJIP6qDWTSvO4cx2tBwVKwJtqW/eqaDJLPxbSYTikchpyXdHBhDplM5w+bmDJ
         ndoV2wQY+ukzSkTXSCX5guxT6xWalfN792Lys5SUZf7UJ/AZCk4dvM6+mFvmY8ON57d4
         LIzVGZLNOwfBClp9BddIeCTpS0BmdccT+dAfJ3OJf3YvXNX5PIH4rh6MI9ec5lf55me7
         03sg==
X-Gm-Message-State: APjAAAWBhVwQoT6oEt3Gw+GLNWTjotkk0lOLH/TWVNAAlO66UGFDI1iq
        +8C5SmwNdJsv/iSCwP16r/h2gFc6Cek5KLz/a0s=
X-Google-Smtp-Source: APXvYqzpOs2ngVfVmJz73hlGI8UpUk2sigfqSuJkh1z/AeIEMMH2pH3Z+sBZuAGRfCGBbKsLDsEAA0YPlpDKL1R27CU=
X-Received: by 2002:a05:620a:1644:: with SMTP id c4mr58248705qko.32.1558359523914;
 Mon, 20 May 2019 06:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <1556618986-18923-1-git-send-email-zhangqing@rock-chips.com>
 <1556618986-18923-2-git-send-email-zhangqing@rock-chips.com> <785392a0-282a-1e51-a4d6-a6d5ca478949@linaro.org>
In-Reply-To: <785392a0-282a-1e51-a4d6-a6d5ca478949@linaro.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Mon, 20 May 2019 15:38:32 +0200
Message-ID: <CAFqH_53nbiwzQKctNa7MBzgCcsRFn1p8g31Xgvo3E9k6eA8AKw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] thermal: rockchip: fix up the tsadc pinctrl
 setting error
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Elaine Zhang <zhangqing@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        huangtao@rock-chips.com, Linux PM list <linux-pm@vger.kernel.org>,
        xxx@rock-chips.com, xf@rock-chips.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Doug Anderson <dianders@chromium.org>, vicencb@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

As pointed by [1] and [2] this commit, that now is upstream, breaks
veyron (rk3288) and kevin (rk3399) boards. The problem is especially
critical for veyron boards because they don't boot anymore.

I didn't look deep at the problem but I have some concerns about this
patch, see below.

[1] https://www.spinics.net/lists/linux-rockchip/msg24657.html
[2] https://www.spinics.net/lists/linux-rockchip/msg24735.html

Missatge de Daniel Lezcano <daniel.lezcano@linaro.org> del dia dt., 30
d=E2=80=99abr. 2019 a les 15:39:
>
> On 30/04/2019 12:09, Elaine Zhang wrote:
> > Explicitly use the pinctrl to set/unset the right mode
> > instead of relying on the pinctrl init mode.
> > And it requires setting the tshut polarity before select pinctrl.
> >
> > When the temperature sensor mode is set to 0, it will automatically
> > reset the board via the Clock-Reset-Unit (CRU) if the over temperature
> > threshold is reached. However, when the pinctrl initializes, it does a
> > transition to "otp_out" which may lead the SoC restart all the time.
> >
> > "otp_out" IO may be connected to the RESET circuit on the hardware.
> > If the IO is in the wrong state, it will trigger RESET.
> > (similar to the effect of pressing the RESET button)
> > which will cause the soc to restart all the time.
> >
> > Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
>
> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>
>
>
> > ---
> >  drivers/thermal/rockchip_thermal.c | 36 ++++++++++++++++++++++++++++++=
+++---
> >  1 file changed, 33 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockc=
hip_thermal.c
> > index 9c7643d62ed7..6dc7fc516abf 100644
> > --- a/drivers/thermal/rockchip_thermal.c
> > +++ b/drivers/thermal/rockchip_thermal.c
> > @@ -172,6 +172,9 @@ struct rockchip_thermal_data {
> >       int tshut_temp;
> >       enum tshut_mode tshut_mode;
> >       enum tshut_polarity tshut_polarity;
> > +     struct pinctrl *pinctrl;
> > +     struct pinctrl_state *gpio_state;
> > +     struct pinctrl_state *otp_state;
> >  };
> >
> >  /**
> > @@ -1242,6 +1245,8 @@ static int rockchip_thermal_probe(struct platform=
_device *pdev)
> >               return error;
> >       }
> >
> > +     thermal->chip->control(thermal->regs, false);
> > +

That's the line that causes the hang. Commenting this makes the veyron
boot again. Probably this needs to go after chip->initialize?

> >       error =3D clk_prepare_enable(thermal->clk);
> >       if (error) {
> >               dev_err(&pdev->dev, "failed to enable converter clock: %d=
\n",
> > @@ -1267,6 +1272,30 @@ static int rockchip_thermal_probe(struct platfor=
m_device *pdev)
> >       thermal->chip->initialize(thermal->grf, thermal->regs,
> >                                 thermal->tshut_polarity);
> >
> > +     if (thermal->tshut_mode =3D=3D TSHUT_MODE_GPIO) {
> > +             thermal->pinctrl =3D devm_pinctrl_get(&pdev->dev);
> > +             if (IS_ERR(thermal->pinctrl)) {
> > +                     dev_err(&pdev->dev, "failed to find thermal pinct=
rl\n");
> > +                     return PTR_ERR(thermal->pinctrl);
> > +             }
> > +
> > +             thermal->gpio_state =3D pinctrl_lookup_state(thermal->pin=
ctrl,
> > +                                                        "gpio");

Shouldn't this mode be documented properly in the binding first?

The binding [3] talks about init, default and sleep states but *not*
gpio and otpout. The patch series looks incomplete to me or not using
the proper names.

[3] https://elixir.bootlin.com/linux/v5.2-rc1/source/Documentation/devicetr=
ee/bindings/thermal/rockchip-thermal.txt

> > +             if (IS_ERR_OR_NULL(thermal->gpio_state)) {
> > +                     dev_err(&pdev->dev, "failed to find thermal gpio =
state\n");
> > +                     return -EINVAL;
> > +             }
> > +
> > +             thermal->otp_state =3D pinctrl_lookup_state(thermal->pinc=
trl,
> > +                                                       "otpout");
> > +             if (IS_ERR_OR_NULL(thermal->otp_state)) {
> > +                     dev_err(&pdev->dev, "failed to find thermal otpou=
t state\n");
> > +                     return -EINVAL;
> > +             }
> > +

Same here otpout is not a documented.

As this change is now in mainline and is causing veyron to hang I'd
suggest reverting this change for now. Even fixing the root cause
(maybe the one I pointed above) after this patch we will have the
thermal driver to fail because "gpio" and "otpout" states are not
defined nor documented (a change on this will need some reviews and
acks and time I guess).

Cheers,
 Enric

> > +             pinctrl_select_state(thermal->pinctrl, thermal->otp_state=
);
> > +     }
> > +
> >       for (i =3D 0; i < thermal->chip->chn_num; i++) {
> >               error =3D rockchip_thermal_register_sensor(pdev, thermal,
> >                                               &thermal->sensors[i],
> > @@ -1337,8 +1366,8 @@ static int __maybe_unused rockchip_thermal_suspen=
d(struct device *dev)
> >
> >       clk_disable(thermal->pclk);
> >       clk_disable(thermal->clk);
> > -
> > -     pinctrl_pm_select_sleep_state(dev);
> > +     if (thermal->tshut_mode =3D=3D TSHUT_MODE_GPIO)
> > +             pinctrl_select_state(thermal->pinctrl, thermal->gpio_stat=
e);
> >
> >       return 0;
> >  }
> > @@ -1383,7 +1412,8 @@ static int __maybe_unused rockchip_thermal_resume=
(struct device *dev)
> >       for (i =3D 0; i < thermal->chip->chn_num; i++)
> >               rockchip_thermal_toggle_sensor(&thermal->sensors[i], true=
);
> >
> > -     pinctrl_pm_select_default_state(dev);
> > +     if (thermal->tshut_mode =3D=3D TSHUT_MODE_GPIO)
> > +             pinctrl_select_state(thermal->pinctrl, thermal->otp_state=
);
> >
> >       return 0;
> >  }
> >
>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
