Return-Path: <linux-pm+bounces-30209-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BF2AFA552
	for <lists+linux-pm@lfdr.de>; Sun,  6 Jul 2025 15:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 828971893794
	for <lists+linux-pm@lfdr.de>; Sun,  6 Jul 2025 13:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64360221FBB;
	Sun,  6 Jul 2025 13:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="UuHdaG3X"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout3.routing.net (mxout3.routing.net [134.0.28.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D75721884B;
	Sun,  6 Jul 2025 13:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751808162; cv=none; b=lY4BGDpAKdZQGIxb+BWmqpFGQgX/hxpENL7suhh8ccuzK80XiJPWAm2S9Dq+NUgxLZ5tI7b0xQ13f8lxyoY/MDqaxNLfmVWj5FVZL1NBFyrkBibDgqs7PgNVZD+2InVb5iX2O7AJqrbIq0OAcc/l8EAGRROFvLu1HzgXSpfUD1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751808162; c=relaxed/simple;
	bh=oEHCeCyYmhRvcoDsSzTQBlneOLnSQNdeNvfMRFj69TE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d2DyFUjWxnBogCvLijxpbyFiMEaW5sRl3qDXFptWWAJWQP41N+rYtsvBGILt0qLaigTdLAIRhtFqfZ1eK9flQwboKU/JCDAKrE3sMZFWqn3kJDiyZhXfQT08O5dSj6hsda/pnIrPN6bNcUxwK5so06dQILDSTU3AH1aD2NcidgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=UuHdaG3X; arc=none smtp.client-ip=134.0.28.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout3.routing.net (Postfix) with ESMTP id A2DCF604E3;
	Sun,  6 Jul 2025 13:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1751808151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zCArQQjnZOoBXdfm7YKc01KniAiMbD7wl2wyNkiAMyg=;
	b=UuHdaG3X42vNp1uXG9exuoFCErwp0oP4PjnZ0Rpzvkc+54i3SMSeGCtqy0q01qRHbV6edW
	XVSlzjcR0NMLpjl2WZBh5UwSLy2SeQoeeEFw4mYd6ZjWVcaXufdiP3NAT/MoOSN5N5BWXg
	Rs38CHS3cKqBUiYXopuBdaxxoglrMyw=
Received: from frank-u24.. (fttx-pool-194.15.86.111.bambit.de [194.15.86.111])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 4ADC21226A5;
	Sun,  6 Jul 2025 13:22:31 +0000 (UTC)
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
Subject: [PATCH v8 12/16] arm64: dts: mediatek: mt7988a-bpi-r4: drop unused pins
Date: Sun,  6 Jul 2025 15:22:07 +0200
Message-ID: <20250706132213.20412-13-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250706132213.20412-1-linux@fw-web.de>
References: <20250706132213.20412-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

Pins were moved from SoC dtsi to Board level dtsi without cleaning up
to needed ones. Drop the unused pins now.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi | 89 -------------------
 1 file changed, 89 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
index afa9e3b2b16a..30affedf84d4 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
@@ -223,18 +223,6 @@ &pcie3 {
 };
 
 &pio {
-	mdio0_pins: mdio0-pins {
-		mux {
-			function = "eth";
-			groups = "mdc_mdio0";
-		};
-
-		conf {
-			pins = "SMI_0_MDC", "SMI_0_MDIO";
-			drive-strength = <8>;
-		};
-	};
-
 	i2c0_pins: i2c0-g0-pins {
 		mux {
 			function = "i2c";
@@ -249,20 +237,6 @@ mux {
 		};
 	};
 
-	i2c1_sfp_pins: i2c1-sfp-g0-pins {
-		mux {
-			function = "i2c";
-			groups = "i2c1_sfp";
-		};
-	};
-
-	i2c2_0_pins: i2c2-g0-pins {
-		mux {
-			function = "i2c";
-			groups = "i2c2_0";
-		};
-	};
-
 	i2c2_1_pins: i2c2-g1-pins {
 		mux {
 			function = "i2c";
@@ -298,34 +272,6 @@ mux {
 		};
 	};
 
-	gbe0_led1_pins: gbe0-led1-pins {
-		mux {
-			function = "led";
-			groups = "gbe0_led1";
-		};
-	};
-
-	gbe1_led1_pins: gbe1-led1-pins {
-		mux {
-			function = "led";
-			groups = "gbe1_led1";
-		};
-	};
-
-	gbe2_led1_pins: gbe2-led1-pins {
-		mux {
-			function = "led";
-			groups = "gbe2_led1";
-		};
-	};
-
-	gbe3_led1_pins: gbe3-led1-pins {
-		mux {
-			function = "led";
-			groups = "gbe3_led1";
-		};
-	};
-
 	i2p5gbe_led0_pins: 2p5gbe-led0-pins {
 		mux {
 			function = "led";
@@ -333,13 +279,6 @@ mux {
 		};
 	};
 
-	i2p5gbe_led1_pins: 2p5gbe-led1-pins {
-		mux {
-			function = "led";
-			groups = "2p5gbe_led1";
-		};
-	};
-
 	mmc0_pins_emmc_45: mmc0-emmc-45-pins {
 		mux {
 			function = "flash";
@@ -361,40 +300,12 @@ mux {
 		};
 	};
 
-	snfi_pins: snfi-pins {
-		mux {
-			function = "flash";
-			groups = "snfi";
-		};
-	};
-
-	spi0_pins: spi0-pins {
-		mux {
-			function = "spi";
-			groups = "spi0";
-		};
-	};
-
 	spi0_flash_pins: spi0-flash-pins {
 		mux {
 			function = "spi";
 			groups = "spi0", "spi0_wp_hold";
 		};
 	};
-
-	spi2_pins: spi2-pins {
-		mux {
-			function = "spi";
-			groups = "spi2";
-		};
-	};
-
-	spi2_flash_pins: spi2-flash-pins {
-		mux {
-			function = "spi";
-			groups = "spi2", "spi2_wp_hold";
-		};
-	};
 };
 
 &pwm {
-- 
2.43.0


