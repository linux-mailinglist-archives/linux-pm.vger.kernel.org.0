Return-Path: <linux-pm+bounces-30494-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C482AFEE25
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 17:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5149A7AD126
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 15:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9182E9EA6;
	Wed,  9 Jul 2025 15:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ho/KmTGG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED78C2E8E10;
	Wed,  9 Jul 2025 15:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076427; cv=none; b=GVcF0V3LDAgh82OxoLr0wyYtIpnLM8J0Tuk/uJBD4rAKG6B+dRRJnRtS3oAQTZxYkN8+OAJeK4A3mm1suQ0AbVaUMvgrSejEbg5PSiP+Z1dOs1r0ZmNh03b3rfLDZ0htP9tE0cM+QfmQwjTfWgX+EWMC/6boDT61ZiPQ6DPrOLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076427; c=relaxed/simple;
	bh=7Wbq7YVdQYBRh6HqmuZ0nMrzeWobJHu0jczoLtBCBC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nuRXdgWrr8SuLgosKWtVrjCRn94B9LltxC9YUiLNgWG/75fVAX6Nchjp3sgy35Whe2PazDL7JXUp364FFU4jZZcI2ZdaEcbziD8UqorO5Oxdz5oZsUau3O5VfRvZ1SrmixnlvH7CHn6yIWTnABDDrKGZM2I6/A0vMdFq2wU2dFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ho/KmTGG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710B9C4AF0B;
	Wed,  9 Jul 2025 15:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752076426;
	bh=7Wbq7YVdQYBRh6HqmuZ0nMrzeWobJHu0jczoLtBCBC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ho/KmTGG+BEj8Z3EAJH+upQ5rpbS3W1yyfhGSC/VrkauLBphKHQ4pHT9VNoV7oGFo
	 DkLp0MplaNZO8dfHh+nRJGpy4Ok0MXbyRe+/5wkVs8bVMNjM7Wsn0I/7AxRQiRx9jE
	 pc6j4dGoCNCbZHttHmR9PCmFa7Oz/qo0DejqbqOEDbj2nkBxr67iDHVGliwAqlEBz6
	 ydlovTSIXcEwofYOKaAuCH97Os9AlCWHDmZfSai6/u9Jxbzhv4TW8fEFI7vRidkLpO
	 oHZPzrnaABoha9Vo675Bgb53dYaU6nQcpVWzuVsJh8hi74N2AKHEXcW6ZrauMWqLaR
	 lFoIPVybXp+Gw==
Received: by wens.tw (Postfix, from userid 1000)
	id 36E955FBBD; Wed,  9 Jul 2025 23:53:44 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-sunxi@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v2 1/4] dt-bindings: power: Add A523 PPU and PCK600 power controllers
Date: Wed,  9 Jul 2025 23:53:40 +0800
Message-Id: <20250709155343.3765227-2-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250709155343.3765227-1-wens@kernel.org>
References: <20250709155343.3765227-1-wens@kernel.org>
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


