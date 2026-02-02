Return-Path: <linux-pm+bounces-41903-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGm0HumDgGnE8wIAu9opvQ
	(envelope-from <linux-pm+bounces-41903-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 12:00:57 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BD4CB63D
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 12:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E11ED3001078
	for <lists+linux-pm@lfdr.de>; Mon,  2 Feb 2026 10:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24A635CBCA;
	Mon,  2 Feb 2026 10:59:31 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788232DC350;
	Mon,  2 Feb 2026 10:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770029971; cv=none; b=j0Ki+KqVJc9+j5fEVTX17lOFKnqc3SIbTdnaBC3KpE+wgHKs8kngU9zacgbmqQUaZa5fe0VcOjU5eWALBxWB3kh0U2dNWYvAqV8IMi9pZrYUxG/lwhImIBF1r1ZoS8+XpYP7UCrgDwxz/zimogcHdX8hX+lDSMF6xvubncY1Rdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770029971; c=relaxed/simple;
	bh=IuRaSBLIVYPYtk7Ns+Da75yPOBJvau0vURBHjEnT3JA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nkbh9Lbp2uRbG7SpYjivfIldyX8EykO4rbszkai13j6IB4ZVmt7iFiP1BaTgGInqt+aH9X76NbOsjf/74i+tiR71BIDv9uGBPLRpqzTFCxnXO7AormZo71PW5PkU08Aar9TUMVqKL1Kdk8LvK1SDHnJi68Lt+ynmiWOk6TxGzpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7EF8B339;
	Mon,  2 Feb 2026 02:59:22 -0800 (PST)
Received: from [10.57.7.119] (unknown [10.57.7.119])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6EAE43F7A6;
	Mon,  2 Feb 2026 02:59:25 -0800 (PST)
Message-ID: <a27b755d-00d2-4350-98ab-0b68ab754770@arm.com>
Date: Mon, 2 Feb 2026 10:59:27 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/8] thermal: Add Remote Proc cooling driver
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, krzk+dt@kernel.org,
 casey.connolly@linaro.org, amitk@kernel.org, konradybcio@kernel.org,
 rui.zhang@intel.com, daniel.lezcano@linaro.org, rafael@kernel.org,
 conor+dt@kernel.org, andersson@kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
 mathieu.poirier@linaro.org, mani@kernel.org
References: <20251223123227.1317244-1-gaurav.kohli@oss.qualcomm.com>
 <20251223123227.1317244-2-gaurav.kohli@oss.qualcomm.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20251223123227.1317244-2-gaurav.kohli@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukasz.luba@arm.com,linux-pm@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41903-lists,linux-pm=lfdr.de];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 93BD4CB63D
X-Rspamd-Action: no action

Hi Gaurav,

On 12/23/25 12:32, Gaurav Kohli wrote:
> Add a new generic driver for thermal cooling devices that control
> remote processors (modem, DSP, etc.) through various communication
> channels.
> 
> This driver provides an abstraction layer between the thermal
> subsystem and vendor-specific remote processor communication
> mechanisms.

