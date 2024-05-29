Return-Path: <linux-pm+bounces-8382-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 987718D3A4F
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 17:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ABBF1F25A52
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 15:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167BC17DE07;
	Wed, 29 May 2024 15:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PVTxxS4P"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A76954670;
	Wed, 29 May 2024 15:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716995318; cv=none; b=jVewE3ZFRMx6h3fGZf4p1Fl8vNonOiAbYUMxMMVR8b+2FS4EIYJqIJeo/EC+YOou8wGvP4cMRIHMP3GbOqsJryXpoYXARxMQ0hvdX9XFkSj4vj7jyzecKfBEgAqTlN6i3QKiPCMkIjxrZBAP7Mrkuo7IaVRp52GAbDvwtF0VEXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716995318; c=relaxed/simple;
	bh=2TnDYbALHW9Uln9puESWYKnzTMt+p8MzBHG0+qadvI4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fJfyFk6KGOZZU/WzpYjwFMNopBdsE1UFVU2VW6zXo36XbmttCzB9CejcSqtFDouzAUBbcTGdgz2/3gHIgjDivKWp2fEeD5d6lgMAzXAPyUW5G0NHfvXtUJUGviOpUbCZ0oXCa+dRjzA2O7EBepI9l0L/eHTq5HEG+6fbVd80FmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PVTxxS4P; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716995316; x=1748531316;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2TnDYbALHW9Uln9puESWYKnzTMt+p8MzBHG0+qadvI4=;
  b=PVTxxS4P9iRTx9k6nO7JaoOLCeYe5ZK0Ynw81X21IvttOhhFLJdtZH4Z
   4kl8zkUhyTRNnoO5uIVg+iksFHWNI408XiRTBhQRvrW1Ia24P1cHEt/mZ
   XaWVTKhxXb3t3SismDH2hE0ucvgfkkrPVzCAAkeWBaKjK7lp33m7E2Rc5
   fhZHgnN1Vi3IVmFSgCmUb+lF+9Jtj6YLaPdUfCGALitagu1pTb+LH5hl3
   nXSqlXVt1cBnMxhdcYD6dSbye9QHBqs+a5s33Ld1vq0z5CsT+rl8OAiGR
   JAnSbtgQ1WUL//x6JsMzaSkNcu5yMTEdyjKGLyxNN7t4WK9XquXtr3tnR
   g==;
X-CSE-ConnectionGUID: 6Q+aZ0ooTIC92laQF3oRtA==
X-CSE-MsgGUID: jYTkwJsvTdio0wLgFpFn+A==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="38790574"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="38790574"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 08:08:35 -0700
X-CSE-ConnectionGUID: OI+KJKjWSW2Oj8078j0oUw==
X-CSE-MsgGUID: dUd48Du6R56NMYdwmMGVpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="35431804"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.149])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 08:08:30 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 29 May 2024 18:08:26 +0300 (EEST)
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
    Hans de Goede <hdegoede@redhat.com>, 
    Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
    Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Konrad Dybcio <konrad.dybcio@linaro.org>, linux-pm@vger.kernel.org, 
    devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org, linux-usb@vger.kernel.org, 
    linux-arm-msm@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>
Subject: Re: [PATCH v4 2/6] platform: arm64: add Lenovo Yoga C630 WOS EC
 driver
In-Reply-To: <20240528-yoga-ec-driver-v4-2-4fa8dfaae7b6@linaro.org>
Message-ID: <627f5d3f-7171-c483-2c0a-de0e94b59a84@linux.intel.com>
References: <20240528-yoga-ec-driver-v4-0-4fa8dfaae7b6@linaro.org> <20240528-yoga-ec-driver-v4-2-4fa8dfaae7b6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 28 May 2024, Dmitry Baryshkov wrote:

