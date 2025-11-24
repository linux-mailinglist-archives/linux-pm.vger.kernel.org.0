Return-Path: <linux-pm+bounces-38494-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E5213C82179
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 19:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA9A94E2A22
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 18:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE613176E4;
	Mon, 24 Nov 2025 18:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V1Ocd6CJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866D7256C84
	for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 18:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764008720; cv=none; b=QrYv6l53voiJNyOI7T2441AlpTAZkfKm8sGJ9yE71/b+KuresFBsHCYzWhJBqHg2NqblTqJFwm2BZ10rmYP0VdOmzccxNvTim8ZhjRFz9aRpPVRJaCE4sbVwHn0gxZ9bPeKD2LH8Y3UIboSWC/mUm78KtAilJcXZz2V1KEld8/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764008720; c=relaxed/simple;
	bh=LyF6EMTQjwZ21u6QXipK76EsjFKK+ZS1DRbbQem1DNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cNBFSej1XQRQmRBaQXq+Fk2W6MlN2XQW3Zjgd18A53qa9CPwa6PwaiaHTRZwOlbyNbN++7p0Ajrl+E3hCoEzfUBHVgVXfO+u8MkhVVESdN27s4mK9AqFHiXLjLat6mY7aMukvm4cbHIOeGh1MKUdMrsTLTRttB/JglZ+GtkJN7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V1Ocd6CJ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477632b0621so31770355e9.2
        for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 10:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764008717; x=1764613517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tT3hJS80cNjtdeK1a1hTCAW6GUTi3Z7+AdwEEe81LCI=;
        b=V1Ocd6CJK5G+JD/EwcTlNwRuHSy0kV5DM+nOGGk5CIcDBHP0walIK9t36HrZtUDxvC
         OacNtRqpU6DGxwM9nE+Qofk9r+ARAkPjDjvRONvfz/2yQD3FP93wYS3MfW6o2Tjq6nvC
         kA7U20+VBCPEMTkulpeAD5V4I2Fv4k/ReplCrjsIdAsPSi3VYwdcvA/W/iJE5BVPzK4a
         8rbQoSEs6aNVM+0ZiCTnMi3lPQxgRTih5pg72INZuBH09tEeBaXHWFPR+OqRplMQpSz+
         zNB5f71Ehzx31lSL219+UdFjN8yvLezpxf+e++h6oHYWDfY7nJ/FF8t48KLGkcN+Q82K
         +DHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764008717; x=1764613517;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tT3hJS80cNjtdeK1a1hTCAW6GUTi3Z7+AdwEEe81LCI=;
        b=NVOFwhjBFbXhuDSEQpaK0N9QXz3FN24U9DV4hwVu2VsCVQrKNqVJcbX5Fr/YDuJkgq
         LnR6KQhVUFTP87jK3QWcqot0hh+hLXvBp7/zGiEkFSsjxu4Chd6zGMvlRL5xQbNoTOjJ
         8zAbbI9cQcsNmVkpPcnR5hb44uQMAxWu8LFojD0OqKyiW7gMvysR9HU8rGvWhfqWLdek
         +XNtrJiLYhKnbq5o5Wh2XzgK39rqSx6lDlROULxpo7p0dhNikEBQYnIphryTj5ckLlwp
         ZTnQ6RTsxrfnrcHEFgCRGHjwA5d4tIo5DwPNsj4l5d4Q5bWFGkDzKzdMlRR+ocV5uKlG
         U8bA==
X-Forwarded-Encrypted: i=1; AJvYcCUyFQvpXE3WIKtnYDDEqJC0pcXZksQ8qPmFdqNJMpvPvJrzgBo5Wc3gKRhF2GKBTx7TYKJjAhYAmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvIzbUJa95AuE7OFLcj173UpkzVcn1gVDZzZv6oXJadYq2jV5T
	gnCphhfwfCUPmkl1LNQZWrAEneTyBqBLUMxPhwFo3InJp1CmxuVYohidh59AhmVzLCI=
X-Gm-Gg: ASbGncv4SiWDa/JX775LqFL9Pzl2R4SqD29An5oJPfhmkIiN1I/nKEpB5mnVMU+rxJy
	AiHCMkI9k8kgcPnGFssrfAVLVHN6qCsZWsigbQjVQ2X2Q0gsVFR1NKM4pcf3nPZQehs8Xunu1pV
	NcPqW/z+f6DfA2Y+Y798B9Ubdw+Go5CAoGVf0q2rCA/JJG0PED/Wwe7FE+GdPTl4oGcUI/dvs4d
	6XG/ioqOgNAZW8BtCgKz8/taMf+0hkYxt/Z9Tx/Un2CPi9MqLsGFwqt0ivUfc+6X6PngZc85zsa
	XbC7zKzzug6HyyMaP49boIouV15coPHji6n58oR7au0VavQFmnwBqh1xfzgoU3u0UPsNCxLebCj
	sEMuPTLCe3TvJmR9CNietE1mONQibAuPOc6y9UQV2LjFf8GunfTvAYomW94a4M2B5eBjH6OsAHY
	NauzRJAKEIazgArQl00uieeE6bk80eZe7OOXd8gOZZug6hI47CXOcOBgj+LXevCM3yqw==