Is this the patch about proposing the new cooling
device type at last LPC2025 conference (what we've discussed with Amit)?

There was some feedback asking you to add a bit more description
into this patch header, please do that (with some background as well).

> 
> Suggested-by: Amit Kucheria <amit.kucheria@oss.qualcomm.com>
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> ---
>   MAINTAINERS                          |   8 ++
>   drivers/thermal/Kconfig              |  11 ++
>   drivers/thermal/Makefile             |   2 +
>   drivers/thermal/remoteproc_cooling.c | 154 +++++++++++++++++++++++++++
>   include/linux/remoteproc_cooling.h   |  52 +++++++++
>   5 files changed, 227 insertions(+)
>   create mode 100644 drivers/thermal/remoteproc_cooling.c
>   create mode 100644 include/linux/remoteproc_cooling.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 679e5f11e672..c1ba87315cdf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -25935,6 +25935,14 @@ F:	drivers/thermal/cpufreq_cooling.c
>   F:	drivers/thermal/cpuidle_cooling.c
>   F:	include/linux/cpu_cooling.h
>   
> +THERMAL/REMOTEPROC_COOLING
> +M:	Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> +L:	linux-pm@vger.kernel.org
> +S:	Supported
> +F:	drivers/thermal/remoteproc_cooling.c
> +F:	include/linux/remoteproc_cooling.h
> +
> +
>   THERMAL/POWER_ALLOCATOR
>   M:	Lukasz Luba <lukasz.luba@arm.com>
>   L:	linux-pm@vger.kernel.org
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index b10080d61860..31e92be34387 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -229,6 +229,17 @@ config PCIE_THERMAL
>   
>   	  If you want this support, you should say Y here.
>   
> +
> +config REMOTEPROC_THERMAL
> +	bool "Remote processor cooling support"
> +	help
> +	  This implements a generic cooling mechanism for remote processors
> +	  (modem, DSP, etc.) that allows vendor-specific implementations to
> +	  register thermal cooling devices and provide callbacks for thermal
> +	  mitigation.
> +
> +	  If you want this support, you should say Y here.
> +
>   config THERMAL_EMULATION
>   	bool "Thermal emulation mode support"
>   	help
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index bb21e7ea7fc6..ae747dde54fe 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -34,6 +34,8 @@ thermal_sys-$(CONFIG_DEVFREQ_THERMAL) += devfreq_cooling.o
>   
>   thermal_sys-$(CONFIG_PCIE_THERMAL) += pcie_cooling.o
>   
> +thermal_sys-$(CONFIG_REMOTEPROC_THERMAL) += remoteproc_cooling.o
> +
>   obj-$(CONFIG_K3_THERMAL)	+= k3_bandgap.o k3_j72xx_bandgap.o
>   # platform thermal drivers
>   obj-y				+= broadcom/
> diff --git a/drivers/thermal/remoteproc_cooling.c b/drivers/thermal/remoteproc_cooling.c
> new file mode 100644
> index 000000000000..a1f948cbde0f
> --- /dev/null
> +++ b/drivers/thermal/remoteproc_cooling.c
> @@ -0,0 +1,154 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Remote Processor Cooling Device
> + *
> + * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/export.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/slab.h>
> +#include <linux/thermal.h>
> +
> +#define REMOTEPROC_PREFIX		"rproc_"
> +
> +struct remoteproc_cooling_ops {
> +	int (*get_max_level)(void *devdata, unsigned long *level);
> +	int (*get_cur_level)(void *devdata, unsigned long *level);
> +	int (*set_cur_level)(void *devdata, unsigned long level);
> +};

1. There is no comment for struct and the functions like you did below.
2. Why you need those 3 callbacks?
    It looks like they are simple wrappers on stuff in
    'struct thermal_cooling_device_ops'.
    Please try to get rid of them and re-use the existing fwk callbacks.

> +
> +/**
> + * struct remoteproc_cdev - Remote processor cooling device
> + * @cdev: Thermal cooling device handle
> + * @ops: Vendor-specific operation callbacks
> + * @devdata: Private data for vendor implementation
> + * @np: Device tree node associated with this cooling device
> + * @lock: Mutex to protect cooling device operations
> + */
> +struct remoteproc_cdev {

Please use the full naming:
remoteproc_cooling_device

> +	struct thermal_cooling_device *cdev;

You don't need to keep it here. AFAICS it's only
used in the 'unregister' function. Please check my
comment here and then remove this pointer.
(It creates uneseccery linkage between those devices).

> +	const struct remoteproc_cooling_ops *ops;

So here it can be simply:
struct thermal_cooling_device_ops cooling_ops;

> +	void *devdata;
> +	struct device_node *np;

This 'np' is also not used, remove it please.

> +	struct mutex lock;
> +};
> +
> +
> +/* Thermal cooling device callbacks */
> +
> +static int remoteproc_get_max_state(struct thermal_cooling_device *cdev,
> +				    unsigned long *state)
> +{
> +	struct remoteproc_cdev *rproc_cdev = cdev->devdata;
> +	int ret;
> +
> +	if (!rproc_cdev || !rproc_cdev->ops)
> +		return -EINVAL;

This mustn't be changed in runtime accidenly. We don't guard in
cpufreq-/devfreq- cooling these callbacks that way. Please drop them.

> +
> +	mutex_lock(&rproc_cdev->lock);
> +	ret = rproc_cdev->ops->get_max_level(rproc_cdev->devdata, state);
> +	mutex_unlock(&rproc_cdev->lock);
> +
> +	return ret;
> +}
> +
> +static int remoteproc_get_cur_state(struct thermal_cooling_device *cdev,
> +				    unsigned long *state)
> +{
> +	struct remoteproc_cdev *rproc_cdev = cdev->devdata;
> +	int ret;
> +
> +	if (!rproc_cdev || !rproc_cdev->ops)
> +		return -EINVAL;

as above

> +
> +	mutex_lock(&rproc_cdev->lock);
> +	ret = rproc_cdev->ops->get_cur_level(rproc_cdev->devdata, state);
> +	mutex_unlock(&rproc_cdev->lock);
> +
> +	return ret;
> +}
> +
> +static int remoteproc_set_cur_state(struct thermal_cooling_device *cdev,
> +				    unsigned long state)
> +{
> +	struct remoteproc_cdev *rproc_cdev = cdev->devdata;
> +	int ret;
> +
> +	if (!rproc_cdev || !rproc_cdev->ops)
> +		return -EINVAL;

as above

> +
> +	mutex_lock(&rproc_cdev->lock);
> +	ret = rproc_cdev->ops->set_cur_level(rproc_cdev->devdata, state);
> +	mutex_unlock(&rproc_cdev->lock);
> +
> +	return ret;
> +}
> +
> +static const struct thermal_cooling_device_ops remoteproc_cooling_ops = {
> +	.get_max_state = remoteproc_get_max_state,
> +	.get_cur_state = remoteproc_get_cur_state,
> +	.set_cur_state = remoteproc_set_cur_state,
> +};
> +
> +struct remoteproc_cdev *
> +remoteproc_cooling_register(struct device_node *np,
> +			     const char *name, const struct remoteproc_cooling_ops *ops,
> +			     void *devdata)

Since this is based on device_node, please align to the naming
convention from cpufreq-/devfreq-cooling and use prefix 'of_'

of_remoteproc_cooling_register()

> +{
> +	struct remoteproc_cdev *rproc_cdev;
> +	struct thermal_cooling_device *cdev;
> +	int ret;
> +
> +	if (!name || !ops) {

IMO you should check the '!np' here, not the lines below.
We can simply bail out very early.

> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	rproc_cdev = kzalloc(sizeof(*rproc_cdev), GFP_KERNEL);
> +	if (!rproc_cdev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	rproc_cdev->ops = ops;
> +	rproc_cdev->devdata = devdata;
> +	rproc_cdev->np = np;
> +	mutex_init(&rproc_cdev->lock);
> +
> +	char *rproc_name __free(kfree) =
> +		kasprintf(GFP_KERNEL, REMOTEPROC_PREFIX "%s", name);
> +	/* Register with thermal framework */
> +	if (np) {

Too late to test 'np'.

> +		cdev = thermal_of_cooling_device_register(np, rproc_name, rproc_cdev,
> +							  &remoteproc_cooling_ops);
> +	}
> +
> +	if (IS_ERR(cdev)) {

This check should be just below the line when you get the 'cdev'

> +		ret = PTR_ERR(cdev);
> +		goto free_rproc_cdev;
> +	}
> +
> +	rproc_cdev->cdev = cdev;
> +
> +	return rproc_cdev;
> +
> +free_rproc_cdev:
> +	kfree(rproc_cdev);
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(remoteproc_cooling_register);
> +
> +void remoteproc_cooling_unregister(struct remoteproc_cdev *rproc_cdev)

Change the API to be alined with cpufreq-cooling and devfreq-cooling
types of devices, so:

void remoteproc_cooling_unregister(struct thermal_cooling_device *cdev)

You still should be able to get the rptoc_cdev like:

rproc_cdev = cdev->devdata;

and free it.

> +{
> +	if (!rproc_cdev)
> +		return;
> +
> +	thermal_cooling_device_unregister(rproc_cdev->cdev);
> +	mutex_destroy(&rproc_cdev->lock);
> +	kfree(rproc_cdev);
> +}
> +EXPORT_SYMBOL_GPL(remoteproc_cooling_unregister);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Remote Processor Cooling Device");
> diff --git a/include/linux/remoteproc_cooling.h b/include/linux/remoteproc_cooling.h
> new file mode 100644
> index 000000000000..ef94019d220d
> --- /dev/null
> +++ b/include/linux/remoteproc_cooling.h
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Remote Processor Cooling Device
> + *
> + * Copyright (c) 2025, Qualcomm Innovation Center
> + */
> +
> +#ifndef __REMOTEPROC_COOLING_H__
> +#define __REMOTEPROC_COOLING_H__
> +
> +#include <linux/thermal.h>
> +
> +struct device;
> +struct device_node;
> +
> +struct remoteproc_cooling_ops {
> +	int (*get_max_level)(void *devdata, unsigned long *level);
> +	int (*get_cur_level)(void *devdata, unsigned long *level);
> +	int (*set_cur_level)(void *devdata, unsigned long level);
> +};

That duplicate w/ .c file content.
We don't need this in the header, please follow the cpufreq-/devfreq-
design.

> +
> +struct remoteproc_cdev;
> +
> +#ifdef CONFIG_REMOTEPROC_THERMAL
> +
> +struct remoteproc_cdev *
> +remoteproc_cooling_register(struct device_node *np,
> +			     const char *name,
> +			     const struct remoteproc_cooling_ops *ops,
> +			     void *devdata);
> +
> +void remoteproc_cooling_unregister(struct remoteproc_cdev *rproc_cdev);
> +
> +#else /* !CONFIG_REMOTEPROC_THERMAL */
> +
> +static inline struct remoteproc_cdev *
> +remoteproc_cooling_register(struct device_node *np,
> +			     const char *name,
> +			     const struct remoteproc_cooling_ops *ops,
> +			     void *devdata)
> +{
> +	return ERR_PTR(-EINVAL);
> +}

Function naming convention here as well


Regards,
Lukasz

