Return-Path: <linux-pm+bounces-16411-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4159AED4E
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 19:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E43171F24A52
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 17:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7122003A1;
	Thu, 24 Oct 2024 17:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b="M/0FCt16"
X-Original-To: linux-pm@vger.kernel.org
Received: from thales.epochal.quest (thales.epochal.quest [51.222.15.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4AA1FAEF9;
	Thu, 24 Oct 2024 17:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.222.15.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729789794; cv=none; b=ZIDVZR22jhc2H7KCUJqY5HgBxdt9W4G8IaaYV+vuVgewdYSkFLQwNOt6+48xGhvOm8iY1oaSfeN9epsZnLIW/RmBdi5P84M6jYgFZkrmdpJ71rSvjQ6AKyEKHWPji+1JvHiICISn6r1amYf39MToCDzVD5/Y3ViM5shr8vS9/UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729789794; c=relaxed/simple;
	bh=bHPvxwNam7d5e7DDcVYjGZMshprhb5/GH93Zen2fk8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXkez1zVZEFw+vV/DUBn8PO1A7tU4mGryZ1OGXYqNmpnqAYzuuQBZyjcGR3MPTCoLz7jGTQhGxy13DZAvQ9wM48NX/mHsxS0L6wXnJ3kw4G7szOAG8sW5FST9OJFGpc2Zh3SAwSZjiB1zBrV43d52S97lJUuSHPu/zXERjLIVpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest; spf=pass smtp.mailfrom=epochal.quest; dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b=M/0FCt16; arc=none smtp.client-ip=51.222.15.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epochal.quest
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epochal.quest;
	s=default; t=1729789787;
	bh=bHPvxwNam7d5e7DDcVYjGZMshprhb5/GH93Zen2fk8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M/0FCt16IYLO4RCFOninr0W8AfJM7xH0LRnX26BHyHD6Z9K2LjBPjpu7rf9g+aw60
	 tO20zweubmEKQAFJRexz9386imzHVMLd7xzIKkdXBtiSpJcBAvKvsHL/YzCiKIeLv/
	 zpqy5p7VHci7nUgddWFYQ6jVDZSXhLAr0HZATdKVw6YZh34CeIf5/EzSsG2teDY+KV
	 1TwY/LEwTw9nQEmvEOPbJWnbo6e2fPREqRFS7fTRjgcYQSb33m3BOSdXi5tTUlf+ig
	 3dfQ+cCmqAbEaM1ZE3ZBHRx5MH/vOdETDQWErUy+f9wQ5yJTh2L6PZdtLdMHqYsT7U
	 L0OOu7T6TI0Og==
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
Subject: [PATCH 09/13] arm64: allwinner: a100: Add MMC related nodes
Date: Thu, 24 Oct 2024 14:05:27 -0300
Message-ID: <20241024170540.2721307-10-masterr3c0rd@epochal.quest>
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

The A100 has 3 MMC controllers, one of them being especially targeted to
eMMC. Let's add nodes on dts.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
---
 .../arm64/boot/dts/allwinner/sun50i-a100.dtsi | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
index 0aee1b578661..6dca766ea222 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
@@ -169,12 +169,83 @@ pio: pinctrl@300b000 {
 			interrupt-controller;
 			#interrupt-cells = <3>;
 
+			mmc0_pins: mmc0-pins {
+				pins = "PF0", "PF1", "PF2", "PF3",
+				       "PF4", "PF5";
+				function = "mmc0";
+				drive-strength = <30>;
+				bias-pull-up;
+			};
+
+			/omit-if-no-ref/
+			mmc1_pins: mmc1-pins {
+				pins = "PG0", "PG1", "PG2", "PG3",
+				       "PG4", "PG5";
+				function = "mmc1";
+				drive-strength = <30>;
+				bias-pull-up;
+			};
+
+			mmc2_pins: mmc2-pins {
+				pins = "PC0", "PC1", "PC5", "PC6",
+				       "PC8", "PC9", "PC10", "PC11",
+				       "PC13", "PC14", "PC15", "PC16";
+				function = "mmc2";
+				drive-strength = <30>;
+				bias-pull-up;
+			};
+
 			uart0_pb_pins: uart0-pb-pins {
 				pins = "PB9", "PB10";
 				function = "uart0";
 			};
 		};
 
+		mmc0: mmc@4020000 {
+			compatible = "allwinner,sun50i-a100-mmc";
+			reg = <0x04020000 0x1000>;
+			clocks = <&ccu CLK_BUS_MMC0>, <&ccu CLK_MMC0>;
+			clock-names = "ahb", "mmc";
+			resets = <&ccu RST_BUS_MMC0>;
+			reset-names = "ahb";
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc0_pins>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mmc1: mmc@4021000 {
+			compatible = "allwinner,sun50i-a100-mmc";
+			reg = <0x04021000 0x1000>;
+			clocks = <&ccu CLK_BUS_MMC1>, <&ccu CLK_MMC1>;
+			clock-names = "ahb", "mmc";
+			resets = <&ccu RST_BUS_MMC1>;
+			reset-names = "ahb";
+			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc1_pins>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mmc2: mmc@4022000 {
+			compatible = "allwinner,sun50i-a100-emmc";
+			reg = <0x04022000 0x1000>;
+			clocks = <&ccu CLK_BUS_MMC2>, <&ccu CLK_MMC2>;
+			clock-names = "ahb", "mmc";
+			resets = <&ccu RST_BUS_MMC2>;
+			reset-names = "ahb";
+			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc2_pins>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		uart0: serial@5000000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x05000000 0x400>;
-- 
2.47.0


