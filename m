Return-Path: <linux-pm+bounces-43970-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDr5I88Yr2nHNgIAu9opvQ
	(envelope-from <linux-pm+bounces-43970-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 20:00:31 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E922F23F0EF
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 20:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6E1E304209A
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2026 18:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E963ED5CB;
	Mon,  9 Mar 2026 18:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y55UqyDF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0762877CB;
	Mon,  9 Mar 2026 18:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773082743; cv=none; b=Spl0Fa5NDRoStTRdgmx3h5+5zx+bx5sMgDbfHmmphomOfRTNWGVtZhGuJLp2tIgBqWtb1pwoQ0A1APdCfL7hlxox6Yb6sniMHGBw54f7pPqPxcCYywrwfWoywtmD61EiDdpRXaMWfIp/vwhiKg02uVFQ+4aaktbVnrXxlvRESWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773082743; c=relaxed/simple;
	bh=WiTVIdFGOY5dFcjsmygUdrDkGKsEyumhe8ha+C1h9zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzzcT5hGQD0PRkxAAhUMYwAwbjvfx3hwgkdWxKmmpvA9DUwy/y7Z6h15Z8dXgSAY9QtkAVVxyVXV1ttGddG+wQokpOTjSZ0b1CZSNkcRsQFMEma/5k92SIr32PeooGOqx5D/cLkuMpZ5jeZm6YajgkoCFaWoWsYPJH2d/i4CXdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y55UqyDF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C285C4CEF7;
	Mon,  9 Mar 2026 18:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773082743;
	bh=WiTVIdFGOY5dFcjsmygUdrDkGKsEyumhe8ha+C1h9zc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y55UqyDF1oudonwv2ouDqGjJCad/eHsUHmhmtHKbVRoUV9Ddh9VcU8LaGo2fJSHz/
	 LDq1JtmEQrN2Dq4xfFrV5esHFLeA/oZz0d3YMngW3pKPFHCPG5+KzwKq8g8P88hx3i
	 fKgPvkDcTbbdMqJEaAXTTE5wsAYOdbWs/LWhRTGAY81MeLnhrUDmMXlBQd1MvaD8vI
	 T6EkiRdx8KpFTJK9520OEEeoF8Pu1NTnfAeMFI6tJkSW0Zz2hrndaUFzEfVRzzC9jR
	 d3IejX1jT9s5tY2OkepI0CJlk+/2XgRBIrIuIO3FJo2RU5SDZQhUVb1iaDX9ZdwWzb
	 sDfMFyGEj1Rcg==
Date: Mon, 9 Mar 2026 18:58:56 +0000
From: Lee Jones <lee@kernel.org>
To: Otto =?iso-8859-1?Q?Pfl=FCger?= <otto.pflueger@abscue.de>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 4/6] mfd: sprd-sc27xx: Switch to devm_mfd_add_devices()
Message-ID: <20260309185856.GZ183676@google.com>
References: <20260222-sc27xx-mfd-cells-v1-0-69526fe74c77@abscue.de>
 <20260222-sc27xx-mfd-cells-v1-4-69526fe74c77@abscue.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260222-sc27xx-mfd-cells-v1-4-69526fe74c77@abscue.de>
