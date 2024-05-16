Return-Path: <linux-pm+bounces-7895-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A15E8C737A
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 11:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D69FBB2280F
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 09:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB52142E91;
	Thu, 16 May 2024 09:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="1qmPN4MS"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED062576F;
	Thu, 16 May 2024 09:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715850523; cv=none; b=g+mouDPfWYj2WyjO8CwkHDDffhCEhChbH9dzaBkFjvrxhZeK5oYwnbmYlbO7tDc3b947xqOoV7oz3I5+R3IhSw0n75MyZyBAkCQnqaMVJiKeKAYhMDgOiDG+0KNFaBSyuKL7GX6zuVOLGDXHcx/R4tQDuVKUBlcZPxiIq47/C10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715850523; c=relaxed/simple;
	bh=vAvIJTNsbVbIUiKWdSGN2T4HDQRkXCi7vBZQDlnrV20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WB1a6v4y441n+7NSV8dFQu+QQJQmfbjGKqM+6DEfIhswwApvmAUuy+Z8dLshLhnoZLl2aK55fefDg0BzFYOPhiUfogOolOVb7Na+3ha2q8dYejDSShxAagUMg3G2hzNdkdaX5Bg+TX6rtsl1KNitUWEV3SUo2oXjiueM95Tmyas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=1qmPN4MS; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715850519;
	bh=vAvIJTNsbVbIUiKWdSGN2T4HDQRkXCi7vBZQDlnrV20=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=1qmPN4MSogKM726TEtrCF4Tayjl4D9lGv8cUo9U3gjtBt4iuHPC4vUOcHtcVtC7LL
	 kZ2tPsVVIjSqzQMLT+QkQPfI6+vPhn41A+iKsCfqm3PVa62heoQ/5xCzeu6jHJ6y3G
	 xDopWBQ/hLf/EAD4n6TM+jLLuPAxs19y3tKU86/FFeJe7g8q7Z5DH5NZAQ+T2/Gal+
	 VHs+vNfktYstW1sLm9wglPx1XzgUY0ffpKw12A5apzywF5U+UWLyC50QxeWF9M2AHe
	 KE1gjqOyoCVi20JlkHRQTxkCk8HktQYfhVqRxyRb1BHAmM3Hsaxz0gMlBGFSdjHCDH
	 5NKeFVye9ny3Q==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3FD18378218B;
	Thu, 16 May 2024 09:08:39 +0000 (UTC)
Message-ID: <f0a59da9-7b1a-4a11-bc3e-e39c9fa4e3bd@collabora.com>
Date: Thu, 16 May 2024 11:08:38 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/drivers/mediatek/lvts_thermal: Remove filtered
 mode for mt8188
To: Julien Panis <jpanis@baylibre.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Nicolas Pitre <npitre@baylibre.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240515-mtk-thermal-mt8188-mode-fix-v1-1-e656b310b67f@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240515-mtk-thermal-mt8188-mode-fix-v1-1-e656b310b67f@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 15/05/24 17:03, Julien Panis ha scritto:
> Filtered mode is not supported on mt8188 SoC and is the source of bad
> results. Move to immediate mode which provides good temperatures.
> 
> Signed-off-by: Julien Panis <jpanis@baylibre.com>

Please add the relevant Fixes tag, after which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
> Filtered mode was set by mistake and difficulties with the test setup
> prevented from catching this earlier. Use default mode (immediate mode)
> instead.
> ---
>   drivers/thermal/mediatek/lvts_thermal.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index 0bb3a495b56e..82c355c466cf 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -1458,7 +1458,6 @@ static const struct lvts_ctrl_data mt8188_lvts_mcu_data_ctrl[] = {
>   		},
>   		VALID_SENSOR_MAP(1, 1, 1, 1),
>   		.offset = 0x0,
> -		.mode = LVTS_MSR_FILTERED_MODE,
>   	},
>   	{
>   		.lvts_sensor = {
> @@ -1469,7 +1468,6 @@ static const struct lvts_ctrl_data mt8188_lvts_mcu_data_ctrl[] = {
>   		},
>   		VALID_SENSOR_MAP(1, 1, 0, 0),
>   		.offset = 0x100,
> -		.mode = LVTS_MSR_FILTERED_MODE,
>   	}
>   };
>   
> @@ -1483,7 +1481,6 @@ static const struct lvts_ctrl_data mt8188_lvts_ap_data_ctrl[] = {
>   		},
>   		VALID_SENSOR_MAP(0, 1, 0, 0),
>   		.offset = 0x0,
> -		.mode = LVTS_MSR_FILTERED_MODE,
>   	},
>   	{
>   		.lvts_sensor = {
> @@ -1496,7 +1493,6 @@ static const struct lvts_ctrl_data mt8188_lvts_ap_data_ctrl[] = {
>   		},
>   		VALID_SENSOR_MAP(1, 1, 1, 0),
>   		.offset = 0x100,
> -		.mode = LVTS_MSR_FILTERED_MODE,
>   	},
>   	{
>   		.lvts_sensor = {
> @@ -1507,7 +1503,6 @@ static const struct lvts_ctrl_data mt8188_lvts_ap_data_ctrl[] = {
>   		},
>   		VALID_SENSOR_MAP(1, 1, 0, 0),
>   		.offset = 0x200,
> -		.mode = LVTS_MSR_FILTERED_MODE,
>   	},
>   	{
>   		.lvts_sensor = {
> @@ -1518,7 +1513,6 @@ static const struct lvts_ctrl_data mt8188_lvts_ap_data_ctrl[] = {
>   		},
>   		VALID_SENSOR_MAP(1, 1, 0, 0),
>   		.offset = 0x300,
> -		.mode = LVTS_MSR_FILTERED_MODE,
>   	}
>   };
>   
> 
> ---
> base-commit: 82d92a9a1b9ea0ea52aff27cddd05009b4edad49
> change-id: 20240515-mtk-thermal-mt8188-mode-fix-e583d9a31da1
> 
> Best regards,


