Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B221D17D4D9
	for <lists+linux-pm@lfdr.de>; Sun,  8 Mar 2020 17:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgCHQfr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 8 Mar 2020 12:35:47 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46610 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgCHQfr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 8 Mar 2020 12:35:47 -0400
Received: by mail-lf1-f65.google.com with SMTP id v6so5628200lfo.13
        for <linux-pm@vger.kernel.org>; Sun, 08 Mar 2020 09:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=SCn2CpVC/7ynZUWvGTDmpECNjpBPxtQHPMbxz1lBSOQ=;
        b=VBwElsPwH4qLkHurgScNaHNHOiGUnQFVuXLs47+GzkvBpuVSogd92FF/MYnHIn9d/m
         8F4fcpi2vppv8TT0bOMhzzYFk+CqYgNJWuH6q31JTUYoxqndZbhItF/tAC2EI5s8wpk/
         o5onxJelZaDxOUI4COgA/C9cn76H2+iiQ487IQwrvdGPlAf/Un4T9vock+xKOwdy8Dj4
         Uq8bXPLzu9T+WvWQU86PMi3FCRwPJrPOs+GGpi+cO0t32PuCDVFOp30dQsJqgmRbHCQg
         KdzHi4WjOZ5F+W2hYQkNbxRiPcwg5yW2jz2fWDxOpaDSEBdv91NRKOFmtEnjlIT/GKm2
         iNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SCn2CpVC/7ynZUWvGTDmpECNjpBPxtQHPMbxz1lBSOQ=;
        b=t+pcpBgpyImjoLuUrPgLY0XjJP7Pc6xIbGU4eyqIjtOOlogl9yn6CQB8eWXZcCIugN
         2NyIZtyL6i33cvWzAwNzzKtUWG7B9kbQb3K6yfoRfOEQ9/hh+ijxiNSD951SSrdsHIP2
         GIOTUtNCQqjGm0+2rlrkABwV4G8r+ZDLz9zYlYpiYqkN1N6kxDaFCw9QCUyY4teZLmSU
         Py1RZnb1NuNzysff/rtZlsvaEXKn3iSIAzm+yXYThicLwIW0uc8COY6g2hgFrSGW6giT
         hCyh71ShjOA5R5GksUCM6Z7QLmcqIybDGVvPc/3Fv2SMfPINn4b3W961AnefNcpvIyvy
         4m2A==
X-Gm-Message-State: ANhLgQ1tgwDWYKdLp/RgsKJaC1D2g9MJWpjs328CVzK/tvb0m7kxyuYz
        gNThnFSxADVst04/B8Qbb5Fkig==
X-Google-Smtp-Source: ADFU+vuo9cIWcyNT/HEu7Hn2mCrfDG0g9mOpd0bFl78MAIG7W5xNck5AJIKMHv1L7fu+OcBX7OdTfA==
X-Received: by 2002:ac2:4201:: with SMTP id y1mr7412717lfh.92.1583685345015;
        Sun, 08 Mar 2020 09:35:45 -0700 (PDT)
Received: from localhost (h-200-138.A463.priv.bahnhof.se. [176.10.200.138])
        by smtp.gmail.com with ESMTPSA id o4sm14989027lfl.62.2020.03.08.09.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2020 09:35:44 -0700 (PDT)
Date:   Sun, 8 Mar 2020 17:35:43 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: renesas: r8a77961: Add thermal nodes
Message-ID: <20200308163543.GD2975348@oden.dyn.berto.se>
References: <20200306110025.24747-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200306110025.24747-1-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Geert,

Thanks for your work.

On 2020-03-06 12:00:25 +0100, Geert Uytterhoeven wrote:
> Add a device node for the Thermal Sensor/Chip Internal Voltage Monitor
> in the R-Car M3-W+ (R8A77961) SoC, and describe the thermal zones.
> 
> According to the R-Car Gen3 Hardware Manual Errata for Revision 2.00 of
> Jan 31, 2020, the thermal parameters for R-Car M3-W+ are the same as for
> R-Car M3-W.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> It's a bit cold in Magnus' lab:
> 
> / # grep . /sys/devices/virtual/thermal/thermal_zone?/temp
> /sys/devices/virtual/thermal/thermal_zone0/temp:17000
> /sys/devices/virtual/thermal/thermal_zone1/temp:19000
> /sys/devices/virtual/thermal/thermal_zone2/temp:18000
> ---
>  arch/arm64/boot/dts/renesas/r8a77961.dtsi | 80 +++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a77961.dtsi b/arch/arm64/boot/dts/renesas/r8a77961.dtsi
> index b6915319a61c8bf0..2f016458f57d3a33 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77961.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a77961.dtsi
> @@ -474,6 +474,20 @@
>  			#power-domain-cells = <1>;
>  		};
>  
> +		tsc: thermal@e6198000 {
> +			compatible = "renesas,r8a77961-thermal";
> +			reg = <0 0xe6198000 0 0x100>,
> +			      <0 0xe61a0000 0 0x100>,
> +			      <0 0xe61a8000 0 0x100>;
> +			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 522>;
> +			power-domains = <&sysc R8A77961_PD_ALWAYS_ON>;
> +			resets = <&cpg 522>;
> +			#thermal-sensor-cells = <1>;
> +		};
> +
>  		intc_ex: interrupt-controller@e61c0000 {
>  			#interrupt-cells = <2>;
>  			interrupt-controller;
> @@ -785,6 +799,7 @@
>  			status = "disabled";
>  		};
>  
> +

This don't looks like it's needed :-) With this fixed,

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

>  		pwm1: pwm@e6e31000 {
>  			reg = <0 0xe6e31000 0 8>;
>  			#pwm-cells = <2>;
> @@ -1073,6 +1088,71 @@
>  		};
>  	};
>  
> +	thermal-zones {
> +		sensor_thermal1: sensor-thermal1 {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +			thermal-sensors = <&tsc 0>;
> +			sustainable-power = <3874>;
> +
> +			trips {
> +				sensor1_crit: sensor1-crit {
> +					temperature = <120000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		sensor_thermal2: sensor-thermal2 {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +			thermal-sensors = <&tsc 1>;
> +			sustainable-power = <3874>;
> +
> +			trips {
> +				sensor2_crit: sensor2-crit {
> +					temperature = <120000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		sensor_thermal3: sensor-thermal3 {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +			thermal-sensors = <&tsc 2>;
> +			sustainable-power = <3874>;
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&target>;
> +					cooling-device = <&a57_0 2 4>;
> +					contribution = <1024>;
> +				};
> +				map1 {
> +					trip = <&target>;
> +					cooling-device = <&a53_0 0 2>;
> +					contribution = <1024>;
> +				};
> +			};
> +			trips {
> +				target: trip-point1 {
> +					temperature = <100000>;
> +					hysteresis = <1000>;
> +					type = "passive";
> +				};
> +
> +				sensor3_crit: sensor3-crit {
> +					temperature = <120000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +	};
> +
>  	timer {
>  		compatible = "arm,armv8-timer";
>  		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
> -- 
> 2.17.1
> 

-- 
Regards,
Niklas Söderlund
