Return-Path: <linux-pm+bounces-23437-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7246A4EA27
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 18:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC1361894D22
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 17:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3A9290BC6;
	Tue,  4 Mar 2025 17:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="jWlMsxws"
X-Original-To: linux-pm@vger.kernel.org
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B319290BA9
	for <linux-pm@vger.kernel.org>; Tue,  4 Mar 2025 17:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109546; cv=pass; b=ap1jW9WpcFESTD7Sdxa6SxroPmZhL3hDmYxj1KqYI2ofJC339/a4LalFdnC6mUjRnmBxXJFs00xbuUHFv4uaqsPEi6530LRC69+zwbYaboyW6skTY/u3pzOe2PZj+HDlKwqTPxxvljT22+RtjfnLojdgP92U8p965UNx81hyytw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109546; c=relaxed/simple;
	bh=ZQkQ0v+LVOjnnddsmiqkVeGvaIQ78BApCBN3whw0Bh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dB5OUtZrRY+NfplovsqmFwrHnNHGIPgwjlvehF7XYtFDzYhs6lvGvFliO1i3zumlH33o0cQh+K/85zr0lJHQVERBVP7R6K950czt75Sgxf1xYXz6A0OQKwURZXjfbdpA+GZ7Z68Oe7Uz6MRl6csHNJA2fQqj5PGerslT7hi9K20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=jWlMsxws; arc=none smtp.client-ip=209.85.218.44; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; arc=pass smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id 8B31940CCF24
	for <linux-pm@vger.kernel.org>; Tue,  4 Mar 2025 20:32:22 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=tuxon.dev header.i=@tuxon.dev header.a=rsa-sha256 header.s=google header.b=jWlMsxws
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fvM0TZxzG0wT
	for <linux-pm@vger.kernel.org>; Tue,  4 Mar 2025 18:37:35 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 342AF4272C; Tue,  4 Mar 2025 18:37:27 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=jWlMsxws
X-Envelope-From: <linux-kernel+bounces-541169-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=jWlMsxws
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 83B6142B07
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:37:56 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 4D5F62DCF6
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:37:56 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4152A188CF0D
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 08:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB991EF0A9;
	Mon,  3 Mar 2025 08:37:40 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6CA1EB19D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 08:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991057; cv=none; b=fTv6MtNAndX9eWP1LDxhkeEEmRJlu8l+1D728psM1oIaY1lhxALFth8A1c2zbBeSEKAcjniEJDJWvopEQaaks/nWQigD9VZ3F/y5jWUQZR5eofGBPchagUuCDENoUMB0/fbciPGGl+1E5rROXNVDv2tpNqddGHmuhboPxo8Qv2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991057; c=relaxed/simple;
	bh=ZQkQ0v+LVOjnnddsmiqkVeGvaIQ78BApCBN3whw0Bh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BIdxHfuTEM8wMCwK8Q3RleBiPEJ20wgBuYukV+hUYqKJ9obh+Z0x+MMDMLiy/DK2WGOrKN5/NzVBNhI3uU/jgG/gK5tWBZP15kmPHJFiFXDXdeXTRH4wed+jaObTXgMx1RGwrxjlTBY/sQV7asuWk4HENQQarKAkXVoc7wXE6pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=jWlMsxws; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abf5358984bso254592766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 00:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1740991053; x=1741595853; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rHzoEXcX3rRgSypgjLl/rpTLfRP49fuHATm+VBKv9lY=;
        b=jWlMsxwsUDdonJkhTqhHJvmcLaMy1EI8DH1KqPBmYNwOKGbMDZ0YzFUW211ZNRN/bt
         VSR8XGrNGFpqhlB61NnOUGuH5wSamTWUCcYHbn+BA9TVfRRq4w/SZ4RFddi6W+q9vMBg
         UyJhH7g1QmdARr7zNXFgwNjp3qI6DvwVxvQnFREZ3joNm2wGQlRq1vIXAwKetKcuVmrI
         lsZxcOBW0kBCWxm9nbJM7LqpQZGZLDhco/wUt7so4WCsUMNO90+K9483EhLNDdCQ88FO
         fZ4QIiMjYS9ntnC60o6Db2zG79kWCai7wKYxwG4Ilq7xfAlVwwtZLZMTvadCRpl4gEiC
         aY3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740991053; x=1741595853;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rHzoEXcX3rRgSypgjLl/rpTLfRP49fuHATm+VBKv9lY=;
        b=qsV/NcEQBkfpANlMRIRVv8Eqh4Of4qTtO0gB6yCc5Q8pNzW7e7Q7SG10HrnAIt0XwN
         1/W5FHudmNx/wWWYSGIdwTItToWWnmcZWj8wdZcDt5NJKCm3thwtJuklIEvBVuWdZ5PD
         +80oaL1FvJlHenXh4gKuHxxvYkn/h8tJNiQbjcLXFxjRyl2qYNr7J+4r4stVgapwFbIk
         UFAfd8oI+/NZ9FeArIvTkexHhx/9p0fuqWE3DD9uBRfP8WyP46tpegmMwyCQ7X31zPyH
         GWS19yTdk/B+gxlPpjSduvq84FBnrzQS8JMvAglC1SskMwgZbPTvJ8cFNCoyqqfNZQ0r
         CFWA==
