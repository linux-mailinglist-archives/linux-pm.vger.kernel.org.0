Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C190E3DC76A
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jul 2021 19:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbhGaRjh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 31 Jul 2021 13:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbhGaRjT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 31 Jul 2021 13:39:19 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA91C0613D5;
        Sat, 31 Jul 2021 10:39:06 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id h2so24955983lfu.4;
        Sat, 31 Jul 2021 10:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nGQjSozPSFmelHHY6OEA+/mUKU2e+EvC+v2vXqxb8f8=;
        b=A3XJtK58biEnbflsvi+OcJIdj/DAXYi9J5DnR2uRyLgQJpN5kV2arK3R6FVy/yS2oA
         wtMEP0Fs+smeGc8A+XB15cMsJSVfsoLVIMTfHZczV5a2pzOBBa6kJV81nogaaLRD/6UI
         qIt+QRN6CW9QE7V8mDs2cVnNButqKe5TqFrXpAdGycCvXh483zc53SSqeQNv3Wdijio8
         YqfC7JMfWUIfagxDcj3SiLODt2NLOrXN+y2Zs5q3zdj3cq7zbwGCqavIBd8m88y23NT+
         VOcUqZfiZESUkX6lXR9gLw9pKHzzRrJWcgqZnKA5kJ0uXTBQQI2qCHgbar075SAvz256
         YnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nGQjSozPSFmelHHY6OEA+/mUKU2e+EvC+v2vXqxb8f8=;
        b=SYmg4EPxv5tEmjgADHj+bdhrq0o+kEBmpQOfdVZusk1E1g5QC1RZi04vmwqbjl4bVT
         DX9p6o9y6PvEz/J8xkKHWYqrYq/n90HYaCR9GEeU+dFukp+XLEg+QTlZ/2K77Mc2+SaR
         VVcfbXhv3LGYNDTtSuqXhcGoL4AiFbN1QAAeZRb5lnx8y7ebFfXDK4YhMxz2RY4p1Qhf
         cYBHwAqVVP3W6cqLsGy/Rr6Pe1Z6k9pGi/XQqCVxN04ruO58lHnkCBt5w5Oyo8WfqqOy
         YvDKzm4SKPk4pPzQWb7UXxnQ0Q2bzId6mGKZGvDKAiZcD9XNPsr5IG/mU1tPMyzLBvbb
         IC/Q==
X-Gm-Message-State: AOAM532+yMi3WWEg1wMK4OO3Ss/rgnQz2syrvzMIFfYwInBw1izzZkR9
        BroK36R1Vu60i395sKNhxhc=
X-Google-Smtp-Source: ABdhPJz5XlyxAn3Rw6IUKI00TONoeXELq14ceNPjYcom+Fmu5CCYYYfFqcFkPMVzXo143Q0Xx/7DyA==
X-Received: by 2002:a05:6512:cf:: with SMTP id c15mr6460507lfp.317.1627753144755;
        Sat, 31 Jul 2021 10:39:04 -0700 (PDT)
Received: from localhost.localdomain (94-29-22-96.dynamic.spd-mgts.ru. [94.29.22.96])
        by smtp.gmail.com with ESMTPSA id s15sm445272lfp.216.2021.07.31.10.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 10:39:04 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v6 10/12] ARM: tegra: Add new properties to USB PHY device-tree nodes
