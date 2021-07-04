Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6713BAF8B
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jul 2021 00:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhGDW6w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Jul 2021 18:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbhGDW6p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Jul 2021 18:58:45 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AE4C061764;
        Sun,  4 Jul 2021 15:56:09 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id r26so11572476lfp.2;
        Sun, 04 Jul 2021 15:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5vwSYHWvsFFWwr0WMVQTe8N3Eb33ImyMSmRuVsspPMo=;
        b=bhgK2ANMfzyHNBxSf3UIZkZEDxqX5j1iuOq+6Z+bE508Y65lQzUNK/VvOHGT5akup7
         8cYgWslGL26pCEyYFfN6FWKqP6nyuyDUVZAqplEQNFsnxEiVZwM6arVXEJpcv21ZWx94
         lalwkyjaN5lJcDE9VR+yDSKDH0Rb+/n/ZCKEOYvdX12rP/yCxs4tHikScPNRhFK4x2ng
         McidgawtnZMj8TmMFjRmFewKVX7397RuGNh96LmPtIy/Bg+P19d2y94rQzYCIO0dFpyQ
         nMNQXldtpa09y3bH7qsN0TDL+JnMFKOKOz2sYiVOnez9sCWLJ9Rd75LeUwUei22LVdjg
         F9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5vwSYHWvsFFWwr0WMVQTe8N3Eb33ImyMSmRuVsspPMo=;
        b=rLLwztnMtifyLam2Ui5Ke3Mr4ruH9/BiQjny+Bs5irK9XBkrHoS5trLNGHB9dlK2MU
         75XPdroWRrHOGEpNj/+qWymYqHbnXlyaWmi3fY3ErnsaYt5GcRmNJbd8BBtxwPNVQEEU
         JurFcZSjUNifsiTK5kGzWSFeFgni+vDKcsZro6h4Qi18sHUtf10d8Iyu3MNtdsQH6iBi
         5S/fWi12U0ardyCozA4mPFKxkf6n+ObFODHu29ZlqP2SJRI/mCjJgnEeTrgQ35N9auHP
         r/V9u8gvVyvne4VV8MEoXyNthqmp9KU/DlmwvA3ruoc0kVGdmFJmnx8P8GGrGyXlfCdt
         w9Yw==
X-Gm-Message-State: AOAM530BSx/XghoSlPZlL7PEycMJLCkMTdSfnfhTq0rlEKnssgWJBUKM
        I8tkaU/tNpXY8vn73iM72Oc=
X-Google-Smtp-Source: ABdhPJyc1Gsmoq+hy3pIw4nSKGRNuR3zsn7mU/FXSXSG51tL952xLbP8vQCOOEpESTg8tpxRfZac6Q==
X-Received: by 2002:a05:6512:6cc:: with SMTP id u12mr8466639lff.32.1625439368026;
        Sun, 04 Jul 2021 15:56:08 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id i13sm497921lfc.111.2021.07.04.15.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 15:56:07 -0700 (PDT)
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
Subject: [PATCH v3 11/12] ARM: tegra: Add new properties to USB PHY device-tree nodes
Date:   Mon,  5 Jul 2021 01:54:32 +0300
Message-Id: <20210704225433.32029-12-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210704225433.32029-1-digetx@gmail.com>
References: <20210704225433.32029-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add new properties to USB PHYs needed for enabling USB OTG mode.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra114.dtsi | 6 ++++++
 arch/arm/boot/dts/tegra124.dtsi | 9 +++++++++
 arch/arm/boot/dts/tegra20.dtsi  | 9 +++++++++
 arch/arm/boot/dts/tegra30.dtsi  | 9 +++++++++
 4 files changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index fb99b3e971c3..c04817851bce 100644
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
@@ -725,6 +726,8 @@ phy1: usb-phy@7d000000 {
 		nvidia,hsdiscon-level = <5>;
 		nvidia,xcvr-hsslew = <12>;
 		nvidia,has-utmi-pad-registers;
+		nvidia,pmc = <&tegra_pmc>;
+		nvidia,phy-instance = <0>;
 		status = "disabled";
 	};
 
