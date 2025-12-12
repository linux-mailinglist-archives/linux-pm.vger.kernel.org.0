Return-Path: <linux-pm+bounces-39473-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D134CB9964
	for <lists+linux-pm@lfdr.de>; Fri, 12 Dec 2025 19:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 191E3301778D
	for <lists+linux-pm@lfdr.de>; Fri, 12 Dec 2025 18:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA09C309DCC;
	Fri, 12 Dec 2025 18:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihuRZLqT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33AF3093BC
	for <linux-pm@vger.kernel.org>; Fri, 12 Dec 2025 18:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765565008; cv=none; b=lldg89wi39Bj+1bLSBgFmZ/LMKpUg4JfI9V7NY7PTK2IUJmSqJzdYx2TsRKI73RVSUYJxpbl1F2zQ7LOijKsZt46YUIUnsl9vFI+/ZJHaFw4Pf0sy3pv8yjmMmum/pfIe9Vpfwn+BWzpsQ1cLrECCEEZtzpoVvomolC67+7oQVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765565008; c=relaxed/simple;
	bh=klikMh7SsRMehniAETpjNmjpMxfugGEv6pO2iBUsuFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjhPJmqNHPm0IV0ZNyaOKdWBZ3xN0Rbchm5qex5nTBmToc36i3+kXpL9W4z5ngdcjO32F34pVdyWXnNRtvcTHI4CluSvc6X0XX3kNhCVSWrLuZ4kavRTqWr+5T7FmkkPPJyzFq7/gRzmxfMtgMnJ6PydkcQ4Um6Mrjdx0Fzwrck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihuRZLqT; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-297e264528aso16729125ad.2
        for <linux-pm@vger.kernel.org>; Fri, 12 Dec 2025 10:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765565005; x=1766169805; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3V1Tntzsv6/ontXJ2NamjGQc7g3JceFHAeQO4cFMwqk=;
        b=ihuRZLqT4NxlbfMGbKLsN0MplhOn5RjjctkNE0NtGtgP/bKA9Yz0hnpQ5fqfONNhOI
         NxvKpgRkTszXRmhsiS5imPYXUoBz4IRk2dBFA373jdBRTwj1Ut6IwK59eCjdAL/6O3wM
         wDiyiQOouSN54RgXOiboEPuYQM5QZkFnuUvo5D4ouTG5KsnvIzTKe6WKLq5Ye14CG4mn
         7vuQsLf1F9nICJpXn9jdvBKbhZudJdLmHQ8Q2Eog4YexiJ60RO2XzYq386X2r4Hh+0nE
         97Z/vo1Pi5sxnSzrT5/cQCQUYjo+5Cbg2aHpdm95ofDpKLnONAJT3T3UWh8jdCSom94l
         6zpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765565005; x=1766169805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3V1Tntzsv6/ontXJ2NamjGQc7g3JceFHAeQO4cFMwqk=;
        b=BUSi09loz/2RLIMSkJ86Wk92YAfylHhp9bqOyayJqjNHHHAKHZNQTYM5I70GMBhN0L
         CtEDRgTqz7X92wG564ly7ZkGjgNx/W3i65TcgzvaFZzHt5E8zbl4qjbDeW10ciDHjPrJ
         3fY+GSujfUr5dbhEotxk7v4y3Rrrq9NU4CYsmePlGKywEpSJYm9iMDIAXj7+/MvIuy/o
         G5q6Zd8TneLG8MtPTzcQ5bCk+vnsce8gDSn3BqZjBy1ijTEUOoA0DTQ7uoeclS2uQ42e
         o5M4hFG/hGtJ+xKS6kHHjRtdbUcBDCA503obyXxWcCHeDyV/gxmAIm6R5JzSV87ed52G
         lI2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHO2NMr3nrTcY1TMrIuz2Xm3w7A2OESs2xermym96lOJ/IBNgyzH3dLegQklCxv+aDoeX6taJAGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzZa7JUZW2uyVumzRUnELIvAUgOPiNZrx15APZ68SlyjLgdGCJ
	rxOgv56zDazIjkWEAFJRSJuGDubgJq60A9PPCEaWh0MR8Ig5j13/nOLE
