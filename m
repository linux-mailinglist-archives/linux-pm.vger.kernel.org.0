Return-Path: <linux-pm+bounces-31531-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8867B14726
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jul 2025 06:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AE70189F9DB
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jul 2025 04:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DF722F14C;
	Tue, 29 Jul 2025 04:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="eAsylATk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93663218AB4;
	Tue, 29 Jul 2025 04:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753762905; cv=none; b=nla04KN7YZ4Lv9Jk+aBZeucNoUBevaxVtDH/3OjzL8CyFXqLymh8UoxX6vVjeZWbaV8A6OMzEwJ8fZJTM+G6pYGaxIzuatt4haqB59T+cYxU5mpG9giDVEFOO5vFdR8GOO2tZ7Z55kSq+ZXR8ikuL4pkEHPLH793SXcB/Kjy97k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753762905; c=relaxed/simple;
	bh=OeKTN21CycNFFobbaS2HsIx24ilhWjJRE82/H3S5eGM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=otxIugl9Rna0l25dZ2kYuHpzCtDvTpDQGRTn6v1hHG8dk9ZzOUX8/zitWQoI0kOLTQnGOCFPBFLYzTe37kweQp1cFM0a0b9JwcMqGSclk8UpPo0O0+1jy/cgpMuX1wWGp3ay5AlHjmu64i7RwQHlr/DJyHrjxMIqc/BHcn004GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=eAsylATk; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1753762893;
	bh=NZkp0I3rfn833ZMw/h05mRfKz+m2vrdOxl19fVW2oz0=; l=2482;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=eAsylATkWYeFSkHFno/2EKRc/te+v0AtFoKDPdiHV3L3oZpO0vReJkJAZjdl+gkfd
	 fewnNg+F+TO4FPFlpzGtsSKUvMghDY8KV6WNuC6T7D1ihKnYMTbbV1XHwhLpH6Ok5q
	 SOZPbPXXIUruf6Q9cLv8czj0VAGl4hx168dRgEgwYSrZtVNeMC53HXZXUvN7XvSKHx
	 SR7mQMjVjHQG1AW6zUpiSvcBw17IslMdQVseOYOTKruyEpZD8uobY/e2psnH33wd4K
	 3uTrkfmNXOWSEVBPyk+GiYWvK59i2HGbtv93BzNRBlAGMyf0DP/ua/kOsoRuNwyY+D
	 +AXT3kbCty+tA==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(244577:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Tue, 29 Jul 2025 12:21:18 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 29 Jul
 2025 12:21:18 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Tue, 29 Jul 2025 12:21:18 +0800
From: <cy_huang@richtek.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Conor Dooley <conor+dt@kernel.org>, ChiYuan Huang <cy_huang@richtek.com>,
	<devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] dt-bindings: power: supply: Add Richtek RT9756 smart cap divider charger
Date: Tue, 29 Jul 2025 12:21:54 +0800
Message-ID: <3fa997b42b4aec43fc182a043cf521f7e3e7fcb3.1753759794.git.cy_huang@richtek.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1753759794.git.cy_huang@richtek.com>
References: <cover.1753759794.git.cy_huang@richtek.com>
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
 .../bindings/power/supply/richtek,rt9756.yaml | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9756.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt9756.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt9756.yaml
new file mode 100644
index 000000000000..e81668b43fba
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/richtek,rt9756.yaml
@@ -0,0 +1,70 @@
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
+  - wakeup-source
+  - interrupts
+
+additionalProperties: false
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


