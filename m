Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17FF43CC31D
	for <lists+linux-pm@lfdr.de>; Sat, 17 Jul 2021 14:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbhGQMOp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Jul 2021 08:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbhGQMOe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 17 Jul 2021 08:14:34 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FB0C061762;
        Sat, 17 Jul 2021 05:11:35 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 22so20518638lfy.12;
        Sat, 17 Jul 2021 05:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Opx0gfO/khSxaDkjnYl+ZQVaHdEB8y2tIK6Yv/mgSFM=;
        b=P8dpWr/0Bztd31+9KyZUHcbBoNvTDdPpPPs7Cj7ZQW7FDe6eFg23WhLrs7GvsFfGn4
         jZgNrmKaApuimjhiF8KtqLV4ESM1aLTSS4EDgJHNS2WT5Ix9w0GSugSfBUnmQhqFp/pA
         Wr3I437CokKlgHUOKzOmX+iPqZJMCoxec0GKcDbgGauYx2ifGBg/0h7+B3M7z2bhxiq4
         SvqO8IftIUIKFZDtFdwaOlnXR3Re4C0xxyVCNm3+WFEJ6bdjBYsc0Unpzh14JMjX0kas
         Ad9lYEg7eI/oura1lfjFeuKbGmlejRPRCRDiGAXybzXIOkYQf0ZZDS41J/WYlptQOCLB
         1itA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Opx0gfO/khSxaDkjnYl+ZQVaHdEB8y2tIK6Yv/mgSFM=;
        b=qAXbKJoTOvulaNmHsgZf1ujDKnRCJ55GF7jagX5ap4diNxNL+AMFMrLfDSqdqcO/lN
         KKfUgSz7jOhRUAqv2/EBAQa2eKxz8TaW9gJV0eUOyp5RSoCrlDY+wBSUv05/rK5+KG+o
         BeA7Ik3DZoh4cSlQkilYl8xrUOfN67mJBMqe4nd6u5+vK/sPYfuUnuAFUTfeEYFBeon+
         RDSEvq8jC0qSRuskU16qUdQHiBfejhUWvNKkpOCjJJBS7Q+3HfvV22AJ688qlPGELxmS
         0lFNQqBgEyS4cB8Sji5ROFCEVwGoY5ina4/DKRHktBenwI1MxsMfwdrbsvVvwDMwtyZ5
         Uchw==
X-Gm-Message-State: AOAM530hfQWyIgfy10nSXBihyWSclcH40yU9MDkjPH2bbmeJQiEQXAkQ
        ld1eJogmHS6x00MdLe2HLUfQFLtoD3w=
X-Google-Smtp-Source: ABdhPJwS2QRV7bkYRQ6Kx66Fq9BECqE6Bolll51tSaspUEQW1lo/Cm9tnQlaQ9LUp1afv+L1hbKbsQ==
X-Received: by 2002:a05:6512:3053:: with SMTP id b19mr11628159lfb.167.1626523894150;
        Sat, 17 Jul 2021 05:11:34 -0700 (PDT)
Received: from localhost.localdomain (46-138-17-250.dynamic.spd-mgts.ru. [46.138.17.250])
        by smtp.gmail.com with ESMTPSA id m16sm852597lfq.23.2021.07.17.05.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 05:11:33 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v4 10/12] ARM: tegra: Add new properties to USB PHY device-tree nodes