X-Forwarded-Encrypted: i=1; AJvYcCVTvZilf/CfUiR1gtIhJedNuDTofQ5tDFhaQGikTk7DoAFQnfKo1GV88JW6wZLaWdV8QtRdwBPiuMK3GD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzOApEQNRZLKYjrpufDYqb38lTCV1EoS3xCvVxrRR5iUZsCdyz
	Pfgp+cmKAwYOrFk3/vES3OhO/vWTE/D6D0EzqdIuUvURyxARRJBIhFw5xhQlhTA=
X-Gm-Gg: ASbGncvWTY/MZf5MFAl4Xo2eXx2KYV/W7MFw/Zh2U2Y4CazX0hK8D+N/mdyHSEaaRBO
	StGzKGy1U1rkbyGiKHZinoniLGvCavAMt6OR94xTPXtnTYpvNEbDjD6hyljOSK5ghH7T3+yh4dv
	3RXzgk1mq5FYW2XT6KSsZuHg70/h2gd0zRhxKDzclptd/baCpo7ezrLvjpjVwPty7AoDLzA0+WF
	5kQNnMzqopDNQhruC3X9baM10rqbO35xFqqg82CBbgOw/4rl2s7rRMGY3zaBoi7ZVkHK0ZDVM1a
	6yRMiqI6CGdBzYfAFWUgTtbkzKZuemsZNAOe0vC8BczxVOkADfPfCrsg
X-Google-Smtp-Source: AGHT+IEu4SCH3E4lm5pHLGphX1D/WhBV+YCMGBhWUNyZogIyLMScbPiRPIx0Mz9hoI+7dm2HVL+OtA==
X-Received: by 2002:a17:907:97cf:b0:abf:38a:6498 with SMTP id a640c23a62f3a-abf26708c88mr1540344766b.55.1740991053091;
        Mon, 03 Mar 2025 00:37:33 -0800 (PST)
