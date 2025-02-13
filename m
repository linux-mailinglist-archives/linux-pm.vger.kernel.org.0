Return-Path: <linux-pm+bounces-22001-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F164A339FD
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 09:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A33533A4900
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 08:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8FB20C008;
	Thu, 13 Feb 2025 08:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="T+QBgBtj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C6F1EF08E
	for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2025 08:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739435447; cv=none; b=GZoeJ97nrGxyweEh3Qejb+91+xMRPOaQTkNcOIYu+W2YshbE83sJI6xH5m8vhThgZLouLfCJEhkYGUeduyVZZ0nEWs9PWS+9+2P9eeWJrGjAIrKGZtDzIyElMW7YhJKCgH4G9sUgz9UCnU02ZnB2owD/+I2qgWfK2VreyjJU7Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739435447; c=relaxed/simple;
	bh=yVyXip6qwmE1k0De5I/LF6Pjyh8674Af4I42FomQeV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HylavZfu5h5I6bIOmNjASRUB8oXYW6XuxJuEVwozt8SMb2obKIF9BodfIP4naGqyxpLioJZt0IlZirUh/Ct3gHKQhFyZW6AkqmII0Pc+/FhNAY89OPvbvgXgXVUQ7lwmZy1fHbT9B1izFXOxQEXjzBxsTOz/tvyZOQ8Yc9UrPi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=T+QBgBtj; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaecf50578eso133008166b.2
        for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2025 00:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1739435443; x=1740040243; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8OTJXiPdRvtiBBp8e+x5n2i2CDc/LvduVGRkWa7Iyto=;
        b=T+QBgBtjCHvKUV+kA9m1KbX7frJPnYEnFiOv88BJ4Ogq1DTf1Wqwxc5mRee3tvrUzI
         AftQNJIEgA4UDykK01Y82iOR5t4gJlWMScSi9IKtfijLscekzoB+ZGZaB7SOHw/+Eq3o
         4c/HIQioSOO++u0eTbjGxUwebhJ7+ghCTPDsO/mirYiuV/KC8KuvOxjWiPYVlhWlPVWH
         BLWRxxacVOr3h0qvP9dwVe7gQCtbKiYC3O8mn6HOwi55pEbpwWtZlFOIGg+TaPGiRwXZ
         75oJFKhXkwFTz/YfyDvKoJfk5swu3hqVosJmg1xIEJrvGOD3xyct0QfT9fzJ8h9XFcEh
         riBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739435443; x=1740040243;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8OTJXiPdRvtiBBp8e+x5n2i2CDc/LvduVGRkWa7Iyto=;
        b=cYpkCcnw2A8iIh3d5h3PcuV+tfPdkbURzlC8GLgxywNNFlEOeKarDrLBmYeBBkgHP+
         pxpKHKnnKqxQy8aeMvvhmGdcMgZcBUvJrhii0zFrPjZp584npVLl5wwdPY9qA0xc1oFq
         YQ1nQSIsH8q0lwEw78kl3wgDtfN7NW+YWtpW6CVKwoTiMA2N22UdSW1rcOnSH0aISzO4
         P9JnEIUOkE0gsD8T/lyJRuJ5y3xF/+MZ3itX6ETimX2W0a0cpoK/JRYAlvgeZGOkt2sG
         ryVrLjVpf2scB3TR3tw+itUBX6qrKIHv5h5YqVzPvoXdh523/SkI0bETpqR8Q0EHsilr
         mrOA==
X-Forwarded-Encrypted: i=1; AJvYcCWnp9dqkNpdYkNZZJSprzg4Dw2DVVthF4spUQK2lZre+W1y+UCzfJ1htiGgiSpdOsb3LC6ctnGMSA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQqwR+igGR4+iU0arpjbkilXTvyRa0icj747wq7HKRudElliI8
	etmVd6JgU9Mv5cpCMwndvl3UKvEMbRKor8dlyn2ZS11H3KHXsD+XE4GBIVHLkks=
X-Gm-Gg: ASbGncshjfiWDMPO2FdIM4OxrLNDoScLm687+YSZWSEquZpr+t6juUUCCCU3yjFTNhY
	wMNax9+yTFGS/llO68JsHDnxxIGbN0+pZMFL7IDRKpFoF0YXZeRqHEsfFtTBzluBf3/znT2MgKF
	mylLkqkSExlLq4diOIVlOmfb5G1ClxjNk0avcXf6zVd77UIGJT3jLBHKSY8eXohwiZTDwBpNBLi
	+5jKQRG0bbywpODzVvKATj7qOT5Z/cfyF3eFJpWD+dD399ijY7Zrkzfr63/vgCs4gdWedE6dCtw
	rlp2Yjq4oTzEss0o4dE7q/Dx
X-Google-Smtp-Source: AGHT+IGRpE3mvXYi07r5eKrsPU6jDtGUtF130PrHSlSd+nAQxiAUlBKaWgcX6BHCBayFoA8d6GoHcg==
X-Received: by 2002:a17:907:724c:b0:ab7:d10b:e1de with SMTP id a640c23a62f3a-ab7f339c868mr555099266b.13.1739435443116;
        Thu, 13 Feb 2025 00:30:43 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.173])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece288e38sm753543a12.79.2025.02.13.00.30.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 00:30:41 -0800 (PST)
Message-ID: <83a59afc-ce67-4461-bb63-d8b8078a1198@tuxon.dev>
Date: Thu, 13 Feb 2025 10:30:39 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/15] ARM: dts: microchip: add shutdown controller and
 rtt timer
To: Ryan.Wanner@microchip.com, lee@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, sre@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 p.zabel@pengutronix.de
Cc: linux@armlinux.org.uk, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
References: <cover.1739221064.git.Ryan.Wanner@microchip.com>
 <709f5268da63c123cc4eee9e47875324df81c454.1739221064.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <709f5268da63c123cc4eee9e47875324df81c454.1739221064.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ryan,

On 10.02.2025 23:13, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add shutdown controller and rtt timer to support shutdown and wake up.

Also, split it in 2 patches:

1/ add rtt timer
2/ Enable shdwc

> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  .../boot/dts/microchip/at91-sama7d65_curiosity.dts | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
> index 0f86360fb733a..d1d0b06fbfc43 100644
> --- a/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
> +++ b/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
> @@ -77,6 +77,11 @@ pinctrl_uart6_default: uart6-default {
>  	};
>  };
>  
> +&rtt {
> +	atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
> +	status = "disabled";

Any reason for keeping this node disabled?

> +};
> +
>  &sdmmc1 {
>  	bus-width = <4>;
>  	pinctrl-names = "default";
> @@ -84,6 +89,15 @@ &sdmmc1 {
>  	status = "okay";
>  };
>  
> +&shdwc {
> +	debounce-delay-us = <976>;
> +	status = "okay";
> +
> +	input@0 {
> +		reg = <0>;
> +	};
> +};
> +
>  &slow_xtal {
>  	clock-frequency = <32768>;
>  };


