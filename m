Return-Path: <linux-pm+bounces-15071-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A3898DF51
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 17:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13ABB28584A
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 15:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141771D0DF5;
	Wed,  2 Oct 2024 15:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvZ48ukx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FC51D0DD9;
	Wed,  2 Oct 2024 15:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883344; cv=none; b=RYnwtZjO0O+ZFZUIMbf1jmfQUc0dfaONa8+bKtCihN5Wxxcjc8fqJ6dQjcnNOZa4tcwOpRLHZCVdX00/eDwEopBxoR/kQv4RqUi0qSf9j0JQz8TAUhOvK/L4vJJa8qkxaVnrEfplMPFCqIQrlneHsYjsQBDmnYJ5YnNFh71cByo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883344; c=relaxed/simple;
	bh=k1zW8KXz7EwiJvjqcAxwtSjygKZUVJO8HBFqTJuGMF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQ5iwQ/2ABMp30aiiUKMjLqvalzp4G8Jdu+R3KMqHwN0w+qPsrEDsoL/9TLj34Ri7yvKlnUvxezwlsRR6lhdyVula/HAoJgQ25kff4XkrLPXk1KZ5voP4/O8BQSQ2KIo0/h7AhuDRwJAFibA7JOrJLjebK3/il36ize+xN/IiBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvZ48ukx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF281C4CECD;
	Wed,  2 Oct 2024 15:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727883343;
	bh=k1zW8KXz7EwiJvjqcAxwtSjygKZUVJO8HBFqTJuGMF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gvZ48ukxkvlA/tROM+XWQCC+GQjn1xdlFnYHeifEYVq3bNZE7U+/awWbv/IXObCLK
	 Ysc1gbU85mEH1o377fQn2byyXFnnUwqVzaCVMUJDVsA8bKlOmU5vmNabqZmvyRGbGc
	 X/7kX4t1SPLDknV2pBJAyf8aXxdc31pTUtOn2E1xJQ91H6DmdnOUL0nKg75YA48ga8
	 /xwVQ+krKvfrEpXXbqzBZXcjjpO8Rpksw4EdnWB1XquWOMs6zS79szHrzEoSX0ZE31
	 jvaKCO00kXJudpcVy4IoBnDzj6q4gdEc1EpMNZp4UTrHDbHjavRHXl1tGXmhrSbzdl
	 mkgFXnebCgzIw==
Date: Wed, 2 Oct 2024 16:35:36 +0100
From: Lee Jones <lee@kernel.org>
To: Junhao Xie <bigfoot@classfun.cn>
Cc: devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	Sebastian Reichel <sre@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Heiko Stuebner <heiko@sntech.de>, Chukun Pan <amadeus@jmu.edu.cn>
Subject: Re: [PATCH 7/9] leds: add Photonicat PMU LED driver
Message-ID: <20241002153536.GG7504@google.com>
References: <20240906093630.2428329-1-bigfoot@classfun.cn>
 <20240906093630.2428329-8-bigfoot@classfun.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240906093630.2428329-8-bigfoot@classfun.cn>

On Fri, 06 Sep 2024, Junhao Xie wrote:

> Photonicat has a network status LED that can be controlled by system.
> The LED status can be set through command 0x19.
> 
> Signed-off-by: Junhao Xie <bigfoot@classfun.cn>
> ---
>  drivers/leds/Kconfig           | 11 +++++
>  drivers/leds/Makefile          |  1 +
>  drivers/leds/leds-photonicat.c | 75 ++++++++++++++++++++++++++++++++++
>  3 files changed, 87 insertions(+)
>  create mode 100644 drivers/leds/leds-photonicat.c
> 
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index 8d9d8da376e4..539adb5944e6 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -381,6 +381,17 @@ config LEDS_PCA9532_GPIO
>  	  To use a pin as gpio pca9532_type in pca9532_platform data needs to
>  	  set to PCA9532_TYPE_GPIO.
>  
> +config LEDS_PHOTONICAT_PMU
> +	tristate "LED Support for Photonicat PMU"
> +	depends on LEDS_CLASS
> +	depends on MFD_PHOTONICAT_PMU
> +	help
> +	  Photonicat has a network status LED that can be controlled by system,

"the system"

