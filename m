Return-Path: <linux-pm+bounces-5109-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2AB87FD27
	for <lists+linux-pm@lfdr.de>; Tue, 19 Mar 2024 12:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8092C283AC6
	for <lists+linux-pm@lfdr.de>; Tue, 19 Mar 2024 11:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1DA7F465;
	Tue, 19 Mar 2024 11:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WkKFOnex"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7FC7CF24;
	Tue, 19 Mar 2024 11:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710848937; cv=none; b=hKACCM2ROMgGNwAa5LQE0fUp8eLEFN8JCZd73wXrIboDmFONKniAUwk29CBTksrIMK2g4IQ8ofltHefJi5Qzwhq3+BZWHshQy+G1b01HGgRtCbDQ0mSy4osf6AmmetFviBngGmjC2P7ChpC17CQg6R0P7PEgwRnrAPmtOFz7dkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710848937; c=relaxed/simple;
	bh=e3xf9w9fguza9YlfKc8c4gwJVjizSFUCZqmpN2WsxJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eskfWMxR/5j1fHswUywRDX3u8cuUT/L+NKqEYVvRr51nlti1U5JZMK1T+wWTkVdR+7bNfJaKshO8oTRypNkWwVaC7I+5jlMq7NuyGLDbvsus/2rUdzAd03uHIjNazrA/8hRFU1k9XlNqdETVvvpzDc9QaRsGoq8PR/+xPR5Vtm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WkKFOnex; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710848934;
	bh=e3xf9w9fguza9YlfKc8c4gwJVjizSFUCZqmpN2WsxJI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WkKFOnexS6Vv6gCTko3Pvzmq5P6rqfcMlhDhF8OqqzRt/O+jMc9ETk0Y8Xxu34DFj
	 Gps4yKKvF1OCudhtzBwzUuRq3RYtpzz/Rg9o31N91Pqj8rfi1x1eReMK/8yCpKULy1
	 C+pv/ln8SlUPe7lIDw0sCxBkxBI4OgjpYhR+09JCatsuBwix5pp7hV+Uz6Eo2qjofr
	 qbKX6/zZlq1iPihK6T8d5FJh6LKozX8GvkQZGsVmBVLcCKauI2XYEa1TcmkjMquIbv
	 rX/5HPIsYVoB4vBBZuI7KLOByex/xGA/zFY4ysKyTmcySs+Ely4v44Gb0dQxGcsOpj
	 uxpvl1QZk338Q==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0D309378203E;
	Tue, 19 Mar 2024 11:48:53 +0000 (UTC)
Message-ID: <6c5e8e8c-3d00-468b-b5c3-d09838b670eb@collabora.com>
Date: Tue, 19 Mar 2024 12:48:53 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/13] thermal/drivers/mediatek/lvts_thermal: add
 MT8186 support
Content-Language: en-US
To: Nicolas Pitre <nico@fluxnic.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>
References: <20240318212428.3843952-1-nico@fluxnic.net>
 <20240318212428.3843952-8-nico@fluxnic.net>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240318212428.3843952-8-nico@fluxnic.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 18/03/24 22:22, Nicolas Pitre ha scritto:
> From: Nicolas Pitre <npitre@baylibre.com>
> 
> Various values extracted from the vendor's kernel driver.
> 
> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> ---
>   drivers/thermal/mediatek/lvts_thermal.c | 67 +++++++++++++++++++++++++
>   1 file changed, 67 insertions(+)
> 
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index ed1888fb24..e923d22c17 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -80,6 +80,8 @@
>   #define LVTS_SENSOR_MAX				4
>   #define LVTS_GOLDEN_TEMP_MAX		62
>   #define LVTS_GOLDEN_TEMP_DEFAULT	50
> +#define LVTS_COEFF_A_MT8186			-204650
> +#define LVTS_COEFF_B_MT8186			204650

You don't need this definition, as you can reuse the MT7988 one.

Regards,
Angelo

