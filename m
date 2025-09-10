Return-Path: <linux-pm+bounces-34370-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AD8B518A5
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 16:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64102563FEE
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 14:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA46322754;
	Wed, 10 Sep 2025 13:59:43 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF8D322C7C;
	Wed, 10 Sep 2025 13:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757512783; cv=none; b=KbhAXat8A2O2x7piTudEw3zpEhfHZxd5mvPcyYOrE1r2UBh7YUSryrP0totTuCXXGLeB8087tTF29dDzT2sB/Y/w35T6/CFrp8lpHzgLX+N2+d9ENUnh9MQrWdCIsgHUDzE1v+yaSxSrjI+C1WY1K8FC6MwTX3D+ViE8XRNIxi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757512783; c=relaxed/simple;
	bh=1GHlEkk33Hekq4aGD0DoRzQmiiOBAR4VAXYkvid7wZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KtzfL95eqvJ9vrx6QpQIywmvbmO9u/P1y31HAhVA6mXPltkQpIje8BSW10NxWqYBcMuFhvvUNW/zwsz2e37DWW8KQXrlzgYonOvH98qLSgHIryUpC0kzj+yVVw81x/tUtXijcxgvLKXwLBieum95yn6z+XP3GdML+45kn5meIXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1371C16F8;
	Wed, 10 Sep 2025 06:59:33 -0700 (PDT)
