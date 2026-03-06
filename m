Return-Path: <linux-pm+bounces-43779-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APTdBZWnqmlTVAEAu9opvQ
	(envelope-from <linux-pm+bounces-43779-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 11:08:21 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8AB21E723
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 11:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5900309EEB9
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 10:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60FC35AC2F;
	Fri,  6 Mar 2026 10:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WooLYWxE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2091330664;
	Fri,  6 Mar 2026 10:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772791452; cv=none; b=jrgCuqob4ZiOgO5jurulNebpclsB8V+7wMjkiWU3yuOXkIIFGFB+73ReNjuqF3ATC83d3qLeytq4RrNxWiInhB7xEolbgmGs65m8GY9Z5ulQvHKSknY13w0HG3yYCuxM46Sel6zAS+ldjj1jlBNlkTHIwguo4I0lLsqINiZX43c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772791452; c=relaxed/simple;
	bh=A4SNBBfmO/v06t2tNwTdr2XLAgD7pB1RGsKDHeu2qwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NeHSg3cb602Hni7fQqX/2qUgdr/C2BcmjazWmdmacKThX84bfvT+o45WMyoNUv+B/h/tYMnT3dcQ2SFZBsk+E9mhwJT0nsEv40ZJPzQzuNC4LYP/2Q1hLEwjml3QzC8SeZ7sL+rstyUlpqrZERB1LXAlXiah7r0z5tqmHwNsMRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WooLYWxE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10041C4CEF7;
	Fri,  6 Mar 2026 10:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772791452;
	bh=A4SNBBfmO/v06t2tNwTdr2XLAgD7pB1RGsKDHeu2qwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WooLYWxEGe93aXCQFnQRVKEKd+/BBqYugO/IxjTGBiigjyb3rxjpqrM2hQjUWifS9
	 LNYAhG+VLce067lSEaRM4Qri77htSjQLNbIcx7TUYZ4YMXQRNR8aN0L+J6MRFJPbUK
	 IUaaMzjHwrRXF2iiwlyoyfp35bm8ltky23NA99NDNy4DaT8ufmo+eizkasc8zUz0fj
	 kQROpYSr7McDiW5fdDlk960RLxRpGFGwz2SmrgofJgKwbOtRQ34d1pR1omgs5YzxCK
	 k5umGQIEnVzJjPvXEndI4+o+GM+wrQeXaleXpA4KE4G8WBjLuE779X2L1CuwRQJW1K
	 TQbVqE0tSrgng==
Date: Fri, 6 Mar 2026 10:04:06 +0000
From: Lee Jones <lee@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Reichel <sre@kernel.org>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	Ion Agorria <ion@agorria.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 7/9] leds: Add driver for Asus Transformer LEDs
Message-ID: <20260306100406.GE183676@google.com>
References: <20260209104407.116426-1-clamor95@gmail.com>
 <20260209104407.116426-8-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260209104407.116426-8-clamor95@gmail.com>
X-Rspamd-Queue-Id: 8D8AB21E723
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43779-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,arndb.de,linuxfoundation.org,rere.qmqm.pl,agorria.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Mon, 09 Feb 2026, Svyatoslav Ryhel wrote:

