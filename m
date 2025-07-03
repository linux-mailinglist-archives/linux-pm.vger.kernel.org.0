Return-Path: <linux-pm+bounces-30017-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6F2AF6FE8
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 12:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F7CD7AB470
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 10:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC072E172C;
	Thu,  3 Jul 2025 10:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UMvZTPf5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811262E2EED
	for <linux-pm@vger.kernel.org>; Thu,  3 Jul 2025 10:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751538108; cv=none; b=Ldkd/EQXaDjn5fpQVSbcIDsWj83vbdxIIXaYiwPZcDRK1yprM1WwyWEA/idXVgNfPQ+Rn6M14MxFumaMoUTxfrOrsm8gzA21TsWV6wtmPiE9gXzDi+4ykHfteQegfxsScSBXq/P6VTHAJFfB+XvcZ4Fs7RsDiCS6Iy0/bGIGB3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751538108; c=relaxed/simple;
	bh=XexxHMorXGwQYFT4LewShysFN8Ru8ThU14NlLP6LrT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=tvsxe7wW6d6cwCh9N6W4arkKl0f1k03WLHheSpDRv8tWFM8i+iajElAFhWIt4GNEwwmSvnmxHdVJ5XadfDlTo4vKbiE6Gq+SRrnDVQcDMdXJ5MLnWqb4pUW8w9kRvtyQg0Ejd0aCWFtA4JZVaF7LNxi+596b+s7G/zxI9GEPuoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=UMvZTPf5; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250703102143euoutp02a7cdcc387ebca25f590a891368326d00~OtqAUDIdc0561505615euoutp02F
	for <linux-pm@vger.kernel.org>; Thu,  3 Jul 2025 10:21:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250703102143euoutp02a7cdcc387ebca25f590a891368326d00~OtqAUDIdc0561505615euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751538103;
	bh=nS7gGLPcYu431wACYDIpnQCjfgmdMYV2m+06WEOimxI=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=UMvZTPf5MFlYbVthTszDlaAh2NyGedz2J80TIqan8EPLEip18Xoe//ExhI+DzeMZ7
	 Y414rsSATVtoYPH/HyaGIRHkKHOIJbBL0jjLdx0Ln3JoUL8WtRta+WIHlpziSIfn4m
	 j5SnuJeiSMBtJPx9MMOL0WQSQXWRykSbsz9ilvEw=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250703102143eucas1p273c64519df9ebb05e9b3a7d9a38ad341~Otp-qSogJ1836718367eucas1p2p;
	Thu,  3 Jul 2025 10:21:43 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250703102141eusmtip2ab7c1f9865f3ac73941aa40cc36a67b8~Otp_moHuq2747427474eusmtip20;
	Thu,  3 Jul 2025 10:21:41 +0000 (GMT)
Message-ID: <fa235fa1-d5ad-44b7-bf52-068ea41fc9ea@samsung.com>
Date: Thu, 3 Jul 2025 12:21:41 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/5] drm/imagination: Use pwrseq for TH1520 GPU power
 management
To: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Philipp Zabel
	<p.zabel@pengutronix.de>, Frank Binns <frank.binns@imgtec.com>, Matt Coster
	<matt.coster@imgtec.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>, Ulf Hansson <ulf.hansson@linaro.org>, Marek
	Szyprowski <m.szyprowski@samsung.com>, Drew Fustini <fustini@kernel.org>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	dri-devel@lists.freedesktop.org, Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <20250626-apr_14_for_sending-v7-1-6593722e0217@samsung.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250703102143eucas1p273c64519df9ebb05e9b3a7d9a38ad341
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250626093356eucas1p1adfcd565173d939f82e15252189c316f
X-EPHeader: CA
X-CMS-RootMailID: 20250626093356eucas1p1adfcd565173d939f82e15252189c316f
References: <20250626-apr_14_for_sending-v7-0-6593722e0217@samsung.com>
	<CGME20250626093356eucas1p1adfcd565173d939f82e15252189c316f@eucas1p1.samsung.com>
	<20250626-apr_14_for_sending-v7-1-6593722e0217@samsung.com>



On 6/26/25 11:33, Michal Wilczynski wrote:
> Update the Imagination PVR DRM driver to leverage the pwrseq framework
> for managing the complex power sequence of the GPU on the T-HEAD TH1520
> SoC.
> 
> To cleanly separate platform specific logic from the generic driver,
> this patch introduces a `pwr_power_sequence_ops` struct containing
> function pointers for power_on and power_off operations. This allows for
> different power management strategies to be selected at probe time based
> on the device's compatible string.
> 
> A `pvr_device_data` struct, associated with each compatible in the
> of_device_id table, points to the appropriate ops table (manual or
> pwrseq).
> 
> At probe time, the driver inspects the assigned ops struct. If the
> pwrseq variant is detected, the driver calls
> devm_pwrseq_get("gpu-power"), deferring probe if the sequencer is not
> yet available. Otherwise, it falls back to the existing manual clock and
> reset handling. The runtime PM callbacks now call the appropriate
> functions via the ops table.
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  drivers/gpu/drm/imagination/pvr_device.c |  36 +++++++-
>  drivers/gpu/drm/imagination/pvr_device.h |  17 ++++
>  drivers/gpu/drm/imagination/pvr_drv.c    |  27 +++++-
>  drivers/gpu/drm/imagination/pvr_power.c  | 139 ++++++++++++++++++++++---------
>  drivers/gpu/drm/imagination/pvr_power.h  |  13 +++
>  5 files changed, 185 insertions(+), 47 deletions(-)
> 

Hi,

I'm checking in on the status of my pwrseq patch above. Is this on track
for the next merge window?

Please let me know if there's anything else needed from my end to help
get it ready.

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