> +	  this option enables support for LEDs connected to the Photonicat PMU.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called leds-photonicat.
> +
>  config LEDS_GPIO
>  	tristate "LED Support for GPIO connected LEDs"
>  	depends on LEDS_CLASS
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index 18afbb5a23ee..dcd5312aee12 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -76,6 +76,7 @@ obj-$(CONFIG_LEDS_PCA9532)		+= leds-pca9532.o
>  obj-$(CONFIG_LEDS_PCA955X)		+= leds-pca955x.o
>  obj-$(CONFIG_LEDS_PCA963X)		+= leds-pca963x.o
>  obj-$(CONFIG_LEDS_PCA995X)		+= leds-pca995x.o
> +obj-$(CONFIG_LEDS_PHOTONICAT_PMU)	+= leds-photonicat.o
>  obj-$(CONFIG_LEDS_PM8058)		+= leds-pm8058.o
>  obj-$(CONFIG_LEDS_POWERNV)		+= leds-powernv.o
>  obj-$(CONFIG_LEDS_PWM)			+= leds-pwm.o
> diff --git a/drivers/leds/leds-photonicat.c b/drivers/leds/leds-photonicat.c
> new file mode 100644
> index 000000000000..3aa5ce525b83
> --- /dev/null
> +++ b/drivers/leds/leds-photonicat.c
> @@ -0,0 +1,75 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2024 Junhao Xie <bigfoot@classfun.cn>
> + */
> +
> +#include <linux/mfd/photonicat-pmu.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/leds.h>

Alphabetical.

> +struct pcat_leds {
> +	struct device *dev;

Where is this used?

> +	struct pcat_pmu *pmu;

Why do you need to store this?

Can't you get this at the call-site by:

  dev_get_drvdata(cdev->dev->parent)

> +	struct led_classdev cdev;
> +};
> +
> +static int pcat_led_status_set(struct led_classdev *cdev,
> +			       enum led_brightness brightness)
> +{
> +	struct pcat_leds *leds = container_of(cdev, struct pcat_leds, cdev);
> +	struct pcat_data_cmd_led_setup setup = { 0, 0, 0 };
> +
> +	if (brightness)
> +		setup.on_time = 100;
> +	else
> +		setup.down_time = 100;
> +	return pcat_pmu_write_data(leds->pmu, PCAT_CMD_NET_STATUS_LED_SETUP,
> +				   &setup, sizeof(setup));
> +}
> +
> +static int pcat_leds_probe(struct platform_device *pdev)
> +{
> +	int ret;

Small sized variables at the bottom please.

> +	struct device *dev = &pdev->dev;
> +	struct pcat_leds *leds;
> +	const char *label;
> +
> +	leds = devm_kzalloc(dev, sizeof(*leds), GFP_KERNEL);
> +	if (!leds)
> +		return -ENOMEM;
> +
> +	leds->dev = dev;

Where is this used?

> +	leds->pmu = dev_get_drvdata(dev->parent);
> +	platform_set_drvdata(pdev, leds);

Where do you platform_get_drvdata()

> +	ret = of_property_read_string(dev->of_node, "label", &label);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "No label property\n");
> +
> +	leds->cdev.name = label;
> +	leds->cdev.max_brightness = 1;
> +	leds->cdev.brightness_set_blocking = pcat_led_status_set;
> +
> +	return devm_led_classdev_register(dev, &leds->cdev);
> +}
> +
> +static const struct of_device_id pcat_leds_dt_ids[] = {
> +	{ .compatible = "ariaboard,photonicat-pmu-leds", },

How many LEDs are there?

> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, pcat_leds_dt_ids);
> +
> +static struct platform_driver pcat_leds_driver = {
> +	.driver = {
> +		.name = "photonicat-leds",
> +		.of_match_table = pcat_leds_dt_ids,
> +	},
> +	.probe = pcat_leds_probe,
> +};
> +module_platform_driver(pcat_leds_driver);
> +
> +MODULE_AUTHOR("Junhao Xie <bigfoot@classfun.cn>");
> +MODULE_DESCRIPTION("Photonicat PMU Status LEDs");
> +MODULE_LICENSE("GPL");
> -- 
> 2.46.0
> 

-- 
0)
Lee Jones [李琼斯]

