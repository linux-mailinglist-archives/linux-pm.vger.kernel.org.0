Return-Path: <linux-pm+bounces-4291-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BF9860193
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 19:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3A6D1F25592
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 18:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A059B73F1A;
	Thu, 22 Feb 2024 18:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/MtZVvh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D702E73F0A;
	Thu, 22 Feb 2024 18:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708626374; cv=none; b=J44GnIYWYgV6iAB1VsVvnRoh9KcVBtVDkKboFt7d3nz6haIcEd+rWnRTz05P71bR/ex8+oSklJJg9SmMUixt46Yg60yL1Te+QDE/2XQSxspLSMwMotSkNbT8WqOjbUWQngtgPoYcnYy5Vq09Wxu/XcUt1B9SU+OcaOYqa7N/skU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708626374; c=relaxed/simple;
	bh=AQkSe8FkaJI8Funpjdq9m8VrzwcqL7TERUb4Ns0sUGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=opnmcbT4iMmLTCcv3Prl5i+vmMZ0niLMfknTeii71WNm+2lJ3tMwvG4Cvaq7h2WQHka9v/Ss6etyutoHG0rmAZoP3xaQgbM0Fa3few0NxnSNWbRiRkHNX7feFlxgSsHI95Bondqne8HBAs6eHmDAz/wOBGI3diM8HxVxtbSe9TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/MtZVvh; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-563f675be29so8431479a12.0;
        Thu, 22 Feb 2024 10:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708626371; x=1709231171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jkH0j96WzJMsna0efM0jXWyc85ksIIZTSjSTyzXxEDw=;
        b=U/MtZVvhgUnX1HpBb4WDhq/WQz2YH87pfJjgLDptO8nmidqtnRMTssJvHrem2xjJZ+
         uU091RtsflFE9IyRJIKC8n8Bt7kT49KsjcPLqJq/ZLNQnGCwh4tc65j2J1MwnLQvzqjm
         7iSNu1laOVGwrTP8mEnj8iGDd4hBVCF2bovYJCWLcbyVCj95C4j6Wonjv6bC50dlz/Vx
         PuXjeknpRZZsNj8H0DMWlXEK6Qd43t4NJOuoKtTV4IU0G/mevJpkT3weFDC4wxfiQttC
         1eB7kFBHkEawqP/lP4dvtrtlmRDnD14TIn3UbFim66AWfzf9+I9KJp36mMX18h3ubNbG
         AG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708626371; x=1709231171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jkH0j96WzJMsna0efM0jXWyc85ksIIZTSjSTyzXxEDw=;
        b=TdqwvYqm3ygCzWfDSJjV2WYfBH2KeRL9NLfD2ZfqJIE0VR7jtdZxANTKgqoMwdV9vB
         Ws8ow2sjlrE2nSKUR0UAoNj3tDqXVf0RNvoLCLfR+zYSXZNqe4P/cRQpkzIdrvTgtXse
         F32QSwKKwvjTSg0U/vTOukkWcWGdzlizonlnwsvQRA31ilDIP/nNxMhnyhFADcC04CMk
         DRVyjM5sBSeTz227RtnVqzs92fCZhAQLvPk9BNBbCsS7Miu6Q+kp3ojV3vzI60YsQF4S
         RNYCfpf+WbEZFBsYrullVNY+kTid1lmG9BT4ks2efmzom1oUQRsovza/S+VsU7onYUC4
         nO5w==
X-Forwarded-Encrypted: i=1; AJvYcCW2kABUourh4zLfGjVmr9BVW2170CbnCiJcIKsZSh/02xZcjFeJRoTPSvv1V0/4A+RqqGoLtMJqto6DpPUMn4WkZvu1NZQW62KSPzAd6cOBI91uFYFg5t58ys7cs0vi3ZYU9KDP
X-Gm-Message-State: AOJu0Ywiu4o8Ttd4mJ6r+SJdDISDxD9lGfqI44Go/uFP1BL8Grpvb2V3
	UucPH1eydv8mIJKIVMBQmUDoxVI49SkEQt+ppAeKrFrNqGNYKHEK
X-Google-Smtp-Source: AGHT+IFKU6Aq4w/6buwzzEUsHyxNhbl8/xrg10HVNhvLtylpT9s3Fi9qn4VeBXpPZYOJ1oxL+ao7SQ==
X-Received: by 2002:a17:906:fb05:b0:a3e:c758:5a7e with SMTP id lz5-20020a170906fb0500b00a3ec7585a7emr7508645ejb.41.1708626370564;
        Thu, 22 Feb 2024 10:26:10 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id g3-20020a170906c18300b00a3ed811cff9sm3404825ejz.154.2024.02.22.10.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 10:26:10 -0800 (PST)
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
 Re: [PATCH v5 1/7] soc: sunxi: sram: export register 0 for THS on H616
Date: Thu, 22 Feb 2024 19:26:08 +0100
Message-ID: <2717467.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20240219153639.179814-2-andre.przywara@arm.com>
References:
 <20240219153639.179814-1-andre.przywara@arm.com>
 <20240219153639.179814-2-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne ponedeljek, 19. februar 2024 ob 16:36:33 CET je Andre Przywara napisal(a):
> The Allwinner H616 SoC contains a mysterious bit at register offset 0x0
> in the SRAM control block. If bit 16 is set (the reset value), the
> temperature readings of the THS are way off, leading to reports about
> 200C, at normal ambient temperatures. Clearing this bits brings the
> reported values down to the expected values.
> The BSP code clears this bit in firmware (U-Boot), and has an explicit
> comment about this, but offers no real explanation.
> 
> Experiments in U-Boot show that register 0x0 has no effect on the SRAM C
> visibility: all tested bit settings still allow full read and write
> access by the CPU to the whole of SRAM C. Only bit 24 of the register at
> offset 0x4 makes all of SRAM C inaccessible by the CPU. So modelling
> the THS switch functionality as an SRAM region would not reflect reality.
> 
> Since we should not rely on firmware settings, allow other code (the THS
> driver) to access this register, by exporting it through the already
> existing regmap. This mimics what we already do for the LDO control and
> the EMAC register.
> 
> To avoid concurrent accesses to the same register at the same time, by
> the SRAM switch code and the regmap code, use the same lock to protect
> the access. The regmap subsystem allows to use an existing lock, so we
> just need to hook in there.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

I guess this one goes through sunxi tree, right?

Best regards,
Jernej

> ---
>  drivers/soc/sunxi/sunxi_sram.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
> index 4458b2e0562b0..6eb6cf06278e6 100644
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
> @@ -327,6 +332,20 @@ static bool sunxi_sram_regmap_accessible_reg(struct device *dev,
>  	return false;
>  }
>  
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
> @@ -336,6 +355,9 @@ static struct regmap_config sunxi_sram_regmap_config = {
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





