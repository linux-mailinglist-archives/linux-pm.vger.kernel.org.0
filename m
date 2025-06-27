Return-Path: <linux-pm+bounces-29674-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8C0AEBBC0
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 17:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 205CF188B728
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 15:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533522E92DC;
	Fri, 27 Jun 2025 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6iaMyjI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2517E1925BC;
	Fri, 27 Jun 2025 15:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751038170; cv=none; b=PhhsjrTPoENt4RIxO8puYScfd8soVCQLQZn106Fw27xm2tayJNoJ3G0AbSf/Vvw5Zq52E4eClZWMp/St/Z++YXaFzVLr6F5uVh/mZwynWtCohmlzQNL2iDbu94klB6lg6Hh9s25uL4h6K0oasKfB+4OJCOfx3VNLE91NEi50DGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751038170; c=relaxed/simple;
	bh=P2snesJzCcoewtMetOLPemSPMxBI1rMj38HQO6OHc0g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hBZA8CYFLKmILN0y+wB6uAKu5zm/f+q/uMjM482FtPr5gciAeilCVeX6ClakITz/S0QwGJdMSNcn7k4r/DS64ircn+EohyS0SuXY0Fo9SdBpFFJEbW1o6k2C1QnVI3BkyFqkB0RH18vbRo2u7E3VQuiDq9HkVDyOo1+uLAOVxpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6iaMyjI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86233C4CEE3;
	Fri, 27 Jun 2025 15:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751038169;
	bh=P2snesJzCcoewtMetOLPemSPMxBI1rMj38HQO6OHc0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H6iaMyjIJSuJKtCHJZ6x37YyMHYme+Bod9u1ZsU/7PCjyXrz//E4WTaIOqMbkhjd/
	 94+M0wIwSFWutdT5V/qplc4oFcCxbz+fKtX/IEtelLZHoWuIZE251HW5Up/60hIoaC
	 AU32kdGZZilFI92vGZyghti24aRHHEFBE65lQoDD+pbqbazVRg74Y9aYF0IqS8oIbN
	 yaHZY0go/TQ3yBy3zW38sTyiwcuo+OKWqYD5xS/dWBdm7bAG65bf4E/n4U/j3Xwlfi
	 Fk/SrzofSaJ0YGEkBqoin29zJWVs94bodR2PeW6ZrQBinmwH1LQPadLLACOGloEEUF
	 PKAdsBX1HNs1A==
Received: by wens.tw (Postfix, from userid 1000)
	id 2BE3A5FAC5; Fri, 27 Jun 2025 23:29:27 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Andre Przywara <andre.przywara@arm.com>,
	linux-sunxi@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: power: Add A523 PPU and PCK600 power controllers
Date: Fri, 27 Jun 2025 23:29:15 +0800
Message-Id: <20250627152918.2606728-2-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250627152918.2606728-1-wens@kernel.org>
References: <20250627152918.2606728-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

The A523 PPU is likely the same kind of hardware seen on previous SoCs.

The A523 PCK600, as the name suggests, is likely a customized version
of ARM's PCK-600 power controller. Comparing the BSP driver against
ARM's PPU datasheet shows that the basic registers line up, but
Allwinner's hardware has some additional delay controls in the reserved
register range. As such it is likely not fully compatible with the
standard ARM version.

Document A523 PPU and PCK600 compatibles.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../bindings/power/allwinner,sun20i-d1-ppu.yaml   |  2 ++
 .../power/allwinner,sun55i-a523-pck600.h          | 15 +++++++++++++++
 .../dt-bindings/power/allwinner,sun55i-a523-ppu.h | 12 ++++++++++++
 3 files changed, 29 insertions(+)
 create mode 100644 include/dt-bindings/power/allwinner,sun55i-a523-pck600.h
 create mode 100644 include/dt-bindings/power/allwinner,sun55i-a523-ppu.h

diff --git a/Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml b/Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml
index f578be6a3bc8..b9f550994512 100644
--- a/Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml
+++ b/Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml
@@ -18,6 +18,8 @@ properties:
     enum:
       - allwinner,sun20i-d1-ppu
       - allwinner,sun8i-v853-ppu
+      - allwinner,sun55i-a523-ppu
+      - allwinner,sun55i-a523-pck-600
 
   reg:
     maxItems: 1
diff --git a/include/dt-bindings/power/allwinner,sun55i-a523-pck600.h b/include/dt-bindings/power/allwinner,sun55i-a523-pck600.h
new file mode 100644
index 000000000000..6b3d8ea7bb69
--- /dev/null
+++ b/include/dt-bindings/power/allwinner,sun55i-a523-pck600.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_POWER_SUN55I_A523_PCK600_H_
+#define _DT_BINDINGS_POWER_SUN55I_A523_PCK600_H_
+
+#define PD_VE			0
+#define PD_GPU			1
+#define PD_VI			2
+#define PD_VO0			3
+#define PD_VO1			4
+#define PD_DE			5
+#define PD_NAND			6
+#define PD_PCIE			7
+
+#endif /* _DT_BINDINGS_POWER_SUN55I_A523_PCK600_H_ */
diff --git a/include/dt-bindings/power/allwinner,sun55i-a523-ppu.h b/include/dt-bindings/power/allwinner,sun55i-a523-ppu.h
new file mode 100644
index 000000000000..bc9aba73c19a
--- /dev/null
+++ b/include/dt-bindings/power/allwinner,sun55i-a523-ppu.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_POWER_SUN55I_A523_PPU_H_
+#define _DT_BINDINGS_POWER_SUN55I_A523_PPU_H_
+
+#define PD_DSP			0
+#define PD_NPU			1
+#define PD_AUDIO		2
+#define PD_SRAM			3
+#define PD_RISCV		4
+
+#endif /* _DT_BINDINGS_POWER_SUN55I_A523_PPU_H_ */
-- 
2.39.5