> Lenovo Yoga C630 WOS is a laptop using Snapdragon 850 SoC. Like many
> laptops it uses embedded controller (EC) to perform various platform
> operations, including, but not limited, to Type-C port control or power
> supply handlng.
> 
> Add the driver for the EC, that creates devices for UCSI and power
> supply devices.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/platform/arm64/Kconfig                 |  14 ++
>  drivers/platform/arm64/Makefile                |   1 +
>  drivers/platform/arm64/lenovo-yoga-c630.c      | 279 +++++++++++++++++++++++++
>  include/linux/platform_data/lenovo-yoga-c630.h |  42 ++++
>  4 files changed, 336 insertions(+)
> 
> diff --git a/drivers/platform/arm64/Kconfig b/drivers/platform/arm64/Kconfig
> index 8fdca0f8e909..8c103b3150d1 100644
> --- a/drivers/platform/arm64/Kconfig
> +++ b/drivers/platform/arm64/Kconfig
> @@ -32,4 +32,18 @@ config EC_ACER_ASPIRE1
>  	  laptop where this information is not properly exposed via the
>  	  standard ACPI devices.
>  
> +config EC_LENOVO_YOGA_C630
> +	tristate "Lenovo Yoga C630 Embedded Controller driver"
> +	depends on I2C
> +	help
> +	  Driver for the Embedded Controller in the Qualcomm Snapdragon-based
> +	  Lenovo Yoga C630, which provides battery and power adapter
> +	  information.
> +
> +	  This driver provides battery and AC status support for the mentioned
> +	  laptop where this information is not properly exposed via the
> +	  standard ACPI devices.
> +
> +	  Say M or Y here to include this support.
> +
>  endif # ARM64_PLATFORM_DEVICES
> diff --git a/drivers/platform/arm64/Makefile b/drivers/platform/arm64/Makefile
> index 4fcc9855579b..b2ae9114fdd8 100644
> --- a/drivers/platform/arm64/Makefile
> +++ b/drivers/platform/arm64/Makefile
> @@ -6,3 +6,4 @@
>  #
>  
>  obj-$(CONFIG_EC_ACER_ASPIRE1)	+= acer-aspire1-ec.o
> +obj-$(CONFIG_EC_LENOVO_YOGA_C630) += lenovo-yoga-c630.o
> diff --git a/drivers/platform/arm64/lenovo-yoga-c630.c b/drivers/platform/arm64/lenovo-yoga-c630.c
> new file mode 100644
> index 000000000000..3d1d5acde807
> --- /dev/null
> +++ b/drivers/platform/arm64/lenovo-yoga-c630.c
> @@ -0,0 +1,279 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022-2024, Linaro Ltd
> + * Authors:
> + *    Bjorn Andersson
> + *    Dmitry Baryshkov
> + */
> +#include <linux/auxiliary_bus.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/notifier.h>
> +#include <linux/platform_data/lenovo-yoga-c630.h>
> +
> +#define LENOVO_EC_RESPONSE_REG		0x01
> +#define LENOVO_EC_REQUEST_REG		0x02
> +
> +#define LENOVO_EC_UCSI_WRITE		0x20
> +#define LENOVO_EC_UCSI_READ		0x21
> +
> +#define LENOVO_EC_READ_REG		0xb0
> +#define LENOVO_EC_REQUEST_NEXT_EVENT	0x84
> +
> +struct yoga_c630_ec {
> +	struct i2c_client *client;
> +	struct mutex lock;

Add include for struct mutex.

> +	struct blocking_notifier_head notifier_list;
> +};
> +
> +static int yoga_c630_ec_request(struct yoga_c630_ec *ec, u8 *req, size_t req_len,
> +				u8 *resp, size_t resp_len)
> +{
> +	int ret;
> +
> +	WARN_ON(!mutex_is_locked(&ec->lock));

There some lockdep way to assert the same thing.

> +	ret = i2c_smbus_write_i2c_block_data(ec->client, LENOVO_EC_REQUEST_REG,
> +					     req_len, req);
> +	if (ret < 0)
> +		return ret;
> +
> +	return i2c_smbus_read_i2c_block_data(ec->client, LENOVO_EC_RESPONSE_REG,
> +					     resp_len, resp);
> +}
> +
> +int yoga_c630_ec_read8(struct yoga_c630_ec *ec, u8 addr)
> +{
> +	u8 req[2] = { LENOVO_EC_READ_REG, };
> +	int ret;
> +	u8 val;
> +
> +	mutex_lock(&ec->lock);
> +	req[1] = addr;
> +	ret = yoga_c630_ec_request(ec, req, sizeof(req), &val, 1);
> +	mutex_unlock(&ec->lock);
> +
> +	return ret < 0 ? ret : val;
> +}
> +EXPORT_SYMBOL_GPL(yoga_c630_ec_read8);
> +
> +int yoga_c630_ec_read16(struct yoga_c630_ec *ec, u8 addr)
> +{
> +	u8 req[2] = { LENOVO_EC_READ_REG, };
> +	int ret;
> +	u8 msb;
> +	u8 lsb;
> +
> +	mutex_lock(&ec->lock);
> +
> +	req[1] = addr;
> +	ret = yoga_c630_ec_request(ec, req, sizeof(req), &lsb, 1);
> +	if (ret < 0)
> +		goto out;
> +
> +	req[1] = addr + 1;
> +	ret = yoga_c630_ec_request(ec, req, sizeof(req), &msb, 1);
> +
> +out:
> +	mutex_unlock(&ec->lock);

Please use the scoped_guard from linux/cleanup.h for the mutex so you can 
immediately return instead of adding the out label.

> +
> +	return ret < 0 ? ret : msb << 8 | lsb;
> +}
> +EXPORT_SYMBOL_GPL(yoga_c630_ec_read16);
> +
> +u16 yoga_c630_ec_ucsi_get_version(struct yoga_c630_ec *ec)
> +{
> +	u8 req[3] = { 0xb3, 0xf2, 0x20};
> +	int ret;
> +	u8 msb;
> +	u8 lsb;
> +
> +	mutex_lock(&ec->lock);
> +	ret = yoga_c630_ec_request(ec, req, sizeof(req), &lsb, 1);
> +	if (ret < 0)
> +		goto out;
> +
> +	req[2]++;
> +	ret = yoga_c630_ec_request(ec, req, sizeof(req), &msb, 1);
> +
> +out:
> +	mutex_unlock(&ec->lock);

Ditto.

> +	return ret < 0 ? ret : msb << 8 | lsb;
> +}
> +EXPORT_SYMBOL_GPL(yoga_c630_ec_ucsi_get_version);
> +
> +int yoga_c630_ec_ucsi_write(struct yoga_c630_ec *ec,
> +			    const u8 req[YOGA_C630_UCSI_WRITE_SIZE])
> +{
> +	int ret;
> +
> +	mutex_lock(&ec->lock);
> +	ret = i2c_smbus_write_i2c_block_data(ec->client, LENOVO_EC_UCSI_WRITE,
> +					     YOGA_C630_UCSI_WRITE_SIZE, req);
> +	mutex_unlock(&ec->lock);
> +
> +	return ret < 0 ? ret : 0;
> +}
> +EXPORT_SYMBOL_GPL(yoga_c630_ec_ucsi_write);
> +
> +int yoga_c630_ec_ucsi_read(struct yoga_c630_ec *ec,
> +			   u8 resp[YOGA_C630_UCSI_READ_SIZE])
> +{
> +	int ret;
> +
> +	mutex_lock(&ec->lock);
> +	ret = i2c_smbus_read_i2c_block_data(ec->client, LENOVO_EC_UCSI_READ,
> +					    YOGA_C630_UCSI_READ_SIZE, resp);
> +	mutex_unlock(&ec->lock);
> +
> +	return ret < 0 ? ret : 0;
> +}
> +EXPORT_SYMBOL_GPL(yoga_c630_ec_ucsi_read);
> +
> +static irqreturn_t yoga_c630_ec_intr(int irq, void *data)
> +{
> +	u8 req[] = { LENOVO_EC_REQUEST_NEXT_EVENT };
> +	struct yoga_c630_ec *ec = data;
> +	u8 event;
> +	int ret;
> +
> +	mutex_lock(&ec->lock);
> +	ret = yoga_c630_ec_request(ec, req, sizeof(req), &event, 1);
> +	mutex_unlock(&ec->lock);
> +	if (ret < 0)
> +		return IRQ_HANDLED;
> +
> +	pr_info("NOTIFY %x\n", event);
> +
> +	blocking_notifier_call_chain(&ec->notifier_list, event, ec);
> +
> +	return IRQ_HANDLED;

Add include for IRQ_HANDLED and irqreturn_t.

> +}
> +
> +/**
> + * yoga_c630_ec_register_notify - Register a notifier callback for EC events.
> + * @ec: Yoga C630 EC
> + * @nb: Notifier block pointer to register
> + *
> + * Return: 0 on success or negative error code.
> + */
> +int yoga_c630_ec_register_notify(struct yoga_c630_ec *ec, struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(&ec->notifier_list,
> +						nb);

Fits to one line.

> +}
> +EXPORT_SYMBOL_GPL(yoga_c630_ec_register_notify);
> +
> +/**
> + * yoga_c630_ec_unregister_notify - Unregister notifier callback for EC events.
> + * @ec: Yoga C630 EC
> + * @nb: Notifier block pointer to unregister
> + *
> + * Unregister a notifier callback that was previously registered with
> + * yoga_c630_ec_register_notify().
> + */
> +void yoga_c630_ec_unregister_notify(struct yoga_c630_ec *ec, struct notifier_block *nb)
> +{
> +	blocking_notifier_chain_unregister(&ec->notifier_list, nb);
> +}
> +EXPORT_SYMBOL_GPL(yoga_c630_ec_unregister_notify);
> +
> +static void yoga_c630_aux_release(struct device *dev)
> +{
> +	struct auxiliary_device *adev = to_auxiliary_dev(dev);
> +
> +	kfree(adev);
> +}
> +
> +static void yoga_c630_aux_remove(void *data)
> +{
> +	struct auxiliary_device *adev = data;
> +
> +	auxiliary_device_delete(adev);
> +	auxiliary_device_uninit(adev);
> +}
> +
> +static int yoga_c630_aux_init(struct device *parent, const char *name,
> +			      struct yoga_c630_ec *ec)
> +{
> +	struct auxiliary_device *adev;
> +	int ret;
> +
> +	adev = kzalloc(sizeof(*adev), GFP_KERNEL);

Add include for kzalloc.

> +	if (!adev)
> +		return -ENOMEM;

Add include for ENOMEM.

I might have missed some other includes your code is using which are not 
directly included currently, please add them as well.

> +	adev->name = name;
> +	adev->id = 0;
> +	adev->dev.parent = parent;
> +	adev->dev.release = yoga_c630_aux_release;
> +	adev->dev.platform_data = ec;
> +
> +	ret = auxiliary_device_init(adev);
> +	if (ret) {
> +		kfree(adev);
> +		return ret;
> +	}
> +
> +	ret = auxiliary_device_add(adev);
> +	if (ret) {
> +		auxiliary_device_uninit(adev);
> +		return ret;
> +	}
> +
> +	return devm_add_action_or_reset(parent, yoga_c630_aux_remove, adev);
> +}
> +
> +static int yoga_c630_ec_probe(struct i2c_client *client)
> +{
> +	struct yoga_c630_ec *ec;
> +	struct device *dev = &client->dev;

Reverse the order of these two.

> +	int ret;
> +
> +	ec = devm_kzalloc(dev, sizeof(*ec), GFP_KERNEL);
> +	if (!ec)
> +		return -ENOMEM;
> +
> +	mutex_init(&ec->lock);
> +	ec->client = client;
> +	BLOCKING_INIT_NOTIFIER_HEAD(&ec->notifier_list);
> +
> +	ret = devm_request_threaded_irq(dev, client->irq,
> +					NULL, yoga_c630_ec_intr,

Could you please rename the handler function such that it's immediately 
obvious you're using irq thread (I had to check this from here when 
reviewing your handler since you used mutex inside it).

> +					IRQF_ONESHOT, "yoga_c630_ec", ec);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "unable to request irq\n");
> +
> +	ret = yoga_c630_aux_init(dev, YOGA_C630_DEV_PSY, ec);
> +	if (ret)
> +		return ret;
> +
> +	return yoga_c630_aux_init(dev, YOGA_C630_DEV_UCSI, ec);
> +}
> +
> +
> +static const struct of_device_id yoga_c630_ec_of_match[] = {
> +	{ .compatible = "lenovo,yoga-c630-ec" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, yoga_c630_ec_of_match);
> +
> +static const struct i2c_device_id yoga_c630_ec_i2c_id_table[] = {
> +	{ "yoga-c630-ec", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, yoga_c630_ec_i2c_id_table);
> +
> +static struct i2c_driver yoga_c630_ec_i2c_driver = {
> +	.driver = {
> +		.name = "yoga-c630-ec",
> +		.of_match_table = yoga_c630_ec_of_match
> +	},
> +	.probe = yoga_c630_ec_probe,
> +	.id_table = yoga_c630_ec_i2c_id_table,
> +};
> +module_i2c_driver(yoga_c630_ec_i2c_driver);
> +
> +MODULE_DESCRIPTION("Lenovo Yoga C630 Embedded Controller");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/platform_data/lenovo-yoga-c630.h b/include/linux/platform_data/lenovo-yoga-c630.h
> new file mode 100644
> index 000000000000..2b893dbeb124
> --- /dev/null
> +++ b/include/linux/platform_data/lenovo-yoga-c630.h
> @@ -0,0 +1,42 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022-2024, Linaro Ltd
> + * Authors:
> + *    Bjorn Andersson
> + *    Dmitry Baryshkov
> + */
> +
> +#ifndef _LENOVO_YOGA_C630_DATA_H
> +#define _LENOVO_YOGA_C630_DATA_H
> +
> +struct yoga_c630_ec;
> +
> +#define YOGA_C630_MOD_NAME	"lenovo_yoga_c630"
> +
> +#define YOGA_C630_DEV_UCSI	"ucsi"
> +#define YOGA_C630_DEV_PSY	"psy"
> +
> +int yoga_c630_ec_read8(struct yoga_c630_ec *ec, u8 addr);
> +int yoga_c630_ec_read16(struct yoga_c630_ec *ec, u8 addr);
> +
> +int yoga_c630_ec_register_notify(struct yoga_c630_ec *ec, struct notifier_block *nb);
> +void yoga_c630_ec_unregister_notify(struct yoga_c630_ec *ec, struct notifier_block *nb);

You need a forward declaration for struct notifier_block like you already 
have for yoga_c630_ec.

> +#define YOGA_C630_UCSI_WRITE_SIZE	8
> +#define YOGA_C630_UCSI_CCI_SIZE		4
> +#define YOGA_C630_UCSI_DATA_SIZE	16
> +#define YOGA_C630_UCSI_READ_SIZE	(YOGA_C630_UCSI_CCI_SIZE + YOGA_C630_UCSI_DATA_SIZE)
> +u16 yoga_c630_ec_ucsi_get_version(struct yoga_c630_ec *ec);
> +int yoga_c630_ec_ucsi_write(struct yoga_c630_ec *ec,
> +			    const u8 req[YOGA_C630_UCSI_WRITE_SIZE]);
> +int yoga_c630_ec_ucsi_read(struct yoga_c630_ec *ec,
> +			   u8 resp[YOGA_C630_UCSI_READ_SIZE]);
> +
> +#define LENOVO_EC_EVENT_USB		0x20
> +#define LENOVO_EC_EVENT_UCSI		0x21
> +#define LENOVO_EC_EVENT_HPD		0x22
> +#define LENOVO_EC_EVENT_BAT_STATUS	0x24
> +#define LENOVO_EC_EVENT_BAT_INFO	0x25
> +#define LENOVO_EC_EVENT_BAT_ADPT_STATUS	0x37
> +
> +#endif
> 
> 

-- 
 i.


