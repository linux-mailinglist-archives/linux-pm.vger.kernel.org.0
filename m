Return-Path: <linux-pm+bounces-1956-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6DA827368
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jan 2024 16:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D94A28104B
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jan 2024 15:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289D053801;
	Mon,  8 Jan 2024 15:34:19 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from gauss.telenet-ops.be (gauss.telenet-ops.be [195.130.132.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F70537E3
	for <linux-pm@vger.kernel.org>; Mon,  8 Jan 2024 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
	by gauss.telenet-ops.be (Postfix) with ESMTPS id 4T7ylh6q7qz4wyrT
	for <linux-pm@vger.kernel.org>; Mon,  8 Jan 2024 16:34:08 +0100 (CET)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:d323:2fd4:4f64:e281])
	by xavier.telenet-ops.be with bizsmtp
	id YFZw2B00H0Qz0eJ01FZwDC; Mon, 08 Jan 2024 16:34:08 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rMrcp-00EtMO-9w;
	Mon, 08 Jan 2024 16:33:56 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rMrdU-00D7oW-FY;
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
Subject: [PATCH 10/15] soc: renesas: Introduce ARCH_RCAR_GEN4
Date: Mon,  8 Jan 2024 16:33:49 +0100
Message-Id: <4f4a2dbdb6ba51e151cbdc128da377083b0d850d.1704726960.git.geert+renesas@glider.be>
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

Currently, all Kconfig symbols for R-Car Gen4 SoCs select the
ARCH_RCAR_GEN3 SoC family symbol, which might confuse the casual reader.

Fix this by introducing a new SoC family symbol for R-Car Gen4 SoCs.
For now this just selects ARCH_RCAR_GEN3, to avoid duplication, and to
relax dependencies.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Once "[PATCH] i2c: rcar: Prepare for the advent of ARCH_RCAR_GEN4"[1]
has been applied, ARCH_RCAR_GEN4 can stop selecting ARCH_RCAR_GEN3.

I'm open for suggestions how to improve this.
Perhaps factor out common parts into ARCH_RCAR?

[1] https://lore.kernel.org/r/bf7b105f7d9728ae5cd9fa99d1cdd278d71e7df2.1704723713.git.geert+renesas@glider.be
---
 drivers/soc/renesas/Kconfig | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 0986672f63757663..784a2b50561d5a97 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -34,6 +34,10 @@ config ARCH_RCAR_GEN3
 	select SYS_SUPPORTS_SH_CMT
 	select SYS_SUPPORTS_SH_TMU
 
+config ARCH_RCAR_GEN4
+	bool
+	select ARCH_RCAR_GEN3
+
 config ARCH_RMOBILE
 	bool
 	select PM
@@ -240,7 +244,7 @@ config ARCH_R8A77961
 
 config ARCH_R8A779F0
 	bool "ARM64 Platform support for R-Car S4-8"
-	select ARCH_RCAR_GEN3
+	select ARCH_RCAR_GEN4
 	select SYSC_R8A779F0
 	help
 	  This enables support for the Renesas R-Car S4-8 SoC.
@@ -261,14 +265,14 @@ config ARCH_R8A77970
 
 config ARCH_R8A779A0
 	bool "ARM64 Platform support for R-Car V3U"
-	select ARCH_RCAR_GEN3
+	select ARCH_RCAR_GEN4
 	select SYSC_R8A779A0
 	help
 	  This enables support for the Renesas R-Car V3U SoC.
 
 config ARCH_R8A779G0
 	bool "ARM64 Platform support for R-Car V4H"
-	select ARCH_RCAR_GEN3
+	select ARCH_RCAR_GEN4
 	select SYSC_R8A779G0
 	help
 	  This enables support for the Renesas R-Car V4H SoC.
-- 
2.34.1


