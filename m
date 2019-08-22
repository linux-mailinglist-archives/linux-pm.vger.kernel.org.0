Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA3698EFD
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2019 11:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbfHVJPe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Aug 2019 05:15:34 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34701 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731438AbfHVJPe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Aug 2019 05:15:34 -0400
Received: by mail-wm1-f67.google.com with SMTP id e8so6645348wme.1
        for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2019 02:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ifonjkk4pkYZcIGDOZ8rC3Ei47dn9VrNBHIZBqiXNdM=;
        b=QyIV0ILfet6vmo4AnEzU0YOARH6X6dMF92FlHTffqYR00LslCx2Ez6xtcGlrFR7PM2
         Np3UafbM5xdfujg6XX/R05/7O3M8hRbV8kyPQkfoM5Sf9VoYfnpPxjiepliG7++w37xR
         zgRYFzye2riga/+MTOL2EfyGT/kg/yWk35Wkk717BI/IVYbOuW+Fo+kJ+uxxlecX3mHC
         Q6+lYTmFuaQ4P6+9HLS+WcrQuDsQonJq3fN7iC7EZ5w2GFOJiCdILkiXZtuxHIn+W942
         8iGisSC2lYkLuyIupqZBkS6Mv1j3s6mju+XWXaKWXJjGV+XbU5wAbhyYQdr0mMXcWF7G
         mEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ifonjkk4pkYZcIGDOZ8rC3Ei47dn9VrNBHIZBqiXNdM=;
        b=Klh3AmcLotVRIDToSsHo2Gkn0p65ZmcXSlVIMQ+qrTrJr/sIbNrCcOQkVY0BSDnMUG
         WNTeegZ5qDq61fU71UVksAwZ/SdBhPV5NMszVGQewhOn65r5JsNQsXJkEnQ5z7/Smbds
         dWOfbzo+1jh5/1rFgb6WPy/ed8/7M4ejMIaLZSxUuzDTVr/opU5kySUce/Q3+sHcLBTT
         +Ou1QUDeUHFYvTOwHFlcvRaC2x0fLfLDnxmM1LSCEXQSiPoNhcuysyfZclQ+XkPBhZBe
         XkhTQp3kZbju95cTCdW2huqcDvvmwVc6psnUskl8lXWNPAGrE2gJXlWcPpVKjTPwsJ4X
         E2oQ==
X-Gm-Message-State: APjAAAWYmxNv9eeMgWcCwfTKsnuAjqpu4r0vl65QH7hATZ2wyjQEpkYF
        sKOIsuhiOauvlom1T1F2DOR+IvUYV/ibhQ==
X-Google-Smtp-Source: APXvYqzYlvCEFiMtcT4GLnAvlRegeLLQctqcFt5+mqDJmrzy6VxVay8I5CPiIVTnpvs1yn90ZbF7Ww==
X-Received: by 2002:a7b:cc86:: with SMTP id p6mr5047049wma.106.1566465330663;
        Thu, 22 Aug 2019 02:15:30 -0700 (PDT)