Received: from [192.168.50.159] ([82.78.167.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0dc601sm780828466b.68.2025.03.03.00.37.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 00:37:32 -0800 (PST)
Message-ID: <81354810-14e6-4840-9e50-52bdd0e63b95@tuxon.dev>
Date: Mon, 3 Mar 2025 10:37:33 +0200
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/21] ARM: at91: pm: add DT compatible support for
 sama7d65
To: Ryan.Wanner@microchip.com, lee@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, sre@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 p.zabel@pengutronix.de
Cc: linux@armlinux.org.uk, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
References: <cover.1740671156.git.Ryan.Wanner@microchip.com>
 <06b64869f2de4b499835d153411ba30512409168.1740671156.git.Ryan.Wanner@microchip.com>
Content-Language: en-US
From: "claudiu beznea (tuxon)" <claudiu.beznea@tuxon.dev>
In-Reply-To: <06b64869f2de4b499835d153411ba30512409168.1740671156.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fvM0TZxzG0wT
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741714225.16425@jkrLJWU7rtl/Tp9poioXEg
X-ITU-MailScanner-SpamCheck: not spam



On 2/27/25 17:51, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add support for SAMA7D65 new compatible strings in pm.c file for wakeup source
> IDs and PMC.
> This is the first bits of PM for this new SoC. PM depends on other patches.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> [nicolas.ferre@microchip.com: split patch and address only the pm.c changes]
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---
>   arch/arm/mach-at91/pm.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index 6c3e6aa22606..39644703244d 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -222,13 +222,16 @@ static const struct of_device_id sam9x60_ws_ids[] = {
>   	{ /* sentinel */ }
>   };
>   
> -static const struct of_device_id sama7g5_ws_ids[] = {
> +static const struct of_device_id sama7_ws_ids[] = {
> +	{ .compatible = "microchip,sama7d65-rtc",	.data = &ws_info[1] },
>   	{ .compatible = "microchip,sama7g5-rtc",	.data = &ws_info[1] },
>   	{ .compatible = "microchip,sama7g5-ohci",	.data = &ws_info[2] },
>   	{ .compatible = "usb-ohci",			.data = &ws_info[2] },
>   	{ .compatible = "atmel,at91sam9g45-ehci",	.data = &ws_info[2] },
>   	{ .compatible = "usb-ehci",			.data = &ws_info[2] },
> +	{ .compatible = "microchip,sama7d65-sdhci",	.data = &ws_info[3] },
>   	{ .compatible = "microchip,sama7g5-sdhci",	.data = &ws_info[3] },
> +	{ .compatible = "microchip,sama7d65-rtt",	.data = &ws_info[4] },
>   	{ .compatible = "microchip,sama7g5-rtt",	.data = &ws_info[4] },
>   	{ /* sentinel */ }
>   };
> @@ -1379,6 +1382,7 @@ static const struct of_device_id atmel_pmc_ids[] __initconst = {
>   	{ .compatible = "atmel,sama5d2-pmc", .data = &pmc_infos[1] },
>   	{ .compatible = "microchip,sam9x60-pmc", .data = &pmc_infos[4] },
>   	{ .compatible = "microchip,sam9x7-pmc", .data = &pmc_infos[4] },
> +	{ .compatible = "microchip,sama7d65-pmc", .data = &pmc_infos[4] },

According to the chapter 42.18.3. PMC System Clock Status Register at [1] there 
is no AT91SAM926x_PMC_UDP for SAMA7D65 (which you are dropping in the next 
patch). This patch would have to reflect what the documentation say instead of 
fixing it in patch 12/21.

Thank you,
Claudiu

[1] 
https://ww1.microchip.com/downloads/aemDocuments/documents/MPU32/ProductDocuments/DataSheets/SAMA7D6-Series-Data-Sheet-DS60001851.pdf

>   	{ .compatible = "microchip,sama7g5-pmc", .data = &pmc_infos[5] },
>   	{ /* sentinel */ },
>   };
> @@ -1672,7 +1676,7 @@ void __init sama7_pm_init(void)
>   	at91_pm_modes_init(iomaps, ARRAY_SIZE(iomaps));
>   	at91_pm_init(NULL);
>   
> -	soc_pm.ws_ids = sama7g5_ws_ids;
> +	soc_pm.ws_ids = sama7_ws_ids;
>   	soc_pm.config_pmc_ws = at91_sam9x60_config_pmc_ws;
>   
>   	soc_pm.sfrbu_regs.pswbu.key = (0x4BD20C << 8);



