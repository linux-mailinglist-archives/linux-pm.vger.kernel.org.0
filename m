Return-Path: <linux-pm+bounces-32016-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC47B1CAE4
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 19:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99826561B9F
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 17:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6717029C33A;
	Wed,  6 Aug 2025 17:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="GovyU9nq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C391FDD;
	Wed,  6 Aug 2025 17:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754501717; cv=none; b=dcebrmBNh4MUyWqM6kqJNy+P4csT+cR4ABu3zehKEDNP88tjFdLGBlP+ZxgSl+GfNh5ECBTxq1HkIUZkEeU77lrwWSlWn/g2oH6ff9wXLo413AhDBmtelJX7PJ2CgSLjv9yZj+1/BoQyIKNJG2RF3zIjZjoiG2wOcX2jCqCcS2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754501717; c=relaxed/simple;
	bh=NaSKHDpe1UTKIpyJg9w1/zlPE5d3b9jJCH+yLalacOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A8LfUju8Ruxx/iAzvsskum9E6JRMXJX9Ku3TwX1MxUrOzvYgcR7yVyLc6z/E/gtatJuKvMTPxhOCwi2x/WHiTBl+Uh/cqsQythBiBLVXEnLpelMqjnfbxGz5mlZpi+hNFKLlsshvL8nrBf0NlAFr8pJsN3tM2MPGE1pk/DDXXII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=GovyU9nq; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
DKIM-Signature: a=rsa-sha256; bh=K+sDVe+AL0VvM2xVVhvm9ns2Irn43g9bQsGd/D2Ja4c=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1754501630; v=1; x=1754933630;
 b=GovyU9nqwNWQBo54lcF4rXe42IT96iZOZf3OMfVm8XBnZ5b5t7k3K/ugVQu7ez43PkFGf28i
 sNhgiWyqyWbpdXiZOmFzskNuHQGS0OZXCDuwTmAeqRm8T/qaTBnmkAuvBLEiHkCheI5+BXnzfqh
 GOu7Z6LWUKwg+jsTGzUXu55S5+KLKiYh/RPn0+aUocEOBHQBxIEZSWfV4074xZwvCdRyZ75SW+N
 qE/Tbxz0XH2XGyEbBgeSZXzS5eF6Zr0nqhMy0hqGTr42j4bhThBxYQK4Yj1B8O0pKxWbNx+J8yj
 QbW74tRYO2Zi/aswsUhCtqChQRMNJ/RXK3DTJEOzbR4Tg==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id 0bfd0103; Wed, 06 Aug 2025 19:33:50 +0200
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Date: Wed, 06 Aug 2025 19:33:21 +0200
Subject: [PATCH RFC 2/5] dt-bindings: power: Add Marvell PXA1908 domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250806-pxa1908-genpd-v1-2-16409309fc72@dujemihanovic.xyz>
References: <20250806-pxa1908-genpd-v1-0-16409309fc72@dujemihanovic.xyz>
In-Reply-To: <20250806-pxa1908-genpd-v1-0-16409309fc72@dujemihanovic.xyz>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: David Wronek <david@mainlining.org>, Karel Balej <balejk@matfyz.cz>, 
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4274;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=NaSKHDpe1UTKIpyJg9w1/zlPE5d3b9jJCH+yLalacOw=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBmTJ/6xZ2Z7XR5sfy77GoOPz/LLwrsUi0okGFf3Zsm2b
 +M13/Cio5SFQYyLQVZMkSX3v+M13s8iW7dnLzOAmcPKBDKEgYtTACbiv4SR4YO0T2mo+imhjB6F
 A9tajZZ3BE3qmsRbtlCIs3Drhjlqxgz/Q7fr7eabINq9V1FATthoi1HA3NSw31w7HQ9WSM18fHM
 RAwA=
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

