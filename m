Return-Path: <linux-pm+bounces-1949-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F74827354
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jan 2024 16:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C8691F20F34
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jan 2024 15:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56000524DE;
	Mon,  8 Jan 2024 15:34:14 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from cantor.telenet-ops.be (cantor.telenet-ops.be [195.130.132.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5FA51037
	for <linux-pm@vger.kernel.org>; Mon,  8 Jan 2024 15:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
	by cantor.telenet-ops.be (Postfix) with ESMTPS id 4T7ylg45B1z4wyrp
	for <linux-pm@vger.kernel.org>; Mon,  8 Jan 2024 16:34:07 +0100 (CET)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:d323:2fd4:4f64:e281])
	by andre.telenet-ops.be with bizsmtp
	id YFZw2B00A0Qz0eJ01FZwK7; Mon, 08 Jan 2024 16:34:07 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rMrcp-00EtMR-B7;
	Mon, 08 Jan 2024 16:33:56 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rMrdU-00D7ob-GX;
	Mon, 08 Jan 2024 16:33:56 +0100
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
Subject: [PATCH 11/15] soc: renesas: Identify R-Car V4M
Date: Mon,  8 Jan 2024 16:33:50 +0100
Message-Id: <d92add6e71daf88d4f6e689f5097cf1f1addbec8.1704726960.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1704726960.git.geert+renesas@glider.be>
References: <cover.1704726960.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Duy Nguyen <duy.nguyen.rh@renesas.com>

Add support for identifying the R-Car V4M (R8A779H0) SoC.

Signed-off-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Changes compared to the BSP:
  - Use lower-case hex for literals in C source code.
---
 drivers/soc/renesas/Kconfig       | 7 +++++++
 drivers/soc/renesas/renesas-soc.c | 8 ++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 784a2b50561d5a97..5deca747fb771744 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -277,6 +277,13 @@ config ARCH_R8A779G0
 	help
 	  This enables support for the Renesas R-Car V4H SoC.
 
+config ARCH_R8A779H0
+	bool "ARM64 Platform support for R-Car V4M"
+	select ARCH_RCAR_GEN4
+	select SYSC_R8A779H0
+	help
+	  This enables support for the Renesas R-Car V4M SoC.
+
 config ARCH_R8A774C0
 	bool "ARM64 Platform support for RZ/G2E"
 	select ARCH_RCAR_GEN3
diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index 27eae1a354ab2329..8f9b8d3736dcdb47 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -270,6 +270,11 @@ static const struct renesas_soc soc_rcar_v4h __initconst __maybe_unused = {
 	.id	= 0x5c,
 };
 
+static const struct renesas_soc soc_rcar_v4m __initconst __maybe_unused = {
+	.family = &fam_rcar_gen4,
+	.id     = 0x5d,
+};
+
 static const struct renesas_soc soc_shmobile_ag5 __initconst __maybe_unused = {
 	.family	= &fam_shmobile,
 	.id	= 0x37,
@@ -380,6 +385,9 @@ static const struct of_device_id renesas_socs[] __initconst __maybe_unused = {
 #ifdef CONFIG_ARCH_R8A779G0
 	{ .compatible = "renesas,r8a779g0",	.data = &soc_rcar_v4h },
 #endif
+#ifdef CONFIG_ARCH_R8A779H0
+	{ .compatible = "renesas,r8a779h0",	.data = &soc_rcar_v4m },
+#endif
 #ifdef CONFIG_ARCH_R9A07G043
 #ifdef CONFIG_RISCV
 	{ .compatible = "renesas,r9a07g043",	.data = &soc_rz_five },
-- 
2.34.1