X-Gm-Gg: AY/fxX5fxZCtn+adv9CFKu1AXaV1DsN8vQqQjjEWJIddcH+1eFMHq4hvkOdPZ16oSyJ
	F4Y/ApvQC5cCdEg3wGoB53mm5ez7s4TI2zXvRjNhPysjqgZmJHIy0K//Yc8zdDGb2QXfSEZ3oaC
	SJy70Q3j3MdIUEoUFgpTwsEyJzr4iouau5srAU6E74/BuhMq7q07jQESqlXhh5YvMPw2ggIbCnN
	YzwpbZXAIvUecsd6iz1rF/aoPsfc8HzsVtPNhtifH6/1YqzjXSllisuA79HWyuXLULjo8xtpa8X
	XLLKRAA5M+bgXNQnkoQiQ//mpCCNey42OBCKKvsr2JCB1uuQ6V5KK9GgnsYZEHhuHnh4qKX8SpR
	dVixsVxvd6XOlUWpmyzQobmUzV0N4f3LCtoamWxRj11hLl8sM0DiDIBgTSEIGDhCVPlBsvwt3qQ
	S7GLaggVyRWfXwueZKqnFwAAOYMCjbB5O26Q==
X-Google-Smtp-Source: AGHT+IEpDcZzX346VirWot2FLU3yLGtf7DjJEHDYFbSoNjUTnm8K3md74oCC6+8Q71/RJNBdRa+O9w==
X-Received: by 2002:a05:7022:ea49:b0:119:e56b:98b0 with SMTP id a92af1059eb24-11f34c02b7dmr1649588c88.23.1765565004774;
        Fri, 12 Dec 2025 10:43:24 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e2b4867sm19892432c88.6.2025.12.12.10.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 10:43:24 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 12 Dec 2025 10:43:23 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Ramiro Oliveira <ramiro.oliveira@advantech.com>
Cc: Lee Jones <lee@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org,
	Wenkai Chung <wenkai.chung@advantech.com.tw>,
	Francisco Aragon-Trivino <francisco.aragon-trivino@advantech.com>,
	Hongzhi Wang <hongzhi.wang@advantech.com>,
	Mikhail Tsukerman <mikhail.tsukerman@advantech.com>,
	Thomas Kastner <thomas.kastner@advantech.com>
Subject: Re: [PATCH 6/8] Add Advantech EIO Watchdog driver
Message-ID: <d3f38cb0-3953-4bf3-8fb0-8c52afd39256@roeck-us.net>
References: <20251212-upstream-v1-v1-0-d50d40ec8d8a@advantech.com>
 <20251212-upstream-v1-v1-6-d50d40ec8d8a@advantech.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212-upstream-v1-v1-6-d50d40ec8d8a@advantech.com>

