Return-Path: <linux-pm+bounces-36883-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28025C0CF59
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 11:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 54FA94E6491
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 10:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818792F690B;
	Mon, 27 Oct 2025 10:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aZZlNJof"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A942F3C3D;
	Mon, 27 Oct 2025 10:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761560913; cv=none; b=bqGEGUC66NEx5Q7lecwE7fCJhHQwtzrpyFRwHcClJX5I1jEABSQgVSu0yVnnLFJYkjvD3pM2BQrSJNi7oOzc944xvqNHU+iIt9kaO1YLR+0p3IPdVRsjpbYENiQyJW2MILyA7U/UMXGcXlzbjd+f3hYYzBGGXKx5enIm4Pt2dHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761560913; c=relaxed/simple;
	bh=80A5WGzXwOBAEhYFN6darwmjlsAVc8wuGY5F609g7q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gkbi2y8/ED/oTFl8aj8+aUV4no/OZvhaQx8Hco0zrdtUsUNMIscSFEvwgxBt/J4YeBOHU3El2ub4yg6oDTfENaRNPg1cz5rWIpgA0acanbiUgvqlljfEapWDYnhiyvlHfV5oDQO0ORTA+QAsRqKNKFZJw9PuevS5wIRIiaO510U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aZZlNJof; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761560908;
	bh=80A5WGzXwOBAEhYFN6darwmjlsAVc8wuGY5F609g7q4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aZZlNJof71hPdQNaI1GKLmACWl8FA8kgZfqROQqPUpXu5eCCn03YIcePo/4oBB11c
	 KEsELY43p8d+Mz1tsz3cz/j9v7oxNWFx3c8nUCIaI/VG6iMJ3ieBTIKP0caEr5vrk9
	 +MQ2ccGqkOsBl6uNiB5ZOHvCTAB90Cmhc9DI/4A1cmmbatp3OOGisVd8orYyw9CmM+
	 dMSdbEUqPES4LhcGhTtXGhnxbQH7bOE6twHtMiBXEKk8sJm2BVDNDcZbaN5rvRF6gK
	 63L5ATtY1XTYWJ+2S3eYOsM4uklK/tg9pc5PE0a/SiHaFoAJXTQJh9ILrL1ToS5Sqa
	 CUKaHUhlUsksQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8333617E10F4;
	Mon, 27 Oct 2025 11:28:27 +0100 (CET)
Message-ID: <dc619e4b-78fc-4306-8aa0-83d8d87a11cf@collabora.com>
Date: Mon, 27 Oct 2025 11:28:27 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 0/9] Add thermal sensor driver support for
 Mediatek MT8196
To: Laura Nao <laura.nao@collabora.com>, srini@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, rafael@kernel.org,
 daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
 matthias.bgg@gmail.com
Cc: nfraprado@collabora.com, arnd@arndb.de, colin.i.king@gmail.com,
 u.kleine-koenig@baylibre.com, andrew-ct.chen@mediatek.com,
 lala.lin@mediatek.com, bchihi@baylibre.com, frank-w@public-files.de,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20251016142158.740242-1-laura.nao@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251016142158.740242-1-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/10/25 16:21, Laura Nao ha scritto:
> This patch series extends the MediaTek LVTS thermal driver to support the
> MT8196 SoC.
> 
> MT8196 requires a different implementation of the lvts_temp_to_raw()
> function.
> 
> To support this, the series introduces:
> 
> - A new struct lvts_platform_ops to allow platform-specific
>    conversion logic between raw sensor values and temperature
> - A variant of the lvts_temp_to_raw() implementation
> - Platform data and controller definitions for MT8196
> 
> Link to v2: https://lore.kernel.org/all/20250730152128.311109-1-laura.nao@collabora.com/
> 
> Changes in v3:
> - Make ops in struct lvts_data a pointer to const struct lvts_platform_ops
> - Changed mediatek,mt8188-efuse const entry in eFuse binding to an enum
> with mediatek,mt8196-efuse and mediatek,mt8188-efuse, dropped mediatek,mt8196-efuse
> const entry
> 

I think this series is ready to be picked.

Please don't let this slip through the cracks.

Regards,
Angelo

> Laura Nao (9):
>    dt-bindings: thermal: mediatek: Add LVTS thermal controller support
>      for MT8196
>    thermal/drivers/mediatek/lvts: Make number of calibration offsets
>      configurable
>    thermal/drivers/mediatek/lvts: Guard against zero temp_factor in
>      lvts_raw_to_temp
>    thermal: mediatek: lvts: Add platform ops to support alternative
>      conversion logic
>    thermal/drivers/mediatek/lvts: Add lvts_temp_to_raw variant
>    thermal/drivers/mediatek/lvts: Add support for ATP mode
>    thermal/drivers/mediatek/lvts: Support MSR offset for 16-bit
>      calibration data
>    thermal/drivers/mediatek/lvts_thermal: Add MT8196 support
>    dt-bindings: nvmem: mediatek: efuse: Add support for MT8196
> 
>   .../bindings/nvmem/mediatek,efuse.yaml        |   4 +-
>   .../thermal/mediatek,lvts-thermal.yaml        |   2 +
>   drivers/thermal/mediatek/lvts_thermal.c       | 305 ++++++++++++++++--
>   .../thermal/mediatek,lvts-thermal.h           |  26 ++
>   4 files changed, 314 insertions(+), 23 deletions(-)
> 


