Return-Path: <linux-pm+bounces-40152-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B62CF0161
	for <lists+linux-pm@lfdr.de>; Sat, 03 Jan 2026 16:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A48B630012E9
	for <lists+linux-pm@lfdr.de>; Sat,  3 Jan 2026 15:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D7230DEA2;
	Sat,  3 Jan 2026 15:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/1/qXDY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803901EA7DF;
	Sat,  3 Jan 2026 15:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767452712; cv=none; b=NwRC0x64ohYc50lXvRysNXYwIUXyrAty5+8Rg7trWrhsSt6CHZqncLF262/o+GegGJA8s/HugmwL6Hzv38eZcIyggjFSOlT6gb1q9YjZWZjrrKUObIJvvctl84zYHx4AxfB3OveGTkALLZIq1yv3GDCyK3ofKUSMf55pIW7H0fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767452712; c=relaxed/simple;
	bh=RG12ZnpznvLgMFZ5ssXSY2DcE5AgQj9QvJ3hAq+c4Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHSg9twj7EfzRnOvuCYsr37bXRuhpUdcG5Uf5vugQClIGQj5pXx7AYatH3jhqELhqNA1d50skmwZB5G2cUZX5W24p/C/XmQi7y0urvg9gTBv/Zj0Xiu/ZJavjrTypizOOdW2owb7TXCn4OFdnoFxMXiTtPHB39ZnK/zgVPopgTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/1/qXDY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D60C113D0;
	Sat,  3 Jan 2026 15:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767452712;
	bh=RG12ZnpznvLgMFZ5ssXSY2DcE5AgQj9QvJ3hAq+c4Vk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k/1/qXDYV0ypk6eqbngp4b+hoC6uD9VJEzvtWLvvKFy5Kmlwu0i+GIAV2OQqXDt3v
	 yNulREuCasstSARkR/+u5qlt9+vK1JdyqjDytyhvk19O2eZVuqJbYb8tfCaTEJXvHE
	 V6c+tNoQsXciUHVfQjMHPQOkZqZSxzTRPIkJRC79uWxIYOEf6HDaaYaHZrb3BPEs/8
	 iS12r5RzoYZtBZOfro4jfziP7LROpCMAy+PDgngxbf9MmE7bb0NdZgFMuX2jny754A
	 mLbCnpxMYWQiGjrrnQbcQDRa52kVdimd7wTrSVUhQqw+YWBbebqUkJAFcWIEq8oetM
	 pGtVQQDnJq02A==
Date: Sat, 3 Jan 2026 09:05:08 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: mathieu.poirier@linaro.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org, 
	rui.zhang@intel.com, lukasz.luba@arm.com, konradybcio@kernel.org, amitk@kernel.org, 
	mani@kernel.org, casey.connolly@linaro.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Amit Kucheria <amit.kucheria@oss.qualcomm.com>
Subject: Re: [PATCH v1 1/8] thermal: Add Remote Proc cooling driver
Message-ID: <a4dpzxt4zkhwfnjijj455nziu2fa26nxzt6a6wgsm4fflcdrcu@rxjw7gcnwnxi>
References: <20251223123227.1317244-1-gaurav.kohli@oss.qualcomm.com>
 <20251223123227.1317244-2-gaurav.kohli@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223123227.1317244-2-gaurav.kohli@oss.qualcomm.com>

On Tue, Dec 23, 2025 at 06:02:20PM +0530, Gaurav Kohli wrote:
> Add a new generic driver for thermal cooling devices that control
> remote processors (modem, DSP, etc.) through various communication
> channels.
> 
> This driver provides an abstraction layer between the thermal
> subsystem and vendor-specific remote processor communication
> mechanisms.
> 
> Suggested-by: Amit Kucheria <amit.kucheria@oss.qualcomm.com>
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> ---
>  MAINTAINERS                          |   8 ++
>  drivers/thermal/Kconfig              |  11 ++
>  drivers/thermal/Makefile             |   2 +
>  drivers/thermal/remoteproc_cooling.c | 154 +++++++++++++++++++++++++++
>  include/linux/remoteproc_cooling.h   |  52 +++++++++
>  5 files changed, 227 insertions(+)
>  create mode 100644 drivers/thermal/remoteproc_cooling.c
>  create mode 100644 include/linux/remoteproc_cooling.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 679e5f11e672..c1ba87315cdf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -25935,6 +25935,14 @@ F:	drivers/thermal/cpufreq_cooling.c
>  F:	drivers/thermal/cpuidle_cooling.c
>  F:	include/linux/cpu_cooling.h
>  
> +THERMAL/REMOTEPROC_COOLING
> +M:	Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> +L:	linux-pm@vger.kernel.org
> +S:	Supported
> +F:	drivers/thermal/remoteproc_cooling.c
> +F:	include/linux/remoteproc_cooling.h
> +
> +

Two empty lines here...

>  THERMAL/POWER_ALLOCATOR
>  M:	Lukasz Luba <lukasz.luba@arm.com>
>  L:	linux-pm@vger.kernel.org
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index b10080d61860..31e92be34387 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -229,6 +229,17 @@ config PCIE_THERMAL
>  
>  	  If you want this support, you should say Y here.
>  
> +

And two here...

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
>  config THERMAL_EMULATION
>  	bool "Thermal emulation mode support"
>  	help
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index bb21e7ea7fc6..ae747dde54fe 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -34,6 +34,8 @@ thermal_sys-$(CONFIG_DEVFREQ_THERMAL) += devfreq_cooling.o
>  
>  thermal_sys-$(CONFIG_PCIE_THERMAL) += pcie_cooling.o
>  
> +thermal_sys-$(CONFIG_REMOTEPROC_THERMAL) += remoteproc_cooling.o
> +
>  obj-$(CONFIG_K3_THERMAL)	+= k3_bandgap.o k3_j72xx_bandgap.o
>  # platform thermal drivers
>  obj-y				+= broadcom/
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

No, that's not the right one.

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
> +	struct thermal_cooling_device *cdev;
> +	const struct remoteproc_cooling_ops *ops;
> +	void *devdata;
> +	struct device_node *np;

This is a local variable in remoteproc_cooling_register().

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

How is this possible? Is there some race condition or something that you
need to guard against?

> +		return -EINVAL;
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
> +{
> +	struct remoteproc_cdev *rproc_cdev;
> +	struct thermal_cooling_device *cdev;
> +	int ret;
> +
> +	if (!name || !ops) {
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

Technically it's "Optionally register with thermal framework" but that's
immediately understood by the name of the function you're calling. What
isn't clear, and where a comment would be beneficial would be to
document why it's optional (or rather conditional on np).

> +	if (np) {
> +		cdev = thermal_of_cooling_device_register(np, rproc_name, rproc_cdev,
> +							  &remoteproc_cooling_ops);
> +	}
> +
> +	if (IS_ERR(cdev)) {
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

That was never the right one.

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

This means that if I build my kernel with CONFIG_REMOTEPROC_THERMAL=n it
will not just disable remoteproc thermal management, but my remoteproc
driver will stop probing.

The remoteproc thermal feature isn't critical to the remtoeproc, so
wouldn't it make more sense to return 0 here and let the remoteproc
continue to operate in such configuration?

Regards,
Bjorn

> +}
> +
> +static inline void
> +remoteproc_cooling_unregister(struct remoteproc_cdev *rproc_cdev)
> +{
> +}
> +
> +#endif /* CONFIG_REMOTEPROC_THERMAL */
> +
> +#endif /* __REMOTEPROC_COOLING_H__ */
> -- 
> 2.34.1
> 

