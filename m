Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 531B973FFF
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2019 22:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387946AbfGXTYc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 24 Jul 2019 15:24:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33749 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfGXTYb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jul 2019 15:24:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so48256611wru.0;
        Wed, 24 Jul 2019 12:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lfXxMsdfj3/069jvw/iy7OsZv8+UN7ABTGl62C7QKYA=;
        b=KLLLaPbbO8eBii32cX5LOLTw947XYtHea0krdZtddLVAbCJq3zgEvX7KZSrvFeFiOn
         REt/zdFIOh9DOTYmmIClMDgVilFbTKEXSL/L+W7X+QJFQZHN3C8Qax/2lZgRAnnpCUBS
         Ao8WrJ7/5BebbGC+jobo7W5z9cRz7nPWtvcgF3lY4e2q1388+BQf/y3u0HywZHa3JzEZ
         Ik7k1prk7lnTrMdtp6EafMdwaaw2wAR8iMTcZLDEKctSAk19vGTDcjnkm5/sHLUorBdP
         GIW2mSo3ZLDspEQK3ORYLHyotRCrUgXLmulfoC69xJ0vs9lpLMmdeL6bYs4nLJofaCeL
         p2nA==
X-Gm-Message-State: APjAAAU/RoLqKcXiSeqKQ3hwto3eCPPZ+KurFnauN7NUGGqGij+Tnc+M
        1eoISvJ5U+izgM0EZxRwER8=
X-Google-Smtp-Source: APXvYqxsoh43HV2OpAyo0WN3mesXUKeJis1EeqQpdnzoRNCOZlfiNYz32Xds+Ra9u+/5tu5G/kpe4w==
X-Received: by 2002:adf:80e6:: with SMTP id 93mr51827758wrl.298.1563996269437;
        Wed, 24 Jul 2019 12:24:29 -0700 (PDT)
Received: from kozik-lap ([194.230.155.239])
        by smtp.googlemail.com with ESMTPSA id o6sm91244088wra.27.2019.07.24.12.24.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jul 2019 12:24:28 -0700 (PDT)
Date:   Wed, 24 Jul 2019 21:24:26 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, m.szyprowski@samsung.com
Subject: Re: [RFC PATCH 08/11] arm: dts: exynos: Add parents and
 #interconnect-cells to Exynos4412
Message-ID: <20190724192426.GJ14346@kozik-lap>
References: <20190723122016.30279-1-a.swigon@partner.samsung.com>
 <CGME20190723122027eucas1p24b1d76e3139f7cc52614d7613ff9ba98@eucas1p2.samsung.com>
 <20190723122016.30279-9-a.swigon@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190723122016.30279-9-a.swigon@partner.samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 23, 2019 at 02:20:13PM +0200, Artur Świgoń wrote:
> This patch adds two fields tp the Exynos4412 DTS:

tp->to

>   - parent: to declare connections between nodes that are not in a
>     parent-child relation in devfreq;

Is it a standard property?
The explanation needs some improvement... why are you adding parent to a
devices which are not child-parent?

Best regards,
Krzysztof

>   - #interconnect-cells: required by the interconnect framework.
> 
> Please note that #interconnect-cells is always zero and node IDs are not
> hardcoded anywhere.
> 
> Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
> ---
>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 1 +
>  arch/arm/boot/dts/exynos4412.dtsi               | 9 +++++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> index ea55f377d17c..bdd61ae86103 100644
> --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> @@ -106,6 +106,7 @@
>  &bus_leftbus {
>  	devfreq-events = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
>  	vdd-supply = <&buck3_reg>;
> +	parent = <&bus_dmc>;
>  	status = "okay";
>  };
>  
> diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
> index d20db2dfe8e2..a70a671acacd 100644
> --- a/arch/arm/boot/dts/exynos4412.dtsi
> +++ b/arch/arm/boot/dts/exynos4412.dtsi
> @@ -390,6 +390,7 @@
>  			clocks = <&clock CLK_DIV_DMC>;
>  			clock-names = "bus";
>  			operating-points-v2 = <&bus_dmc_opp_table>;
> +			#interconnect-cells = <0>;
>  			status = "disabled";
>  		};
>  
> @@ -398,6 +399,7 @@
>  			clocks = <&clock CLK_DIV_ACP>;
>  			clock-names = "bus";
>  			operating-points-v2 = <&bus_acp_opp_table>;
> +			#interconnect-cells = <0>;
>  			status = "disabled";
>  		};
>  
> @@ -406,6 +408,7 @@
>  			clocks = <&clock CLK_DIV_C2C>;
>  			clock-names = "bus";
>  			operating-points-v2 = <&bus_dmc_opp_table>;
> +			#interconnect-cells = <0>;
>  			status = "disabled";
>  		};
>  
> @@ -459,6 +462,7 @@
>  			clocks = <&clock CLK_DIV_GDL>;
>  			clock-names = "bus";
>  			operating-points-v2 = <&bus_leftbus_opp_table>;
> +			#interconnect-cells = <0>;
>  			status = "disabled";
>  		};
>  
> @@ -467,6 +471,7 @@
>  			clocks = <&clock CLK_DIV_GDR>;
>  			clock-names = "bus";
>  			operating-points-v2 = <&bus_leftbus_opp_table>;
> +			#interconnect-cells = <0>;
>  			status = "disabled";
>  		};
>  
> @@ -475,6 +480,7 @@
>  			clocks = <&clock CLK_ACLK160>;
>  			clock-names = "bus";
>  			operating-points-v2 = <&bus_display_opp_table>;
> +			#interconnect-cells = <0>;
>  			status = "disabled";
>  		};
>  
> @@ -483,6 +489,7 @@
>  			clocks = <&clock CLK_ACLK133>;
>  			clock-names = "bus";
>  			operating-points-v2 = <&bus_fsys_opp_table>;
> +			#interconnect-cells = <0>;
>  			status = "disabled";
>  		};
>  
> @@ -491,6 +498,7 @@
>  			clocks = <&clock CLK_ACLK100>;
>  			clock-names = "bus";
>  			operating-points-v2 = <&bus_peri_opp_table>;
> +			#interconnect-cells = <0>;
>  			status = "disabled";
>  		};
>  
> @@ -499,6 +507,7 @@
>  			clocks = <&clock CLK_SCLK_MFC>;
>  			clock-names = "bus";
>  			operating-points-v2 = <&bus_leftbus_opp_table>;
> +			#interconnect-cells = <0>;
>  			status = "disabled";
>  		};
>  
> -- 
> 2.17.1
> 