Date:   Sat, 31 Jul 2021 20:38:40 +0300
Message-Id: <20210731173842.19643-11-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210731173842.19643-1-digetx@gmail.com>
References: <20210731173842.19643-1-digetx@gmail.com>
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
index 2015147c2de3..ce2171739cf8 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -879,6 +879,7 @@ phy1: usb-phy@c5000000 {
 		compatible = "nvidia,tegra20-usb-phy";
 		reg = <0xc5000000 0x4000>,
 		      <0xc5000000 0x4000>;
+		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 		phy_type = "utmi";
 		clocks = <&tegra_car TEGRA20_CLK_USBD>,
 			 <&tegra_car TEGRA20_CLK_PLL_U>,
@@ -897,6 +898,7 @@ phy1: usb-phy@c5000000 {
 		nvidia,xcvr-lsfslew = <1>;
 		nvidia,xcvr-lsrslew = <1>;
 		nvidia,has-utmi-pad-registers;
+		nvidia,pmc = <&tegra_pmc 0>;
 		status = "disabled";
 	};
 
@@ -917,6 +919,7 @@ usb@c5004000 {
 	phy2: usb-phy@c5004000 {
 		compatible = "nvidia,tegra20-usb-phy";
 		reg = <0xc5004000 0x4000>;
+		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
 		phy_type = "ulpi";
 		clocks = <&tegra_car TEGRA20_CLK_USB2>,
 			 <&tegra_car TEGRA20_CLK_PLL_U>,
@@ -925,6 +928,7 @@ phy2: usb-phy@c5004000 {
 		resets = <&tegra_car 58>, <&tegra_car 22>;
 		reset-names = "usb", "utmi-pads";
 		#phy-cells = <0>;
+		nvidia,pmc = <&tegra_pmc 1>;
 		status = "disabled";
 	};
 
@@ -946,6 +950,7 @@ phy3: usb-phy@c5008000 {
 		compatible = "nvidia,tegra20-usb-phy";
 		reg = <0xc5008000 0x4000>,
 		      <0xc5000000 0x4000>;
+		interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
 		phy_type = "utmi";
 		clocks = <&tegra_car TEGRA20_CLK_USB3>,
 			 <&tegra_car TEGRA20_CLK_PLL_U>,
@@ -962,6 +967,7 @@ phy3: usb-phy@c5008000 {
 		nvidia,xcvr-setup = <9>;
 		nvidia,xcvr-lsfslew = <2>;
 		nvidia,xcvr-lsrslew = <2>;
+		nvidia,pmc = <&tegra_pmc 2>;
 		status = "disabled";
 	};
 
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 339ddda4b2a7..9c757b63a197 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -1151,6 +1151,7 @@ phy1: usb-phy@7d000000 {
 		compatible = "nvidia,tegra30-usb-phy";
 		reg = <0x7d000000 0x4000>,
 		      <0x7d000000 0x4000>;
+		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 		phy_type = "utmi";
 		clocks = <&tegra_car TEGRA30_CLK_USBD>,
 			 <&tegra_car TEGRA30_CLK_PLL_U>,
@@ -1171,6 +1172,7 @@ phy1: usb-phy@7d000000 {
 		nvidia,hssquelch-level = <2>;
 		nvidia,hsdiscon-level = <5>;
 		nvidia,has-utmi-pad-registers;
+		nvidia,pmc = <&tegra_pmc 0>;
 		status = "disabled";
 	};
 
@@ -1192,6 +1194,7 @@ phy2: usb-phy@7d004000 {
 		compatible = "nvidia,tegra30-usb-phy";
 		reg = <0x7d004000 0x4000>,
 		      <0x7d000000 0x4000>;
+		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
 		phy_type = "utmi";
 		clocks = <&tegra_car TEGRA30_CLK_USB2>,
 			 <&tegra_car TEGRA30_CLK_PLL_U>,
@@ -1211,6 +1214,7 @@ phy2: usb-phy@7d004000 {
 		nvidia,xcvr-hsslew = <32>;
 		nvidia,hssquelch-level = <2>;
 		nvidia,hsdiscon-level = <5>;
+		nvidia,pmc = <&tegra_pmc 1>;
 		status = "disabled";
 	};
 
@@ -1232,6 +1236,7 @@ phy3: usb-phy@7d008000 {
 		compatible = "nvidia,tegra30-usb-phy";
 		reg = <0x7d008000 0x4000>,
 		      <0x7d000000 0x4000>;
+		interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
 		phy_type = "utmi";
 		clocks = <&tegra_car TEGRA30_CLK_USB3>,
 			 <&tegra_car TEGRA30_CLK_PLL_U>,
@@ -1251,6 +1256,7 @@ phy3: usb-phy@7d008000 {
 		nvidia,xcvr-hsslew = <32>;
 		nvidia,hssquelch-level = <2>;
 		nvidia,hsdiscon-level = <5>;
+		nvidia,pmc = <&tegra_pmc 2>;
 		status = "disabled";
 	};
 
-- 
2.32.0

