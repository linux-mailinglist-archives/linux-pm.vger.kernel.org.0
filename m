Return-Path: <linux-pm+bounces-41612-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABAaF5/1eWkE1QEAu9opvQ
	(envelope-from <linux-pm+bounces-41612-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 12:40:15 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 04663A0A36
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 12:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15AF730576BA
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 11:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0912EA171;
	Wed, 28 Jan 2026 11:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKYGYuIa"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABFC2BEFFF;
	Wed, 28 Jan 2026 11:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599950; cv=none; b=HJ37W0QlQwIQCBrC3ssZ6PpoEm7ChW6D2LCnL47pgW7rLp2el1dJyqvJgqQ79GQy8p83+VruqVCN5owIKHKeoG08/NIbpO9XSTsErvon18PFAoZfCBDMBci/9K8XMvZPyfL9JsTkXqcetTaLtlxphK97MOMb3Upmqh91LZMtdLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599950; c=relaxed/simple;
	bh=KysVmJLSIzaMW0m7vxH9W3dWOyoa8ERdFfNk2aIsbSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ni2Mn7RckTE7et0oIC+FEy7YaRZDNfncN8NLJ0qO0CX6mQgm+87dDSE33iu35SstbChL868ds8atFCWckYh//IdJTNyx++ct1BPVh6MPqAdLOgIuTRFMn5igPuLF/Q6obqH6PDZlB9GWvGxgczx0SPW7LaSgFkIx9MilkFnh22U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uKYGYuIa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A3DC4CEF1;
	Wed, 28 Jan 2026 11:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769599949;
	bh=KysVmJLSIzaMW0m7vxH9W3dWOyoa8ERdFfNk2aIsbSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uKYGYuIahSZ+TPTJjz5bg7dz4ONXUnjVHKaxBdcbQv+FcCD0ibu/Mpu5DgIkjgrMB
	 3zwfucstE8QTnVFTQg7GQvvJCLKIh1bc/WqP7rdpDS1bmR0EKL1oUhd1uCVOYd/b3r
	 oyhsY689OHeSjvR5MFc/PNpu2su/EyZ+hq0JAgwy0WeeD1gmVFKT+AVC+QYc7csUn0
	 Bl+zHQB0TVtrb6/UNt7e99Ki4jDml7OFKpPj33PB/ji2nmdvQQ9Zivc6U6iNnMk5QW
	 HJhVllaxsKQdlcDiiqUyL5Lq9zPQVbzLObB/7qb6glEuuYaD4p4Z1A6OYWzSYUeHhD
	 0nY+kAnCEs7zQ==
Date: Wed, 28 Jan 2026 12:32:27 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: andersson@kernel.org, mathieu.poirier@linaro.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com, 
	konradybcio@kernel.org, mani@kernel.org, casey.connolly@linaro.org, 
	amit.kucheria@oss.qualcomm.com, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com
Subject: Re: [PATCH v2 1/8] thermal: Add Remote Proc cooling driver
Message-ID: <20260128-quick-maroon-dragon-d832c8@quoll>
References: <20260127155722.2797783-1-gaurav.kohli@oss.qualcomm.com>
 <20260127155722.2797783-2-gaurav.kohli@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260127155722.2797783-2-gaurav.kohli@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41612-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 04663A0A36
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 09:27:15PM +0530, Gaurav Kohli wrote:
> Add a new generic driver for thermal cooling devices that control

There is no driver here. You did not a single driver entry point.

> remote processors (modem, DSP, etc.) through various communication
> channels.
> 
> This driver provides an abstraction layer between the thermal

Please read coding style how much we like abstraction layers.

> subsystem and vendor-specific remote processor communication
> mechanisms.
> 
> Advantage of this to avoid duplicating vendor-specific logic
> in the thermal subsystem and make it easier for different vendors
> to plug in their own cooling mechanisms via callbacks.
> 
> Suggested-by: Amit Kucheria <amit.kucheria@oss.qualcomm.com>
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> ---
>  MAINTAINERS                          |   7 ++
>  drivers/thermal/Kconfig              |  10 ++
>  drivers/thermal/Makefile             |   2 +
>  drivers/thermal/remoteproc_cooling.c | 143 +++++++++++++++++++++++++++
>  include/linux/remoteproc_cooling.h   |  52 ++++++++++
>  5 files changed, 214 insertions(+)
>  create mode 100644 drivers/thermal/remoteproc_cooling.c
>  create mode 100644 include/linux/remoteproc_cooling.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 414f44093269..5ebc7819d2cf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -26169,6 +26169,13 @@ F:	drivers/thermal/cpufreq_cooling.c
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
>  THERMAL/POWER_ALLOCATOR

Please beginning of this file. P < R.


>  M:	Lukasz Luba <lukasz.luba@arm.com>
>  L:	linux-pm@vger.kernel.org
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index b10080d61860..dfc52eed64de 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -229,6 +229,16 @@ config PCIE_THERMAL
>  
>  	  If you want this support, you should say Y here.
>  
> +config REMOTEPROC_THERMAL
> +	tristate "Remote processor cooling support"
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
> index 000000000000..f958efa691b3
> --- /dev/null
> +++ b/drivers/thermal/remoteproc_cooling.c
> @@ -0,0 +1,143 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Remote Processor Cooling Device
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/export.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>

Where do you use it?

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
> +	struct mutex lock;
> +};
> +
> +/* Thermal cooling device callbacks */
> +
> +static int remoteproc_get_max_state(struct thermal_cooling_device *cdev,
> +				    unsigned long *state)
> +{
> +	struct remoteproc_cdev *rproc_cdev = cdev->devdata;
> +	int ret;
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
> +			    const char *name, const struct remoteproc_cooling_ops *ops,
> +			     void *devdata)
> +{
> +	struct remoteproc_cdev *rproc_cdev;
> +	struct thermal_cooling_device *cdev;
> +	int ret;
> +
> +	if (!name || !ops)
> +		return ERR_PTR(-EINVAL);
> +
> +	rproc_cdev = kzalloc(sizeof(*rproc_cdev), GFP_KERNEL);
> +	if (!rproc_cdev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	rproc_cdev->ops = ops;
> +	rproc_cdev->devdata = devdata;
> +	mutex_init(&rproc_cdev->lock);
> +
> +	char *rproc_name __free(kfree) =
> +		kasprintf(GFP_KERNEL, REMOTEPROC_PREFIX "%s", name);
> +	/* Register with thermal framework */
> +	if (np)
> +		cdev = thermal_of_cooling_device_register(np, rproc_name, rproc_cdev,
> +							  &remoteproc_cooling_ops);
> +	else
> +		cdev = thermal_cooling_device_register(rproc_name, rproc_cdev,
> +						       &remoteproc_cooling_ops);
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

I do not see any driver here, just bunch of exported functions. I do not
see point in this abstraction/wrapping layer.

Another abstraction layer, NAK.

Best regards,
Krzysztof


