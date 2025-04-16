Return-Path: <linux-pm+bounces-25582-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87751A90EE5
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 00:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15FA31901AB1
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 22:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81B32459C4;
	Wed, 16 Apr 2025 22:49:39 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F7423E229;
	Wed, 16 Apr 2025 22:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744843779; cv=none; b=dNa1ScY2kdSNmamqLhPcDIOfsqNPw7msaIwQtCa5nyeeic364EoPrFxkfKUbAss51zIzMo4h9OZAo/JvzyWFEsuR1raLNPUu2JdIh75yjX2o8iX8Rj1ilO9DL5vI0gfBi41HbZL3Yrcjwa1O7cIqyENJ8SOGzvmlwZhelHitp94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744843779; c=relaxed/simple;
	bh=KdaSDgBpDMgItcGIYJxDgbgtshhdeEzKqe1mb0nsRFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VBVoW6C5I9Xbg4lBPW+9DeiuvpnAcLv4aPT+ELAqMUONsaPW/pGyxN8gFnrBXKGVll5GR1IB2a/wnmIQtdijhjH5iw8UrGuWVroE5XpsXX8s18bOd7Z9kLANdu3LFTuLd4jb13VCW202UmNa5sm/Tf9IQ6gR07Wz82uMAmVceVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11FCC1595;
	Wed, 16 Apr 2025 15:49:35 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76B263F66E;
	Wed, 16 Apr 2025 15:49:35 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Philippe Simons <simons.philippe@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 1/4] dt-bindings: power: Add Allwinner H6/H616 PRCM PPU
Date: Wed, 16 Apr 2025 23:48:36 +0100
Message-ID: <20250416224839.9840-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250416224839.9840-1-andre.przywara@arm.com>
References: <20250416224839.9840-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Allwinner H6 and some later SoCs contain some bits in the PRCM (Power
Reset Clock Management) block that control some power domains.
Those power domains include the one for the GPU, the PLLs and some
analogue circuits.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../power/allwinner,sun50i-h6-prcm-ppu.yaml   | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/allwinner,sun50i-h6-prcm-ppu.yaml

diff --git a/Documentation/devicetree/bindings/power/allwinner,sun50i-h6-prcm-ppu.yaml b/Documentation/devicetree/bindings/power/allwinner,sun50i-h6-prcm-ppu.yaml
new file mode 100644
index 0000000000000..7eaff9baf7268
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/allwinner,sun50i-h6-prcm-ppu.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/allwinner,sun50i-h6-prcm-ppu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner SoCs PRCM power domain controller
+
+maintainers:
+  - Andre Przywara <andre.przywara@arm.com>
+
+description:
+  The Allwinner Power Reset Clock Management (PRCM) unit contains bits to
+  control a few power domains.
+
+properties:
+  compatible:
+    enum:
+      - allwinner,sun50i-h6-prcm-ppu
+      - allwinner,sun50i-h616-prcm-ppu
+      - allwinner,sun55i-a523-prcm-ppu
+
+  reg:
+    maxItems: 1
+
+  '#power-domain-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#power-domain-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    prcm_ppu: power-controller@7010210 {
+        compatible = "allwinner,sun50i-h616-prcm-ppu";
+        reg = <0x07010250 0x10>;
+        #power-domain-cells = <1>;
+    };
-- 
2.46.3


