Return-Path: <linux-pm+bounces-2751-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E1C83C6F0
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jan 2024 16:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 817281F2475F
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jan 2024 15:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C865745C3;
	Thu, 25 Jan 2024 15:35:07 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from gauss.telenet-ops.be (gauss.telenet-ops.be [195.130.132.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6047D74E31
	for <linux-pm@vger.kernel.org>; Thu, 25 Jan 2024 15:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706196907; cv=none; b=HgZqLEsBFihF+sHct0LUhhaNCDvWq7Mk6rqmzRtvd6Vy7uvNRShsfbm8ScM9pdAooRHkaOJ4s1mDwGLxYf8Y5D3qV9Ufp/IDOhvRwtkol7dlkRsn5VVdfLx4hMwfyO77I2vKfJ9Rw99aSFIiG2ZoufNTqB63qB6O/GBmtBDawY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706196907; c=relaxed/simple;
	bh=KWptP/q+SI7IkYUS0NXIxPMW/D8IJmR9Rt7P/xmxXOA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GSKgsuA3kz46sQCSDIZ17mfeYJCxnG1dk8uvA5XN4eBXv0vGyX7BUXLFsI8B9GdrdMr5XJlqxV6ynPu5Ajmt5ufAepUAjG1XW4Qsg+wioAuT2XVcSTQTZWecpcvKldzH8xcdvg0Pa3SwG5wmTDj2OYAZFzrAbf14tqDOPWqHtB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
	by gauss.telenet-ops.be (Postfix) with ESMTPS id 4TLPyp0d5fz4wxLk
	for <linux-pm@vger.kernel.org>; Thu, 25 Jan 2024 16:34:58 +0100 (CET)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:bc9e:fcb8:8aa3:5dc0])
	by albert.telenet-ops.be with bizsmtp
	id f3am2B00658agq2063am9R; Thu, 25 Jan 2024 16:34:57 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rT1jn-00GUvY-Vt;
	Thu, 25 Jan 2024 16:34:46 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rT1kb-00Fs2O-UY;
	Thu, 25 Jan 2024 16:34:45 +0100
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
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v2 02/15] dt-bindings: clock: Add R8A779H0 V4M CPG Core Clock Definitions
Date: Thu, 25 Jan 2024 16:34:30 +0100
Message-Id: <11acbd2a30b58607474e9c32eb798b3a00e85e73.1706194617.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706194617.git.geert+renesas@glider.be>
References: <cover.1706194617.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Duy Nguyen <duy.nguyen.rh@renesas.com>

Add all Clock Pulse Generator Core Clock Outputs for the Renesas R-Car
V4M (R8A779H0) SoC.

Signed-off-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
v2:
  - Add Reviewed-by,
  - Add vendor-prefix to file name and update include guard.

Changes compared to the BSP:
  - Drop POST* clocks, as they are internal clocks.
---
 .../clock/renesas,r8a779h0-cpg-mssr.h         | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 include/dt-bindings/clock/renesas,r8a779h0-cpg-mssr.h