>   #define LVTS_COEFF_A_MT8195			-250460
>   #define LVTS_COEFF_B_MT8195			250460
>   #define LVTS_COEFF_A_MT7988			-204650
> @@ -92,6 +94,7 @@
>   #define LVTS_MSR_READ_WAIT_US		(LVTS_MSR_READ_TIMEOUT_US / 2)
>   
>   #define LVTS_HW_SHUTDOWN_MT7988		105000
> +#define LVTS_HW_SHUTDOWN_MT8186		105000
>   #define LVTS_HW_SHUTDOWN_MT8192		105000
>   #define LVTS_HW_SHUTDOWN_MT8195		105000
>   
> @@ -1377,6 +1380,62 @@ static int lvts_resume(struct device *dev)
>   	return 0;
>   }
>   
> +/*
> + * The MT8186 calibration data is stored as packed 3-byte little-endian
> + * values using a weird layout that makes sense only when viewed as a 32-bit
> + * hexadecimal word dump. Let's suppose SxBy where x = sensor number and
> + * y = byte number where the LSB is y=0. We then have:
> + *
> + *   [S0B2-S0B1-S0B0-S1B2] [S1B1-S1B0-S2B2-S2B1] [S2B0-S3B2-S3B1-S3B0]
> + *
> + * However, when considering a byte stream, those appear as follows:
> + *
> + *   [S1B2] [S0B0[ [S0B1] [S0B2] [S2B1] [S2B2] [S1B0] [S1B1] [S3B0] [S3B1] [S3B2] [S2B0]
> + *
> + * Hence the rather confusing offsets provided below.
> + */
> +static const struct lvts_ctrl_data mt8186_lvts_data_ctrl[] = {
> +	{
> +		.lvts_sensor = {
> +			{ .dt_id = MT8186_TS1_0,
> +			  .cal_offsets = { 5, 6, 7 } },
> +			{ .dt_id = MT8186_TS1_1,
> +			  .cal_offsets = { 10, 11, 4 } },
> +			{ .dt_id = MT8186_TS1_2,
> +			  .cal_offsets = { 15, 8, 9 } },
> +			{ .dt_id = MT8186_TS1_3,
> +			  .cal_offsets = { 12, 13, 14 } }
> +		},
> +		.num_lvts_sensor = 4,
> +		.offset = 0x0,
> +		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8186,
> +	},
> +	{
> +		.lvts_sensor = {
> +			{ .dt_id = MT8186_TS2_0,
> +			  .cal_offsets = { 22, 23, 16 } },
> +			{ .dt_id = MT8186_TS2_1,
> +			  .cal_offsets = { 27, 20, 21 } }
> +		},
> +		.num_lvts_sensor = 2,
> +		.offset = 0x100,
> +		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8186,
> +	},
> +	{
> +		.lvts_sensor = {
> +			{ .dt_id = MT8186_TS3_0,
> +			  .cal_offsets = { 29, 30, 31 } },
> +			{ .dt_id = MT8186_TS3_1,
> +			  .cal_offsets = { 34, 35, 28 } },
> +			{ .dt_id = MT8186_TS3_2,
> +			  .cal_offsets = { 39, 32, 33 } }
> +		},
> +		.num_lvts_sensor = 3,
> +		.offset = 0x200,
> +		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8186,
> +	}
> +};
> +
>   static const struct lvts_ctrl_data mt8192_lvts_mcu_data_ctrl[] = {
>   	{
>   		.lvts_sensor = {
> @@ -1565,6 +1624,13 @@ static const struct lvts_data mt7988_lvts_ap_data = {
>   	.temp_offset	= LVTS_COEFF_B_MT7988,
>   };
>   
> +static const struct lvts_data mt8186_lvts_data = {
> +	.lvts_ctrl	= mt8186_lvts_data_ctrl,
> +	.num_lvts_ctrl	= ARRAY_SIZE(mt8186_lvts_data_ctrl),
> +	.temp_factor	= LVTS_COEFF_A_MT8186,
> +	.temp_offset	= LVTS_COEFF_B_MT8186,
> +};
> +
>   static const struct lvts_data mt8192_lvts_mcu_data = {
>   	.lvts_ctrl	= mt8192_lvts_mcu_data_ctrl,
>   	.num_lvts_ctrl	= ARRAY_SIZE(mt8192_lvts_mcu_data_ctrl),
> @@ -1591,6 +1657,7 @@ static const struct lvts_data mt8195_lvts_ap_data = {
>   
>   static const struct of_device_id lvts_of_match[] = {
>   	{ .compatible = "mediatek,mt7988-lvts-ap", .data = &mt7988_lvts_ap_data },
> +	{ .compatible = "mediatek,mt8186-lvts", .data = &mt8186_lvts_data },
>   	{ .compatible = "mediatek,mt8192-lvts-mcu", .data = &mt8192_lvts_mcu_data },
>   	{ .compatible = "mediatek,mt8192-lvts-ap", .data = &mt8192_lvts_ap_data },
>   	{ .compatible = "mediatek,mt8195-lvts-mcu", .data = &mt8195_lvts_mcu_data },


