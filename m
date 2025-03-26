Return-Path: <linux-pm+bounces-24521-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D44A71AA7
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 16:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5C0A165839
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 15:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6A21F8690;
	Wed, 26 Mar 2025 15:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PgYiOqCi"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F261F5616;
	Wed, 26 Mar 2025 15:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743003402; cv=none; b=CRreL5g1T/vvtEn3xT0yCQRKO7MqueWmFLcyeNgabkKSnbFO+rGdup/TiRDQP6nHjtAlVAlJ2lgqM8eergL1IfG+ueDcMISlILjtJr6CBAtiDucRT+wM7juNXMlcrqEJsz/o5lbZ0JGcjlQFQosgJ7rr/Z6Zspzz9JO1S7XjqL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743003402; c=relaxed/simple;
	bh=szVEnhvPvUBlfCtyjfvV2jfNXNmn2KFpzc9sZGjFHCQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sTTHNTRaTAWqDdFwYB1Snp3mlAJMKQxmNl4rO1RicGMCYGYXE646ZLfozwFlXYxux4RX0RQBogdZUDFOEQlynR/km69TdiF8+Vwbs4Mm1M5k/WslHc7IHly4IUy3oBOZbdFHdTwPP4uvBwl65Pq1OpZFrLgsjZvgNpR/MFUSIhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PgYiOqCi; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1743003401; x=1774539401;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=szVEnhvPvUBlfCtyjfvV2jfNXNmn2KFpzc9sZGjFHCQ=;
  b=PgYiOqCiGZyjsvXZ8RxJkwn1lFHmHRCyZttotNJQmd5QmpVtQufIlQAo
   BXyUsGdxUBpyHRSBcZryfKvrGcilIoQr/pwA3Uu2Mr3fbFmDrT0UjsFZL
   oGCzfPsiLZ2mq7qbX49emaMwBYAuHhipeUEW2NdD0vBUYQJ5gas90YBvS
   MAZb/a5hnnwrAVdtenTOV6jZ6NaU2/DOKLlmHKE0fHtRoqH4SZ1kzQLSC
   ow69R/IrHXNXv8pmkSvarAw8sCJQ3hiokDvvmVrqYq57w5ZVw8ZMuCCNo
   LYqaMsXpjpPxCifbOR+Zz7Rii3R/ZaqIBIDo6feYSZUUTBnkqYjYb9/HC
   A==;
X-CSE-ConnectionGUID: NRxSiTFnT3ucBnaYj7CaZg==
X-CSE-MsgGUID: nc1Hn/qqQNGMW2FQWcbFQQ==
X-IronPort-AV: E=Sophos;i="6.14,278,1736838000"; 
   d="scan'208";a="44096107"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Mar 2025 08:36:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 26 Mar 2025 08:35:51 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Wed, 26 Mar 2025 08:35:51 -0700
From: <Ryan.Wanner@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <lee@kernel.org>, <sre@kernel.org>,
	<p.zabel@pengutronix.de>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-rtc@vger.kernel.org>, Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH v4 07/11] dt-bindings: mfd: syscon: atmel,sama5d2-secumod: convert to yaml
Date: Wed, 26 Mar 2025 08:35:40 -0700
Message-ID: <271b23440f79bfad3e902689a9f4b240ab43eb28.1742936082.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1742936082.git.Ryan.Wanner@microchip.com>
References: <cover.1742936082.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Convert Microchip AT91 secumod to YAML format.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 .../bindings/arm/atmel,sama5d2-secumod.yaml   | 48 +++++++++++++++++++
 .../devicetree/bindings/arm/atmel-sysregs.txt | 25 ----------
 2 files changed, 48 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/atmel,sama5d2-secumod.yaml

diff --git a/Documentation/devicetree/bindings/arm/atmel,sama5d2-secumod.yaml b/Documentation/devicetree/bindings/arm/atmel,sama5d2-secumod.yaml
new file mode 100644
index 000000000000..6edeb320220f
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/atmel,sama5d2-secumod.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/atmel,sama5d2-secumod.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip AT91 Security Module (SECUMOD)
+
+maintainers:
+  - Nicolas Ferre <nicolas.ferre@microchip.com>
+
+description:
+  The Security Module also offers the PIOBU pins which can be used as GPIO pins.
+  Note that they maintain their voltage during Backup/Self-refresh.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: atmel,sama5d2-secumod
+          - const: syscon
+      - items:
+          - enum:
+              - microchip,sama7g5-secumod
+          - const: atmel,sama5d2-secumod
+          - const: syscon
+  reg:
+    maxItems: 1
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    secumod@fc040000 {
+      compatible = "atmel,sama5d2-secumod", "syscon";
+      reg = <0xfc040000 0x100>;
+      gpio-controller;
+      #gpio-cells = <2>;
+    };
diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
index d3821f651e72..5ce54f9befe6 100644
--- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
@@ -46,28 +46,3 @@ Examples:
 		reg = <0xffffe800 0x200>;
 	};
 
-Security Module (SECUMOD)
-
-The Security Module macrocell provides all necessary secure functions to avoid
-voltage, temperature, frequency and mechanical attacks on the chip. It also
-embeds secure memories that can be scrambled.
-
-The Security Module also offers the PIOBU pins which can be used as GPIO pins.
-Note that they maintain their voltage during Backup/Self-refresh.
-
-required properties:
-- compatible: Should be "atmel,<chip>-secumod", "syscon".
-  <chip> can be "sama5d2".
-- reg: Should contain registers location and length
-- gpio-controller:	Marks the port as GPIO controller.
-- #gpio-cells:		There are 2. The pin number is the
-			first, the second represents additional
-			parameters such as GPIO_ACTIVE_HIGH/LOW.
-
-
-	secumod@fc040000 {
-		compatible = "atmel,sama5d2-secumod", "syscon";
-		reg = <0xfc040000 0x100>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-- 
2.43.0


