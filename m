Return-Path: <linux-pm+bounces-25499-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39111A8A9F0
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 23:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E899190236B
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 21:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AA825F99C;
	Tue, 15 Apr 2025 21:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="cQFHyKQ+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB6B257443
	for <linux-pm@vger.kernel.org>; Tue, 15 Apr 2025 21:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744751716; cv=none; b=PQw4ddy3ghO8IJpwbKNKbaP1SMOXR325JotNRP0pGRV4K7gSJ9RYED3WfkkfzyHzQHbyKkiI1XOc4nf1W1iRhgzZhEd4PoAy/4cHHncTCNkzdayAn17zbkKFXKskVSU3P8z5blLVHFOwKVxugYvGef2bvyNWJYdXUj4GznUWe4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744751716; c=relaxed/simple;
	bh=zMVcXFHYVJjFBimj6JogfsbaQ2BSuIvcWzg7Gx1Wrdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eotusqxm54Q1QVEIUsBWvIwVZsbxXm/6J7dMtGcjYrov6g8B5AW/eZRgN4h1SW+yZdrGUnw7wm9/8L4CsRHgKZWxokU6+zp08OEEMLFgpX8mFLYZpWs+Mfsbt0GieJJhqiVi5EDRXVkjKxQ4BJ/lhzjNXd/2VVcDNvIC9HF+S+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=cQFHyKQ+; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1744751706;
 bh=IAeshu1rPRVwkbSbcg36lO4ijxbO9PeaGLWgVnDeV5c=;
 b=cQFHyKQ+LshwTyALuunpYkfRaTfFArzM2nDhdZfWrkMmKE6syAmKAhOBWEfWwKI2cHU4VNBMe
 5w8xIWxXwSRzYerlTtjyj1czPS8nXElE0y6P3lc6qfJ7/tKk79ZJ58AN8zoZuCu/cFGP0OgIutM
 VADQk3V7pgQUUqhxgogmiABW51eE3ucJeu7RqK6pIuyGC6SpeD9gNF86HIJMYWADAf8Qi1Far4J
 blHIx1MpgETwmXltn033UN8/Rgt7plUjXGFQxEcMyo9/Gf1SzOvWyVxcXxuPugpKWhaj33DleFS
 aWpUaFFz0JvrT3dlYqAuGTiLyBDTt/W1zkzMNTJWFBaA==
X-Forward-Email-ID: 67fecc56f405d8e4e0433b24
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <7e5ac4a8-6188-447b-8041-89ea00ca1576@kwiboo.se>
Date: Tue, 15 Apr 2025 23:14:58 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] thermal: rockchip: Add support for rk3562 SoC
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, heiko@sntech.de,
 linux-rockchip@lists.infradead.org, Shaohan Yao
 <shaohan.yao@rock-chips.com>, linux-pm@vger.kernel.org,
 Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
 Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>
References: <20250415033940.47914-1-kever.yang@rock-chips.com>
 <20250415033940.47914-2-kever.yang@rock-chips.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250415033940.47914-2-kever.yang@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kever,

