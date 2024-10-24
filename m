Return-Path: <linux-pm+bounces-16414-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D88F9AEDAA
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 19:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67D461C2308B
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 17:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476671FBF78;
	Thu, 24 Oct 2024 17:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b="hcApd2xl"
X-Original-To: linux-pm@vger.kernel.org
Received: from thales.epochal.quest (thales.epochal.quest [51.222.15.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6EA1FAF1E;
	Thu, 24 Oct 2024 17:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.222.15.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729790356; cv=none; b=JGOcU2H+y6F5tVyDgejkE4QhqtE6IXM7UQZDnf1w8JQArAFDbWoTnj/objKvMIwuvafQ/NoT3OVzdTeVtCLWXwC1Wzr/l7PjVWYKdEFQMGR0eoDbCbta/97hPp99UFpAViX0IRopz0hp4/BvB4oS2kXvlAdy275ocCULvpMM2s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729790356; c=relaxed/simple;
	bh=c6mAFMfMnzUCM/bRTvKysE72zxNJKIHReq/xcIwXjco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C6Jiul/wnzH+xrrVqIz1Nc/L7JclAvl5nvCdHk18GBVD+0XVplyrW//xHkrvmr2f3qT19cAGFHjpXJaxLLtmD9RxmIyC/J3xiNASj19LvNBD/Eby5GMCvgs+iv3yCe1ScASPMuZ4vJdKmnYcKF0gNP1bQaJ6NQqU4f5VtczhK4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest; spf=pass smtp.mailfrom=epochal.quest; dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b=hcApd2xl; arc=none smtp.client-ip=51.222.15.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epochal.quest
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epochal.quest;
	s=default; t=1729789781;
	bh=c6mAFMfMnzUCM/bRTvKysE72zxNJKIHReq/xcIwXjco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hcApd2xlBpYyS0cXu9eSE1lhCyAo9OS/FOBF5M4uqtwdGFPa5eYsTWwyGOxjEap4O
	 BKUlObhTk7+teSIm2Kjim68paDZKTyAywxNx7ZQcm4ClXFhrarEhaKyS22WRtAoO3n
	 U2pxyPNIJsSuhVNjeG5w0wkPXiK9G3nli1J2mDCQxNG91GA6fllxHOWcijXo2wzDxG
	 Yv38dsP6WsEkhFHu+jRs+4PdeadGAHntpUbLN09gvyYrdlKNMlhJd78HVwVog1cAWM
	 s1otUpErvBIyK83IaZykiIHKkIKQra0NQo6IgaOOvsTW+rp2BGuYrg+Yz5s7rAgtEF
	 Gmpu/d9ayT9LQ==
X-Virus-Scanned: by epochal.quest
From: Cody Eksal <masterr3c0rd@epochal.quest>
To: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-usb@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: Cody Eksal <masterr3c0rd@epochal.quest>,
	Andre Przywara <andre.przywara@arm.com>,
	Parthiban <parthiban@linumiz.com>,
	Yangtao Li <frank@allwinnertech.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Vinod Koul <vkoul@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Thierry Reding <treding@nvidia.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yangtao Li <tiny.windzz@gmail.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 02/13] arm64: dts: allwinner: a100: add watchdog node
Date: Thu, 24 Oct 2024 14:05:20 -0300
Message-ID: <20241024170540.2721307-3-masterr3c0rd@epochal.quest>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024170540.2721307-1-masterr3c0rd@epochal.quest>
References: <20241024170540.2721307-1-masterr3c0rd@epochal.quest>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yangtao Li <frank@allwinnertech.com>

Declare A100's watchdog in the device-tree.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
---
 arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
index 1eca7c220ede..adb11b26045f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
@@ -144,6 +144,14 @@ ths_calibration: calib@14 {
 			};
 		};
 
+		watchdog@30090a0 {
+			compatible = "allwinner,sun50i-a100-wdt",
+				     "allwinner,sun6i-a31-wdt";
+			reg = <0x030090a0 0x20>;
+			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&dcxo24M>;
+		};
+
 		pio: pinctrl@300b000 {
 			compatible = "allwinner,sun50i-a100-pinctrl";
 			reg = <0x0300b000 0x400>;
-- 
2.47.0


