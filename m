Return-Path: <linux-pm+bounces-20142-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCEEA07536
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 13:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B70D188B0E5
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 12:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4032C2165F3;
	Thu,  9 Jan 2025 12:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lw/9ZmFe"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E3A195;
	Thu,  9 Jan 2025 12:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736424125; cv=none; b=OG3XSyndA6y+CIy4ola7QYKk0QBoKSztcpmii1gi1yw9CoKEMUeUs06bhPh+OQIpS3GoM2iDiER1Uys1MXlp9QSgSbOoflrsqUjBWetTRyTV36MvEzmpeGLO8WttPCNQd4oEkOzGWeEgp59GS2YSWxStBYibG7oNNX0dQkmVBMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736424125; c=relaxed/simple;
	bh=44XC/PoinYXBD7pTczVCDvbpws2IBUMxEXAauXTCGG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3IH6SGzqUVmLkZnAlL8e6pf7n5EAArlBPu3i/7PNkYiCYylRJ8JDcUpwfTDCd4mkx/W/i0WAOA3wDHTlq6u/OBHj6/MrzIeE4qUvWNRC1xp5zO3F9VMpHVeaD2NZDu0ZcRAAWM27Ef1yRaQOGUlrIhB2405dITK23Pg4u6w8mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lw/9ZmFe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41250C4CEE7;
	Thu,  9 Jan 2025 12:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736424124;
	bh=44XC/PoinYXBD7pTczVCDvbpws2IBUMxEXAauXTCGG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lw/9ZmFeEQJ+wTxulF0TE5jHA5xXgi+sWJirHx/0MOKs9NDGFlAXJ8X1Szz3vS+a2
	 PNxJ8qwlx1Y0yq7jtDSZM8/ramIS8h9Wf1dGfKjXUv3FMOQiYc2r7L90bfmMgAvYbu
	 oUyFeL68Bm/fpa0UNr4kvdC3vgvBsWqeIp/uozshaPdQJd5rMKEwBYK1/anhwDgEXq
	 nsS2T+JmozfTh0NoRFXBP/jnV/+J2Q9Wy4zGpxnnEVXOxKm33n3osizYBGHCHqtgkG
	 2CrtQR62mIJNOjAdkJjx7dRn4F01WOLBRyu628vTY+Da8c+/nqEC5x0gkDCUmQJWL4
	 xbs4JkTNu6S9g==
Date: Thu, 9 Jan 2025 12:01:58 +0000
From: Lee Jones <lee@kernel.org>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@ucw.cz>, Hans de Goede <hdegoede@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v14 07/10] mfd: simple-mfd-i2c: Add MAX77705 support
Message-ID: <20250109120158.GH6763@google.com>
References: <20250108-starqltechn_integration_upstream-v14-0-f6e84ec20d96@gmail.com>
 <20250108-starqltechn_integration_upstream-v14-7-f6e84ec20d96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250108-starqltechn_integration_upstream-v14-7-f6e84ec20d96@gmail.com>

On Wed, 08 Jan 2025, Dzmitry Sankouski wrote:

> Add MAX77705 support - fuel gauge and hwmon devices.
> Hwmon provides charger input and system bus measurements.
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
> Changes in v13:
> - remove compatible from cells
> - change mfd compatible to match max77705 fuel gauge node
> ---
>  drivers/mfd/simple-mfd-i2c.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
> index 6eda79533208..22159913bea0 100644
> --- a/drivers/mfd/simple-mfd-i2c.c
> +++ b/drivers/mfd/simple-mfd-i2c.c
> @@ -83,11 +83,22 @@ static const struct simple_mfd_data maxim_max5970 = {
>  	.mfd_cell_size = ARRAY_SIZE(max5970_cells),
>  };
>  
> +static const struct mfd_cell max77705_sensor_cells[] = {
> +	{ .name = "max77705-battery" },
> +	{ .name = "max77705-hwmon", },
> +};
> +
> +static const struct simple_mfd_data maxim_mon_max77705 = {
> +	.mfd_cell = max77705_sensor_cells,
> +	.mfd_cell_size = ARRAY_SIZE(max77705_sensor_cells),
> +};
> +
>  static const struct of_device_id simple_mfd_i2c_of_match[] = {
>  	{ .compatible = "kontron,sl28cpld" },
>  	{ .compatible = "silergy,sy7636a", .data = &silergy_sy7636a},
>  	{ .compatible = "maxim,max5970", .data = &maxim_max5970},
>  	{ .compatible = "maxim,max5978", .data = &maxim_max5970},
> +	{ .compatible = "maxim,max77705-battery", .data = &maxim_mon_max77705},

Drop the battery part from the MFD (group) name please.

>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, simple_mfd_i2c_of_match);
> 
> -- 
> 2.39.5
> 

-- 
Lee Jones [李琼斯]

