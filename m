Return-Path: <linux-pm+bounces-22589-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C4EA3E991
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 02:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EDE317BF37
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 01:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051CF2C187;
	Fri, 21 Feb 2025 01:00:30 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2612AD13;
	Fri, 21 Feb 2025 01:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740099629; cv=none; b=mmy5lUsfkiXQsVpUQxFdKSL0BapZct3A1pUkaPzos3GKVIUq2EBeh9pXblKypMuraIX/bWfhdUXi4rp+lI4Bdwr5TVBqBhC70wzrwjiug4RR+ASh5NiSaPQIDXILm4Ez6JZtdUNId4qKZSKLFG5ipSDgRh3nFmouCNiluSArj6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740099629; c=relaxed/simple;
	bh=Z7YW0++AAqIo98z6DBnMerWXfId2k/29R1PiCFEj0uA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cjSY8+fDuW/04r7XLH1JXpeFqEnZYZft1ziCU2mu7p5s21bIM1Bxi+8Oe+RXNMoQ1yd8J8CTGbD+1BinnqVik+XZCvJRnY9mNUkVMTSMuhlgo0diouWJSntZBtGqg7opLCiJxv9gopFKEhsmjzoDmkafEjodiIH2+AKs2VuTn7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4DD31BA8;
	Thu, 20 Feb 2025 17:00:44 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 79BE83F59E;
	Thu, 20 Feb 2025 17:00:24 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-pm@vger.kernel.org
Subject: [PATCH 5/5] arm64: dts: allwinner: h616: enable Mali GPU for all boards
Date: Fri, 21 Feb 2025 00:58:02 +0000
Message-ID: <20250221005802.11001-6-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250221005802.11001-1-andre.przywara@arm.com>
References: <20250221005802.11001-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All Allwinner H616/H618 SoCs contain a Mali G31 MP2 GPU.

Enable the DT nodes for that GPU, and specify the regulator providing
power to the VDD_GPU pins of the package. The rest of the DT node is set
by the SoC, so is not board specific.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h313-tanix-tx1.dts      | 5 +++++
 .../boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi      | 5 +++++
 arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi | 4 ++++
 arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts | 4 ++++
 arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts       | 5 +++++
 .../boot/dts/allwinner/sun50i-h618-longan-module-3h.dtsi     | 5 +++++
 .../arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero2w.dts | 5 +++++
 arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts | 4 ++++
 .../boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts     | 5 +++++
 .../boot/dts/allwinner/sun50i-h618-yuzukihd-chameleon.dts    | 5 +++++
 .../boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts  | 5 +++++
 11 files changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h313-tanix-tx1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h313-tanix-tx1.dts
index 17e6aef67aaf9..7906b79c03898 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h313-tanix-tx1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h313-tanix-tx1.dts
@@ -79,6 +79,11 @@ &ehci0 {
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&reg_dcdc1>;
+	status = "okay";
+};
+
 &ir {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi
index d12b01c5f41b6..bebfeb2a337a3 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi
@@ -67,6 +67,11 @@ &cpu0 {
 	cpu-supply = <&reg_dcdc2>;
 };
 
+&gpu {
+	mali-supply = <&reg_dcdc1>;
+	status = "okay";
+};
+
 &mmc0 {
 	vmmc-supply = <&reg_dldo1>;
 	/* Card detection pin is not connected */
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi
index 908fa3b847a66..a8644fb52b04e 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi
@@ -77,6 +77,10 @@ &emac0 {
 	status = "okay";
 };
 
+&gpu {
+	status = "okay";
+};
+
 &mdio0 {
 	ext_rgmii_phy: ethernet-phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
index a360d8567f955..f2e3300e078a9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
@@ -24,6 +24,10 @@ &emac0 {
 	phy-supply = <&reg_dcdce>;
 };
 
+&gpu {
+	mali-supply = <&reg_dcdcc>;
+};
+
 &mmc0 {
 	vmmc-supply = <&reg_dcdce>;
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts
index 968960ebf1d18..085f3e4e8eaa8 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts
@@ -50,6 +50,11 @@ &ehci2 {
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&reg_dcdcc>;
+	status = "okay";
+};
+
 &ir {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h618-longan-module-3h.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h618-longan-module-3h.dtsi
index e92d150aaf1c1..3f416d129b727 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h618-longan-module-3h.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h618-longan-module-3h.dtsi
@@ -10,6 +10,11 @@ &cpu0 {
 	cpu-supply = <&reg_dcdc2>;
 };
 
+&gpu {
+	mali-supply = <&reg_dcdc1>;
+	status = "okay";
+};
+
 &mmc2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_pins>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero2w.dts b/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero2w.dts
index a0fe7a9afb77c..b340bbcb710de 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero2w.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero2w.dts
@@ -69,6 +69,11 @@ &ehci1 {
 
 /* USB 2 & 3 are on the FPC connector (or the exansion board) */
 
+&gpu {
+	mali-supply = <&reg_dcdc1>;
+	status = "okay";
+};
+
 &mmc0 {
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;	/* PF6 */
 	bus-width = <4>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts
index e1cd7572a14ce..c51d4d9120dee 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts
@@ -27,6 +27,10 @@ &ext_rgmii_phy {
 	motorcomm,clk-out-frequency-hz = <125000000>;
 };
 
+&gpu {
+	mali-supply = <&reg_dcdc1>;
+};
+
 &mmc0 {
 	/*
 	 * The schematic shows the card detect pin wired up to PF6, via an
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts b/arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts
index f828ca1ce51ef..efe0faa252f5e 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts
@@ -69,6 +69,11 @@ &ehci1 {
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&reg_dcdc1>;
+	status = "okay";
+};
+
 &ir {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h618-yuzukihd-chameleon.dts b/arch/arm64/boot/dts/allwinner/sun50i-h618-yuzukihd-chameleon.dts
index 747242becbb6e..d6768455404ee 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h618-yuzukihd-chameleon.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h618-yuzukihd-chameleon.dts
@@ -68,6 +68,11 @@ &ehci3 {
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&reg_dcdc1>;
+	status = "okay";
+};
+
 &mmc0 {
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;	/* PF6 */
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts b/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts
index a231abf1684ad..4a7f382e0e722 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts
@@ -191,6 +191,11 @@ &ehci0 {
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&reg_dcdc2>;
+	status = "okay";
+};
+
 &mmc0 {
 	vmmc-supply = <&reg_cldo3>;
 	disable-wp;
-- 
2.46.3


