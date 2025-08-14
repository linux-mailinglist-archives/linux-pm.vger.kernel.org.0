Return-Path: <linux-pm+bounces-32376-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D07DB25D92
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 09:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04B3BA00E46
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 07:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27202727F9;
	Thu, 14 Aug 2025 07:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="GGUCt4jZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F9F8F4A;
	Thu, 14 Aug 2025 07:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156631; cv=none; b=Nu9krd6LCxo0XgKT+LNek8431fk+PLw+qkPB98eRNqtqhcAgcYOvxp9gQl4ueVmyOOFEBBuDiR5BLmOVB4cv3ZQbxLtcOQUN2lYUgMLXSMFqDOwy8mTcZFGN1MyXp1RRGlRxwf44E1bdnp8PJmk9dODMH2UZG5LaMgFxaTUjaR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156631; c=relaxed/simple;
	bh=9trR5UxdHWDqSG6vyDQcemhL3UOInGnpau/LcAXDx44=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pcVFFaEkYGciAqVZklCuvc7IciPjYd26/dZ7/iFWvrLuf58XhgWy+9+k9lj9mXE4PmZfngmjWxacNx8cnJtnV52AIh9G4xzDW/YMbVeNxel6bF1eqDMp/XFfBttcm4h2ayNwOLtiTpXOFd5caXvzxgRChpYw3zH8OQNafPX1y3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=GGUCt4jZ; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1755156626;
	bh=dkZBtvIeapL8oPDdpjQQ5aagXVeprBU+s6xz6iCqmRw=; l=2741;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=GGUCt4jZ0B93tRNXCyGEnXR3BMV841A4vqUw1MTVvbmDrF1K63PxE6Y6v/aOB96Kt
	 SB4wz7Ie2G8Q58ru6VnVBEafeKZUoRGFBlqRNmzPm0QYEcPYcNR45i6LHkC/W4FjC8
	 fNX4GW5rrTmkEOq3GTDP+Otizr9JOVGtlYTEcoNl5zRMM3BnqIfpM3Eeg0kjgbIYEw
	 lLFM9ClOoWfqGk1UJkGeUB/pW9S9x6580FQV9mM30zBYElviP1Do2HEqD6tGvfjPfU
	 RtKuOJaZX3C+dwdPIiD0XOZxN/TAEB06OIUogka7mY97l+dTAGMaPfc81RgIGEnyim
	 k11/ViOt3YNjw==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(817437:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Thu, 14 Aug 2025 15:30:19 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 14 Aug
 2025 15:30:19 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Thu, 14 Aug 2025 15:30:19 +0800
From: <cy_huang@richtek.com>
To: Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>
CC: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"ChiYuan Huang" <cy_huang@richtek.com>, <devicetree@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski@linaro.org>
Subject: [PATCH RESEND v2 1/3] dt-bindings: power: supply: Add Richtek RT9756 smart cap divider charger
Date: Thu, 14 Aug 2025 15:31:06 +0800
Message-ID: <b27544e3bad860d806e3791df696929ca844dc5b.1755154950.git.cy_huang@richtek.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1755154950.git.cy_huang@richtek.com>
References: <cover.1755154950.git.cy_huang@richtek.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


