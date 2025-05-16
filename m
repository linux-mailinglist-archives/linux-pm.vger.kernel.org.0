Return-Path: <linux-pm+bounces-27253-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5893FABA61A
	for <lists+linux-pm@lfdr.de>; Sat, 17 May 2025 00:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C14F57B8EE9
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 22:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A49280011;
	Fri, 16 May 2025 22:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crpsh6Xx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E52327FD47;
	Fri, 16 May 2025 22:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747436108; cv=none; b=IGWnQxvId66eFJzEJVogni1h9EgJ6kcsHHhpDSyknL2A0Un9x5FeanE6DuZafdN4GydMOWwy9wQcOlwhTTYGwVFYqKKU46NflNmhXtxhUpAuYZiqCmL7sixBylDscxJFSOB5jq2+xP5TDmXRhDx86oNCn3eGfUCYHTM4ebdqGuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747436108; c=relaxed/simple;
	bh=hOMLuFduWtXN/+QtxXzHUO4wiaD+EKQzuAeNWwZgs5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlwFyQkqIU3UYe0sQVnn+hB70+DJJElXcpOIn0ZxnjnCcafktQI7ar9ClmekW7AUDDlhJTDefaDXWlemTTyZX7cO43BPPajwLhOFlbe73SL0VEKfM/W/nBQcuLjv37wQFH3dm8eyydlSk1mLELpE9xjY7f5nVuJENq1sOTb6XW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crpsh6Xx; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-74068f95d9fso2536668b3a.0;
        Fri, 16 May 2025 15:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747436106; x=1748040906; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yex2W6o3RIbU+dPn4cbk1jEW3HNCiH3A6lnrJWDSkTs=;
        b=crpsh6XxYjKTMZ670EwqtZcuTjFfjfZgmj5FfAWAcZUrl25MV0nsRj9ZE+sy14iPaT
         jR3R6aRUDl8YUN6LoxGirKTA05p3msGFEj9ZAZD6n/E/uEk1KMnOjlZFIAZ+lEDe506d
         lHCzRfjmEW7ldfuNJNL+pNaVViJ7Uf8Ug4jEUGM2jtiumWBpIKstF+KbyVNJU3nAxSKn
         RoAeEPdN0PCAn9lXhFv5vmCSqCxi7LNoeR2CNRoGoRwn8Z/LXbf+wh+1NKaRXC7R1o0c
         aKBhGFyPRb1coOZHpKQqnXY86v8dpkEW6yIQeNDeEZ0Tmsf2Nl28wQImTvRHAJMaUnHu
         7gSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747436106; x=1748040906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yex2W6o3RIbU+dPn4cbk1jEW3HNCiH3A6lnrJWDSkTs=;
        b=wDiBaXNmd5Pn3HGbSQNyKSAVd09dcozkMkaD8Eq+nI20Z7g1uNXGdyFc9xoic8KWLh
         4uiwQuXSkZ1FngMYTRRl1LuxTb9L4L5xOOlAUjmN0kFXSyq/xyj43WD2FGpbU58ZDDbU
         Nm5IETniwAloOYVlgL7hCghStANrxlPYyfhcroWBEvdZSL30747SITN3EOI9zStJcSTT
         ran/jUbe2l5NX5+7cxJ8a6zKZ9D/V5ufLA0NelcjpLW+LjtI6+X2n6GivTkmaH0M8+mi
         Jf07PjIbk/VCy+FboxWw8Lty19qV7SQegmAPNqCc28HvOKj20wHwFIazaLXj8PleWWfK
         6D1w==
X-Forwarded-Encrypted: i=1; AJvYcCWBpXm/TM5WHnEFFtZb/tVDHM3alsmp0D2JYYyL9QSuEBPu5uV64nd/cSEfi75QoStO9imWLyKnGgw=@vger.kernel.org, AJvYcCWpv+8r4Gc7oeVnrX19zsZKma8arWn+I8KR49V8oXZ1VwG5vTi3lYY/y1vBexB4HFISWbK+dPCBDLqNMA==@vger.kernel.org, AJvYcCXsU9kCiYekVxGAk4abzpQjeuC1RjoNDCsl560IEOLmIb2FZ84mSLhmvv9D2vwJD28KPGTPyjfJIsXV4obN@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0OV4dRcw3URpokCSoyl9twCFkVhJ94ngmBg82IumVWm5+oxci
	2XGsht2tRCEHo1Cun4WkbPov8EWmy9V966G4v7SXE6pNEgy5DERxe1uB
