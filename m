Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFCA63A326
	for <lists+linux-pm@lfdr.de>; Mon, 28 Nov 2022 09:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiK1IeI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Nov 2022 03:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiK1IeI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Nov 2022 03:34:08 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A7462D5;
        Mon, 28 Nov 2022 00:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1669624446; x=1701160446;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iwI2vXusxEJcdrBbQlsu9BgwoiXuqhhIdkuJYPsTfNM=;
  b=JqbVwzF9EwvEGZRN4o4Q/J7PHy42++jaPnRSK034VK6iVHcUUIqs2cpv
   4KvDfcAaMVDsj5LS1XDprScnwV54RIp6H2I+Lc0pDjB1wL9QbCZ8AsWNz
   Un2evpQax1rhaPFsq0jVRS6/iK7G8Ek3hdXZm5tsO1NsA/odoWKumR28C
   TwVjVUb4teQT+FEGFbBfb3DJnV4rmgIwzc0USwe2PwFL/jzy7K6zlhgQG
   BI35Fdx1XYayLblBYXLF1X4fRaHTwQo34wZZMZh5mFtFKEogZ5d+K9Lbw
   ShcaykuWPTnypF6NBDuqRIEllkbZpJw0cSh7uXnLBXWPL6ecWtaXWNI6B
   g==;
X-IronPort-AV: E=Sophos;i="5.96,199,1665439200"; 
   d="scan'208";a="27607326"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 28 Nov 2022 09:34:04 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 28 Nov 2022 09:34:04 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 28 Nov 2022 09:34:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1669624444; x=1701160444;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iwI2vXusxEJcdrBbQlsu9BgwoiXuqhhIdkuJYPsTfNM=;
  b=lRFfnBX36UXXBmdmOpHzCPP8/c5LizQ+q3IBEy17uQuWIHcR8K5AsxrB
   +BTsFYPI455picgA1LgB0vjg1cX1OvyuCH+zgDZxfjFTIJipX9ZQaGOV1
   TRICe5h52YiTaw3e3st/QI1ctr+OYI7XYiLUq7oBTgMJR40JHOFCGIxW5
   +p9NDAxO/hxPNli6gUyRtP/4C8IFIobcOx8xXemXHfTKTmP2YzaS+Egb2
   fMNlbxbg6EchziiLHE6S8j2MC0DpYTh/Bh1loR2+nNyxIJ3235ck7BJoK
   xSv0c9DdJjThKGsSBP0tIGALwI4N418oMNJuYRlW/K6J8VOZmpJwPb28n
   w==;
X-IronPort-AV: E=Sophos;i="5.96,199,1665439200"; 
   d="scan'208";a="27607325"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 28 Nov 2022 09:34:04 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 066D8280056;
        Mon, 28 Nov 2022 09:34:04 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Adam Ford <aford173@gmail.com>, Alice Guo <alice.guo@nxp.com>,
        Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Jun <jun.li@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, devicetree@vger.kernel.org,
        Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 4/5] arm64: dts: imx8m: Add TMU phandle to calibration data in OCOTP
Date:   Mon, 28 Nov 2022 09:34:03 +0100
Message-ID: <12103021.O9o76ZdvQC@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20221126224740.311625-4-marex@denx.de>
References: <20221126224740.311625-1-marex@denx.de> <20221126224740.311625-4-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Marek,

Am Samstag, 26. November 2022, 23:47:39 CET schrieb Marek Vasut:
> The TMU TASR, TCALIVn, TRIM registers must be explicitly programmed with
> calibration values in OCOTP. Add the OCOTP calibration values phandle so
> the TMU driver can perform this programming.
> 
> The MX8MM/MX8MN TMUv1 uses only one OCOTP cell, while MX8MP TMUv2 uses 4.

Is there any source for the fuse addresses? I can only find  
OCOTP_OCOTP_HW_OCOTP_ANA1 and a calibration description in TMU section in the 
IMX8MNRM Rev 2, but I can't find any fuse for imx8mm and imx8mp.

Best regards,
Alexander

> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Adam Ford <aford173@gmail.com>
> Cc: Alice Guo <alice.guo@nxp.com>
> Cc: Amit Kucheria <amitk@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Li Jun <jun.li@nxp.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Richard Cochran <richardcochran@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: devicetree@vger.kernel.org
> To: linux-pm@vger.kernel.org
> To: linux-arm-kernel@lists.infradead.org
> ---
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 6 ++++++
>  arch/arm64/boot/dts/freescale/imx8mn.dtsi | 6 ++++++
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 6 ++++++
>  3 files changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mm.dtsi index
> 513c2de0caa15..0cd7fff47c44d 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -496,6 +496,8 @@ tmu: tmu@30260000 {
>  				compatible = "fsl,imx8mm-tmu";
>  				reg = <0x30260000 0x10000>;
>  				clocks = <&clk IMX8MM_CLK_TMU_ROOT>;
> +				nvmem-cells = <&tmu_calib>;
> +				nvmem-cell-names = "calib";
>  				#thermal-sensor-cells = <0>;
>  			};
> 
> @@ -584,6 +586,10 @@ cpu_speed_grade: speed-grade@10 { /* 0x440 */
>  					reg = <0x10 4>;
>  				};
> 
> +				tmu_calib: calib@3c { /* 0x4f0 */
> +					reg = <0x3c 4>;
> +				};
> +
>  				fec_mac_address: mac-address@90 { /* 
0x640 */
>  					reg = <0x90 6>;
>  				};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mn.dtsi index
> 068f599cdf757..5eef9b274edde 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> @@ -498,6 +498,8 @@ tmu: tmu@30260000 {
>  				compatible = "fsl,imx8mn-tmu", 
"fsl,imx8mm-tmu";
>  				reg = <0x30260000 0x10000>;
>  				clocks = <&clk IMX8MN_CLK_TMU_ROOT>;
> +				nvmem-cells = <&tmu_calib>;
> +				nvmem-cell-names = "calib";
>  				#thermal-sensor-cells = <0>;
>  			};
> 
> @@ -585,6 +587,10 @@ cpu_speed_grade: speed-grade@10 { /* 0x440 */
>  					reg = <0x10 4>;
>  				};
> 
> +				tmu_calib: calib@3c { /* 0x4f0 */
> +					reg = <0x3c 4>;
> +				};
> +
>  				fec_mac_address: mac-address@90 { /* 
0x640 */
>  					reg = <0x90 6>;
>  				};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mp.dtsi index
> ddcd5e23ba47d..0173e394ad4d8 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -380,6 +380,8 @@ tmu: tmu@30260000 {
>  				compatible = "fsl,imx8mp-tmu";
>  				reg = <0x30260000 0x10000>;
>  				clocks = <&clk 
IMX8MP_CLK_TSENSOR_ROOT>;
> +				nvmem-cells = <&tmu_calib>;
> +				nvmem-cell-names = "calib";
>  				#thermal-sensor-cells = <1>;
>  			};
> 
> @@ -454,6 +456,10 @@ eth_mac1: mac-address@90 { /* 0x640 */
>  				eth_mac2: mac-address@96 { /* 0x658 */
>  					reg = <0x96 6>;
>  				};
> +
> +				tmu_calib: calib@264 { /* 0xd90-0xdc0 
*/
> +					reg = <0x264 0x10>;
> +				};
>  			};
> 
>  			anatop: clock-controller@30360000 {




