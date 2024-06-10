Return-Path: <linux-pm+bounces-8844-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A57901D74
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 10:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E2F81F215F8
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 08:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B9F7580D;
	Mon, 10 Jun 2024 08:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="2IPln/Ik"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C29974076;
	Mon, 10 Jun 2024 08:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718009868; cv=none; b=qeDKX7ATQSK8vaj+D7PBwL/q53nFPuWr2nttt9WLSwTlRblMNa7AAz9OeT2LK+3VxSnQvKhVcrjghx5XpAsCrMsKyIIzVmW/vc0cQwsXrHod+pZC0z0CqFUDBqjfP1K3RqsUdArcYh8d94s91h7IG7HySifGnihtbz5ne+0lFRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718009868; c=relaxed/simple;
	bh=3Zeqi/RdCx9L9htA/KnzDJuzfpBx9g/uuKDEMw1Y5ZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Axk1yMtohSAI5fyeCeiF9yqQCBEyyYSTWlYWPbYoC6RUBeDqd7MZU1tM/d01wRDelCGW1yxw/1PGPkQ7UOAk7xUwswzz0w0qgqWUlcFAY/vUkY4hDKlQe/sDLsRcd/mFEmkb/fRiy85FsQ1cLTpjWc2N3P0WuiY7eR/VuXQJdQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=2IPln/Ik; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718009864;
	bh=3Zeqi/RdCx9L9htA/KnzDJuzfpBx9g/uuKDEMw1Y5ZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2IPln/IkiIg2cLyao+eNl1Jx/hfHa19m7IOmdPusNhipqupVRflce1kfyUTf8jb2K
	 BFGjpPa+jZ/HTV5wfzx6vmPofLVWTJxK5oGLBi5t4VC/wXjXIcAUYhokD2bFDPu3ch
	 85BsojSFJDQQCF1aiuOkIJnr5RfNwD1mkb+63QpufvlsNSNUoVnL3M/faOEIJGZX5a
	 Y99YqELAFDnYLrof6e1DpIXSWp9/5XB1c6tOBWNsS9BZutdQ2C0i6bVb79adsO4b/M
	 w8QtnIGjLrUYbw4wGv1qfwG8t+slQRf//bXCO5/QX5+Yny1U0L5/etXtk9NmfYzAPc
	 uJE53lu2e8erg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5028A378217A;
	Mon, 10 Jun 2024 08:57:43 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: djakov@kernel.org
Cc: robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	keescook@chromium.org,
	gustavoars@kernel.org,
	henryc.chen@mediatek.com,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com,
	wenst@chromium.org,
	amergnat@baylibre.com
Subject: [PATCH v6 3/7] dt-bindings: soc: mediatek: Add DVFSRC bindings for MT8183 and MT8195
Date: Mon, 10 Jun 2024 10:57:31 +0200
Message-ID: <20240610085735.147134-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240610085735.147134-1-angelogioacchino.delregno@collabora.com>
References: <20240610085735.147134-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bindings for the MediaTek Dynamic Voltage and Frequency Scaling
Resource Collector (DVFSRC), a hardware module used to collect all the
requests from both software and the various remote processors embedded
into the SoC and decide about a minimum operating voltage and a minimum
DRAM frequency to fulfill those requests in an effort to provide the
best achievable performance per watt.

This hardware IP is capable of transparently performing direct register
R/W on all of the DVFSRC-controlled regulators and SoC bandwidth knobs.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../soc/mediatek/mediatek,mt8183-dvfsrc.yaml  | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.yaml

diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.yaml
new file mode 100644
index 000000000000..1ad5b61b249f
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/mediatek/mediatek,mt8183-dvfsrc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Dynamic Voltage and Frequency Scaling Resource Collector (DVFSRC)
+
+description:
+  The Dynamic Voltage and Frequency Scaling Resource Collector (DVFSRC) is a
+  Hardware module used to collect all the requests from both software and the
+  various remote processors embedded into the SoC and decide about a minimum
+  operating voltage and a minimum DRAM frequency to fulfill those requests in
+  an effort to provide the best achievable performance per watt.
+  This hardware IP is capable of transparently performing direct register R/W
+  on all of the DVFSRC-controlled regulators and SoC bandwidth knobs.
+
+maintainers:
+  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+  - Henry Chen <henryc.chen@mediatek.com>
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - mediatek,mt8183-dvfsrc
+          - mediatek,mt8195-dvfsrc
+      - items:
+          - const: mediatek,mt8192-dvfsrc
+          - const: mediatek,mt8195-dvfsrc
+
+  reg:
+    maxItems: 1
+    description: DVFSRC common register address and length.
+
+  regulators:
+    type: object
+    $ref: /schemas/regulator/mediatek,mt6873-dvfsrc-regulator.yaml#
+
+  interconnect:
+    type: object
+    $ref: /schemas/interconnect/mediatek,mt8183-emi.yaml#
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        system-controller@10012000 {
+            compatible = "mediatek,mt8195-dvfsrc";
+            reg = <0 0x10012000 0 0x1000>;
+
+            regulators {
+                compatible = "mediatek,mt8195-dvfsrc-regulator";
+
+                dvfsrc_vcore: dvfsrc-vcore {
+                        regulator-name = "dvfsrc-vcore";
+                        regulator-min-microvolt = <550000>;
+                        regulator-max-microvolt = <750000>;
+                        regulator-always-on;
+                };
+
+                dvfsrc_vscp: dvfsrc-vscp {
+                        regulator-name = "dvfsrc-vscp";
+                        regulator-min-microvolt = <550000>;
+                        regulator-max-microvolt = <750000>;
+                        regulator-always-on;
+                };
+            };
+
+            emi_icc: interconnect {
+                compatible = "mediatek,mt8195-emi";
+                #interconnect-cells = <1>;
+            };
+        };
+    };
-- 
2.45.2


