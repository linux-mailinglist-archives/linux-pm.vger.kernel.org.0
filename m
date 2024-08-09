Return-Path: <linux-pm+bounces-12032-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEECD94CA66
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 08:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95E4B285512
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 06:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88FB16D312;
	Fri,  9 Aug 2024 06:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="fsTqCxjA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA5A16D306
	for <linux-pm@vger.kernel.org>; Fri,  9 Aug 2024 06:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723184678; cv=none; b=SzfivSxJrO8MiqpLBhGtkWu5GSRi9R8c9biP8U7hJ2VyGIuIqmjkKxIfurNN9gCWpFeqE7OCVhLcumqB+YUehz7O5a4LwP98lqY7UlQDaVJjDemxV9JnhcHb+AMIamCC3oNDS8XK2zxUQ/m5Zz0IMNx3lVjlnS51i6d36wv4eIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723184678; c=relaxed/simple;
	bh=32PvQ3ZwcFq9EVY+VwEjYAa8YvEuHz3rO7T/75OdL3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=J0QUiLw7/F1gxTv4Fudme4UgisVE2gWhJO0Z4O374XVkIP44EL8p8pf27snSFEggb0p1Me5Ei0nx90Nkvay0uPjbspKglGgN7OMr015H4uC0DPU0hAHuuoOmCJF1RoTMPm6He5jQNwbOZyoLLR7O+WieyEq7Lv7Jvf6LcqLAalU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=fsTqCxjA; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52efdf02d13so3187761e87.2
        for <linux-pm@vger.kernel.org>; Thu, 08 Aug 2024 23:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1723184675; x=1723789475; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3S0qr9/Jv03AD+fUOeSyuNhsSFPzVg2JMztEACb1ujM=;
        b=fsTqCxjAokJ43lGYeVfqMFaTKLcojLQO9gN+FOuhjThJ9Ie3rcAvKT4cUCZA5eaOWX
         8YbL/kmotzN6cBnehLUMqdla/9pfIRjYScgrEsiQbNMzXlgAR6n4CR+rX9ffFUf7UNAB
         vX8miNNzBxdh9JiO/+Fvnum0lYJtt1DqGU81zN5oqbA8E+57fcIAJh3kgZ71cJevpqFX
         4XeZvdsX4rqYRijnGH8qiRTN2hJVNXoFDat7Ovol4rBjUpTAevzEUlOp23EUbKm4v+1O
         CkPbLNJ54E+cqXnN6lAyvN2aIouq9nggtsX6CHTxhgbS14BPUqGC9BGL2RO7oiTOwJ/w
         jHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723184675; x=1723789475;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3S0qr9/Jv03AD+fUOeSyuNhsSFPzVg2JMztEACb1ujM=;
        b=dWfblI6srdScc5ofo7qD+7NEHO6en0uswfnZi2A3JVBK01I4w6SysIvq4VnqNrRcln
         0ccDNeTlz2eN2UcEBsIPfCV+I1PZcshR4BhES6u9vFUJ7azA1bF7XpeLSsnTez+7YuXa
         16Cev8hPxzRzXb6Nv9/PxK9KYroE7WGHOOWF7v02vl/SQIAUXTfLyjtMNPOtJLWNnT12
         7JVV8mkgG5cgF1r/hSQeMvTVJnRbIxSy/VOPDqNzFxCvAP+H0TICOx6YpHKImKVd7N3Z
         D6AwH9zjJl6mRisClXjkvPOGxJ1FAPPglGsJsAFqI8LruvjoGeT5iZ52VcM1GpLGkS3n
         s3Yw==
X-Forwarded-Encrypted: i=1; AJvYcCU6GaZazyWKbzKS0VUuCetJh/RVymuV9V4EUd9wWCSHSDOTW+sm+/f2URMc78wxBUuWJZu4EYfhCkLRMFbGUq2TleuSj//ZJcI=
X-Gm-Message-State: AOJu0YwbbkObII2n7VzgDQH0wYtGRFS+fIvW1ucrn70OwecyciviDElU
	1tTepNofjdHOn6zw9/mR+GI8uJRyBrveuQL74km+4mcW63AdfLk4k3QUXM1Kfmc=
X-Google-Smtp-Source: AGHT+IFtRJSAy81Ovy9X/JT0lVaScHSB+oACg+nIrM17DzL37eBwuT4MrcU43b5nLMl8P8skePBRZg==
X-Received: by 2002:a05:6512:1392:b0:52c:dd94:bda9 with SMTP id 2adb3069b0e04-530eea1cf6cmr498847e87.56.1723184674977;
        Thu, 08 Aug 2024 23:24:34 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.180])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c61575sm811830366b.92.2024.08.08.23.24.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 23:24:34 -0700 (PDT)
Message-ID: <efcb1b43-2098-4490-8d10-b4f887ae862e@tuxon.dev>
Date: Fri, 9 Aug 2024 09:24:31 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/27] Add support for sam9x7 SoC family
Content-Language: en-US
To: Varshini Rajendran <varshini.rajendran@microchip.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, mturquette@baylibre.com, sboyd@kernel.org,
 tglx@linutronix.de, lee@kernel.org, sre@kernel.org, p.zabel@pengutronix.de,
 richard.genoud@bootlin.com, radu_nicolae.pirea@upb.ro,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, linux@armlinux.org.uk,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 ychuang3@nuvoton.com, schung@nuvoton.com, mihai.sain@microchip.com,
 andrei.simion@microchip.com, arnd@arndb.de, Jason@zx2c4.com,
 dharma.b@microchip.com, rdunlap@infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-mediatek@lists.infradead.org
References: <20240729065603.1986074-1-varshini.rajendran@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240729065603.1986074-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 29.07.2024 09:56, Varshini Rajendran wrote:
> This patch series adds support for the new SoC family - sam9x7.
>  - The device tree, configs and drivers are added
>  - Clock driver for sam9x7 is added
>  - Support for basic peripherals is added
>  - Target board SAM9X75 Curiosity is added

[ ... ]

> 
>  Changes in v6:
>  --------------
> 
>  - Addressed all the review comments in the patches
>  - Picked up all Acked-by and Reviewed-by tags
>  - Reverted the IRQ patch to that of version 3 of the same series
>  - All the specific changes are captured in the corresponding patches
> 

[ ... ]

> 
> Varshini Rajendran (26):
>   dt-bindings: atmel-sysreg: add sam9x7
>   ARM: at91: pm: add support for sam9x7 SoC family
>   ARM: at91: pm: add sam9x7 SoC init config
>   ARM: at91: add support in SoC driver for new sam9x7

Applied to at91-soc, thanks!

>   dt-bindings: clocks: atmel,at91sam9x5-sckc: add sam9x7
>   dt-bindings: clocks: atmel,at91rm9200-pmc: add sam9x7 clock controller
>   clk: at91: clk-sam9x60-pll: re-factor to support individual core freq
>     outputs
>   clk: at91: sam9x7: add support for HW PLL freq dividers
>   clk: at91: sama7g5: move mux table macros to header file
>   dt-bindings: clock: at91: Allow PLLs to be exported and referenced in
>     DT
>   clk: at91: sam9x7: add sam9x7 pmc driver

Applied to clk-microchip, thanks!

>   ARM: at91: Kconfig: add config flag for SAM9X7 SoC

Applied to at91-soc, thanks!

>   ARM: configs: at91: enable config flags for sam9x7 SoC family

Applied to at91-defconfig, thanks!


