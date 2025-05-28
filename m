Return-Path: <linux-pm+bounces-27707-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE8BAC5E24
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 02:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0D359E6721
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 00:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B191F5EA;
	Wed, 28 May 2025 00:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqBb9OrP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861DC1367;
	Wed, 28 May 2025 00:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748391655; cv=none; b=EVNAscTVr9Q5d4anvCWbJMIcNmSWhyectNpYkfZ0cjV9oxQLnuF6isHY3zqL7LaGmoaxln302N6vL+E+UN/7NC1Il+hU7GOY1LZdnDzm+v9huYKByCoQV6QSW5f4ZKjXm1wY4IPErgxWSw0HkNIl9hjTKnXCzH4Wp/TLQM+EtuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748391655; c=relaxed/simple;
	bh=07I8pZ0zqVggpS9U6quNsxu0qx6lmPVOZfAeN22ERBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWM+3iTdZN/CfPaj60Zri1sIl3RzVOTFEMiMs6/dD5VECXuBWggMIqUSModnJGoKpU1y1maUYwK/utgkt6eSqrUDILXdXk/d5njczrgqFalo4Z96kqNWe5K7AuQWHlnA/lT2TqKPgzkXsRy55HzuFdmJvQww1AvLF0AMZD80BNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqBb9OrP; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b271f3ae786so2376533a12.3;
        Tue, 27 May 2025 17:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748391653; x=1748996453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kWZ6iUW307N5iuj7sMs8339NMMA8wqPm/BKB3SNxcD8=;
        b=RqBb9OrPATwr+8Pzd8JHEvUDELF2yz6JxsQ0uMfPO2fz1gquIkLbd/BNWA2nPZy/OO
         Alr9pWfxd+xLVF0UDSweAO9p/+ZQToPkajRHTTr4aGMs+wYhBfDuA/bi1wKkWvWEwZIm
         vfN49PsHMhJO7j/CbNWpIim/VOOFTx2Lp3xhGinFj5ILFrZgXGkyiYVrudgc440GSkXB
         rsOuKP27kaK2kuXnPSMCWIdaMapBN/Rf/KXdImjWY4WhzSnmELzpQjEyGUwcWrm/XYcE
         btprwbOM/a8k4AaVlOo3VRXV7E4LAFY14VomadTOX77lPsib/4j7dW6ycJvI9knoBI81
         lA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748391653; x=1748996453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWZ6iUW307N5iuj7sMs8339NMMA8wqPm/BKB3SNxcD8=;
        b=OaysN4vL2KUrRTCK/aH619cXj6sSosZ56Qk95PV0HcRpGvvujBQ2uDIH4smamGF9K6
         Zuwcs3HWjqMwyRuZbSYzrPzZtTnGETci3FVnRktSmcL86qqv32adH04HOd6nLQU4EbQy
         Kbmarvw3DZATOzUnmMrV7UkmGt9nloLN+sM5AJqayQbeO98dDxJL3zIGGseFUR+BPxkI
         qn8AlBc8daFlV+LpYVoxhw2ek4j/rORqLZFkEHvXH70+L+6nLvxN0076l6rTRS4S21oU
         kUUPaS+BvglhMKZ5AHMatfLlvePFpdmx52fl2JEmxbKv2rpd9B9HAf1cqfTK/0BkeDQc
         61ww==
X-Forwarded-Encrypted: i=1; AJvYcCVBxRr1DOY6SoOonvYEWMwbjniHmogbJr7wZtiXAa4qha7yV3yo8ZJTAKZb1cXI4Ugmj46qA+PGlw0=@vger.kernel.org, AJvYcCW1X0NoT0YwcBa4BUGveMtUOKeKOTGMkNoCHhfaWphR/jr/Q7c+HycT06S9Mb6IuhCFKY6XWW57rZYa@vger.kernel.org, AJvYcCWcGvY39oB7lqIXYIJ+JxxYCAj+hZ4+A5FDS8AEyaU3gonJ+kZCAyThSAB1GNZQRxaHjA4DYCk0AnG2cbI=@vger.kernel.org, AJvYcCXWa0rV5cOOCEH3m/8jmtitF+PplZ+MVQIebmeoLcpTKQIaEAVF8ygSs89Hq5urZoptS60bN4D2Iv/xRk2k@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1+Y4jyp/pnI2Do9CXhA7loxIXenbSJopmF89tWYQrpRnU7IJh
	8N2oWBdOHzGd7zif2hfN9uj+jwiw4uENuKcP3k8tN7/J1ihkUz2aagtt
