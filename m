Return-Path: <linux-pm+bounces-28269-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEFEAD1482
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 23:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BB737A501A
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 21:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367E1258CC9;
	Sun,  8 Jun 2025 21:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="PJ/cCjGl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout3.routing.net (mxout3.routing.net [134.0.28.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597AE257423;
	Sun,  8 Jun 2025 21:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749417317; cv=none; b=iypmreIp/7Bp0LGWEO3DitcmEnynVFrOynds947TjEo/S0qcVfi964t+53HNP/DsW3rxCO5FVGBXCMnQn6GSbbD698EO0vhHxtBxtaQfQUJHEWfTU4+8lpA3pTljBzrNPB4An37wDxR2vTbe0kRjH00wlaXaBZ5xUuVkW84rwjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749417317; c=relaxed/simple;
	bh=OYcr8qXnY4Akdf0Ph0cILSwEOSItA0bwfuk+h/XIGBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NM95/l+77XO5qogpr3Tu9Nh/6us+tcqVdr2ZQUEgyLYJ+YZqi/BE3sFxzTcmpHapJAkTF35Uo6lhEBgaP+ptHMTEFMZmf/CMZ/Jynk6eOhGUfEzrdCRsVSQ5gDbzNA9Q4PEDgtIjzayS+LQHFHPJp1lW3XOLpjr+eOE3wWWh4vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=PJ/cCjGl; arc=none smtp.client-ip=134.0.28.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout3.routing.net (Postfix) with ESMTP id D991C601B5;
	Sun,  8 Jun 2025 21:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1749417303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O+IhUztd6jkEKnUjCh07ODP20v3CuuoWXyT/W7fl/Ak=;
	b=PJ/cCjGlA5gOqD36tt1cxEiFxlPhUqKH9uExaV39mb809oBXpBoz3sHl/QoaJas65CtO3j
	RHo2ybDqOcpczH0IKpDRuh74yAcjYXORvxXR5UQsZjEj28NDoyV/ItcUWKYc+4vZHqJdUx
	UW2c4jjOc7Am0JGbqG3TKqBuJCBgQpg=
Received: from frank-u24.. (fttx-pool-80.245.77.166.bambit.de [80.245.77.166])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 7F4171226D6;
	Sun,  8 Jun 2025 21:15:03 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Georgi Djakov <djakov@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	Jia-Wei Chang <jia-wei.chang@mediatek.com>,
	Johnson Wang <johnson.wang@mediatek.com>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3 12/13] arm64: dts: mediatek: mt7988a-bpi-r4: add sfp cages and link to gmac
Date: Sun,  8 Jun 2025 23:14:45 +0200
Message-ID: <20250608211452.72920-13-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250608211452.72920-1-linux@fw-web.de>
References: <20250608211452.72920-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

Add SFP cages to Bananapi-R4 board. The 2.5g phy variant only contains the
wan-SFP, so add this to common dtsi and the lan-sfp only to the dual-SFP
variant.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
v3:
- enable mac with 2.5g phy on r4 phy variant because driver is now mainline
---
 .../mediatek/mt7988a-bananapi-bpi-r4-2g5.dts   | 12 ++++++++++++
 .../dts/mediatek/mt7988a-bananapi-bpi-r4.dts   | 18 ++++++++++++++++++
 .../dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi  | 18 ++++++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-2g5.dts b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-2g5.dts
index 53de9c113f60..e63e17ae35a0 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-2g5.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-2g5.dts
@@ -9,3 +9,15 @@ / {
 	model = "Banana Pi BPI-R4 (1x SFP+, 1x 2.5GbE)";
 	chassis-type = "embedded";
 };
+
+&gmac1 {
+	phy-mode = "internal";
+	phy-connection-type = "internal";
+	phy = <&int_2p5g_phy>;
+	status = "okay";
+};
+
+&int_2p5g_phy {
+	pinctrl-names = "i2p5gbe-led";
+	pinctrl-0 = <&i2p5gbe_led0_pins>;
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
index 36bd1ef2efab..3136dc4ba4cc 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
@@ -8,6 +8,24 @@ / {
 	compatible = "bananapi,bpi-r4", "mediatek,mt7988a";
 	model = "Banana Pi BPI-R4 (2x SFP+)";
 	chassis-type = "embedded";
+
+	/* SFP2 cage (LAN) */
+	sfp2: sfp2 {
+		compatible = "sff,sfp";
+		i2c-bus = <&i2c_sfp2>;
+		los-gpios = <&pio 2 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpios = <&pio 83 GPIO_ACTIVE_LOW>;
+		tx-disable-gpios = <&pio 0 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpios = <&pio 1 GPIO_ACTIVE_HIGH>;
+		rate-select0-gpios = <&pio 3 GPIO_ACTIVE_LOW>;
+		maximum-power-milliwatt = <3000>;
+	};
+};
+
+&gmac1 {
+	sfp = <&sfp2>;
+	managed = "in-band-status";
+	phy-mode = "usxgmii";
 };
 
 &pca9545 {
diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
index 20073eb4d1bd..d8b9cd794ee3 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
@@ -63,6 +63,18 @@ reg_3p3v: regulator-3p3v {
 		regulator-boot-on;
 		regulator-always-on;
 	};
+
+	/* SFP1 cage (WAN) */
+	sfp1: sfp1 {
+		compatible = "sff,sfp";
+		i2c-bus = <&i2c_sfp1>;
+		los-gpios = <&pio 54 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpios = <&pio 82 GPIO_ACTIVE_LOW>;
+		tx-disable-gpios = <&pio 70 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpios = <&pio 69 GPIO_ACTIVE_HIGH>;
+		rate-select0-gpios = <&pio 21 GPIO_ACTIVE_LOW>;
+		maximum-power-milliwatt = <3000>;
+	};
 };
 
 &cci {
@@ -133,6 +145,12 @@ map-cpu-active-low {
 	};
 };
 
+&gmac2 {
+	sfp = <&sfp1>;
+	managed = "in-band-status";
+	phy-mode = "usxgmii";
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0_pins>;
-- 
2.43.0


