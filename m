Return-Path: <linux-pm+bounces-20601-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 602A2A14A74
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 08:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C18F31887287
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 07:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F621F7907;
	Fri, 17 Jan 2025 07:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlB3DkmF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EA11F6687;
	Fri, 17 Jan 2025 07:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737100538; cv=none; b=I/aac18Z/wbEOvZ0jtAdBmmCq/LUx8d1Tmd8aisGC7OppDJL/y+mYOxFiFfS/NznSt3V/QWG+FIupaaJGSEeJKRgGqXpmrRuDXFQSSnhZO7rmp0MqTmpGvfxL8X9eOBgFYx2o3C05z3yeHTqAhOVtHYWF0Ly0YrB017o0joXwXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737100538; c=relaxed/simple;
	bh=YZZciSRnEHvwgnogTa8XgQp/5/86Fo7g7sZoLmmgwS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ni0c4HLjt8jvWKyKCCBG1qwu4I6TQBE/lzq2w26C5fPjqgkfiyaLe0MzXZuKBWAZ8JvNih87n5MYHA5RqkUAQUFfMUOfg3QXUo1M3KCOm0BbRejoRkRNFyiOfL5Wk4hd+JS0uui89XQg3Q6IdzukpXwY/Q8WILaOlzDk0EFXVnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlB3DkmF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D18C4CEDD;
	Fri, 17 Jan 2025 07:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737100537;
	bh=YZZciSRnEHvwgnogTa8XgQp/5/86Fo7g7sZoLmmgwS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SlB3DkmFSVH9hB2crWnxoQKixDJ/IOiratiGsae8f5GYk9D1HqkzMFXac5ZJ3HUh0
	 Ze2RlO7yICYjOqyC+Vg++c52tAugknVh/LbEE4WOyrQvf6D1owIYzl8zf7mXFCiFZ1
	 l/V3hvXO4mvmcOqwkmt2VTGuPrqMc1mn/MHXQ6SrO6ELKz5SjHH3Od4eaZQdrLWyuz
	 DRymW4Fw/fkCY36xEF2yoWy3zsrzL00l9ahWGIwJFuMmMdqQYRaRsOVmF7KBsQgft4
	 bYgwCV8yMF+EDvJW8UlryIJIoOpRGmYy/IR355Mt/fPAfpXw8530l8rK0oqZlTw1Dl
	 DSp4P/zdYngiA==
Date: Fri, 17 Jan 2025 08:55:35 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Pavel Machek <pavel@ucw.cz>, Hans de Goede <hdegoede@redhat.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
	Purism Kernel Team <kernel@puri.sm>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v15 5/7] mfd: Add new driver for MAX77705 PMIC
Message-ID: <20250117-cordial-hopeful-leopard-4b7ad9@krzk-bin>
References: <20250116-starqltechn_integration_upstream-v15-0-cf229de9f758@gmail.com>
 <20250116-starqltechn_integration_upstream-v15-5-cf229de9f758@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250116-starqltechn_integration_upstream-v15-5-cf229de9f758@gmail.com>

On Thu, Jan 16, 2025 at 07:26:07PM +0300, Dzmitry Sankouski wrote:
>  config MFD_MAX77714
>  	tristate "Maxim Semiconductor MAX77714 PMIC Support"
>  	depends on I2C
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index e057d6d6faef..d981690b5a12 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -168,6 +168,7 @@ obj-$(CONFIG_MFD_MAX77620)	+= max77620.o
>  obj-$(CONFIG_MFD_MAX77650)	+= max77650.o
>  obj-$(CONFIG_MFD_MAX77686)	+= max77686.o
>  obj-$(CONFIG_MFD_MAX77693)	+= max77693.o
> +obj-$(CONFIG_MFD_MAX77705)	+= max77705.o
>  obj-$(CONFIG_MFD_MAX77714)	+= max77714.o
>  obj-$(CONFIG_MFD_MAX77843)	+= max77843.o
>  obj-$(CONFIG_MFD_MAX8907)	+= max8907.o
> @@ -233,6 +234,7 @@ obj-$(CONFIG_MFD_RK8XX_I2C)	+= rk8xx-i2c.o
>  obj-$(CONFIG_MFD_RK8XX_SPI)	+= rk8xx-spi.o
>  obj-$(CONFIG_MFD_RN5T618)	+= rn5t618.o
>  obj-$(CONFIG_MFD_SEC_CORE)	+= sec-core.o sec-irq.o
> +obj-$(CONFIG_MFD_S2DOS05)	+= s2dos05.o

Hm? How so? And how does it even work?

>  obj-$(CONFIG_MFD_SYSCON)	+= syscon.o
>  obj-$(CONFIG_MFD_LM3533)	+= lm3533-core.o lm3533-ctrlbank.o
>  obj-$(CONFIG_MFD_VEXPRESS_SYSREG)	+= vexpress-sysreg.o

...

> +
> +static int max77705_suspend(struct device *dev)
> +{
> +	struct i2c_client *i2c = to_i2c_client(dev);
> +
> +	disable_irq(i2c->irq);
> +
> +	if (device_may_wakeup(dev))
> +		enable_irq_wake(i2c->irq);
> +
> +	return 0;
> +}
> +
> +static int max77705_resume(struct device *dev)
> +{
> +	struct i2c_client *i2c = to_i2c_client(dev);
> +
> +	if (device_may_wakeup(dev))
> +		disable_irq_wake(i2c->irq);
> +
> +	enable_irq(i2c->irq);
> +
> +	return 0;
> +}
> +DEFINE_SIMPLE_DEV_PM_OPS(max77705_pm_ops, max77705_suspend, max77705_resume);
> +
> +static const struct of_device_id max77705_i2c_of_match[] = {
> +	{ .compatible = "maxim,max77705" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, max77705_i2c_of_match);
> +
> +static struct i2c_driver max77705_i2c_driver = {
> +	.driver = {
> +		.name			= "max77705",
> +		.of_match_table		= max77705_i2c_of_match,
> +		.pm			= pm_sleep_ptr(&max77705_pm_ops),
> +		.suppress_bind_attrs	= true,

I don't see any reason for that. This is allowed only for core
SoC components and power supply driver is neither part of SoC, nor a
core component.


Best regards,
Krzysztof


