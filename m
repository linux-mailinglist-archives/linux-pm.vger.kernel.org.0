Return-Path: <linux-pm+bounces-11079-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B26930A42
	for <lists+linux-pm@lfdr.de>; Sun, 14 Jul 2024 15:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3351F1C2126A
	for <lists+linux-pm@lfdr.de>; Sun, 14 Jul 2024 13:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34487136663;
	Sun, 14 Jul 2024 13:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="FACF3Chw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918E1132106
	for <linux-pm@vger.kernel.org>; Sun, 14 Jul 2024 13:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720964491; cv=none; b=daN4nviUkeflnGsQ3efZ9qk93IijcwsnQI1ikAC+aEcr/Q9XsSGFat7VUJKJjOjB3oThIbc6lzv5XOfevkq0mFMuGi6VePNWR+3TL+Km7UxY/ejUNIGGAEdHwn9rqXzCeiFZoLOntW21Zm9vAzOgSX5nKIsOba/EU318RycGiFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720964491; c=relaxed/simple;
	bh=nBfPreotN/WrxMiwWJk0/N1s90noTh+ul4zihYIDLuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kyRxBs57wHu7uzK8xReSUPFh/ehXnGPtnCPGyQEmY8jeBS757VU7DRb47uIBTVDzYM81dSD4h0HCLJ46UTvHvtE6j72Gmwst5LPE+LhUgNupKndCfLR10/OGUEj/9cv9GOLFxEM1qeH8RN0c+QmLKJYHWOmhxY9vECnufd9U3g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=FACF3Chw; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-367ab50a07aso2134702f8f.0
        for <linux-pm@vger.kernel.org>; Sun, 14 Jul 2024 06:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1720964488; x=1721569288; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jihw6LjoGxoxtoTBxFDRasBpW6zvsmRAV9veTSj6sFA=;
        b=FACF3ChwMp8QgQ5udtF3OZZYUaZqkWtyhs2fMkcRD/UGefjsYAb/9csFaLlh6gQe8w
         ytfFbbsaDZk70MiWEQYs0VXN6QH0deMssmuW3QBYGHSi6FGyWkWRHyeoZ3WZfgLd3UdE
         JsQeP0zS6MXe/5L6Ucaw6YML4OAlxFWx83MLfp4R48NkZFvEJ7ldHlj07goR8kIHhr20
         aoQeKkkzF+f/CNH9NxMDTR3DlyySmc7txpnhifOcqEBtIeAPMg1t3+lD626Lhx2auIVO
         MsxuvShQgmn+3xXMzy1M7yVO5QTyGJa9T4QCBrPNNNUS73YfooTqFZkKFRCADoZtZE0s
         2Tpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720964488; x=1721569288;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jihw6LjoGxoxtoTBxFDRasBpW6zvsmRAV9veTSj6sFA=;
        b=kxKK/FrymltL2T0ZoYaTdTFpSaHtllJWZahztfY5CXqlE1tM06sZKEF3tsNQ0E21Q7
         WPyG+CHLmjVIeCZ82AuOsju6UXa5px5KB/40nIxR3LSpU3/p7rvbbGP05czNsJp2ebFT
         Z12XNP6IvuOqb+YCgxiPNXh1jHZf/T2Ejmip7DXiLYchu5eFOv67bxqz5dQV7LbDPVkP
         t+YDEnLBI4tmPlfybXk456GftVaPaQujy2VI/5FdHeTYnTiVsMFuGAHvcxbMppIPN0wv
         DM13FAZxcye/uqRLBh1Hv9y+Ao8cYtZDd6YL3v0QSOfnqL9bwMbgZ7qf+Dd0lrmb8gxM
         aeIA==
X-Forwarded-Encrypted: i=1; AJvYcCVH1cvNJlTPCoD9fJ2M9DZ34kciQVE0i5gTFe0MNbYBbwxxnWVTwoXDKf0ZE+5L8zXZpbrz+dNgRtcOHuXrWxw4hpCCkwBvZzg=
X-Gm-Message-State: AOJu0YyMifpXC/cgM9kMGVJSxFM1wl1OjX4z7Q1gbtIH1x1PCaQTps+X
	0VdDvxx6zlGu5lbEUKCnzv3R2ImDbrOfvWLvoI+lRPHqebgb8/vSc5BUa0OaBcQ=
X-Google-Smtp-Source: AGHT+IHggpH+Y3o1aBi5tNvS934po/PJoMBxDG4GaFnY8NfPfS0+/6X/6pYmiXhWogFXibyM14aa4A==
X-Received: by 2002:adf:f20b:0:b0:366:ecd1:2f38 with SMTP id ffacd0b85a97d-367cea45cb1mr10565682f8f.7.1720964488117;
        Sun, 14 Jul 2024 06:41:28 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f276a62sm87036695e9.24.2024.07.14.06.41.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jul 2024 06:41:27 -0700 (PDT)
Message-ID: <7ba0d06b-a6db-47fa-b6be-894b70207bda@tuxon.dev>
Date: Sun, 14 Jul 2024 16:41:26 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 18/27] power: reset: at91-poweroff: lookup for proper
 pmc dt node for sam9x7
Content-Language: en-US
To: Varshini Rajendran <varshini.rajendran@microchip.com>, sre@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20240703102011.193343-1-varshini.rajendran@microchip.com>
 <20240703102834.196209-1-varshini.rajendran@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240703102834.196209-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 03.07.2024 13:28, Varshini Rajendran wrote:
> Use sam9x7 pmc's compatible to lookup for in the SHDWC driver.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

The suggestion from v4 still applies to avoid increasing this array.

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
>  	{ /* Sentinel. */ }
>  };
>  

