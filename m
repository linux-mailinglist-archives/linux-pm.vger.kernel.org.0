Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 669BA987E2
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2019 01:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730460AbfHUX3z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Aug 2019 19:29:55 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43628 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729230AbfHUX3y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Aug 2019 19:29:54 -0400
Received: by mail-pg1-f194.google.com with SMTP id k3so2261353pgb.10
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2019 16:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Ce79tt1EdjWmHjsbOeVM0d2spReWneK1/ievz/5bOQ0=;
        b=SRJayQ+vvdMXVmtPpjEFclS7e2GZ1M9sa9zF2sf57HNJmzZnN2WRqclWakGVnPGLN7
         7GYwJ+WTjKHLab1MxehDKQSHs+KMnpzraeh5+CSSW+LhI1avIb7Evi76Syf5qZfJa6Sw
         L6gZ6SV1gh2iCsdxfxWvzc6oAxu9ug2lsdcMT168c60XJZwz5hCaB9UieV0oaSvD+0rP
         LU75UaFgyt7GyVC9h8mhJ+2nSDu6Ef8kDqTDpWLmyYk9Y25SXLi9hvNtUGbnIj7WjVUP
         9sqsHIqaBqGrMWL2EboclseGxi6y8M0YQXDC/jjG1iOUy+AdFQHbGLEdbYTFlpWScRNY
         2bSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Ce79tt1EdjWmHjsbOeVM0d2spReWneK1/ievz/5bOQ0=;
        b=n6idf3pCrl+kFDHF8wj5t9UBRpyLzcmJjtTV/il7g9+0Bi7niyXyjsObPpXQJUJdBT
         rumD/f/EReqAtgwWG3kHmexk0FpzcqzXEDvznlDhTS9iGp0moPIaQNApNtzGBEDak3Xp
         ncEffWDrVXW/ReO7Dw5pCg6Rmm9Nty/v8s225XTRysdihOSbsxntHCpt4vh+B8m77Olv
         O6gya3KellP+nY+hcG8Zf44CWT3X7CeTrtTS1b7WtM3HjFbMcDgn7g6EvzUw0AzMZHLY
         BYJ+ue5MNE7l8FT2v9f3xCDXqDwzQtbI1rM/qmrtQ2VeX6wDajmRsv6cKB5czAR3PKRC
         ZjVg==
X-Gm-Message-State: APjAAAVJBvku4Ouvg31oeNTdDze6bjApiIKpIADmTGxqUEBz+0NOsVgM
        37rwVcHgMe29IP4wFJGrwg/P7A==
X-Google-Smtp-Source: APXvYqzkdm/ufbDMjz6NTJ8+3pzRUrft6UEGKjkNpjv+C03jHIb4CVd+utTFJWjOWcDCpwBAbC0G3Q==
X-Received: by 2002:a17:90a:d082:: with SMTP id k2mr2464206pju.85.1566430193696;
        Wed, 21 Aug 2019 16:29:53 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id z19sm20864303pgv.35.2019.08.21.16.29.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Aug 2019 16:29:53 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Guillaume La Roque <glaroque@baylibre.com>, rui.zhang@intel.com,
        edubezval@gmail.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v4 4/6] arm64: dts: meson: sei510: Add minimal thermal zone
In-Reply-To: <20190821222421.30242-5-glaroque@baylibre.com>
References: <20190821222421.30242-1-glaroque@baylibre.com> <20190821222421.30242-5-glaroque@baylibre.com>
Date:   Wed, 21 Aug 2019 16:29:52 -0700
Message-ID: <7hsgpu5c7j.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Guillaume La Roque <glaroque@baylibre.com> writes:

> Add minimal thermal zone for two temperature sensor
> One is located close to the DDR and the other one is
> located close to the PLLs (between the CPU and GPU)
>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../boot/dts/amlogic/meson-g12a-sei510.dts    | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
> index c9fa23a56562..35d2ebbd6d4e 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
> @@ -10,6 +10,7 @@
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/gpio/meson-g12a-gpio.h>
>  #include <dt-bindings/sound/meson-g12a-tohdmitx.h>
> +#include <dt-bindings/thermal/thermal.h>
>  
>  / {
>  	compatible = "seirobotics,sei510", "amlogic,g12a";
> @@ -33,6 +34,67 @@
>  		ethernet0 = &ethmac;
>  	};
>  
> +	thermal-zones {
> +		cpu-thermal {
> +			polling-delay = <1000>;
> +			polling-delay-passive = <100>;
> +			thermal-sensors = <&cpu_temp>;
> +
> +			trips {
> +				cpu_hot: cpu-hot {
> +					temperature = <85000>; /* millicelsius */
> +					hysteresis = <2000>; /* millicelsius */
> +					type = "hot";
> +				};
> +
> +				cpu_critical: cpu-critical {
> +					temperature = <110000>; /* millicelsius */
> +					hysteresis = <2000>; /* millicelsius */
> +					type = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu_hot>;
> +					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +
> +				map1 {
> +					trip = <&cpu_critical>;
> +					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +
> +		ddr-thermal {
> +			polling-delay = <1000>;
> +			polling-delay-passive = <100>;
> +			thermal-sensors = <&ddr_temp>;
> +
> +			trips {
> +				ddr_critical: ddr-critical {
> +					temperature = <110000>; /* millicelsius */
> +					hysteresis = <2000>; /* millicelsius */
> +					type = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map {
> +					trip = <&ddr_critical>;
> +					cooling-device = <&mali THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +	};
> +
>  	mono_dac: audio-codec-0 {
>  		compatible = "maxim,max98357a";
>  		#sound-dai-cells = <0>;
> @@ -321,6 +383,7 @@
>  	operating-points-v2 = <&cpu_opp_table>;
>  	clocks = <&clkc CLKID_CPU_CLK>;
>  	clock-latency = <50000>;
> +	#cooling-cells = <2>;
>  };
>  
>  &cpu1 {
> @@ -328,6 +391,7 @@
>  	operating-points-v2 = <&cpu_opp_table>;
>  	clocks = <&clkc CLKID_CPU_CLK>;
>  	clock-latency = <50000>;
> +	#cooling-cells = <2>;
>  };
>  
>  &cpu2 {
> @@ -335,6 +399,7 @@
>  	operating-points-v2 = <&cpu_opp_table>;
>  	clocks = <&clkc CLKID_CPU_CLK>;
>  	clock-latency = <50000>;
> +	#cooling-cells = <2>;
>  };
>  
>  &cpu3 {
> @@ -342,6 +407,7 @@
>  	operating-points-v2 = <&cpu_opp_table>;
>  	clocks = <&clkc CLKID_CPU_CLK>;
>  	clock-latency = <50000>;
> +	#cooling-cells = <2>;
>  };
>  
>  &cvbs_vdac_port {
> @@ -368,6 +434,10 @@
>  	status = "okay";
>  };
>  
> +&mali {
> +	#cooling-cells = <2>;
> +};
> +

Is there a reason these #cooling-cells properties belong in the SoC
.dtsi and not the board .dts.  Seems like you'll have to repeat this in
every board .dts which doesn't seem necessary.

Same comment for patch 5/6

Kevin