On 2025-04-15 05:39, Kever Yang wrote:
> From: Shaohan Yao <shaohan.yao@rock-chips.com>
> 
> There is one Temperature Sensor with channel 0 on rk3562 SoC.
> This driver adds the mapping table as-is from the TRM so that we can
> always sync to the TRM once there have any change in the future.
> 
> Signed-off-by: Shaohan Yao <shaohan.yao@rock-chips.com>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> 
> Changes in v2:
> - Update the commit message
> 
>  drivers/thermal/rockchip_thermal.c | 112 ++++++++++++++++++++++++++++-
>  1 file changed, 111 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> index a8ad85feb68f..3278472b06f9 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Copyright (c) 2014-2016, Fuzhou Rockchip Electronics Co., Ltd
> + * Copyright (c) 2014-2021, Fuzhou Rockchip Electronics Co., Ltd.
> + * Copyright (c) 2021-2024, Rockchip Electronics Co., Ltd.
>   * Caesar Wang <wxt@rock-chips.com>
>   */
>  
> @@ -185,6 +186,8 @@ struct rockchip_thermal_data {
>  #define TSADCV2_AUTO_PERIOD_HT			0x6c
>  #define TSADCV3_AUTO_PERIOD			0x154
>  #define TSADCV3_AUTO_PERIOD_HT			0x158
> +#define TSADCV9_Q_MAX				0x210
> +#define TSADCV9_FLOW_CON			0x218
>  
>  #define TSADCV2_AUTO_EN				BIT(0)
>  #define TSADCV2_AUTO_EN_MASK			BIT(16)
> @@ -195,6 +198,7 @@ struct rockchip_thermal_data {
>  #define TSADCV2_AUTO_TSHUT_POLARITY_MASK	BIT(24)
>  
>  #define TSADCV3_AUTO_Q_SEL_EN			BIT(1)
> +#define TSADCV3_AUTO_Q_SEL_EN_MASK		BIT(17)
>  
>  #define TSADCV2_INT_SRC_EN(chn)			BIT(chn)
>  #define TSADCV2_INT_SRC_EN_MASK(chn)		BIT(16 + (chn))
> @@ -220,6 +224,12 @@ struct rockchip_thermal_data {
>  #define TSADCV5_AUTO_PERIOD_HT_TIME		1622 /* 2.5ms */
>  #define TSADCV6_AUTO_PERIOD_TIME		5000 /* 2.5ms */
>  #define TSADCV6_AUTO_PERIOD_HT_TIME		5000 /* 2.5ms */
> +#define TSADCV7_AUTO_PERIOD_TIME		3000 /* 2.5ms */
> +#define TSADCV7_AUTO_PERIOD_HT_TIME		3000 /* 2.5ms */
> +#define TSADCV12_AUTO_PERIOD_TIME		3000 /* 2.5ms */
> +#define TSADCV12_AUTO_PERIOD_HT_TIME		3000 /* 2.5ms */
> +#define TSADCV3_Q_MAX_VAL			0x7ff /* 11bit 2047 */
> +#define TSADCV12_Q_MAX_VAL			0xfff /* 12bit 4095 */
>  
>  #define TSADCV2_USER_INTER_PD_SOC		0x340 /* 13 clocks */
>  #define TSADCV5_USER_INTER_PD_SOC		0xfc0 /* 97us, at least 90us */
> @@ -230,6 +240,8 @@ struct rockchip_thermal_data {
>  
>  #define PX30_GRF_SOC_CON2			0x0408
>  
> +#define RK3562_GRF_TSADC_CON			0x0580
> +
>  #define RK3568_GRF_TSADC_CON			0x0600
>  #define RK3568_GRF_TSADC_ANA_REG0		(0x10001 << 0)
>  #define RK3568_GRF_TSADC_ANA_REG1		(0x10001 << 1)
> @@ -498,6 +510,45 @@ static const struct tsadc_table rk3399_code_table[] = {
>  	{TSADCV3_DATA_MASK, 125000},
>  };
>  
> +static const struct tsadc_table rk3562_code_table[] = {
> +	{0, -40000},
> +	{1419, -40000},
> +	{1428, -35000},
> +	{1436, -30000},
> +	{1445, -25000},
> +	{1453, -20000},
> +	{1462, -15000},
> +	{1470, -10000},
> +	{1479, -5000},
> +	{1487, 0},
> +	{1496, 5000},
> +	{1504, 10000},
> +	{1512, 15000},
> +	{1521, 20000},
> +	{1529, 25000},
> +	{1538, 30000},
> +	{1546, 35000},
> +	{1555, 40000},
> +	{1563, 45000},
> +	{1572, 50000},
> +	{1580, 55000},
> +	{1589, 60000},
> +	{1598, 65000},
> +	{1606, 70000},
> +	{1615, 75000},
> +	{1623, 80000},
> +	{1632, 85000},
> +	{1640, 90000},
> +	{1648, 95000},
> +	{1657, 100000},
> +	{1666, 105000},
> +	{1674, 110000},
> +	{1682, 115000},
> +	{1691, 120000},
> +	{1699, 125000},
> +	{TSADCV2_DATA_MASK, 125000},
> +};
> +
>  static const struct tsadc_table rk3568_code_table[] = {
>  	{0, -40000},
>  	{1584, -40000},
> @@ -835,6 +886,37 @@ static void rk_tsadcv8_initialize(struct regmap *grf, void __iomem *regs,
>  			       regs + TSADCV2_AUTO_CON);
>  }
>  
> +static void rk_tsadcv12_initialize(struct regmap *grf, void __iomem *regs,
> +				   enum tshut_polarity tshut_polarity)
> +{
> +	writel_relaxed(TSADCV12_AUTO_PERIOD_TIME, regs + TSADCV3_AUTO_PERIOD);
> +	writel_relaxed(TSADCV12_AUTO_PERIOD_HT_TIME,
> +		       regs + TSADCV3_AUTO_PERIOD_HT);
> +	writel_relaxed(TSADCV2_HIGHT_INT_DEBOUNCE_COUNT,
> +		       regs + TSADCV3_HIGHT_INT_DEBOUNCE);
> +	writel_relaxed(TSADCV2_HIGHT_TSHUT_DEBOUNCE_COUNT,
> +		       regs + TSADCV3_HIGHT_TSHUT_DEBOUNCE);
> +	writel_relaxed(TSADCV12_Q_MAX_VAL, regs + TSADCV9_Q_MAX);
> +	writel_relaxed(TSADCV3_AUTO_Q_SEL_EN | TSADCV3_AUTO_Q_SEL_EN_MASK,
> +		       regs + TSADCV2_AUTO_CON);
> +	if (tshut_polarity == TSHUT_HIGH_ACTIVE)
> +		writel_relaxed(TSADCV2_AUTO_TSHUT_POLARITY_HIGH |
> +			       TSADCV2_AUTO_TSHUT_POLARITY_MASK,
> +			       regs + TSADCV2_AUTO_CON);
> +	else
> +		writel_relaxed(TSADCV2_AUTO_TSHUT_POLARITY_MASK,
> +			       regs + TSADCV2_AUTO_CON);
> +
> +	if (!IS_ERR(grf)) {
> +		regmap_write(grf, RK3562_GRF_TSADC_CON, RK3568_GRF_TSADC_TSEN);
> +		udelay(15);
> +		regmap_write(grf, RK3562_GRF_TSADC_CON, RK3568_GRF_TSADC_ANA_REG0);
> +		regmap_write(grf, RK3562_GRF_TSADC_CON, RK3568_GRF_TSADC_ANA_REG1);
> +		regmap_write(grf, RK3562_GRF_TSADC_CON, RK3568_GRF_TSADC_ANA_REG2);
> +		usleep_range(100, 200);
> +	}
> +}
> +
>  static void rk_tsadcv2_irq_ack(void __iomem *regs)
>  {
>  	u32 val;
> @@ -1259,6 +1341,30 @@ static const struct rockchip_tsadc_chip rk3399_tsadc_data = {
>  	},
>  };
>  
> +static const struct rockchip_tsadc_chip rk3562_tsadc_data = {
> +	.chn_offset = 0,
> +	.chn_num = 1, /* one channels for tsadc */
> +
> +	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
> +	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */

Vendor kernel seem to set following in DT for RK3562:

  rockchip,hw-tshut-mode = <0>; /* tshut mode 0:CRU 1:GPIO */
  rockchip,hw-tshut-polarity = <0>; /* tshut polarity 0:LOW 1:HIGH */

Why not adjust the default tshut_mode to match what is default used in
DT for this SoC i.e. TSHUT_MODE_CRU?

> +	.tshut_temp = 95000,

Similar here, for all/most SoCs the default in the driver is 95 deg and
then SoC DTs override and set a higher default, e.g.:

  rockchip,hw-tshut-temp = <120000>;

Is there any specific reason for this? Or just how it has ended up for
all SoCs?

I have a few pending patches for adding tsadc support for RK3528 [1]
that was waiting on the updated RK3562 OTP series, and for RK3528 I
changed to use CRU as default tshut_mode but kept the 95 deg default in
driver.

[1] https://github.com/Kwiboo/linux-rockchip/commits/next-20250319-rk3528/

> +
> +	.initialize = rk_tsadcv12_initialize,
> +	.irq_ack = rk_tsadcv4_irq_ack,
> +	.control = rk_tsadcv4_control,
> +	.get_temp = rk_tsadcv4_get_temp,
> +	.set_alarm_temp = rk_tsadcv3_alarm_temp,
> +	.set_tshut_temp = rk_tsadcv3_tshut_temp,
> +	.set_tshut_mode = rk_tsadcv3_tshut_mode,

I suggest you rebase this on top of Nicolas Frattaroli's RK3576 tsadc
series [2] and add support for RK3562 trim values in next version.

This rk_tsadcv3_tshut_mode is e.g. renamed to match the v4 name used by
the vendor kernel.

[2] https://lore.kernel.org/all/20250317-rk3576-tsadc-upstream-v4-0-c5029ce55d74@collabora.com/

Regards,
Jonas

> +
> +	.table = {
> +		.id = rk3562_code_table,
> +		.length = ARRAY_SIZE(rk3562_code_table),
> +		.data_mask = TSADCV2_DATA_MASK,
> +		.mode = ADC_INCREMENT,
> +	},
> +};
> +
>  static const struct rockchip_tsadc_chip rk3568_tsadc_data = {
>  	/* cpu, gpu */
>  	.chn_offset = 0,
> @@ -1338,6 +1444,10 @@ static const struct of_device_id of_rockchip_thermal_match[] = {
>  		.compatible = "rockchip,rk3399-tsadc",
>  		.data = (void *)&rk3399_tsadc_data,
>  	},
> +	{
> +		.compatible = "rockchip,rk3562-tsadc",
> +		.data = (void *)&rk3562_tsadc_data,
> +	},
>  	{
>  		.compatible = "rockchip,rk3568-tsadc",
>  		.data = (void *)&rk3568_tsadc_data,


