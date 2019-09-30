Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70D40C1CBB
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2019 10:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbfI3ITK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Sep 2019 04:19:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46746 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729232AbfI3ITJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Sep 2019 04:19:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id o18so10087900wrv.13
        for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2019 01:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=x0XGX0p2g1eVIlvAKXleMxs/akDsCWqOinlGv4rBIQ0=;
        b=y0Be53V8mLwX21Q5YFuM17HmPOuuZIafNiSQN52m8A9vMiV8Q43bXkNtIj8UNaAikY
         prpMDxS+uqbZN0LEeevdj9KKQhhbbon9qfVh6mZ6e1A7HsLeFGGd4LlF95fJr/ttO9ga
         hhSRKhVQww3EX7/b5Yi2UXe//mtSfgYrCGphshQC3VibaxZq7M3x5qai16GqxrWtJb19
         PHCgVIxeuo0oNCxVDAbON9GXlUBi2Gxb3wUe1V2+xOGRCAp5EVw+uheLiaLa+mke0qpZ
         kWVGPqaqIRVsM8ZcuiYrKI/Ac8StVLJ3YENlidBnbV1n4u1X2zLP2CWnUliji6gbJZ12
         QQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=x0XGX0p2g1eVIlvAKXleMxs/akDsCWqOinlGv4rBIQ0=;
        b=M9c95botlMvUKSQede9vqzrmGYy/DiHuT9+9VivM321R0dlLkzj5ZsCgFXf8b5tgrb
         UARHjY3GAiesoZYhyR0JPFvSPVc5IS3CDZ97cSnqnY/Dp5k1Bs5LbJzjb6u0iThHlMaQ
         uNSCt9IrlYi+vploRPeRd1S1i2/ovDQq7OxmDrCysLeFA2z+g4JPrxRb6cDz/ovQiqox
         kLu2C9ReWefQFHdk5xSqTcJjNFOZpMzFUJe5HZMHsrvrnPK8f7hCfLL4glq6CJxjR5GQ
         gjQLsqsawFVezMuPAK9OLimElN5p+n4tLgtjEZ8K21HgXPxApswWyiUuWwJWkU12t96/
         4NFw==
X-Gm-Message-State: APjAAAXQF/7gIkenq40hWN/zBaXFUpqXSvvD3uh3ieq0nYCc7jK3ArJU
        eel9LEKy5Sg0xE3Z3TfADtyn3suikWxwGQ==
X-Google-Smtp-Source: APXvYqxYTiKVWT4mxgVLvUlRxFMopqZqi66bgYb3b0oH2ELYWVa+Jot0BTXb4UGgotbXrSXzPQPMfA==
X-Received: by 2002:adf:dd41:: with SMTP id u1mr12780409wrm.49.1569831545020;
        Mon, 30 Sep 2019 01:19:05 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e9sm30510461wme.3.2019.09.30.01.19.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Sep 2019 01:19:04 -0700 (PDT)
Subject: Re: [PATCH v6 3/7] arm64: dts: amlogic: g12: add temperature sensor
To:     Guillaume La Roque <glaroque@baylibre.com>,
        amit.kucheria@linaro.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org
Cc:     devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
References: <20190927184352.28759-1-glaroque@baylibre.com>
 <20190927184352.28759-4-glaroque@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <6aff984e-cb77-cc02-9df6-905a517b428d@baylibre.com>
Date:   Mon, 30 Sep 2019 10:19:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190927184352.28759-4-glaroque@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27/09/2019 20:43, Guillaume La Roque wrote:
> Add cpu and ddr temperature sensors for G12 Socs
> 
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Tested-by: Christian Hewitt <christianshewitt@gmail.com>
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
>  .../boot/dts/amlogic/meson-g12-common.dtsi    | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> index 38d70ce1cfc7..0660d9ef6a86 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> @@ -1353,6 +1353,26 @@
>  				};
>  			};
>  
> +			cpu_temp: temperature-sensor@34800 {
> +				compatible = "amlogic,g12a-cpu-thermal",
> +					     "amlogic,g12a-thermal";
> +				reg = <0x0 0x34800 0x0 0x50>;
> +				interrupts = <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>;
> +				clocks = <&clkc CLKID_TS>;
> +				#thermal-sensor-cells = <0>;
> +				amlogic,ao-secure = <&sec_AO>;
> +			};
> +
> +			ddr_temp: temperature-sensor@34c00 {
> +				compatible = "amlogic,g12a-ddr-thermal",
> +					     "amlogic,g12a-thermal";
> +				reg = <0x0 0x34c00 0x0 0x50>;
> +				interrupts = <GIC_SPI 36 IRQ_TYPE_EDGE_RISING>;
> +				clocks = <&clkc CLKID_TS>;
> +				#thermal-sensor-cells = <0>;
> +				amlogic,ao-secure = <&sec_AO>;
> +			};
> +
>  			usb2_phy0: phy@36000 {
>  				compatible = "amlogic,g12a-usb2-phy";
>  				reg = <0x0 0x36000 0x0 0x2000>;
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
