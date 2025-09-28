Return-Path: <linux-pm+bounces-35517-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79602BA6624
	for <lists+linux-pm@lfdr.de>; Sun, 28 Sep 2025 04:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C93DC189675C
	for <lists+linux-pm@lfdr.de>; Sun, 28 Sep 2025 02:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E311E1A33;
	Sun, 28 Sep 2025 02:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="aX3Iu+WV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A594A01;
	Sun, 28 Sep 2025 02:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759025457; cv=none; b=hruxTRDk5mCStborSvqVtwRDbe2SX3vXNdi/DClBN8XroooB6tKv3Z7hyCozLSWC6OCDnjtwktgpO0BSXmmDSNSKRyQAGuRePKYsIB9Q4cuFw6gjqECg43+BFHSdexlcKM6MXIMTiKTjpMnP0TdUs+B7j1lrPcpNauW9mZBmnLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759025457; c=relaxed/simple;
	bh=bXbecS0IyDLvfvVFyAQIfZWm7g6T5lIqeGstL+ERs8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKCqw12R6HQBUP9AYKvyphDZL2Av13/iXaw6CNgPAAtRMQrRDy/jHcDssFUDvzHpahtwVdUAoZf8aB6OeKIjrNYI9jRaIBMkKwCEstuPOLMDn3TZFyt5/IhdAAT0ltxqDm7i76MSmdmNIMmexmIYu7/InXnmHwk/VDGxWUgFidU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=aX3Iu+WV; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1759025450;
	bh=eY0bpTnzgWUlPNePnN5gj3Yr6PlpWRkAzkaXahzV1o8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=aX3Iu+WVXqkaOEt6IYhUzisugto3NkFU0NDjsDI8z/eeHKrMMQ1i8RFzml9N7mwcp
	 tooixD20fy83WXGkfKgQ3MtsWGC+eb/JefwFrpczYF+jAwpuhQnsPNxP4JdllR8sr9
	 cXaUkoygOcDG4l0hGHXcnZikCzTEWt4qpzfC5qKs=
X-QQ-mid: zesmtpgz9t1759025446tf4c98f6b
X-QQ-Originating-IP: RtsBnZ4ihVU9CHOc9np/4YECKvEAil73OOUAMK5O8B8=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 28 Sep 2025 10:10:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11079297919091120086
EX-QQ-RecipientCnt: 13
Date: Sun, 28 Sep 2025 10:10:45 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Aurelien Jarno <aurelien@aurel32.net>, linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Yixun Lan <dlan@gentoo.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: "open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>,
	"open list:RISC-V SPACEMIT SoC Support" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH 1/2] driver: reset: spacemit-p1: add driver for
 poweroff/reboot
Message-ID: <97073301A892F7D5+aNiZJbY2_WqSZR76@kernel.org>
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
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: OakVxA/3u/8R+RscWecTt98PzYb9aUs3vB+UBNkPt3bRCdLOSVAd4S/A
	QF98oDqLAcCTe1QTS8A4KkwY1gxNwmFxQl0UQ8Hb4B7kqoU+Kg8qLsuRU45OWYUZK37VneJ
	+QPjsF7Z2RubYo2koD7xKFCLlywFKWM3xpDEnFTAC5WekUgMDkErU74iqyoi13/rVmNahUP
	BnRSCCQ4GBPh1G5lOlpchJFwlSjohHnS22TqHhECLEh99yg7VDjdHHk3dz4wObCijOubiAJ
	AMdufrhe7dDFrhz9dvgVi49EiCxlOIsplVcuXZ8D/WgPdndwBfngN0wcUgdpyAMZb/mPbH6
	aoF/MSt7dfR2x2wKrn9fHLXGhz3mlB4/BWwFtPIwxtL0GxnBvlQYvKpGvF69kTNM4st/Vc0
	K6lHfYBCNKE+pERulZOkKQ5dKaJUxbCO2byJGisEiO8WPD2pH0TU355D0L7V8eMexhvBWjI
	GvU1gxORMfkGNR/24NA+7oPIrmxTjT+FKdnrcSdnWAySieX1eglznhrCpNGZq25C6qqt1Jb
	AZGhtIPSyAmIyOQlZQ5T5kpIIS/ivC1pkoRsQCUCvh0vxXVdx9tnnCFIXncC5IxXHF9b1/P
	RIQHGNvhdPV+sEuNBnqN7FHeDqLmllVVj2oMnWo2FzqQc11tKUULayidaiK43eQQGR08Ddc
	fh3c0ZDa3/7Gt6G6KNYNf4fiEzFvSHbK57N3BhVpdHbCnVOIeJ2VeEmLhsLwyH2IA0L5H75
	suQbh/3/lXpQSNkmnI1MjqwA9yjA4iKRPX3hbO+amkOoMvykda9p/N28kH2hIQW6glwjvTC
	EPGAmyOhho8ScW82ar/bWjBU1eULAXobSrQRZk/QpRw2BrkCJyceOcsll12Sk2h1fjCEYnv
	oBafY02et8kCKOra46pEXo/BExFwPKsh63r2AtBFlSPL4Udc1rciBfJN1+12+nUhZs8ILs+
	vuAoN1IpMN4tr4S6JjjwgfFJdakIPRb4lgnH5wGrJi+yRoVKhsowI8Mkx38BDMwxJUjYmWB
	1a0adsk/uAYgZ+D1j7x3XnAVM+l73gxPeMiqiTiyHDH7StaexDKFai5lzQG6WjY4OtHZ1Lz
	PGek2BfcL9w0PcuOMnqz4ZsolDs5RLiUZanZyu/0nWs
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

On Sun, Sep 28, 2025 at 12:07:40AM +0200, Aurelien Jarno wrote:
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
[...]
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
> +	}
With fixing what Yixun said, LGTM.

Acked-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> +
> +	ret = devm_register_restart_handler(dev, spacemit_p1_restart_handler, regmap);
> +	if (ret) {
> +		dev_err(dev, "Failed to register restart handler: %d\n", ret);
> +		return ret;
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
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