X-Gm-Gg: ASbGnct1++7DO9UaDUx+u8UcNZSFdOUo2G/3897vgmTUjqvTvE6aiRysn1Y6Z9pQX99
	5SW5h9zJ/lOocIz0ZRuFmaaZXqDXGgCmgiTfjsgnZ5Dp8hswYlXJdQFMhSpqytbJzKlgV5/E7JL
	tPxcjaQbLwL0wZn68QAWy6duPZTo0JTg+hDf1ekWPkqG1xaPOO2gYenviR/NCN5CMjVBVePjPV9
	g1MhPqE/pF8uVn1O1Fc3SKYPdamTOdg+DVjMrYFXj9NWFyf2E68F1xTfXb945md8zEo+B8BHmHu
	Go7eIvJa4rCHOITLQSgWtuCKdsqy2BE4SUOj10klO39PKGTcD9EJ
X-Google-Smtp-Source: AGHT+IFJJpotdf2hO7IWi0L0BmRbcD4UD8MNE8RzIOi28CQIakKjLKr9e+0/CTdk+V3lKW5ekgPfpQ==
X-Received: by 2002:a05:6a00:3e0b:b0:736:51ab:7aed with SMTP id d2e1a72fcca58-742acd50ac5mr6476948b3a.16.1747436105507;
        Fri, 16 May 2025 15:55:05 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:b895:bc3d:709a:d586])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a970c882sm2137590b3a.55.2025.05.16.15.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 15:55:04 -0700 (PDT)
Date: Fri, 16 May 2025 15:55:02 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
Cc: Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Robin Gong <yibin.gong@nxp.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-imx@nxp.com, linux-input@vger.kernel.org, Abel Vesa <abelvesa@linux.com>, 
	Abel Vesa <abel.vesa@nxp.com>, Robin Gong <b38343@freescale.com>, 
	Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v2 7/9] input: pf1550: add onkey support
Message-ID: <pnfj4tyj3hovtu5ttnecmgozdq7hm2clxhl4xpuzrahlrzqmdm@qpdr4z2y5ylg>
References: <cover.1747409892.git.samuel.kayode@savoirfairelinux.com>
 <7d80afedf1ad9e98c9739163751bcb2785009e74.1747409892.git.samuel.kayode@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d80afedf1ad9e98c9739163751bcb2785009e74.1747409892.git.samuel.kayode@savoirfairelinux.com>

Hi Samuel,

On Fri, May 16, 2025 at 02:57:28PM -0400, Samuel Kayode wrote:
> Add support for the onkey of the pf1550 PMIC.
> 
> Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
> ---
>  drivers/input/keyboard/Kconfig        |   8 ++
>  drivers/input/keyboard/Makefile       |   1 +
>  drivers/input/keyboard/pf1550_onkey.c | 200 ++++++++++++++++++++++++++
>  3 files changed, 209 insertions(+)
>  create mode 100644 drivers/input/keyboard/pf1550_onkey.c
> 
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index 721ab69e84ac..b01decc03ab9 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -444,6 +444,14 @@ config KEYBOARD_SNVS_PWRKEY
>  	  To compile this driver as a module, choose M here; the
>  	  module will be called snvs_pwrkey.

With the exception of snvs-pwrkey, all other onkey/pwrkey drivers live
in drivers/input/misc, please move them there. drivers/input/keyboard is
really for real keyboard devices.

>  
> +config KEYBOARD_PF1550_ONKEY
> +	tristate "PF1550 OnKey Driver"
> +	depends on MFD_PF1550
> +	depends on OF

I do not think your driver has any direct dependencies on OF, especially
if you switch to using generic device properties (device_property_read_*).

