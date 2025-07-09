Return-Path: <linux-pm+bounces-30467-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA534AFE751
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 13:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB4251C47E02
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 11:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B752D12F6;
	Wed,  9 Jul 2025 11:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="MzVzvAE1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AED2BE7D9;
	Wed,  9 Jul 2025 11:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752059533; cv=none; b=NhicIaz5frOMAHiyNBCUv1KUHgy7FeUZVhu4qdDUa10t5hEy30C/iJCLPsYCh1fY0QaWILNAx1DBkKhtldKGrapMtndmJyjeZTi+X7lZ7XT/nMBUfIP2JNVX8qAUnNLP8aAizjX3tAo9L+rRkIfQgT9tNwDlj5MaqmqE7pjIHfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752059533; c=relaxed/simple;
	bh=owery2Y9xho1bAvAYoxF0F6uDfB7KsKdTzyV/Nr07xM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Er5VodP2n+B/eeO9ABPQLyZ/E444TWfp+IxJ5BSlVKRK5OMtptiOe9rYHARJoqNxI9Q4uwaPw9P0XwwoZNH1lS550R7HRJFZvuSxDAXRXP+w/HBbu1ixjJWBHhJ/3dXcz9Im6qR3FxEy6IoRDZ6pCQAtp+N60MaI77rh/N7gAt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=MzVzvAE1; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout4.routing.net (Postfix) with ESMTP id 63661100935;
	Wed,  9 Jul 2025 11:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1752059521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mw75z6h4HeFha6AF7YI1R1VXg23z1dS7Y1C1o8vw7rQ=;
	b=MzVzvAE1gokUWwIKohEWFrqkPn4hiv/+0+mq6sOvaeCNU1/FTCDq2+GTySkfzPhl6ikOep
	ZGnFWnZqezfYLi7yFydOCJnMZWb9U2wsDEfnlrdP8rXQMx4xpbleJjClGOoMSCfIUYeGOI
	WiKHQTbWf/Q44EYQYxitbsg1xxXa0U8=
Received: from frank-u24.. (fttx-pool-217.61.157.99.bambit.de [217.61.157.99])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 0C9701226CC;
	Wed,  9 Jul 2025 11:12:01 +0000 (UTC)
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
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Johnson Wang <johnson.wang@mediatek.com>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Felix Fietkau <nbd@nbd.name>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v9 13/13] arm64: dts: mediatek: mt7988a-bpi-r4: configure switch phys and leds
Date: Wed,  9 Jul 2025 13:09:49 +0200
Message-ID: <20250709111147.11843-14-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709111147.11843-1-linux@fw-web.de>
References: <20250709111147.11843-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

Assign pinctrl to switch phys and leds.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
v4:
- reorder switch phy(-led) properties
v2:
- add labels and led-function and include after dropping from soc dtsi
---
 .../dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
index 4d709ee527df..7c9df606f60d 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
@@ -4,6 +4,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/regulator/richtek,rt5190a-regulator.h>
+#include <dt-bindings/leds/common.h>
 
 #include "mt7988a.dtsi"
 
@@ -152,6 +153,66 @@ &gmac2 {
 	sfp = <&sfp1>;
 };
 
+&gsw_phy0 {
+	pinctrl-0 = <&gbe0_led0_pins>;
+	pinctrl-names = "gbe-led";
+};
+
+&gsw_phy0_led0 {
+	function = LED_FUNCTION_WAN;
+	color = <LED_COLOR_ID_GREEN>;
+	status = "okay";
+};
+
+&gsw_port0 {
+	label = "wan";
+};
+
+&gsw_phy1 {
+	pinctrl-0 = <&gbe1_led0_pins>;
+	pinctrl-names = "gbe-led";
+};
+
+&gsw_phy1_led0 {
+	function = LED_FUNCTION_LAN;
+	color = <LED_COLOR_ID_GREEN>;
+	status = "okay";
+};
+
+&gsw_port1 {
+	label = "lan1";
+};
+
+&gsw_phy2 {
+	pinctrl-0 = <&gbe2_led0_pins>;
+	pinctrl-names = "gbe-led";
+};
+
+&gsw_phy2_led0 {
+	function = LED_FUNCTION_LAN;
+	color = <LED_COLOR_ID_GREEN>;
+	status = "okay";
+};
+
+&gsw_port2 {
+	label = "lan2";
+};
+
+&gsw_phy3 {
+	pinctrl-0 = <&gbe3_led0_pins>;
+	pinctrl-names = "gbe-led";
+};
+
+&gsw_phy3_led0 {
+	function = LED_FUNCTION_LAN;
+	color = <LED_COLOR_ID_GREEN>;
+	status = "okay";
+};
+
+&gsw_port3 {
+	label = "lan3";
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0_pins>;
-- 
2.43.0