Date:   Sat, 17 Jul 2021 15:11:10 +0300
Message-Id: <20210717121112.3248-11-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210717121112.3248-1-digetx@gmail.com>
References: <20210717121112.3248-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add new properties to USB PHYs needed for enabling USB OTG mode.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra114.dtsi | 4 ++++
 arch/arm/boot/dts/tegra124.dtsi | 6 ++++++
 arch/arm/boot/dts/tegra20.dtsi  | 6 ++++++
 arch/arm/boot/dts/tegra30.dtsi  | 6 ++++++
 4 files changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index fb99b3e971c3..b391c7940b8f 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -706,6 +706,7 @@ phy1: usb-phy@7d000000 {
 		compatible = "nvidia,tegra114-usb-phy", "nvidia,tegra30-usb-phy";
 		reg = <0x7d000000 0x4000>,
 		      <0x7d000000 0x4000>;
+		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 		phy_type = "utmi";
 		clocks = <&tegra_car TEGRA114_CLK_USBD>,
 			 <&tegra_car TEGRA114_CLK_PLL_U>,
@@ -725,6 +726,7 @@ phy1: usb-phy@7d000000 {
 		nvidia,hsdiscon-level = <5>;
 		nvidia,xcvr-hsslew = <12>;
 		nvidia,has-utmi-pad-registers;
+		nvidia,pmc = <&tegra_pmc 0>;
 		status = "disabled";
 	};
 
@@ -744,6 +746,7 @@ phy3: usb-phy@7d008000 {
 		compatible = "nvidia,tegra114-usb-phy", "nvidia,tegra30-usb-phy";
 		reg = <0x7d008000 0x4000>,
 		      <0x7d000000 0x4000>;
+		interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
 		phy_type = "utmi";
 		clocks = <&tegra_car TEGRA114_CLK_USB3>,
 			 <&tegra_car TEGRA114_CLK_PLL_U>,
@@ -762,6 +765,7 @@ phy3: usb-phy@7d008000 {
 		nvidia,hssquelch-level = <2>;
 		nvidia,hsdiscon-level = <5>;
 		nvidia,xcvr-hsslew = <12>;
+		nvidia,pmc = <&tegra_pmc 2>;
 		status = "disabled";
 	};
 
diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 8b38f123f554..ee28bb2b01ba 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -1094,6 +1094,7 @@ phy1: usb-phy@7d000000 {
 		compatible = "nvidia,tegra124-usb-phy", "nvidia,tegra30-usb-phy";
 		reg = <0x0 0x7d000000 0x0 0x4000>,
 		      <0x0 0x7d000000 0x0 0x4000>;
+		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 		phy_type = "utmi";
 		clocks = <&tegra_car TEGRA124_CLK_USBD>,
 			 <&tegra_car TEGRA124_CLK_PLL_U>,
@@ -1113,6 +1114,7 @@ phy1: usb-phy@7d000000 {
 		nvidia,hsdiscon-level = <5>;
 		nvidia,xcvr-hsslew = <12>;
 		nvidia,has-utmi-pad-registers;
+		nvidia,pmc = <&tegra_pmc 0>;
 		status = "disabled";
 	};
 
@@ -1132,6 +1134,7 @@ phy2: usb-phy@7d004000 {
 		compatible = "nvidia,tegra124-usb-phy", "nvidia,tegra30-usb-phy";
 		reg = <0x0 0x7d004000 0x0 0x4000>,
 		      <0x0 0x7d000000 0x0 0x4000>;
+		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
 		phy_type = "utmi";
 		clocks = <&tegra_car TEGRA124_CLK_USB2>,
 			 <&tegra_car TEGRA124_CLK_PLL_U>,
@@ -1150,6 +1153,7 @@ phy2: usb-phy@7d004000 {
 		nvidia,hssquelch-level = <2>;
 		nvidia,hsdiscon-level = <5>;
 		nvidia,xcvr-hsslew = <12>;
+		nvidia,pmc = <&tegra_pmc 1>;
 		status = "disabled";
 	};
 
@@ -1169,6 +1173,7 @@ phy3: usb-phy@7d008000 {
 		compatible = "nvidia,tegra124-usb-phy", "nvidia,tegra30-usb-phy";
 		reg = <0x0 0x7d008000 0x0 0x4000>,
 		      <0x0 0x7d000000 0x0 0x4000>;
+		interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
 		phy_type = "utmi";
 		clocks = <&tegra_car TEGRA124_CLK_USB3>,
 			 <&tegra_car TEGRA124_CLK_PLL_U>,
@@ -1187,6 +1192,7 @@ phy3: usb-phy@7d008000 {
 		nvidia,hssquelch-level = <2>;
 		nvidia,hsdiscon-level = <5>;
 		nvidia,xcvr-hsslew = <12>;
+		nvidia,pmc = <&tegra_pmc 2>;
 		status = "disabled";
 	};
 
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 70d81a6cbc61..1dfd5880e282 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -875,6 +875,7 @@ phy1: usb-phy@c5000000 {
 		compatible = "nvidia,tegra20-usb-phy";
 		reg = <0xc5000000 0x4000>,
 		      <0xc5000000 0x4000>;
+		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 		phy_type = "utmi";
 		clocks = <&tegra_car TEGRA20_CLK_USBD>,
 			 <&tegra_car TEGRA20_CLK_PLL_U>,
@@ -893,6 +894,7 @@ phy1: usb-phy@c5000000 {
 		nvidia,xcvr-lsfslew = <1>;
 		nvidia,xcvr-lsrslew = <1>;
 		nvidia,has-utmi-pad-registers;
+		nvidia,pmc = <&tegra_pmc 0>;
 		status = "disabled";
 	};
 
@@ -913,6 +915,7 @@ usb@c5004000 {
 	phy2: usb-phy@c5004000 {
 		compatible = "nvidia,tegra20-usb-phy";
 		reg = <0xc5004000 0x4000>;
+		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
 		phy_type = "ulpi";
 		clocks = <&tegra_car TEGRA20_CLK_USB2>,
 			 <&tegra_car TEGRA20_CLK_PLL_U>,
@@ -921,6 +924,7 @@ phy2: usb-phy@c5004000 {
 		resets = <&tegra_car 58>, <&tegra_car 22>;
 		reset-names = "usb", "utmi-pads";
 		#phy-cells = <0>;
+		nvidia,pmc = <&tegra_pmc 1>;
 		status = "disabled";
 	};
 
@@ -942,6 +946,7 @@ phy3: usb-phy@c5008000 {
 		compatible = "nvidia,tegra20-usb-phy";
 		reg = <0xc5008000 0x4000>,
 		      <0xc5000000 0x4000>;
+		interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
 		phy_type = "utmi";
 		clocks = <&tegra_car TEGRA20_CLK_USB3>,
 			 <&tegra_car TEGRA20_CLK_PLL_U>,
@@ -958,6 +963,7 @@ phy3: usb-phy@c5008000 {
 		nvidia,xcvr-setup = <9>;
 		nvidia,xcvr-lsfslew = <2>;
 		nvidia,xcvr-lsrslew = <2>;
+		nvidia,pmc = <&tegra_pmc 2>;
 		status = "disabled";
 	};
 
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 377bbc50ad2a..776df5a1dd3f 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -1143,6 +1143,7 @@ phy1: usb-phy@7d000000 {
 		compatible = "nvidia,tegra30-usb-phy";
 		reg = <0x7d000000 0x4000>,
 		      <0x7d000000 0x4000>;
+		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 		phy_type = "utmi";
 		clocks = <&tegra_car TEGRA30_CLK_USBD>,
 			 <&tegra_car TEGRA30_CLK_PLL_U>,
@@ -1163,6 +1164,7 @@ phy1: usb-phy@7d000000 {
 		nvidia,hssquelch-level = <2>;
 		nvidia,hsdiscon-level = <5>;
 		nvidia,has-utmi-pad-registers;
+		nvidia,pmc = <&tegra_pmc 0>;
 		status = "disabled";
 	};
 
@@ -1184,6 +1186,7 @@ phy2: usb-phy@7d004000 {
 		compatible = "nvidia,tegra30-usb-phy";
 		reg = <0x7d004000 0x4000>,
 		      <0x7d000000 0x4000>;
+		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
 		phy_type = "utmi";
 		clocks = <&tegra_car TEGRA30_CLK_USB2>,
 			 <&tegra_car TEGRA30_CLK_PLL_U>,
@@ -1203,6 +1206,7 @@ phy2: usb-phy@7d004000 {
 		nvidia,xcvr-hsslew = <32>;
 		nvidia,hssquelch-level = <2>;
 		nvidia,hsdiscon-level = <5>;
+		nvidia,pmc = <&tegra_pmc 1>;
 		status = "disabled";
 	};
 
@@ -1224,6 +1228,7 @@ phy3: usb-phy@7d008000 {
 		compatible = "nvidia,tegra30-usb-phy";
 		reg = <0x7d008000 0x4000>,
 		      <0x7d000000 0x4000>;
+		interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
 		phy_type = "utmi";
 		clocks = <&tegra_car TEGRA30_CLK_USB3>,
 			 <&tegra_car TEGRA30_CLK_PLL_U>,
@@ -1243,6 +1248,7 @@ phy3: usb-phy@7d008000 {
 		nvidia,xcvr-hsslew = <32>;
 		nvidia,hssquelch-level = <2>;
 		nvidia,hsdiscon-level = <5>;
+		nvidia,pmc = <&tegra_pmc 2>;
 		status = "disabled";
 	};
 
-- 
2.32.0

