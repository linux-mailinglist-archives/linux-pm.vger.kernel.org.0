Return-Path: <linux-pm+bounces-23261-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69281A4B94D
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 09:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B7BE7A1445
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 08:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FFE1EFF99;
	Mon,  3 Mar 2025 08:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="HTM8O5PX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5BF1EFF93
	for <linux-pm@vger.kernel.org>; Mon,  3 Mar 2025 08:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740990534; cv=none; b=NbxdpL7gdYzjA9uDSJbMuhPJrXOLbu5ng7CfygyxB1xO31lWX5kEfoc3sBCbYdwVhfaXWdKabgmmyOuXZasbJ9tLN6xUPlOe7zg7Q9viKp0erAtPABFDQUmu2sHq1efmiMFbIL0P+hgOk1zNrp4EgP5Mn0d5i9Yb1dKw8f8ujDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740990534; c=relaxed/simple;
	bh=qoPtDOyTcjwvCpBRIB3CYa8gwUoF4qiW66mIwy/6yyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nyk0xFql6LHwZiEF00P25V0byLS01ZGDP7CQ2gs2wRYNSa5Q0VZt/WYz2+76fMCXcAkYjhtqdSVOlzP/krVrWXcWYdVsuiDz2eA6CkHDL3W0MDz7jMl0rBygVIK+YTV4mj3N7gvGFEAR/CuPhv6TPU8tg+2wU5U/iGPUozGDGD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=HTM8O5PX; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aaec111762bso758903966b.2
        for <linux-pm@vger.kernel.org>; Mon, 03 Mar 2025 00:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1740990530; x=1741595330; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bZbWYCAiGLdzl+1azDhHiS3T7Iql29Bgd9JnV0VCloE=;
        b=HTM8O5PXxEYHVqSz6Zexc4NOBWwT9uXMWeBleqmOWJlKDhofqiKwYum5WX+yFzWV6s
         fI03y1H27wxQQRN/7++rdfgsF43Cg04yByb9+Rab7kKfFJ95C2WfAfdKPEk7fgPlicRG
         gk/9+Nr6H3MhCl+JGjwUY7AfmoZF93p4HL/iUS1wsGYvEw/Npc7MFbsjT+FhVemxxhJd
         wiiMRoa4go9M5vf953mMFJB1H4pJ689iSPoIttF2BjM9yx1nPURmW6vPM8v1Ac0tQb8l
         w5OVs/aU/+W/55Qxe11fpqNvFqsgTi2i/S41LdYH+G9L965kmPVOXM3lWLQ3Uvm3rM5r
         8yOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740990530; x=1741595330;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bZbWYCAiGLdzl+1azDhHiS3T7Iql29Bgd9JnV0VCloE=;
        b=Uf7ZcIp/03lz85hcKpsgZYjR+sjjlQVqwaWfqlut1OG9KXGj+A3g/yNm2hRLb/tvEh
         ZT7Vv8SYEz2HNLEO7b34ZtBYOVirNI/vgWyGn4JqNgaWmjY82j/7xb7ed9OdS98hw1Ap
         l9qnqlYiNnFuUwdfJ4tc+BS4cZUTEo1lUJ1lJtOM3Y20TUP4bB141nGOzaLKN9MuxqTj
         I+PYea4LdB5Fg+hHxHxoKgfRG5pCuaHeUSkKAM1JU1Jhx1nzBOIbiCr35VpX2yQSDbmd
         SshYR9+3kSJn2U/WBQxTErL2+R5ClO2/tfH3hmYJ2SVUifhLxPdwhXQS9yG6whsb99AJ
         FGqg==
X-Forwarded-Encrypted: i=1; AJvYcCXnEAbYbw7qNcbWIEv/DGdN37AiSnOIWRw8A2GApg2br947bsp/qzorR6FDws6LMiImuYrAFr5mpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YySaKLAgv3QNMWesYJBsyOZ8bKxOZqB0/Hi4kQeSW0CqCp69/Hv
	cLuub06n5s7ENcAiRw0xQcL0qODcU9h0jBB/IRez4TTcoiPpADX/Pe2Dk7xTrhQ=
X-Gm-Gg: ASbGncvJXlQHIr2jy5H65HOV23OamiQ8N+smkaRvfa+hn4deQOcsEiWEYQRfMpYwt+T
	bh1p1AnEq9TKixp8fjPiFtXk4aRJTDozddPiMZZshYS/kDJcMhg9i7Gnn/VUWOFO5Gq4toeT7aw
	2fGRg+sEWaJVrmI1ueM489vRdy+bOdQjhtf4liq8vYp3o41A6f26YuXHbRZQ4T7RjMsUxWl2n4Y
	Ln0GXyoPEyVebboJcKD2qceZbiAdujWK1g6Qeq58PikOfIryNShNGH9TrWduXDkWU9xDZmoPY9l
	Y9cUvUxFbvimfJ3y6D2xLleWZOHrJNsGia5sViseK2NqhwZpfazDDA==
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


