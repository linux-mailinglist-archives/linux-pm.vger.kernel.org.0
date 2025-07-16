Return-Path: <linux-pm+bounces-30910-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08E0B07637
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 14:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DBB77BC4A2
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 12:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CE11891AB;
	Wed, 16 Jul 2025 12:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Kr13GJL+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADC5DDAD;
	Wed, 16 Jul 2025 12:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752670297; cv=none; b=SKlWgjlYXwvsbOcT5XI8HqYZqJkwuidKGdF2GQjEHOMVgGUmoCRWXuATSQDwEaWxBHtr6BA7CqCUnGYWc0T1eCovwDy5rAhfoGm+EK3jHbgHRY1+CEwuQ4MrbZMxx7pbIqx/TkaFxgA1QJAJBOVmfkJV8X0hZLttsfHzVqOtRj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752670297; c=relaxed/simple;
	bh=J54eoEWwWNy+ylE6R6oz//6xnGPALJEFSyh5pY2yyfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnxhH9w6RlSBW0ksFXqBMQPxIZgyMNVqc3FcZPvID2oCAGPoHkJwWIYJD4nVHuN4aBVCEUBXkMSpb37le8UkuVwHyELELz6au+uBypH6v7waZMbB1ZKzBNbD35cW0Jt7Q2/vOGpUQTvpLsz9OUYI+Oh6urL3p8jjr+1F2lVivp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Kr13GJL+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C85C4CEF4;
	Wed, 16 Jul 2025 12:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752670296;
	bh=J54eoEWwWNy+ylE6R6oz//6xnGPALJEFSyh5pY2yyfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kr13GJL+eokFFyuUKDnzt0/0vk+dLernPfT1kKSAiOmKkDGx4rFJw7s4CXlbzaTpo
	 6gXMQLkr0bScacKwD45raj2G5MxUmuKGtySEU+SDrI3PrCyzoi+OP17DVfWPVQ5Kun
	 dotUfIgmxZ1BTC3yxwaOPUmz+iBRqFdRxDz2gq3g=
Date: Wed, 16 Jul 2025 14:51:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Sebastian Reichel <sre@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	=?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>,
	Guenter Roeck <groeck@chromium.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH v11 6/7] power: reset: add PSCR NVMEM Driver for
 Recording Power State Change Reasons
Message-ID: <2025071631-henna-synthesis-9961@gregkh>
References: <20250618120255.3141862-7-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618120255.3141862-7-o.rempel@pengutronix.de>

On Wed, Jun 18, 2025 at 02:02:54PM +0200, Oleksij Rempel wrote:
> This driver utilizes the Power State Change Reasons Recording (PSCRR)
> framework to store specific power state change information, such as
> shutdown or reboot reasons, into a designated non-volatile memory
> (NVMEM) cell.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Tested-by: Francesco Valla <francesco@valla.it>
> ---
> changes v6:
> - rename pscr_reason to psc_reason
> changes v5:
> - avoid a build against NVMEM=m
> changes v4:
> - remove devicetree dependencies
> ---
>  drivers/power/reset/Kconfig       |  22 +++
>  drivers/power/reset/Makefile      |   1 +
>  drivers/power/reset/pscrr-nvmem.c | 254 ++++++++++++++++++++++++++++++
>  3 files changed, 277 insertions(+)
>  create mode 100644 drivers/power/reset/pscrr-nvmem.c
> 
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index 69e038e20731..3affef932e4d 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -354,3 +354,25 @@ menuconfig PSCRR
>  	  be recorded unless hardware provides the reset cause.
>  
>  	  If unsure, say N.
> +
> +if PSCRR
> +
> +config PSCRR_NVMEM
> +	tristate "Generic NVMEM-based Power State Change Reason Recorder"
> +	depends on NVMEM || !NVMEM
> +	help
> +	  This option enables support for storing power state change reasons
> +	  (such as shutdown, reboot, or power failure events) into a designated
> +	  NVMEM (Non-Volatile Memory) cell.
> +
> +	  This feature allows embedded systems to retain power transition
> +	  history even after a full system restart or power loss. It is useful
> +	  for post-mortem debugging, automated recovery strategies, and
> +	  improving system reliability.
> +
> +	  The NVMEM cell used for storing these reasons can be dynamically
> +	  configured via module parameters.

