Return-Path: <linux-pm+bounces-24136-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7128EA64566
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 09:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B65D6169408
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 08:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3FF21D3D6;
	Mon, 17 Mar 2025 08:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="SfnqWs2y"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAC5946F;
	Mon, 17 Mar 2025 08:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742200173; cv=pass; b=TMU7YnHq7a2eQGzNdtu3kkP97rAaPRdA8vALwwQiqN4OOozVuo591IXfrdO08HWCKbZ4wnOoYAJ5WK1GYbHxKll4rRkucc+EyM9RdlzHa24vhItulIUYvvbOXaZucbYXygzB7sAMZbzpYv4+B9Oz/ahG07WnGUfw5IAOfq8JRyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742200173; c=relaxed/simple;
	bh=ckHakReN3TIvJFh4lVS1/knrUrhDGp4A/nxraD8nAH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eNga4abtFtKkIYcB72mWaJJnC67kR15rCH5/lgYocjWPlWYvWr/RjHopgriCaKP0Df07tauQDX4nAOq26csPRQvolGjInABqX1GnFbvrWtb9mPe3kUP07Mdv/8OZJiiBb7Ti+Dd4DdUc2k4r1t/MboLTe0vG+N1CjyyGOlAyBE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=SfnqWs2y; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742200143; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MPDA5DZeNkMr9rXs6kPXA0kyKfA3zFfmllIuxWqruuD2wYlhBnAUVAhIWdsgn0V5fVWmqDXCPwDpCdU89wXd1DuXrYRLeiW5SkvSE0GfZwNIyjqF+tOa7cTrg1+q1WUK6Rbd3peDTmZ1ygGmc2EfqlkjdxU+7MlYCammRuwMvcE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742200143; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=umuvK91DZgNUVvUrd/naQBA7f7ASrvoD/6ljA2wUXb0=; 
	b=muW4EKoqaUzjoOkFOGYoy7iBogtgRbYu/H95/L89kSh6fH4eyUbg94LXK0qmTmINYLVIgskYARjT6KX0SpJ6JJDxhYFqAqpVC2S/4YLWAmfHx3BdsxXfWOZ6nLaqI+PtffZNGVysLVRYG36UvdSdsvzG2fPTsIeCSGErCCMsFSY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742200143;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=umuvK91DZgNUVvUrd/naQBA7f7ASrvoD/6ljA2wUXb0=;
	b=SfnqWs2ylGqsqOU2b0RitTxMEVjKYpCIaFFF+tZNh/FiAGGcLn2QYDT1/U6KEU3v
	661KUzgcStvEt2+xhC/z6ZclltMc3urBBG+an/enoLsPa5zajUDDozoLu32LiWUCoHA
	vtY6RzL6jrfEjWBJrJs3tXJbi6rpTwowpnUXqJ9I=
Received: by mx.zohomail.com with SMTPS id 1742200141185867.5196911777422;
	Mon, 17 Mar 2025 01:29:01 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Ye Zhang <ye.zhang@rock-chips.com>,
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 kernel@collabora.com, linux-arm-kernel@lists.infradead.org
Subject:
 Re: [PATCH v3 3/6] thermal: rockchip: Support RK3576 SoC in the thermal
 driver
Date: Mon, 17 Mar 2025 09:28:55 +0100
Message-ID: <4994384.31r3eYUQgx@workhorse>
In-Reply-To: <6c355664-50dd-4efd-94b7-9d93c02d3e80@kwiboo.se>
References:
 <20250228-rk3576-tsadc-upstream-v3-0-4bfbb3b699b9@collabora.com>
 <20250228-rk3576-tsadc-upstream-v3-3-4bfbb3b699b9@collabora.com>
 <6c355664-50dd-4efd-94b7-9d93c02d3e80@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Saturday, 15 March 2025 09:20:07 Central European Standard Time Jonas 
Karlman wrote:
> Hi Nicolas,

Hi Jonas,

