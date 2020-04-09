Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 644C91A31C1
	for <lists+linux-pm@lfdr.de>; Thu,  9 Apr 2020 11:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgDIJae (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Apr 2020 05:30:34 -0400
Received: from mout02.posteo.de ([185.67.36.66]:37345 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgDIJae (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 Apr 2020 05:30:34 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id AA8492400FF
        for <linux-pm@vger.kernel.org>; Thu,  9 Apr 2020 11:30:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1586424630; bh=3vKK18IBU+GDtmCbWLdhddK39mV7mf0TfnAFzsj7y40=;
        h=Subject:To:Cc:From:Autocrypt:Date:From;
        b=lYjuNff4CTkyHnVQ/u6IEedCTw/GPI0RsY3ySmWz0+PH9dnRM4Wo/Nv/JKUOQpNxX
         TbQrwMOA5ZDevbqxyafTRZCbdUZA/Dbl7wA4RSjrtf85+DfU/qjDohb9j0jIz9GwY+
         X4PLg1DN9/nQsinjcnOdxyzqw6IB1yuk71+J/mAkdA/KeVspuETS50ZLMRJPS0cci4
         5IlOlBhqReGEnlBUCet3AVn3o0zNx3VFnlMej/mPg3pn5wkgRKfErQpXj+na0ieH3V
         +U9aTEe4k3vCS89RNnggQbZrhSTW+uNNARKmFbECQE2XbQ2Mdw/eyiZtr3efXKfoj+
         Ih/9Rga3S0BOw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 48ybTs5HBRz6tmY;
        Thu,  9 Apr 2020 11:30:25 +0200 (CEST)
Subject: Re: [PATCH v3 8/8] arm64: dts: imx8m: Add NOC nodes
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, Jacky Bai <ping.bai@nxp.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Angus Ainslie <angus@akkea.ca>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Silvano di Ninno <silvano.dininno@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Saravana Kannan <saravanak@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
References: <cover.1586174566.git.leonard.crestez@nxp.com>
 <cc14c8134238311fb35ce1eabe7ec9d5dfffb762.1586174566.git.leonard.crestez@nxp.com>
From:   Martin Kepplinger <martink@posteo.de>
Autocrypt: addr=martink@posteo.de; keydata=
 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
Message-ID: <f5e074e4-7147-4a8f-da58-96ab34f77dee@posteo.de>
Date:   Thu, 9 Apr 2020 11:30:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <cc14c8134238311fb35ce1eabe7ec9d5dfffb762.1586174566.git.leonard.crestez@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06.04.20 14:03, Leonard Crestez wrote:
> Add nodes for the main interconnect of the imx8m series chips.
> 
> These nodes are bound to by devfreq and interconnect drivers.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 24 +++++++++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8mn.dtsi | 24 +++++++++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 24 +++++++++++++++++++++++
>  3 files changed, 72 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index 175c28ae10cf..41047b6709b6 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -6,10 +6,11 @@
>  #include <dt-bindings/clock/imx8mm-clock.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/thermal/thermal.h>
> +#include <dt-bindings/interconnect/imx8mm.h>
>  
>  #include "imx8mm-pinfunc.h"
>  
>  / {
>  	interrupt-parent = <&gic>;
> @@ -860,10 +861,33 @@
>  				status = "disabled";
>  			};
>  
>  		};
>  
> +		noc: interconnect@32700000 {
> +			compatible = "fsl,imx8mm-noc", "fsl,imx8m-noc";
> +			reg = <0x32700000 0x100000>;
> +			clocks = <&clk IMX8MM_CLK_NOC>;
> +			fsl,ddrc = <&ddrc>;
> +			#interconnect-cells = <1>;
> +			operating-points-v2 = <&noc_opp_table>;
> +
> +			noc_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-150M {
> +					opp-hz = /bits/ 64 <150000000>;
> +				};
> +				opp-375M {
> +					opp-hz = /bits/ 64 <375000000>;
> +				};
> +				opp-750M {
> +					opp-hz = /bits/ 64 <750000000>;
> +				};
> +			};
> +		};
> +
>  		aips4: bus@32c00000 {
>  			compatible = "fsl,aips-bus", "simple-bus";
>  			reg = <0x32df0000 0x10000>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> index 88e7d74e077f..e8a55956813f 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> @@ -6,10 +6,11 @@
>  #include <dt-bindings/clock/imx8mn-clock.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/thermal/thermal.h>
> +#include <dt-bindings/interconnect/imx8mn.h>
>  
>  #include "imx8mn-pinfunc.h"
>  
>  / {
>  	interrupt-parent = <&gic>;
> @@ -751,10 +752,33 @@
>  				status = "disabled";
>  			};
>  
>  		};
>  
> +		noc: interconnect@32700000 {
> +			compatible = "fsl,imx8mn-noc", "fsl,imx8m-noc";
> +			reg = <0x32700000 0x100000>;
> +			clocks = <&clk IMX8MN_CLK_NOC>;
> +			fsl,ddrc = <&ddrc>;
> +			#interconnect-cells = <1>;
> +			operating-points-v2 = <&noc_opp_table>;
> +
> +			noc_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-100M {
> +					opp-hz = /bits/ 64 <100000000>;
> +				};
> +				opp-600M {
> +					opp-hz = /bits/ 64 <600000000>;
> +				};
> +				opp-800M {
> +					opp-hz = /bits/ 64 <800000000>;
> +				};
> +			};
> +		};
> +
>  		aips4: bus@32c00000 {
>  			compatible = "fsl,aips-bus", "simple-bus";
>  			reg = <0x32df0000 0x10000>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index ea93bc4b7d7e..3a208feec74c 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -9,10 +9,11 @@
>  #include <dt-bindings/reset/imx8mq-reset.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include "dt-bindings/input/input.h"
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/thermal/thermal.h>
> +#include <dt-bindings/interconnect/imx8mq.h>
>  #include "imx8mq-pinfunc.h"
>  
>  / {
>  	interrupt-parent = <&gpc>;
>  
> @@ -1026,10 +1027,33 @@
>  				fsl,num-rx-queues = <3>;
>  				status = "disabled";
>  			};
>  		};
>  
> +		noc: interconnect@32700000 {
> +			compatible = "fsl,imx8mq-noc", "fsl,imx8m-noc";
> +			reg = <0x32700000 0x100000>;
> +			clocks = <&clk IMX8MQ_CLK_NOC>;
> +			fsl,ddrc = <&ddrc>;
> +			#interconnect-cells = <1>;
> +			operating-points-v2 = <&noc_opp_table>;
> +
> +			noc_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-133M {
> +					opp-hz = /bits/ 64 <133333333>;
> +				};
> +				opp-400M {
> +					opp-hz = /bits/ 64 <400000000>;
> +				};
> +				opp-800M {
> +					opp-hz = /bits/ 64 <800000000>;
> +				};
> +			};
> +		};
> +
>  		bus@32c00000 { /* AIPS4 */
>  			compatible = "fsl,aips-bus", "simple-bus";
>  			reg = <0x32df0000 0x10000>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> 

imx8mq:
Tested-by: Martin Kepplinger <martin.kepplinger@puri.sm>

                       martin