Received: from [10.1.25.55] (e122027.cambridge.arm.com [10.1.25.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E14273F694;
	Wed, 10 Sep 2025 06:59:35 -0700 (PDT)
Message-ID: <4670e984-10c2-4c8e-89b3-d3a0217735b3@arm.com>
Date: Wed, 10 Sep 2025 14:59:29 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 09/10] drm/panthor: devfreq: add pluggable devfreq
 providers
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Jassi Brar <jassisinghbrar@gmail.com>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Chia-I Wu <olvaffe@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>,
 kernel@collabora.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250905-mt8196-gpufreq-v1-0-7b6c2d6be221@collabora.com>
 <20250905-mt8196-gpufreq-v1-9-7b6c2d6be221@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250905-mt8196-gpufreq-v1-9-7b6c2d6be221@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/09/2025 11:23, Nicolas Frattaroli wrote:
> On some devices, devfreq is not controlled directly by DT OPPs and the
> common clock framework, but through an external devfreq driver. To
> permit this type of usage, add the concept of devfreq providers.
> 
> Devfreq providers for panthor register themselves with panthor as a
> provider. panthor then gets whatever driver is suckling on its
> performance-node property, finds the registered devfreq provider init
> function for it, and calls it.
> 
> Should the probe order work out such that panthor probes before the
> devfreq provider is finished probing and registering itself, then we
> just defer the probe after adding a device link.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Looks fine to me, but I think there are some updates needed due to the
DT review.

Thanks,
Steve

> ---
>  drivers/gpu/drm/panthor/panthor_devfreq.c | 74 ++++++++++++++++++++++++++++++-
>  drivers/gpu/drm/panthor/panthor_devfreq.h | 16 +++++++
>  2 files changed, 89 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.c b/drivers/gpu/drm/panthor/panthor_devfreq.c
> index d495dd856299826c4bddc205087d8914d01d7fc4..1b0c21f6f069b059b8b0e412a79556c602c5f1e7 100644
> --- a/drivers/gpu/drm/panthor/panthor_devfreq.c
> +++ b/drivers/gpu/drm/panthor/panthor_devfreq.c
> @@ -4,6 +4,7 @@
>  #include <linux/clk.h>
>  #include <linux/devfreq.h>
>  #include <linux/devfreq_cooling.h>
> +#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_opp.h>
>  
> @@ -12,6 +13,34 @@
>  #include "panthor_devfreq.h"
>  #include "panthor_device.h"
>  
> +static LIST_HEAD(panthor_devfreq_providers);
> +static DEFINE_MUTEX(panthor_devfreq_providers_lock);
> +
> +int panthor_devfreq_register_provider(struct panthor_devfreq_provider *prov)
> +{
> +	guard(mutex)(&panthor_devfreq_providers_lock);
> +
> +	list_add(&prov->node, &panthor_devfreq_providers);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(panthor_devfreq_register_provider);
> +
> +static int panthor_devfreq_init_provider(struct panthor_device *ptdev,
> +					 struct device *provider_dev)
> +{
> +	struct panthor_devfreq_provider *prov;
> +
> +	guard(mutex)(&panthor_devfreq_providers_lock);
> +
> +	list_for_each_entry(prov, &panthor_devfreq_providers, node) {
> +		if (prov->dev == provider_dev)
> +			return prov->init(ptdev, provider_dev);
> +	}
> +
> +	return -EPROBE_DEFER;
> +}
> +
>  static void panthor_devfreq_update_utilization(struct panthor_devfreq *pdevfreq)
>  {
>  	ktime_t now, last;
> @@ -102,7 +131,7 @@ static struct devfreq_dev_profile panthor_devfreq_profile = {
>  	.get_cur_freq = panthor_devfreq_get_cur_freq,
>  };
>  
> -int panthor_devfreq_init(struct panthor_device *ptdev)
> +static int panthor_devfreq_init_of(struct panthor_device *ptdev)
>  {
>  	/* There's actually 2 regulators (mali and sram), but the OPP core only
>  	 * supports one.
> @@ -222,6 +251,49 @@ int panthor_devfreq_init(struct panthor_device *ptdev)
>  	return 0;
>  }
>  
> +static int panthor_devfreq_init_platform(struct panthor_device *ptdev)
> +{
> +	struct device_node *pcnode;
> +	struct platform_device *pdev;
> +	struct device_link *link;
> +	int ret;
> +
> +	pcnode = of_parse_phandle(ptdev->base.dev->of_node,
> +				  "performance-controller", 0);
> +	if (!pcnode)
> +		return -EINVAL;
> +
> +	pdev = of_find_device_by_node(pcnode);
> +	of_node_put(pcnode);
> +	if (!pdev)
> +		return -ENODEV;
> +
> +	link = device_link_add(ptdev->base.dev, &pdev->dev,
> +			       DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
> +	if (!link) {
> +		dev_err(ptdev->base.dev, "failed to add device link\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = panthor_devfreq_init_provider(ptdev, &pdev->dev);
> +	if (ret)
> +		return dev_err_probe(ptdev->base.dev, ret,
> +				     "failed to initialize devfreq provider\n");
> +
> +	DRM_DEV_INFO(ptdev->base.dev, "initialized devfreq provider %s\n",
> +		     dev_name(&pdev->dev));
> +
> +	return 0;
> +}
> +
> +int panthor_devfreq_init(struct panthor_device *ptdev)
> +{
> +	if (!of_property_present(ptdev->base.dev->of_node, "performance-controller"))
> +		return panthor_devfreq_init_of(ptdev);
> +
> +	return panthor_devfreq_init_platform(ptdev);
> +}
> +
>  void panthor_devfreq_resume(struct panthor_device *ptdev)
>  {
>  	struct panthor_devfreq *pdevfreq = ptdev->devfreq;
> diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.h b/drivers/gpu/drm/panthor/panthor_devfreq.h
> index a891cb5fdc34636444f141e10f5d45828fc35b51..94c9768d5d038c4ba8516929edb565a1f13443fb 100644
> --- a/drivers/gpu/drm/panthor/panthor_devfreq.h
> +++ b/drivers/gpu/drm/panthor/panthor_devfreq.h
> @@ -8,6 +8,7 @@
>  
>  struct devfreq;
>  struct thermal_cooling_device;
> +struct platform_device;
>  
>  struct panthor_device;
>  
> @@ -43,6 +44,19 @@ struct panthor_devfreq {
>  	spinlock_t lock;
>  };
>  
> +struct panthor_devfreq_provider {
> +	/** @dev: device pointer to the provider device */
> +	struct device *dev;
> +	/**
> +	 * @init: the provider's init callback that allocates a
> +	 * &struct panthor_devfreq, adds it to panthor, and adds a devfreq
> +	 * device to panthor. Will be called during panthor's probe.
> +	 */
> +	int (*init)(struct panthor_device *ptdev, struct device *dev);
> +
> +	struct list_head node;
> +};
> +
>  
>  int panthor_devfreq_init(struct panthor_device *ptdev);
>  
> @@ -57,4 +71,6 @@ int panthor_devfreq_get_dev_status(struct device *dev,
>  
>  unsigned long panthor_devfreq_get_freq(struct panthor_device *ptdev);
>  
> +int panthor_devfreq_register_provider(struct panthor_devfreq_provider *prov);
> +
>  #endif /* __PANTHOR_DEVFREQ_H__ */
> 