On Fri, Dec 12, 2025 at 05:40:57PM +0100, Ramiro Oliveira wrote:
> This commit adds the driver to control the Advantech EIO Watchdog block,
> this block is included in the Advantech EIO Embedded Controller.
> 
> Signed-off-by: Ramiro Oliveira <ramiro.oliveira@advantech.com>
> ---
>  MAINTAINERS                |   1 +
>  drivers/watchdog/Kconfig   |   7 +
>  drivers/watchdog/Makefile  |   1 +
>  drivers/watchdog/eio_wdt.c | 672 +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 681 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index df4b4cc31257..dfdf4f39c14b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -624,6 +624,7 @@ F:	drivers/hwmon/eio-hwmon.c
>  F:	drivers/i2c/busses/i2c-eio.c
>  F:	drivers/mfd/eio_core.c
>  F:	drivers/video/backlight/eio_bl.c
> +F:	drivers/watchdog/eio_wdt.c
>  F:	include/linux/mfd/eio.h
>  
>  ADXL313 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index d3b9df7d466b..2f8508e51634 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -248,6 +248,13 @@ config DA9062_WATCHDOG
>  
>  	  This driver can be built as a module. The module name is da9062_wdt.
>  
> +config EIO_WATCHDOG
> +	tristate "Advantech EIO Watchdog"
> +	depends on MFD_EIO
> +	help
> +	  Watchdog timer driver for the Advantech EIO.
> +	  If unsure, say N.
> +
>  config GPIO_WATCHDOG
>  	tristate "Watchdog device controlled through GPIO-line"
>  	depends on OF_GPIO
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index ba52099b1253..59b5ec0246d6 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -230,6 +230,7 @@ obj-$(CONFIG_DA9052_WATCHDOG) += da9052_wdt.o
>  obj-$(CONFIG_DA9055_WATCHDOG) += da9055_wdt.o
>  obj-$(CONFIG_DA9062_WATCHDOG) += da9062_wdt.o
>  obj-$(CONFIG_DA9063_WATCHDOG) += da9063_wdt.o
> +obj-$(CONFIG_EIO_WATCHDOG) += eio_wdt.o
>  obj-$(CONFIG_GPIO_WATCHDOG)	+= gpio_wdt.o
>  obj-$(CONFIG_WDAT_WDT) += wdat_wdt.o
>  obj-$(CONFIG_WM831X_WATCHDOG) += wm831x_wdt.o
> diff --git a/drivers/watchdog/eio_wdt.c b/drivers/watchdog/eio_wdt.c
> new file mode 100644
> index 000000000000..a81f005d82d2
> --- /dev/null
> +++ b/drivers/watchdog/eio_wdt.c
> @@ -0,0 +1,672 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Advantech EIO Watchdog Driver
> + *
> + * Copyright (C) 2025 Advantech Co., Ltd.
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/jiffies.h>
> +#include <linux/mfd/core.h>
> +#include <linux/module.h>
> +#include <linux/reboot.h>
> +#include <linux/uaccess.h>
> +#include <linux/watchdog.h>
> +#include <linux/mfd/eio.h>
> +
> +#define WATCHDOG_TIMEOUT	60
> +#define WATCHDOG_PRETIMEOUT	10
> +
> +/* Support Flags */
> +#define SUPPORT_AVAILABLE	BIT(0)
> +#define SUPPORT_PWRBTN		BIT(3)
> +#define SUPPORT_IRQ		BIT(4)
> +#define SUPPORT_SCI		BIT(5)
> +#define SUPPORT_PIN		BIT(6)
> +#define SUPPORT_RESET		BIT(7)
> +
> +/* PMC registers */
> +#define REG_STATUS		0x00
> +#define REG_CONTROL		0x02
> +#define REG_EVENT		0x10
> +#define REG_PWR_EVENT_TIME	0x12
> +#define REG_IRQ_EVENT_TIME	0x13
> +#define REG_RESET_EVENT_TIME	0x14
> +#define REG_PIN_EVENT_TIME	0x15
> +#define REG_SCI_EVENT_TIME	0x16
> +#define REG_IRQ_NUMBER		0x17
> +
> +/* PMC command and control */
> +#define CMD_WDT_WRITE		0x2A
> +#define CMD_WDT_READ		0x2B
> +#define CTRL_STOP		0x00
> +#define CTRL_START		0x01
> +#define CTRL_TRIGGER		0x02
> +
> +/* I/O register and its flags */
> +#define IOREG_UNLOCK		0x87
> +#define IOREG_LOCK		0xAA
> +#define IOREG_LDN		0x07
> +#define IOREG_LDN_PMCIO		0x0F
> +#define IOREG_IRQ		0x70
> +#define IOREG_WDT_STATUS	0x30
> +
> +/* Flags */
> +#define FLAG_WDT_ENABLED	0x01
> +#define FLAG_TRIGGER_IRQ	BIT(4)
> +
> +/* Mapping event type to supported bit */
> +#define EVENT_BIT(type)	BIT(type + 2)
> +
> +enum event_type {
> +	EVENT_NONE,
> +	EVENT_PWRBTN,
> +	EVENT_IRQ,
> +	EVENT_SCI,
> +	EVENT_PIN
> +};
> +
> +struct eio_wdt_dev {
> +	u32 event_type;
> +	u32 support;
> +	int irq;
> +	unsigned long last_time;
> +	struct regmap *iomap;
> +	struct device *mfd;
> +	struct device *dev;
> +	struct watchdog_device wdd;
> +	struct eio_dev *core;
> +};
> +
> +static char * const type_strs[] = {
> +	"NONE",
> +	"PWRBTN",
> +	"IRQ",
> +	"SCI",
> +	"PIN",
> +};
> +
> +static u32 type_regs[] = {
> +	REG_RESET_EVENT_TIME,
> +	REG_PWR_EVENT_TIME,
> +	REG_IRQ_EVENT_TIME,
> +	REG_SCI_EVENT_TIME,
> +	REG_PIN_EVENT_TIME,
> +};
> +
> +/* Specify the pin triggered on pretimeout or timeout */
> +static char *event_type = "NONE";
> +module_param(event_type, charp, 0);
> +MODULE_PARM_DESC(event_type, "Watchdog timeout event type (NONE, PWRBTN, IRQ, SCI, PIN)");
> +
> +/* Specify the IRQ number when the IRQ event is triggered */
> +static int irq;
> +module_param(irq, int, 0);
> +MODULE_PARM_DESC(irq, "The IRQ number for IRQ event");
> +
> +static int timeout;
> +module_param(timeout, int, 0444);
> +MODULE_PARM_DESC(timeout, "Set PMC command timeout value.\n");
> +

