Return-Path: <linux-pm+bounces-2742-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D012B83C6DA
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jan 2024 16:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 883EE294F63
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jan 2024 15:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24E6745FB;
	Thu, 25 Jan 2024 15:35:03 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D97973175
	for <linux-pm@vger.kernel.org>; Thu, 25 Jan 2024 15:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706196903; cv=none; b=qrf7vi+8BK9tl2V8PDjiL3w9R6hHozcTBlj3MffultSBeLjsWsDuAwQha5hBWuSuOdB547AELh9lA6J+hDDAV3N9P9sa4zvpGPn+5U1LYq1SnpXBMVwyxNNdUYv2pPHI2DJfjL/mdk024rHrfN0blMzx8l7Wy/WX9/9pYrxqDqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706196903; c=relaxed/simple;
	bh=PrGLmOdB4gT9pV6Vw4tAfL7M/IXCcsXdVseJO1BoioI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CfG/fE2QJkv23YaGR74Xi6y1VX/rIlLj2kH0JFfL2JV1QBpMn+hn5juj7RHj3tUwwmzd+kd9CPlkC+Vo7rEGmIe9ySsVjOw3PJFvDD/mSeWZ1jEjm937ILKvOQtVdFwP81Uj3WfSv23S7AaQQsaiAOmN6CYDjeJV2QtMxQRbefk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:bc9e:fcb8:8aa3:5dc0])
	by albert.telenet-ops.be with bizsmtp
	id f3am2B00M58agq2063am9X; Thu, 25 Jan 2024 16:34:56 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rT1jo-00GUwK-9n;
	Thu, 25 Jan 2024 16:34:46 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rT1kc-00Fs3K-9J;
	Thu, 25 Jan 2024 16:34:46 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Magnus Damm <magnus.damm@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Cong Dang <cong.dang.xn@renesas.com>,
	Duy Nguyen <duy.nguyen.rh@renesas.com>,
	Hai Pham <hai.pham.ud@renesas.com>,
	Linh Phung <linh.phung.jy@renesas.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 14/15] arm64: dts: renesas: Add Gray Hawk Single board support
Date: Thu, 25 Jan 2024 16:34:42 +0100
Message-Id: <b657402113267acd57aece0b4c681b707e704455.1706194617.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706194617.git.geert+renesas@glider.be>
References: <cover.1706194617.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add initial support for the Renesas Gray Hawk Single board, which is
based on the R-Car V4M (R8A779H0) SoC:
  - Memory,
  - Crystal oscillators,
  - Serial console.

Based on the White Hawk Single DTS, and on a patch for the Gray Hawk
board stack in the BSP by Hai Pham.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Add SoC name to top-level comment.
---
 arch/arm64/boot/dts/renesas/Makefile          |  2 +
 .../dts/renesas/r8a779h0-gray-hawk-single.dts | 52 +++++++++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a779h0-gray-hawk-single.dts

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index 1d7d69657a1f0559..4c5ac5f02829ff58 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -86,6 +86,8 @@ dtb-$(CONFIG_ARCH_R8A779G0) += r8a779g0-white-hawk-ard-audio-da7212.dtbo
 r8a779g0-white-hawk-ard-audio-da7212-dtbs := r8a779g0-white-hawk.dtb r8a779g0-white-hawk-ard-audio-da7212.dtbo
 dtb-$(CONFIG_ARCH_R8A779G0) += r8a779g0-white-hawk-ard-audio-da7212.dtb
 
+dtb-$(CONFIG_ARCH_R8A779H0) += r8a779h0-gray-hawk-single.dtb
+
 dtb-$(CONFIG_ARCH_R8A77951) += r8a779m1-salvator-xs.dtb
 r8a779m1-salvator-xs-panel-aa104xd12-dtbs := r8a779m1-salvator-xs.dtb salvator-panel-aa104xd12.dtbo
 dtb-$(CONFIG_ARCH_R8A77951) += r8a779m1-salvator-xs-panel-aa104xd12.dtb
diff --git a/arch/arm64/boot/dts/renesas/r8a779h0-gray-hawk-single.dts b/arch/arm64/boot/dts/renesas/r8a779h0-gray-hawk-single.dts
new file mode 100644
index 0000000000000000..1ed404712d823871
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a779h0-gray-hawk-single.dts
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the R-Car V4M Gray Hawk Single board
+ *
+ * Copyright (C) 2023 Renesas Electronics Corp.
+ * Copyright (C) 2024 Glider bv
+ */
+
+/dts-v1/;
+#include "r8a779h0.dtsi"
+
+/ {
+	model = "Renesas Gray Hawk Single board based on r8a779h0";
+	compatible = "renesas,gray-hawk-single", "renesas,r8a779h0";
+
+	aliases {
+		serial0 = &hscif0;
+	};
+
+	chosen {
+		bootargs = "ignore_loglevel";
+		stdout-path = "serial0:921600n8";
+	};
+
+	memory@48000000 {
+		device_type = "memory";
+		/* first 128MB is reserved for secure area. */
+		reg = <0x0 0x48000000 0x0 0x78000000>;
+	};
+
+	memory@480000000 {
+		device_type = "memory";
+		reg = <0x4 0x80000000 0x1 0x80000000>;
+	};
+};
+
+&extal_clk {
+	clock-frequency = <16666666>;
+};
+
+&extalr_clk {
+	clock-frequency = <32768>;
+};
+
+&hscif0 {
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&scif_clk {
+	clock-frequency = <24000000>;
+};
-- 
2.34.1


