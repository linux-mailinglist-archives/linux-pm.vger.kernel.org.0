Return-Path: <linux-pm+bounces-37730-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 411D9C46A8A
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 13:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A93E4EB469
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 12:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2DA30EF71;
	Mon, 10 Nov 2025 12:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EHLzUCQC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F20030C361
	for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 12:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762778532; cv=none; b=iHEOz2kz8kxvH/iFJv6Ij4WGH4YRPKOHnSWL47apBgc/Ptl2un5Zr/CD9np3mc4NuqAHpEOxsdMHETkVvFo5zYSjBIoGxhUcVLFp9SLxz1QILgtfuSfIn4hsR4vnKBM6uZ0ynML1nKo8dZHiHWrbKFRcwAYGEgit57chlUXfqOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762778532; c=relaxed/simple;
	bh=4nBpBSOWAyXa5p1SawHF2Z0qXdpStWEQvCVLK9Q7K1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bfaJR8aUoYnI+Yyt5vD2DCiL+Comk1SuMH8qD6wPdxyOUx04ShB+q0Cum7/03q1K6iHfxew49umhtgAhyEP2XYzlnq0uiLIVYgR6jtk5KjcA+kQnCkIOz/ZeMEnV6YtnP5YMS+Ow4gxvKB+Nn2oLJbN7qfa4CzbbqOLNZbgT8uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EHLzUCQC; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42b3c5defb2so452785f8f.2
        for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 04:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762778529; x=1763383329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q+N76mxcxihAP3O+FLFRElIM/tYwXLZuPej3Jupgfxo=;
        b=EHLzUCQCD5gFoTvKy93z7IU4JqD+GHBwYv/S5azIk/i00QOrGSts7QsevsAkL65Oyk
         6RFfQNdWYjFBYWDjQ8HIm+R21g7CN5gBijLAGxH5OpPxb5jN4xtz+wyJiLUQxamd/cW1
         XwfQ9BTF5GjBTgvQXw+QLfIUyVhhqbsRsAn2LBeJuU3DDSoJ5jry183MMjWGYds8WHDU
         MvsxDRPBBeqojK4U9mSwOVEdfRwUkWSJqC2DuP9lj/ols8OmU1XmNhu4rqr6u/B3FRdo
         dNUFjrkdAjpR8qaljyyTI0b0qCtuCa6HlzKTqExCjce9b45sN1jQxD/HTCS1nAqdRFzz
         6gXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762778529; x=1763383329;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q+N76mxcxihAP3O+FLFRElIM/tYwXLZuPej3Jupgfxo=;
        b=fwjW+p+/a5jQU2qrg2eiMHF+WAmD8T3AAxRFII2x8pnijPCcRp1j3sF/OeQIP5i9+w
         CgcCPKuaBoRgswRTdHDDYf8VCWul4LaSZ72+LkKo9OQylyZb/NRxb7slpbmfbitcPQfK
         5kvF7nSlAUXVaqMBlma35BYV0D8K6k1VTpcIj3LDZ1NZjgCskwsHIxtiVUNtLV0L1Fuf
         xhuPDB79laStDXgT8pJ+0iXFK6WyXmugeUWkqAmrVtD7QBxjFMvjDmf60CIaS1+qFYMi
         ji4h4o5B+fe80aYszhmeiJNLDMMlS1zIPwHbiKwneuXlckWDffG58b3+/WpYTqffxTSh
         gPoQ==
X-Forwarded-Encrypted: i=1; AJvYcCX47Iyr/eEmOBXRd0gk3jHy8JTsT/aHzpmT9VpRNsfGOsz5hva//abjUcQGB7h/lqyX1WjgWimAhw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdoFS3kMiqT0G2Vz5tsiGN9p7zzyyQ+KAezGK3acK/EZl2Vfpj
	CKh2MzAZ1e3ZTZOvMSc7ns/j7lcFs2DmArFYx5lROu12oPSNWNFQuaTKRepFYsxw3wI=
