Return-Path: <linux-pm+bounces-38365-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F0BC791B7
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 14:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DD0AF36451A
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 13:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C031D6DB5;
	Fri, 21 Nov 2025 13:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qR8YYg9a"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84E41C84CB;
	Fri, 21 Nov 2025 13:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763730034; cv=none; b=herd4iXubilc3wgqo5o1ZeOKRYEr48DoJo8gnIAttWW9HrJKIcLysYwr5mBwp+uOjxDMHLx5PoXp2ax7LV6Uz0LmQGbwWBELr8Zuckz8H7nsTdHN5VcYFTyqdd6ekTUTsejTD9MsijJpCHGp0CcO5MpKTT/5BZ0okyrPUD3HAHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763730034; c=relaxed/simple;
	bh=l+liJeHp0JkLlcj+7/9/4BqCexY09/RYvw3Uz3/qIX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dlA21FFVhIonweq1h+oXyN065cIOp1hX5o1kyW6cgNDpidKsqsIOYNmDIsEwUQXXlVgLD1nX29hEphxQCx51UhhL+2+pjlCkx84w0qTQO9e7Pb1GhTQCyltnlQ/W283dJ2WX9/bL3fZvpdLOZeVyQlTasjMnSXI9c56VMdudaz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qR8YYg9a; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1763730030;
	bh=l+liJeHp0JkLlcj+7/9/4BqCexY09/RYvw3Uz3/qIX8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qR8YYg9avpuPHoD1vt/phejYpeMFiuCav/44bcWP07kFaS6Zaq+l/++kBCzpHhQQE
	 BBkzZv2aUe+G7xBCNotgAFVaNcntSqi/LO2OrT9bHyQfqsvc5u98YlkragcAsbeBof
	 H4vpYAxrJpxJXwXu90oQ8CUE61Qm3swXuv5X2cQy1e1R3kkjf9QJB88TFUAvvWdrUc
	 OvAhUQhIqV8f0WiIff0MAbRpYpj5gFlvOe2/aKJLNBNwASr6x2OpKktLqcDT/hCQeQ
	 boVZwKoAuAUEIhgx/Os69bCCkin9qKPsIkhq1XvvqPDPxxNL4EfRGZZORs4J2Hc3lf
	 8y/VEVTNovyvQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7A81117E05BE;
	Fri, 21 Nov 2025 14:00:29 +0100 (CET)
Message-ID: <acfc088f-7c54-4281-b816-a5f2eca23ecf@collabora.com>
Date: Fri, 21 Nov 2025 14:00:29 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/9] thermal/drivers/mediatek/lvts: Fail probe if
 temp_factor is zero
To: Laura Nao <laura.nao@collabora.com>, srini@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, rafael@kernel.org,
 daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
 matthias.bgg@gmail.com
Cc: nfraprado@collabora.com, arnd@arndb.de, colin.i.king@gmail.com,
 u.kleine-koenig@baylibre.com, andrew-ct.chen@mediatek.com,
 lala.lin@mediatek.com, bchihi@baylibre.com, frank-w@public-files.de,
 wenst@chromium.org, fshao@chromium.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com
References: <20251121-mt8196-lvts-v4-v4-0-357f955a3176@collabora.com>
 <20251121-mt8196-lvts-v4-v4-3-357f955a3176@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251121-mt8196-lvts-v4-v4-3-357f955a3176@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 21/11/25 12:16, Laura Nao ha scritto:
> temp_factor is used in lvts_temp_to_raw() and lvts_raw_to_temp(). If
> platform data is incorrect and temp_factor is zero, it could cause a
> division by zero. Fail the probe early to prevent a kernel crash.
> 
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>   drivers/thermal/mediatek/lvts_thermal.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index 1c54d0b75b1a..b49441d82ffd 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -1346,6 +1346,11 @@ static int lvts_probe(struct platform_device *pdev)
>   	if (irq < 0)
>   		return irq;
>   
> +	if (!lvts_data->temp_factor)
> +		return dev_err_probe(
> +			dev, -EINVAL,
> +			"temp_factor should never be zero; check platform data.\n");
> +

		return dev_err_probe(dev, -EINVAL,
				     "temp_factor should never be zero; check platform data.\n");

That's the only nitpick that I've got here, and I'm fine either way, anyway, as
this then kind of boils down to personal preference, in a way.

So, regardless of this getting fixed (by the maintainer or by you) or not:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

>   	golden_temp_offset = lvts_data->temp_offset;
>   
>   	ret = lvts_domain_init(dev, lvts_td, lvts_data);
> 


