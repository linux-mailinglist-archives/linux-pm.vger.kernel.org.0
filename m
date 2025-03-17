Return-Path: <linux-pm+bounces-24152-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC0DA64D2D
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 12:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E4CF3B5276
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 11:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11F22343AF;
	Mon, 17 Mar 2025 11:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="AGIi57Xh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7C92080C1
	for <linux-pm@vger.kernel.org>; Mon, 17 Mar 2025 11:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742212090; cv=none; b=b+gJ10lQCcs0AuhfQUj8Intt9uUXzY+niXCE/aGgWxI9m01YatnY4bcJnwQb+dAbp+D/XwatLJsnDsE28t+Ek0LKrSkGfGSBUYIswNl22VgBMXE2NfJyl7f5lQUKLuTM0gFnszk41XQFyQLDdfU81naShtjAB/Tb3VN2ubHE/aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742212090; c=relaxed/simple;
	bh=0V8Kpv3GRconCqA+yTaYkzmha0LljPTt+ZO2xmG2Ppg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X8QWICXSveQVLxIg8LqkLJ4z/UG94+7KJJ7mA9XUrDoE5uhv+E+R+n1v+2uBcpcR7883iUiKB3Bthe6J8U73NYkKnieCRJ8AxN5h/Ip+UW9kOIYBmk5d2KXEUw+LUpqIDTHNVzsC0MLeJ6yPNAOmG1NX39gRPq4omqMBG/FVW4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=AGIi57Xh; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1742212086;
 bh=HEOVbh7gUdGpeV0lk7aQTpECpLg2DtqXrUEnTsWW+ag=;
 b=AGIi57XhqUt82sgAO/mujiEEpLf9y90F8elPfJlzCQrNRWxScwfl4zQoeDX1xUuZhb9RiKnMX
 7Uz0UEtw8cjWeJTVrTjtLcbY3E0LWe19Fyd4cKH8e/Ki1kjsp0N70864xMsbY+o/qAFcq6w5pGU
 cccezGVwcRxEpnCCCd+/8yyF6Ha/caKDclhKLFzLPvAB74wNZU8QQel9IszAnGaPGXQQrXUTU7X
 cqGFDz4GpMGop4afVZJ7f5KQukfuusmAON/AAcUUFM8L0zPZJlzXQr/MBvikRShMnqZD6OttoRA
 YTJzy23Zj2kclMfFm97CPUAHFNunGvTgXkaRJrB2Z6zw==
X-Forward-Email-ID: 67d80befc3abe04af72034b8
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <ba057235-85d4-4635-87ad-741e369904f3@kwiboo.se>
Date: Mon, 17 Mar 2025 12:47:52 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] thermal: rockchip: Support RK3576 SoC in the
 thermal driver
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Ye Zhang <ye.zhang@rock-chips.com>, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org, Sebastian Reichel
 <sebastian.reichel@collabora.com>, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com,
 linux-arm-kernel@lists.infradead.org
References: <20250228-rk3576-tsadc-upstream-v3-0-4bfbb3b699b9@collabora.com>
 <20250228-rk3576-tsadc-upstream-v3-3-4bfbb3b699b9@collabora.com>
 <6c355664-50dd-4efd-94b7-9d93c02d3e80@kwiboo.se>
 <4994384.31r3eYUQgx@workhorse>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <4994384.31r3eYUQgx@workhorse>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Nicolas,

On 2025-03-17 09:28, Nicolas Frattaroli wrote:
> On Saturday, 15 March 2025 09:20:07 Central European Standard Time Jonas 
> Karlman wrote:
>> Hi Nicolas,
> 
> Hi Jonas,
> 
>>
>> On 2025-02-28 21:06, Nicolas Frattaroli wrote:
>>> From: Ye Zhang <ye.zhang@rock-chips.com>
>>>
>>> The RK3576 SoC has six TS-ADC channels: TOP, BIG_CORE, LITTLE_CORE,
>>> DDR, NPU and GPU.
>>>
>>> Signed-off-by: Ye Zhang <ye.zhang@rock-chips.com>
>>> [ported to mainline, reworded commit message]
>>> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
>>> ---
>>>
>>>  drivers/thermal/rockchip_thermal.c | 42
>>>  ++++++++++++++++++++++++++++++++++++++ 1 file changed, 42 insertions(+)
>>>
>>> diff --git a/drivers/thermal/rockchip_thermal.c
>>> b/drivers/thermal/rockchip_thermal.c index
>>> a8ad85feb68fbb7ec8d79602b16c47838ecb3c00..bec1930bebd87859a7e519cfc9f05e1
>>> 0b1c31e87 100644 --- a/drivers/thermal/rockchip_thermal.c
>>> +++ b/drivers/thermal/rockchip_thermal.c
>>> @@ -1061,6 +1061,22 @@ static void rk_tsadcv3_tshut_mode(int chn, void
>>> __iomem *regs,> 
>>>  	writel_relaxed(val_cru, regs + TSADCV3_HSHUT_CRU_INT_EN);
>>>  
>>>  }
>>>
>>> +static void rk_tsadcv4_tshut_mode(int chn, void __iomem *regs,
>>> +				  enum tshut_mode mode)
>>> +{
>>> +	u32 val_gpio, val_cru;
>>> +
>>> +	if (mode == TSHUT_MODE_GPIO) {
>>> +		val_gpio = TSADCV2_INT_SRC_EN(chn) | 
> TSADCV2_INT_SRC_EN_MASK(chn);
>>> +		val_cru = TSADCV2_INT_SRC_EN_MASK(chn);
>>> +	} else {
>>> +		val_cru = TSADCV2_INT_SRC_EN(chn) | 
> TSADCV2_INT_SRC_EN_MASK(chn);
>>> +		val_gpio = TSADCV2_INT_SRC_EN_MASK(chn);
>>> +	}
>>> +	writel_relaxed(val_gpio, regs + TSADCV3_HSHUT_GPIO_INT_EN);
>>> +	writel_relaxed(val_cru, regs + TSADCV3_HSHUT_CRU_INT_EN);
>>> +}
>>
>> This function is identical to rk_tsadcv3_tshut_mode() in mainline.
>>
>> Should the v3 function be renamed to v4 in mainline to match vendor
>> kernel to avoid confusion?
> 
> Good catch. Yes, I'll add a patch to rename the function before introducing 
> new changes in v4, and get rid of the duplicate function.