> 
> On 2025-02-28 21:06, Nicolas Frattaroli wrote:
> > From: Ye Zhang <ye.zhang@rock-chips.com>
> > 
> > The RK3576 SoC has six TS-ADC channels: TOP, BIG_CORE, LITTLE_CORE,
> > DDR, NPU and GPU.
> > 
> > Signed-off-by: Ye Zhang <ye.zhang@rock-chips.com>
> > [ported to mainline, reworded commit message]
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > ---
> > 
> >  drivers/thermal/rockchip_thermal.c | 42
> >  ++++++++++++++++++++++++++++++++++++++ 1 file changed, 42 insertions(+)
> > 
> > diff --git a/drivers/thermal/rockchip_thermal.c
> > b/drivers/thermal/rockchip_thermal.c index
> > a8ad85feb68fbb7ec8d79602b16c47838ecb3c00..bec1930bebd87859a7e519cfc9f05e1
> > 0b1c31e87 100644 --- a/drivers/thermal/rockchip_thermal.c
> > +++ b/drivers/thermal/rockchip_thermal.c
> > @@ -1061,6 +1061,22 @@ static void rk_tsadcv3_tshut_mode(int chn, void
> > __iomem *regs,> 
> >  	writel_relaxed(val_cru, regs + TSADCV3_HSHUT_CRU_INT_EN);
> >  
> >  }
> > 
> > +static void rk_tsadcv4_tshut_mode(int chn, void __iomem *regs,
> > +				  enum tshut_mode mode)
> > +{
> > +	u32 val_gpio, val_cru;
> > +
> > +	if (mode == TSHUT_MODE_GPIO) {
> > +		val_gpio = TSADCV2_INT_SRC_EN(chn) | 
TSADCV2_INT_SRC_EN_MASK(chn);
> > +		val_cru = TSADCV2_INT_SRC_EN_MASK(chn);
> > +	} else {
> > +		val_cru = TSADCV2_INT_SRC_EN(chn) | 
TSADCV2_INT_SRC_EN_MASK(chn);
> > +		val_gpio = TSADCV2_INT_SRC_EN_MASK(chn);
> > +	}
> > +	writel_relaxed(val_gpio, regs + TSADCV3_HSHUT_GPIO_INT_EN);
> > +	writel_relaxed(val_cru, regs + TSADCV3_HSHUT_CRU_INT_EN);
> > +}
> 
> This function is identical to rk_tsadcv3_tshut_mode() in mainline.
> 
> Should the v3 function be renamed to v4 in mainline to match vendor
> kernel to avoid confusion?

Good catch. Yes, I'll add a patch to rename the function before introducing 
new changes in v4, and get rid of the duplicate function.

> 
> > +
> > 
> >  static const struct rockchip_tsadc_chip px30_tsadc_data = {
> >  
> >  	/* cpu, gpu */
> >  	.chn_offset = 0,
> > 
> > @@ -1284,6 +1300,28 @@ static const struct rockchip_tsadc_chip
> > rk3568_tsadc_data = {> 
> >  	},
> >  
> >  };
> > 
> > +static const struct rockchip_tsadc_chip rk3576_tsadc_data = {
> > +	/* top, big_core, little_core, ddr, npu, gpu */
> > +	.chn_offset = 0,
> > +	.chn_num = 6, /* six channels for tsadc */
> > +	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC 
*/
> > +	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
> > +	.tshut_temp = 95000,
> 
> Here the default is GPIO and 95 deg, in DT node the default is override
> to CRU and 120 deg.
> 
> Any reason that is not the default here?

No reason, other than that this is what most Rockchip SoCs seem to do. RK3588 
does the same thing. The hardware power-on-reset state is to not have any 
tshut, so whatever the "default" should be is entirely made up by the driver 
in either case.

For the sake of being consistent, I'll keep it the same in v4, as RK3588 does. 
Otherwise, we'll have RK3576 and RK3588 do different things. If someone wants 
to change the default, then ideally this would be done in a follow-up series 
to make it consistent for all SoCs.

If that's alright with you, then I'll send out a v4.

> 
> Regards,
> Jonas
> 

Regards,
Nicolas Frattaroli

> > +	.initialize = rk_tsadcv8_initialize,
> > +	.irq_ack = rk_tsadcv4_irq_ack,
> > +	.control = rk_tsadcv4_control,
> > +	.get_temp = rk_tsadcv4_get_temp,
> > +	.set_alarm_temp = rk_tsadcv3_alarm_temp,
> > +	.set_tshut_temp = rk_tsadcv3_tshut_temp,
> > +	.set_tshut_mode = rk_tsadcv4_tshut_mode,
> > +	.table = {
> > +		.id = rk3588_code_table,
> > +		.length = ARRAY_SIZE(rk3588_code_table),
> > +		.data_mask = TSADCV4_DATA_MASK,
> > +		.mode = ADC_INCREMENT,
> > +	},
> > +};
> > +
> > 
> >  static const struct rockchip_tsadc_chip rk3588_tsadc_data = {
> >  
> >  	/* top, big_core0, big_core1, little_core, center, gpu, npu */
> >  	.chn_offset = 0,
> > 
> > @@ -1342,6 +1380,10 @@ static const struct of_device_id
> > of_rockchip_thermal_match[] = {> 
> >  		.compatible = "rockchip,rk3568-tsadc",
> >  		.data = (void *)&rk3568_tsadc_data,
> >  	
> >  	},
> > 
> > +	{
> > +		.compatible = "rockchip,rk3576-tsadc",
> > +		.data = (void *)&rk3576_tsadc_data,
> > +	},
> > 
> >  	{
> >  	
> >  		.compatible = "rockchip,rk3588-tsadc",
> >  		.data = (void *)&rk3588_tsadc_data,





