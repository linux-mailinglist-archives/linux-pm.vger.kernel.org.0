Return-Path: <linux-pm+bounces-29142-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B7DAE166A
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 10:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC0665A5D25
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 08:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255A5251791;
	Fri, 20 Jun 2025 08:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="dg6AvJo0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout1.routing.net (mxout1.routing.net [134.0.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9D12367C0;
	Fri, 20 Jun 2025 08:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750408585; cv=none; b=sVDnK/mGO1t/7Tyiz11QG5VbJv4hGf7Ze9p8NrwVx14fTDBZrVYJv2Vxg/AIPq+bDUX3l03YUKOYXUk26UZVBMpwbajCd58z4DTRCX8GYirzEj0MW8s39XL/5ROsXZ6pnqnJbsa57lXHYzBT1n3gWtuWEbJGdDl+tCZRtuF9SrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750408585; c=relaxed/simple;
	bh=8XYNjr8XCUKkZ2P5FpY7wgrxJpx4ZLcb9vr9wNboiDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJDdfzA9byUAuxg5F61Wkfr71Ib5EpzMdF67GrYipuO9HcI8Kqr8NWYwJnvSATATGUGVJW+ZeIVgUvcdNfg+56pMEUkFEHSvOJSf9vOWLJMgbbPT1sMCFr9SzwNq2zOM7WleZZR9wJeRLN2GDdd0kqUJ5sJAVL/6PsUy/2/qzGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=dg6AvJo0; arc=none smtp.client-ip=134.0.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout1.routing.net (Postfix) with ESMTP id 6414041AF5;
	Fri, 20 Jun 2025 08:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1750408573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kC5v9ze9x9toLS8TmWv43Wu3P6QZKGYMdRPuLYWSdAk=;
	b=dg6AvJo0pW28wyAghtGqUqa//Y74brD30ySyrfBhRu/tv28cy3buh/xvNzFfPzw++Kogz4
	IHYIpDrqDPEG3tOiRp9CnkkAfazt5uJwLEmNWDk3w3IX0Sgwf/EneRDfdFZecvaLuGpP0o
	tMMZ9KgH3jZuvq+u6y3l69wKXVMvg0Y=
Received: from frank-u24.. (fttx-pool-157.180.225.81.bambit.de [157.180.225.81])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 06C8B1226F1;
	Fri, 20 Jun 2025 08:36:13 +0000 (UTC)
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
Subject: [PATCH v5 07/13] arm64: dts: mediatek: mt7988: add switch node
Date: Fri, 20 Jun 2025 10:35:38 +0200
Message-ID: <20250620083555.6886-8-linux@fw-web.de>
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

Add mt7988 builtin mt753x switch nodes.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
v4:
- drop phy-mode for gsw-phy
- reorder phy-mode after phy-handle
- drop interrupt parent from switch

v2:
- drop labels and led-function too (have to be in board)
---
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 148 ++++++++++++++++++++++
 1 file changed, 148 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index 3ab77ad4736a..33a80199ffbe 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -742,6 +742,154 @@ ethsys: clock-controller@15000000 {
 			#reset-cells = <1>;
 		};
 
+		switch: switch@15020000 {
+			compatible = "mediatek,mt7988-switch";
+			reg = <0 0x15020000 0 0x8000>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupts = <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&ethwarp MT7988_ETHWARP_RST_SWITCH>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				gsw_port0: port@0 {
+					reg = <0>;
+					phy-handle = <&gsw_phy0>;
+					phy-mode = "internal";
+				};
+
+				gsw_port1: port@1 {
+					reg = <1>;
+					phy-handle = <&gsw_phy1>;
+					phy-mode = "internal";
+				};
+
+				gsw_port2: port@2 {
+					reg = <2>;
+					phy-handle = <&gsw_phy2>;
+					phy-mode = "internal";
+				};
+
+				gsw_port3: port@3 {
+					reg = <3>;
+					phy-handle = <&gsw_phy3>;
+					phy-mode = "internal";
+				};
+
+				port@6 {
+					reg = <6>;
+					ethernet = <&gmac0>;
+					phy-mode = "internal";
+
+					fixed-link {
+						speed = <10000>;
+						full-duplex;
+						pause;
+					};
+				};
+			};
+
+			mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				mediatek,pio = <&pio>;
+
+				gsw_phy0: ethernet-phy@0 {
+					compatible = "ethernet-phy-ieee802.3-c22";
+					reg = <0>;
+					interrupts = <0>;
+					nvmem-cells = <&phy_calibration_p0>;
+					nvmem-cell-names = "phy-cal-data";
+
+					leds {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						gsw_phy0_led0: led@0 {
+							reg = <0>;
+							status = "disabled";
+						};
+
+						gsw_phy0_led1: led@1 {
+							reg = <1>;
+							status = "disabled";
+						};
+					};
+				};
+
+				gsw_phy1: ethernet-phy@1 {
+					compatible = "ethernet-phy-ieee802.3-c22";
+					reg = <1>;
+					interrupts = <1>;
+					nvmem-cells = <&phy_calibration_p1>;
+					nvmem-cell-names = "phy-cal-data";
+
+					leds {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						gsw_phy1_led0: led@0 {
+							reg = <0>;
+							status = "disabled";
+						};
+
+						gsw_phy1_led1: led@1 {
+							reg = <1>;
+							status = "disabled";
+						};
+					};
+				};
+
+				gsw_phy2: ethernet-phy@2 {
+					compatible = "ethernet-phy-ieee802.3-c22";
+					reg = <2>;
+					interrupts = <2>;
+					nvmem-cells = <&phy_calibration_p2>;
+					nvmem-cell-names = "phy-cal-data";
+
+					leds {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						gsw_phy2_led0: led@0 {
+							reg = <0>;
+							status = "disabled";
+						};
+
+						gsw_phy2_led1: led@1 {
+							reg = <1>;
+							status = "disabled";
+						};
+					};
+				};
+
+				gsw_phy3: ethernet-phy@3 {
+					compatible = "ethernet-phy-ieee802.3-c22";
+					reg = <3>;
+					interrupts = <3>;
+					nvmem-cells = <&phy_calibration_p3>;
+					nvmem-cell-names = "phy-cal-data";
+
+					leds {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						gsw_phy3_led0: led@0 {
+							reg = <0>;
+							status = "disabled";
+						};
+
+						gsw_phy3_led1: led@1 {
+							reg = <1>;
+							status = "disabled";
+						};
+					};
+				};
+			};
+		};
+
 		ethwarp: clock-controller@15031000 {
 			compatible = "mediatek,mt7988-ethwarp";
 			reg = <0 0x15031000 0 0x1000>;
-- 
2.43.0


