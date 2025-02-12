Return-Path: <linux-pm+bounces-21937-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB19A320C5
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 09:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25D63A6050
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 08:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94868204F64;
	Wed, 12 Feb 2025 08:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="MzZw8gbu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9E11EE013
	for <linux-pm@vger.kernel.org>; Wed, 12 Feb 2025 08:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739348340; cv=none; b=LF4vVHkCuPkavCBJAiTZsaYcMebqUNOnih23dRl6Qwci+qbe9GSVBn60rXoTzX1Yhp6IrLydMUcyk5waGtNyxMufpEy8Fvf+w/lYjKU0SsxsfdN6jPYJohPvbW2ZKWOmJYkt0S/22Q+UrdI4G+ftPJaGTd8nVkxTXTDIZD48Mqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739348340; c=relaxed/simple;
	bh=YarSXhMi3MICiWyZ0jRRnUYvv8XeVcnEvxnut2kZOyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F+BBtylIqyTH1jJmExTAXOZGh7RQdJGmMdBK8mP3N7YbKgOZZ9YwF9GXE6u2KEwEf/3t+uzdiVjgpwlVKzgw9IgNQeowexR+qxCKs/PDxuiMcW9p3oDXrcjYNrtroSHMJ8jOQ+LGrT8Q+JFsv4jHSCk/HCd4V9kApjYmo0UYdDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=MzZw8gbu; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab7430e27b2so1231236366b.3
        for <linux-pm@vger.kernel.org>; Wed, 12 Feb 2025 00:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1739348337; x=1739953137; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Ca3jOifU6KLMuLCZFV+VlIgaFdG1oVjtxMx89qkKmE=;
        b=MzZw8gbuqLVeL2UHvA5aKLgbE0gIYWGSISDZP8MAJ791yo/wtGJ7+ZTmRXtvZvv/1I
         k9RPd3JtvMfno2uQv1Rn+TaeyJYifJQTkYPu3XPdEdN0ZPTumzW3t7sMioUELOYsPSia
         drXfL8NnWsXSPezSKJ+hOfTZFHkANRAPcHxGxej8nia1kbkBxBlYA+3QrjMnu26tHrQF
         zq1r1B3xazjK86GtNihSzPuatJhGbrq0IMiauK8LrqNxOkYr8O3AbXrGODzwBeMRoZ1l
         DbPqI43fvhDFEs9DmaZdb2eg/SwiKKlZPMWU2ZyFsfN99XsWNqiq/b1i9Rx65RqlH4C+
         h9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739348337; x=1739953137;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Ca3jOifU6KLMuLCZFV+VlIgaFdG1oVjtxMx89qkKmE=;
        b=ai4fbZe5SXkggxkwEIgoTZouNMRFPx7zLEZH66SBCqJ/CJPtmBt4jC2bvZHPAqhJ79
         RJB/vQW7QmLPdkABfQkY5pLyhltK9YscxwRzO141cw1BZb7o3en9CKwtei7xJ312+DUL
         gL9+oJS8B15NZ8GhkM9nsgLUnxhluOmaDYd7SJVflHdRKDgvPPDg0tc4xksOt3IfY+Mp
         2Xv1ULB98n66vfIbmX6YEzYaPansoNmUBdcUFOEV3g/H6DbIOppm9QHHaT0gftg1TUJn
         8JCNrCd80nylvkNXw2CjK7jLEdVG1dakLVFEHtmA12xv+2lJKEfdsem2J635WVwObP/f
         3O0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVT8uEquDuobpcWESkEAbKl6R3V4W7NpiZoDuI1lnx4Q5s46ADL/mQmr2lG9cETK044qDttPXde8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTOM7mFQd46ZzXm1CZMNgSFD29bmGbbxxGkKLa7o4/4vsiuyCP
	K0RyyAPeYQl++rDRmnW1d7WOEBZnb/HILY1ssrfFl+s9/EQRHMSCWbGNM40UiFY=
X-Gm-Gg: ASbGncvh9N3mTYMqaKyvmjUS3Ph1FObzzCYfwhvebFrBjLkU4aefPMjy9HqacksgeC4
	AOQMZWZjxYV4uCymu0AMKyTmk/QD2skRbJRwhYb+94L+6yYZHMqSRtva2IdjvydmBwgB9mEnNLK
	fAvwjWvchMqB2q8LydOj6nAU9jz/q2mT7IxHLnOzwfr6M46nJNvBmBsXKntfuzeZWmsdMg+Th1J
	bs55gLvKP393JlPtIio4Jy9X1gq0IOseB1umBDjUjdNK0L/tK3ZqqIwqhxP9oBFvM+Hm5kZGckM
	qbAPylbnUIsWtLiqtG1JiLE2
X-Google-Smtp-Source: AGHT+IHBLSlZ+tK9sv24mLWsqTARUiAJ4W3lRBwdQFx31Cj8hrychh4XqU6wPO/Gzkojw3c5V7eTFA==
X-Received: by 2002:a17:906:6a0b:b0:ab6:b9a6:a9e6 with SMTP id a640c23a62f3a-ab7f34a11a2mr161055766b.46.1739348337071;
        Wed, 12 Feb 2025 00:18:57 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.173])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de5e15c76bsm8231120a12.42.2025.02.12.00.18.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 00:18:56 -0800 (PST)
Message-ID: <b697f8d5-79ca-4d51-b5ac-9dd51713c0ea@tuxon.dev>
Date: Wed, 12 Feb 2025 10:18:54 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/15] dt-bindings: rtc: at91rm9200: add
 microchip,sama7d65-rtc
To: Ryan.Wanner@microchip.com, lee@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, sre@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 p.zabel@pengutronix.de
Cc: linux@armlinux.org.uk, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
References: <cover.1739221064.git.Ryan.Wanner@microchip.com>
 <a0338f3d05ed43eeaf2121dd22a9f0dbf25f2fc0.1739221064.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <a0338f3d05ed43eeaf2121dd22a9f0dbf25f2fc0.1739221064.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10.02.2025 23:13, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add SAMA7D65 RTC compatible to DT bindings documentation.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  .../devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml          | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml b/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml
> index c8bb2eef442dd..0c878331170b4 100644
> --- a/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml
> +++ b/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml
> @@ -25,6 +25,9 @@ properties:
>        - items:
>            - const: microchip,sam9x7-rtc
>            - const: microchip,sam9x60-rtc
> +      - items:
> +          - const: microchip,sama7d65-rtc
> +          - const: microchip,sam9x60-rtc

Can't these be merged like below?

- items:
    - enum:
        - microchip,sam9x7-rtc
        - microchip,sama7d65-rtc
    - const: microchip,sam9x60-rtc


>  
>    reg:
>      maxItems: 1


