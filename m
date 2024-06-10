Return-Path: <linux-pm+bounces-8866-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E97C79021F8
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 14:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D9321C214C6
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 12:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9B581219;
	Mon, 10 Jun 2024 12:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UYiBegjv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A90180C03;
	Mon, 10 Jun 2024 12:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718023834; cv=none; b=M5RQhHKjD6FEDl6cocSYj6MVLdet2aAo6roIZQ/2wl+uWllf+GYRTXOkIshgbLb/Mv3a4dBukZYFMUz15DNjfQyZA5v44okEpY9RWvFBSFTde20fcNPdX1gCw+aUbSzJeUXzqWTcd1527YOJWWxWpaMs0OcfnfhBuupw8QhglbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718023834; c=relaxed/simple;
	bh=kP67tg1aFmDVq6/yIQoghI3NugyJihFVrG0i3XXqxh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PsrIGP6/JmuLzskKQ2tvpdPHNBfeuBCa3NPV/LN0QSjBZQWNb801u8oC/ijUGkQrPrtWkaK5O9q6NHBRGwse2qQaCOT+irHd6A5E5MnQ3aLZ52UEluKy9DrY0R+822mAn//i7W85Ufh0eKwtMkYM6tAGzNVBV5PAatNpKnQ3KjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UYiBegjv; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718023833; x=1749559833;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kP67tg1aFmDVq6/yIQoghI3NugyJihFVrG0i3XXqxh4=;
  b=UYiBegjvyW7sxzC7MNCefUIN+EMzDWR/b3+Pp/AOXZ3mX1k4cMGy74sX
   GuH1M9SJQX6YrNRToWx8ZdHuLqCfrHt2/QmoGacUabL5GzPVrvyJiQ5Yo
   LMu2B1umBYnTCwJ6gpT4XGsIhIQeGDHNZ3kz22we4Vz++HEJmPepUOX2B
   QJalNy+LRvciCLRCttfQ69Dhj5HA1aNWDFWyjzdnh4bdzpwJa9ahOnor2
   ePxsIHpMjJYxMf/Xnc12KEo8ph5K1InOFAfpmeHNf38UNZvLnfwyf/YNs
   3VcTbTE5gN585nWe+zzwby5TnqJvoXKo68UCRWgtISAnV+JcC0f8Tdgzs
   g==;
X-CSE-ConnectionGUID: l+cP/76/S9eF1bdzLZYo3w==
X-CSE-MsgGUID: /7WQSHSURjeA1pcoq2T8Sw==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="25787722"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="25787722"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 05:50:31 -0700
X-CSE-ConnectionGUID: b2bKekFRRPezsp44DOIcqQ==
X-CSE-MsgGUID: MlSzVcRmTiC3eEa7sC8S9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="39126848"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmviesa010.fm.intel.com with SMTP; 10 Jun 2024 05:50:25 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 10 Jun 2024 15:50:24 +0300
Date: Mon, 10 Jun 2024 15:50:24 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>
Subject: Re: [PATCH v5 3/6] usb: typec: ucsi: add Lenovo Yoga C630 glue driver
Message-ID: <Zmb2kD/ZQBaeOqkB@kuha.fi.intel.com>
References: <20240607-yoga-ec-driver-v5-0-1ac91a0b4326@linaro.org>
 <20240607-yoga-ec-driver-v5-3-1ac91a0b4326@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607-yoga-ec-driver-v5-3-1ac91a0b4326@linaro.org>

