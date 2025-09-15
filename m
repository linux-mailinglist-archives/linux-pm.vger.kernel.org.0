Return-Path: <linux-pm+bounces-34660-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59055B575F3
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 12:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89F811889E2A
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 10:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EF42FC870;
	Mon, 15 Sep 2025 10:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fL3GyFoK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1780B2FB62E;
	Mon, 15 Sep 2025 10:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757931258; cv=none; b=VVC03q4EcJ/4pqEZnVxxgdMFuh5E7jLSttmTO3WLuiS4AfOcymJ9d/+f61j4KqAjLkVMMm/wwLMSe8ROrkhqM+QnHCrZQoFve0OCSvj6jJyprJhpQIqfXyWQ6AkGfLbCig/gOERHdu30y5DhoPPapfDsjYqFcifcd/gqLoLuxpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757931258; c=relaxed/simple;
	bh=8vtetbU+oQHn8MIKLYcmyc6fn0I4jRKOJkIvin6Zijk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dhhHfE6VIvQxjP+gD2B7Tbw+b92vKdfzAMc1SZkXTrnBEUt7DRYSGXI8Ac+BX4Y5f0WI2Lr/vhcdeofE5AgFaNJ/+voMYxx0qt3wI1i2+nbj68nI+so5WnvNQAWuSoJKe40fCxB2oR7TxaZUeNoF+FK3eJImQIZwW1AXmnu8dgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fL3GyFoK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B07EAC4CEFD;
	Mon, 15 Sep 2025 10:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757931257;
	bh=8vtetbU+oQHn8MIKLYcmyc6fn0I4jRKOJkIvin6Zijk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fL3GyFoKRWKgm+UxvGqkuHsoWMMor1dLWcgrxfeQuV8Y5gBeWwCTsYR9CN2mZ50DW
	 KBj+3H6U+11e+PyZdJTlp/6IXbx2mndQcxlGs5WO5YK9TppiL5QG2YZ7yESV4z4YqT
	 /dcY1tTZPXlsKK4esG4V/fpc5JRjymxtIj+04LuTutLTAkIir/BlhEHNoMANzhmlcj
	 gLG29iFmemKcBjpIFL/gUZsYWRBICGdqHpTiqZo0D4b2NQ5lxhIW4gqeO2Pavn61KQ
	 Z9RiHAQdZVXPrURuAXyDfU96+NysFaXdpvd85a96yRCGKz/tJi17S8n1MQK1V+nAWQ
	 pmbNZvsMuTwcg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E062CAC59A;
	Mon, 15 Sep 2025 10:14:17 +0000 (UTC)
From: Thomas Antoine via B4 Relay <devnull+t.antoine.uclouvain.be@kernel.org>
Date: Mon, 15 Sep 2025 12:14:11 +0200
Subject: [PATCH v6 2/2] dt-bindings: power: supply: add support for
 MAX77759 fuel gauge
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-b4-gs101_max77759_fg-v6-2-31d08581500f@uclouvain.be>
References: <20250915-b4-gs101_max77759_fg-v6-0-31d08581500f@uclouvain.be>
In-Reply-To: <20250915-b4-gs101_max77759_fg-v6-0-31d08581500f@uclouvain.be>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, Thomas Antoine <t.antoine@uclouvain.be>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757931256; l=3462;
 i=t.antoine@uclouvain.be; s=20241202; h=from:subject:message-id;
 bh=RmrJkFcdKdGw/nW9mrN2NqAI0SHNuIVBB+BVTG5fu5w=;
 b=hlTQFthVMw1e+fIMoGX7ZzBZTtDfMDVZ4HJOwUPGLh7Pdjnr032ocqXmFWxuIkKD+btGyotPc
 uINIS045cq4BE2MWbKh7rBGhv620OIMxlAtpKAveKZiNv17bMPfc/yV
X-Developer-Key: i=t.antoine@uclouvain.be; a=ed25519;
 pk=sw7UYl31W1LTpgWRiX4xIF5x6ok7YWZ6XZnHqy/d3dY=
X-Endpoint-Received: by B4 Relay for t.antoine@uclouvain.be/20241202 with
 auth_id=289
X-Original-From: Thomas Antoine <t.antoine@uclouvain.be>
Reply-To: t.antoine@uclouvain.be

From: Thomas Antoine <t.antoine@uclouvain.be>

The Maxim MAX77759 is a companion PMIC for USB Type-C. It contains
Battery Charger, Fuel Gauge, temperature sensors, USB Type-C Port
Controller (TCPC), NVMEM, and additional GPIO interfaces

Use max77759-fg compatible to avoid conflict with drivers for other
functions.

The battery node is used to pass the REPCAP and ICHGTERM values
needed for the initialization of the fuel gauge.

The nvmem cells are used to get initialization values and to backup
the learning and the number of cycles. It should work out of the box
with gs101-oriole and gs101-raven which were previously running
Android.

Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
---
 .../bindings/power/supply/maxim,max77759.yaml      | 78 ++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max77759.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max77759.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..4d45739fcaf26273ec57b60049d6d0421df38efb
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max77759.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/maxim,max77759.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim Integrated MAX77759 fuel gauge
+
+maintainers:
+  - Thomas Antoine <t.antoine@uclouvain.be>
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    const: maxim,max77759-fg
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  shunt-resistor-micro-ohms:
+    description: The value of the current sense resistor in microohms.
+
+  monitored-battery:
+    description: |
+      The fuel gauge needs the following battery properties:
+      - charge-full-design-microamp-hours
+      - charge-term-current-microamp
+
+  nvmem-cells:
+    maxItems: 1
+    description: |
+      Saved fuel gauge state. This state will be used during the initialization
+      and saved on exit. It must be initialized beforehand.
+      Its layout must be composed of
+        - RCOMP0 (characterization of the open-circuit voltage)
+        - TCOMPO (temperature compensation information)
+        - FULLCAPREP (reported full capacity)
+        - QRTABLE00, QRTABLE10, QRTABLE20, QRTABLE30 (cell capacity information)
+        - cv_mixcap (remaining capacity of the cell without empty compensation)
+        - cv_halftime (time-to-full characterization time constant)
+      They must all be aligned on 2 bytes. A valid CRC8 checksum must
+      also be found at the end (polynomial x^8 + x^2 + x + 1).
+
+  nvmem-cell-names:
+    const: fg_state
+
+required:
+  - compatible
+  - reg
+  - shunt-resistor-micro-ohms
+  - monitored-battery
+  - nvmem-cells
+  - nvmem-cell-names
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
+      fuel-gauge@36 {
+        compatible = "maxim,max77759-fg";
+        reg = <0x36>;
+        interrupts-extended = <&gpa9 3 IRQ_TYPE_LEVEL_LOW>;
+        shunt-resistor-micro-ohms = <5000>;
+        monitored-battery = <&battery>;
+        nvmem-cells = <&fg_state>;
+        nvmem-cell-names = "fg_state";
+      };
+    };

-- 
2.51.0



