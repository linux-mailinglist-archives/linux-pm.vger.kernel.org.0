Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9F52EC9E2
	for <lists+linux-pm@lfdr.de>; Thu,  7 Jan 2021 06:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbhAGFNi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Jan 2021 00:13:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:40912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbhAGFNi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 7 Jan 2021 00:13:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C200D225AC;
        Thu,  7 Jan 2021 05:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609996377;
        bh=ErN54kxZTm8lZUalspRnGSyijSi97JU0sRRnNxeJrvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nljmi6aTkFBa0rPNe89gwF8J1A6HOYBueNCVXr3u/O3Yf6SzkqK7O8XDZ/jG99gxx
         1h0MsUN01WVG/YpH7f0ApPRgRQRi1LBRKUzMNly2CkhRF1I2LSJK6hNDZRwV/rnBSG
         qsriMqFnf0xk/NaPvrRuEEHrC3mnUekB9Px6hT7m8lvcojjMR+MoXK4S4aXcliWHpP
         yMECHvKeTIGAtSA4YuUrdN9Tg2LC1LfcYM3lvxqo5g38hj/IJgUT9eqnkYY7m8qqi2
         5bethOrnJE7bRaqU3nzEoMehHbPUv+sJLdJ9mGjkfOroZv+HzTfvXe8Jc6mnHjqXY/
         wrgNVmkesfNaQ==
Date:   Thu, 7 Jan 2021 13:12:50 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, festevam@gmail.com, catalin.marinas@arm.com,
        will@kernel.org, georgi.djakov@linaro.org, cdleonard@gmail.com,
        kernel@pengutronix.de, linux-imx@nxp.com, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH v3 1/6] arm64: dts: imx8mq: Add NOC node
Message-ID: <20210107051250.GD28365@dragon>
References: <20201210100906.18205-1-martin.kepplinger@puri.sm>
 <20201210100906.18205-2-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210100906.18205-2-martin.kepplinger@puri.sm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 10, 2020 at 11:09:01AM +0100, Martin Kepplinger wrote:
> From: Leonard Crestez <leonard.crestez@nxp.com>
> 
> Add initial support for dynamic frequency scaling of the main NOC
> on imx8mq.
> 
> Make DDRC the parent of the NOC (using passive governor) so that the
> main NOC is automatically scaled together with DDRC by default.
> 
> Support for proactive scaling via interconnect will come on top.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index a841a023e8e0..9c9d68a14e69 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -1158,6 +1158,28 @@
>  			};
>  		};
>  
> +		noc: interconnect@32700000 {
> +			compatible = "fsl,imx8mq-noc", "fsl,imx8m-noc";
> +			reg = <0x32700000 0x100000>;
> +			clocks = <&clk IMX8MQ_CLK_NOC>;
> +			fsl,ddrc = <&ddrc>;
> +			operating-points-v2 = <&noc_opp_table>;
> +
> +			noc_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-133M {
> +					opp-hz = /bits/ 64 <133333333>;
> +				};

Please have a newline between nodes.

Shawn

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
>  			reg = <0x32c00000 0x400000>;
> -- 
> 2.20.1
> 
