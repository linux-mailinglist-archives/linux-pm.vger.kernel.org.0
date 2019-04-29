Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8647DFCE
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2019 11:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbfD2JwC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Apr 2019 05:52:02 -0400
Received: from regular1.263xmail.com ([211.150.70.205]:34328 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbfD2JwB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2019 05:52:01 -0400
Received: from zhangqing?rock-chips.com (unknown [192.168.167.236])
        by regular1.263xmail.com (Postfix) with ESMTP id 3281A4A6;
        Mon, 29 Apr 2019 17:51:35 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from [172.16.12.236] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P420T140005497153280S1556531492608937_;
        Mon, 29 Apr 2019 17:51:34 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <7e1d8f2b177a105ff24d92cf140eb7b4>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: huangtao@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH v2 1/3] thermal: rockchip: fix up the tsadc pinctrl
 setting error
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, heiko@sntech.de
Cc:     rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com
References: <1556187154-22632-1-git-send-email-zhangqing@rock-chips.com>
 <1556187154-22632-2-git-send-email-zhangqing@rock-chips.com>
 <be0170d7-64dc-896d-b847-5be192304791@linaro.org>
From:   "elaine.zhang" <zhangqing@rock-chips.com>
Organization: rockchip
Message-ID: <8d41ea98-e0e8-60c8-3237-ade5d0d169bf@rock-chips.com>
Date:   Mon, 29 Apr 2019 17:51:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <be0170d7-64dc-896d-b847-5be192304791@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

hi,

