Return-Path: <linux-pm+bounces-18116-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EFF9D94C4
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2024 10:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 770AC282709
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2024 09:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90431C5799;
	Tue, 26 Nov 2024 09:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NNT+0d4F"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE451BC9EE;
	Tue, 26 Nov 2024 09:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732614231; cv=none; b=tHIVoqLNsTQFzG0j5VwDNx3zPrPRY+muttEMFJEYGDqt6VpiiifzR1fMd7hCTxR/sO/vgulKXSc4OXqM/qWiIX+OzEeWjH4Z2FErSSF98yiIy/ezMHXfLQSGEyKf4LWCZ92VEfqj/koWwTg1ac6eXyPLM/uClat1J4r3GT83CwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732614231; c=relaxed/simple;
	bh=QTvnyqwGjjWVyPYPOq20hf9RRJbA0UUZwRQxa1GhjMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aGZalvRAEN45wrFnhDol0gYb01ck+RwNJGNI4zqB/rYufmKuQ4weYMbtEyaynE3iUrOrSIBUfjS6IDM7i9OcQFit15eGtyf2yLBBf3KXMQpeSaYkxJS1zBGpQpQEqbBRpeEp4LDUKlrE/52gWbF+9LwIUpCA1ZZrnD2eoDvRhMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NNT+0d4F; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732614228;
	bh=QTvnyqwGjjWVyPYPOq20hf9RRJbA0UUZwRQxa1GhjMo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NNT+0d4F3zVyNDComwEHZiFfeYnXHDdTzC0yn29gej+aWe6VyDEXRSJ5mmUAx/MhP
	 IqMPKO67Ib0yOsnTaT1b8bJcBEip2fFve3yC0fdjUA2gAaworD55mlS+qxYKE2emTv
	 whb0LhPSHBvHupJ+PKPA35tZLE23ghLt1Q6h1yyV4qEZkUshFa0QJV2hZxCuYgq9WC
	 kNIcVczflIb1DJ/b78RukpNC/1REt6FA5v8A2QhAcpg2dlzv0Jr7jr8A6/eBNoaFaT
	 /TI3ncRovqJx18ucCom9gqbiFwAcTvyyk/zEBcjh0vsfzOPrRYb4Edbpit0hNyZ0xV
	 mhUYTNIu/pYmw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5DDA617E35DC;
	Tue, 26 Nov 2024 10:43:47 +0100 (CET)
Message-ID: <78f440ff-1247-4d97-a170-fe2412e75d4a@collabora.com>
Date: Tue, 26 Nov 2024 10:43:47 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] thermal/drivers/mediatek/lvts: Disable low offset IRQ
 for minimum threshold
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, Alexandre Mergnat <amergnat@baylibre.com>,
 Balsam CHIHI <bchihi@baylibre.com>
Cc: kernel@collabora.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Hsin-Te Yuan <yuanhsinte@chromium.org>,
 Chen-Yu Tsai <wenst@chromium.org>, =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?=
 <bero@baylibre.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 stable@vger.kernel.org
References: <20241125-mt8192-lvts-filtered-suspend-fix-v1-0-42e3c0528c6c@collabora.com>
 <20241125-mt8192-lvts-filtered-suspend-fix-v1-3-42e3c0528c6c@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241125-mt8192-lvts-filtered-suspend-fix-v1-3-42e3c0528c6c@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 25/11/24 22:20, Nícolas F. R. A. Prado ha scritto:
> In order to get working interrupts, a low offset value needs to be
> configured. The minimum value for it is 20 Celsius, which is what is
> configured when there's no lower thermal trip (ie the thermal core
> passes -INT_MAX as low trip temperature). However, when the temperature
> gets that low and fluctuates around that value it causes an interrupt
> storm.
> 
> Prevent that interrupt storm by not enabling the low offset interrupt if
> the low threshold is the minimum one.
> 
> Cc: stable@vger.kernel.org
> Fixes: 77354eaef821 ("thermal/drivers/mediatek/lvts_thermal: Don't leave threshold zeroed")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>   drivers/thermal/mediatek/lvts_thermal.c | 48 ++++++++++++++++++++++++---------
>   1 file changed, 35 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index 6ac33030f015c7239e36d81018d1a6893cb69ef8..2271023f090df82fbdd0b5755bb34879e58b0533 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -67,10 +67,14 @@
>   #define LVTS_CALSCALE_CONF			0x300
>   #define LVTS_MONINT_CONF			0x0300318C
>   
> -#define LVTS_MONINT_OFFSET_SENSOR0		0xC
> -#define LVTS_MONINT_OFFSET_SENSOR1		0x180
> -#define LVTS_MONINT_OFFSET_SENSOR2		0x3000
> -#define LVTS_MONINT_OFFSET_SENSOR3		0x3000000
> +#define LVTS_MONINT_OFFSET_HIGH_SENSOR0		BIT(3)

