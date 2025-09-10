Return-Path: <linux-pm+bounces-34368-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E552B51891
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 15:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD8354E35FA
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 13:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB2032142A;
	Wed, 10 Sep 2025 13:59:17 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5672C11E1;
	Wed, 10 Sep 2025 13:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757512757; cv=none; b=QkEkmeuDRnZK10a/cL/0zB5sA1fFzzqOcPIsD/kycfMJU+LtgVf+29i2xmu/UUgujSVB/NCn5BW0ADmmcmLuJCLwQ1dVKLlNM3w5KObobaBUjf5LWAa9/Si0KPumSdPYjDGylNgfsSctpKgxJTL0qaTbikOz/Ext/jLQskzILas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757512757; c=relaxed/simple;
	bh=U2M+U984KmuW7sRJRH5OzGeyEOOiedqI2X7Dze9Zj1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kr44hMauKm6IDuBQP9CidNSlAYD86REf4XETcB02PRlbRy/bu2BH5UnLYXYYa+rTXehoEAiHs1RKc+lk1ZTBh99fk2W1Um08H0KQKTZqc1AZ9lCNoYLRpyvn0t5tnBvh1JDVnZ5wM53ak1s+z1dHI/UjhTU+QUpw32stAyoKsHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93C7116F8;
	Wed, 10 Sep 2025 06:59:06 -0700 (PDT)
Received: from [10.1.25.55] (e122027.cambridge.arm.com [10.1.25.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C10343F694;
	Wed, 10 Sep 2025 06:59:09 -0700 (PDT)
Message-ID: <3da64b80-ecdc-4b86-a4ca-3b4a9d75d9c4@arm.com>
Date: Wed, 10 Sep 2025 14:59:02 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 07/10] drm/panthor: move panthor_devfreq struct to
 header
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
 <20250905-mt8196-gpufreq-v1-7-7b6c2d6be221@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250905-mt8196-gpufreq-v1-7-7b6c2d6be221@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/09/2025 11:23, Nicolas Frattaroli wrote:
> In order to make files other than panthor_devfreq.c be able to touch the
> members of a panthor_devfreq instance, it needs to live somewhere other
> than the .c file.
> 
> Move it into the panthor_devfreq.h header, so that the upcoming MediaTek
> MFG devfreq can use it as well.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panthor/panthor_devfreq.c | 32 ---------------------------
>  drivers/gpu/drm/panthor/panthor_devfreq.h | 36 ++++++++++++++++++++++++++++++-
>  2 files changed, 35 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.c b/drivers/gpu/drm/panthor/panthor_devfreq.c
> index 8903f60c0a3f06313ac2008791c210ff32b6bd52..02eb3ca15d1874e1cbafc6b614b196c5cc75b6a1 100644
> --- a/drivers/gpu/drm/panthor/panthor_devfreq.c
> +++ b/drivers/gpu/drm/panthor/panthor_devfreq.c
> @@ -12,38 +12,6 @@
>  #include "panthor_devfreq.h"
>  #include "panthor_device.h"
>  
> -/**
> - * struct panthor_devfreq - Device frequency management
> - */
> -struct panthor_devfreq {
> -	/** @devfreq: devfreq device. */
> -	struct devfreq *devfreq;
> -
> -	/** @gov_data: Governor data. */
> -	struct devfreq_simple_ondemand_data gov_data;
> -
> -	/** @busy_time: Busy time. */
> -	ktime_t busy_time;
> -
> -	/** @idle_time: Idle time. */
> -	ktime_t idle_time;
> -
> -	/** @time_last_update: Last update time. */
> -	ktime_t time_last_update;
> -
> -	/** @last_busy_state: True if the GPU was busy last time we updated the state. */
> -	bool last_busy_state;
> -
> -	/**
> -	 * @lock: Lock used to protect busy_time, idle_time, time_last_update and
> -	 * last_busy_state.
> -	 *
> -	 * These fields can be accessed concurrently by panthor_devfreq_get_dev_status()
> -	 * and panthor_devfreq_record_{busy,idle}().
> -	 */
> -	spinlock_t lock;
> -};
> -
>  static void panthor_devfreq_update_utilization(struct panthor_devfreq *pdevfreq)
>  {
>  	ktime_t now, last;
> diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.h b/drivers/gpu/drm/panthor/panthor_devfreq.h
> index f8e29e02f66cb3281ed4bb4c75cda9bd4df82b92..e8b5ccddd45c52ee3215e9c84c6ebd9109640282 100644
> --- a/drivers/gpu/drm/panthor/panthor_devfreq.h
> +++ b/drivers/gpu/drm/panthor/panthor_devfreq.h
> @@ -4,11 +4,45 @@
>  #ifndef __PANTHOR_DEVFREQ_H__
>  #define __PANTHOR_DEVFREQ_H__
>  
> +#include <linux/devfreq.h>
> +
>  struct devfreq;
>  struct thermal_cooling_device;
>  
>  struct panthor_device;
> -struct panthor_devfreq;
> +
> +/**
> + * struct panthor_devfreq - Device frequency management
> + */
> +struct panthor_devfreq {
> +	/** @devfreq: devfreq device. */
> +	struct devfreq *devfreq;
> +
> +	/** @gov_data: Governor data. */
> +	struct devfreq_simple_ondemand_data gov_data;
> +
> +	/** @busy_time: Busy time. */
> +	ktime_t busy_time;
> +
> +	/** @idle_time: Idle time. */
> +	ktime_t idle_time;
> +
> +	/** @time_last_update: Last update time. */
> +	ktime_t time_last_update;
> +
> +	/** @last_busy_state: True if the GPU was busy last time we updated the state. */
> +	bool last_busy_state;
> +
> +	/**
> +	 * @lock: Lock used to protect busy_time, idle_time, time_last_update and
> +	 * last_busy_state.
> +	 *
> +	 * These fields can be accessed concurrently by panthor_devfreq_get_dev_status()
> +	 * and panthor_devfreq_record_{busy,idle}().
> +	 */
> +	spinlock_t lock;
> +};
> +
>  
>  int panthor_devfreq_init(struct panthor_device *ptdev);
>  
> 