> From: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> 
> Asus Transformer tablets have a green and an amber LED on both the Pad
> and the Dock. If both LEDs are enabled simultaneously, the emitted light
> will be yellow.
> 
> Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/leds/Kconfig        |  11 ++++
>  drivers/leds/Makefile       |   1 +
>  drivers/leds/leds-asus-ec.c | 104 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 116 insertions(+)
>  create mode 100644 drivers/leds/leds-asus-ec.c
> 
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index 597d7a79c988..96dab210f6ca 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -120,6 +120,17 @@ config LEDS_OSRAM_AMS_AS3668
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called leds-as3668.
>  
> +config LEDS_ASUSEC
> +	tristate "LED Support for Asus Transformer charging LED"
> +	depends on LEDS_CLASS
> +	depends on MFD_ASUSEC
> +	help
> +	  This option enables support for charging indicator on
> +	  Asus Transformer's Pad and it's Dock.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called leds-asus-ec.
> +
>  config LEDS_AW200XX
>  	tristate "LED support for Awinic AW20036/AW20054/AW20072/AW20108"
>  	depends on LEDS_CLASS
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index 8fdb45d5b439..1117304dfdf4 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_LEDS_AN30259A)		+= leds-an30259a.o
>  obj-$(CONFIG_LEDS_APU)			+= leds-apu.o
>  obj-$(CONFIG_LEDS_ARIEL)		+= leds-ariel.o
>  obj-$(CONFIG_LEDS_AS3668)		+= leds-as3668.o
> +obj-$(CONFIG_LEDS_ASUSEC)		+= leds-asus-ec.o
>  obj-$(CONFIG_LEDS_AW200XX)		+= leds-aw200xx.o
>  obj-$(CONFIG_LEDS_AW2013)		+= leds-aw2013.o
>  obj-$(CONFIG_LEDS_BCM6328)		+= leds-bcm6328.o
> diff --git a/drivers/leds/leds-asus-ec.c b/drivers/leds/leds-asus-ec.c
> new file mode 100644
> index 000000000000..5dd76c9247ee
> --- /dev/null
> +++ b/drivers/leds/leds-asus-ec.c
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ASUS EC driver - battery LED
> + */
> +
> +#include <linux/err.h>
> +#include <linux/leds.h>
> +#include <linux/mfd/asus-ec.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +/*
> + * F[5] & 0x07
> + *  auto: brightness == 0
> + *  bit 0: blink / charger on
> + *  bit 1: amber on
> + *  bit 2: green on
> + */
> +
> +#define ASUSEC_CTL_LED_BLINK		BIT_ULL(40)
> +#define ASUSEC_CTL_LED_AMBER		BIT_ULL(41)
> +#define ASUSEC_CTL_LED_GREEN		BIT_ULL(42)
> +
> +static void asus_ec_led_set_brightness_amber(struct led_classdev *led,
> +					     enum led_brightness brightness)
> +{
> +	const struct asusec_info *ec = dev_get_drvdata(led->dev->parent);
> +
> +	if (brightness)
> +		asus_ec_set_ctl_bits(ec, ASUSEC_CTL_LED_AMBER);
> +	else
> +		asus_ec_clear_ctl_bits(ec, ASUSEC_CTL_LED_AMBER);
> +}
> +
> +static void asus_ec_led_set_brightness_green(struct led_classdev *led,
> +					     enum led_brightness brightness)
> +{
> +	const struct asusec_info *ec = dev_get_drvdata(led->dev->parent);
> +
> +	if (brightness)
> +		asus_ec_set_ctl_bits(ec, ASUSEC_CTL_LED_GREEN);
> +	else
> +		asus_ec_clear_ctl_bits(ec, ASUSEC_CTL_LED_GREEN);
> +}
> +
> +static int asus_ec_led_probe(struct platform_device *pdev)
> +{
> +	struct asusec_info *ec = cell_to_ec(pdev);

Please remove all of your abstraction layers.  They serve little purpose
other than to complicate things.  Just use dev_get_drvdata() here.

Remove the "_info" part and change "ec" to "ddata".

> +	struct device *dev = &pdev->dev;
> +	struct led_classdev *amber_led, *green_led;
> +	int ret;
> +
> +	platform_set_drvdata(pdev, ec);

Wait, what?

Why are you doing that?

> +	amber_led = devm_kzalloc(dev, sizeof(*amber_led), GFP_KERNEL);
> +	if (!amber_led)
> +		return -ENOMEM;
> +
> +	amber_led->name = devm_kasprintf(dev, GFP_KERNEL, "%s::amber", ec->name);
> +	amber_led->max_brightness = 1;
> +	amber_led->flags = LED_CORE_SUSPENDRESUME | LED_RETAIN_AT_SHUTDOWN;
> +	amber_led->brightness_set = asus_ec_led_set_brightness_amber;
> +
> +	ret = devm_led_classdev_register(dev, amber_led);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to register amber LED\n");
> +
> +	green_led = devm_kzalloc(dev, sizeof(*green_led), GFP_KERNEL);
> +	if (!green_led)
> +		return -ENOMEM;
> +
> +	green_led->name = devm_kasprintf(dev, GFP_KERNEL, "%s::green", ec->name);
> +	green_led->max_brightness = 1;
> +	green_led->flags = LED_CORE_SUSPENDRESUME | LED_RETAIN_AT_SHUTDOWN;
> +	green_led->brightness_set = asus_ec_led_set_brightness_green;
> +
> +	ret = devm_led_classdev_register(dev, green_led);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to register green LED\n");

Lots of repetition here.

I'd make a sub-function that takes the differences.

Same with the set brightness functions.

Think to yourself - what if I had to support 16 different LEDs?

> +
> +	return 0;
> +}
> +
> +static const struct of_device_id asus_ec_led_match[] = {
> +	{ .compatible = "asus,ec-led" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, asus_ec_led_match);
> +
> +static struct platform_driver asus_ec_led_driver = {
> +	.driver = {
> +		.name = "asus-ec-led",
> +		.of_match_table = asus_ec_led_match,
> +	},
> +	.probe = asus_ec_led_probe,
> +};
> +module_platform_driver(asus_ec_led_driver);
> +
> +MODULE_AUTHOR("Michał Mirosław <mirq-linux@rere.qmqm.pl>");
> +MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
> +MODULE_DESCRIPTION("ASUS Transformer's charging LED driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.51.0
> 
> 

-- 
Lee Jones [李琼斯]