在 2019/4/28 下午8:45, Daniel Lezcano 写道:
> On 25/04/2019 12:12, Elaine Zhang wrote:
>> Explicitly use the pinctrl to set/unset the right mode
>> instead of relying on the pinctrl init mode.
>> And it requires setting the tshut polarity before select pinctrl.
>>
>> When the temperature sensor mode is set to 0, it will automatically
>> reset the board via the Clock-Reset-Unit (CRU) if the over temperature
>> threshold is reached. However, when the pinctrl initializes, it does a
>> transition to "otp_out" which may lead the SoC restart all the time.
>>
>> "otp_out" IO may be connected to the RESET circuit on the hardware.
>> If the IO is in the wrong state, it will trigger RESET.
>> (similar to the effect of pressing the RESET button)
>> which will cause the soc to restart all the time.
>>
>> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
>> ---
>>   drivers/thermal/rockchip_thermal.c | 37 ++++++++++++++++++++++++++++++++++---
>>   1 file changed, 34 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
>> index 9c7643d62ed7..03ff494f2864 100644
>> --- a/drivers/thermal/rockchip_thermal.c
>> +++ b/drivers/thermal/rockchip_thermal.c
>> @@ -172,6 +172,9 @@ struct rockchip_thermal_data {
>>   	int tshut_temp;
>>   	enum tshut_mode tshut_mode;
>>   	enum tshut_polarity tshut_polarity;
>> +	struct pinctrl *pinctrl;
>> +	struct pinctrl_state *gpio_state;
>> +	struct pinctrl_state *otp_state;
>>   };
>>   
>>   /**
>> @@ -1242,6 +1245,8 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
>>   		return error;
>>   	}
>>   
>> +	thermal->chip->control(thermal->regs, false);
>> +
>>   	error = clk_prepare_enable(thermal->clk);
>>   	if (error) {
>>   		dev_err(&pdev->dev, "failed to enable converter clock: %d\n",
>> @@ -1267,6 +1272,31 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
>>   	thermal->chip->initialize(thermal->grf, thermal->regs,
>>   				  thermal->tshut_polarity);
>>   
>> +	if (thermal->tshut_mode == TSHUT_MODE_GPIO) {
>> +		thermal->pinctrl = devm_pinctrl_get(&pdev->dev);
>> +		if (IS_ERR(thermal->pinctrl)) {
>> +			dev_err(&pdev->dev, "failed to find thermal pinctrl\n");
>> +			panic("panic_on_find thermal pinctrl...\n");
> I realize my comment was confusing. I was not saying to add a panic()
> call here but that the code was accessing a NULL pointer. Please remove
> the panic.
OK, I'll fixed it.
>
>> +			return PTR_ERR(thermal->pinctrl);
>> +		}
>> +
>> +		thermal->gpio_state = pinctrl_lookup_state(thermal->pinctrl,
>> +							   "gpio");
>> +		if (IS_ERR_OR_NULL(thermal->gpio_state)) {
>> +			dev_err(&pdev->dev, "failed to find thermal gpio state\n");
>> +			return -EINVAL;
>> +		}
>> +
>> +		thermal->otp_state = pinctrl_lookup_state(thermal->pinctrl,
>> +							  "otpout");
>> +		if (IS_ERR_OR_NULL(thermal->otp_state)) {
>> +			dev_err(&pdev->dev, "failed to find thermal otpout state\n");
>> +			return -EINVAL;
>> +		}
>> +
>> +		pinctrl_select_state(thermal->pinctrl, thermal->otp_state);
> I don't understand this portion of code. The test above says tshut_mode
> is TSHUT_MODE_GPIO. Why acting on thermal->otp_state then ?
>
>
> In my previous comment, I was suggesting the following:
>
> Two more fields instead of three:
>
> 	struct rockchip_thermal_data {
>    		int tshut_temp;
> 	  	enum tshut_mode tshut_mode;
>    		enum tshut_polarity tshut_polarity;
> 	 	struct pinctrl *pinctrl;
> 		struct pinctrl_state *pinctrl_state;
> 	};
>
> 	[ ... ]
>
> 	thermal->pinctrl = devm_pinctrl_get(&pdev->dev);
> 	if (IS_ERR(thermal->pinctrl)) {
> 		dev_err("...");
> 		return PTR_ERR(thermal->pinctrl);
> 	}
>
> 	thermal->pinctrl_state = pinctrl_lookup_state(thermal->pinctrl,
> 		thermal->tshut_mode == TSHUT_MODE_GPIO ? "gpio" :
> 							"otpout";
>
> 	if (IS_ERR_OR_NULL(thermal->pinctrl_state) {
> 		dev_err("...");
> 		return PTR_ERR(thermal->pinctrl_state);
> 	}
>
>   	pinctrl_select_state(thermal->pinctrl, thermal->pinctrl_state);
>
>
> 	[ ... ]
>
> Is it wrong ?
>
>
>> +	}
>> +
>>   	for (i = 0; i < thermal->chip->chn_num; i++) {
>>   		error = rockchip_thermal_register_sensor(pdev, thermal,
>>   						&thermal->sensors[i],
>> @@ -1337,8 +1367,8 @@ static int __maybe_unused rockchip_thermal_suspend(struct device *dev)
>>   
>>   	clk_disable(thermal->pclk);
>>   	clk_disable(thermal->clk);
>> -
>> -	pinctrl_pm_select_sleep_state(dev);
>> +	if (thermal->tshut_mode == TSHUT_MODE_GPIO)
>> +		pinctrl_select_state(thermal->pinctrl, thermal->gpio_state);
> And then:
> 	 pinctrl_select_state(thermal->pinctrl, thermal->pinctrl_state);

pinctrl select to gpio mode when tsadc suspend and shutdown.

When suspend, tsadc is disabled, the otp_pin should revert to the 
default gpio state.

>
>>   
>>   	return 0;
>>   }
>> @@ -1383,7 +1413,8 @@ static int __maybe_unused rockchip_thermal_resume(struct device *dev)
>>   	for (i = 0; i < thermal->chip->chn_num; i++)
>>   		rockchip_thermal_toggle_sensor(&thermal->sensors[i], true);
>>   
>> -	pinctrl_pm_select_default_state(dev);
>> +	if (thermal->tshut_mode == TSHUT_MODE_GPIO)
>> +		pinctrl_select_state(thermal->pinctrl, thermal->otp_state);
> And then
> 	pinctrl_select_state(thermal->pinctrl, thermal->pinctrl_state);

pinctrl select to otp mode when tsadc resume.

>
>>   	return 0;
>>   }
>>
>


