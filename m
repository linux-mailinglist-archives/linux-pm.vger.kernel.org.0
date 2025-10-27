Return-Path: <linux-pm+bounces-36866-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83547C0BBC6
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 04:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA1693BB681
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 03:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C8C2D5920;
	Mon, 27 Oct 2025 03:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="E1OtxS5m"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AEC2D3EE3;
	Mon, 27 Oct 2025 03:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761535251; cv=none; b=RsdsihIkT/G+he+rX2ztLY0KIM83wVODHWTPgYY1SyB07C6S4Uvg1GoKZkd9ECRL7P+OFPG6O0zElpa30IPkq3RzprXM26eoWuyWvUyrplvLdzePVLkERx4y7NH6G1Lzzmw88+WoOR64FQsuF5ARe9mNSoIji+So9D5vhCm0q7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761535251; c=relaxed/simple;
	bh=V6gLOPoyZC1Rrtb1DD9I54bfxiLa0quZq+9NVrkdgJg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G6vVQJNGBx052f7axr0G79WJjUeXB6hiOS5eVNu1kceqVXaLMvrymHXsF7CwqGV3wgCKZ6+P4iEMl/HubGun2dIetNlMKRlFeMjAIcoQx1GWnmbjXlR+3JL0/rS6Qf8EkSZjbzbzDnEsMWOl6LRcfMhlmc2ma4ivtRf8egIq2hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=E1OtxS5m; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1761535237;
	bh=56JGIU4CD1fsXCYSHVvyznt4gBt5NH3ahDq0LBsoufM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=E1OtxS5mVmZP77hAW9lJoGz1KJEGje0c7HoE+rZdbbzood82a2DwpSdFVd9iSox7o
	 sNF7BY60rvCS/+RMPE9MmQoQIO2gNfjIa8DC+myb0YDfEx/3iI8sRtyGDTZh7xGOhf
	 GOM0BaGPzkSKu8P68Ul5G2rHSn5wKOoKWfYTKO7k=
X-QQ-mid: esmtpgz11t1761535235t1790e053
X-QQ-Originating-IP: wU7tvrJ7wJKBNyTcA7+PgYwp28voDXOKAvCOskFI580=
Received: from = ( [183.48.247.177])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 27 Oct 2025 11:20:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2694975293500696196
EX-QQ-RecipientCnt: 13
Date: Mon, 27 Oct 2025 11:20:33 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Aurelien Jarno <aurelien@aurel32.net>, linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Yixun Lan <dlan@gentoo.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	"open list:RISC-V ARCHITECTURE:Keyword:riscv" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support:Keyword:spacemit" <spacemit@lists.linux.dev>,
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] driver: reset: spacemit-p1: add driver for
 poweroff/reboot
Message-ID: <A73D83A7055D782E+aP7lAdAk66slv6l7@kernel.org>
References: <20251026224424.1891541-1-aurelien@aurel32.net>
 <20251026224424.1891541-2-aurelien@aurel32.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026224424.1891541-2-aurelien@aurel32.net>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: Np+AlqyfvJHVPkavF2+o0FnCOHd8MEydgR6o5ybeAxfDlCVvhj8UG5rw
	gJdvtt/BQJD7CdZyyuIbghBiJwCYvrv65i8d/KEkqh1PfR7TjKxs1dvJmKi7U7Dexb82Hn9
	cfJwoYA/NsuTAnpyNzqwTRp8DedRTWSWnsxHxbNsrBAYCPMK9fpf4L/EMC5qmWgHOMUzaol
	8Lzk74a40UUEn1QlqdYYAhf61n3LOzxWaOnsBw2n2YKnbAPsI/MU41WFrfAaGQgwl6hXtUz
	RnfdzNaBIYt7xEpTMHRq8G1nRWDYPB3+kJ1i/jHJccRbSz2PFdXslaYv5bhpdingiem2EHj
	1vfqZydeULfqjK58jU56JXoY9iFXwcmE0YzdEEleWBOCas0+micwkMuxKWhaN8QVqmNjpuc
	eyxBZuqOeoTTpeEs/ezxNUeUlmPe4/q2Xrbe2DJeGmjsJRptZEyADb3ZpPX2uonEufXplGA
	8AIDQGYblqOD8pBnNaat7Irua+cHrgvfMFLMoYoamEfhsp48QcgrTPDUXm3tIMrRJi0BCQT
	78jirr/1TilXc0vVINvPdngHt2K2V0EHDu5punAUnk+3rTi097w8HlCSqiF8CJk5C8cQlge
	897d0fMMxJUKIGMwH207nJ/ARgP99xVnuxo/vJ+nq/9h+EfLzzWy7M0o5ejW9HkbHAAQ31h
	URAcVD+UA7Kn7Ddz0JVB42ieKKUTgMqDEtH7OQO9mzoFkDNzLR7yYLzl6XPXoSvV+NizErS
	CqoNf+uTk7dP/NBuLg2s19566GJbHAIVwTHsTtE+1hALRAeVrln8WUxqB2ciNWRQu1pXf1+
	qoJhXhHj/81vwoosJr9c3lZm6XjIym+DZH6XrfdwGUVBfINpwlXGr3+CTGnUphRYYjORw5+
	Q4P0JQfj4X9EkeDt10HGI9Bnqayz5yYubgcLiusBzlGcvPb7xYJmmgwSdXidSWTBoxn0yVR
	1d7hVer32/B6aELpFayBTi2DNorpEHTCKmuCJuWjxKWRBE5zUObfs9twFduv2MlgUuS0HBX
	V/UmqoGTMFKX7Kt3y35ahczpjUzJYFHFnMf4TFKsXtJRw8yxASD7kQUuKb2ps=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

