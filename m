Return-Path: <linux-pm+bounces-7870-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AADB8C6724
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2024 15:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B9421C223FA
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2024 13:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A29B12D201;
	Wed, 15 May 2024 13:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzJ3PiRf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D770012D1E9;
	Wed, 15 May 2024 13:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715778868; cv=none; b=fj6Mg2jIhMrMxz69kw96AvzenJNShW4d+Q7UvO5FyBxlyr5scS2qoorSqToMR5spGr+/pmkG84ipsNiRJRSCjqCJ6vgl5KHb04DrpT0h0M7kA8ecRkJQAO2e1WudJ/0oTWO5/JX+HamT+DlemlnH0AtPdY6V6FHdNGrzPZ4TdP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715778868; c=relaxed/simple;
	bh=Yb5M9H36jt8uea4+5ZG2QLZ3q4Yzr5yww1nqS+8QW5Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=N8J8PpZh1eIUUB2D3QI5YclqD8XtB4UwjnTTAgJg7u362VBBa4Bq/pv4iYC5ZZsODPCiG1CJaeiJRAHKPyYHgkUyyluFkuZ4PYDj5RCn05Vf3YG2VGnllIJ6RRGSxkoovkvmteS/RPzqHbGAuHJnyQKLEGTRzmO3JAjDCcxwNvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UzJ3PiRf; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-34e667905d2so4707391f8f.1;
        Wed, 15 May 2024 06:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715778865; x=1716383665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xqCAubB284eWJZEoxEZDG9uJ95Ernv3VMqhGxv3fKCg=;
        b=UzJ3PiRfnROyKCszeDGypAuESw9sV8uqsOOMLmvmEH5bQTM3zJDzZ0ww+PaO61CpXX
         jeINeq3IAwN3tkumUPD75oLht1YxOI08opSgPWTV5r73kWulSaAiT7d2YYJ61UDLg+Iy
         aXmYeimQ1dpBsLAa3dJK+Z8/1knnWqU7E2MYS3Y0t1R6PTSzadFuvZL8VtJBXGuOzK2T
         rLrH86l56MmD2mMVzWl3QOHF2xTTMSegtfNHHxqTBgVkTRXx4Nb4oyLw1V6lNdDXyr89
         QwbAbNhci3vsQvYWL7MU9lidji6RPXO4sTLqwuto2e+sErPhwt3C2jIse4H168PTbed1
         bWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715778865; x=1716383665;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xqCAubB284eWJZEoxEZDG9uJ95Ernv3VMqhGxv3fKCg=;
        b=s2ejDHV5Hdgb6gZsarcovDQtIlTlh2OQRuHvIgDcUKwGXpQTzNX4RDmYJl7Q8Z3xPN
         eqPbuLW+hKlyJ4MW8dOurBebBmCzpl1PQjQoKirIaN1V61HChB3GdFDVm5fvU9EWGH8j
         JIVWHI0+HYWRQaoVMt6RYCYOU/9Mtd88HBOr533WQ2gaRM9qvu+oQ5tpVAExpZ+U5Yww
         nQv3MjpQnTlfx4Q12KI9BJ89P0KYGJwRF+KgKR5IppJMcwProsNzlhuuBk2WV0XgZoXQ
         g2tycFZCTaXneCavXfOi2QJKUgllNJ577r5CR8Hq/htoohXeHi3AOvpKhW5P74nhFWdz
         uAtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIv+X8fCeM3YT70yf+Ktk67Mm69YYQxuqu35KYVhHgdsI71qg9GcDp6l8AFJ7IDrZCvOcvnKZxBvXK2HTYK5RNxJBvo5g52tB0JVMejCHPVmWte4gDKdj/6fyaVmp4VIwGdah4KRXZlw==
X-Gm-Message-State: AOJu0YxAodX684PPek09sMzYcVWTESIUXPJiC3mTqTfzODrEk23vOknE
	m3dfcH+lcb7Zkrm6QQ0xgXTRgOIPq5EKJU3xyMz7pTFqzarUuhy1
X-Google-Smtp-Source: AGHT+IFzeuuotpdffji9hPE+SlOa46FpGzcGLpwc2mDaJCNNjbVZQTmLPGQpVyrfhAu+GfS7sWtn3A==
X-Received: by 2002:a5d:510b:0:b0:34d:750c:5d81 with SMTP id ffacd0b85a97d-3504a741521mr11460139f8f.42.1715778864960;
        Wed, 15 May 2024 06:14:24 -0700 (PDT)
Received: from ?IPV6:2001:861:3385:e20:6384:4cf:52c5:3194? ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3504660753esm14821268f8f.8.2024.05.15.06.14.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 06:14:24 -0700 (PDT)
Message-ID: <9f0e7fb6-8712-4956-b058-9dfcb652cfbc@gmail.com>
Date: Wed, 15 May 2024 15:14:23 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] ARM: dts: st: add thermal property on stih410.dtsi
 and stih418.dtsi
From: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Lee Jones <lee@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240320-thermal-v3-0-700296694c4a@gmail.com>
 <20240320-thermal-v3-2-700296694c4a@gmail.com>
Content-Language: en-US, fr
In-Reply-To: <20240320-thermal-v3-2-700296694c4a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Patrice,

Gentle ping on this one. :)

Regards,
Raphaël

Le 20/03/2024 à 22:33, Raphael Gallais-Pou a écrit :
> "#thermal-sensor-cells" is required and missing in thermal nodes.
> Add it.
> 
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> ---
>   arch/arm/boot/dts/st/stih410.dtsi | 1 +
>   arch/arm/boot/dts/st/stih418.dtsi | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/st/stih410.dtsi b/arch/arm/boot/dts/st/stih410.dtsi
> index 29e95e9d3229..a69231854f78 100644
> --- a/arch/arm/boot/dts/st/stih410.dtsi
> +++ b/arch/arm/boot/dts/st/stih410.dtsi
> @@ -270,6 +270,7 @@ thermal@91a0000 {
>   			clock-names = "thermal";
>   			clocks = <&clk_sysin>;
>   			interrupts = <GIC_SPI 205 IRQ_TYPE_EDGE_RISING>;
> +			#thermal-sensor-cells = <0>;
>   		};
>   
>   		cec@94a087c {
> diff --git a/arch/arm/boot/dts/st/stih418.dtsi b/arch/arm/boot/dts/st/stih418.dtsi
> index b35b9b7a7ccc..0f0db988a907 100644
> --- a/arch/arm/boot/dts/st/stih418.dtsi
> +++ b/arch/arm/boot/dts/st/stih418.dtsi
> @@ -113,6 +113,7 @@ thermal@91a0000 {
>   			clock-names = "thermal";
>   			clocks = <&clk_sysin>;
>   			interrupts = <GIC_SPI 205 IRQ_TYPE_EDGE_RISING>;
> +			#thermal-sensor-cells = <0>;
>   		};
>   	};
>   };
> 

