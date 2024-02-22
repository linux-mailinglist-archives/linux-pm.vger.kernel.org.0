Return-Path: <linux-pm+bounces-4292-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C15860198
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 19:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03DC31F229C7
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 18:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE4C13790A;
	Thu, 22 Feb 2024 18:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IE+1gTDP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886FA137905;
	Thu, 22 Feb 2024 18:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708626475; cv=none; b=RSgBwoLqYjQe302BzUOcCtuYo9B6LZXORUSNr+iuLApI/jA+DcqYisvlXxOkEz73DfOtMah1YO/HSKVYL1UV8GwJqVLHBrpmmTv/unHOf3b5HN4famPkEVaKdIMy0rNlZXYvguv5t7BFDxZxkwMtDvsjk3AbRWYxf2m7lQwPc6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708626475; c=relaxed/simple;
	bh=/ERQAEsXu0G6kcuTagglxUQka6jY9dYPE/DzuZNf3dI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YKID/gPhUuYKaok+h5miSr+T3sSfCqkFbpgUtM4T3XF3PVKbJDGANJpxKBD8W+dN8uzDsAZaZF6dXTKCYrrgA/V6qM+u9aSin0/Z8B7WFvyCsTO5mJbHMxv8VXW2IrVQe0tZNUGKixMx9pcqpNo7lFkRcWCI+b7KLoPx3mzWQew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IE+1gTDP; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3ed9cae56fso242360366b.1;
        Thu, 22 Feb 2024 10:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708626472; x=1709231272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tELClXvgGOtyHBZZBd2XEfCIwH1azmS4e74QYILe7xI=;
        b=IE+1gTDPNqjASF5P5ZKg7gZhIpmrsm5Xc+V/vfukRYhJ5ZLDtaY81PD9wXq/cfxr+q
         4eWBef6E/Qk4MBi5WJXKzkcR6qtyCWVBjmK07fqSsZk1EKsLByu36l8Yx6s3Kxgq9UZB
         nwL/VqhimjYMFDlWCtSqK128XlJkmeuuCi2Rp7v4r3TlHxSvK80LFozF99R6LeS0Jd/3
         r1hA/t2fVXJTlF02BAWZmZ2cgkzVurHMOguvkcnwvLE/DtKTljjHjgvbdBsC3G3FLyh0
         zqZ2QqOmh+4YC/N5powUPwviDAk4pel9ibigGL5iRCjB6OzVTNQYQYllCppYyNjpV4f1
         BYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708626472; x=1709231272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tELClXvgGOtyHBZZBd2XEfCIwH1azmS4e74QYILe7xI=;
        b=i80O44Ocvlon6NUFtCXF3wMv3V161v/tlXixlACw1XrMR+cD6+x+ggNIKvKUi++dzN
         o4tenQ8XyXDZ2Iq0K5eVjBc7aSYZ15H+pkIwhLzZ5NFmf9qA7z+c1S5wlPVRjDt7N53Z
         QAW4WKfXEdSJVVV/xH5X/Xu/btkcIVPQBFT1cO2dOZNYDFLIEZLOPzq+RUkTS6tSTz6k
         MhU4719vn8jCl1AXEZrcWktTMVnUYCFGj0wknancNtO/HyIVczdKy7atvFYP8inP+/46
         L8GQeatel2RAAD62meVjhl2/o7DmS89f5j4go0lXCP4F7QKDe0bJZta6WMCSxWkTp+LW
         TSjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxIGp9/HaYJgjxsE8t9jWP3bd73nHkWAW8LyMijTRFCQIlDhEFiUTfzO4vboYEb9R+1zuiP2QJBC9uBLr9aCWD3hD3m+IdZj7i82yFcyU8zXrvaaEylZzd4qNmQquYBsQs0twG
X-Gm-Message-State: AOJu0YzlEOB0wE1yxapXHRA5sD0Vv9NVBKp1yNN0GedYwzYBj/5cSGOZ
	bravAq+tsUsanzFJoCpptAbX7Tt17KFzERgz5GcM1xB/ebKc+j2h
X-Google-Smtp-Source: AGHT+IEyETD3CnHapZN/pItaYfe7T2SP89qHiRZOnxnaXo9m2VgXcYMwYEO4qUFvxVQA2rz+LGVA2Q==
X-Received: by 2002:a17:906:3398:b0:a3e:8b8e:8795 with SMTP id v24-20020a170906339800b00a3e8b8e8795mr2534984eja.34.1708626471678;
        Thu, 22 Feb 2024 10:27:51 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id bn9-20020a170907268900b00a3db46018a4sm6143818ejc.71.2024.02.22.10.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 10:27:51 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>,
 Yangtao Li <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, Andre Przywara <andre.przywara@arm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Martin Botka <martin.botka@somainline.org>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Bob McChesney <bob@electricworry.net>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
