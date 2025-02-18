Return-Path: <linux-pm+bounces-22312-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4FEA39D35
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 14:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21BDC7A13A7
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 13:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C06267388;
	Tue, 18 Feb 2025 13:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AYpRsrYd"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02949230D2F;
	Tue, 18 Feb 2025 13:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739884721; cv=none; b=W8Jbe6VbQjNj2ff2pPfdZndF/e/s6g7kcnfYQkYT4N8+skXQ/mjtLy57h8ahMSA9UOfNQlONttTVnJapiBPrSSD845utoFE7FUsfBBqcGbTJqkU6UuJbojeQstdB9wlTdtPvwkjTEzUyPeLdGXqpr7Rr4cBviVXcqiGucDBQcx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739884721; c=relaxed/simple;
	bh=FPWHPpu0oh2a3YB49PZMeRnbaB9j7/2z74Gs213PxMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZ3lEe7ArruhPWzB8UEIIdSPZLmyo+S9CqJ/9945MbPu5Qw+YebHP+WBO0OK7iqEwOcG35HUwzOno9LNCyvLdVLEDqKn+CU1pXwOXmUsD9KdojYI/18bNIhfZNHzsumNGDleOeUWgatMCS9+02noIDAPczMV1k2EChTXG8JGXu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AYpRsrYd; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739884718;
	bh=FPWHPpu0oh2a3YB49PZMeRnbaB9j7/2z74Gs213PxMM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AYpRsrYdp8B3SpEganL2jKb8Bs73o8Tn+ptsaTezupvmkOLsCMRb0NJW+Qy6PiEwE
	 OqyREqyyT7zX7wl/QvPmk2ihB0UqByW6nErSSkS4sRhEp9aiJPPWtxyFfnf+UqLsi8
	 YC7oePKC9WKeq3bZI7VphNuCq0mYxBFjZlNOqNasFpnnSryDt1KK3o4r0wquxiB+v5
	 Gg2/Zkuzk6Ii9d4MWQyxwlErJjxsVvzwepBA/tVJaQzpXa9DNe8rIickZG79CkQOPK
	 Qc5MGaavU0xUguPKekofn8VFtZCjUpwnkeDzvHSD2BiU4ZAbSiWkaON3VDXkN6BE3f
	 DcjsGH6vLF4Xw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1EC9017E0657;
	Tue, 18 Feb 2025 14:18:37 +0100 (CET)
Message-ID: <0ec8b0a5-d9b0-4090-a6b0-22537f449176@collabora.com>
Date: Tue, 18 Feb 2025 14:18:36 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] ASoC: mediatek: mt6359-accdet: Add compatible
 property
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Sen Chu <sen.chu@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Lee Jones <lee@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-pm@vger.kernel.org, Andrew Perepech <andrew.perepech@mediatek.com>
References: <20250214-mt6359-accdet-dts-v1-0-677a151b9b4c@collabora.com>
 <20250214-mt6359-accdet-dts-v1-4-677a151b9b4c@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250214-mt6359-accdet-dts-v1-4-677a151b9b4c@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 14/02/25 18:18, Nícolas F. R. A. Prado ha scritto:
> Add a compatible property and add it to the module device table for the
> mt6359-accdet platform driver to allow automatic module loading and
> probing when the compatible is present in DT.
> 
> Co-developed-by: Andrew Perepech <andrew.perepech@mediatek.com>
> Signed-off-by: Andrew Perepech <andrew.perepech@mediatek.com>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>   sound/soc/codecs/mt6359-accdet.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/sound/soc/codecs/mt6359-accdet.c b/sound/soc/codecs/mt6359-accdet.c
> index ed34cc15b80e856356c07fd53af22207124e0d19..6f07db879c6a56ce4843954f51bb9602373e4aa5 100644
> --- a/sound/soc/codecs/mt6359-accdet.c
> +++ b/sound/soc/codecs/mt6359-accdet.c
> @@ -1047,9 +1047,19 @@ static int mt6359_accdet_probe(struct platform_device *pdev)
>   	return ret;
>   }
>   
> +const struct of_device_id accdet_of_match[] = {
> +	{
> +		.compatible = "mediatek,mt6359-accdet",
> +	}, {
> +		/* sentinel */
> +	},

Compress that stuff please...

	{ .compatible .. },
	{ /* sentinel */ }
};

after which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> +};
> +MODULE_DEVICE_TABLE(of, accdet_of_match);
> +
>   static struct platform_driver mt6359_accdet_driver = {
>   	.driver = {
>   		.name = "pmic-codec-accdet",
> +		.of_match_table = accdet_of_match,
>   	},
>   	.probe = mt6359_accdet_probe,
>   };
> 