Those module parameters are unusual and (for timeout) even misleading.
The "timeout" module parameter in a watchdog driver, if it exists,
is usually the watchdog timeout. This is likely to be confused.
On top of that, expecting the user to know the PMC timeout or an irq
number is just not reasonable, much less giving the user an opportunity
to write such values into the chip.

> +static int pmc_write(struct device *dev, u8 ctrl, void *data)
> +{
> +	struct pmc_op op = {
> +		.cmd       = CMD_WDT_WRITE,
> +		.control   = ctrl,
> +		.payload   = data,
> +		.size     = (ctrl <= REG_EVENT) ? 1 :
> +			    (ctrl >= REG_IRQ_NUMBER) ? 1 : 4,
> +		.timeout   = timeout,
> +	};
> +	return eio_core_pmc_operation(dev, &op);
> +}
> +
> +static int pmc_read(struct device *dev, u8 ctrl, void *data)
> +{
> +	struct pmc_op op = {
> +		.cmd       = CMD_WDT_READ,
> +		.control   = ctrl,
> +		.payload   = data,
> +		.size     = (ctrl <= REG_EVENT) ? 1 :
> +			    (ctrl >= REG_IRQ_NUMBER) ? 1 : 4,
> +		.timeout   = timeout,
> +	};
> +	return eio_core_pmc_operation(dev, &op);
> +}

Those functions are almost the same. Only CMD_WDT_READ/CMD_WDT_WRITE
is different. Please fold into a single function.

> +
> +static int wdt_set_timeout(struct watchdog_device *wdd, unsigned int timeout)
> +{
> +	struct eio_wdt_dev *eio_wdt = watchdog_get_drvdata(wdd);
> +
> +	wdd->timeout = timeout;
> +	dev_info(eio_wdt->dev, "Set timeout: %u\n", timeout);
> +
> +	return 0;
> +}
> +
> +static int wdt_set_pretimeout(struct watchdog_device *wdd, unsigned int pretimeout)
> +{
> +	struct eio_wdt_dev *eio_wdt = watchdog_get_drvdata(wdd);
> +
> +	wdd->pretimeout = pretimeout;
> +	dev_info(eio_wdt->dev, "Set pretimeout: %u\n", pretimeout);
> +
> +	return 0;
> +}

The above two functions to nothing that isn't already done by the watchdog
core, except to add logging noise. That is not acceptable.

