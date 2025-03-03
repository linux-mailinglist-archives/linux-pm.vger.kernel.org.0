Return-Path: <linux-pm+bounces-23263-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FBBA4B982
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 09:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5FA3188C8E7
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 08:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F010F1EDA0D;
	Mon,  3 Mar 2025 08:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="GTwMmdPn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8C41E9B31
	for <linux-pm@vger.kernel.org>; Mon,  3 Mar 2025 08:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991066; cv=none; b=Qnaa4o9noMJsGOc3pwMH35zUptssnwDaKv2NczK0fwvoFrnsGVlZZhM/+DpgUA04DvINRG1sX/otJJZQm9+D33IABrGzQXEbJTQbqsWOpHotfhrJlBfEn7tJzAtpCnlz9sbktVDHRTDY3scHnHFBh7iB68AlByLwGRmIQoQ8CRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991066; c=relaxed/simple;
	bh=RK+QYQOjVVok1aZddoO9G5Ba4alVGQm4Od6mXZJOVrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l7ontAzi5NdWvHVCudWfYCsZXUZx+e74wV6eE+8hdxqElwcWa5YKUG3UQE9yYJ2o+lcD6HYNzU6J9nDXVTcfKN3DxkUa4dYtX3TAuFfvX3V9iY9xxeCg+YYCpPmMh0zJvhI5l3TGnyVOMk2NIRnOAR+UjMtm5zNBrZ0P4XFMg0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=GTwMmdPn; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abec8b750ebso723905366b.0
        for <linux-pm@vger.kernel.org>; Mon, 03 Mar 2025 00:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1740991063; x=1741595863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=088gCiVsmCpfljLz/WNF5os3OZWs6Dr62hIApojY3d8=;
        b=GTwMmdPnOt4JdMYnuZd0BMPrJfhOGVMFGyaIt30eGyGKH88mrDBAzuCfb/8W5gXcoy
         Fi0uy9lBo5b+sX6jQwzO/TDHvHWK+HQ1iD2HimnqoKKc3X9eeKxHTqBk7fAMzKMe7ITd
         GNspcevs36/PtIIe/M4DnImUflW+aYnaeFBZ2YhmvcrpsGZFM7rNmzpGAJqBJ1tfWeC+
         L/h+qu3fKXDM9nLcrDaz281esofKd3ZoO1E+e7XW9UMkROxWf0HeLO8RKiKKWwvyXNf7
         K8v7lThakNbJ8u5gSwcEum02YRFL0CJc2ABSIZROxqE9G47oFCC9y5epW7El/7yx/rIP
         TR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740991063; x=1741595863;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=088gCiVsmCpfljLz/WNF5os3OZWs6Dr62hIApojY3d8=;
        b=u38XsgBxskoJrAdvy05Hq3W53ZYNAMJQ3T9271kiaNTVZ7VLEgw84T+v1mR4/wfyw6
         qtHUbGZOoe3W2cv46gAv7CXBMxpjPPFkX1+/bh2WHeiRw4B4kgdWatBT4cHFgEgDttOq
         TUmI/YqCn2JY4oZo5HbbFevZDXKAPTBBk6EBwZOd6wk9ypJQhV8jjHuaF391INKumy4p
         eCUEznIfx05m/FbDBR5+67ubCRB+fqyRRc5O9E8cbogWGRJ9K5JhqLYj0ORLNzwtIBu/
         g3rotyH4ftzZkVuCdh9T6AfS6kJgpuIEd0NqdTWUhDJC4+szXg4nKfZUDPTzP17Cv0gJ
         U97w==
X-Forwarded-Encrypted: i=1; AJvYcCVHmyKp5xlaWMT+5XbxkH2R4TL3mC2rpV8COE6NdvDd/DbCqgSqLjw45Y4JnIJJ6z8z1NacaW0iGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIIp5B7KFikXf8gLltVYy8pkaayD3KBusve5k9Rpf4gNcLKIsL
	dFVKCl2h7UOLey5AZhEgp2vy7fzf4FYuSsIGZoccSISjJK8O+e4JQLjFLh0tIlA=
