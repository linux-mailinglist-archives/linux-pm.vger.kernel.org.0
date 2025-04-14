Return-Path: <linux-pm+bounces-25411-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F211FA88E15
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 23:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 435393AA62C
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 21:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53EB1FECA5;
	Mon, 14 Apr 2025 21:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Rq7U2VC4"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0A31F542E;
	Mon, 14 Apr 2025 21:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744666930; cv=none; b=ADAVqcc02pZlsNgZGR2aT+JSNgaRfWWMLhV6Hs7JMVLnra8q2njbaQKAeV3oiwGf8wdtUhRHZJicsjPXS2/mANqac1GpRzFexRpdJ+nqz3TBeap3p0CPrXVPCCQ9Y6RxntQE/9WXdhoSnWWpjNTc4rVfXsToOJj/p0PD1ut5n+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744666930; c=relaxed/simple;
	bh=VCaMKVR89ookuZONPoMM9YW1f2EPtej4NWNimSc/EFo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SjsnvuEhOs+5RmhLDxFYjJQZyTvjbxG+Nr85B5/Abr3u5zeId0DoK6D8bpDO6gQk0V21Uzz9PoCy2EZv/7p70L8O0ye0PMblY7JNHrzdJt87RlD5izQycCoSCKqyw3m/kU8gSsvbgV6cYBWRJSCwr09GHs2l0H4j5/35yIGwR48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Rq7U2VC4; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1744666928; x=1776202928;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VCaMKVR89ookuZONPoMM9YW1f2EPtej4NWNimSc/EFo=;
  b=Rq7U2VC4EzVpMlzExlzCEogiQOSzPjMgZa0mEocuGyz+mz1X3aG/DZE/
   Qa/ifwYvwV7jAnfzbskYNaPZn3iyeRUKi7ziWKzVTXvliFsgAi5Th2RoP
   tFWm+IZYlkBc8Ev4a35Xzj98pxPXEPmSC0OnsM/qwLh3L6t8rO1v87OKO
   gBmxMJIBV9Hu3Wf1+KbRnBRWq6cGbYOMN288yK5jVtyQxwguCh/QbhwtL
   uGGa3VWgBjxNjBcw7W+KyJ/60TdnAlDZnwP5PE1ELkDtUKTpd9qSPuAVy
   cgvtphgECFzPsscwkqxvV/O5rYPjyr/NXmoD15q+cKtOycyIz4AuQX+Zb
   g==;
X-CSE-ConnectionGUID: jf75aQsXSneWELgtntpGWQ==
X-CSE-MsgGUID: D0dtunMcRnuRprEgLd2nHQ==
X-IronPort-AV: E=Sophos;i="6.15,212,1739862000"; 
   d="scan'208";a="40006675"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Apr 2025 14:41:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 14 Apr 2025 14:41:05 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 14 Apr 2025 14:41:05 -0700
From: <Ryan.Wanner@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <lee@kernel.org>, <sre@kernel.org>,
	<p.zabel@pengutronix.de>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-rtc@vger.kernel.org>, Ryan Wanner <Ryan.Wanner@microchip.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 07/11] dt-bindings: mfd: syscon: atmel,sama5d2-secumod: convert to yaml
Date: Mon, 14 Apr 2025 14:41:24 -0700
Message-ID: <a999a719a652ec834f1176d69a3e9b207cbd63e6.1744666011.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1744666011.git.Ryan.Wanner@microchip.com>
References: <cover.1744666011.git.Ryan.Wanner@microchip.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/arm/atmel,sama5d2-secumod.yaml   | 48 +++++++++++++++++++
 .../devicetree/bindings/arm/atmel-sysregs.txt | 25 ----------
 2 files changed, 48 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/atmel,sama5d2-secumod.yaml

diff --git a/Documentation/devicetree/bindings/arm/atmel,sama5d2-secumod.yaml b/Documentation/devicetree/bindings/arm/atmel,sama5d2-secumod.yaml
new file mode 100644
index 000000000000..b1f766e333d4
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
+    security-module@fc040000 {
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


