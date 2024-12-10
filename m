Return-Path: <linux-pm+bounces-18970-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C3F9EBD77
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 23:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAD9318893C0
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 22:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DC02451F9;
	Tue, 10 Dec 2024 22:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="k4Dg2g3j"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708182451F1;
	Tue, 10 Dec 2024 22:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733868236; cv=none; b=eucGV0aKvLpn1Mebk2PfbPdY7nrSmSuU0NgyRgwCNyjEd5pwJTjgxwj872xlZvt/PxmJg6jE8d3rZxePgwv9055c9+REfGC84CxmVb4oa8NsrmpbMhMy/prRhSTr3rNhqRD+DDzgkhfugeJlCF2pVbnBcVQZcqRlVLzOTBkiB0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733868236; c=relaxed/simple;
	bh=chLVF/n4S2Gt6eJE4eERHqu9z2YYk6cN5qGEAS+WPco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HEeqb2exiccF6FhJvY35QjhucWBIg1ObrX2ZcDoKdT/R8OK7L9aupwjEa7kVQ07YzIb8ppSDi2XKKs3mEJwCoKoDQstsozyy/7kGCbB90QKGlq/k82O77MG/RCY9is5tGg3MDNw0GnyDZA76K50NyybH2/tsE3a4Up+X4hBCoBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=k4Dg2g3j; arc=none smtp.client-ip=80.12.242.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id L8JMt1CCAzLhcL8JMtnHY8; Tue, 10 Dec 2024 23:02:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1733868154;
	bh=vdIWqiL9YeYZIPJs3LWY7CxT8XaVOOt8ra806CiqypQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=k4Dg2g3jch4CBWVmgDqiSXMbtFnM8Ou9fxDwZNVBuQt0wM/FopsqJS25t6tUQm4GS
	 qx40inpNoxdOPeEp3w0NxlwYnVOO18kKLuO6OeP1GQE4HipP8jnysiKbCM/2NiyFTN
	 aJYh2vDhWYLrFKr0qQ9Oi2Wh+G5niJcjJdiHgFkwqGDIvujq70CEp07/tkQ4hOzYNP
	 ilPaBNxfWKv6zTi3oqv3Ke6y37lAoJBSQVHlblWOCvJC4d4cgga9LLGLyH2bVQLjgO
	 DWSRQ4+5BzyFijUyvfswwGjNeinHRXaIbPjtRWvDHbIu2vpnXQptJdDgyOqRcuM71s
	 M65I71Ej4GvGA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 10 Dec 2024 23:02:34 +0100
X-ME-IP: 90.11.132.44
Message-ID: <99cfb914-dc4e-4cb1-b4c7-c8b0e62cc3fa@wanadoo.fr>
Date: Tue, 10 Dec 2024 23:02:32 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 6/9] mfd: Add new driver for MAX77705 PMIC
To: Dzmitry Sankouski <dsankouski@gmail.com>,
 Sebastian Reichel <sre@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>,
 Hans de Goede <hdegoede@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
 Purism Kernel Team <kernel@puri.sm>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-input@vger.kernel.org,
 linux-leds@vger.kernel.org
References: <20241209-starqltechn_integration_upstream-v11-0-dc0598828e01@gmail.com>
 <20241209-starqltechn_integration_upstream-v11-6-dc0598828e01@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20241209-starqltechn_integration_upstream-v11-6-dc0598828e01@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 09/12/2024 à 12:26, Dzmitry Sankouski a écrit :
> Add the core MFD driver for max77705 PMIC. We define five sub-devices
> for which the drivers will be added in subsequent patches.
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> 
> ---

...

> diff --git a/drivers/mfd/max77705.c b/drivers/mfd/max77705.c
> new file mode 100644
> index 000000000000..bf71d4399b23
> --- /dev/null
> +++ b/drivers/mfd/max77705.c
> @@ -0,0 +1,233 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +//
> +// Maxim MAX77705 PMIC core driver
> +//
> +// Copyright (C) 2024 Dzmitry Sankouski <dsankouski@gmail.com>
> +
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/max77705-private.h>
> +#include <linux/mfd/max77693-common.h>
> +#include <linux/pm.h>
> +#include <linux/power/max17042_battery.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/of.h>
> +
> +#define I2C_ADDR_FG     0x36
> +#define	FUEL_GAUGE_NAME "max77705-battery"
> +
> +const struct dev_pm_ops max77705_pm_ops;

I'm not sure that this is needed.

DEFINE_SIMPLE_DEV_PM_OPS() at the end of the file already define it, IIUC.

...

