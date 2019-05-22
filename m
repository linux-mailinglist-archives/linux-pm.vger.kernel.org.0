Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3BC263AF
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2019 14:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbfEVMUz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 May 2019 08:20:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44729 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728438AbfEVMUy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 May 2019 08:20:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id w13so2035535wru.11
        for <linux-pm@vger.kernel.org>; Wed, 22 May 2019 05:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2ZhTk2acfpx8r4rFg+ynBi2h7n1lFX/B8oA8Vc1vWH4=;
        b=KlvSGTvJ/VQA3qnYedKHobnQk8JkvV/4dnosj/hXZhcKYODa8MUB36fNKdt5ac2m15
         /K5HRObcXkfT5oE73OIczs4h3yyFlnwNWpV0eIwpKeDQyqNXMBey1y4Kj+Gd6lt40yqb
         Sskay6gQq9Do8FehTN8k+XFjwK3e4xkSLOZfv6X1Ik0hV+S/+NsFuVkJ5LFlkBRO5qTR
         6W6Hd+nx6WMOg0TXQl/51Rtg5OgYxSjAWczXesMFFyA6BOmJ7gVGE5KvPLZTuTKX8atI
         lw7A8PWcrPsN0G44hYBUtjWhFlfUSGQcRZKWwQP/5SaHhD2FXApIP+I5Omxfs/VSxdcy
         UsTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2ZhTk2acfpx8r4rFg+ynBi2h7n1lFX/B8oA8Vc1vWH4=;
        b=i9WtIEoArOzXn4CJaYC8yhgBaYj1muPusVQI7wOtxhEU4Dq7oQ3te9SK3+fEprcUxN
         iW53n+7rK2Xzns/0xSVmHqJt32vrRbmGRSekpo6/2iVbTpCTGeMxn594cgdD86HKEV1X
         UFvAuuLG0YIlbRa+fcolACxDbLw1dQVQxD8ZT4nQccgHbSjPjwRvUx06iomkSs24yFM+
         njj5bSoWxlHsTiSZn/ejeH204Vyccde1aNqsYGO7u0ACtnA/yIf093QH+96zA5S9USyh
         8U5UEzUlSoQgA+vV29T4EVEr1EtIeJzpPHksgeSTTzEYC+rgaoeLG5ObFqg+kwCiXFJW
         YVLg==
X-Gm-Message-State: APjAAAXlecQ9sE2zQjK+6Jjw+ltiWtV+yGdN5wll7uW2aJN5hhoBaCZc
        3lFNyQY3TiS11WO9NCJp3nZdSA==
X-Google-Smtp-Source: APXvYqwvz7JWD2HEdR5e4BkwVZV1oZMtKMC3nGM56TpQlUOa698nuBsd11/iLMyslPitIHxG5t1plA==
X-Received: by 2002:a5d:6a8c:: with SMTP id s12mr22488097wru.326.1558527652486;
        Wed, 22 May 2019 05:20:52 -0700 (PDT)
Received: from [10.1.203.87] (nat-wifi.sssup.it. [193.205.81.22])
        by smtp.googlemail.com with ESMTPSA id z8sm22338145wrs.84.2019.05.22.05.20.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 05:20:51 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] thermal: rockchip: fix up the tsadc pinctrl
 setting error
To:     Elaine Zhang <zhangqing@rock-chips.com>, heiko@sntech.de
Cc:     rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com
References: <1556618986-18923-1-git-send-email-zhangqing@rock-chips.com>
 <1556618986-18923-2-git-send-email-zhangqing@rock-chips.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <1d1063a5-3ec8-f430-febe-7e1471cd1812@linaro.org>
Date:   Wed, 22 May 2019 14:20:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556618986-18923-2-git-send-email-zhangqing@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Elaine,

are you taking care of the issue related to this patch. If not fixed, it
will be reverted.


