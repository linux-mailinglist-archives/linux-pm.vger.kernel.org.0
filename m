Return-Path: <linux-pm+bounces-4622-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2867F86F4D1
	for <lists+linux-pm@lfdr.de>; Sun,  3 Mar 2024 13:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88FC2B20AE3
	for <lists+linux-pm@lfdr.de>; Sun,  3 Mar 2024 12:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DABBE62;
	Sun,  3 Mar 2024 12:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ZP5U4kxE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92941BE5D
	for <linux-pm@vger.kernel.org>; Sun,  3 Mar 2024 12:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709468565; cv=none; b=P/hk6u4eWrVzWj7xlabghqfC8EvFL3wujbNp+h3OqGEN6eKh4FFzbXglau73iVgLOyoW82ySQERFB4ODbJ4zysr9qEk9bEjBWN3XoPsyVI9qTc5utUE4li83ym8w0gDA3LEz3qSARX6gR+2/S9DSchTmgft4OejxOSKr9YFu+zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709468565; c=relaxed/simple;
	bh=AgQGKG1txHLWS8ImEhfnYrC9R9R6mULK4U8TwmPHZL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LUHnxGwH6rdl9Zhm+FeJvzbQwR15LleK7j4IDPRDbMv8Sc0yv9noMvbr4XaC2tf6ERyzjXoZCP7qssakErqdUcsF5hlT5RYihMG4fMWxSAHc+KRH0Sog6M9qV4uFpoNH5YPPZfX7Cq/LmpOT58tOszXU0B+NGCUlsu90YPp8ZZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ZP5U4kxE; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33dcd8dec88so2196655f8f.1
        for <linux-pm@vger.kernel.org>; Sun, 03 Mar 2024 04:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1709468562; x=1710073362; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LeuiFF7R2tbAvv2UiI2PaXeJiriCJov3tu3mur7RTtA=;
        b=ZP5U4kxEzdGczoHSJKE09oWCgmVV3ZluyAyDipgaxpKMHyrDq20im/Q/dHQqoNc/zL
         dEd4s5ZQNiKQ9KEU2mOF3Osiz4t6TvRCQgtHGFH6j5Yx1eHhcCHuqC7xaksKxHz5LCSx
         78HyPP2g8aiXYiHzSUO/CR++spE0Mcn7+D4Uc3ChGFR9afzaYzdxG0GBLCe3sOIjKklx
         zAsEoTyhtdAl4Bl6Z8e6zdXIPtKBUs0wARlco69aLJi2DzCcniVKLjwWUPAHyypu26M+
         JwVhZOkngpOYEq8HSGhvf1RKTAQaleW0XgnIy5V2vBHiIu4ueCDXE4p5YEI0A776l9uq
         RUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709468562; x=1710073362;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LeuiFF7R2tbAvv2UiI2PaXeJiriCJov3tu3mur7RTtA=;
        b=MUhdJ+UVX9I63N7Y++TPWOI9MT9DMQWBubamkDb45oq5dCV88EzWJsh32TSlaHdoxJ
         UDnWv9vsfz9QPJhRDLauRZhBHNj0XtyPDVCPTbtBRAQbF9s9y7NRdv5/gpBaW2OBGu+M
         KKNeMlzkjpdQf/hr+VsHsUS+Vocc5MuLciDgrn/v04kXXbghifu4YCjxqXUY/leMM8Ca
         O9666dVOlyXG5vzOuqFF3phGWPXcuMqyWuMTOxh3mu5bD/Fh/OizjGy9d208Z3n2F9iC
         S6EYVIkQhxPoF+jOnkF1pybJsPihmi+q4nMrGe9L8Ptasn8fUy6od71dwFDkX5zazelM
         5l5w==
X-Forwarded-Encrypted: i=1; AJvYcCV+ZjTg47hag2DZQlAoYBGj8bvMh04ofPvN/Vguvf2TELF/YRTeO5x74W1iaw0yuGH8HG7g4OkHfVAGGNgON3AD7Tf4h/yoA4o=
X-Gm-Message-State: AOJu0Yy6IwUpM/HmaVJv0DY8CEIZY/+x2A1wWB7DpyEJVDhds9uC2gNS
	9UZyJbe875JpjzgIEeiTZnPy5TXv4pbDrmDPfZhNmqQNiDhF4pwggOUQyLaazco=
X-Google-Smtp-Source: AGHT+IF20EOBE7aJ/x79yakSrTL0/aE5yoWoNlwT5Z0ESnkPtvvcc9ML76lCqjtFRth7j+EnygarBw==
X-Received: by 2002:a5d:4150:0:b0:33e:164d:c8c3 with SMTP id c16-20020a5d4150000000b0033e164dc8c3mr4775457wrq.31.1709468561818;
        Sun, 03 Mar 2024 04:22:41 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.38])
        by smtp.gmail.com with ESMTPSA id dw2-20020a0560000dc200b0033ddfba0c67sm9477927wrb.41.2024.03.03.04.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Mar 2024 04:22:41 -0800 (PST)
Message-ID: <c4e00fb5-3124-4b2d-a096-11f6e5b86758@tuxon.dev>
Date: Sun, 3 Mar 2024 14:22:40 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 30/39] power: reset: at91-poweroff: lookup for proper
 pmc dt node for sam9x7
Content-Language: en-US
To: Varshini Rajendran <varshini.rajendran@microchip.com>, sre@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
 <20240223172920.673110-1-varshini.rajendran@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240223172920.673110-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 23.02.2024 19:29, Varshini Rajendran wrote:
> Use sam9x7 pmc's compatible to lookup for in the SHDWC driver.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
> Changes in v4:
> - Updated Acked-by tag
> ---
>  drivers/power/reset/at91-sama5d2_shdwc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
> index 959ce0dbe91d..2121d7e74e12 100644
> --- a/drivers/power/reset/at91-sama5d2_shdwc.c
> +++ b/drivers/power/reset/at91-sama5d2_shdwc.c
> @@ -326,6 +326,7 @@ static const struct of_device_id at91_pmc_ids[] = {
>  	{ .compatible = "atmel,sama5d2-pmc" },
>  	{ .compatible = "microchip,sam9x60-pmc" },
>  	{ .compatible = "microchip,sama7g5-pmc" },
> +	{ .compatible = "microchip,sam9x7-pmc" },

Maybe would be better to add a phandle in DT instead of continuing
populating this array. But then the backward compatibility should be
preserved. I leave this to Sebastian.

>  	{ /* Sentinel. */ }
>  };
>  

