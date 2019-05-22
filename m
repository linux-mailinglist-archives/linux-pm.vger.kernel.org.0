Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2A5E263CB
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2019 14:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbfEVM1q convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 22 May 2019 08:27:46 -0400
Received: from gloria.sntech.de ([185.11.138.130]:45608 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728468AbfEVM1q (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 May 2019 08:27:46 -0400
Received: from we0524.dip.tu-dresden.de ([141.76.178.12] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hTQLJ-0000jJ-2R; Wed, 22 May 2019 14:27:37 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Elaine Zhang <zhangqing@rock-chips.com>,
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
Subject: Re: [PATCH v3 1/3] thermal: rockchip: fix up the tsadc pinctrl setting error
Date:   Wed, 22 May 2019 14:27:35 +0200
Message-ID: <2174314.1vfUlvne1O@phil>
In-Reply-To: <CAFqH_53nbiwzQKctNa7MBzgCcsRFn1p8g31Xgvo3E9k6eA8AKw@mail.gmail.com>
References: <1556618986-18923-1-git-send-email-zhangqing@rock-chips.com> <785392a0-282a-1e51-a4d6-a6d5ca478949@linaro.org> <CAFqH_53nbiwzQKctNa7MBzgCcsRFn1p8g31Xgvo3E9k6eA8AKw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Enric,

Am Montag, 20. Mai 2019, 15:38:32 CEST schrieb Enric Balletbo Serra:
> Hi all,
> 
> As pointed by [1] and [2] this commit, that now is upstream, breaks
> veyron (rk3288) and kevin (rk3399) boards. The problem is especially
> critical for veyron boards because they don't boot anymore.
> 
> I didn't look deep at the problem but I have some concerns about this
> patch, see below.
> 
> [1] https://www.spinics.net/lists/linux-rockchip/msg24657.html
> [2] https://www.spinics.net/lists/linux-rockchip/msg24735.html
> 
> Missatge de Daniel Lezcano <daniel.lezcano@linaro.org> del dia dt., 30
> d’abr. 2019 a les 15:39:
> >
> > On 30/04/2019 12:09, Elaine Zhang wrote:
> > > Explicitly use the pinctrl to set/unset the right mode
> > > instead of relying on the pinctrl init mode.
> > > And it requires setting the tshut polarity before select pinctrl.
> > >
> > > When the temperature sensor mode is set to 0, it will automatically
> > > reset the board via the Clock-Reset-Unit (CRU) if the over temperature
> > > threshold is reached. However, when the pinctrl initializes, it does a
> > > transition to "otp_out" which may lead the SoC restart all the time.
> > >
> > > "otp_out" IO may be connected to the RESET circuit on the hardware.
> > > If the IO is in the wrong state, it will trigger RESET.
> > > (similar to the effect of pressing the RESET button)
> > > which will cause the soc to restart all the time.
> > >
> > > Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> >
> > Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >
> >
> >
> > > ---
> > >  drivers/thermal/rockchip_thermal.c | 36 +++++++++++++++++++++++++++++++++---
> > >  1 file changed, 33 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> > > index 9c7643d62ed7..6dc7fc516abf 100644
> > > --- a/drivers/thermal/rockchip_thermal.c
> > > +++ b/drivers/thermal/rockchip_thermal.c
> > > @@ -172,6 +172,9 @@ struct rockchip_thermal_data {
> > >       int tshut_temp;
> > >       enum tshut_mode tshut_mode;
> > >       enum tshut_polarity tshut_polarity;
> > > +     struct pinctrl *pinctrl;
> > > +     struct pinctrl_state *gpio_state;
> > > +     struct pinctrl_state *otp_state;
> > >  };
> > >
> > >  /**
> > > @@ -1242,6 +1245,8 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
> > >               return error;
> > >       }
> > >
> > > +     thermal->chip->control(thermal->regs, false);
> > > +
> 
> That's the line that causes the hang. Commenting this makes the veyron
> boot again. Probably this needs to go after chip->initialize?

It needs to go after the clk_enable calls.
At this point the tsadc may still be unclocked.

> 
> > >       error = clk_prepare_enable(thermal->clk);
> > >       if (error) {
> > >               dev_err(&pdev->dev, "failed to enable converter clock: %d\n",
> > > @@ -1267,6 +1272,30 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
> > >       thermal->chip->initialize(thermal->grf, thermal->regs,
> > >                                 thermal->tshut_polarity);
> > >
> > > +     if (thermal->tshut_mode == TSHUT_MODE_GPIO) {
> > > +             thermal->pinctrl = devm_pinctrl_get(&pdev->dev);
> > > +             if (IS_ERR(thermal->pinctrl)) {
> > > +                     dev_err(&pdev->dev, "failed to find thermal pinctrl\n");
> > > +                     return PTR_ERR(thermal->pinctrl);
> > > +             }
> > > +
> > > +             thermal->gpio_state = pinctrl_lookup_state(thermal->pinctrl,
> > > +                                                        "gpio");
> 
> Shouldn't this mode be documented properly in the binding first?

More importantly, it should be _backwards-compatible_, aka work with
old devicetrees without that property and not break thermal handling for
them entirely.


> 
> The binding [3] talks about init, default and sleep states but *not*
> gpio and otpout. The patch series looks incomplete to me or not using
> the proper names.
> 
> [3] https://elixir.bootlin.com/linux/v5.2-rc1/source/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> 
> > > +             if (IS_ERR_OR_NULL(thermal->gpio_state)) {
> > > +                     dev_err(&pdev->dev, "failed to find thermal gpio state\n");
> > > +                     return -EINVAL;
> > > +             }
> > > +
> > > +             thermal->otp_state = pinctrl_lookup_state(thermal->pinctrl,
> > > +                                                       "otpout");
> > > +             if (IS_ERR_OR_NULL(thermal->otp_state)) {
> > > +                     dev_err(&pdev->dev, "failed to find thermal otpout state\n");
> > > +                     return -EINVAL;
> > > +             }
> > > +
> 
> Same here otpout is not a documented.
> 
> As this change is now in mainline and is causing veyron to hang I'd
> suggest reverting this change for now. Even fixing the root cause
> (maybe the one I pointed above) after this patch we will have the
> thermal driver to fail because "gpio" and "otpout" states are not
> defined nor documented (a change on this will need some reviews and
> acks and time I guess).

I definitly agree here. Handling + checking the binding change
as well as needed fallback code is definitly not material for -rc-kernels
so we should just revert for now and let Elaine fix the issues for 5.3.

Anyone volunteering for sending a revert-patch to Eduardo? :-)

Heiko




