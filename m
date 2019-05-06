Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F163A147BC
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2019 11:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfEFJnF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 May 2019 05:43:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38095 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfEFJnE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 May 2019 05:43:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id k16so16388650wrn.5
        for <linux-pm@vger.kernel.org>; Mon, 06 May 2019 02:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oBRW4mzs2+gSuRgFKtSlAc3IAdXzqU5G7UW4zze+fv0=;
        b=HEXOulifYSD9r6cpc+favVP51KND98+0UEUwidmOZ+pPyUdRR5WR3JUzUuNSX2pxIF
         T/4MnQbM7IHWrbQVqbXyzeEWQWGuf3EgNQOiQp/8Hhvp87nNMZBMdlV3CVOrD3DaAn6J
         ZdKkCGrKwiobSJZASqPNEgw9E5TFxcOHKf66XxLgdMHFQYwNe8iDCqox9IVWvZoNcB3R
         FN2m2fG3G0pbWqFeWwBLoz1aFFCi45zvEnREThevLqPoiMMy5GOyH3B7zHm8YY1gtEn5
         Ry2lclt2WVw6oBz33J9/YxM6oK8O/HlZ7HC/kNFgEoBuDij+/bD2XuaJ0yzc006uQg8S
         zdIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oBRW4mzs2+gSuRgFKtSlAc3IAdXzqU5G7UW4zze+fv0=;
        b=SllenOGidFnLBRoZwotrncIwxKRCGxbIA1WDu6UBxwS1uO/qDqtLT42NMo9MYJCWBA
         gZVfmzv0gvE+kKJ6SNMUiOPfbXV6t2gvW2WrtUKWrUTY3PGzZ08J0DwnwgHrE0BYyCMc
         ci5/1ZT4igg7Mx/wCl5rxBRYMZgozlwjShrfPwtjnHtBC8SCAjJQd7j6CTK0Ds5tASuq
         2CTFuDJvSQ5buLITkk4YdFsHkkFk07et4XhbmeiKH65mmbiZBy+U4fAPq9ImIRU1PoL3
         VYOwyOtlIkPQpC1Bc9Lm+SgtmBgwV3aY6RcxzSDbQ0zcKY+6AY9Ytc7AW9qtEfSaq02h
         RjYA==
X-Gm-Message-State: APjAAAXULjaqhD/vWvAflC7Clojwrs+lTjpb3jvtp2Vms6otifQJ95FZ
        W+hXSuUgm7KVm0PFvBbm79ykcg==
X-Google-Smtp-Source: APXvYqzERXrD9dfIppanGsG4vczgC5yAuidlgdRE0rB9x9uiRwmebaGhxtIZTRMTsNGX8g/83N2t8g==
X-Received: by 2002:a5d:52c6:: with SMTP id r6mr18035560wrv.131.1557135782760;
        Mon, 06 May 2019 02:43:02 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id g5sm10623857wrh.44.2019.05.06.02.43.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 02:43:02 -0700 (PDT)
Subject: Re: [PATCH 1/8] arm64: dts: mt8183: add thermal zone node
To:     "michael.kao" <michael.kao@mediatek.com>, fan.chen@mediatek.com,
        jamesjj.liao@mediatek.com, dawei.chien@mediatek.com,
        louis.yu@mediatek.com, roger.lu@mediatek.com,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <1556793795-25204-1-git-send-email-michael.kao@mediatek.com>
 <1556793795-25204-2-git-send-email-michael.kao@mediatek.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <8e0fad21-57d1-923c-fd8b-f5f2c47a5c94@linaro.org>
Date:   Mon, 6 May 2019 11:43:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556793795-25204-2-git-send-email-michael.kao@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02/05/2019 12:43, michael.kao wrote:
> Add thermal zone node to Mediatek MT8183 dts file.
> 
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> ---

Hi Michael,

the device tree binding for thermal specifies the thermal zone must
define a cooling-maps (it is a required field).

All the thermal zones below tzts1, tzts2, etc ... do not have it.


>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 64 ++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 926df75..b92116f 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -334,6 +334,67 @@
>  			status = "disabled";
>  		};
>  
> +		thermal: thermal@1100b000 {
> +			#thermal-sensor-cells = <1>;
> +			compatible = "mediatek,mt8183-thermal";
> +			reg = <0 0x1100b000 0 0x1000>;
> +			interrupts = <0 76 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&infracfg CLK_INFRA_THERM>,
> +				 <&infracfg CLK_INFRA_AUXADC>;
> +			clock-names = "therm", "auxadc";
> +			resets = <&infracfg  MT8183_INFRACFG_AO_THERM_SW_RST>;
> +			mediatek,auxadc = <&auxadc>;
> +			mediatek,apmixedsys = <&apmixedsys>;
> +			mediatek,hw-reset-temp = <117000>;
> +			nvmem-cells = <&thermal_calibration>;
> +			nvmem-cell-names = "calibration-data";
> +		};
> +
> +		thermal-zones {
> +			cpu_thermal: cpu_thermal {
> +				polling-delay-passive = <1000>;
> +				polling-delay = <1000>;
> +
> +				thermal-sensors = <&thermal 0>;
> +				sustainable-power = <1500>;
> +			};
> +
> +			tzts1: tzts1 {
> +				polling-delay-passive = <1000>;
> +				polling-delay = <1000>;
> +				thermal-sensors = <&thermal 1>;
> +			};
> +
> +			tzts2: tzts2 {
> +				polling-delay-passive = <1000>;
> +				polling-delay = <1000>;
> +				thermal-sensors = <&thermal 2>;
> +			};
> +
> +			tzts3: tzts3 {
> +				polling-delay-passive = <1000>;
> +				polling-delay = <1000>;
> +				thermal-sensors = <&thermal 3>;
> +			};
> +
> +			tzts4: tzts4 {
> +				polling-delay-passive = <1000>;
> +				polling-delay = <1000>;
> +				thermal-sensors = <&thermal 4>;
> +			};
> +
> +			tzts5: tzts5 {
> +				polling-delay-passive = <1000>;
> +				polling-delay = <1000>;
> +				thermal-sensors = <&thermal 5>;
> +			};
> +
> +			tztsABB: tztsABB {
> +				polling-delay-passive = <1000>;
> +				polling-delay = <1000>;
> +				thermal-sensors = <&thermal 6>;
> +			};
> +		};
>  		audiosys: syscon@11220000 {
>  			compatible = "mediatek,mt8183-audiosys", "syscon";
>  			reg = <0 0x11220000 0 0x1000>;
> @@ -368,6 +429,9 @@
>  			compatible = "mediatek,mt8183-efuse",
>  				     "mediatek,efuse";
>  			reg = <0 0x11f10000 0 0x1000>;
> +			thermal_calibration: calib@180 {
> +				reg = <0x180 0xc>;
> +			};
>  		};
>  
>  		mfgcfg: syscon@13000000 {
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

