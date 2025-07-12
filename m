Return-Path: <linux-pm+bounces-30720-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9E9B029BC
	for <lists+linux-pm@lfdr.de>; Sat, 12 Jul 2025 09:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7399F1C22272
	for <lists+linux-pm@lfdr.de>; Sat, 12 Jul 2025 07:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826E622A7EF;
	Sat, 12 Jul 2025 07:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIS1XkB+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AA022A4CC;
	Sat, 12 Jul 2025 07:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752306048; cv=none; b=rmNvZCKwhFddL4O9xZOxNeNmkkfg5/rtW6MtFlGalVaIZIMUEy5G02YqihLS56eJO2gDqLqbhJpB4H8ebRNd/R9zmBaN2HoK9PvN4n6vPLJt2XrTlwU4DRCLKmjlutUDjOCqr6QNpsESdEKdhHvwdRWrzOYXqYl/tGYcbde/Pe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752306048; c=relaxed/simple;
	bh=BnVNBCmaGD8QKefYif7ONwqBQvBpS1QUbrNhxe9uuik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R16V5+nLYBpxjTYCHWf/hJXRengaIENDsZcZiq5VRduC9ljJAURqYGYVZaxKti8GX8TlHKHNd8Pcr0TlahZ/lcqGvgKWx+XNDJLeoSW7Gbc7zbmcujXuwcpLwRVKBC7vm0I5aFv2q3Ofh25f5bvDAEox2HkCzjOUH5XQTzgay8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIS1XkB+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F01C4CEF4;
	Sat, 12 Jul 2025 07:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752306047;
	bh=BnVNBCmaGD8QKefYif7ONwqBQvBpS1QUbrNhxe9uuik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vIS1XkB+tIS1q6MQDWPYVYScsNdG2z77DV9w8N8KxXTvLXA9YHLvi60ba+oFPXWcY
	 +r3z0elC2niosw3oU7y4doGzoYq1FsiPCkMYHvhfElysMhNcFmkY5tq53tJ0SBL+3I
	 bCB1pb0Qbrc/2QWK+GpiGpbOHsXwxzcmzWXYq7U3cJFtk1BLuNz5uF/pA8+L41iNNV
	 7fOk8kwSy4csNkTvX/ct0WHC0en/IyEfOmABzqJz9c3f3kWvxEoSQrriSG20+xixTa
	 o2i6/qEayA9qH7JESWDcB4+9VS5eKb1Pc80vd9N3Hby1cMa9sokeXg1+FeI4VZ21gg
	 M//C9KshEDeXA==
Received: by wens.tw (Postfix, from userid 1000)
	id C36FA5FF44; Sat, 12 Jul 2025 15:40:42 +0800 (CST)
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
Subject: [PATCH v3 1/5] dt-bindings: power: Add A523 PPU and PCK600 power controllers
Date: Sat, 12 Jul 2025 15:40:17 +0800
Message-Id: <20250712074021.805953-2-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250712074021.805953-1-wens@kernel.org>
References: <20250712074021.805953-1-wens@kernel.org>
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

Also reorder the compatible string entries so they are grouped and
ordered by family first, then by SoC model.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
Changes since v1:
- Re-order compatible string entries
- Fix name of header file to match compatible string
---
 .../bindings/power/allwinner,sun20i-d1-ppu.yaml   |  4 +++-
 .../power/allwinner,sun55i-a523-pck-600.h         | 15 +++++++++++++++
 .../dt-bindings/power/allwinner,sun55i-a523-ppu.h | 12 ++++++++++++
 3 files changed, 30 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/power/allwinner,sun55i-a523-pck-600.h
 create mode 100644 include/dt-bindings/power/allwinner,sun55i-a523-ppu.h

diff --git a/Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml b/Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml
index f578be6a3bc8..a28e75a9cb6a 100644
--- a/Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml
+++ b/Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml
@@ -16,8 +16,10 @@ description:
 properties:
   compatible:
     enum:
-      - allwinner,sun20i-d1-ppu
       - allwinner,sun8i-v853-ppu
+      - allwinner,sun20i-d1-ppu
+      - allwinner,sun55i-a523-pck-600
+      - allwinner,sun55i-a523-ppu
 
   reg:
     maxItems: 1
diff --git a/include/dt-bindings/power/allwinner,sun55i-a523-pck-600.h b/include/dt-bindings/power/allwinner,sun55i-a523-pck-600.h
new file mode 100644
index 000000000000..6b3d8ea7bb69
--- /dev/null
+++ b/include/dt-bindings/power/allwinner,sun55i-a523-pck-600.h
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


