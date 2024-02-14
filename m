Return-Path: <linux-pm+bounces-3925-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA54F8553F9
	for <lists+linux-pm@lfdr.de>; Wed, 14 Feb 2024 21:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 343751F228A4
	for <lists+linux-pm@lfdr.de>; Wed, 14 Feb 2024 20:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B1613DBBE;
	Wed, 14 Feb 2024 20:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKu+mB/9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B0C13DB90;
	Wed, 14 Feb 2024 20:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707942576; cv=none; b=DMjSnK6tSA5D9bpXimxCuOPm/VCbJz9Un6AWUJvzvhllJqDaY6H8/Ksybj/9t62ZJ+x5WlyPdMtZ8uiudEaacsbtBquOdeXm4YrqNm2ZZZbzaCASzzAB0/bKl0dmnBhyeJfmavIeEMP5oUg02eysW6zRG/HYUPNlaH7QGn1qCgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707942576; c=relaxed/simple;
	bh=8kTz3bW/+5NCQ7HkpejSwj0MVAdniybDxiGS6ZjkDaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JqT8THvjETCEvMT2ZdblH+W/a2UMcRQaIM8qw/ep/X3dG3ka/u40GADWYTF5FyWRSLksRfabx+lP76TIirf1sKIPyVNYMoAHWtVUZhfQgv8WQ11jz/B6quzNcmL1N84qq/3tSUvWncpnyB74pD/5BH3iOUWy5bRpoi7/MfG/W9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKu+mB/9; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-411a5b8765bso1027955e9.1;
        Wed, 14 Feb 2024 12:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707942573; x=1708547373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBvsc1XKIhR5dVEzuhjn9WsrMef1zGyP0ra7G6DruCM=;
        b=cKu+mB/9J70+hI3KkoYyTv13vnyJ/nueycuF60jadp5hMrg/fwNLviiAETHNCdP0bk
         duHk49dPWO/fjgQB/nBJpnfgooU3tr7bYlWs82BrLu45KW/9Z35fcdfvrsnT79QRQI4/
         UeYMws4mM2WCSiGuuBlp5AyBUE40pNyeSrqb6HXzVbPL9rPtWzInS7d2HJe+TCXWL1l+
         llnSfaFc2Al7CQciFg1PlJ3s0vu/zSef3K2jW0G9eBtDjR5nr4DpxMa1B1pZq3Gyr10K
         epM+ga9mnlQtXiLcdezuLnqljOVa+6Ez85cP7ijZIyLijrdyTio9G0ki1cTM/Lh0/0xP
         pm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707942573; x=1708547373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZBvsc1XKIhR5dVEzuhjn9WsrMef1zGyP0ra7G6DruCM=;
        b=QatroGnBT+ERg7/oKLw24aDQjrqYVV9E34Pm2fzKAFkRTAWjhUC00CE3uSKqIh6/Gq
         EMGVFSoJdTrxIumDaOfB6npONNr3sUv6tqT7cXwW2xW40LG5CC+j3ikzJfSmS1J2TC1B
         9I0f81xGRfJ5hhVB48TLcjEpkJiKmtyquiAM0Qq8FCcBqbuBqLghenqKhkkXNt8s6oCv
         0r6nKtU0wIjCDrQ1Sa4wElXJNris8jcYAu9363+uUWORyoxY9BrVIr+Z5nJEWlW7E04l
         vR/6GC0dupDhGDws6wVaejpEvoVNNvVdm4dVlo+a3E1EvM0GPbdYQV5pFSQv7jSjIB5w
         mv9w==
X-Forwarded-Encrypted: i=1; AJvYcCWVmGkLyx+jX2l22tS79vppbstCTe4OySkcWTRdd8Pbntf8BoZDTcGMSg4SVs/dp3h/B4xHUiv+BH9TSYVSspLH3BaTMIwmwQFsiejXKQNYO+wY+QDnsWxW3EKCpVXnhhZqmcMC
X-Gm-Message-State: AOJu0Yx0PBsRUCoEIGR56JpUsAPREOi1Mlp5kd30zbJLzixhTSC0Jm+X
	XYvpTxTHszTLDPUCNxkfR/L6CIsfJqo8eIQm6+YIpgIo2apqHDU7
X-Google-Smtp-Source: AGHT+IGAtFiJcgsqh2G4NKplvuzykjrTJbMMnt+EEhEh4BzlxfzvJ19V00BJBJC0SEzlBpwjIVGJAA==
X-Received: by 2002:a05:600c:1d1a:b0:411:db41:687c with SMTP id l26-20020a05600c1d1a00b00411db41687cmr2471800wms.13.1707942572918;
        Wed, 14 Feb 2024 12:29:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCULxJADTUmIWQLgtTo+9SxgGAGxI9sHnQGBBOU/2/dHQnP+JBf7rc+DpzpzCZdmT6+S5jY6we0wbWySfWh3Dv+xjZ+FruklmpcFfBObITXpr3XT3PT9Q4KZ3VFX9Hhd6SaaoWDkywoLXPf2muRJDGowHDFF8svwn1p4sJK0ycZKksNLtvOdecl4TlKq527LFfBf2+HD/xa9h6cL5VeyP3/Xff4ZcswZWJ01SvyGkKGk6EF/0mK4+RAH2HJg5ThC7phclR72UlSQuLPrfZqOzAtjRjePr9xz2YUsXgC0jbivBfEoBFvuKcylI7gGLaxhjv0rNy5RqjdC3CV2M011FxDZIbm/RAsqECF4AVcqQCt0fJIng1YWQylCNpeUf/I3SwYfS0HXQnRxHtM4zYVqQ8jozbTrCDppkpByn4EjdUkpFW10wPDj7DOQjjUtJKNzY1GTkkJXNeQOlbi/RBWsVFkG8/RFW0/wRilYqWRgO9s/iPbeWCyewJdn34RIqzd2BGnxsow+OWHNmfWbHaMOms+cPNwH8qakWpw2samegau87+vtQs31M+wUVA+AQiQzRDc3nAjhTnlyeWm/9fiOHce0MpJxkVygshEwCpYZnTVZr6h+y4tBiQ==
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id cg8-20020a5d5cc8000000b0033cdf1f15e8sm4727671wrb.16.2024.02.14.12.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 12:29:32 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>,
 Yangtao Li <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, Andre Przywara <andre.przywara@arm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Martin Botka <martin.botka@somainline.org>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Bob McChesney <bob@electricworry.net>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