> +	help
> +	  This is onkey driver for PF1550 pmic, onkey can trigger release
> +	  and 1s(push hold), 2s, 3s, 4s, 8s interrupt for long press detect
> +
>  config KEYBOARD_IMX
>  	tristate "IMX keypad support"
>  	depends on ARCH_MXC || COMPILE_TEST
> diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
> index 1e0721c30709..8a6feae3ddb1 100644
> --- a/drivers/input/keyboard/Makefile
> +++ b/drivers/input/keyboard/Makefile
> @@ -59,6 +59,7 @@ obj-$(CONFIG_KEYBOARD_QT2160)		+= qt2160.o
>  obj-$(CONFIG_KEYBOARD_SAMSUNG)		+= samsung-keypad.o
>  obj-$(CONFIG_KEYBOARD_SH_KEYSC)		+= sh_keysc.o
>  obj-$(CONFIG_KEYBOARD_SNVS_PWRKEY)	+= snvs_pwrkey.o
> +obj-$(CONFIG_KEYBOARD_PF1550_ONKEY)	+= pf1550_onkey.o
>  obj-$(CONFIG_KEYBOARD_SPEAR)		+= spear-keyboard.o
>  obj-$(CONFIG_KEYBOARD_STMPE)		+= stmpe-keypad.o
>  obj-$(CONFIG_KEYBOARD_STOWAWAY)		+= stowaway.o
> diff --git a/drivers/input/keyboard/pf1550_onkey.c b/drivers/input/keyboard/pf1550_onkey.c
> new file mode 100644
> index 000000000000..b0601acf893d
> --- /dev/null
> +++ b/drivers/input/keyboard/pf1550_onkey.c
> @@ -0,0 +1,200 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for the PF1550 ON_KEY
> + * Copyright (C) 2016 Freescale Semiconductor, Inc. All Rights Reserved.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>

I don't think you actually need io.h

> +#include <linux/jiffies.h>

and neither jiffies.h. Please audit your includes.

> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mfd/pf1550.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +struct onkey_drv_data {
> +	struct device *dev;
> +	struct pf1550_dev *pf1550;
> +	int irq;
> +	int keycode;
> +	int wakeup;
> +	struct input_dev *input;
> +};
> +
> +static struct pf1550_irq_info pf1550_onkey_irqs[] = {
> +	{ PF1550_ONKEY_IRQ_PUSHI,	"release" },
> +	{ PF1550_ONKEY_IRQ_1SI,		"1S" },
> +	{ PF1550_ONKEY_IRQ_2SI,		"2S" },
> +	{ PF1550_ONKEY_IRQ_3SI,		"3S" },
> +	{ PF1550_ONKEY_IRQ_4SI,		"4S" },
> +	{ PF1550_ONKEY_IRQ_8SI,		"8S" },
> +};
> +
> +static irqreturn_t pf1550_onkey_irq_handler(int irq, void *data)
> +{
> +	struct onkey_drv_data *onkey = data;
> +	int i, state, irq_type = -1;
> +
> +	onkey->irq = irq;
> +
> +	for (i = 0; i < ARRAY_SIZE(pf1550_onkey_irqs); i++)
> +		if (onkey->irq == pf1550_onkey_irqs[i].virq)
> +			irq_type = pf1550_onkey_irqs[i].irq;
> +	switch (irq_type) {
> +	case PF1550_ONKEY_IRQ_PUSHI:
> +		state = 0;
> +		break;
> +	case PF1550_ONKEY_IRQ_1SI:
> +	case PF1550_ONKEY_IRQ_2SI:
> +	case PF1550_ONKEY_IRQ_3SI:
> +	case PF1550_ONKEY_IRQ_4SI:
> +	case PF1550_ONKEY_IRQ_8SI:
> +		state = 1;
> +		break;
> +	default:
> +		dev_err(onkey->dev, "onkey interrupt: irq %d occurred\n",
> +			irq_type);
> +		return IRQ_HANDLED;
> +	}
> +
> +	input_event(onkey->input, EV_KEY, onkey->keycode, state);
> +	input_sync(onkey->input);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int pf1550_onkey_probe(struct platform_device *pdev)
> +{
> +	struct onkey_drv_data *onkey;
> +	struct input_dev *input = NULL;

This initialization is not needed.

> +	struct device_node *np = pdev->dev.of_node;

Please switch to generic device properties and stop referencing of_node.

> +	struct pf1550_dev *pf1550 = dev_get_drvdata(pdev->dev.parent);
> +	int i, error;
> +
> +	if (!np)
> +		return -ENODEV;
> +
> +	onkey = devm_kzalloc(&pdev->dev, sizeof(*onkey), GFP_KERNEL);
> +	if (!onkey)
> +		return -ENOMEM;
> +
> +	if (of_property_read_u32(np, "linux,keycodes", &onkey->keycode)) {
> +		onkey->keycode = KEY_POWER;
> +		dev_warn(&pdev->dev, "KEY_POWER without setting in dts\n");

Maybe make this property mandatory?

> +	}
> +
> +	onkey->wakeup = of_property_read_bool(np, "wakeup-source");
> +
> +	input = devm_input_allocate_device(&pdev->dev);
> +	if (!input) {
> +		dev_err(&pdev->dev, "failed to allocate the input device\n");
> +		return -ENOMEM;
> +	}
> +
> +	input->name = pdev->name;
> +	input->phys = "pf1550-onkey/input0";
> +	input->id.bustype = BUS_HOST;
> +
> +	input_set_capability(input, EV_KEY, onkey->keycode);
> +
> +	for (i = 0; i < ARRAY_SIZE(pf1550_onkey_irqs); i++) {
> +		struct pf1550_irq_info *onkey_irq =
> +						&pf1550_onkey_irqs[i];
> +		unsigned int virq = 0;
> +
> +		virq = regmap_irq_get_virq(pf1550->irq_data_onkey,
> +					   onkey_irq->irq);
> +		if (!virq)
> +			return -EINVAL;
> +
> +		onkey_irq->virq = virq;

I think this kind of mapping needs to be done in the core part of your
driver.

> +
> +		error = devm_request_threaded_irq(&pdev->dev, virq, NULL,
> +						  pf1550_onkey_irq_handler,
> +					IRQF_NO_SUSPEND,
> +					onkey_irq->name, onkey);
> +		if (error) {
> +			dev_err(&pdev->dev,
> +				"failed: irq request (IRQ: %d, error :%d)\n",
> +				onkey_irq->irq, error);
> +			return error;
> +		}
> +	}
> +
> +	error = input_register_device(input);
> +	if (error < 0) {

Input API return 0 or negative, so simply "if (error) { ... }"

> +		dev_err(&pdev->dev, "failed to register input device\n");
> +		input_free_device(input);

You are using devm, so no need to free it manually.

> +		return error;
> +	}
> +
> +	onkey->input = input;

You are too late. Interrupts are already active and you may dereference
onkey->input from your ISR.

> +	onkey->pf1550 = pf1550;
> +	platform_set_drvdata(pdev, onkey);
> +
> +	device_init_wakeup(&pdev->dev, onkey->wakeup);
> +
> +	return 0;
> +}
> +
> +static int pf1550_onkey_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct onkey_drv_data *onkey = platform_get_drvdata(pdev);
> +
> +	if (!device_may_wakeup(&pdev->dev))
> +		regmap_write(onkey->pf1550->regmap,
> +			     PF1550_PMIC_REG_ONKEY_INT_MASK0,
> +			     ONKEY_IRQ_PUSHI | ONKEY_IRQ_1SI | ONKEY_IRQ_2SI |
> +			     ONKEY_IRQ_3SI | ONKEY_IRQ_4SI | ONKEY_IRQ_8SI);
> +	else
> +		enable_irq_wake(onkey->pf1550->irq);

This is suspicious that you need to twiddle the state of the main
interrupt line. I'd expect you manipulate your own interrupts and this
all cascades up.

> +
> +	return 0;
> +}
> +
> +static int pf1550_onkey_resume(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct onkey_drv_data *onkey = platform_get_drvdata(pdev);
> +
> +	if (!device_may_wakeup(&pdev->dev))
> +		regmap_write(onkey->pf1550->regmap,
> +			     PF1550_PMIC_REG_ONKEY_INT_MASK0,
> +			     ~(ONKEY_IRQ_PUSHI | ONKEY_IRQ_1SI | ONKEY_IRQ_2SI |
> +			     ONKEY_IRQ_3SI | ONKEY_IRQ_4SI | ONKEY_IRQ_8SI));
> +	else
> +		disable_irq_wake(onkey->pf1550->irq);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id pf1550_onkey_ids[] = {
> +	{ .compatible = "fsl,pf1550-onkey" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, pf1550_onkey_ids);
> +
> +static SIMPLE_DEV_PM_OPS(pf1550_onkey_pm_ops, pf1550_onkey_suspend,
> +				pf1550_onkey_resume);
> +
> +static struct platform_driver pf1550_onkey_driver = {
> +	.driver = {
> +		.name = "pf1550-onkey",
> +		.pm     = &pf1550_onkey_pm_ops,
> +		.of_match_table = pf1550_onkey_ids,
> +	},
> +	.probe = pf1550_onkey_probe,
> +};
> +module_platform_driver(pf1550_onkey_driver);
> +
> +MODULE_AUTHOR("Freescale Semiconductor");
> +MODULE_DESCRIPTION("PF1550 onkey Driver");
> +MODULE_LICENSE("GPL v2");

Thanks.

-- 
Dmitry