Subject:
 Re: [PATCH v5 7/7] arm64: dts: allwinner: h616: Add thermal sensor and zones
Date: Thu, 22 Feb 2024 19:27:49 +0100
Message-ID: <6017340.lOV4Wx5bFT@jernej-laptop>
In-Reply-To: <20240219153639.179814-8-andre.przywara@arm.com>
References:
 <20240219153639.179814-1-andre.przywara@arm.com>
 <20240219153639.179814-8-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne ponedeljek, 19. februar 2024 ob 16:36:39 CET je Andre Przywara napisal(a):
> From: Martin Botka <martin.botka@somainline.org>
> 
> There are four thermal sensors:
> - CPU
> - GPU
> - VE
> - DRAM
> 
> Add the thermal sensor configuration and the thermal zones.
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  .../arm64/boot/dts/allwinner/sun50i-h616.dtsi | 88 +++++++++++++++++++
>  1 file changed, 88 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> index 12ffabc79bcde..7c7d7c285505c 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> @@ -9,6 +9,7 @@
>  #include <dt-bindings/clock/sun6i-rtc.h>
>  #include <dt-bindings/reset/sun50i-h616-ccu.h>
>  #include <dt-bindings/reset/sun50i-h6-r-ccu.h>
> +#include <dt-bindings/thermal/thermal.h>
>  
>  / {
>  	interrupt-parent = <&gic>;
> @@ -138,6 +139,10 @@ sid: efuse@3006000 {
>  			reg = <0x03006000 0x1000>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> +
> +			ths_calibration: thermal-sensor-calibration@14 {
> +				reg = <0x14 0x8>;
> +			};
>  		};
>  
>  		watchdog: watchdog@30090a0 {
> @@ -517,6 +522,19 @@ mdio0: mdio {
>  			};
>  		};
>  
> +		ths: thermal-sensor@5070400 {
> +			compatible = "allwinner,sun50i-h616-ths";
> +			reg = <0x05070400 0x400>;
> +			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_THS>;
> +			clock-names = "bus";
> +			resets = <&ccu RST_BUS_THS>;
> +			nvmem-cells = <&ths_calibration>;
> +			nvmem-cell-names = "calibration";
> +			allwinner,sram = <&syscon>;
> +			#thermal-sensor-cells = <1>;
> +		};
> +
>  		usbotg: usb@5100000 {
>  			compatible = "allwinner,sun50i-h616-musb",
>  				     "allwinner,sun8i-h3-musb";
> @@ -761,4 +779,74 @@ r_rsb: rsb@7083000 {
>  			#size-cells = <0>;
>  		};
>  	};
> +
> +	thermal-zones {
> +		cpu-thermal {
> +			polling-delay-passive = <500>;
> +			polling-delay = <1000>;
> +			thermal-sensors = <&ths 2>;
> +			sustainable-power = <1000>;
> +
> +			trips {
> +				cpu_threshold: cpu-trip-0 {
> +					temperature = <60000>;
> +					type = "passive";
> +					hysteresis = <0>;
> +				};
> +				cpu_target: cpu-trip-1 {
> +					temperature = <70000>;
> +					type = "passive";
> +					hysteresis = <0>;
> +				};
> +				cpu_critical: cpu-trip-2 {
> +					temperature = <110000>;
> +					type = "critical";
> +					hysteresis = <0>;
> +				};
> +			};
> +		};
> +
> +		gpu-thermal {
> +			polling-delay-passive = <500>;
> +			polling-delay = <1000>;
> +			thermal-sensors = <&ths 0>;
> +			sustainable-power = <1100>;
> +
> +			trips {
> +				gpu_temp_critical: gpu-trip-0 {
> +					temperature = <110000>;
> +					type = "critical";
> +					hysteresis = <0>;
> +				};
> +			};
> +		};
> +
> +		ve-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&ths 1>;
> +
> +			trips {
> +				ve_temp_critical: ve-trip-0 {
> +					temperature = <110000>;
> +					type = "critical";
> +					hysteresis = <0>;
> +				};
> +			};
> +		};
> +
> +		ddr-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&ths 3>;
> +
> +			trips {
> +				ddr_temp_critical: ddr-trip-0 {
> +					temperature = <110000>;
> +					type = "critical";
> +					hysteresis = <0>;
> +				};
> +			};
> +		};
> +	};
>  };
> 