Yeah it's longer, but that's more readable:

#define LVTS_MONINT_OFFSET_HIGH_INTEN_SENSOR0

...because what this BIT does is enabling the high offset interrupt for the
sensing point 0 (which in this driver we call sensor 0).

That name would make it (imo) way less likely to need any datasheet to understand
what is actually going on with that setting :-)

> +#define LVTS_MONINT_OFFSET_HIGH_SENSOR1		BIT(8)
> +#define LVTS_MONINT_OFFSET_HIGH_SENSOR2		BIT(13)
> +#define LVTS_MONINT_OFFSET_HIGH_SENSOR3		BIT(25)
> +#define LVTS_MONINT_OFFSET_LOW_SENSOR0		BIT(2)

Of course, the comment is valid for the LOW ones as well!

Everything else is good for me, and since it is just about simple renaming, I can
already give you my

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> +#define LVTS_MONINT_OFFSET_LOW_SENSOR1		BIT(7)
> +#define LVTS_MONINT_OFFSET_LOW_SENSOR2		BIT(12)
> +#define LVTS_MONINT_OFFSET_LOW_SENSOR3		BIT(24)
>   
>   #define LVTS_INT_SENSOR0			0x0009001F
>   #define LVTS_INT_SENSOR1			0x001203E0
> @@ -326,11 +330,17 @@ static int lvts_get_temp(struct thermal_zone_device *tz, int *temp)
>   
>   static void lvts_update_irq_mask(struct lvts_ctrl *lvts_ctrl)
>   {
> -	u32 masks[] = {
> -		LVTS_MONINT_OFFSET_SENSOR0,
> -		LVTS_MONINT_OFFSET_SENSOR1,
> -		LVTS_MONINT_OFFSET_SENSOR2,
> -		LVTS_MONINT_OFFSET_SENSOR3,
> +	u32 high_offset_masks[] = {
> +		LVTS_MONINT_OFFSET_HIGH_SENSOR0,
> +		LVTS_MONINT_OFFSET_HIGH_SENSOR1,
> +		LVTS_MONINT_OFFSET_HIGH_SENSOR2,
> +		LVTS_MONINT_OFFSET_HIGH_SENSOR3,
> +	};
> +	u32 low_offset_masks[] = {
> +		LVTS_MONINT_OFFSET_LOW_SENSOR0,
> +		LVTS_MONINT_OFFSET_LOW_SENSOR1,
> +		LVTS_MONINT_OFFSET_LOW_SENSOR2,
> +		LVTS_MONINT_OFFSET_LOW_SENSOR3,
>   	};
>   	u32 value = 0;
>   	int i;
> @@ -339,10 +349,22 @@ static void lvts_update_irq_mask(struct lvts_ctrl *lvts_ctrl)
>   
>   	for (i = 0; i < ARRAY_SIZE(masks); i++) {
>   		if (lvts_ctrl->sensors[i].high_thresh == lvts_ctrl->high_thresh
> -		    && lvts_ctrl->sensors[i].low_thresh == lvts_ctrl->low_thresh)
> -			value |= masks[i];
> -		else
> -			value &= ~masks[i];
> +		    && lvts_ctrl->sensors[i].low_thresh == lvts_ctrl->low_thresh) {
> +			/*
> +			 * The minimum threshold needs to be configured in the
> +			 * OFFSETL register to get working interrupts, but we
> +			 * don't actually want to generate interrupts when
> +			 * crossing it.
> +			 */
> +			if (lvts_ctrl->low_thresh == -INT_MAX) {
> +				value &= ~low_offset_masks[i];
> +				value |= high_offset_masks[i];
> +			} else {
> +				value |= low_offset_masks[i] | high_offset_masks[i];
> +			}
> +		} else {
> +			value &= ~(low_offset_masks[i] | high_offset_masks[i]);
> +		}
>   	}
>   
>   	writel(value, LVTS_MONINT(lvts_ctrl->base));
> 


