Return-Path: <linux-pm+bounces-23440-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08425A4EB37
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 19:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA14F17F7D3
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 18:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E73293B5D;
	Tue,  4 Mar 2025 18:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Y0D+xgHV"
X-Original-To: linux-pm@vger.kernel.org
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1613D29346D
	for <linux-pm@vger.kernel.org>; Tue,  4 Mar 2025 18:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741111273; cv=pass; b=GbWSKIAruFTwLhz3SCFvuEYpkQQliOm0NFqLrs9THfWvFjB27Q2uts83Y8q28DMvF18Kj2xWBb6LN2S9PhULteuoNFjf66wDim1zLBft61Z/FygGU3nqTw8URVua6eM8U74O27quEqyCymqN6fZEtfkiGYvbVNv/ob43MvZy+HI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741111273; c=relaxed/simple;
	bh=qoPtDOyTcjwvCpBRIB3CYa8gwUoF4qiW66mIwy/6yyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AaP4eXvzJH5ULW6RBaOJ/CKD2vJOR8OzKBymMvWonkROdiUlwlafEJ2f8nCMajrr0tsDcbIPkm8xJtjZijXE3ZTk367HGCRCzhH33zbrBoculb+DCch2vqPtGBIvr31//SUhp8TIvNyFOSgSc1vh4MI3/mz6r8RtFbTKGPEQu04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Y0D+xgHV; arc=none smtp.client-ip=209.85.208.42; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; arc=pass smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id 4F000408B64F
	for <linux-pm@vger.kernel.org>; Tue,  4 Mar 2025 21:01:09 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6g6l5cXXzG1B7
	for <linux-pm@vger.kernel.org>; Tue,  4 Mar 2025 18:47:27 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 9035742727; Tue,  4 Mar 2025 18:47:22 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Y0D+xgHV
X-Envelope-From: <linux-kernel+bounces-541158-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Y0D+xgHV
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 93A7542671
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:29:48 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 6E8EE3064C1E
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:29:48 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D39F8188C186
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 08:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95971F03F3;
	Mon,  3 Mar 2025 08:28:56 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502D51EFF92
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 08:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740990534; cv=none; b=tU8/YJIvdLhnyBlPi7i5UtdqZXEFDMuwieUKQwiTnpk0L8hjZ3PEQ8zoOUXpg4sDrS03nY2xh84ZV91tjaot97TU0TLV6LcDxFu1STdwz/Mzdm+IndDkcoJTUywTlw7ah3fqDbZb/LFfpgf9+1BR2NI6FFkJx0oPbFCSxhNwMK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740990534; c=relaxed/simple;
	bh=qoPtDOyTcjwvCpBRIB3CYa8gwUoF4qiW66mIwy/6yyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nyk0xFql6LHwZiEF00P25V0byLS01ZGDP7CQ2gs2wRYNSa5Q0VZt/WYz2+76fMCXcAkYjhtqdSVOlzP/krVrWXcWYdVsuiDz2eA6CkHDL3W0MDz7jMl0rBygVIK+YTV4mj3N7gvGFEAR/CuPhv6TPU8tg+2wU5U/iGPUozGDGD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Y0D+xgHV; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e5050d19e9so4468381a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 00:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1740990531; x=1741595331; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bZbWYCAiGLdzl+1azDhHiS3T7Iql29Bgd9JnV0VCloE=;
        b=Y0D+xgHVb2dK950l7vfoJF+Q6AOpJ/BByNSkcJY1OeeAJ0bBsd0BbgqkEKc4ur86dE
         cYT2Af+Oof9FyLF+kr7NyyjPgH92ZRzOhzcD17audsET7nH7KJpmLZDPGNVUg6xMru+S
         m0d6qwbBSbbUqnyROX61/FqmtvkCPJ7EkU5NWqZM+XalCsBAmP1JpJ4+sDwZE6kNO3zg
         hepJTyg9y2a0W8bhFKgOgJTdPdBfP+3be1ugGyqQhpziUZdLoiMc0ni69l5oTs+W0K5n
         Zll+GnRHvnlNZ4Bo6eW4sDVFApZeLIK16KPQyUXFP8MO+QSBthiMmZRhMRBr1TncDUXd
         FGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740990531; x=1741595331;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bZbWYCAiGLdzl+1azDhHiS3T7Iql29Bgd9JnV0VCloE=;
        b=aBbnBfzcsyFwJisN3U8MB0KIo+mLpdnJopTFdK8jOeNt4/Yfq4BUPEF2Sjs9Uj7Q6u
         GCStkO8apScpBTI+7Uy5DNGXcNQkVsdvxUERkzVHpg6N2Hh5j96MhxFpI+Ke+Shs1N9w
         ET2BQjF+llXjupWZ6/kJtD7WglFofKEIGvzrfwoANOdubMwKA40lo2DZyR6Nusr3qMWs
         z84TmVPAwpfvVEAqebUuo3h1ixEZdeCP4NlyqtbZrJhwzLk/EA+47sqaLxrCLN86DdIq
         v6ddlIyMfne50fj09FImI4dLvO5B86steXosWXimI1532Tqh/nlo3ofLZuorLcjbGXEQ
         0+dw==