On Sun, Oct 26, 2025 at 11:41:14PM +0100, Aurelien Jarno wrote:
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
> v2:
>  - Replace the "select" by a "depends on"
>  - Remove outdated Reviewed-by
> 
>  drivers/power/reset/Kconfig              |  9 +++
>  drivers/power/reset/Makefile             |  1 +
>  drivers/power/reset/spacemit-p1-reboot.c | 88 ++++++++++++++++++++++++
>  3 files changed, 98 insertions(+)
>  create mode 100644 drivers/power/reset/spacemit-p1-reboot.c
> 
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index 8248895ca9038..61c16f3d5abc7 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -283,6 +283,15 @@ config POWER_RESET_KEYSTONE
>  	help
>  	  Reboot support for the KEYSTONE SoCs.
>  
> +config POWER_RESET_SPACEMIT_P1
> +	tristate "SpacemiT P1 poweroff and reset driver"
> +	depends on ARCH_SPACEMIT || COMPILE_TEST
> +	depends on MFD_SPACEMIT_P1
> +	default m
default m if ARCH_SPACEMIT? Or default ARCH_SPACEMIT?
I believe that reboot and shutdown are actually essential functionalities,
so it might make more sense: default ARCH_SPACEMIT?

                                      - Troy
> +	help
> +	  This driver supports power-off and reset operations for the SpacemiT
> +	  P1 PMIC.
> +
>  config POWER_RESET_SYSCON
>  	bool "Generic SYSCON regmap reset driver"
>  	depends on OF
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index 51da87e05ce76..0e4ae6f6b5c55 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -24,6 +24,7 @@ obj-$(CONFIG_POWER_RESET_LTC2952) += ltc2952-poweroff.o
>  obj-$(CONFIG_POWER_RESET_QNAP) += qnap-poweroff.o
>  obj-$(CONFIG_POWER_RESET_REGULATOR) += regulator-poweroff.o
>  obj-$(CONFIG_POWER_RESET_RESTART) += restart-poweroff.o
> +obj-$(CONFIG_POWER_RESET_SPACEMIT_P1) += spacemit-p1-reboot.o
>  obj-$(CONFIG_POWER_RESET_ST) += st-poweroff.o
>  obj-$(CONFIG_POWER_RESET_TH1520_AON) += th1520-aon-reboot.o
>  obj-$(CONFIG_POWER_RESET_TORADEX_EC) += tdx-ec-poweroff.o
> diff --git a/drivers/power/reset/spacemit-p1-reboot.c b/drivers/power/reset/spacemit-p1-reboot.c
> new file mode 100644
> index 0000000000000..9ec3d1fff8f3d
> --- /dev/null
> +++ b/drivers/power/reset/spacemit-p1-reboot.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2025 by Aurelien Jarno
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/reboot.h>
> +
> +/* Power Control Register 2 */
> +#define PWR_CTRL2		0x7e
> +#define PWR_CTRL2_SHUTDOWN	BIT(2)	/* Shutdown request */
> +#define PWR_CTRL2_RST		BIT(1)	/* Reset request */
> +
> +static int spacemit_p1_pwroff_handler(struct sys_off_data *data)
> +{
> +	struct regmap *regmap = data->cb_data;
> +	int ret;
> +
> +	/* Put the PMIC into shutdown state */
> +	ret = regmap_set_bits(regmap, PWR_CTRL2, PWR_CTRL2_SHUTDOWN);
> +	if (ret) {
> +		dev_err(data->dev, "shutdown failed: %d\n", ret);
> +		return notifier_from_errno(ret);
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static int spacemit_p1_restart_handler(struct sys_off_data *data)
> +{
> +	struct regmap *regmap = data->cb_data;
> +	int ret;
> +
> +	/* Put the PMIC into reset state */
> +	ret = regmap_set_bits(regmap, PWR_CTRL2, PWR_CTRL2_RST);
> +	if (ret) {
> +		dev_err(data->dev, "restart failed: %d\n", ret);
> +		return notifier_from_errno(ret);
> +	}
> +
> +	return NOTIFY_DONE;
> +}
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
> +	ret = devm_register_power_off_handler(dev, &spacemit_p1_pwroff_handler,
> +					      regmap);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to register power off handler\n");
> +
> +	ret = devm_register_restart_handler(dev, spacemit_p1_restart_handler,
> +					    regmap);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to register restart handler\n");
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