@@ -744,6 +747,7 @@ phy3: usb-phy@7d008000 {
 		compatible = "nvidia,tegra114-usb-phy", "nvidia,tegra30-usb-phy";
 		reg = <0x7d008000 0x4000>,
 		      <0x7d000000 0x4000>;
+		interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
 		phy_type = "utmi";
 		clocks = <&tegra_car TEGRA114_CLK_USB3>,
 			 <&tegra_car TEGRA114_CLK_PLL_U>,
@@ -762,6 +766,8 @@ phy3: usb-phy@7d008000 {
 		nvidia,hssquelch-level = <2>;
 		nvidia,hsdiscon-level = <5>;
 		nvidia,xcvr-hsslew = <12>;
+		nvidia,pmc = <&tegra_pmc>;
+		nvidia,phy-instance = <2>;
 		status = "disabled";
 	};
 
diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 8b38f123f554..0daa1e97c1f6 100644
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
@@ -1113,6 +1114,8 @@ phy1: usb-phy@7d000000 {
 		nvidia,hsdiscon-level = <5>;
 		nvidia,xcvr-hsslew = <12>;
 		nvidia,has-utmi-pad-registers;
+		nvidia,pmc = <&tegra_pmc>;
+		nvidia,phy-instance = <0>;
 		status = "disabled";
 	};
 
@@ -1132,6 +1135,7 @@ phy2: usb-phy@7d004000 {
 		compatible = "nvidia,tegra124-usb-phy", "nvidia,tegra30-usb-phy";
 		reg = <0x0 0x7d004000 0x0 0x4000>,
 		      <0x0 0x7d000000 0x0 0x4000>;
+		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
 		phy_type = "utmi";
 		clocks = <&tegra_car TEGRA124_CLK_USB2>,
 			 <&tegra_car TEGRA124_CLK_PLL_U>,
@@ -1150,6 +1154,8 @@ phy2: usb-phy@7d004000 {
 		nvidia,hssquelch-level = <2>;
 		nvidia,hsdiscon-level = <5>;
 		nvidia,xcvr-hsslew = <12>;
+		nvidia,pmc = <&tegra_pmc>;
+		nvidia,phy-instance = <1>;
 		status = "disabled";
 	};
 
@@ -1169,6 +1175,7 @@ phy3: usb-phy@7d008000 {
 		compatible = "nvidia,tegra124-usb-phy", "nvidia,tegra30-usb-phy";
 		reg = <0x0 0x7d008000 0x0 0x4000>,
 		      <0x0 0x7d000000 0x0 0x4000>;
+		interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
 		phy_type = "utmi";
 		clocks = <&tegra_car TEGRA124_CLK_USB3>,
 			 <&tegra_car TEGRA124_CLK_PLL_U>,
@@ -1187,6 +1194,8 @@ phy3: usb-phy@7d008000 {
 		nvidia,hssquelch-level = <2>;
 		nvidia,hsdiscon-level = <5>;
 		nvidia,xcvr-hsslew = <12>;
+		nvidia,pmc = <&tegra_pmc>;
+		nvidia,phy-instance = <2>;
 		status = "disabled";
 	};
 
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 70d81a6cbc61..d4c068415bfd 100644
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
@@ -893,6 +894,8 @@ phy1: usb-phy@c5000000 {
 		nvidia,xcvr-lsfslew = <1>;
 		nvidia,xcvr-lsrslew = <1>;
 		nvidia,has-utmi-pad-registers;
+		nvidia,pmc = <&tegra_pmc>;
+		nvidia,phy-instance= <0>;
 		status = "disabled";
 	};
 
@@ -913,6 +916,7 @@ usb@c5004000 {
 	phy2: usb-phy@c5004000 {
 		compatible = "nvidia,tegra20-usb-phy";
 		reg = <0xc5004000 0x4000>;
+		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
 		phy_type = "ulpi";
 		clocks = <&tegra_car TEGRA20_CLK_USB2>,
 			 <&tegra_car TEGRA20_CLK_PLL_U>,
@@ -921,6 +925,8 @@ phy2: usb-phy@c5004000 {
 		resets = <&tegra_car 58>, <&tegra_car 22>;
 		reset-names = "usb", "utmi-pads";
 		#phy-cells = <0>;
+		nvidia,pmc = <&tegra_pmc>;
+		nvidia,phy-instance= <1>;
 		status = "disabled";
 	};
 
@@ -942,6 +948,7 @@ phy3: usb-phy@c5008000 {
 		compatible = "nvidia,tegra20-usb-phy";
 		reg = <0xc5008000 0x4000>,
 		      <0xc5000000 0x4000>;
+		interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
 		phy_type = "utmi";
 		clocks = <&tegra_car TEGRA20_CLK_USB3>,
 			 <&tegra_car TEGRA20_CLK_PLL_U>,
@@ -958,6 +965,8 @@ phy3: usb-phy@c5008000 {
 		nvidia,xcvr-setup = <9>;
 		nvidia,xcvr-lsfslew = <2>;
 		nvidia,xcvr-lsrslew = <2>;
+		nvidia,pmc = <&tegra_pmc>;
+		nvidia,phy-instance= <2>;
 		status = "disabled";
 	};
 
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 377bbc50ad2a..f6d63799f05d 100644
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
@@ -1163,6 +1164,8 @@ phy1: usb-phy@7d000000 {
 		nvidia,hssquelch-level = <2>;
 		nvidia,hsdiscon-level = <5>;
 		nvidia,has-utmi-pad-registers;
+		nvidia,pmc = <&tegra_pmc>;
+		nvidia,phy-instance = <0>;
 		status = "disabled";
 	};
 
@@ -1184,6 +1187,7 @@ phy2: usb-phy@7d004000 {
 		compatible = "nvidia,tegra30-usb-phy";
 		reg = <0x7d004000 0x4000>,
 		      <0x7d000000 0x4000>;
+		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
 		phy_type = "utmi";
 		clocks = <&tegra_car TEGRA30_CLK_USB2>,
 			 <&tegra_car TEGRA30_CLK_PLL_U>,
@@ -1203,6 +1207,8 @@ phy2: usb-phy@7d004000 {
 		nvidia,xcvr-hsslew = <32>;
 		nvidia,hssquelch-level = <2>;
 		nvidia,hsdiscon-level = <5>;
+		nvidia,pmc = <&tegra_pmc>;
+		nvidia,phy-instance = <1>;
 		status = "disabled";
 	};
 
@@ -1224,6 +1230,7 @@ phy3: usb-phy@7d008000 {
 		compatible = "nvidia,tegra30-usb-phy";
 		reg = <0x7d008000 0x4000>,
 		      <0x7d000000 0x4000>;
+		interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
 		phy_type = "utmi";
 		clocks = <&tegra_car TEGRA30_CLK_USB3>,
 			 <&tegra_car TEGRA30_CLK_PLL_U>,
@@ -1243,6 +1250,8 @@ phy3: usb-phy@7d008000 {
 		nvidia,xcvr-hsslew = <32>;
 		nvidia,hssquelch-level = <2>;
 		nvidia,hsdiscon-level = <5>;
+		nvidia,pmc = <&tegra_pmc>;
+		nvidia,phy-instance = <2>;
 		status = "disabled";
 	};
 
-- 
2.32.0