> +static int max77705_resume(struct device *dev)
> +{
> +	struct i2c_client *i2c = to_i2c_client(dev);
> +	struct max77693_dev *max77705 = i2c_get_clientdata(i2c);
> +
> +	if (device_may_wakeup(dev))
> +		disable_irq_wake(max77705->irq);
> +
> +	enable_irq(max77705->irq);
> +
> +	return 0;
> +}
> +DEFINE_SIMPLE_DEV_PM_OPS(max77705_pm_ops, max77705_suspend, max77705_resume);
> +
> +static const struct of_device_id max77705_i2c_of_match[] = {
> +	{ .compatible = "maxim,max77705" },
> +	{ },

Nitpick: Unneeded ending comma

> +};
> +MODULE_DEVICE_TABLE(of, max77705_i2c_of_match);

...

> +enum max77705_reg {
> +	MAX77705_PMIC_REG_PMICID1		= 0x00,
> +	MAX77705_PMIC_REG_PMICREV		= 0x01,
> +	MAX77705_PMIC_REG_MAINCTRL1		= 0x02,
> +	MAX77705_PMIC_REG_BSTOUT_MASK		= 0x03,
> +	MAX77705_PMIC_REG_FORCE_EN_MASK		= 0x08,
> +	MAX77705_PMIC_REG_MCONFIG		= 0x10,
> +	MAX77705_PMIC_REG_MCONFIG2		= 0x11,
> +	MAX77705_PMIC_REG_INTSRC		= 0x22,
> +	MAX77705_PMIC_REG_INTSRC_MASK		= 0x23,
> +	MAX77705_PMIC_REG_SYSTEM_INT		= 0x24,
> +	MAX77705_PMIC_REG_RESERVED_25		= 0x25,
> +	MAX77705_PMIC_REG_SYSTEM_INT_MASK	= 0x26,
> +	MAX77705_PMIC_REG_RESERVED_27		= 0x27,
> +	MAX77705_PMIC_REG_RESERVED_28		= 0x28,
> +	MAX77705_PMIC_REG_RESERVED_29		= 0x29,
> +	MAX77705_PMIC_REG_BOOSTCONTROL1		= 0x4C,
> +	MAX77705_PMIC_REG_BOOSTCONTROL2		= 0x4F,
> +	MAX77705_PMIC_REG_SW_RESET		= 0x50,
> +	MAX77705_PMIC_REG_USBC_RESET		= 0x51,
> +
> +	MAX77705_PMIC_REG_END,

Nitpick: Unneeded ending comma

> +};

...

> +enum max77705_fuelgauge_reg {
> +	STATUS_REG				= 0x00,
> +	VALRT_THRESHOLD_REG			= 0x01,
> +	TALRT_THRESHOLD_REG			= 0x02,
> +	SALRT_THRESHOLD_REG			= 0x03,
> +	REMCAP_REP_REG				= 0x05,
> +	SOCREP_REG				= 0x06,
> +	TEMPERATURE_REG				= 0x08,
> +	VCELL_REG				= 0x09,
> +	TIME_TO_EMPTY_REG			= 0x11,
> +	FULLSOCTHR_REG				= 0x13,
> +	CURRENT_REG				= 0x0A,
> +	AVG_CURRENT_REG				= 0x0B,
> +	SOCMIX_REG				= 0x0D,
> +	SOCAV_REG				= 0x0E,
> +	REMCAP_MIX_REG				= 0x0F,
> +	FULLCAP_REG				= 0x10,
> +	RFAST_REG				= 0x15,
> +	AVR_TEMPERATURE_REG			= 0x16,
> +	CYCLES_REG				= 0x17,
> +	DESIGNCAP_REG				= 0x18,
> +	AVR_VCELL_REG				= 0x19,
> +	TIME_TO_FULL_REG			= 0x20,
> +	CONFIG_REG				= 0x1D,
> +	ICHGTERM_REG				= 0x1E,
> +	REMCAP_AV_REG				= 0x1F,
> +	FULLCAP_NOM_REG				= 0x23,
> +	LEARN_CFG_REG				= 0x28,
> +	FILTER_CFG_REG				= 0x29,
> +	MISCCFG_REG				= 0x2B,
> +	QRTABLE20_REG				= 0x32,
> +	FULLCAP_REP_REG				= 0x35,
> +	RCOMP_REG				= 0x38,
> +	VEMPTY_REG				= 0x3A,
> +	FSTAT_REG				= 0x3D,
> +	DISCHARGE_THRESHOLD_REG			= 0x40,
> +	QRTABLE30_REG				= 0x42,
> +	ISYS_REG				= 0x43,
> +	DQACC_REG				= 0x45,
> +	DPACC_REG				= 0x46,
> +	AVGISYS_REG				= 0x4B,
> +	QH_REG					= 0x4D,
> +	VSYS_REG				= 0xB1,
> +	TALRTTH2_REG				= 0xB2,
> +	VBYP_REG				= 0xB3,
> +	CONFIG2_REG				= 0xBB,
> +	IIN_REG					= 0xD0,
> +	OCV_REG					= 0xEE,
> +	VFOCV_REG				= 0xFB,
> +	VFSOC_REG				= 0xFF,
> +
> +	MAX77705_FG_END,

Nitpick: Unneeded ending comma

> +};

...

CJ

