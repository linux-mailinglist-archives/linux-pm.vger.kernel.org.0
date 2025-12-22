Return-Path: <linux-pm+bounces-39776-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D41CDCD6366
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 14:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 140973045F6D
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 13:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BD0327BE7;
	Mon, 22 Dec 2025 13:43:04 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9889328248
	for <linux-pm@vger.kernel.org>; Mon, 22 Dec 2025 13:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766410984; cv=none; b=sis7Z6Un28BoRJUMn1XVVwWZOFASmrz+Fdh/oAXMxpyCwrtO5EOqkcGi5OKWFUuawxfFp9Zhu6Y6BknwrF7oHUCC0YxlcDzz7NFSMUgJZF40qpL15GCXswbJuTPc7Sum6Y5SqznxqT8XMId4hfJihkdfGRgYP4Yt+kj7btWMKwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766410984; c=relaxed/simple;
	bh=zx83YMM/Rs69+JYQjm7BnV7oovtvQh9xVVwoTU6BPw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1ccnZl4twDFB55lV1RRn0KnVreriDnRU8hW+PWvIc8oNZzYgyexovP35KEbN528Scu7qvCq7jbNGjjqsOO11bpdLLKsGfuPujOS5S0ztQqx+oCKzMsF1Jv9vTI8dMfkbYwGt/M8egOOWFJMBaARY5efx3yrW2UxQ2E/F1DkQQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2376EFEC
	for <linux-pm@vger.kernel.org>; Mon, 22 Dec 2025 05:42:55 -0800 (PST)
Received: from [169.254.77.58] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EFE3D3F778
	for <linux-pm@vger.kernel.org>; Mon, 22 Dec 2025 05:43:01 -0800 (PST)
Date: Mon, 22 Dec 2025 13:41:52 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Chen-Yu Tsai <wenst@chromium.org>, Chia-I Wu <olvaffe@gmail.com>,
	kernel@collabora.com, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 3/4] drm/panthor: Implement reading shader_present
 from nvmem
Message-ID: <aUlKoHKb084vm_p-@e142607>
References: <20251220-mt8196-shader-present-v2-0-45b1ff1dfab0@collabora.com>
 <20251220-mt8196-shader-present-v2-3-45b1ff1dfab0@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251220-mt8196-shader-present-v2-3-45b1ff1dfab0@collabora.com>

On Sat, Dec 20, 2025 at 07:49:54PM +0100, Nicolas Frattaroli wrote:
> On some platforms, notably MediaTek MT8196, the shader_present bitmask
> in the Mali GPU register for it has cores enabled that may be faulty.
> The true shader_present bitmask is found in an efuse instead.
> 
> Implement reading shader_present from an nvmem cell if one is present,
> falling back to the Mali register if it's absent. The error codes are
> trickled up through to the probe function so that probe deferral works.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_hw.c | 36 ++++++++++++++++++++++++++++++------
>  1 file changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
> index 87ebb7ae42c4..80c521784cd3 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.c
> +++ b/drivers/gpu/drm/panthor/panthor_hw.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0 or MIT
>  /* Copyright 2025 ARM Limited. All rights reserved. */
>  
> +#include <linux/nvmem-consumer.h>
>  #include <drm/drm_print.h>
>  
>  #include "panthor_device.h"
> @@ -109,7 +110,25 @@ static char *get_gpu_model_name(struct panthor_device *ptdev)
>  	return "(Unknown Mali GPU)";
>  }
>  
> -static void panthor_gpu_info_init(struct panthor_device *ptdev)
> +static int overload_shader_present(struct panthor_device *ptdev)
> +{
> +	u64 contents;
> +	int ret;
> +
> +	ret = nvmem_cell_read_variable_le_u64(ptdev->base.dev, "shader-present",
> +					      &contents);
> +	if (!ret)
> +		ptdev->gpu_info.shader_present = contents;
> +	else if (ret == -ENOENT)
> +		return 0;
> +	else
> +		return dev_err_probe(ptdev->base.dev, ret,
> +				     "Failed to read shader-present nvmem cell\n");
> +
> +	return 0;
> +}
> +
> +static int panthor_gpu_info_init(struct panthor_device *ptdev)
>  {
>  	unsigned int i;
>  
> @@ -143,13 +162,18 @@ static void panthor_gpu_info_init(struct panthor_device *ptdev)
>  		ptdev->gpu_info.tiler_present = gpu_read64(ptdev, GPU_TILER_PRESENT);
>  		ptdev->gpu_info.l2_present = gpu_read64(ptdev, GPU_L2_PRESENT);
>  	}
> +
> +	return overload_shader_present(ptdev);
>  }
>  
> -static void panthor_hw_info_init(struct panthor_device *ptdev)
> +static int panthor_hw_info_init(struct panthor_device *ptdev)
>  {
>  	u32 major, minor, status;
> +	int ret;
>  
> -	panthor_gpu_info_init(ptdev);
> +	ret = panthor_gpu_info_init(ptdev);
> +	if (ret)
> +		return ret;
>  
>  	major = GPU_VER_MAJOR(ptdev->gpu_info.gpu_id);
>  	minor = GPU_VER_MINOR(ptdev->gpu_info.gpu_id);
> @@ -172,6 +196,8 @@ static void panthor_hw_info_init(struct panthor_device *ptdev)
>  		 "shader_present=0x%0llx l2_present=0x%0llx tiler_present=0x%0llx",
>  		 ptdev->gpu_info.shader_present, ptdev->gpu_info.l2_present,
>  		 ptdev->gpu_info.tiler_present);
> +
> +	return 0;
>  }
>  
>  static int panthor_hw_bind_device(struct panthor_device *ptdev)
> @@ -218,7 +244,5 @@ int panthor_hw_init(struct panthor_device *ptdev)
>  	if (ret)
>  		return ret;
>  
> -	panthor_hw_info_init(ptdev);
> -
> -	return 0;
> +	return panthor_hw_info_init(ptdev);
>  }
> 
> -- 
> 2.52.0
> 