On 30/04/2019 12:09, Elaine Zhang wrote:
> Explicitly use the pinctrl to set/unset the right mode
> instead of relying on the pinctrl init mode.
> And it requires setting the tshut polarity before select pinctrl.
> 
> When the temperature sensor mode is set to 0, it will automatically
> reset the board via the Clock-Reset-Unit (CRU) if the over temperature
> threshold is reached. However, when the pinctrl initializes, it does a
> transition to "otp_out" which may lead the SoC restart all the time.
> 
> "otp_out" IO may be connected to the RESET circuit on the hardware.
> If the IO is in the wrong state, it will trigger RESET.
> (similar to the effect of pressing the RESET button)
> which will cause the soc to restart all the time.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  drivers/thermal/rockchip_thermal.c | 36 +++++++++++++++++++++++++++++++++---
>  1 file changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> index 9c7643d62ed7..6dc7fc516abf 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -172,6 +172,9 @@ struct rockchip_thermal_data {
>  	int tshut_temp;
>  	enum tshut_mode tshut_mode;
>  	enum tshut_polarity tshut_polarity;
> +	struct pinctrl *pinctrl;
> +	struct pinctrl_state *gpio_state;
> +	struct pinctrl_state *otp_state;
>  };
>  
>  /**
> @@ -1242,6 +1245,8 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
>  		return error;
>  	}
>  
> +	thermal->chip->control(thermal->regs, false);
> +
>  	error = clk_prepare_enable(thermal->clk);
>  	if (error) {
>  		dev_err(&pdev->dev, "failed to enable converter clock: %d\n",
> @@ -1267,6 +1272,30 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
>  	thermal->chip->initialize(thermal->grf, thermal->regs,
>  				  thermal->tshut_polarity);
>  
> +	if (thermal->tshut_mode == TSHUT_MODE_GPIO) {
> +		thermal->pinctrl = devm_pinctrl_get(&pdev->dev);
> +		if (IS_ERR(thermal->pinctrl)) {
> +			dev_err(&pdev->dev, "failed to find thermal pinctrl\n");
> +			return PTR_ERR(thermal->pinctrl);
> +		}
> +
> +		thermal->gpio_state = pinctrl_lookup_state(thermal->pinctrl,
> +							   "gpio");
> +		if (IS_ERR_OR_NULL(thermal->gpio_state)) {
> +			dev_err(&pdev->dev, "failed to find thermal gpio state\n");
> +			return -EINVAL;
> +		}
> +
> +		thermal->otp_state = pinctrl_lookup_state(thermal->pinctrl,
> +							  "otpout");
> +		if (IS_ERR_OR_NULL(thermal->otp_state)) {
> +			dev_err(&pdev->dev, "failed to find thermal otpout state\n");
> +			return -EINVAL;
> +		}
> +
> +		pinctrl_select_state(thermal->pinctrl, thermal->otp_state);
> +	}
> +
>  	for (i = 0; i < thermal->chip->chn_num; i++) {
>  		error = rockchip_thermal_register_sensor(pdev, thermal,
>  						&thermal->sensors[i],
> @@ -1337,8 +1366,8 @@ static int __maybe_unused rockchip_thermal_suspend(struct device *dev)
>  
>  	clk_disable(thermal->pclk);
>  	clk_disable(thermal->clk);
> -
> -	pinctrl_pm_select_sleep_state(dev);
> +	if (thermal->tshut_mode == TSHUT_MODE_GPIO)
> +		pinctrl_select_state(thermal->pinctrl, thermal->gpio_state);
>  
>  	return 0;
>  }
> @@ -1383,7 +1412,8 @@ static int __maybe_unused rockchip_thermal_resume(struct device *dev)
>  	for (i = 0; i < thermal->chip->chn_num; i++)
>  		rockchip_thermal_toggle_sensor(&thermal->sensors[i], true);
>  
> -	pinctrl_pm_select_default_state(dev);
> +	if (thermal->tshut_mode == TSHUT_MODE_GPIO)
> +		pinctrl_select_state(thermal->pinctrl, thermal->otp_state);
>  
>  	return 0;
>  }
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