Subject:
 Re: [PATCH v4 1/7] soc: sunxi: sram: export register 0 for THS on H616
Date: Wed, 14 Feb 2024 21:29:30 +0100
Message-ID: <2172811.irdbgypaU6@jernej-laptop>
In-Reply-To: <20240209144221.3602382-2-andre.przywara@arm.com>
References:
 <20240209144221.3602382-1-andre.przywara@arm.com>
 <20240209144221.3602382-2-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne petek, 09. februar 2024 ob 15:42:15 CET je Andre Przywara napisal(a):
> The Allwinner H616 SoC contains a mysterious bit at register offset 0x0
> in the SRAM control block. If bit 16 is set (the reset value), the
> temperature readings of the THS are way off, leading to reports about
> 200C, at normal ambient temperatures. Clearing this bits brings the
> reported values down to reasonable ranges.
> The BSP code clears this bit in firmware (U-Boot), and has an explicit
> comment about this, but offers no real explanation.
> 
> Since we should not rely on firmware settings, allow other code (the THS
> driver) to access this register, by exporting it through the already
> existing regmap. This mimics what we already do for the LDO control and
> the EMAC register.

Are you sure that this bit doesn't control actual SRAM region?

Best regards,
Jernej

> 
> Since this bit is in the very same register as the actual SRAM switch,
> we need to change the regmap lock to the SRAM lock. Fortunately regmap
> has provisions for that, so we just need to hook in there.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/soc/sunxi/sunxi_sram.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
> index 4458b2e0562b0..71cdd1b257eeb 100644
> --- a/drivers/soc/sunxi/sunxi_sram.c
> +++ b/drivers/soc/sunxi/sunxi_sram.c
> @@ -287,6 +287,7 @@ EXPORT_SYMBOL(sunxi_sram_release);
>  struct sunxi_sramc_variant {
>  	int num_emac_clocks;
>  	bool has_ldo_ctrl;
> +	bool has_ths_offset;
>  };
>  
>  static const struct sunxi_sramc_variant sun4i_a10_sramc_variant = {
> @@ -308,8 +309,10 @@ static const struct sunxi_sramc_variant sun50i_a64_sramc_variant = {
>  
>  static const struct sunxi_sramc_variant sun50i_h616_sramc_variant = {
>  	.num_emac_clocks = 2,
> +	.has_ths_offset = true,
>  };
>  
> +#define SUNXI_SRAM_THS_OFFSET_REG	0x0
>  #define SUNXI_SRAM_EMAC_CLOCK_REG	0x30
>  #define SUNXI_SYS_LDO_CTRL_REG		0x150
>  
> @@ -318,6 +321,8 @@ static bool sunxi_sram_regmap_accessible_reg(struct device *dev,
>  {
>  	const struct sunxi_sramc_variant *variant = dev_get_drvdata(dev);
>  
> +	if (reg == SUNXI_SRAM_THS_OFFSET_REG && variant->has_ths_offset)
> +		return true;
>  	if (reg >= SUNXI_SRAM_EMAC_CLOCK_REG &&
>  	    reg <  SUNXI_SRAM_EMAC_CLOCK_REG + variant->num_emac_clocks * 4)
>  		return true;
> @@ -327,6 +332,21 @@ static bool sunxi_sram_regmap_accessible_reg(struct device *dev,
>  	return false;
>  }
>  
> +
> +static void sunxi_sram_lock(void *_lock)
> +{
> +	spinlock_t *lock = _lock;
> +
> +	spin_lock(lock);
> +}
> +
> +static void sunxi_sram_unlock(void *_lock)
> +{
> +	spinlock_t *lock = _lock;
> +
> +	spin_unlock(lock);
> +}
> +
>  static struct regmap_config sunxi_sram_regmap_config = {
>  	.reg_bits       = 32,
>  	.val_bits       = 32,
> @@ -336,6 +356,9 @@ static struct regmap_config sunxi_sram_regmap_config = {
>  	/* other devices have no business accessing other registers */
>  	.readable_reg	= sunxi_sram_regmap_accessible_reg,
>  	.writeable_reg	= sunxi_sram_regmap_accessible_reg,
> +	.lock		= sunxi_sram_lock,
> +	.unlock		= sunxi_sram_unlock,
> +	.lock_arg	= &sram_lock,
>  };
>  
>  static int __init sunxi_sram_probe(struct platform_device *pdev)
> 





