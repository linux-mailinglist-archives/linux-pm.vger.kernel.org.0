Return-Path: <linux-pm+bounces-27559-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF249AC2312
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 14:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA5004E06E9
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 12:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC09146D45;
	Fri, 23 May 2025 12:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXnmkCKz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9383AC1C;
	Fri, 23 May 2025 12:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748004725; cv=none; b=VFSjZnxWb4sMl4sNfLLQTfwTX23mrTCV7MqcdGtXuZJKnVyu2hWl7aM+fDoWxA8ZcBdgv2uDCY/hvvTbp15zZAJl2ShuAq65zrZTOLfxWPIiiaT0l/tx2R0DaEinQZGWeCG/cpE3q8SZHVNjNny9OmpfACu4SbUJGmkSRz5f9uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748004725; c=relaxed/simple;
	bh=NveI/c5xQaxOP/723CwcVzN8aFWHOag/eGc7TuodKC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ijo2gxP6wxjj7DXR5y2dEzR7+8aTYlD4fr65cmJB1MHH9qsNos1O9YGH7UTj/cIegaW47UFoX4MIw/WHDos+HtLEGm+yNIvLp7J/4u32crcgsBTFJpk5ty8qUDbCWc/z/PvlrApN29z26HEb+4VSQKNkAmirrpnGaLo8Udw9aI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXnmkCKz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3201C4CEF4;
	Fri, 23 May 2025 12:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748004725;
	bh=NveI/c5xQaxOP/723CwcVzN8aFWHOag/eGc7TuodKC8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TXnmkCKz9hGSfTZovLeW2UjOICio8LoJ6TTxFV7e/3mhMKar9XQLj+eP0ADCF7C7t
	 BnFbyWRaRA5ffbqZ2lKd9HtyudivcnB/a2W/0E1qQLp6tlkYItl7R8kYDLHl5SHZ41
	 khU/8/gjRY7k3onKkhAoPCBG5t7pJNHdclvFmTIoaFKMMHPDuWwMC0rbcSkHaDeNnP
	 eWMx3T6IfqvcO/DYS0rdJlojh80nwk+fB545yYKou7wPK/8zVgVeRGj7iNsKbmTREP
	 zValZAlmoZfBf30yGsLC1PYwZ02qjOJMn67Fa5hB0wCVHdMXzQdepdw3Fg/WFXPP8q
	 SCfqVOFC5c+xw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5447C54F30;
	Fri, 23 May 2025 12:52:04 +0000 (UTC)
From: Thomas Antoine via B4 Relay <devnull+t.antoine.uclouvain.be@kernel.org>
Date: Fri, 23 May 2025 14:51:46 +0200
Subject: [PATCH v4 3/5] dt-bindings: power: supply: add max77759-fg flavor
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250523-b4-gs101_max77759_fg-v4-3-b49904e35a34@uclouvain.be>
References: <20250523-b4-gs101_max77759_fg-v4-0-b49904e35a34@uclouvain.be>
In-Reply-To: <20250523-b4-gs101_max77759_fg-v4-0-b49904e35a34@uclouvain.be>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, Thomas Antoine <t.antoine@uclouvain.be>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748004727; l=2682;
 i=t.antoine@uclouvain.be; s=20241202; h=from:subject:message-id;
 bh=GU2WoKOxlaWJoWfEaZr2bJ8lw3s+AOWQv0h8uwcwC90=;
 b=1zMV5uiw+xStEJWY23TLxuRPfW60BpaXrb6tMzTSEz/FqhcXCpWyL8y858ymE4+QoyVLSt7Fu
 iIKgAx0Q2TYCrw1JC4VQmzIV0StD/KwzRrwQOyp3yvofsr+hC59GTRu
X-Developer-Key: i=t.antoine@uclouvain.be; a=ed25519;
 pk=sw7UYl31W1LTpgWRiX4xIF5x6ok7YWZ6XZnHqy/d3dY=
X-Endpoint-Received: by B4 Relay for t.antoine@uclouvain.be/20241202 with
 auth_id=289
X-Original-From: Thomas Antoine <t.antoine@uclouvain.be>
Reply-To: t.antoine@uclouvain.be

From: Thomas Antoine <t.antoine@uclouvain.be>

The Maxim MAX77759 is an IC used to manage the power supply of the battery
and the USB-C. Based on drivers from google, it contains at least a PMIC,
a fuel gauge, a TCPCI and a charger.

Use max77759-fg compatible to avoid conflict with drivers for other
functions.

The Maxim MAX77759 has no non-volatile memory so it doesn't require an
address and instead requires a value for the current sensing resistor.

Keep shunt-resistor-micro-ohms optional for the MAX17201/MAX17205 as it is
not be used at the moment but could be in the future. (e.g. as a default
value to be used in case of nvmem failure)

Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
---
 .../bindings/power/supply/maxim,max17201.yaml      | 42 ++++++++++++++++++++--
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max17201.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max17201.yaml
index fe3dd9bd5585618e45220c51023391a5b21acfd2..2fb826b4b160eb9abe6604185ac2192447d90b8c 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,max17201.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max17201.yaml
@@ -9,13 +9,11 @@ title: Maxim MAX17201 fuel gauge
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
@@ -25,11 +23,18 @@ properties:
     items:
       - description: ModelGauge m5 registers
       - description: Nonvolatile registers
+    minItems: 1
+    maxItems: 2
 
   reg-names:
     items:
       - const: m5
       - const: nvmem
+    minItems: 1
+    maxItems: 2
+
+  shunt-resistor-micro-ohms:
+    description: The value of current sense resistor in microohms.
 
   interrupts:
     maxItems: 1
@@ -39,6 +44,37 @@ required:
   - reg
   - reg-names
 
+allOf:
+  - $ref: power-supply.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - maxim,max17201
+    then:
+      properties:
+        reg:
+          minItems: 2
+        reg-names:
+          minItems: 2
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - maxim,max77759-fg
+    then:
+      properties:
+        reg:
+          maxItems: 1
+        reg-names:
+          maxItems: 1
+      required:
+        - shunt-resistor-micro-ohms
+
 unevaluatedProperties: false
 
 examples:

-- 
2.49.0