X-Gm-Gg: ASbGncuRVQ9CmKU5wa047qtavV2xljoHCQxxUIsvFnXwPSSIIubhNFuM2IDxWbnhZ9j
	dawmigmP//av55n/0tv3sjlPda+gwPWnWuy+hB0HpgiO5POs55hBZfJfb9UM/9qotH82mxFp6fz
	zGc+HvxulNw+NqOd8tDSiBCVWlt4BQN1QemKCBgGIqNiYNyliZ0psYJ8RSViC7EabMNzLFwNQ6m
	YCssY7bE5UGXbHzaXl7byRecFgMbbqPpaq7SyrzmxxX0UXscElN8lXiT6LcLMaz2hcZ31L4ujS3
	fbhWDcRpcfv7cwUiGOSCljZA0AjUbTLv80+dQSaNesv+UW/iJ1HpqU3ULwf0glfotj+KPFMsEb+
	76r75rxO5mxleEirbV6HjEvColmpmuKMF7LEsRHFWuBMoBCVZzwgqO2d9w3d64LcbzvA7gZHWvH
	B3jjo88/i/MHwMD2baj5ck4UYJkIuN2SeFM7Dv4Ude1CCMs6i+caf2iy5GnKVsH2MeFg==
X-Google-Smtp-Source: AGHT+IGNKo1M31mUDoARlNl8zibaXqZMwervmekEB8cz3HVAafXXSH8iFrMG/LkjJqzdboVDP9+/mg==
X-Received: by 2002:a5d:5d81:0:b0:42b:2c54:d9ba with SMTP id ffacd0b85a97d-42b2dc1e51bmr6642107f8f.20.1762778528609;
        Mon, 10 Nov 2025 04:42:08 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:2b20:d700:6e9c:533c? ([2a05:6e02:1041:c10:2b20:d700:6e9c:533c])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-42b35ad7c16sm9213468f8f.15.2025.11.10.04.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 04:42:07 -0800 (PST)
Message-ID: <84b9fd00-ce75-43bf-a53b-48818628f7e2@linaro.org>
Date: Mon, 10 Nov 2025 13:42:06 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 3/9] thermal/drivers/mediatek/lvts: Guard
 against zero temp_factor in lvts_raw_to_temp
To: Laura Nao <laura.nao@collabora.com>, srini@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, rafael@kernel.org,
 rui.zhang@intel.com, lukasz.luba@arm.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com
Cc: nfraprado@collabora.com, arnd@arndb.de, colin.i.king@gmail.com,
 u.kleine-koenig@baylibre.com, andrew-ct.chen@mediatek.com,
 lala.lin@mediatek.com, bchihi@baylibre.com, frank-w@public-files.de,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, kernel@collabora.com,
 Chen-Yu Tsai <wenst@chromium.org>, Fei Shao <fshao@chromium.org>
References: <20251016142158.740242-1-laura.nao@collabora.com>
 <20251016142158.740242-4-laura.nao@collabora.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20251016142158.740242-4-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/16/25 16:21, Laura Nao wrote:
> Add a guard against zero temp_factor in lvts_raw_to_temp() to prevent
> division by zero and ensure safe conversion.

Is the temp_factor something else than a ro data statically initialized 
by the lvts_data structure ?

It is pointless to handle the case where the temp_factor is zero. If we 
read the temperature the kernel crashes immediately (which means it was 
not tested).

The temp_factor is an internal value of the driver. If the temp_factor 
is zero, the driver is buggy and should be fixed.


> Fixes: 6725a29321e4 ("thermal/drivers/mediatek/lvts_thermal: Make coeff configurable")
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Fei Shao <fshao@chromium.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>   drivers/thermal/mediatek/lvts_thermal.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index 1c54d0b75b1a..4ef549386add 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -284,11 +284,14 @@ static int lvts_raw_to_temp(u32 raw_temp, int temp_factor)
>   
>   static u32 lvts_temp_to_raw(int temperature, int temp_factor)
>   {
> -	u32 raw_temp = ((s64)(golden_temp_offset - temperature)) << 14;
> +	u32 raw_temp;
>   
> -	raw_temp = div_s64(raw_temp, -temp_factor);
> +	if (temp_factor == 0)
> +		return temperature;
>   
> -	return raw_temp;
> +	raw_temp = ((s64)(golden_temp_offset - temperature)) << 14;
> +
> +	return div_s64(raw_temp, -temp_factor);
>   }
>   
>   static int lvts_get_temp(struct thermal_zone_device *tz, int *temp)
> @@ -1346,6 +1349,9 @@ static int lvts_probe(struct platform_device *pdev)
>   	if (irq < 0)
>   		return irq;
>   
> +	if (!lvts_data->temp_factor)
> +		dev_warn(dev, "temp_factor should never be zero; check platform data.\n");
> +
>   	golden_temp_offset = lvts_data->temp_offset;
>   
>   	ret = lvts_domain_init(dev, lvts_td, lvts_data);
If





-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

