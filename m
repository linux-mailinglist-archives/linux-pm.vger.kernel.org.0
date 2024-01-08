Return-Path: <linux-pm+bounces-1953-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC928827361
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jan 2024 16:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64AE0280C4D
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jan 2024 15:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C306537ED;
	Mon,  8 Jan 2024 15:34:17 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from cantor.telenet-ops.be (cantor.telenet-ops.be [195.130.132.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD79152F98
	for <linux-pm@vger.kernel.org>; Mon,  8 Jan 2024 15:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
	by cantor.telenet-ops.be (Postfix) with ESMTPS id 4T7ylp2ZMXz4x2y2
	for <linux-pm@vger.kernel.org>; Mon,  8 Jan 2024 16:34:14 +0100 (CET)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:d323:2fd4:4f64:e281])
	by albert.telenet-ops.be with bizsmtp
	id YFZw2B00E0Qz0eJ06FZwec; Mon, 08 Jan 2024 16:34:07 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rMrcp-00EtLy-2F;
	Mon, 08 Jan 2024 16:33:56 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rMrdU-00D7o1-8w;
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
Subject: [PATCH 04/15] dt-bindings: power: Add r8a779h0 SYSC power domain definitions
Date: Mon,  8 Jan 2024 16:33:43 +0100
Message-Id: <1285e6a9fb423c8d6fff0c7faef157a1ea172d70.1704726960.git.geert+renesas@glider.be>
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

Add power domain indices for the Renesas R-Car V4M (R8A779H0) SoC.

Signed-off-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/dt-bindings/power/r8a779h0-sysc.h | 49 +++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 include/dt-bindings/power/r8a779h0-sysc.h

diff --git a/include/dt-bindings/power/r8a779h0-sysc.h b/include/dt-bindings/power/r8a779h0-sysc.h
new file mode 100644
index 0000000000000000..29f05f0401a13336
--- /dev/null
+++ b/include/dt-bindings/power/r8a779h0-sysc.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) 2023 Renesas Electronics Corp.
+ */
+#ifndef __DT_BINDINGS_POWER_R8A779H0_SYSC_H__
+#define __DT_BINDINGS_POWER_R8A779H0_SYSC_H__
+
+/*
+ * These power domain indices match the Power Domain Register Numbers (PDR)
+ */
+
+#define R8A779H0_PD_A1E0D0C0		0
+#define R8A779H0_PD_A1E0D0C1		1
+#define R8A779H0_PD_A1E0D0C2		2
+#define R8A779H0_PD_A1E0D0C3		3
+#define R8A779H0_PD_A2E0D0		16
+#define R8A779H0_PD_A3CR0		21
+#define R8A779H0_PD_A3CR1		22
+#define R8A779H0_PD_A3CR2		23
+#define R8A779H0_PD_A33DGA		24
+#define R8A779H0_PD_A23DGB		25
+#define R8A779H0_PD_C4			31
+#define R8A779H0_PD_A1DSP0		33
+#define R8A779H0_PD_A2IMP01		34
+#define R8A779H0_PD_A2PSC		35
+#define R8A779H0_PD_A2CV0		36
+#define R8A779H0_PD_A2CV1		37
+#define R8A779H0_PD_A3IMR0		38
+#define R8A779H0_PD_A3IMR1		39
+#define R8A779H0_PD_A3VC		40
+#define R8A779H0_PD_A2CN0		42
+#define R8A779H0_PD_A1CN0		44
+#define R8A779H0_PD_A1DSP1		45
+#define R8A779H0_PD_A2DMA		47
+#define R8A779H0_PD_A2CV2		48
+#define R8A779H0_PD_A2CV3		49
+#define R8A779H0_PD_A3IMR2		50
+#define R8A779H0_PD_A3IMR3		51
+#define R8A779H0_PD_A3PCI		52
+#define R8A779H0_PD_A2PCIPHY		53
+#define R8A779H0_PD_A3VIP0		56
+#define R8A779H0_PD_A3VIP2		58
+#define R8A779H0_PD_A3ISP0		60
+#define R8A779H0_PD_A3DUL		62
+
+/* Always-on power area */
+#define R8A779H0_PD_ALWAYS_ON		64
+
+#endif /* __DT_BINDINGS_POWER_R8A779H0_SYSC_H__ */
-- 
2.34.1


