Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD1B2D400
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2019 04:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfE2Cxg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 May 2019 22:53:36 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43614 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfE2Cxg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 May 2019 22:53:36 -0400
Received: by mail-pg1-f195.google.com with SMTP id f25so402899pgv.10;
        Tue, 28 May 2019 19:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IRbOxDloc34+bVD1clrnHE8qeNgQWI5zIDtydL1C1Nk=;
        b=SVXxzt3Szs/n4Egthe5l0wstUwHu0GteoKDAV1UOOTMEs4O42+JUV93q+YzJyiNbHS
         y/Hrj+22ObeUhL9Llc6jnyxaaAhGn/yaYUNnI1J4TB05rzceiu9GQCVnIP08Mppaj1QT
         Xkt0T9CIf4OWKlsTUUMkviEwe4Bn2+CGNhx0M5IY2sN31sDsU5GYOtR6Ep/Oh9/kON/O
         9FPEErzHqo47d/ZlI+2KFsDWa+Fs4N1GptqE/yqqkQ9n+1AparOin8QDEiCvDTss6o1h
         bFqeI9VJOVud2nwvWzMv227PCqhKFrVyoSb3eCQ8WvTbCWGtvbUKIzfoEwqQPH7x8gwe
         Y9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IRbOxDloc34+bVD1clrnHE8qeNgQWI5zIDtydL1C1Nk=;
        b=RyD3URBBUo87M/UnQWRgtUrUWcfroRl26l5QYjMNpjz4M03e6VuaUkbtMgli15ZUa1
         BNbfyQP0sKvsoPn6sGNPnSZjy7D0DL+Fq5nmMNS8p0+EppCeARgw1Y/F/vHE0/PLYKnk
         z/x4YlRBLznu57tiPEpAycOTJb5wA2aat00t3hn6oHI7kUfKHe5i/IO9aojj4yHFvFGe
         NN6IOC115yvzl3rH5zBtjg6P9xZN65OqtkwJLfrsBT7ILiP7AetCpvx5exidOaK+le1m
         9/edQhbF31ffyHfb/GOU8TQjHvSZelaqsOS+mZJKZvLMdaYMaY4cYb/A1pplHubNh/11
         t+Lg==
X-Gm-Message-State: APjAAAW7qJlmcpEdQ8uFzMM158wDwL1ei9gvs0g+mPIplcRDu1MtHP+X
        PnJE6ZusESS8MWks/JI5a20=
X-Google-Smtp-Source: APXvYqwSGGDaSrL60LvaJmFCEVVVRHqpXuqZZDAXAzAI/Eqcp7AQAAnqTtBorkEQgcScBJHiEeOuLQ==
X-Received: by 2002:a63:4826:: with SMTP id v38mr10318770pga.417.1559098415428;
        Tue, 28 May 2019 19:53:35 -0700 (PDT)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id x24sm3893935pjq.27.2019.05.28.19.53.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 19:53:34 -0700 (PDT)
Date:   Tue, 28 May 2019 19:53:32 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Yuantian Tang <andy.tang@nxp.com>
Cc:     shawnguo@kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, daniel.lezcano@linaro.org,
        rui.zhang@intel.com
Subject: Re: [PATCH] arm64: dts: ls1028a: Add Thermal Monitor Unit node
Message-ID: <20190529025331.GB2419@localhost.localdomain>
References: <20190425082640.37982-1-andy.tang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425082640.37982-1-andy.tang@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 25, 2019 at 04:26:40PM +0800, Yuantian Tang wrote:
> The Thermal Monitoring Unit (TMU) monitors and reports the
> temperature from 2 remote temperature measurement sites
> located on ls1028a chip.
> Add TMU dts node to enable this feature.
> 
> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>

I dont see anything wrong from a thermal standpoint.

Acked-by: Eduardo Valentin <edubezval@gmail.com>

Please get this via your arch tree maintainer to avoid merge conflicts.

> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi |  114 ++++++++++++++++++++++++
>  1 files changed, 114 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index b045812..a25f5fc 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -29,6 +29,7 @@
>  			clocks = <&clockgen 1 0>;
>  			next-level-cache = <&l2>;
>  			cpu-idle-states = <&CPU_PH20>;
> +			#cooling-cells = <2>;
>  		};
>  
>  		cpu1: cpu@1 {
> @@ -39,6 +40,7 @@
>  			clocks = <&clockgen 1 0>;
>  			next-level-cache = <&l2>;
>  			cpu-idle-states = <&CPU_PH20>;
> +			#cooling-cells = <2>;
>  		};
>  
>  		l2: l2-cache {
> @@ -398,6 +400,118 @@
>  			status = "disabled";
>  		};
>  
> +		tmu: tmu@1f00000 {
> +			compatible = "fsl,qoriq-tmu";
> +			reg = <0x0 0x1f80000 0x0 0x10000>;
> +			interrupts = <0 23 0x4>;
> +			fsl,tmu-range = <0xb0000 0xa0026 0x80048 0x70061>;
> +			fsl,tmu-calibration = <0x00000000 0x00000024
> +					       0x00000001 0x0000002b
> +					       0x00000002 0x00000031
> +					       0x00000003 0x00000038
> +					       0x00000004 0x0000003f
> +					       0x00000005 0x00000045
> +					       0x00000006 0x0000004c
> +					       0x00000007 0x00000053
> +					       0x00000008 0x00000059
> +					       0x00000009 0x00000060
> +					       0x0000000a 0x00000066
> +					       0x0000000b 0x0000006d
> +
> +					       0x00010000 0x0000001c
> +					       0x00010001 0x00000024
> +					       0x00010002 0x0000002c
> +					       0x00010003 0x00000035
> +					       0x00010004 0x0000003d
> +					       0x00010005 0x00000045
> +					       0x00010006 0x0000004d
> +					       0x00010007 0x00000045
> +					       0x00010008 0x0000005e
> +					       0x00010009 0x00000066
> +					       0x0001000a 0x0000006e
> +
> +					       0x00020000 0x00000018
> +					       0x00020001 0x00000022
> +					       0x00020002 0x0000002d
> +					       0x00020003 0x00000038
> +					       0x00020004 0x00000043
> +					       0x00020005 0x0000004d
> +					       0x00020006 0x00000058
> +					       0x00020007 0x00000063
> +					       0x00020008 0x0000006e
> +
> +					       0x00030000 0x00000010
> +					       0x00030001 0x0000001c
> +					       0x00030002 0x00000029
> +					       0x00030003 0x00000036
> +					       0x00030004 0x00000042
> +					       0x00030005 0x0000004f
> +					       0x00030006 0x0000005b
> +					       0x00030007 0x00000068>;
> +			little-endian;
> +			#thermal-sensor-cells = <1>;
> +		};
> +
> +		thermal-zones {
> +			core-cluster {
> +				polling-delay-passive = <1000>;
> +				polling-delay = <5000>;
> +				thermal-sensors = <&tmu 0>;
> +
> +				trips {
> +					core_cluster_alert: core-cluster-alert {
> +						temperature = <85000>;
> +						hysteresis = <2000>;
> +						type = "passive";
> +					};
> +
> +					core_cluster_crit: core-cluster-crit {
> +						temperature = <95000>;
> +						hysteresis = <2000>;
> +						type = "critical";
> +					};
> +				};
> +
> +				cooling-maps {
> +					map0 {
> +						trip = <&core_cluster_alert>;
> +						cooling-device =
> +							<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +					};
> +				};
> +			};
> +
> +			ddr-controller {
> +				polling-delay-passive = <1000>;
> +				polling-delay = <5000>;
> +				thermal-sensors = <&tmu 1>;
> +
> +				trips {
> +					ddr_controller_alert: ddr-controller-alert {
> +						temperature = <85000>;
> +						hysteresis = <2000>;
> +						type = "passive";
> +					};
> +
> +					ddr_controller_crit: ddr-controller-crit {
> +						temperature = <95000>;
> +						hysteresis = <2000>;
> +						type = "critical";
> +					};
> +				};
> +
> +				cooling-maps {
> +					map0 {
> +						trip = <&ddr_controller_alert>;
> +						cooling-device =
> +							<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +					};
> +				};
> +			};
> +		};
> +
>  		pcie@1f0000000 { /* Integrated Endpoint Root Complex */
>  			compatible = "pci-host-ecam-generic";
>  			reg = <0x01 0xf0000000 0x0 0x100000>;
