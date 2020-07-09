Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003C521A97C
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jul 2020 23:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgGIVEw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jul 2020 17:04:52 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40453 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgGIVEw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2020 17:04:52 -0400
Received: by mail-io1-f67.google.com with SMTP id q8so3830856iow.7;
        Thu, 09 Jul 2020 14:04:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ep2BUalGoUDMYiRgPfHR0K5E7uXRpZtzmzl5wMZRFHs=;
        b=AA7h/I7bauQk7abixJNncQ1aG7YAueNZEsj/fiA9sBsdq8245RqKrRTJXTgoMUIpt/
         4Q0TW0wHHs2hzkI0D3HXUx4wFAu4sx4o3u0reOT40nu4PXaORKVn93G4ZbnXmHkdWwFI
         96JGzwoXWFMIOgcWw9OuYKNvZCXs9SfW0lwIFruNsQvymFgAHmxyK1Gd+qUQvURqrkZ+
         M93nafNiQ2jRwcG+6WXqtSCEubJsrFGz6VkxmwsdbsoqzaqqwO1/qjPIn5Aa3dRumZ82
         g+ec7sAabgIemW01IlMMyncuBLa8tmtHzUqFPU0Y56G9pOF10VAtTjdsVNo44Q1zvWBy
         1jFw==
X-Gm-Message-State: AOAM530528xuNMhoaWv0viItMQMdr+5m0B0qkWYTD3O+DpAVGb+bI66Q
        SS3j0oTEqEvXfdqtvNqiiw==
X-Google-Smtp-Source: ABdhPJzzckh793p74m62K2t6bgxJyhqTwep2hglKcjMTiXCsSoxr/OlqW/k8gyAtxdeWk6fveOx07A==
X-Received: by 2002:a02:cd06:: with SMTP id g6mr43286633jaq.37.1594328690447;
        Thu, 09 Jul 2020 14:04:50 -0700 (PDT)
Received: from xps15 ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id g8sm2399655ilq.49.2020.07.09.14.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 14:04:49 -0700 (PDT)
Received: (nullmailer pid 883283 invoked by uid 1000);
        Thu, 09 Jul 2020 21:04:48 -0000
Date:   Thu, 9 Jul 2020 15:04:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     georgi.djakov@linaro.org, cw00.choi@samsung.com, krzk@kernel.org,
        devicetree@vger.kernel.org, a.swigon@samsung.com,
        myungjoo.ham@samsung.com, inki.dae@samsung.com,
        sw0312.kim@samsung.com, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC v6 1/6] dt-bindings: exynos-bus: Add documentation
 for interconnect properties
Message-ID: <20200709210448.GA876103@bogus>
References: <20200702163724.2218-1-s.nawrocki@samsung.com>
 <CGME20200702163748eucas1p2cf7eab70bc072dea9a95183018b38ad3@eucas1p2.samsung.com>
 <20200702163724.2218-2-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200702163724.2218-2-s.nawrocki@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 02, 2020 at 06:37:19PM +0200, Sylwester Nawrocki wrote:
> Add documentation for new optional properties in the exynos bus nodes:
> samsung,interconnect-parent, #interconnect-cells, bus-width.
> These properties allow to specify the SoC interconnect structure which
> then allows the interconnect consumer devices to request specific
> bandwidth requirements.
> 
> Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes for v6:
>  - added dts example of bus hierarchy definition and the interconnect
>    consumer,
>  - added new bus-width property.
> 
> Changes for v5:
>  - exynos,interconnect-parent-node renamed to samsung,interconnect-parent
> ---
>  .../devicetree/bindings/devfreq/exynos-bus.txt     | 68 +++++++++++++++++++++-
>  1 file changed, 66 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
> index e71f752..4035e3e 100644
> --- a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
> +++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
> @@ -51,6 +51,13 @@ Optional properties only for parent bus device:
>  - exynos,saturation-ratio: the percentage value which is used to calibrate
>  			the performance count against total cycle count.
>  
> +Optional properties for interconnect functionality (QoS frequency constraints):
> +- samsung,interconnect-parent: phandle to the parent interconnect node; for
> +  passive devices should point to same node as the exynos,parent-bus property.

Adding vendor specific properties for a common binding defeats the 
point.

> +- #interconnect-cells: should be 0.
> +- bus-width: the interconnect bus width in bits, default value is 8 when this
> +  property is missing.

Your bus is 8-bits or 4-bits as the example?

> +
>  Detailed correlation between sub-blocks and power line according to Exynos SoC:
>  - In case of Exynos3250, there are two power line as following:
>  	VDD_MIF |--- DMC
> @@ -135,7 +142,7 @@ Detailed correlation between sub-blocks and power line according to Exynos SoC:
>  		|--- PERIC (Fixed clock rate)
>  		|--- FSYS  (Fixed clock rate)
>  
> -Example1:
> +Example 1:
>  	Show the AXI buses of Exynos3250 SoC. Exynos3250 divides the buses to
>  	power line (regulator). The MIF (Memory Interface) AXI bus is used to
>  	transfer data between DRAM and CPU and uses the VDD_MIF regulator.
> @@ -184,7 +191,7 @@ Example1:
>  	|L5   |200000 |200000  |400000 |300000 |       ||1000000 |
>  	----------------------------------------------------------
>  
> -Example2 :
> +Example 2:
>  	The bus of DMC (Dynamic Memory Controller) block in exynos3250.dtsi
>  	is listed below:
>  
> @@ -419,3 +426,60 @@ Example2 :
>  		devfreq = <&bus_leftbus>;
>  		status = "okay";
>  	};
> +
> +Example 3:
> +	An interconnect path "bus_display -- bus_leftbus -- bus_dmc" on
> +	Exynos4412 SoC with video mixer as an interconnect consumer device.
> +
> +	soc {
> +		bus_dmc: bus_dmc {
> +			compatible = "samsung,exynos-bus";
> +			clocks = <&clock CLK_DIV_DMC>;
> +			clock-names = "bus";
> +			operating-points-v2 = <&bus_dmc_opp_table>;
> +			bus-width = <4>;
> +			#interconnect-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		bus_leftbus: bus_leftbus {
> +			compatible = "samsung,exynos-bus";
> +			clocks = <&clock CLK_DIV_GDL>;
> +			clock-names = "bus";
> +			operating-points-v2 = <&bus_leftbus_opp_table>;
> +			samsung,interconnect-parent = <&bus_dmc>;
> +			#interconnect-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		bus_display: bus_display {
> +			compatible = "samsung,exynos-bus";
> +			clocks = <&clock CLK_ACLK160>;
> +			clock-names = "bus";
> +			operating-points-v2 = <&bus_display_opp_table>;
> +			samsung,interconnect-parent = <&bus_leftbus>;
> +			#interconnect-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		bus_dmc_opp_table: opp_table1 {
> +			compatible = "operating-points-v2";
> +			/* ... */
> +		}
> +
> +		bus_leftbus_opp_table: opp_table3 {
> +			compatible = "operating-points-v2";
> +			/* ... */
> +		};
> +
> +		bus_display_opp_table: opp_table4 {
> +			compatible = "operating-points-v2";
> +			/* .. */
> +		};
> +
> +		&mixer {
> +			compatible = "samsung,exynos4212-mixer";
> +			interconnects = <&bus_display &bus_dmc>;
> +			/* ... */
> +		};
> +	};
> -- 
> 2.7.4
> 