> +
> +static int wdt_get_type(struct eio_wdt_dev *eio_wdt)
> +{
> +	int i;
> +
> +	for (i = 1; i < ARRAY_SIZE(type_strs); i++) {
> +		if (strcasecmp(event_type, type_strs[i]) == 0) {
> +			if ((eio_wdt->support & EVENT_BIT(i)) == 0) {
> +				dev_err(eio_wdt->dev,
> +					"This board doesn't support %s trigger type\n",
> +					event_type);
> +				return -EINVAL;
> +			}
> +
> +			dev_info(eio_wdt->dev, "Trigger type is %d:%s\n",
> +				 i, type_strs[i]);
> +			eio_wdt->event_type = i;
> +			return 0;
> +		}
> +	}
> +
> +	dev_info(eio_wdt->dev, "Event type: %s\n",
> +		 type_strs[eio_wdt->event_type]);

Drop all that logging noise.

> +	return 0;
> +}
> +
> +static int get_time(struct eio_wdt_dev *eio_wdt, u8 ctrl, u32 *val)
> +{
> +	int ret;
> +
> +	ret = pmc_read(eio_wdt->mfd, ctrl, val);
> +	if (ret)
> +		return ret;
> +
> +	/* ms to sec */
> +	*val /= 1000;
> +
> +	return 0;
> +}
> +
> +static int set_time(struct eio_wdt_dev *eio_wdt, u8 ctrl, u32 time)
> +{
> +	/* sec to ms */
> +	time *= 1000;
> +
> +	return pmc_write(eio_wdt->mfd, ctrl, &time);
> +}
> +
> +static int wdt_set_config(struct eio_wdt_dev *eio_wdt)
> +{
> +	int ret, type;
> +	u32 event_time = 0;
> +	u32 reset_time = 0;
> +
> +	if (eio_wdt->event_type > EVENT_PIN)
> +		return -EFAULT;
> +
> +	/* Calculate event time and reset time */
> +	if (eio_wdt->wdd.pretimeout && eio_wdt->wdd.timeout) {
> +		if (eio_wdt->wdd.timeout < eio_wdt->wdd.pretimeout)
> +			return -EINVAL;
> +
> +		reset_time = eio_wdt->wdd.timeout;
> +		event_time = eio_wdt->wdd.timeout - eio_wdt->wdd.pretimeout;
> +
> +	} else if (eio_wdt->wdd.timeout) {
> +		reset_time = eio_wdt->event_type ?	0 : eio_wdt->wdd.timeout;
> +		event_time = eio_wdt->event_type ? eio_wdt->wdd.timeout : 0;
> +	}
> +
> +	/* Set reset time */
> +	ret = set_time(eio_wdt, REG_RESET_EVENT_TIME, reset_time);
> +	if (ret)
> +		return ret;
> +
> +	/* Set every other times */
> +	for (type = 1; type < ARRAY_SIZE(type_regs); type++) {
> +		ret = set_time(eio_wdt, type_regs[type],
> +			       (eio_wdt->event_type == type) ? event_time : 0);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	dev_dbg(eio_wdt->dev, "Config wdt reset time %u\n", reset_time);
> +	dev_dbg(eio_wdt->dev, "Config wdt event time %u\n", event_time);
> +	dev_dbg(eio_wdt->dev, "Config wdt event type %s\n",
> +		type_strs[eio_wdt->event_type]);
> +
> +	return 0;
> +}
> +
> +static int wdt_get_config(struct eio_wdt_dev *eio_wdt)
> +{
> +	int ret, type;
> +	u32 event_time = 0, reset_time = 0;
> +
> +	/* Get Reset Time */
> +	ret = get_time(eio_wdt, REG_RESET_EVENT_TIME, &reset_time);
> +	if (ret)
> +		return ret;
> +
> +	dev_dbg(eio_wdt->dev, "Timeout H/W default timeout: %u secs\n", reset_time);
> +
> +	/* Get every other times */
> +	for (type = 1; type < ARRAY_SIZE(type_regs); type++) {
> +		if ((eio_wdt->support & EVENT_BIT(type)) == 0)
> +			continue;
> +
> +		ret = get_time(eio_wdt, type_regs[type], &event_time);
> +		if (ret)
> +			return ret;
> +
> +		if (event_time == 0)
> +			continue;
> +
> +		if (reset_time) {
> +			if (reset_time < event_time)
> +				continue;
> +
> +			eio_wdt->wdd.timeout    = reset_time;
> +			eio_wdt->wdd.pretimeout = reset_time - event_time;
> +
> +			dev_dbg(eio_wdt->dev,
> +				"Pretimeout H/W enabled with event %s of %u secs\n",
> +				type_strs[type], eio_wdt->wdd.pretimeout);
> +		} else {
> +			eio_wdt->wdd.timeout    = event_time;
> +			eio_wdt->wdd.pretimeout = 0;
> +		}
> +
> +		eio_wdt->event_type = type;
> +
> +		dev_dbg(eio_wdt->dev, "Timeout H/W enabled of %u secs\n",
> +			eio_wdt->wdd.timeout);
> +		return 0;
> +	}
> +
> +	eio_wdt->event_type         = EVENT_NONE;
> +	eio_wdt->wdd.pretimeout     = reset_time ? 0 : WATCHDOG_PRETIMEOUT;
> +	eio_wdt->wdd.timeout        = reset_time ? reset_time : WATCHDOG_TIMEOUT;
> +
> +	dev_dbg(eio_wdt->dev, "Pretimeout H/W disabled\n");

Is it ? Then why set it to a value != 0 above ?

> +	return 0;
> +}
> +
> +static int set_ctrl(struct eio_wdt_dev *eio_wdt, u8 ctrl)
> +{
> +	return pmc_write(eio_wdt->mfd, REG_CONTROL, &ctrl);
> +}
> +
> +static int wdt_start(struct watchdog_device *wdd)
> +{
> +	struct eio_wdt_dev *eio_wdt = watchdog_get_drvdata(wdd);
> +	int ret;
> +
> +	ret = wdt_set_config(eio_wdt);
> +	if (ret)
> +		return ret;
> +
> +	ret = set_ctrl(eio_wdt, CTRL_START);
> +	if (!ret) {
> +		eio_wdt->last_time = jiffies;
> +		dev_dbg(eio_wdt->dev, "Watchdog started\n");
> +	}
> +
> +	return ret;
> +}
> +
> +static int wdt_stop(struct watchdog_device *wdd)
> +{
> +	struct eio_wdt_dev *eio_wdt = watchdog_get_drvdata(wdd);
> +	int ret;
> +
> +	dev_dbg(eio_wdt->dev, "Watchdog stopped\n");
> +	eio_wdt->last_time = 0;
> +
> +	ret = set_ctrl(eio_wdt, CTRL_STOP);
> +	return ret;
> +}
> +
> +static int wdt_ping(struct watchdog_device *wdd)
> +{
> +	struct eio_wdt_dev *eio_wdt = watchdog_get_drvdata(wdd);
> +	int ret;
> +
> +	dev_dbg(eio_wdt->dev, "Watchdog ping\n");
> +
> +	ret = set_ctrl(eio_wdt, CTRL_TRIGGER);
> +	if (!ret)
> +		eio_wdt->last_time = jiffies;
> +
> +	return ret;
> +}
> +
> +static unsigned int wdt_get_timeleft(struct watchdog_device *wdd)
> +{
> +	struct eio_wdt_dev *eio_wdt = watchdog_get_drvdata(wdd);
> +	unsigned int timeleft = 0;
> +
> +	if (eio_wdt->last_time && wdd->timeout) {
> +		unsigned long delta   = jiffies - eio_wdt->last_time;
> +		unsigned int  elapsed = (unsigned int)(delta / HZ);
> +
> +		if (elapsed < wdd->timeout)
> +			timeleft = wdd->timeout - elapsed;
> +	}
> +	return timeleft;

No, that is not what the timeleft function is supposed to do. It is supposed
to read the remaining time from the chip. If the chip does not support reading
the remaining time, do not simulate it in software.

> +}
> +
> +static int wdt_support(struct eio_wdt_dev *eio_wdt)
> +{
> +	u8 support;
> +
> +	if (pmc_read(eio_wdt->mfd, REG_STATUS, &support))
> +		return -EIO;
> +
> +	if (!(support & SUPPORT_AVAILABLE))
> +		return -ENODEV;
> +
> +	if ((support & SUPPORT_RESET) != SUPPORT_RESET)
> +		return -ENODEV;
> +
> +	eio_wdt->support = support;
> +
> +	return 0;
> +}
> +
> +static int wdt_get_irq_io(struct eio_wdt_dev *eio_wdt)
> +{
> +	int ret  = 0;
> +	int idx  = EIO_PNP_INDEX;
> +	int data = EIO_PNP_DATA;
> +	struct regmap *map = eio_wdt->iomap;
> +
> +	mutex_lock(&eio_wdt->core->mutex);
> +
> +	/* Unlock EC IO port */
> +	ret |= regmap_write(map, idx, IOREG_UNLOCK);
> +	ret |= regmap_write(map, idx, IOREG_UNLOCK);
> +
> +	/* Select logical device to PMC */
> +	ret |= regmap_write(map, idx,  IOREG_LDN);
> +	ret |= regmap_write(map, data, IOREG_LDN_PMCIO);
> +
> +	/* Get IRQ number */
> +	ret |= regmap_write(map, idx,  IOREG_IRQ);
> +	ret |= regmap_read(map, data, &eio_wdt->irq);
> +
> +	/* Lock back */
> +	ret |= regmap_write(map, idx, IOREG_LOCK);
> +
> +	mutex_unlock(&eio_wdt->core->mutex);
> +
> +	return ret ? -EIO : 0;
> +}
> +
> +static int wdt_get_irq_pmc(struct eio_wdt_dev *eio_wdt)
> +{
> +	return pmc_read(eio_wdt->mfd, REG_IRQ_NUMBER, &eio_wdt->irq);
> +}
> +
> +static int wdt_get_irq(struct eio_wdt_dev *eio_wdt)
> +{
> +	int ret;
> +
> +	if (!(eio_wdt->support & BIT(EVENT_IRQ)))
> +		return -ENODEV;
> +
> +	ret = wdt_get_irq_pmc(eio_wdt);
> +	if (ret) {
> +		dev_err(eio_wdt->dev, "Error get irq by pmc\n");
> +		return ret;
> +	}
> +
> +	if (eio_wdt->irq)
> +		return 0;
> +
> +	/* Fallback: get IRQ number from EC IO space */
> +	ret = wdt_get_irq_io(eio_wdt);
> +	if (ret) {
> +		dev_err(eio_wdt->dev, "Error get irq by io\n");
> +		return ret;
> +	}
> +
> +	if (!eio_wdt->irq) {
> +		dev_err(eio_wdt->dev, "Error IRQ number = 0\n");
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static int wdt_set_irq_io(struct eio_wdt_dev *eio_wdt)
> +{
> +	int ret  = 0;
> +	int idx  = EIO_PNP_INDEX;
> +	int data = EIO_PNP_DATA;
> +	struct regmap *map = eio_wdt->iomap;
> +
> +	mutex_lock(&eio_wdt->core->mutex);
> +
> +	/* Unlock EC IO port */
> +	ret |= regmap_write(map, idx, IOREG_UNLOCK);
> +	ret |= regmap_write(map, idx, IOREG_UNLOCK);
> +
> +	/* Select logical device to PMC */
> +	ret |= regmap_write(map, idx,  IOREG_LDN);
> +	ret |= regmap_write(map, data, IOREG_LDN_PMCIO);
> +
> +	/* Enable WDT */
> +	ret |= regmap_write(map, idx,  IOREG_WDT_STATUS);
> +	ret |= regmap_write(map, data, FLAG_WDT_ENABLED);
> +
> +	/* Set IRQ number */
> +	ret |= regmap_write(map, idx,  IOREG_IRQ);
> +	ret |= regmap_write(map, data, eio_wdt->irq);
> +
> +	/* Lock back */
> +	ret |= regmap_write(map, idx, IOREG_LOCK);

While it may be convenient, it is unacceptable to bundle return codes
this way. The behavior of this code is completely undefined if any
of the accesses above fails.

> +
> +	mutex_unlock(&eio_wdt->core->mutex);
> +
> +	return ret ? -EIO : 0;
> +}
> +
> +static int wdt_set_irq_pmc(struct eio_wdt_dev *eio_wdt)
> +{
> +	return pmc_write(eio_wdt->mfd, REG_IRQ_NUMBER, &eio_wdt->irq);
> +}
> +
> +static int wdt_set_irq(struct eio_wdt_dev *eio_wdt)
> +{
> +	int ret;
> +
> +	if (!(eio_wdt->support & BIT(EVENT_IRQ)))
> +		return -ENODEV;
> +
> +	ret = wdt_set_irq_io(eio_wdt);
> +	if (ret) {
> +		dev_err(eio_wdt->dev, "Error set irq by io\n");
> +		return ret;
> +	}
> +
> +	ret = wdt_set_irq_pmc(eio_wdt);
> +	if (ret) {
> +		dev_err(eio_wdt->dev, "Error set irq by pmc\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int wdt_get_irq_event(struct eio_wdt_dev *eio_wdt)
> +{
> +	u8 status;
> +
> +	if (pmc_read(eio_wdt->mfd, REG_EVENT, &status))
> +		return 0;
> +
> +	return status;
> +}
> +
> +static irqreturn_t wdt_isr(int irq, void *arg)
> +{
> +	return IRQ_WAKE_THREAD;
> +}
> +
> +static irqreturn_t wdt_threaded_isr(int irq, void *arg)
> +{
> +	struct eio_wdt_dev *eio_wdt = arg;
> +	u8 status = wdt_get_irq_event(eio_wdt) & FLAG_TRIGGER_IRQ;
> +
> +	if (!status)
> +		return IRQ_NONE;
> +
> +	if (eio_wdt->wdd.pretimeout) {
> +		watchdog_notify_pretimeout(&eio_wdt->wdd);
> +	} else {
> +		dev_crit(eio_wdt->dev, "Watchdog expired, rebooting\n");
> +		emergency_restart();
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int query_irq(struct eio_wdt_dev *eio_wdt)
> +{
> +	int ret = 0;
> +
> +	if (irq) {
> +		eio_wdt->irq = irq;
> +	} else {
> +		ret = wdt_get_irq(eio_wdt);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	dev_dbg(eio_wdt->dev, "IRQ = %d\n", eio_wdt->irq);
> +
> +	return wdt_set_irq(eio_wdt);
> +}
> +
> +static int wdt_init(struct eio_wdt_dev *eio_wdt)
> +{
> +	int ret;
> +
> +	ret = wdt_support(eio_wdt);
> +	if (ret)
> +		return ret;
> +
> +	ret = wdt_get_config(eio_wdt);
> +	if (ret)
> +		return ret;
> +
> +	ret = wdt_get_type(eio_wdt);
> +	if (ret)
> +		return ret;
> +
> +	if (eio_wdt->event_type == EVENT_IRQ)
> +		ret = query_irq(eio_wdt);
> +
> +	return ret;
> +}
> +
> +static const struct watchdog_ops wdt_ops = {
> +	.owner		= THIS_MODULE,
> +	.start		= wdt_start,
> +	.stop		= wdt_stop,
> +	.ping		= wdt_ping,
> +	.set_timeout	= wdt_set_timeout,
> +	.get_timeleft	= wdt_get_timeleft,
> +	.set_pretimeout = wdt_set_pretimeout,
> +};
> +
> +static struct watchdog_info wdinfo = {
> +	.identity = KBUILD_MODNAME,
> +	.options  = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
> +		    WDIOF_PRETIMEOUT | WDIOF_MAGICCLOSE,
> +};
> +
> +static int eio_wdt_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct eio_wdt_dev *eio_wdt;
> +	struct watchdog_device *wdd;
> +	int ret = 0;
> +
> +	eio_wdt = devm_kzalloc(dev, sizeof(*eio_wdt), GFP_KERNEL);
> +	if (!eio_wdt)
> +		return -ENOMEM;
> +
> +	eio_wdt->dev = dev;
> +	eio_wdt->mfd = dev->parent;
> +	eio_wdt->iomap = dev_get_regmap(dev->parent, NULL);
> +	if (!eio_wdt->iomap)
> +		return dev_err_probe(dev, -ENODEV, "parent regmap missing\n");
> +
> +	eio_wdt->core = dev_get_drvdata(dev->parent);
> +	if (!eio_wdt->core)
> +		return dev_err_probe(dev, -ENODEV, "eio_core not present\n");
> +
> +	ret = wdt_init(eio_wdt);
> +	if (ret) {
> +		dev_err(dev, "wdt_init fail\n");
> +		return -EIO;
> +	}
> +
> +	if (eio_wdt->event_type == EVENT_IRQ) {
> +		ret = devm_request_threaded_irq(dev, eio_wdt->irq,

This would end up requesting an irq provided through the module parameter.
This is completely unacceptable.

> +						wdt_isr, wdt_threaded_isr,
> +						IRQF_SHARED | IRQF_ONESHOT, pdev->name,
> +						eio_wdt);
> +		if (ret) {
> +			dev_err(dev, "IRQ %d request fail:%d. Disabled.\n",
> +				eio_wdt->irq, ret);

You might want to consider using dev_err_probe().

> +			return ret;
> +		}
> +	}
> +
> +	wdd = &eio_wdt->wdd;
> +	wdd->info        = &wdinfo;
> +	wdd->ops         = &wdt_ops;
> +	wdd->parent      = dev;
> +	wdd->min_timeout = 1;
> +	wdd->max_timeout = 0x7FFF;
> +
> +	ret = watchdog_init_timeout(wdd, wdd->timeout, dev);

This is pretty pointless. The function is normally used to overwrite
the default timeout (which is already in wdd->timeout) with a module
parameter or a timeout from devicetree. Calling it with the already
configured timeout does not add any value. Either call it with "0"
as timeout parameter to let it read any timeout from devicetree if
provided, or drop the call.

> +	if (ret) {
> +		dev_err(dev, "Init timeout fail\n");
> +		return ret;
> +	}
> +
> +	watchdog_stop_on_reboot(&eio_wdt->wdd);
> +	watchdog_stop_on_unregister(&eio_wdt->wdd);
> +
> +	watchdog_set_drvdata(&eio_wdt->wdd, eio_wdt);
> +	platform_set_drvdata(pdev, eio_wdt);
> +
> +	ret = devm_watchdog_register_device(dev, &eio_wdt->wdd);
> +	if (ret)
> +		dev_err(dev, "Cannot register watchdog device (err: %d)\n", ret);
> +
> +	return ret;
> +}
> +
> +static struct platform_driver eio_wdt_driver = {
> +	.probe  = eio_wdt_probe,
> +	.driver = {
> +		.name = "eio_wdt",
> +	},
> +};
> +module_platform_driver(eio_wdt_driver);
> +
> +MODULE_AUTHOR("Wenkai Chung <wenkai.chung@advantech.com.tw>");
> +MODULE_AUTHOR("Ramiro Oliveira <ramiro.oliveira@advantech.com>");
> +MODULE_DESCRIPTION("Watchdog interface for Advantech EIO embedded controller");
> +MODULE_LICENSE("GPL");
> 
> -- 
> 2.43.0
> 
> 