X-Google-Smtp-Source: AGHT+IEp/+xfgqCCD0AdpFxMvmOtmfqswl3tOTSPHA1XXl6DHcUQiOYz7lT/1lNZ+sQorO1fAsI5XQ==
X-Received: by 2002:a05:600c:4ec7:b0:477:9b4a:a82 with SMTP id 5b1f17b1804b1-477c1138445mr126058885e9.35.1764008716859;
        Mon, 24 Nov 2025 10:25:16 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:a756:bb6c:7b35:af9b? ([2a05:6e02:1041:c10:a756:bb6c:7b35:af9b])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-477bf1f365fsm209857255e9.8.2025.11.24.10.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 10:25:15 -0800 (PST)
Message-ID: <24a5bd31-a79f-4f18-a190-6a4d886a29b2@linaro.org>
Date: Mon, 24 Nov 2025 19:25:14 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/9] thermal/drivers/mediatek/lvts: Make number of
 calibration offsets configurable
To: Laura Nao <laura.nao@collabora.com>, srini@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, rafael@kernel.org,
 rui.zhang@intel.com, lukasz.luba@arm.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com
Cc: nfraprado@collabora.com, arnd@arndb.de, colin.i.king@gmail.com,
 u.kleine-koenig@baylibre.com, andrew-ct.chen@mediatek.com,
 lala.lin@mediatek.com, bchihi@baylibre.com, frank-w@public-files.de,
 wenst@chromium.org, fshao@chromium.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com
References: <20251121-mt8196-lvts-v4-v4-0-357f955a3176@collabora.com>
 <20251121-mt8196-lvts-v4-v4-2-357f955a3176@collabora.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20251121-mt8196-lvts-v4-v4-2-357f955a3176@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/21/25 12:16, Laura Nao wrote:
> MT8196/MT6991 use 2-byte eFuse calibration data, whereas other SoCs
> supported by the driver rely on 3 bytes. Make the number of calibration
> bytes per sensor configurable, enabling support for SoCs with varying
> calibration formats.
> 
> Reviewed-by: Fei Shao <fshao@chromium.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Tested-by: Frank Wunderlich <frank-w@public-files.de>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>   drivers/thermal/mediatek/lvts_thermal.c | 32 ++++++++++++++++++++++----------
>   1 file changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index ab55b20cda47..1c54d0b75b1a 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -96,12 +96,14 @@
>   
>   #define LVTS_MINIMUM_THRESHOLD		20000
>   
> +#define LVTS_MAX_CAL_OFFSETS		3

I suggest LVTS_NUM_CAL_OFFSETS then below,

> +
>   static int golden_temp = LVTS_GOLDEN_TEMP_DEFAULT;
>   static int golden_temp_offset;
>   
>   struct lvts_sensor_data {
>   	int dt_id;
> -	u8 cal_offsets[3];
> +	u8 cal_offsets[LVTS_MAX_CAL_OFFSETS];
>   };
>   
>   struct lvts_ctrl_data {
> @@ -127,6 +129,7 @@ struct lvts_data {
>   	const struct lvts_ctrl_data *lvts_ctrl;
>   	const u32 *conn_cmd;
>   	const u32 *init_cmd;
> +	int num_cal_offsets;
>   	int num_lvts_ctrl;
>   	int num_conn_cmd;
>   	int num_init_cmd;
> @@ -711,7 +714,7 @@ static int lvts_calibration_init(struct device *dev, struct lvts_ctrl *lvts_ctrl
>   					u8 *efuse_calibration,
>   					size_t calib_len)
>   {
> -	int i;
> +	int i, j;
>   	u32 gt;
>   
>   	/* A zero value for gt means that device has invalid efuse data */
> @@ -720,17 +723,18 @@ static int lvts_calibration_init(struct device *dev, struct lvts_ctrl *lvts_ctrl
>   	lvts_for_each_valid_sensor(i, lvts_ctrl_data) {
>   		const struct lvts_sensor_data *sensor =
>   					&lvts_ctrl_data->lvts_sensor[i];
> +		u32 calib = 0;
>   
> -		if (sensor->cal_offsets[0] >= calib_len ||
> -		    sensor->cal_offsets[1] >= calib_len ||
> -		    sensor->cal_offsets[2] >= calib_len)
> -			return -EINVAL;
> +		for (j = 0; j < lvts_ctrl->lvts_data->num_cal_offsets; j++) {
> +			u8 offset = sensor->cal_offsets[j];
> +
> +			if (offset >= calib_len)
> +				return -EINVAL;
> +			calib |= efuse_calibration[offset] << (8 * j);

May be worth for a comment here, ideally a separate function to clarify 
the code

> +		}
>   
>   		if (gt) {
> -			lvts_ctrl->calibration[i] =
> -				(efuse_calibration[sensor->cal_offsets[0]] << 0) +
> -				(efuse_calibration[sensor->cal_offsets[1]] << 8) +
> -				(efuse_calibration[sensor->cal_offsets[2]] << 16);
> +			lvts_ctrl->calibration[i] = calib;
>   		} else if (lvts_ctrl->lvts_data->def_calibration) {
>   			lvts_ctrl->calibration[i] = lvts_ctrl->lvts_data->def_calibration;
>   		} else {
> @@ -1763,6 +1767,7 @@ static const struct lvts_data mt7988_lvts_ap_data = {
>   	.temp_factor	= LVTS_COEFF_A_MT7988,
>   	.temp_offset	= LVTS_COEFF_B_MT7988,
>   	.gt_calib_bit_offset = 24,
> +	.num_cal_offsets = 3,

LVTS_NUM_CAL_OFFSETS


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