Received: from [192.168.1.62] (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id r16sm52922710wrc.81.2019.08.22.02.15.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 02:15:30 -0700 (PDT)
Subject: Re: [PATCH v4 4/6] arm64: dts: meson: sei510: Add minimal thermal
 zone
To:     Kevin Hilman <khilman@baylibre.com>,
        Guillaume La Roque <glaroque@baylibre.com>,
        rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org
Cc:     devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
References: <20190821222421.30242-1-glaroque@baylibre.com>
 <20190821222421.30242-5-glaroque@baylibre.com> <7hsgpu5c7j.fsf@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <a6881ab8-21b0-ecd6-f7d9-cfe081455c24@baylibre.com>
Date:   Thu, 22 Aug 2019 11:15:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7hsgpu5c7j.fsf@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22/08/2019 01:29, Kevin Hilman wrote:
> Guillaume La Roque <glaroque@baylibre.com> writes:
> 
>> Add minimal thermal zone for two temperature sensor
>> One is located close to the DDR and the other one is
>> located close to the PLLs (between the CPU and GPU)
>>
>> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
>> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> ---
>>  .../boot/dts/amlogic/meson-g12a-sei510.dts    | 70 +++++++++++++++++++
>>  1 file changed, 70 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
>> index c9fa23a56562..35d2ebbd6d4e 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
>> @@ -10,6 +10,7 @@
>>  #include <dt-bindings/input/input.h>
>>  #include <dt-bindings/gpio/meson-g12a-gpio.h>
>>  #include <dt-bindings/sound/meson-g12a-tohdmitx.h>
>> +#include <dt-bindings/thermal/thermal.h>
>>  
>>  / {
>>  	compatible = "seirobotics,sei510", "amlogic,g12a";
>> @@ -33,6 +34,67 @@
>>  		ethernet0 = &ethmac;
>>  	};
>>  
>> +	thermal-zones {
>> +		cpu-thermal {
>> +			polling-delay = <1000>;
>> +			polling-delay-passive = <100>;
>> +			thermal-sensors = <&cpu_temp>;
>> +
>> +			trips {
>> +				cpu_hot: cpu-hot {
>> +					temperature = <85000>; /* millicelsius */
>> +					hysteresis = <2000>; /* millicelsius */
>> +					type = "hot";
>> +				};
>> +
>> +				cpu_critical: cpu-critical {
>> +					temperature = <110000>; /* millicelsius */
>> +					hysteresis = <2000>; /* millicelsius */
>> +					type = "critical";
>> +				};
>> +			};
>> +
>> +			cooling-maps {
>> +				map0 {
>> +					trip = <&cpu_hot>;
>> +					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> +				};
>> +
>> +				map1 {
>> +					trip = <&cpu_critical>;
>> +					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> +				};
>> +			};
>> +		};
>> +
>> +		ddr-thermal {
>> +			polling-delay = <1000>;
>> +			polling-delay-passive = <100>;
>> +			thermal-sensors = <&ddr_temp>;
>> +
>> +			trips {
>> +				ddr_critical: ddr-critical {
>> +					temperature = <110000>; /* millicelsius */
>> +					hysteresis = <2000>; /* millicelsius */
>> +					type = "critical";
>> +				};
>> +			};
>> +
>> +			cooling-maps {
>> +				map {
>> +					trip = <&ddr_critical>;
>> +					cooling-device = <&mali THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> +				};
>> +			};
>> +		};
>> +	};
>> +
>>  	mono_dac: audio-codec-0 {
>>  		compatible = "maxim,max98357a";
>>  		#sound-dai-cells = <0>;
>> @@ -321,6 +383,7 @@
>>  	operating-points-v2 = <&cpu_opp_table>;
>>  	clocks = <&clkc CLKID_CPU_CLK>;
>>  	clock-latency = <50000>;
>> +	#cooling-cells = <2>;
>>  };
>>  
>>  &cpu1 {
>> @@ -328,6 +391,7 @@
>>  	operating-points-v2 = <&cpu_opp_table>;
>>  	clocks = <&clkc CLKID_CPU_CLK>;
>>  	clock-latency = <50000>;
>> +	#cooling-cells = <2>;
>>  };
>>  
>>  &cpu2 {
>> @@ -335,6 +399,7 @@
>>  	operating-points-v2 = <&cpu_opp_table>;
>>  	clocks = <&clkc CLKID_CPU_CLK>;
>>  	clock-latency = <50000>;
>> +	#cooling-cells = <2>;
>>  };
>>  
>>  &cpu3 {
>> @@ -342,6 +407,7 @@
>>  	operating-points-v2 = <&cpu_opp_table>;
>>  	clocks = <&clkc CLKID_CPU_CLK>;
>>  	clock-latency = <50000>;
>> +	#cooling-cells = <2>;
>>  };
>>  
>>  &cvbs_vdac_port {
>> @@ -368,6 +434,10 @@
>>  	status = "okay";
>>  };
>>  
>> +&mali {
>> +	#cooling-cells = <2>;
>> +};
>> +
> 
> Is there a reason these #cooling-cells properties belong in the SoC
> .dtsi and not the board .dts.  Seems like you'll have to repeat this in
> every board .dts which doesn't seem necessary.

I asked him to keep the cooling-cells in the boards until we add the thermal
in all the remaining boards.

Seemed to be safer way at the time...

Neil

> 
> Same comment for patch 5/6
> 
> Kevin
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
> 