Great.

> 
>>
>>> +
>>>
>>>  static const struct rockchip_tsadc_chip px30_tsadc_data = {
>>>  
>>>  	/* cpu, gpu */
>>>  	.chn_offset = 0,
>>>
>>> @@ -1284,6 +1300,28 @@ static const struct rockchip_tsadc_chip
>>> rk3568_tsadc_data = {> 
>>>  	},
>>>  
>>>  };
>>>
>>> +static const struct rockchip_tsadc_chip rk3576_tsadc_data = {
>>> +	/* top, big_core, little_core, ddr, npu, gpu */
>>> +	.chn_offset = 0,
>>> +	.chn_num = 6, /* six channels for tsadc */
>>> +	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC 
> */
>>> +	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
>>> +	.tshut_temp = 95000,
>>
>> Here the default is GPIO and 95 deg, in DT node the default is override
>> to CRU and 120 deg.
>>
>> Any reason that is not the default here?
> 
> No reason, other than that this is what most Rockchip SoCs seem to do. RK3588 
> does the same thing. The hardware power-on-reset state is to not have any 
> tshut, so whatever the "default" should be is entirely made up by the driver 
> in either case.
> 
> For the sake of being consistent, I'll keep it the same in v4, as RK3588 does. 
> Otherwise, we'll have RK3576 and RK3588 do different things. If someone wants 
> to change the default, then ideally this would be done in a follow-up series 
> to make it consistent for all SoCs.
> 
> If that's alright with you, then I'll send out a v4.

Sounds good, I was mostly wondering because I am preparing patches for
RK3528 and it felt strange to define one default in driver and directly
override that default in DT to something different.

Also noticed that this driver log a warning when the DT props are
missing, something that probably should be downgraded as the props are
optional in DT schema. Something for another series.

Regards,
Jonas

> 
>>
>> Regards,
>> Jonas
>>
> 
> Regards,
> Nicolas Frattaroli
> 
>>> +	.initialize = rk_tsadcv8_initialize,
>>> +	.irq_ack = rk_tsadcv4_irq_ack,
>>> +	.control = rk_tsadcv4_control,
>>> +	.get_temp = rk_tsadcv4_get_temp,
>>> +	.set_alarm_temp = rk_tsadcv3_alarm_temp,
>>> +	.set_tshut_temp = rk_tsadcv3_tshut_temp,
>>> +	.set_tshut_mode = rk_tsadcv4_tshut_mode,
>>> +	.table = {
>>> +		.id = rk3588_code_table,
>>> +		.length = ARRAY_SIZE(rk3588_code_table),
>>> +		.data_mask = TSADCV4_DATA_MASK,
>>> +		.mode = ADC_INCREMENT,
>>> +	},
>>> +};
>>> +
>>>
>>>  static const struct rockchip_tsadc_chip rk3588_tsadc_data = {
>>>  
>>>  	/* top, big_core0, big_core1, little_core, center, gpu, npu */
>>>  	.chn_offset = 0,
>>>
>>> @@ -1342,6 +1380,10 @@ static const struct of_device_id
>>> of_rockchip_thermal_match[] = {> 
>>>  		.compatible = "rockchip,rk3568-tsadc",
>>>  		.data = (void *)&rk3568_tsadc_data,
>>>  	
>>>  	},
>>>
>>> +	{
>>> +		.compatible = "rockchip,rk3576-tsadc",
>>> +		.data = (void *)&rk3576_tsadc_data,
>>> +	},
>>>
>>>  	{
>>>  	
>>>  		.compatible = "rockchip,rk3588-tsadc",
>>>  		.data = (void *)&rk3588_tsadc_data,
> 
> 
> 
> 


