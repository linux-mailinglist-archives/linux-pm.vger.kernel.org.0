Return-Path: <linux-pm+bounces-23259-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC360A4B93A
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 09:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4019218873ED
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 08:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12ADA1EF0B2;
	Mon,  3 Mar 2025 08:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Lhp5eRfD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F5D19D092
	for <linux-pm@vger.kernel.org>; Mon,  3 Mar 2025 08:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740990417; cv=none; b=rjCHeqG/ts9PKJ70YOwRXZfc9MyMRYijDNCDy93UUq3pA4eOwQw/g4fC4GF8o/oucTyuMhq6CuYizcZQnPO96KTg34CCVtVb21k4fyFA5bACW6bo8Gean33t6nvD/8xhRKMfthvEBw6JTFY9YG9oa2lpojZ7z27tMHI3/br7hCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740990417; c=relaxed/simple;
	bh=lJXPyymC+Bn7eNg7QGwNenIBMEiR5kuGsl3f2E+vwL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rQ5L69tbDCTbIW3bk5e2FXd4HXO/I9DJSdD1Pj+sdjhw6qgcyEk63mjrcwR1B5zJa7MEdksLAXu6nOMxG8zqXsAzIUW6GIPpJIgOiJbBNbDMmG7KdXchXX247iyYMyVOefgm+tcQH+KFbRtvolUOCb7QbYYWaXmCfo+L0iBc3yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Lhp5eRfD; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abf3cf3d142so311042666b.2
        for <linux-pm@vger.kernel.org>; Mon, 03 Mar 2025 00:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1740990412; x=1741595212; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BD0ged1tbWk7V8+0mBgsPRbGV+NS/Ji1P1tciZQV6bE=;
        b=Lhp5eRfDH8wGcAYGfwM89OO+e8ZKEvJ8G30YTmuWKwp3UwHrBWUElxio4311xTFaJZ
         dfibFmO7LQnho+Rwu8SoiCWi3y0BcDd8CQwttwW4XbP1kRxVEeFw7VkauJymrzUupTY2
         ayMGbkBrgQL/puxu8MZne/R5KP6Dj3CuMceUAXWke2RtcXJMDl64/OBDylZpKTZNK1kG
         IXaKee8r5vtGMxUEICWpLi6VGe6FaJbuSVnCDrjpxKlzJqx1skg27aC0NvK1Rwplz8jl
         OkPgh4AkdndEYYAwrB0H4j2k2TFAS63K0KqhSygfYsVH5yAG8bMDPDMo2r1aoZRtWDji
         2+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740990412; x=1741595212;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BD0ged1tbWk7V8+0mBgsPRbGV+NS/Ji1P1tciZQV6bE=;
        b=Jj2BNBC1Sj8u18WhgqRVDJmW0PHfrCJ5mps6AKpOX2Ca5XdTdz1tmOE4taSVIwKax4
         nxF/j+Pc8v2WRAJuknBAOlxqg8VyNKwmcj5PG/lxvSimLzoEMxJFKXXIoH0e8WPhpGq4
         fabjTUxJLe5UmZpnXeisiQqRFa6tjFxX4wXbqATpolTDHX94N7+W/IbfMN4lpO7PzgdI
         CQsq2fxeRDxxJ2IRxCYvzm1rkMw8XuXTMh9vGI/OxYFRPyZuXUA1RBw0AJVF89SDLTBy
         ajbP8gJ8SL9ewL2l8eGF687hVs9ucd34+i/OAGz7uTjE1zh5F89hYfO/CBmuHbA+UGRb
         Dq6g==
X-Forwarded-Encrypted: i=1; AJvYcCXoOMKY7TWFKd+GwztLwUgh5uyXkFKSE0CeZ4S3URq75NODKppt0j2A4HKoJnAR3WxAE5sodP3OkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc7K8OfFzRl5YPRYjuhmunxZQb+WPGkYNgzPQU5mVjMgJ44DSm
	FQ0/ZCmT73BgVwDBqHJgRmuhNKBFFjhrTEugehLgfXsLb/CUYWq3uspXH4f5G4w=
X-Gm-Gg: ASbGncuCLxoYntWM5E95fisYNP5dGLfJcmH5kDhHhBgEI/s6TGTheSMH/tj19Zh0K40
	GItjONwR3SKvdGhQJh6H9RLEJzQVZKv8vQvanFgClADmMH1qNZbZU2t8HL8O+77tswadrt3UHL0
	l77+3LYK/vvaWZlHVCY3CVTIrZ6Ni02N7pcJM4NjXdYnBOPtvKrA4sZZHDxMC7w3e0bwf9M+vZp
	g1VkjxFO8mynvIJ1yZL0z3N7rKuSkl6nmtdm+yFx3LykLj3+3cqfPXEzlQuwVCFTGGRJvB1fR5E
	WkPk0zLT/JM8A9rZ1L+TVpdf9WF6bhhBEPXiPGLLHziSevWpjwWijA==
X-Google-Smtp-Source: AGHT+IFB0ef71YNR9dJGXCO7UqAzxgYbd67xW8P9JXXgL21idOk1dW4h3KG6K2wPSXyAzJ2F6c4cew==
X-Received: by 2002:a05:6402:2692:b0:5d0:bf5e:eb8 with SMTP id 4fb4d7f45d1cf-5e4d6b4baabmr28693051a12.23.1740990412164;
        Mon, 03 Mar 2025 00:26:52 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c6ee491sm776723966b.103.2025.03.03.00.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 00:26:51 -0800 (PST)
Message-ID: <f03946a8-24bc-4a1a-8d06-d5652a4db34f@tuxon.dev>
Date: Mon, 3 Mar 2025 10:26:49 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/21] ARM: at91: Add PM support to sama7d65
To: Ryan.Wanner@microchip.com, lee@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, sre@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 p.zabel@pengutronix.de
Cc: linux@armlinux.org.uk, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
References: <cover.1740671156.git.Ryan.Wanner@microchip.com>
 <f4634d70f1e7002db059f2cc892fbbbfe1a95dac.1740671156.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <f4634d70f1e7002db059f2cc892fbbbfe1a95dac.1740671156.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ryan,

On 27.02.2025 17:51, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add PM support to SAMA7D65 SoC.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  arch/arm/mach-at91/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> index 04bd91c72521..f3ff1220c0fb 100644
> --- a/arch/arm/mach-at91/Kconfig
> +++ b/arch/arm/mach-at91/Kconfig
> @@ -65,6 +65,7 @@ config SOC_SAMA7D65
>  	select HAVE_AT91_SAM9X60_PLL
>  	select HAVE_AT91_USB_CLK
>  	select HAVE_AT91_UTMI
> +	select PM_OPP

This is for OPP not PM support. For this series this should not be needed.


>  	select SOC_SAMA7
>  	help
>  	  Select this if you are using one of Microchip's SAMA7D65 family SoC.


