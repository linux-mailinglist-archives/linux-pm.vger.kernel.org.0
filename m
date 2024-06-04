Return-Path: <linux-pm+bounces-8583-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 143428FB8F6
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 18:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 453E31C220DA
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 16:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8490E148FE0;
	Tue,  4 Jun 2024 16:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LuTfpSvx"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6B31487E7;
	Tue,  4 Jun 2024 16:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717518602; cv=none; b=CYREqe+jxmXPKGLOHWSOgLgHWO1+niq0aY3VK7tr3YSK4b/0Ae9ACkJ89VLHA1xCgeNizmpftvadUwePByRaSf5xUdgOX/gR1ayvql/N6A+hIINTmM+3b+BvdRtbKiWS6XM41DKaDpMJEZvVsKvKGj9OuMis5cvx94x/U+Bwzkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717518602; c=relaxed/simple;
	bh=zzYkFvKYex68lFbcEumkWIRNilyKlRoCRjm2QfKYCYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QqZvfuVLxbqRahAvh87Ot7LLPwCYlWpH9OkVvDYG0wNfgvNOU0Q9OMeCMy+v86QJtOMU+Mf3C49LKt+KHjwzNdD4u1J7mfdkOfG9vdR529g8fAUTwDtVbaIwv54+QOdD0n/jeXw0bJcnVhMb/N9KQ2jsznrQ1CaDI4c34AfIe7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LuTfpSvx; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717518599;
	bh=zzYkFvKYex68lFbcEumkWIRNilyKlRoCRjm2QfKYCYI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LuTfpSvx77y3cFBgUuKy6/VtKdGfhRAFnKnsdpuSRjSysWrElI548NJjDUA986Qxu
	 /hHklctq0p9l2AQ6nTkiDLwJOCmQTZMNgndn7d2mFNa+OQ6zqjRXK4tKUXiwH38Um2
	 pRG8oHEIhekBwVmM6RE3xY9AHb++2L/XWywja7g9ZeigtEE3oPG/HcRmPBSZzFV4HW
	 w5HDMUsmi14ZC7D/zkgH4V2Qno9h/wQkBNoAvnC4eeR+v28s+tEjuxVz7iTAZH614b
	 H6KhWVhZYy57O0ZvyFCGxyqsMxnHttLifoSe4aeW9TwsCxdxRzvifIHJZjwKcyFEDU
	 Nn3k6Yk/ogwTg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 63A7B3781104;
	Tue,  4 Jun 2024 16:29:58 +0000 (UTC)
Message-ID: <af024ad1-93f6-4d7a-b139-7eb2fa12eb81@collabora.com>
Date: Tue, 4 Jun 2024 18:29:57 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/drivers/mediatek/lvts_thermal: Return error in
 case of invalid efuse data
To: Julien Panis <jpanis@baylibre.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Nicolas Pitre <npitre@baylibre.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240603-mtk-thermal-calib-check-v1-1-5d6bf040414c@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240603-mtk-thermal-calib-check-v1-1-5d6bf040414c@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 03/06/24 14:06, Julien Panis ha scritto:
> This patch prevents from registering thermal entries and letting the
> driver misbehave if efuse data is invalid. A device is not properly
> calibrated if the golden temperature is zero.
> 
> Signed-off-by: Julien Panis <jpanis@baylibre.com>

Fixes tag, please.

Regards,
Angelo

> ---
> Guard against invalid calibration data, following this discussion:
> https://lore.kernel.org/all/ad047631-16b8-42ce-8a8d-1429e6af4517@collabora.com/
> ---
>   drivers/thermal/mediatek/lvts_thermal.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index 0bb3a495b56e..185d5a32711f 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -769,7 +769,11 @@ static int lvts_golden_temp_init(struct device *dev, u8 *calib,
>   	 */
>   	gt = (((u32 *)calib)[0] >> lvts_data->gt_calib_bit_offset) & 0xff;
>   
> -	if (gt && gt < LVTS_GOLDEN_TEMP_MAX)
> +	/* A zero value for gt means that device has invalid efuse data */
> +	if (!gt)
> +		return -ENODATA;
> +
> +	if (gt < LVTS_GOLDEN_TEMP_MAX)
>   		golden_temp = gt;
>   
>   	golden_temp_offset = golden_temp * 500 + lvts_data->temp_offset;
> 
> ---
> base-commit: 632483ea8004edfadd035de36e1ab2c7c4f53158
> change-id: 20240603-mtk-thermal-calib-check-ba2ec24a1c32
> 
> Best regards,



