Return-Path: <linux-pm+bounces-22585-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D00A3E999
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 02:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBF27705C54
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 01:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46382CCA5;
	Fri, 21 Feb 2025 01:00:19 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76C12A1A4;
	Fri, 21 Feb 2025 01:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740099619; cv=none; b=gWFhB6AkRwW5HcGFBLca5Lj2bWJcVD2JefXn343xoOXN3lrQP9JFAPa3xVsp60ivESqB8WOf9REKdYwE9S4eFjeJxJGKeCH1+H+r4RbnurfT1aVBM7NsgtICdIE8yoHnhjVVi7txjuuFUAOd6PA1b5WNtZzAnmOhT12H9TaP2nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740099619; c=relaxed/simple;
	bh=N3l8k06E2lTecUPOk6hqSheF+IUZ9RXQkUANLTLh9zI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1lkIRO4wrxvSLQWGYHgUFt0UClN0s8qar9ISv3P7KtzXTWEqNG7lnOptdqbZ7FuQFgakkohb4T98bky9h6V0Hgns3hJoqR/pTCh4tMOwq6jHqNSbArFl5mmgR0PCwWBWiDPNZtN2uQUW47p4wyRg4DciwdF+mipPwZebTtavRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 274B81C01;
	Thu, 20 Feb 2025 17:00:34 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFAA53F59E;
	Thu, 20 Feb 2025 17:00:13 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-pm@vger.kernel.org
Subject: [PATCH 1/5] dt-bindings: power: Add Allwinner H6/H616 PRCM PPU
Date: Fri, 21 Feb 2025 00:57:58 +0000
Message-ID: <20250221005802.11001-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250221005802.11001-1-andre.przywara@arm.com>
References: <20250221005802.11001-1-andre.przywara@arm.com>
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


