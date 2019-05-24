Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07A822912D
	for <lists+linux-pm@lfdr.de>; Fri, 24 May 2019 08:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388451AbfEXGpY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 24 May 2019 02:45:24 -0400
Received: from gloria.sntech.de ([185.11.138.130]:34568 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388365AbfEXGpY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 May 2019 02:45:24 -0400
Received: from [46.183.103.17] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hU3x7-0002US-Pg; Fri, 24 May 2019 08:45:18 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     "elaine.zhang" <zhangqing@rock-chips.com>
Cc:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
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
Date:   Fri, 24 May 2019 08:45:12 +0200
Message-ID: <23620031.GKuRlaLy8o@phil>
In-Reply-To: <a6780f8f-4144-f817-b4b8-c40f6aa5e806@rock-chips.com>
References: <1556618986-18923-1-git-send-email-zhangqing@rock-chips.com> <2174314.1vfUlvne1O@phil> <a6780f8f-4144-f817-b4b8-c40f6aa5e806@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Elaine,

Am Donnerstag, 23. Mai 2019, 03:34:37 CEST schrieb elaine.zhang:
> hi, Heiko & Enric:
> 
> 在 2019/5/22 下午8:27, Heiko Stuebner 写道:
> > Hi Enric,
> >
> > Am Montag, 20. Mai 2019, 15:38:32 CEST schrieb Enric Balletbo Serra:
> >> Hi all,
> >>
> >> As pointed by [1] and [2] this commit, that now is upstream, breaks
> >> veyron (rk3288) and kevin (rk3399) boards. The problem is especially
> >> critical for veyron boards because they don't boot anymore.
> >>
> >> I didn't look deep at the problem but I have some concerns about this
> >> patch, see below.
> >>
> >> [1] https://www.spinics.net/lists/linux-rockchip/msg24657.html
> >> [2] https://www.spinics.net/lists/linux-rockchip/msg24735.html
> >>
> >> Missatge de Daniel Lezcano <daniel.lezcano@linaro.org> del dia dt., 30
> >> d’abr. 2019 a les 15:39:
> >>> On 30/04/2019 12:09, Elaine Zhang wrote:
> >>>> Explicitly use the pinctrl to set/unset the right mode
> >>>> instead of relying on the pinctrl init mode.
> >>>> And it requires setting the tshut polarity before select pinctrl.
> >>>>
> >>>> When the temperature sensor mode is set to 0, it will automatically
> >>>> reset the board via the Clock-Reset-Unit (CRU) if the over temperature
> >>>> threshold is reached. However, when the pinctrl initializes, it does a
> >>>> transition to "otp_out" which may lead the SoC restart all the time.
> >>>>
> >>>> "otp_out" IO may be connected to the RESET circuit on the hardware.
> >>>> If the IO is in the wrong state, it will trigger RESET.
> >>>> (similar to the effect of pressing the RESET button)
> >>>> which will cause the soc to restart all the time.
> >>>>
> >>>> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> >>> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >>>
> >>>
> >>>
> >>>> ---
> >>>>   drivers/thermal/rockchip_thermal.c | 36 +++++++++++++++++++++++++++++++++---
> >>>>   1 file changed, 33 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> >>>> index 9c7643d62ed7..6dc7fc516abf 100644
> >>>> --- a/drivers/thermal/rockchip_thermal.c
> >>>> +++ b/drivers/thermal/rockchip_thermal.c
> >>>> @@ -172,6 +172,9 @@ struct rockchip_thermal_data {
> >>>>        int tshut_temp;
> >>>>        enum tshut_mode tshut_mode;
> >>>>        enum tshut_polarity tshut_polarity;
> >>>> +     struct pinctrl *pinctrl;
> >>>> +     struct pinctrl_state *gpio_state;
> >>>> +     struct pinctrl_state *otp_state;
> >>>>   };
> >>>>
> >>>>   /**
> >>>> @@ -1242,6 +1245,8 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
> >>>>                return error;
> >>>>        }
> >>>>
> >>>> +     thermal->chip->control(thermal->regs, false);
> >>>> +
> >> That's the line that causes the hang. Commenting this makes the veyron
> >> boot again. Probably this needs to go after chip->initialize?
> > It needs to go after the clk_enable calls.
> > At this point the tsadc may still be unclocked.
> 
> The clk is enable by default.

Not necessarily. A driver needing a clock should not rely on it being
magically on :-) . Especially rk3288 devices were affected by this ...
see the number of people "complaining".

As you need to have the pclk enabled to access the tsadc registers
I'd suggest changing the control to something like

clk_prepare_enable(pclk)
->control(..., false)
clk_prepare_enable(tsadc)

So just swapping the clk-enable order (right now pclk only gets enabled
later as second clock)

> The reason for this modification:
> 
> The otp Pin polarity setting for tsadc must be set when tsadc is turned off.
> 
> The order:
> 
> Close the tsadc->Set the otp pin polarity ->Set the pinctrl->initialize 
> the tsadc->Open the tsadc

I'm still trying to understand why you need the additional pin-states
though. I.e. you introduce an additional gpio and otpout state, but
instead could just select the "init" state when needed?
(when the tsadc gets disabled)

Staying backwards compatible with existing devicetrees is really important
and changing the pinctrl requirements makes tsadc probe fail on these.

Heiko


> 
> 
> As for the problem you mentioned, I guess: The default polarity of otp 
> does not match the default state, that is, the otp is triggered by 
> default, and then the reset circuit of the hardware takes effect and is 
> restarted all the time.
> Modification:
> 1. For this hardware, otp pin default state is modified.
> 2. The mode of using CRU is rockchip,hw-tshut-mode = <0> in DTS;
> /* tshut mode 0:CRU 1:GPIO */
> 
> Recommended use method 2. You can try it.
> 
> >
> >>>>        error = clk_prepare_enable(thermal->clk);
> >>>>        if (error) {
> >>>>                dev_err(&pdev->dev, "failed to enable converter clock: %d\n",
> >>>> @@ -1267,6 +1272,30 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
> >>>>        thermal->chip->initialize(thermal->grf, thermal->regs,
> >>>>                                  thermal->tshut_polarity);
> >>>>
> >>>> +     if (thermal->tshut_mode == TSHUT_MODE_GPIO) {
> >>>> +             thermal->pinctrl = devm_pinctrl_get(&pdev->dev);
> >>>> +             if (IS_ERR(thermal->pinctrl)) {
> >>>> +                     dev_err(&pdev->dev, "failed to find thermal pinctrl\n");
> >>>> +                     return PTR_ERR(thermal->pinctrl);
> >>>> +             }
> >>>> +
> >>>> +             thermal->gpio_state = pinctrl_lookup_state(thermal->pinctrl,
> >>>> +                                                        "gpio");
> >> Shouldn't this mode be documented properly in the binding first?
> > More importantly, it should be _backwards-compatible_, aka work with
> > old devicetrees without that property and not break thermal handling for
> > them entirely.
> If need  _backwards-compatible_,  It's can't return 
> PTR_ERR(thermal->pinctrl) when get
> 
> devm_pinctrl_get failed.
> 
> >
> >> The binding [3] talks about init, default and sleep states but *not*
> >> gpio and otpout. The patch series looks incomplete to me or not using
> >> the proper names.
> >>
> >> [3] https://elixir.bootlin.com/linux/v5.2-rc1/source/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> >>
> >>>> +             if (IS_ERR_OR_NULL(thermal->gpio_state)) {
> >>>> +                     dev_err(&pdev->dev, "failed to find thermal gpio state\n");
> >>>> +                     return -EINVAL;
> >>>> +             }
> >>>> +
> >>>> +             thermal->otp_state = pinctrl_lookup_state(thermal->pinctrl,
> >>>> +                                                       "otpout");
> >>>> +             if (IS_ERR_OR_NULL(thermal->otp_state)) {
> >>>> +                     dev_err(&pdev->dev, "failed to find thermal otpout state\n");
> >>>> +                     return -EINVAL;
> >>>> +             }
> >>>> +
> >> Same here otpout is not a documented.
> >>
> >> As this change is now in mainline and is causing veyron to hang I'd
> >> suggest reverting this change for now. Even fixing the root cause
> >> (maybe the one I pointed above) after this patch we will have the
> >> thermal driver to fail because "gpio" and "otpout" states are not
> >> defined nor documented (a change on this will need some reviews and
> >> acks and time I guess).
> > I definitly agree here. Handling + checking the binding change
> > as well as needed fallback code is definitly not material for -rc-kernels
> > so we should just revert for now and let Elaine fix the issues for 5.3.
> >
> > Anyone volunteering for sending a revert-patch to Eduardo? :-)
> 
> I agree to revert the patch,and I will correct it and push it later.
> 
> Do I need to commit the revert the patch now?@Heiko




