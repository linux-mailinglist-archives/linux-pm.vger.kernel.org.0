Return-Path: <linux-pm+bounces-29137-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB92AE1658
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 10:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CE415A50F1
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 08:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4D124469A;
	Fri, 20 Jun 2025 08:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="ej1t5pzP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC4123F41F;
	Fri, 20 Jun 2025 08:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750408579; cv=none; b=CAx/abb5VtfNTCrhz5Cnru62uLK0fI6dNWusAvtCbY8hYdXDiR2T6X/kco9dh6xxIIL7HIAzpXfIH9KPi1IMuctsT/A8EEavzxIx60+RzrO+1AIxqc0m8hagHAUH81CnaiGSBdVPRrAPgU5ewOhHQ5+J8YcCHm7LvY6HOq3s+8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750408579; c=relaxed/simple;
	bh=ey8sFA0aJmZOnyRJ3qeMcegDo7hR1CHbUQHNOIwayLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ky7b9HvX7rOZ8bv7hFXJBkGIkclKWqb8MLE+/tQ+qdPqNP2OYYR0fpZaIGyKwTTm2BwYpv5h32T2biEOFMfeBMnEFychfobhAgir0EdIL0FCEoKU6Mhyx3AKtPfMnebgvYnzDaCfiU9/KrtPI9dp5JkmpNvu01xVENfQTk6l/jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=ej1t5pzP; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout2.routing.net (Postfix) with ESMTP id 022B9601EE;
	Fri, 20 Jun 2025 08:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1750408573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AMfSWKfWlsVG5kJFYY9nMKmKjjqRwbIiq6r4sbujFwM=;
	b=ej1t5pzPN1f4ntPWFsyeVVB0qECb9PujuXTATEjUFzp+ul4bJSEaY4POBGK2yllJ6cALG8
	UxvpUMEuThlhH1Whz+3WALpReFcBWguWn00fwHsaBg+OORYFgby0Qc/S2pYoLFe5kW3nMS
	NOu/fKE/RA7HHk9MhBZBq5xJIqcBOwY=
Received: from frank-u24.. (fttx-pool-157.180.225.81.bambit.de [157.180.225.81])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 92CA01226B1;
	Fri, 20 Jun 2025 08:36:12 +0000 (UTC)
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
Subject: [PATCH v5 06/13] arm64: dts: mediatek: mt7988: add basic ethernet-nodes
Date: Fri, 20 Jun 2025 10:35:37 +0200
Message-ID: <20250620083555.6886-7-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250620083555.6886-1-linux@fw-web.de>
References: <20250620083555.6886-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

Add basic ethernet related nodes.

Mac1+2 needs pcs (sgmii+usxgmii) to work correctly which will be linked
later when driver is merged.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
v5:
- add reserved irqs and change name to fe0..fe3
- change rx-ringX to pdmaX to be closer to documentation

v4:
- comment for fixed-link on gmac0
- update 2g5 phy node
  - unit-name dec instead of hex to match reg property
  - move compatible before reg
  - drop phy-mode
- add interrupts for RSS
- add interrupt-names and drop reserved irqs for ethernet
- some reordering
- eth-reg and clock whitespace-fix based on angelos review
---
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 128 +++++++++++++++++++++-
 1 file changed, 125 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index 560ec86dbec0..3ab77ad4736a 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -680,7 +680,28 @@ xphyu3port0: usb-phy@11e13000 {
 			};
 		};
 
