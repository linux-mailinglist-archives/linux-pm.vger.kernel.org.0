Return-Path: <linux-pm+bounces-35513-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA165BA6502
	for <lists+linux-pm@lfdr.de>; Sun, 28 Sep 2025 02:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46E6F3BF333
	for <lists+linux-pm@lfdr.de>; Sun, 28 Sep 2025 00:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741853C2F;
	Sun, 28 Sep 2025 00:03:02 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B11534BA24;
	Sun, 28 Sep 2025 00:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759017782; cv=none; b=HeECVpvyoW9L46ey83ac+3b4kf1vP/ikpvfTR8puEd7qKr1gvBs1hgA6DDhJhIGL0q5Djt1dBvcOekeMJB+4JGfTYymu8m+Dg7zbJu8CvWziSAah3FC6w53atB6imTisT+zhLtnv1oeeHqPlFvwPxEDQ9towxBJl9dUnJUIpRl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759017782; c=relaxed/simple;
	bh=ChBHW2ts8z1Rw+T1GL1S7mMYhiJYfcHp9vO/hj5eZFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBFUOHm9yy3yfIOMGI861rgZzCLtxPxfiA9HZ7zg7TZ8IzJnNk3g+AjpwxFPFuMrBofnlXdNWjWUvvMxi6sIVlCIzAdRrPxh+emXqqKhWtWliItHjqhB5mMyri7OfEnkiCDe2+VQrWNEe2RcxznURUj1sl135PbRko7CdqVA4iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [180.158.240.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 7DF62340B28;
	Sun, 28 Sep 2025 00:02:59 +0000 (UTC)
Date: Sun, 28 Sep 2025 08:02:55 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>,
	"open list:RISC-V SPACEMIT SoC Support" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>
Subject: Re: [PATCH 1/2] driver: reset: spacemit-p1: add driver for
 poweroff/reboot
Message-ID: <20250928000255-GYA1342640@gentoo.org>
References: <20250927220824.1267318-1-aurelien@aurel32.net>
 <20250927220824.1267318-2-aurelien@aurel32.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250927220824.1267318-2-aurelien@aurel32.net>

Hi Aurelien, 

On 00:07 Sun 28 Sep     , Aurelien Jarno wrote:
> This driver implements poweroff/reboot support for the SpacemiT P1 PMIC
> chip, which is commonly paired with the SpacemiT K1 SoC.
> 
> The SpacemiT P1 support is implemented as a MFD driver, so the access is
> done directly through the regmap interface. Reboot or poweroff is
> triggered by setting a specific bit in a control register, which is
> automatically cleared by the hardware afterwards.
> 
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
>  drivers/power/reset/Kconfig              |  9 +++
>  drivers/power/reset/Makefile             |  1 +
>  drivers/power/reset/spacemit-p1-reboot.c | 88 ++++++++++++++++++++++++
>  3 files changed, 98 insertions(+)
>  create mode 100644 drivers/power/reset/spacemit-p1-reboot.c
> 
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index 77ea3129c7080..5afef049760d6 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
[snip]..
> +
> +static int spacemit_p1_reboot_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	regmap = dev_get_regmap(dev->parent, NULL);
> +	if (!regmap)
> +		return -ENODEV;
> +
> +	ret = devm_register_power_off_handler(dev, &spacemit_p1_pwroff_handler, regmap);
> +	if (ret) {
> +		dev_err(dev, "Failed to register power off handler: %d\n", ret);
> +		return ret;
suggest to simplify with dev_err_probe(), which will save few lines
> +	}
> +
> +	ret = devm_register_restart_handler(dev, spacemit_p1_restart_handler, regmap);
> +	if (ret) {
> +		dev_err(dev, "Failed to register restart handler: %d\n", ret);
> +		return ret;
ditto
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct platform_device_id spacemit_p1_reboot_id_table[] = {
> +	{ "spacemit-p1-reboot", },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(platform, spacemit_p1_reboot_id_table);
> +
> +static struct platform_driver spacemit_p1_reboot_driver = {
> +	.driver = {
> +		.name = "spacemit-p1-reboot",
> +	},
> +	.probe = spacemit_p1_reboot_probe,
> +	.id_table = spacemit_p1_reboot_id_table,
> +};
> +module_platform_driver(spacemit_p1_reboot_driver);
> +
> +MODULE_DESCRIPTION("SpacemiT P1 reboot/poweroff driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.47.2
> 

-- 
Yixun Lan (dlan)

