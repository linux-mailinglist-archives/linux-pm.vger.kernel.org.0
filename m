Return-Path: <linux-pm+bounces-31657-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 547D1B16BAD
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 07:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDCFF5A5921
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 05:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB81242D64;
	Thu, 31 Jul 2025 05:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="4BVoEewS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331142AD0F;
	Thu, 31 Jul 2025 05:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753940869; cv=none; b=Htpo1sFluWhXQhpYx44+e3dc+1xSfZLEOuJlUldZmQKyDdDYZe1rWksJc8Q6QCf8c6XxgGrVjdukBpCUmvSiuHXslazjB1j6XK0HTyAJ2MxqfBjuTpNefAPwoFZwFIzGc2/eeIp84+YuBsa1YdLfjrnhEH0TXXpq02Kjid0pKCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753940869; c=relaxed/simple;
	bh=d5fEOtua4vpT6NX34jk7klGwiYHt5UYWGtJvkDVAkZA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RJArS2WzDWmSKBYZ1OBjvJ35Fd1teZdK/6tKMGSs7uX1x9nQPzZWx9VLKHERCyj0p/YtmFwpLbNjIIApJNGilLONs2VLSeiuJLb18GQ4paz7m2uBfhZzziiLsgbwXrVWQ5oS513SoNPGMO5wZXD/+2Ij7cin9efK1ud6KAtkFlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=4BVoEewS; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1753940863;
	bh=LgE1wrgehgQ7YAKYVZSadz1mYOzKdPMuLR4U45cahxA=; l=2674;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=4BVoEewSWseneRtBgQFk5cBaTguGfkL2fKUzcck4JRGwCmBs3RQC2rDSLis2bTEQk
	 2WPnKAQ8JDPnKRP13EgFvT/UjlFSEqDLjCh0oSPsvhE0itcssxkfkikYnvoI7kiCWs
	 bLKflVM8KbWcv+3rLHqVC8oWjfBy1QNqH/QG3+UEhTshQOtH98LcmTYYbQdAOvIzXQ
	 t40vdYPxg1dUmkgJlv50k+tRyvaEIlKeE5IQGEYjSoH5yydVB+kuRkhULQRQQfbeTv
	 EbmStbNefNBjVRcDoDbHzx+RFr40GFpWGEqhG/ce/7wlx/+Bl2tNwl8d5ZzTXThH3F
	 PUcDegLyH3Xzg==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(244579:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Thu, 31 Jul 2025 13:47:38 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 31 Jul
 2025 13:47:37 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Thu, 31 Jul 2025 13:47:37 +0800
From: <cy_huang@richtek.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Conor Dooley <conor+dt@kernel.org>, ChiYuan Huang <cy_huang@richtek.com>,
	<devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: power: supply: Add Richtek RT9756 smart cap divider charger
Date: Thu, 31 Jul 2025 13:48:16 +0800
Message-ID: <6e986ea01a3dd104f700f5cc49578a9403c9676b.1753940508.git.cy_huang@richtek.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1753940508.git.cy_huang@richtek.com>
References: <cover.1753940508.git.cy_huang@richtek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: ChiYuan Huang <cy_huang@richtek.com>

Add the document for Richtek RT9756 smart cap divider charger.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
V2
- Add reference to 'power-supply.yaml'
- Remove 'wakeup-source' from required property list
- Use 'unevaluatedProperties' to replace 'additionalProperties'
---
 .../bindings/power/supply/richtek,rt9756.yaml | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9756.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt9756.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt9756.yaml
new file mode 100644
index 000000000000..a88bf6cd1927
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/richtek,rt9756.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/richtek,rt9756.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RT9756 Smart Cap Divider Charger
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  The RT9756/RT9757 is a high efficiency and high charge current charger.
+
+  The efficiency is up to 98.2% when VBAT = 4V, IBAT = 2A in DIV2 mode and 99.1%
+  when VBAT=4V, IBAT=1A in bypass mode. The maximum charger current is up to 8A
+  in DIV2 mode and 5A in bypass mode. The device integrates smart cap divider
+  topology, direct charging mode, external over-voltage protection control, an
+  input reverse blocking NFET and 2-way regulation, a dual phase charge pump
+  core, 8-Channel high speed ADCs and USB BC 1.2 detection.
+
+  RT9770 is almost the same with RT9756/57, only BC 1.2 detection function is
+  removed to shrink the die size.
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - richtek,rt9756
+          - richtek,rt9770
+      - items:
+          - enum:
+              - richtek,rt9757
+          - const: richtek,rt9756
+
+  reg:
+    maxItems: 1
+
+  wakeup-source: true
+
+  interrupts:
+    maxItems: 1
+
+  shunt-resistor-micro-ohms:
+    description: Battery current sense resistor mounted.
+    default: 2000
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      charger@6f {
+        compatible = "richtek,rt9756";
+        reg = <0x6f>;
+        wakeup-source;
+        interrupts-extended = <&gpio_intc 32 IRQ_TYPE_EDGE_FALLING>;
+        shunt-resistor-micro-ohms = <5000>;
+      };
+    };
-- 
2.34.1


