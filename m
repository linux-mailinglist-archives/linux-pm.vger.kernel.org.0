Return-Path: <linux-pm+bounces-2753-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7D783C6FA
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jan 2024 16:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 554D7295C3F
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jan 2024 15:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE597690F;
	Thu, 25 Jan 2024 15:35:09 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BDC74E3D
	for <linux-pm@vger.kernel.org>; Thu, 25 Jan 2024 15:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706196909; cv=none; b=GzPaGdLGMq5/Zn61zh0IjJsAz9i30UaSa9CIFp+pFe9T5pexGfHhj84DHXWWNUSNsqOKrcmNzsxMHcGvHqpIaW6ainvn7vp9TSwbXmR++j0DJxqyQpKC73uhBy7Rn3LGQM//A3QFv7eAWH3KuBneSgo3tWiuFXpl4NUwxn5NFGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706196909; c=relaxed/simple;
	bh=sWacTy8fqdpm+liAekvyPvdRGwz5kCdbPHjdVjIHXmg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J41t8BDaT89/erNb/LVEh67WeKVLa42s0qZuTBgnB+pthM8AkX+lbNZkYfSrIyU7STCV99RtaY3iayyaQu0SZ0QfizZUs+ijPOK27E/PddCTObE5SZItOqEyOXrrs5OgOO6bYKtHd/trCJQJHDfnveCSljlEIEUxQak44ckoT00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:bc9e:fcb8:8aa3:5dc0])
	by laurent.telenet-ops.be with bizsmtp
	id f3am2B00858agq2013amNd; Thu, 25 Jan 2024 16:34:57 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rT1jo-00GUw9-7Y;
	Thu, 25 Jan 2024 16:34:46 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rT1kc-00Fs36-6y;
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
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2 11/15] soc: renesas: Identify R-Car V4M
Date: Thu, 25 Jan 2024 16:34:39 +0100
Message-Id: <31e06d055aec1bc70c3e9a02f9268bcfc72b2204.1706194617.git.geert+renesas@glider.be>
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

From: Duy Nguyen <duy.nguyen.rh@renesas.com>

Add support for identifying the R-Car V4M (R8A779H0) SoC.

Signed-off-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v2:
  - Add Reviewed-by.

Changes compared to the BSP:
  - Use lower-case hex for literals in C source code.
---
 drivers/soc/renesas/Kconfig       | 7 +++++++
 drivers/soc/renesas/renesas-soc.c | 8 ++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 2367385d84b5a17d..1b8a89ad4fd7e7a3 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -282,6 +282,13 @@ config ARCH_R8A779G0
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
index 67de980ec4244c41..083f6580cb5dae00 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -271,6 +271,11 @@ static const struct renesas_soc soc_rcar_v4h __initconst __maybe_unused = {
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
@@ -381,6 +386,9 @@ static const struct of_device_id renesas_socs[] __initconst __maybe_unused = {
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


