Return-Path: <linux-pm+bounces-35272-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5985EB998BA
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 13:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50DC23B7E05
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 11:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8DE2E6CAF;
	Wed, 24 Sep 2025 11:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FqQDe9Eo"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE742E62D4;
	Wed, 24 Sep 2025 11:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758712287; cv=none; b=TXktnSEAIg2K4vqEJa2BXQOx1XzvMQk1ErWuDNheX6cp+SSYgSlbcqpT6iCpQtNkS7/DWfDUkC27P2erpgs110tjYxXQJ1EUMJHUZ7sUuQdwpkO46va4NEjqYub4NXQ26szfTB/AYFKQPGfLDXfElwvljdiskxz7316KBf5GfaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758712287; c=relaxed/simple;
	bh=5GT6jnvxYjStCKgCq5+Wz35bOeICFGv9mfyP8q18sGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B/wDd7myviC6ZmFC+qLl/J3CSfX3XHxueGGQDlpchjglcFqe1M3LqDo4fFX1fEGnhZjx4eEoOm63YNKKNzLGoP5oJ9Np+o317HAzb8faKb24VnPc42vd64LFsWVLEmfEPUpmQuRZwnmeZmWIiWK3h0BsXpg3TcUEf4x7Ww7ecMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FqQDe9Eo; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758712280;
	bh=5GT6jnvxYjStCKgCq5+Wz35bOeICFGv9mfyP8q18sGI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FqQDe9Eo+x/xmzaI1BbvECmNJw21c6MO2jBjAvmTpblE+Q+gR1a9m8bHeSohkfPxj
	 MO41XNvHtQL2w4W11nwUdY0Nr1MJdNMeIGtrXpLKX7GHdpypxk+Ou/HFM8bHfcxxrj
	 uXhBevqAezWCIkkpqVmmMO3MjODu92EXK/HpMh2p+E2zODc79juhktSXrlDn0KXdS+
	 99EW6jPyZBRIlfG9dLatj36vySf7eRYi8Rj+9R6ci5HePQJ+4ugKXyRN7WLn4bw9YG
	 fbNlzUAHdg1+DwFRIc8uJw+GuiCaB0cgmA7v+5JbFLvUddHPegEoX6Dv6p5VxOi4kN
	 4mHxFqTQ23HSw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 25D9117E068C;
	Wed, 24 Sep 2025 13:11:19 +0200 (CEST)
Message-ID: <5fb4a548-4dc4-4964-975f-675541c4b728@collabora.com>
Date: Wed, 24 Sep 2025 13:11:18 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] Add thermal sensor driver support for Mediatek
 MT8196
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
References: <20250804133035.309990-1-laura.nao@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250804133035.309990-1-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 04/08/25 15:30, Laura Nao ha scritto:
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

Whole series is both

Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> 
#MT8196 Chromebook

and is also

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

...and besides, this got also tested on MT8188/95 in our lab (for quite a while).

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




