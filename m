Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5463B8C40
	for <lists+linux-pm@lfdr.de>; Thu,  1 Jul 2021 04:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238750AbhGAC1e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Jun 2021 22:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238690AbhGAC1Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Jun 2021 22:27:25 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04311C0617AE;
        Wed, 30 Jun 2021 19:24:54 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id d25so6156710lji.7;
        Wed, 30 Jun 2021 19:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aduSnERZ8l22vkadiHklXq9E0cxO6EtBQR5Z63zqRHw=;
        b=SyexQ6LhRMibveWk8vrp9KoOBrp0q0KMsnbgPUj7A4KVBsmnWkpBo0+AvSK5LAIYA7
         JfnerbaUZrjuZmLst0dkaWOQzIzXtyAghB5udla+xVXzNs8xFKJLmXUaSU4sA8olY2PL
         WJgoo62q1DrWLvLBmxJJ8EBCI4kXoohbd+39m2T+S1+FqztcfIlPfdtqlhJXOtFOQxyu
         7piFavPG6cPvUfWSeU1tr3St/QDxtQ5HzT0wEzKKfQS095Ll1YhhqAiyZGzAlGp4zUu9
         md4qC/SkURGJgenorojZE7I0pSABbJcCPhsQ1oiJJAmhzwk79P+cznNEq49Jb1/eK8DG
         tQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aduSnERZ8l22vkadiHklXq9E0cxO6EtBQR5Z63zqRHw=;
        b=i+2wVglfNiI4ob6Rh3NYp4OIqa3EH3waCHjZB4StV65PRQaH56h3ltXLlDA5ys/qGX
         Hvp4E4SKHzG0r4J1mcuDmpuL9KHFjsw350ki+R2K8phBqaKO3rW8hY5VII3AcUsA5jE6
         4eP6oBUuL0Jfz0YSe4woM2Jsw1fdcb1/DuZxL6TewD82txN3NInlKC1jH0y5wB17viEx
         FA0Oy8ZI0zI71nEyXkqYvwzIkMlQM1ZUAbKQxb/MwwtvbCkKmAz634/cUsGnCGR7P5sy
         6v69La9Lw6zje/WjFR/6TMRbQg6jGP878/W6dXmlnEsxiMuNhjXbKIK75afBlPcPq1iF
         R8xA==
X-Gm-Message-State: AOAM530YFFJqDx+svNomoMu3m6zZFu3mVFcHtcgCanQv0p2udKTyEbFB
        gJVfFAtjfh482r3+zylZgIs=
X-Google-Smtp-Source: ABdhPJzPPMP1RLEXi+I4B2IFCRv0/qrHrNplfdgTV6zV314Ad2P8/cnY+cmAlBZJxf0iYQElbfd6CA==
X-Received: by 2002:a2e:7211:: with SMTP id n17mr10066015ljc.133.1625106292373;
        Wed, 30 Jun 2021 19:24:52 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id v7sm2407262ljn.14.2021.06.30.19.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 19:24:52 -0700 (PDT)
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
Subject: [PATCH v1 11/12] ARM: tegra: Add new properties to USB PHY device-tree nodes
Date:   Thu,  1 Jul 2021 05:24:04 +0300
Message-Id: <20210701022405.10817-12-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701022405.10817-1-digetx@gmail.com>
References: <20210701022405.10817-1-digetx@gmail.com>
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
index 69f344aaf871..4decf5f00d09 100644
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
2.30.2