X-Gm-Gg: ASbGnct1xQ+6BA2893EbsXC1lzkKgyNStl4qMZzEjuR4hLlXYHG7TMfWoFx2dUl/RMa
	29T0kZL5uHdWxRclP5lEJPCZ/Si8nFZcsdyDxj+mXRr4g/VYck90x1AzIBv4scLSi1k2mAEamDC
	JYCNlvbgMdBaaA8yPJt4KdSIF5YDW0QqPgJullFyfKtufvxpdC+Q3WjBtZKe0FxG54kYHw4iAwT
	1JSxKPpPxdLcv7QIHZubjwRO+l3aE/TNsixJsaVSPvOCO2+REDTL9dkgGK21BTJQhzNddJp4xVk
	Meb08bD6LPGT3wZ97zGKo4Vx+r+yrsBxgdBysrlklmGJGIVd303/mN8pjgYWGsk=
X-Google-Smtp-Source: AGHT+IHkMqHNdBvwN7BnGeJysfykY0aSAvyCsDf4+q5TK7fnOhHB5Dl68f/952BrcbnMXhQ2+5boOw==
X-Received: by 2002:a17:90b:44:b0:30e:712e:5739 with SMTP id 98e67ed59e1d1-311e740329emr591342a91.14.1748391652552;
        Tue, 27 May 2025 17:20:52 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:a04a:d85e:c794:147c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-311e3da5c22sm169847a91.21.2025.05.27.17.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 17:20:52 -0700 (PDT)
Date: Tue, 27 May 2025 17:20:48 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: samuel.kayode@savoirfairelinux.com
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-pm@vger.kernel.org, eballetbo@gmail.com, 
	abelvesa@linux.com, b38343@freescale.com, yibin.gong@nxp.com, 
	Abel Vesa <abelvesa@kernel.org>
Subject: Re: [PATCH v3 4/6] input: pf1550: add onkey support
Message-ID: <xuuvptsz6ryeanj4wu6hzzskcdspwdis4p54hhsbhny5mmcodw@2ihxnzlva5ff>
References: <20250527-pf1550-v3-0-45f69453cd51@savoirfairelinux.com>
 <20250527-pf1550-v3-4-45f69453cd51@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527-pf1550-v3-4-45f69453cd51@savoirfairelinux.com>

Hi Samuel,

On Tue, May 27, 2025 at 06:25:36PM -0400, Samuel Kayode via B4 Relay wrote:
> From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
> 
> Add support for the onkey of the pf1550 PMIC.
> 
> Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
> ---
> v3:
> - Address Dmitry's feedback
>   - Drop compatible string
>   - Remove dependency on OF
>   - Use generic device properties
>   - Drop unnecessary includes
>   - Drop unnecessary initializations in probe
>   - Always use the KEY_POWER property for onkey->keycode
>   - Do mapping of irqs in MFD driver
>   - Define onkey->input before interrupts are active
>   - Drop unnecessary input_free_device since devm
>   - Manage onkey irqs instead of the main interrupt line.
> - Fix integer overflow when unmasking onkey irqs in onkey_resume.

Thank you for making changes, some more comments below.

