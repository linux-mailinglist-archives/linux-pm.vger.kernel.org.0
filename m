Return-Path: <linux-pm+bounces-36465-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80458BF1A06
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 15:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F045B188AF36
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 13:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E0131AF15;
	Mon, 20 Oct 2025 13:47:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6ED2C21F7;
	Mon, 20 Oct 2025 13:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760968060; cv=none; b=nSg8Lijp8sLeEjWxEmaCyScYtv0gvEeHIx1OOc/0R/jQEdJK8anyVgSk9K+V646jMQWzxsCnHoNdlAgfIa05PRDbKlGADH2BsK1cx8L7ANQO4cVHjA+a8a0Fl/7N/hOkipfgi7gDXWqVQJz0fgZ5mtbarxjCpudqtSyVzEEhsL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760968060; c=relaxed/simple;
	bh=7xW28T3apWZwrY81wJCRu3IdXgTZGX/t1f963bLJQoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eKYxnZVpuEFDxzFKkvmp6pHCSAdVQIkBCy8zmz/ZFhtqwhxLtr2ED3/u8ujrv6Eh148GgT4AcDmqF9y7FLO/v0ZNVZn291bWGd7NLlxK2+XjxtovGntzaN+eON7+WN1EdaqR1o3UU0Xw3Z8Fh8CMUKsUKnKMmQOmmBxcrOBJDoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FCBA16A3;
	Mon, 20 Oct 2025 06:47:30 -0700 (PDT)
Received: from [10.57.36.117] (unknown [10.57.36.117])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF81F3F66E;
	Mon, 20 Oct 2025 06:47:32 -0700 (PDT)
Message-ID: <ef6434a9-cde5-4d68-a3a3-1873ba7912d3@arm.com>
Date: Mon, 20 Oct 2025 14:47:30 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/5] drm/panthor: Use existing OPP table if present
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Jassi Brar <jassisinghbrar@gmail.com>, Chia-I Wu <olvaffe@gmail.com>,
 Chen-Yu Tsai <wenst@chromium.org>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-hardening@vger.kernel.org, linux-pm@vger.kernel.org
References: <20251017-mt8196-gpufreq-v8-0-98fc1cc566a1@collabora.com>
 <20251017-mt8196-gpufreq-v8-4-98fc1cc566a1@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20251017-mt8196-gpufreq-v8-4-98fc1cc566a1@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/10/2025 16:31, Nicolas Frattaroli wrote:
> On SoCs where the GPU's power-domain is in charge of setting performance
> levels, the OPP table of the GPU node will have already been populated
> during said power-domain's attach_dev operation.
> 
> To avoid initialising an OPP table twice, only set the OPP regulator and
> the OPPs from DT if there's no OPP table present.
> 
> Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panthor/panthor_devfreq.c | 32 ++++++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.c b/drivers/gpu/drm/panthor/panthor_devfreq.c
> index a6dca599f0a5..ec63e27f4883 100644
> --- a/drivers/gpu/drm/panthor/panthor_devfreq.c
> +++ b/drivers/gpu/drm/panthor/panthor_devfreq.c
> @@ -141,6 +141,7 @@ int panthor_devfreq_init(struct panthor_device *ptdev)
>  	struct thermal_cooling_device *cooling;
>  	struct device *dev = ptdev->base.dev;
>  	struct panthor_devfreq *pdevfreq;
> +	struct opp_table *table;
>  	struct dev_pm_opp *opp;
>  	unsigned long cur_freq;
>  	unsigned long freq = ULONG_MAX;
> @@ -152,17 +153,30 @@ int panthor_devfreq_init(struct panthor_device *ptdev)
>  
>  	ptdev->devfreq = pdevfreq;
>  
> -	ret = devm_pm_opp_set_regulators(dev, reg_names);
> -	if (ret && ret != -ENODEV) {
> -		if (ret != -EPROBE_DEFER)
> -			DRM_DEV_ERROR(dev, "Couldn't set OPP regulators\n");
> -		return ret;
> +	/*
> +	 * The power domain associated with the GPU may have already added an
> +	 * OPP table, complete with OPPs, as part of the platform bus
> +	 * initialization. If this is the case, the power domain is in charge of
> +	 * also controlling the performance, with a set_performance callback.
> +	 * Only add a new OPP table from DT if there isn't such a table present
> +	 * already.
> +	 */
> +	table = dev_pm_opp_get_opp_table(dev);
> +	if (IS_ERR_OR_NULL(table)) {
> +		ret = devm_pm_opp_set_regulators(dev, reg_names);
> +		if (ret && ret != -ENODEV) {
> +			if (ret != -EPROBE_DEFER)
> +				DRM_DEV_ERROR(dev, "Couldn't set OPP regulators\n");
> +			return ret;
> +		}
> +
> +		ret = devm_pm_opp_of_add_table(dev);
> +		if (ret)
> +			return ret;
> +	} else {
> +		dev_pm_opp_put_opp_table(table);
>  	}
>  
> -	ret = devm_pm_opp_of_add_table(dev);
> -	if (ret)
> -		return ret;
> -
>  	spin_lock_init(&pdevfreq->lock);
>  
>  	panthor_devfreq_reset(pdevfreq);
> 


