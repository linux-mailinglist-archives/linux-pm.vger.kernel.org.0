Return-Path: <linux-pm+bounces-36486-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D46BF292B
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 18:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1CB974F7C66
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 16:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8301232AAD6;
	Mon, 20 Oct 2025 16:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SNT0ptMz"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CE92638BF
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979557; cv=none; b=ugpnLiHnUcp+RZBKrOXicBM8KahaXkaPsFnDDHLZTEuqL2URBuoD3FlvJyJMXr7KhPus/hoIGXV3x17ieNa53FH6RrId6P6rK96del+VGq2efKhG+2PjZpsT6gNGS1lHVMJOIrYs3GqpU++nTKMTZjCQ2ELtP63zkqUs99Gyft4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979557; c=relaxed/simple;
	bh=YfnKeMKwhtaKKkpqNf8xO08h+LVL7gFtv+Wvu1LExHw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ODNeB2DmsYsqI6NB+Ptx9r5MRefAYdMq1vLwWuLZWNr1Nj2uFygjBr8hYjmo8pfkGzKtPCKVOjW3E/wN29WoKMtKQLubNktIHP5GtzodMdrlD//JuLnVqPDxhT6Okmxc7+VgfagAua16wxn9jX4VW97IQuj0Yj4jDhboE+oa+4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SNT0ptMz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760979553;
	bh=YfnKeMKwhtaKKkpqNf8xO08h+LVL7gFtv+Wvu1LExHw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=SNT0ptMzU1hGPApmR8M2TMZlhqbcmlE0R5tihYF3NoQci7wE9LRQuAH/CTyInqqag
	 yUEws0h2RGdw94IQxdbHwqE74XZHVVGHnp4Zv5ns1BgKumAuICW5z4lnn8WPtgYvnh
	 XYtNsVNxc5V300f3zZqN3PrfY8J3J3fCR/EDUEgCrEvQXIIZjDsvjzEb14EM5T1ARM
	 HcBiBs7kRemcyb96M8jDvEbW/g8OVac773ez7B1loYim1vXepQwJvVqd8ngudI09gt
	 yQhNhmwP+QPZRGHSpzw3RCt+Zh8M4VmIlNT6cOuVlc593aoFEhqkYRnbgRzxBsun5w
	 expjkHJGVndEg==
Received: from [192.168.200.105] (unknown [182.181.201.194])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3D02917E1278;
	Mon, 20 Oct 2025 18:59:10 +0200 (CEST)
Message-ID: <f710ff00-096b-4d88-8e39-dcde29098d40@collabora.com>
Date: Mon, 20 Oct 2025 21:59:04 +0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@collabora.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
Subject: Re: [RFC 3/3] drm/amd: Return -EBUSY for amdgpu_pmops_thaw() on
 success
To: "Mario Limonciello (AMD)" <superm1@kernel.org>,
 mario.limonciello@amd.com, airlied@gmail.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, dakr@kernel.org, gregkh@linuxfoundation.org,
 lenb@kernel.org, pavel@kernel.org, rafael@kernel.org, simona@ffwll.ch
References: <20251020165317.3992933-1-superm1@kernel.org>
 <20251020165317.3992933-4-superm1@kernel.org>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20251020165317.3992933-4-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 9:50 PM, Mario Limonciello (AMD) wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> The PM core should be notified that thaw was skipped for the device
> so that if it's tried to be resumed (such as an aborted hibernate)
> that it gets another chance to resume.
> 
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 61268aa82df4d..d40af069f24dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2681,7 +2681,7 @@ static int amdgpu_pmops_thaw(struct device *dev)
>  
>  	/* do not resume device if it's normal hibernation */
>  	if (!pm_hibernate_is_recovering() && !pm_hibernation_mode_is_suspend())
> -		return 0;
> +		return -EBUSY;
>  
>  	return amdgpu_device_resume(drm_dev, true);
>  }


-- 
---
Thanks,
Usama