On Fri, Jun 07, 2024 at 01:32:38PM +0300, Dmitry Baryshkov wrote:
> The Lenovo Yoga C630 WOS laptop provides implements UCSI interface in
> the onboard EC. Add glue driver to interface the platform's UCSI
> implementation.
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/Kconfig          |   9 ++
>  drivers/usb/typec/ucsi/Makefile         |   1 +
>  drivers/usb/typec/ucsi/ucsi_yoga_c630.c | 202 ++++++++++++++++++++++++++++++++
>  3 files changed, 212 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/Kconfig b/drivers/usb/typec/ucsi/Kconfig
> index bdcb1764cfae..680e1b87b152 100644
> --- a/drivers/usb/typec/ucsi/Kconfig
> +++ b/drivers/usb/typec/ucsi/Kconfig
> @@ -69,4 +69,13 @@ config UCSI_PMIC_GLINK
>  	  To compile the driver as a module, choose M here: the module will be
>  	  called ucsi_glink.
>  
> +config UCSI_LENOVO_YOGA_C630
> +	tristate "UCSI Interface Driver for Lenovo Yoga C630"
> +	depends on EC_LENOVO_YOGA_C630
> +	help
> +	  This driver enables UCSI support on the Lenovo Yoga C630 laptop.
> +
> +	  To compile the driver as a module, choose M here: the module will be
> +	  called ucsi_yoga_c630.
> +
>  endif
> diff --git a/drivers/usb/typec/ucsi/Makefile b/drivers/usb/typec/ucsi/Makefile
> index b4679f94696b..aed41d23887b 100644
> --- a/drivers/usb/typec/ucsi/Makefile
> +++ b/drivers/usb/typec/ucsi/Makefile
> @@ -21,3 +21,4 @@ obj-$(CONFIG_UCSI_ACPI)			+= ucsi_acpi.o
>  obj-$(CONFIG_UCSI_CCG)			+= ucsi_ccg.o
>  obj-$(CONFIG_UCSI_STM32G0)		+= ucsi_stm32g0.o
>  obj-$(CONFIG_UCSI_PMIC_GLINK)		+= ucsi_glink.o
> +obj-$(CONFIG_UCSI_LENOVO_YOGA_C630)	+= ucsi_yoga_c630.o
> diff --git a/drivers/usb/typec/ucsi/ucsi_yoga_c630.c b/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
> new file mode 100644
> index 000000000000..194b49291f28
> --- /dev/null
> +++ b/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
> @@ -0,0 +1,202 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022-2024, Linaro Ltd
> + * Authors:
> + *  Bjorn Andersson
> + *  Dmitry Baryshkov
> + */
> +#include <linux/auxiliary_bus.h>
> +#include <linux/bitops.h>
> +#include <linux/completion.h>
> +#include <linux/container_of.h>
> +#include <linux/module.h>
> +#include <linux/notifier.h>
> +#include <linux/string.h>
> +#include <linux/platform_data/lenovo-yoga-c630.h>
> +
> +#include "ucsi.h"
> +
> +struct yoga_c630_ucsi {
> +	struct yoga_c630_ec *ec;
> +	struct ucsi *ucsi;
> +	struct notifier_block nb;
> +	struct completion complete;
> +	unsigned long flags;
> +#define UCSI_C630_COMMAND_PENDING	0
> +#define UCSI_C630_ACK_PENDING		1
> +	u16 version;
> +};
> +
> +static int yoga_c630_ucsi_read(struct ucsi *ucsi, unsigned int offset,
> +			       void *val, size_t val_len)
> +{
> +	struct yoga_c630_ucsi *uec = ucsi_get_drvdata(ucsi);
> +	u8 buf[YOGA_C630_UCSI_READ_SIZE];
> +	int ret;
> +
> +	ret = yoga_c630_ec_ucsi_read(uec->ec, buf);
> +	if (ret)
> +		return ret;
> +
> +	if (offset == UCSI_VERSION) {
> +		memcpy(val, &uec->version, min(val_len, sizeof(uec->version)));
> +		return 0;
> +	}
> +
> +	if (offset == UCSI_CCI)
> +		memcpy(val, buf, min(val_len, YOGA_C630_UCSI_CCI_SIZE));
> +	else if (offset == UCSI_MESSAGE_IN)
> +		memcpy(val, buf + YOGA_C630_UCSI_CCI_SIZE,
> +		       min(val_len, YOGA_C630_UCSI_DATA_SIZE));
> +	else
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int yoga_c630_ucsi_async_write(struct ucsi *ucsi, unsigned int offset,
> +				      const void *val, size_t val_len)
> +{
> +	struct yoga_c630_ucsi *uec = ucsi_get_drvdata(ucsi);
> +
> +	if (offset != UCSI_CONTROL ||
> +	    val_len != YOGA_C630_UCSI_WRITE_SIZE)
> +		return -EINVAL;
> +
> +	return yoga_c630_ec_ucsi_write(uec->ec, val);
> +}
> +
> +static int yoga_c630_ucsi_sync_write(struct ucsi *ucsi, unsigned int offset,
> +				     const void *val, size_t val_len)
> +{
> +	struct yoga_c630_ucsi *uec = ucsi_get_drvdata(ucsi);
> +	bool ack = UCSI_COMMAND(*(u64 *)val) == UCSI_ACK_CC_CI;
> +	int ret;
> +
> +	if (ack)
> +		set_bit(UCSI_C630_ACK_PENDING, &uec->flags);
> +	else
> +		set_bit(UCSI_C630_COMMAND_PENDING, &uec->flags);
> +
> +	reinit_completion(&uec->complete);
> +
> +	ret = yoga_c630_ucsi_async_write(ucsi, offset, val, val_len);
> +	if (ret)
> +		goto out_clear_bit;
> +
> +	if (!wait_for_completion_timeout(&uec->complete, 5 * HZ))
> +		ret = -ETIMEDOUT;
> +
> +out_clear_bit:
> +	if (ack)
> +		clear_bit(UCSI_C630_ACK_PENDING, &uec->flags);
> +	else
> +		clear_bit(UCSI_C630_COMMAND_PENDING, &uec->flags);
> +
> +	return ret;
> +}
> +
> +const struct ucsi_operations yoga_c630_ucsi_ops = {
> +	.read = yoga_c630_ucsi_read,
> +	.sync_write = yoga_c630_ucsi_sync_write,
> +	.async_write = yoga_c630_ucsi_async_write,
> +};
> +
> +static void yoga_c630_ucsi_notify_ucsi(struct yoga_c630_ucsi *uec, u32 cci)
> +{
> +	if (UCSI_CCI_CONNECTOR(cci))
> +		ucsi_connector_change(uec->ucsi, UCSI_CCI_CONNECTOR(cci));
> +
> +	if (cci & UCSI_CCI_ACK_COMPLETE &&
> +	    test_bit(UCSI_C630_ACK_PENDING, &uec->flags))
> +		complete(&uec->complete);
> +
> +	if (cci & UCSI_CCI_COMMAND_COMPLETE &&
> +	    test_bit(UCSI_C630_COMMAND_PENDING, &uec->flags))
> +		complete(&uec->complete);
> +}
> +
> +static int yoga_c630_ucsi_notify(struct notifier_block *nb,
> +				 unsigned long action, void *data)
> +{
> +	struct yoga_c630_ucsi *uec = container_of(nb, struct yoga_c630_ucsi, nb);
> +	u32 cci;
> +	int ret;
> +
> +	switch (action) {
> +	case LENOVO_EC_EVENT_USB:
> +	case LENOVO_EC_EVENT_HPD:
> +		ucsi_connector_change(uec->ucsi, 1);
> +		return NOTIFY_OK;
> +
> +	case LENOVO_EC_EVENT_UCSI:
> +		ret = uec->ucsi->ops->read(uec->ucsi, UCSI_CCI, &cci, sizeof(cci));
> +		if (ret)
> +			return NOTIFY_DONE;
> +
> +		yoga_c630_ucsi_notify_ucsi(uec, cci);
> +
> +		return NOTIFY_OK;
> +
> +	default:
> +		return NOTIFY_DONE;
> +	}
> +}
> +
> +static int yoga_c630_ucsi_probe(struct auxiliary_device *adev,
> +				const struct auxiliary_device_id *id)
> +{
> +	struct yoga_c630_ec *ec = adev->dev.platform_data;
> +	struct yoga_c630_ucsi *uec;
> +	int ret;
> +
> +	uec = devm_kzalloc(&adev->dev, sizeof(*uec), GFP_KERNEL);
> +	if (!uec)
> +		return -ENOMEM;
> +
> +	uec->ec = ec;
> +	init_completion(&uec->complete);
> +	uec->nb.notifier_call = yoga_c630_ucsi_notify;
> +
> +	uec->ucsi = ucsi_create(&adev->dev, &yoga_c630_ucsi_ops);
> +	if (IS_ERR(uec->ucsi))
> +		return PTR_ERR(uec->ucsi);
> +
> +	ucsi_set_drvdata(uec->ucsi, uec);
> +
> +	uec->version = yoga_c630_ec_ucsi_get_version(uec->ec);
> +
> +	auxiliary_set_drvdata(adev, uec);
> +
> +	ret = yoga_c630_ec_register_notify(ec, &uec->nb);
> +	if (ret)
> +		return ret;
> +
> +	return ucsi_register(uec->ucsi);
> +}
> +
> +static void yoga_c630_ucsi_remove(struct auxiliary_device *adev)
> +{
> +	struct yoga_c630_ucsi *uec = auxiliary_get_drvdata(adev);
> +
> +	yoga_c630_ec_unregister_notify(uec->ec, &uec->nb);
> +	ucsi_unregister(uec->ucsi);
> +}
> +
> +static const struct auxiliary_device_id yoga_c630_ucsi_id_table[] = {
> +	{ .name = YOGA_C630_MOD_NAME "." YOGA_C630_DEV_UCSI, },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(auxiliary, yoga_c630_ucsi_id_table);
> +
> +static struct auxiliary_driver yoga_c630_ucsi_driver = {
> +	.name = YOGA_C630_DEV_UCSI,
> +	.id_table = yoga_c630_ucsi_id_table,
> +	.probe = yoga_c630_ucsi_probe,
> +	.remove = yoga_c630_ucsi_remove,
> +};
> +
> +module_auxiliary_driver(yoga_c630_ucsi_driver);
> +
> +MODULE_DESCRIPTION("Lenovo Yoga C630 UCSI");
> +MODULE_LICENSE("GPL");
> 
> -- 
> 2.39.2

-- 
heikki