> v2:
> - Add driver for onkey
> ---
>  drivers/input/misc/Kconfig        |  11 +++
>  drivers/input/misc/Makefile       |   1 +
>  drivers/input/misc/pf1550-onkey.c | 202 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 214 insertions(+)
> 
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index f5496ca0c0d2bfcb7968503ccd1844ff43bbc1c0..50ae50628f4d03f54b5678dbd28e3b58f8d02f86 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -179,6 +179,17 @@ config INPUT_PCSPKR
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called pcspkr.
>  
> +config INPUT_PF1550_ONKEY
> +	tristate "PF1550 Onkey support"
> +	depends on MFD_PF1550
> +	help
> +	  Say Y here if you want support for PF1550 PMIC. Onkey can trigger
> +	  release and 1s(push hold), 2s, 3s, 4s, 8s interrupt for long press
> +	  detect.
> +
> +	  To compile this driver as a module, choose M here. The module will be
> +	  called pf1550-onkey.
> +
>  config INPUT_PM8941_PWRKEY
>  	tristate "Qualcomm PM8941 power key support"
>  	depends on MFD_SPMI_PMIC
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> index 6d91804d0a6f761a094e6c380f878f74c3054d63..c652337de464c1eeaf1515d0bc84d10de0cb3a74 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -62,6 +62,7 @@ obj-$(CONFIG_INPUT_PCAP)		+= pcap_keys.o
>  obj-$(CONFIG_INPUT_PCF50633_PMU)	+= pcf50633-input.o
>  obj-$(CONFIG_INPUT_PCF8574)		+= pcf8574_keypad.o
>  obj-$(CONFIG_INPUT_PCSPKR)		+= pcspkr.o
> +obj-$(CONFIG_INPUT_PF1550_ONKEY)	+= pf1550-onkey.o
>  obj-$(CONFIG_INPUT_PM8941_PWRKEY)	+= pm8941-pwrkey.o
>  obj-$(CONFIG_INPUT_PM8XXX_VIBRATOR)	+= pm8xxx-vibrator.o
>  obj-$(CONFIG_INPUT_PMIC8XXX_PWRKEY)	+= pmic8xxx-pwrkey.o
> diff --git a/drivers/input/misc/pf1550-onkey.c b/drivers/input/misc/pf1550-onkey.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..7c10bc75708891a22d8b67b44e55f18c42f09749
> --- /dev/null
> +++ b/drivers/input/misc/pf1550-onkey.c
> @@ -0,0 +1,202 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for the PF1550 ON_KEY
> + * Copyright (C) 2016 Freescale Semiconductor, Inc. All Rights Reserved.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mfd/pf1550.h>
> +#include <linux/platform_device.h>
> +
> +#define PF1550_ONKEY_IRQ_NR	6
> +
> +struct onkey_drv_data {
> +	struct device *dev;
> +	struct pf1550_dev *pf1550;
> +	unsigned int irq;

I do not think you need to store this (with the current code).

> +	int keycode;

If you always send KEY_POWER you do not need to store keycode here.

> +	int wakeup;

bool?

> +	struct input_dev *input;
> +};
> +
> +static irqreturn_t pf1550_onkey_irq_handler(int irq, void *data)
> +{
> +	struct onkey_drv_data *onkey = data;
> +	struct irq_domain *domain;
> +	int i, state, irq_type = -1;
> +	unsigned int virq;
> +
> +	domain = regmap_irq_get_domain(onkey->pf1550->irq_data_onkey);
> +	onkey->irq = irq;
> +
> +	for (i = 0; i < PF1550_ONKEY_IRQ_NR; i++) {
> +		virq = irq_find_mapping(domain, i);
> +		if (onkey->irq == virq)
> +			irq_type = i;
> +	}

I wonder why the driver still needs to poke into the IRQ domain? Is it
possible to have the mapped IRQs described as resources in onkey MFD
cell so here we can use platform_get_irq() or platform_get_irq_byname()
and use them? You can specify that "pushi" should be the first platform
IRQ, or go by names...

> +
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
> +	struct input_dev *input;
> +	struct pf1550_dev *pf1550 = dev_get_drvdata(pdev->dev.parent);

Can this be const?

> +	struct irq_domain *domain;
> +	int i, error;
> +
> +	onkey = devm_kzalloc(&pdev->dev, sizeof(*onkey), GFP_KERNEL);
> +	if (!onkey)
> +		return -ENOMEM;
> +
> +	if (!pf1550->regmap)
> +		return dev_err_probe(&pdev->dev, -ENODEV,
> +				     "failed to get regmap\n");
> +
> +	onkey->wakeup = device_property_read_bool(pdev->dev.parent,
> +						  "wakeup-source");
> +
> +	input = devm_input_allocate_device(&pdev->dev);
> +	if (!input)
> +		return dev_err_probe(&pdev->dev, -ENOMEM,
> +				     "failed to allocate the input device\n");
> +
> +	onkey->input = input;
> +	onkey->keycode = KEY_POWER;
> +
> +	input->name = pdev->name;
> +	input->phys = "pf1550-onkey/input0";
> +	input->id.bustype = BUS_HOST;
> +
> +	input_set_capability(input, EV_KEY, onkey->keycode);
> +
> +	domain = regmap_irq_get_domain(pf1550->irq_data_onkey);
> +
> +	for (i = 0; i < PF1550_ONKEY_IRQ_NR; i++) {
> +		unsigned int virq = irq_find_mapping(domain, i);

As I mentioned, I wonder if we can change the core so we use:

		irq = platform_get_irq(pdev, i);

> +
> +		error = devm_request_threaded_irq(&pdev->dev, virq, NULL,
> +						  pf1550_onkey_irq_handler,
> +						  IRQF_NO_SUSPEND,
> +						  "pf1550-onkey", onkey);
> +		if (error)
> +			return dev_err_probe(&pdev->dev, error,
> +					     "failed: irq request (IRQ: %d)\n",
> +					     i);
> +	}
> +
> +	error = input_register_device(input);
> +	if (error < 0)

Just "if (error)"

> +		return dev_err_probe(&pdev->dev, error,
> +				     "failed to register input device\n");
> +
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
> +	struct irq_domain *domain;
> +	unsigned int virq;
> +	int i;
> +
> +	domain = regmap_irq_get_domain(onkey->pf1550->irq_data_onkey);
> +
> +	if (!device_may_wakeup(&pdev->dev)) {
> +		regmap_write(onkey->pf1550->regmap,
> +			     PF1550_PMIC_REG_ONKEY_INT_MASK0,
> +			     ONKEY_IRQ_PUSHI | ONKEY_IRQ_1SI | ONKEY_IRQ_2SI |
> +			     ONKEY_IRQ_3SI | ONKEY_IRQ_4SI | ONKEY_IRQ_8SI);
> +	} else {
> +		for (i = 0; i < PF1550_ONKEY_IRQ_NR; i++) {
> +			virq = irq_find_mapping(domain, i);
> +
> +			if (virq)
> +				enable_irq_wake(virq);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int pf1550_onkey_resume(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct onkey_drv_data *onkey = platform_get_drvdata(pdev);
> +	struct irq_domain *domain;
> +	unsigned int virq;
> +	int i;
> +
> +	domain = regmap_irq_get_domain(onkey->pf1550->irq_data_onkey);
> +
> +	if (!device_may_wakeup(&pdev->dev)) {
> +		regmap_write(onkey->pf1550->regmap,
> +			     PF1550_PMIC_REG_ONKEY_INT_MASK0,
> +			     ~((u8)(ONKEY_IRQ_PUSHI | ONKEY_IRQ_1SI |
> +			     ONKEY_IRQ_2SI | ONKEY_IRQ_3SI | ONKEY_IRQ_4SI |
> +			     ONKEY_IRQ_8SI)));
> +	} else {
> +		for (i = 0; i < PF1550_ONKEY_IRQ_NR; i++) {
> +			virq = irq_find_mapping(domain, i);
> +
> +			if (virq)
> +				disable_irq_wake(virq);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(pf1550_onkey_pm_ops, pf1550_onkey_suspend,
> +			 pf1550_onkey_resume);
> +
> +static const struct platform_device_id pf1550_onkey_id[] = {
> +	{ "pf1550-onkey", PF1550 },

Why do we need to set driver_data here? 

> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(platform, pf1550_onkey_id);
> +
> +static struct platform_driver pf1550_onkey_driver = {
> +	.driver = {
> +		.name = "pf1550-onkey",
> +		.pm   = &pf1550_onkey_pm_ops,
> +	},
> +	.probe = pf1550_onkey_probe,
> +	.id_table = pf1550_onkey_id,
> +};
> +module_platform_driver(pf1550_onkey_driver);
> +
> +MODULE_AUTHOR("Freescale Semiconductor");
> +MODULE_DESCRIPTION("PF1550 onkey Driver");
> +MODULE_LICENSE("GPL");

Thanks.

-- 
Dmitry

