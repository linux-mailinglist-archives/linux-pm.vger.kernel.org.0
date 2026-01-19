Return-Path: <linux-pm+bounces-41085-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DA5D3A829
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 13:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A37C4306C56B
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 12:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA90359F80;
	Mon, 19 Jan 2026 12:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CV6DrZSq"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8AB3191C0;
	Mon, 19 Jan 2026 12:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768824421; cv=none; b=dntsQ/1sEwSwXYeb1slsLU/VEw5MPPlXpTmKr4Lhld1J0cy+Oe93LbwIJLjb8S7Df1OOWo3Bg4JaCD5ja+QhJyfxq+ebR+p3fsXJSe0aDQD1CypM3om7xnklObxq4ASafeditHOlKqA0qM9IHw/25DVJ5Kt/lQAG+WnRzRcw0Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768824421; c=relaxed/simple;
	bh=smVe+F+p92Be8MNVffomnHhZ2pZhHkzY+FZJ7CSclQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lnvy5ZXcUSsAu+ocbZ3kPyXrU+g41Cs5tCzc7p1lqo8o29rHmNrn6jA7mU0/6LHZZF4IW6WIb0+zVrND28weFOsp7gF3BQM3MCsWuph2zG9g0cKQmA2B4lwLmQkznH+aHI+pezrjvMNQPDqqlArqQoYU8k1ooPP3P3lxIKAlOOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CV6DrZSq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1768824418;
	bh=smVe+F+p92Be8MNVffomnHhZ2pZhHkzY+FZJ7CSclQg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CV6DrZSqcyK5ZOXYaeoQ85nbfdM5QNTKFFe1B2KXkwrbpd1uUI5xj3MY8l92dPpJ/
	 u5DumxeRFkwLCBpI2VQav5oJ1tzrg6uxE0E6X/pRUGJKSYwSH+De5OGcsy+N4oXUfP
	 xKvfudI8qG0tPcmrH0hLtFDsZCbFQgA0n7DY8mayhXeurlFB+Z2Uy4B38HoVmW4sy8
	 TWhr5B3lf619G17o2buhd+X/p8tBcu7jrhoWxGSQs2ML48m4vl3WsydNUhwtUYLMx2
	 8CuQryJ7ZEE1nOOeqI4D0K8DIkvn2HXl+yvCGTjXsXpK1S9Wt8n26FGMyBYIS2ViMr
	 RE+M1dURETQ8Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D8EFF17E0117;
	Mon, 19 Jan 2026 13:06:57 +0100 (CET)
Message-ID: <382ef406-6abf-4d6f-9f0c-42b0bbbd6918@collabora.com>
Date: Mon, 19 Jan 2026 13:06:57 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] Add thermal sensor driver support for Mediatek
 MT8196
To: srini@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
 rui.zhang@intel.com, lukasz.luba@arm.com, matthias.bgg@gmail.com
Cc: nfraprado@collabora.com, arnd@arndb.de, colin.i.king@gmail.com,
 u.kleine-koenig@baylibre.com, andrew-ct.chen@mediatek.com,
 lala.lin@mediatek.com, bchihi@baylibre.com, frank-w@public-files.de,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, kernel@collabora.com,
 wenst@chromium.org, fshao@chromium.org, Laura Nao <laura.nao@collabora.com>
References: <20251125-mt8196-lvts-v4-v5-0-6db7eb903fb7@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251125-mt8196-lvts-v4-v5-0-6db7eb903fb7@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/11/25 17:16, Laura Nao ha scritto:
> This patch series extends the MediaTek LVTS thermal driver to support the
> MT8196 SoC.
> 

This series has been there on the lists for *5 months* now, and it still
applies as-is.

Can we *please* get this picked?

Thanks,
Angelo

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
> Link to v4: https://lore.kernel.org/r/20251121-mt8196-lvts-v4-v4-0-357f955a3176@collabora.com
> 
> Changes in v5:
> - Dropped patch 3
> - Added LVTS_NUM_CAL_OFFSETS_MT7988/LVTS_NUM_CAL_OFFSETS_MT8196 defines
> - Moved code that assembles calibration bytes from the efuse data into
>    a dedicated lvts_decode_sensor_calibration() helper
> - Fixed prefix in patch 4 commit message
> - Dropped R-b/T-b tags on patch 2
> 
> ---
> Laura Nao (8):
>        dt-bindings: thermal: mediatek: Add LVTS thermal controller support for MT8196
>        thermal/drivers/mediatek/lvts: Make number of calibration offsets configurable
>        thermal/drivers/mediatek/lvts: Add platform ops to support alternative conversion logic
>        thermal/drivers/mediatek/lvts: Add lvts_temp_to_raw variant
>        thermal/drivers/mediatek/lvts: Add support for ATP mode
>        thermal/drivers/mediatek/lvts: Support MSR offset for 16-bit calibration data
>        thermal/drivers/mediatek/lvts_thermal: Add MT8196 support
>        dt-bindings: nvmem: mediatek: efuse: Add support for MT8196
> 
>   .../devicetree/bindings/nvmem/mediatek,efuse.yaml  |   1 +
>   .../bindings/thermal/mediatek,lvts-thermal.yaml    |   2 +
>   drivers/thermal/mediatek/lvts_thermal.c            | 326 +++++++++++++++++++--
>   .../dt-bindings/thermal/mediatek,lvts-thermal.h    |  26 ++
>   4 files changed, 333 insertions(+), 22 deletions(-)
> ---
> base-commit: abadc219d77ce0e61fcac0147cc6cc69164af43e
> change-id: 20251121-mt8196-lvts-v4-a61fb5c27216
> 
> Best regards,


