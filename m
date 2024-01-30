Return-Path: <linux-pm+bounces-2996-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 469408427AB
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jan 2024 16:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79B1E1C220A3
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jan 2024 15:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A321082D71;
	Tue, 30 Jan 2024 15:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="Uy6upPFK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB1A7E761
	for <linux-pm@vger.kernel.org>; Tue, 30 Jan 2024 15:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706627338; cv=none; b=o5kV4SYC+KvBiwxzkkaxf2lpPB7Dt3/FmXBNLpSLL5+ZM98Ic/e80S04M+SOCMO3YjVDyxSCBI/o1BQvAHrXViSXxK9RzFt4qBaHMguOGX6Ji8pXIt2kPvE+nws3SHUrbScmcy3wTxXgaXJBIqSpa+0HzgDWVbwBDCx1tWmQrGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706627338; c=relaxed/simple;
	bh=h0OTDxBWOisgWB2yRwbr7R3YMVBdajhXN88i633Gm28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VreCwc+BmXgQv85PLCTOIhX0eonGQTW1q9EfwoFYE6kC7E/GWyFXVzX6LNTgZSCkbR2ocSCYHlEnJduym7pkwiFJQQ5lcczdFySNN/6qobP2Bqwvs0rPWdngdgD/pMnpWRqy/Br1gP8gzxp1u8XgR7H52ZH2icG0HDH6vl2IlKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=Uy6upPFK; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51028acdcf0so5049809e87.0
        for <linux-pm@vger.kernel.org>; Tue, 30 Jan 2024 07:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech.se; s=google; t=1706627334; x=1707232134; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aeOs16K1ggzcSxM81rroSW/PgSS9ODAboh/iGfdKq7Y=;
        b=Uy6upPFKyfMncgV3j33k4kHyf0E5Al+8vVcRar6WOabwFgwL5b+XRM5p46s0N+7uZr
         3fAaK40Cr8Y1EB4kmK+GAzmN938uKHMwdaZoz5ZBjASko/nZmgy5a375syWK+uSdMdWK
         YaoBq6Q6YfiJtE0RB07QXIi3MG5TbWThdcJK4bjXRR3RtgcZrC4ve8WXACa/IsTAQ7cE
         vWVP/0YT9CZBkWbPqswECFAzqPN5lVasHvyflbRnGtYsngppnx4AAKZOtbmO034Useha
         vyV1KX20Wsv0fjNZSNsqvv+khptlyaVKEeOC+lMuhZ4AIrWmVWk8FmeJhfUuZDNJJpPG
         cS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706627334; x=1707232134;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aeOs16K1ggzcSxM81rroSW/PgSS9ODAboh/iGfdKq7Y=;
        b=gSp3uyMsJHCFSwRyJJk/FugrRgnhlwWNtKHXVUC32y0RNPsWoejAXYgUEfFrBweUpN
         v3GTGBY1nYKU4SeVBpS2YesyYpScmS13z1vdIMeCTv8n2Kx42En88LzHg5Typ4x7Rmch
         K6cgOPtlpluCH6n++8k9bqEfbYS8SCD4IFOXYfbUQ8KX3gHjBl0GGiPp6DOUbt+5di3E
         otO049ZLcOgqTknNMpCatot2kwvYMZ3KVH3SCF9WPi5ZatzE1Si6yz8cCRAmqeDhhVk5
         EdWj0M0AV+3QFolX6rSGc6pJrXNcHu4jupPTfI2cwTGwraVcEwYQJNZZXVA0iIsCXr0B
         kOFA==
X-Gm-Message-State: AOJu0YwYp6Vm5Qnu8+2rCTIKDD2U08jS4r1jh+0gD2aPEoL2VkP7ANna
	GqcssgHs1RXDUCGs4l+0B+LVhjeeoqkSuwMRwpQQS949ngadxDbPnE9qRBTJc1w=
X-Google-Smtp-Source: AGHT+IF6B+jmXhpAUXU/JypBmBfGty/Zps7VOXIocvbWg2ZzM+V6LjpS3JB2V6IpNaOfUn05BOgkfw==
X-Received: by 2002:a05:6512:3764:b0:511:1fb8:a16f with SMTP id z4-20020a056512376400b005111fb8a16fmr928741lft.8.1706627333655;
        Tue, 30 Jan 2024 07:08:53 -0800 (PST)
Received: from localhost (h-46-59-36-113.A463.priv.bahnhof.se. [46.59.36.113])
        by smtp.gmail.com with ESMTPSA id v24-20020ac25618000000b0050f09876c12sm1491359lfd.208.2024.01.30.07.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 07:08:53 -0800 (PST)
Date: Tue, 30 Jan 2024 16:08:52 +0100
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: daniel.lezcano@linaro.org, miquel.raynal@bootlin.com, rafael@kernel.org,
	rui.zhang@intel.com, lukasz.luba@arm.com,
	support.opensource@diasemi.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-imx@nxp.com, andersson@kernel.org, konrad.dybcio@linaro.org,
	amitk@kernel.org, thara.gopinath@gmail.com,
	srinivas.pandruvada@linux.intel.com, baolin.wang@linux.alibaba.com,
	u.kleine-koenig@pengutronix.de, hayashi.kunihiko@socionext.com,
	d-gole@ti.com, linus.walleij@linaro.org,
	DLG-Adam.Ward.opensource@dm.renesas.com, error27@gmail.com,
	heiko@sntech.de, hdegoede@redhat.com, jernej.skrabec@gmail.com,
	f.fainelli@gmail.com, bchihi@baylibre.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH v1 06/18] thermal/drivers/rcar: Migrate to
 thermal_zone_device_register()
Message-ID: <20240130150852.GB2544372@ragnatech.se>
References: <20240130111250.185718-1-angelogioacchino.delregno@collabora.com>
 <20240130111250.185718-7-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240130111250.185718-7-angelogioacchino.delregno@collabora.com>

Hi AngeloGioacchino,

Thanks for your work.

On 2024-01-30 12:12:38 +0100, AngeloGioacchino Del Regno wrote:
> The thermal API has a new thermal_zone_device_register() function which
> is deprecating the older thermal_zone_device_register_with_trips() and
> thermal_tripless_zone_device_register().
> 
> Migrate to the new thermal zone device registration function.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/thermal/rcar_thermal.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> index feb848d595fa..7bf9c1611a00 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -488,10 +488,17 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>  						dev, i, priv,
>  						&rcar_thermal_zone_ops);
>  		} else {
> -			priv->zone = thermal_zone_device_register_with_trips(
> -				"rcar_thermal", trips, ARRAY_SIZE(trips), 0, priv,
> -						&rcar_thermal_zone_ops, NULL, 0,
> -						idle);
> +			struct thermal_zone_device_params tzdp = {
> +				.tzp = {
> +					.type = "rcar_thermal",
> +					.ops = &rcar_thermal_zone_ops,
> +					.devdata = priv,
> +					.trips = trips,
> +					.num_trips = ARRAY_SIZE(trips),
> +					.polling_delay = idle,
> +				}
> +			};
> +			priv->zone = thermal_zone_device_register(&tzdp);
>  
>  			ret = thermal_zone_device_enable(priv->zone);
>  			if (ret) {
> -- 
> 2.43.0
> 

-- 
Kind Regards,
Niklas Söderlund