X-Gm-Gg: ASbGncuCM5ieDBy56/61q2BnI/X6Ob2zFGc9Bwzpk9t3l8G5l+3Fzqhra840P4Sdg4D
	g1E3gOMVCLlb/ia0Ihu8IQMs7qh0TVoYecqXMF9J8yKAELt3ikL5drcXt27cBC5w/IC+Todgq40
	P64GMDHXPGboRvB6f7BD6t5Ayx4pVPAZ3jAHYW6GdSY62dOGzno4av3tlxxtwXS26GdcOE9no05
	Rr2qgVzewY9KKAo2gWfxyA8WsjYfHxcPfj5+uFeYk1qoagKJvsyFjGTAgAZTa7VjLYWfUAZD8c0
	2oh/b1m/U6e++pai4pCi3tIL5he0bjh1XssgxfyK4dsTGJGLfR6bZq+T
X-Google-Smtp-Source: AGHT+IG+mwXTx4eDAQj8AAOugFy3UaMktA3JlzKQWx74RnnVc1/k+KU8S1qfjCYJPEbQsqpxnNFduw==
X-Received: by 2002:a17:906:6a28:b0:abf:749f:f719 with SMTP id a640c23a62f3a-abf749ffc45mr408409866b.7.1740991063333;
        Mon, 03 Mar 2025 00:37:43 -0800 (PST)
Received: from [192.168.50.159] ([82.78.167.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf19aca8a0sm730375166b.178.2025.03.03.00.37.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 00:37:42 -0800 (PST)
Message-ID: <45713e88-57af-43c7-bf0b-4583383b10dc@tuxon.dev>
Date: Mon, 3 Mar 2025 10:37:43 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/21] ARM: at91: PM: Add Backup mode for SAMA7D65
To: Ryan.Wanner@microchip.com, lee@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, sre@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 p.zabel@pengutronix.de
Cc: linux@armlinux.org.uk, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
References: <cover.1740671156.git.Ryan.Wanner@microchip.com>
 <3a1f59af1ac9322b0203694b535d5d13120a31eb.1740671156.git.Ryan.Wanner@microchip.com>
Content-Language: en-US
From: "claudiu beznea (tuxon)" <claudiu.beznea@tuxon.dev>
In-Reply-To: <3a1f59af1ac9322b0203694b535d5d13120a31eb.1740671156.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/27/25 17:51, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add config check that enables Backup mode for SAMA7D65 SoC.
> 
> Add SHDWC_SR read to clear the status bits once finished exiting backup
> mode. This is only for SAMA7D65 SoCs. The SHDWC status register
> needs to be cleared after exiting backup mode to clear the wake up pin
> status.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>   arch/arm/mach-at91/pm.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index 39644703244d..d82a507bc8da 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -647,6 +647,11 @@ static void at91_pm_suspend(suspend_state_t state)
>   		at91_suspend_sram_fn = fncpy(at91_suspend_sram_fn,
>   					     &at91_pm_suspend_in_sram,
>   					     at91_pm_suspend_in_sram_sz);
> +
> +		if (IS_ENABLED(CONFIG_SOC_SAMA7D65))
> +			/* SHDWC.SR */
> +			readl(soc_pm.data.shdwc + 0x08);
> +
>   	} else {
>   		at91_suspend_finish(0);
>   	}
> @@ -707,6 +712,7 @@ static int at91_pm_enter(suspend_state_t state)
>   static void at91_pm_end(void)
>   {
>   	at91_pm_config_ws(soc_pm.data.mode, false);
> +

Not needed. I'll drop it while applying.

>   }
>   
>   
> @@ -1065,7 +1071,8 @@ static int __init at91_pm_backup_init(void)
>   	int ret = -ENODEV, located = 0;
>   
>   	if (!IS_ENABLED(CONFIG_SOC_SAMA5D2) &&
> -	    !IS_ENABLED(CONFIG_SOC_SAMA7G5))
> +	    !IS_ENABLED(CONFIG_SOC_SAMA7G5) &&
> +	    !IS_ENABLED(CONFIG_SOC_SAMA7D65))
>   		return -EPERM;
>   
>   	if (!at91_is_pm_mode_active(AT91_PM_BACKUP))