Module parameters?  Why?

> +
> +	  If unsure, say N.
> +
> +endif
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index 025da19cb335..cc9008c8bb02 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -34,6 +34,7 @@ obj-$(CONFIG_POWER_RESET_SYSCON) += syscon-reboot.o
>  obj-$(CONFIG_POWER_RESET_SYSCON_POWEROFF) += syscon-poweroff.o
>  obj-$(CONFIG_POWER_RESET_RMOBILE) += rmobile-reset.o
>  obj-$(CONFIG_PSCRR) += pscrr.o
> +obj-$(CONFIG_PSCRR_NVMEM) += pscrr-nvmem.o
>  obj-$(CONFIG_REBOOT_MODE) += reboot-mode.o
>  obj-$(CONFIG_SYSCON_REBOOT_MODE) += syscon-reboot-mode.o
>  obj-$(CONFIG_POWER_RESET_SC27XX) += sc27xx-poweroff.o
> diff --git a/drivers/power/reset/pscrr-nvmem.c b/drivers/power/reset/pscrr-nvmem.c
> new file mode 100644
> index 000000000000..7d02d989893f
> --- /dev/null
> +++ b/drivers/power/reset/pscrr-nvmem.c
> @@ -0,0 +1,254 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * pscrr_nvmem.c - PSCRR backend for storing shutdown reasons in small NVMEM
> + *		   cells
> + *
> + * This backend provides a way to persist power state change reasons in a
> + * non-volatile memory (NVMEM) cell, ensuring that reboot causes can be
> + * analyzed post-mortem. Unlike traditional logging to eMMC or NAND, which
> + * may be unreliable during power failures, this approach allows storing
> + * reboot reasons in small, fast-access storage like RTC scratchpads, EEPROM,
> + * or FRAM.
> + *
> + * The module allows dynamic configuration of the NVMEM device and cell
> + * via module parameters:
> + *
> + * Example usage:
> + *   modprobe pscrr-nvmem nvmem_name=pcf85063_nvram0 cell_name=pscr@0,0

Ugh, no, this isn't the 1990's anymore.  Module parameters don't make
sense for dynamic systems with multiple devices and names and the like.
Please use a proper api for this instead of this static one.

> +/*
> + * Module parameters:
> + *   nvmem_name: Name of the NVMEM device (e.g. "pcf85063_nvram0").
> + *   cell_name : Sysfs name of the cell on that device (e.g. "pscr@0,0").
> + */
> +static char *nvmem_name;
> +module_param(nvmem_name, charp, 0444);
> +MODULE_PARM_DESC(nvmem_name, "Name of the NVMEM device (e.g. pcf85063_nvram0)");
> +
> +static char *cell_name;
> +module_param(cell_name, charp, 0444);
> +MODULE_PARM_DESC(cell_name, "Sysfs name of the NVMEM cell (e.g. pscr@0,0)");

Again, don't.  Please don't.

You now only have one name, and one device.  WHat happens to the next
system that has multiple ones?  And who is enforcing this arbitrary
naming scheme?  Why is that now a user/kernel abi that can never change?

> +	pr_info("PSCRR-nvmem: Loaded (nvmem=%s, cell=%s), can store 0..%zu\n",
> +		nvmem_name, cell_name, priv->max_val);

Again, when code works, it is quiet.

> +static void __exit pscrr_nvmem_exit(void)
> +{
> +	pscrr_core_exit();
> +
> +	if (priv) {
> +		if (priv->cell) {
> +			nvmem_cell_put(priv->cell);
> +			priv->cell = NULL;
> +		}
> +		if (priv->nvmem) {
> +			nvmem_device_put(priv->nvmem);
> +			priv->nvmem = NULL;
> +		}
> +		kfree(priv);
> +		priv = NULL;
> +	}
> +
> +	pr_info("pscrr-nvmem: Unloaded\n");

Again, please be quiet.

And use pr_fmt().

thanks,

greg k-h

