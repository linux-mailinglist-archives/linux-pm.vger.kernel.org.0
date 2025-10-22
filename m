Return-Path: <linux-pm+bounces-36612-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F23BF9844
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 02:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E5FA934309C
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 00:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED80278F51;
	Wed, 22 Oct 2025 00:48:37 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E45E76025;
	Wed, 22 Oct 2025 00:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761094117; cv=none; b=tAkVfAx2zIU7AZsmFJjJbLQ2FbjaW5bh48RiJ3NMNB/WMepIHqLziVDgl377jWwy7XOJDO+A96zqH6wJmdLuTgPmyw01G0R5TF/eOqzopltmlFWlUJqY4duRd+U72pjku540ggKa8pb2ktnnXdowmNWSe64d7GIrgH/O1qYkxHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761094117; c=relaxed/simple;
	bh=U0MBq3amAZygVlq0kpe0Mnjgkacbka8wHelIfyOJZew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6DYgzwidrdBbM8eRHmDhdUISefp0Hb3hLq/wjmx5fs7uEGRAIglgou2Y5Nx9XctUXbC//2FM+Qd2fBqSQKSLjBmZPvMQl3Z8xufWimzQ33+Bnbw2zP8ztvJKfrBNrEn30nE+Uhgs87h6pd+xMVfHUq8XKTPgqSEB9V2RYcYKro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.147.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 203E434106A;
	Wed, 22 Oct 2025 00:48:34 +0000 (UTC)
Date: Wed, 22 Oct 2025 08:48:30 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	"open list:RISC-V ARCHITECTURE:Keyword:riscv" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support:Keyword:spacemit" <spacemit@lists.linux.dev>,
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] driver: reset: spacemit-p1: add driver for
 poweroff/reboot
Message-ID: <20251022004830-GYB1522542@gentoo.org>
References: <20251021201451.1013640-1-aurelien@aurel32.net>
 <20251021201451.1013640-2-aurelien@aurel32.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021201451.1013640-2-aurelien@aurel32.net>

Hi Aurelien,

On 22:11 Tue 21 Oct     , Aurelien Jarno wrote:
> This driver implements poweroff/reboot support for the SpacemiT P1 PMIC
> chip, which is commonly paired with the SpacemiT K1 SoC.
> 
> The SpacemiT P1 support is implemented as a MFD driver, so the access is
> done directly through the regmap interface. Reboot or poweroff is
> triggered by setting a specific bit in a control register, which is
> automatically cleared by the hardware afterwards.
> 
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> Reviewed-by: Yixun Lan <dlan@gentoo.org>
> ---
> v3:
>  - Allow building as a module
>  - Remove outdated Acked-by and Tested-by
>  - Collect Reviewed-by
> 
>  drivers/power/reset/Kconfig              |  9 +++
>  drivers/power/reset/Makefile             |  1 +
>  drivers/power/reset/spacemit-p1-reboot.c | 88 ++++++++++++++++++++++++
>  3 files changed, 98 insertions(+)
>  create mode 100644 drivers/power/reset/spacemit-p1-reboot.c
> 
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index 8248895ca9038..6577d73edbda4 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -283,6 +283,15 @@ config POWER_RESET_KEYSTONE
>  	help
>  	  Reboot support for the KEYSTONE SoCs.
>  
> +config POWER_RESET_SPACEMIT_P1
> +	tristate "SpacemiT P1 poweroff and reset driver"
> +	depends on ARCH_SPACEMIT || COMPILE_TEST
..
> +	select MFD_SPACEMIT_P1
I'd suggest to use "depends on" instead of "select", the reason is that
using "select" will sometimes ignore the dependency, considering
the reset driver here is tightly coupled with P1, so I think it's 
reasonable to switch to use "depends on", also refer below link

https://lxr.linux.no/#linux+v6.7.1/Documentation/kbuild/kconfig-language.rst#L144

        select should be used with care. select will force
        a symbol to a value without visiting the dependencies.
        By abusing select you are able to select a symbol FOO even
        if FOO depends on BAR that is not set.
        In general use select only for non-visible symbols
        (no prompts anywhere) and for symbols with no dependencies.
        That will limit the usefulness but on the other hand avoid
        the illegal configurations all over.

> +	default m
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

-- 
Yixun Lan (dlan)

