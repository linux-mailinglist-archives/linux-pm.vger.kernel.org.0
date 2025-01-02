Return-Path: <linux-pm+bounces-19899-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DD69FF896
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 12:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CA54162359
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 11:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD63C1B0418;
	Thu,  2 Jan 2025 11:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwB82J1P"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3741ADFF8;
	Thu,  2 Jan 2025 11:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735816564; cv=none; b=T2QvtS3l3HIS5dCXlvo0x5kfACyzG9ikhypYMpFpDfk47xVzE3KERysDHUWdPC/+DAnXsu+dBF5XTxh8tngk88RmoEs88YxOZBwb01LntvO7bEsv7Dz/GXfbW/r1IiaSjSMK3OojVvpzoUYXFC3WAdn4zFaKbbq4UrWG+leWJXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735816564; c=relaxed/simple;
	bh=YR3aOQfQRpjZeAPGaopQcbBOCXaW1wkvfZuiJhh9ZRs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uLUgFw+DTc6Qr5erqwYV2YW6iPgKIqXVnqfu2YSEdP1JVZvn2EoEVabU+/HKbf7ZjlrVokGSeMRIR/7qGziKxA3jilkRLtlHbqkbcIqQnvwnICovK04FJ0eafROEQ3QO0VRS00wO4XUV0ftjN/JmP2cMRBEqOqL36GOi5307P9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwB82J1P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D035AC4CEE0;
	Thu,  2 Jan 2025 11:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735816563;
	bh=YR3aOQfQRpjZeAPGaopQcbBOCXaW1wkvfZuiJhh9ZRs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nwB82J1Pv2iNNTb2Af7IuogSNLkCde2a3t0qaAzS97CdDpXBqitQiDKZ1AV1o2hZ7
	 mbyzLeyQeB2TWP/VrsCWotg84pwCHlfJt2PpMlXIbfQhFrm0fsu9mf5gDe2jFG9Gef
	 LF34GIxYDDxKGA+R+zsuHU8omuWo/piJT/j/rLeQapr0KgUDOmNl1l0eHYMqF9rd2A
	 4/VtzP9Uq/4PQ64doNWVk4mWeB5CM8UxTVBhSEzGkZiAApGDInZ6W4dXf6Cjq+6JXx
	 87zvrIWvHHgMaOtyPWkHg09EOqFbouIdB2oef/i1gdt2uUc1pkp/iUBN11gapKvdtr
	 xiIJuV6M+pkaA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD23FE77197;
	Thu,  2 Jan 2025 11:16:03 +0000 (UTC)
From: Thomas Antoine via B4 Relay <devnull+t.antoine.uclouvain.be@kernel.org>
Date: Thu, 02 Jan 2025 12:15:04 +0100
Subject: [PATCH v2 2/4] dt-bindings: power: supply: add max77759-fg flavor
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250102-b4-gs101_max77759_fg-v2-2-87959abeb7ff@uclouvain.be>
References: <20250102-b4-gs101_max77759_fg-v2-0-87959abeb7ff@uclouvain.be>
In-Reply-To: <20250102-b4-gs101_max77759_fg-v2-0-87959abeb7ff@uclouvain.be>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, Thomas Antoine <t.antoine@uclouvain.be>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735816515; l=2599;
 i=t.antoine@uclouvain.be; s=20241202; h=from:subject:message-id;
 bh=NQEfG+SwFTGG+va2nEDX792ufRBYG0gtt35ac3EAHLY=;
 b=jM9VyggQ6eUW1RT5Sw+s3vgG3v7+G7XxjmfVHL2taeQU21fLP17pnVRrLZpT7NYIGIpDtxYrk
 OMqxPoSo6FqBEGjo0OnJe41tXf4Ii/jZK6JPj76xV1c1Vmui0kl7rNh
X-Developer-Key: i=t.antoine@uclouvain.be; a=ed25519;
 pk=sw7UYl31W1LTpgWRiX4xIF5x6ok7YWZ6XZnHqy/d3dY=
X-Endpoint-Received: by B4 Relay for t.antoine@uclouvain.be/20241202 with
 auth_id=289
X-Original-From: Thomas Antoine <t.antoine@uclouvain.be>
Reply-To: t.antoine@uclouvain.be

From: Thomas Antoine <t.antoine@uclouvain.be>

The max77759 is an IC used to manage the power supply of the battery and
the USB-C. Based on drivers from google, it contains at least a PMIC, a
fuel gauge, a TCPCI and a charger.

Use max77759-fg compatible to avoid conflict with drivers for other
functions.

The max77759 has no non-volatile memory so it doesn't require an address
and instead requires a value for the current sensing resistor.

Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
---
 .../bindings/power/supply/maxim,max17201.yaml      | 56 +++++++++++++++++-----
 1 file changed, 43 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max17201.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max17201.yaml
index fe3dd9bd5585618e45220c51023391a5b21acfd2..7e95314508c27d0d90ea92f61bca6b4a2fe0e88e 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,max17201.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max17201.yaml
@@ -9,31 +9,61 @@ title: Maxim MAX17201 fuel gauge
 maintainers:
   - Dimitri Fedrau <dima.fedrau@gmail.com>
 
-allOf:
-  - $ref: power-supply.yaml#
-
 properties:
   compatible:
     oneOf:
       - const: maxim,max17201
+      - const: maxim,max77759-fg
       - items:
           - enum:
               - maxim,max17205
           - const: maxim,max17201
 
-  reg:
-    items:
-      - description: ModelGauge m5 registers
-      - description: Nonvolatile registers
-
-  reg-names:
-    items:
-      - const: m5
-      - const: nvmem
-
   interrupts:
     maxItems: 1
 
+allOf:
+  - $ref: power-supply.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - maxim,max17201
+    then:
+      properties:
+        reg:
+          items:
+            - description: ModelGauge m5 registers
+            - description: Nonvolatile registers
+          minItems: 1
+
+        reg-names:
+          items:
+            - const: m5
+            - const: nvmem
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - maxim,max77759-fg
+    then:
+      properties:
+        reg:
+          items:
+            - description: ModelGauge m5 registers
+
+        reg-names:
+          items:
+            - const: m5
+
+        shunt-resistor-micro-ohms:
+          description: The value of current sense resistor.
+
+      required:
+        - shunt-resistor-micro-ohms
+
 required:
   - compatible
   - reg

-- 
2.47.1