X-Forwarded-Encrypted: i=1; AJvYcCU9C8QcijkhGg+iUI6AWiEVmqY6DUVZ5NQd/06DKAjSYe11ifI4M6Zd2HWIe8VFPc6xKGCLOaqLFDVCvVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQOtpzZ6GXtimIvAxkka5/mLzwHpQbh55Fd2bEs8HyHfhTviES
	ufsoOLpMap4swaaewPk7Pw54cXUhQrxfnsOutU5asuEz1IgGib9GFV5M/qPIWP4=
X-Gm-Gg: ASbGnctuAuPQ2ICqDJD7ExCdJF3tZtVlW/nRCq+XaECF+e3dvItsV+i3O3K9KLAK/3d
	jxM5QjtAdrjkn49an2DZgGCxdC8hcqFfC0PQMRNrOD/5A79LzbYmMH2Az2/jWbnfh/oTv2NIuTR
	ri1ETzc2T3AuJVk3bcCIXkL5kpKb6FitHztd4Nq5AZsnU4ynv5Rf5UaApfwzP/WPvPJip7S30O3
	h4TZy9PAp+G5UVbM2MXgOaNlCYrpgaLCEECMPX83M097CwRN64ps9Y+t0ryB3Q+h6T2D9jhEI2o
	CcTKiXRTOL8Ton5jK3Npku/mFk5UOo4jEYR0CVX18M9RLWY4aL2SLg==
X-Google-Smtp-Source: AGHT+IFrYJnOfLSyyyjojYRmFnfLxPLsWEHLU4GBBp6Ea3g+RJ8CQj9vhxA16WLLX0u0LSDAoCw01Q==
X-Received: by 2002:a17:907:7ea5:b0:ab8:c215:fd27 with SMTP id a640c23a62f3a-abf25fa8e4fmr1364497766b.14.1740990529665;
        Mon, 03 Mar 2025 00:28:49 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf17fa4a4asm733337966b.92.2025.03.03.00.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 00:28:49 -0800 (PST)
Message-ID: <430f1dae-0123-4d4a-81c9-b3c1d9df285d@tuxon.dev>
Date: Mon, 3 Mar 2025 10:28:47 +0200
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/21] ARM: dts: microchip: sama7d65: Add RTT and GPBR
 Support for sama7d65 SoC
To: Ryan.Wanner@microchip.com, lee@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, sre@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 p.zabel@pengutronix.de
Cc: linux@armlinux.org.uk, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
References: <cover.1740671156.git.Ryan.Wanner@microchip.com>
 <6a1c058edee3fe1459dcb3a93a0a789a9ffff5f3.1740671156.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <6a1c058edee3fe1459dcb3a93a0a789a9ffff5f3.1740671156.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6g6l5cXXzG1B7
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741715973.18347@6eb45kxoS9IGvUnhKSTeGA
X-ITU-MailScanner-SpamCheck: not spam

Hi, Ryan,

On 27.02.2025 17:52, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add RTT support for SAMA7D65 SoC. The GPBR is added so the SoC is able
> to store the RTT time data.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  arch/arm/boot/dts/microchip/sama7d65.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/microchip/sama7d65.dtsi b/arch/arm/boot/dts/microchip/sama7d65.dtsi
> index b0a676623100..aadeea132289 100644
> --- a/arch/arm/boot/dts/microchip/sama7d65.dtsi
> +++ b/arch/arm/boot/dts/microchip/sama7d65.dtsi
> @@ -120,6 +120,13 @@ shdwc: poweroff@e001d200 {
>  			status = "disabled";
>  		};
>  
> +		rtt: rtc@e001d300 {
> +			compatible = "microchip,sama7d65-rtt", "atmel,at91sam9260-rtt";
> +			reg = <0xe001d300 0x30>;
> +			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk32k 0>;
> +		};
> +
>  		clk32k: clock-controller@e001d500 {
>  			compatible = "microchip,sama7d65-sckc", "microchip,sam9x60-sckc";
>  			reg = <0xe001d500 0x4>;
> @@ -132,6 +139,11 @@ chipid@e0020000 {
>  			reg = <0xe0020000 0x8>;
>  		};
>  
> +		gpbr: gpbr@e001d700 {
> +			compatible = "microchip,sama7d65-gpbr", "syscon";

This is not documented. I'll postpone this until a documentation patch will
be posted.

> +			reg = <0xe001d700 0x48>;
> +		};
> +
>  		dma2: dma-controller@e1200000 {
>  			compatible = "microchip,sama7d65-dma", "microchip,sama7g5-dma";
>  			reg = <0xe1200000 0x1000>;