-		clock-controller@11f40000 {
+		xfi_tphy0: phy@11f20000 {
+			compatible = "mediatek,mt7988-xfi-tphy";
+			reg = <0 0x11f20000 0 0x10000>;
+			clocks = <&xfi_pll CLK_XFIPLL_PLL_EN>,
+				 <&topckgen CLK_TOP_XFI_PHY_0_XTAL_SEL>;
+			clock-names = "xfipll", "topxtal";
+			resets = <&watchdog 14>;
+			mediatek,usxgmii-performance-errata;
+			#phy-cells = <0>;
+		};
+
+		xfi_tphy1: phy@11f30000 {
+			compatible = "mediatek,mt7988-xfi-tphy";
+			reg = <0 0x11f30000 0 0x10000>;
+			clocks = <&xfi_pll CLK_XFIPLL_PLL_EN>,
+				 <&topckgen CLK_TOP_XFI_PHY_1_XTAL_SEL>;
+			clock-names = "xfipll", "topxtal";
+			resets = <&watchdog 15>;
+			#phy-cells = <0>;
+		};
+
+		xfi_pll: clock-controller@11f40000 {
 			compatible = "mediatek,mt7988-xfi-pll";
 			reg = <0 0x11f40000 0 0x1000>;
 			resets = <&watchdog 16>;
@@ -714,19 +735,120 @@ phy_calibration_p3: calib@97c {
 			};
 		};
 
-		clock-controller@15000000 {
+		ethsys: clock-controller@15000000 {
 			compatible = "mediatek,mt7988-ethsys", "syscon";
 			reg = <0 0x15000000 0 0x1000>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 		};
 
-		clock-controller@15031000 {
+		ethwarp: clock-controller@15031000 {
 			compatible = "mediatek,mt7988-ethwarp";
 			reg = <0 0x15031000 0 0x1000>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 		};
+
+		eth: ethernet@15100000 {
+			compatible = "mediatek,mt7988-eth";
+			reg = <0 0x15100000 0 0x80000>, <0 0x15400000 0 0x200000>;
+			interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
+                                     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>,
+                                     <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
+                                     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "fe0", "fe1", "fe2", "fe3", "pdma0",
+					  "pdma1", "pdma2", "pdma3";
+			clocks = <&ethsys CLK_ETHDMA_CRYPT0_EN>,
+				 <&ethsys CLK_ETHDMA_FE_EN>,
+				 <&ethsys CLK_ETHDMA_GP2_EN>,
+				 <&ethsys CLK_ETHDMA_GP1_EN>,
+				 <&ethsys CLK_ETHDMA_GP3_EN>,
+				 <&ethwarp CLK_ETHWARP_WOCPU2_EN>,
+				 <&ethwarp CLK_ETHWARP_WOCPU1_EN>,
+				 <&ethwarp CLK_ETHWARP_WOCPU0_EN>,
+				 <&ethsys CLK_ETHDMA_ESW_EN>,
+				 <&topckgen CLK_TOP_ETH_GMII_SEL>,
+				 <&topckgen CLK_TOP_ETH_REFCK_50M_SEL>,
+				 <&topckgen CLK_TOP_ETH_SYS_200M_SEL>,
+				 <&topckgen CLK_TOP_ETH_SYS_SEL>,
+				 <&topckgen CLK_TOP_ETH_XGMII_SEL>,
+				 <&topckgen CLK_TOP_ETH_MII_SEL>,
+				 <&topckgen CLK_TOP_NETSYS_SEL>,
+				 <&topckgen CLK_TOP_NETSYS_500M_SEL>,
+				 <&topckgen CLK_TOP_NETSYS_PAO_2X_SEL>,
+				 <&topckgen CLK_TOP_NETSYS_SYNC_250M_SEL>,
+				 <&topckgen CLK_TOP_NETSYS_PPEFB_250M_SEL>,
+				 <&topckgen CLK_TOP_NETSYS_WARP_SEL>,
+				 <&ethsys CLK_ETHDMA_XGP1_EN>,
+				 <&ethsys CLK_ETHDMA_XGP2_EN>,
+				 <&ethsys CLK_ETHDMA_XGP3_EN>;
+			clock-names = "crypto", "fe", "gp2", "gp1", "gp3",
+				      "ethwarp_wocpu2", "ethwarp_wocpu1",
+				      "ethwarp_wocpu0", "esw", "top_eth_gmii_sel",
+				      "top_eth_refck_50m_sel", "top_eth_sys_200m_sel",
+				      "top_eth_sys_sel", "top_eth_xgmii_sel",
+				      "top_eth_mii_sel", "top_netsys_sel",
+				      "top_netsys_500m_sel", "top_netsys_pao_2x_sel",
+				      "top_netsys_sync_250m_sel",
+				      "top_netsys_ppefb_250m_sel",
+				      "top_netsys_warp_sel","xgp1", "xgp2", "xgp3";
+			assigned-clocks = <&topckgen CLK_TOP_NETSYS_2X_SEL>,
+					  <&topckgen CLK_TOP_NETSYS_GSW_SEL>,
+					  <&topckgen CLK_TOP_USXGMII_SBUS_0_SEL>,
+					  <&topckgen CLK_TOP_USXGMII_SBUS_1_SEL>,
+					  <&topckgen CLK_TOP_SGM_0_SEL>,
+					  <&topckgen CLK_TOP_SGM_1_SEL>;
+			assigned-clock-parents = <&apmixedsys CLK_APMIXED_NET2PLL>,
+						 <&topckgen CLK_TOP_NET1PLL_D4>,
+						 <&topckgen CLK_TOP_NET1PLL_D8_D4>,
+						 <&topckgen CLK_TOP_NET1PLL_D8_D4>,
+						 <&apmixedsys CLK_APMIXED_SGMPLL>,
+						 <&apmixedsys CLK_APMIXED_SGMPLL>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			mediatek,ethsys = <&ethsys>;
+			mediatek,infracfg = <&topmisc>;
+
+			gmac0: mac@0 {
+				compatible = "mediatek,eth-mac";
+				reg = <0>;
+				phy-mode = "internal";
+
+				/* Connected to internal switch */
+				fixed-link {
+					speed = <10000>;
+					full-duplex;
+					pause;
+				};
+			};
+
+			gmac1: mac@1 {
+				compatible = "mediatek,eth-mac";
+				reg = <1>;
+				status = "disabled";
+			};
+
+			gmac2: mac@2 {
+				compatible = "mediatek,eth-mac";
+				reg = <2>;
+				status = "disabled";
+			};
+
+			mdio_bus: mdio-bus {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				/* internal 2.5G PHY */
+				int_2p5g_phy: ethernet-phy@15 {
+					compatible = "ethernet-phy-ieee802.3-c45";
+					reg = <15>;
+				};
+			};
+		};
 	};
 
 	thermal-zones {
-- 
2.43.0