X-Rspamd-Queue-Id: E922F23F0EF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43970-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[bootlin.com,kernel.org,gmail.com,linux.alibaba.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[abscue.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sun, 22 Feb 2026, Otto Pflüger wrote:

> To allow instantiating subdevices such as the regulator and poweroff
> devices that do not have corresponding device tree nodes with a
> "compatible" property, use devm_mfd_add_devices() with MFD cells instead
> of devm_of_platform_populate(). Since different PMICs in the SC27xx
> series contain different components, use separate MFD cell tables for
> each PMIC model. Define cells for all components that have upstream
> drivers at this point.

We're not passing one device registration API's data (MFD)
through another (Device Tree).

Pass an identifier through and match on that instead.

Look at how all of the other drivers in MFD do it.

> Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
> ---
>  drivers/mfd/sprd-sc27xx-spi.c | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
> index d6b4350779e6..57941bec4c2e 100644
> --- a/drivers/mfd/sprd-sc27xx-spi.c
> +++ b/drivers/mfd/sprd-sc27xx-spi.c
> @@ -48,6 +48,31 @@ struct sprd_pmic_data {
>  	u32 irq_base;
>  	u32 num_irqs;
>  	u32 charger_det;
> +	const struct mfd_cell *cells;
> +	int num_cells;
> +};
> +
> +static const struct mfd_cell sc2730_devices[] = {
> +	MFD_CELL_OF("sc2730-adc", NULL, NULL, 0, 0, "sprd,sc2730-adc"),
> +	MFD_CELL_OF("sc2730-bltc", NULL, NULL, 0, 0, "sprd,sc2730-bltc"),
> +	MFD_CELL_OF("sc2730-efuse", NULL, NULL, 0, 0, "sprd,sc2730-efuse"),
> +	MFD_CELL_OF("sc2730-eic", NULL, NULL, 0, 0, "sprd,sc2730-eic"),
> +	MFD_CELL_OF("sc2730-fgu", NULL, NULL, 0, 0, "sprd,sc2730-fgu"),
> +	MFD_CELL_OF("sc2730-rtc", NULL, NULL, 0, 0, "sprd,sc2730-rtc"),
> +	MFD_CELL_OF("sc2730-vibrator", NULL, NULL, 0, 0, "sprd,sc2730-vibrator"),
> +};
> +
> +static const struct mfd_cell sc2731_devices[] = {
> +	MFD_CELL_OF("sc2731-adc", NULL, NULL, 0, 0, "sprd,sc2731-adc"),
> +	MFD_CELL_OF("sc2731-bltc", NULL, NULL, 0, 0, "sprd,sc2731-bltc"),
> +	MFD_CELL_OF("sc2731-charger", NULL, NULL, 0, 0, "sprd,sc2731-charger"),
> +	MFD_CELL_OF("sc2731-efuse", NULL, NULL, 0, 0, "sprd,sc2731-efuse"),
> +	MFD_CELL_OF("sc2731-eic", NULL, NULL, 0, 0, "sprd,sc2731-eic"),
> +	MFD_CELL_OF("sc2731-fgu", NULL, NULL, 0, 0, "sprd,sc2731-fgu"),
> +	MFD_CELL_NAME("sc2731-poweroff"),
> +	MFD_CELL_NAME("sc2731-regulator"),
> +	MFD_CELL_OF("sc2731-rtc", NULL, NULL, 0, 0, "sprd,sc2731-rtc"),
> +	MFD_CELL_OF("sc2731-vibrator", NULL, NULL, 0, 0, "sprd,sc2731-vibrator"),
>  };
>  
>  /*
> @@ -59,12 +84,16 @@ static const struct sprd_pmic_data sc2730_data = {
>  	.irq_base = SPRD_SC2730_IRQ_BASE,
>  	.num_irqs = SPRD_SC2730_IRQ_NUMS,
>  	.charger_det = SPRD_SC2730_CHG_DET,
> +	.cells = sc2730_devices,
> +	.num_cells = ARRAY_SIZE(sc2730_devices),
>  };
>  
>  static const struct sprd_pmic_data sc2731_data = {
>  	.irq_base = SPRD_SC2731_IRQ_BASE,
>  	.num_irqs = SPRD_SC2731_IRQ_NUMS,
>  	.charger_det = SPRD_SC2731_CHG_DET,
> +	.cells = sc2731_devices,
> +	.num_cells = ARRAY_SIZE(sc2731_devices),
>  };
>  
>  enum usb_charger_type sprd_pmic_detect_charger_type(struct device *dev)
> @@ -204,7 +233,9 @@ static int sprd_pmic_probe(struct spi_device *spi)
>  		return ret;
>  	}
>  
> -	ret = devm_of_platform_populate(&spi->dev);
> +	ret = devm_mfd_add_devices(&spi->dev, PLATFORM_DEVID_AUTO,
> +				   pdata->cells, pdata->num_cells, NULL, 0,
> +				   regmap_irq_get_domain(ddata->irq_data));
>  	if (ret) {
>  		dev_err(&spi->dev, "Failed to populate sub-devices %d\n", ret);
>  		return ret;
> 
> -- 
> 2.51.0
> 

-- 
Lee Jones [李琼斯]

