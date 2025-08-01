Return-Path: <linux-pm+bounces-31733-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A927B17D7F
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 09:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CD37189BB7D
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 07:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633A3219A9B;
	Fri,  1 Aug 2025 07:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Rv/vt5CW"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8313E20D50C;
	Fri,  1 Aug 2025 07:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754033329; cv=none; b=Tie/vejR8cK1kyUttPxqG5IxbiK2EzcrE6cCIH4C40Y6VypFUMMj/kvXKltp1Kw3h2YYX3DDlY7qUiF+WiYd7Tzw6Tb33FLn7k/DGk6DbMGc+79XdcAuZtEE/qpFHr5lQ1XvS+e22FJEnTclXQZ9At/0t1luigMsKxTVQiN69/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754033329; c=relaxed/simple;
	bh=EMVwpG37bgqFGohQRsO75cPRK1G/rDe+DuVSBLIxMoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gi+U1a0OGghPlQSkW5M0XAum7ovsKQIBlIn5ZrD4VML6S5957yg8uJzewmvx/39wkUOhm59zYTampTuJQIS1BRbK9J+XYigvyQhUQgXH1uJB/Bdg/exggeznTYDwRjs7Hm38DHa7QVUbeoQWAR7JA9npxL6NX1xPv4lw/C5DoHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Rv/vt5CW; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754033325;
	bh=EMVwpG37bgqFGohQRsO75cPRK1G/rDe+DuVSBLIxMoE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Rv/vt5CWaBk8BqZWNiED+VbmzHUIAXxWMxdTcUPLrmLi10vKiAtp1cKRY+V0iE1ZD
	 PaPec3XSKqyv+KDbm6EE45aF1txbnslJVvFR8gA1qjPfooxhat61e/KgEqpsgqKUQd
	 SRNx5waZ6VNSvFXqn82bKC++hZDC2ATUsPnpx0lZx7VbibglljfcpJQu6yYlMEHQLr
	 C1UaOsXc8OR9TxTUKihAhw6Aauty/tNKioToAT2jcC3JsMQGzboCe77M0tq1GXOc6m
	 G56FCbMuA909y8UMBUtc9Kv0fZBLw2bTVb+BDpz/6UkW9YLfdELD9idlmZEptc2IhT
	 dyfiif+0lF9TA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A297D17E1324;
	Fri,  1 Aug 2025 09:28:44 +0200 (CEST)
Message-ID: <fe21aa13-d92c-4f3e-8311-2d75468ecb4a@collabora.com>
Date: Fri, 1 Aug 2025 09:28:44 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] thermal: mediatek: lvts: Add platform ops to
 support alternative conversion logic
To: Laura Nao <laura.nao@collabora.com>, srini@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, rafael@kernel.org,
 daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
 matthias.bgg@gmail.com
Cc: wenst@chromium.org, nfraprado@collabora.com, arnd@arndb.de,
 colin.i.king@gmail.com, u.kleine-koenig@baylibre.com,
 andrew-ct.chen@mediatek.com, lala.lin@mediatek.com, bchihi@baylibre.com,
 frank-w@public-files.de, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com
References: <20250730152128.311109-1-laura.nao@collabora.com>
 <20250730152128.311109-5-laura.nao@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250730152128.311109-5-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 30/07/25 17:21, Laura Nao ha scritto:
> Introduce lvts_platform_ops struct to support SoC-specific versions of
> lvts_raw_to_temp() and lvts_temp_to_raw() conversion functions.
> 
> This is in preparation for supporting SoCs like MT8196/MT6991, which
> require a different lvts_temp_to_raw() implementation.
> 
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>   drivers/thermal/mediatek/lvts_thermal.c | 46 +++++++++++++++++++++++--
>   1 file changed, 43 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index 8398af657ba2..6e4a35ecaf34 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -125,8 +125,14 @@ struct lvts_ctrl_data {
>   			continue; \
>   		else
>   
> +struct lvts_platform_ops {
> +	int (*lvts_raw_to_temp)(u32 raw_temp, int temp_factor);
> +	u32 (*lvts_temp_to_raw)(int temperature, int temp_factor);
> +};
> +
>   struct lvts_data {
>   	const struct lvts_ctrl_data *lvts_ctrl;
> +	struct lvts_platform_ops ops;

You can constify this one - but then there's something else that we can do here
to waste a bit less memory.

	const struct lvts_platform_ops *ops;

const struct lvts_platform_ops lvts_platform_ops_v1 = {
	.lvts_raw_to_temp = lvts_raw_to_temp,
	.lvts_temp_to_raw = lvts_temp_to_raw,
};

static const struct lvts_data mt8195_lvts_mcu_data = {
	[..... stuff .....],
	.ops = lvts_platform_ops_v1,
};

....and goes on the same for all the others.



>   	const u32 *conn_cmd;
>   	const u32 *init_cmd;
>   	int num_cal_offsets;
> @@ -300,6 +306,7 @@ static int lvts_get_temp(struct thermal_zone_device *tz, int *temp)
>   	struct lvts_ctrl *lvts_ctrl = container_of(lvts_sensor, struct lvts_ctrl,
>   						   sensors[lvts_sensor->id]);
>   	const struct lvts_data *lvts_data = lvts_ctrl->lvts_data;
> +	const struct lvts_platform_ops *ops = &lvts_data->ops;

...then here, and everywhere else, it would be just

	const struct lvts_platform_ops *ops = lvts_data->ops;


After implementing the proposed change, exactly how I wrote them:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Cheers,
Angelo