diff --git a/include/dt-bindings/clock/renesas,r8a779h0-cpg-mssr.h b/include/dt-bindings/clock/renesas,r8a779h0-cpg-mssr.h
new file mode 100644
index 0000000000000000..7ab6cfbaf9010326
--- /dev/null
+++ b/include/dt-bindings/clock/renesas,r8a779h0-cpg-mssr.h
@@ -0,0 +1,96 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) 2023 Renesas Electronics Corp.
+ */
+#ifndef __DT_BINDINGS_CLOCK_RENESAS_R8A779H0_CPG_MSSR_H__
+#define __DT_BINDINGS_CLOCK_RENESAS_R8A779H0_CPG_MSSR_H__
+
+#include <dt-bindings/clock/renesas-cpg-mssr.h>
+
+/* r8a779h0 CPG Core Clocks */
+
+#define R8A779H0_CLK_ZX			0
+#define R8A779H0_CLK_ZD			1
+#define R8A779H0_CLK_ZS			2
+#define R8A779H0_CLK_ZT			3
+#define R8A779H0_CLK_ZTR		4
+#define R8A779H0_CLK_S0D2		5
+#define R8A779H0_CLK_S0D3		6
+#define R8A779H0_CLK_S0D4		7
+#define R8A779H0_CLK_S0D1_VIO		8
+#define R8A779H0_CLK_S0D2_VIO		9
+#define R8A779H0_CLK_S0D4_VIO		10
+#define R8A779H0_CLK_S0D8_VIO		11
+#define R8A779H0_CLK_VIOBUSD1		12
+#define R8A779H0_CLK_VIOBUSD2		13
+#define R8A779H0_CLK_S0D1_VC		14
+#define R8A779H0_CLK_S0D2_VC		15
+#define R8A779H0_CLK_S0D4_VC		16
+#define R8A779H0_CLK_VCBUSD1		17
+#define R8A779H0_CLK_VCBUSD2		18
+#define R8A779H0_CLK_S0D2_MM		19
+#define R8A779H0_CLK_S0D4_MM		20
+#define R8A779H0_CLK_S0D2_U3DG		21
+#define R8A779H0_CLK_S0D4_U3DG		22
+#define R8A779H0_CLK_S0D2_RT		23
+#define R8A779H0_CLK_S0D3_RT		24
+#define R8A779H0_CLK_S0D4_RT		25
+#define R8A779H0_CLK_S0D6_RT		26
+#define R8A779H0_CLK_S0D2_PER		27
+#define R8A779H0_CLK_S0D3_PER		28
+#define R8A779H0_CLK_S0D4_PER		29
+#define R8A779H0_CLK_S0D6_PER		30
+#define R8A779H0_CLK_S0D12_PER		31
+#define R8A779H0_CLK_S0D24_PER		32
+#define R8A779H0_CLK_S0D1_HSC		33
+#define R8A779H0_CLK_S0D2_HSC		34
+#define R8A779H0_CLK_S0D4_HSC		35
+#define R8A779H0_CLK_S0D8_HSC		36
+#define R8A779H0_CLK_SVD1_IR		37
+#define R8A779H0_CLK_SVD2_IR		38
+#define R8A779H0_CLK_IMPAD1		39
+#define R8A779H0_CLK_IMPAD4		40
+#define R8A779H0_CLK_IMPB		41
+#define R8A779H0_CLK_SVD1_VIP		42
+#define R8A779H0_CLK_SVD2_VIP		43
+#define R8A779H0_CLK_CL			44
+#define R8A779H0_CLK_CL16M		45
+#define R8A779H0_CLK_CL16M_MM		46
+#define R8A779H0_CLK_CL16M_RT		47
+#define R8A779H0_CLK_CL16M_PER		48
+#define R8A779H0_CLK_CL16M_HSC		49
+#define R8A779H0_CLK_ZC0		50
+#define R8A779H0_CLK_ZC1		51
+#define R8A779H0_CLK_ZC2		52
+#define R8A779H0_CLK_ZC3		53
+#define R8A779H0_CLK_ZB3		54
+#define R8A779H0_CLK_ZB3D2		55
+#define R8A779H0_CLK_ZB3D4		56
+#define R8A779H0_CLK_ZG			57
+#define R8A779H0_CLK_SD0H		58
+#define R8A779H0_CLK_SD0		59
+#define R8A779H0_CLK_RPC		60
+#define R8A779H0_CLK_RPCD2		61
+#define R8A779H0_CLK_MSO		62
+#define R8A779H0_CLK_CANFD		63
+#define R8A779H0_CLK_CSI		64
+#define R8A779H0_CLK_FRAY		65
+#define R8A779H0_CLK_IPC		66
+#define R8A779H0_CLK_SASYNCRT		67
+#define R8A779H0_CLK_SASYNCPERD1	68
+#define R8A779H0_CLK_SASYNCPERD2	69
+#define R8A779H0_CLK_SASYNCPERD4	70
+#define R8A779H0_CLK_DSIEXT		71
+#define R8A779H0_CLK_DSIREF		72
+#define R8A779H0_CLK_ADGH		73
+#define R8A779H0_CLK_OSC		74
+#define R8A779H0_CLK_ZR0		75
+#define R8A779H0_CLK_ZR1		76
+#define R8A779H0_CLK_ZR2		77
+#define R8A779H0_CLK_RGMII		78
+#define R8A779H0_CLK_CPEX		79
+#define R8A779H0_CLK_CP			80
+#define R8A779H0_CLK_CBFUSA		81
+#define R8A779H0_CLK_R			82
+
+#endif /* __DT_BINDINGS_CLOCK_RENESAS_R8A779H0_CPG_MSSR_H__ */
-- 
2.34.1