Add device tree bindings for Marvell PXA1908's power domains.

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
 .../power/marvell,pxa1908-power-controller.yaml    | 105 +++++++++++++++++++++
 include/dt-bindings/power/marvell,pxa1908-power.h  |  17 ++++
 2 files changed, 122 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/marvell,pxa1908-power-controller.yaml b/Documentation/devicetree/bindings/power/marvell,pxa1908-power-controller.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..1cf3a45d56cbb7b75f7204d656016a9a569da186
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/marvell,pxa1908-power-controller.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/marvell,pxa1908-power-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell PXA1908 Power Domain Controller
+
+maintainers:
+  - Duje Mihanović <duje@dujemihanovic.xyz>
+
+description: |
+  The Marvell PXA1908 SoC includes multiple power domains which can be powered
+  on/off to save power when different IP cores are not in use.
+
+properties:
+  $nodename:
+    pattern: '^power-controller$'
+
+  compatible:
+    const: marvell,pxa1908-power-controller
+
+  '#power-domain-cells':
+    const: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  "^power-domain@[0-9a-f]+$":
+    type: object
+
+    description: |
+      Represents a power domain within the power controller node as documented
+      in Documentation/devicetree/bindings/power/power-domain.yaml.
+
+    properties:
+      reg:
+        description: |
+          Power domain index. Valid values are defined in:
+              "include/dt-bindings/power/marvell,pxa1908-power.h"
+        maxItems: 1
+
+      clocks:
+        description: |
+          A number of phandles to clocks that need to be enabled during domain
+          power up.
+
+      '#power-domain-cells':
+        const: 0
+
+    required:
+      - reg
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/power/marvell,pxa1908-power.h>
+
+    clock-controller@d4282800 {
+      compatible = "marvell,pxa1908-apmu", "simple-mfd", "syscon";
+      reg = <0xd4282800 0x400>;
+      #clock-cells = <1>;
+
+      power-controller {
+        compatible = "marvell,pxa1908-power-controller";
+        #address-cells = <1>;
+        #size-cells = <0>;
+        #power-domain-cells = <1>;
+
+        power-domain@PXA1908_POWER_DOMAIN_VPU {
+          reg = <PXA1908_POWER_DOMAIN_VPU>;
+          #power-domain-cells = <0>;
+        };
+
+        power-domain@PXA1908_POWER_DOMAIN_GPU {
+          reg = <PXA1908_POWER_DOMAIN_GPU>;
+          #power-domain-cells = <0>;
+        };
+
+        power-domain@PXA1908_POWER_DOMAIN_GPU2D {
+          reg = <PXA1908_POWER_DOMAIN_GPU2D>;
+          #power-domain-cells = <0>;
+        };
+
+        power-domain@PXA1908_POWER_DOMAIN_DSI {
+          reg = <PXA1908_POWER_DOMAIN_DSI>;
+          #power-domain-cells = <0>;
+        };
+
+        power-domain@PXA1908_POWER_DOMAIN_ISP {
+          reg = <PXA1908_POWER_DOMAIN_ISP>;
+          #power-domain-cells = <0>;
+        };
+      };
+    };
diff --git a/include/dt-bindings/power/marvell,pxa1908-power.h b/include/dt-bindings/power/marvell,pxa1908-power.h
new file mode 100644
index 0000000000000000000000000000000000000000..19b088351af138823505a774ff27203429fe2d97
--- /dev/null
+++ b/include/dt-bindings/power/marvell,pxa1908-power.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * Marvell PXA1908 power domains
+ *
+ * Copyright 2025, Duje Mihanović <duje@dujemihanovic.xyz>
+ */
+
+#ifndef __DTS_MARVELL_PXA1908_POWER_H
+#define __DTS_MARVELL_PXA1908_POWER_H
+
+#define PXA1908_POWER_DOMAIN_VPU	0
+#define PXA1908_POWER_DOMAIN_GPU	1
+#define PXA1908_POWER_DOMAIN_GPU2D	2
+#define PXA1908_POWER_DOMAIN_DSI	3
+#define PXA1908_POWER_DOMAIN_ISP	4
+
+#endif

-- 
2.50.1


