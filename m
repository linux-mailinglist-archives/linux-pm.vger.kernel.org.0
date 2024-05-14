Return-Path: <linux-pm+bounces-7835-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C20968C4F76
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 12:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5EA51C209B2
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 10:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634A013FD94;
	Tue, 14 May 2024 10:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rU+gmuFG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="61RO9kn2"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F33F126F1E
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681945; cv=none; b=UAUFGofoKAL45AhutfxnmhmBNThJ3UNLvuSRKlQ/l9L8jga3ChAxR/y+T2NwKmPN9SIPlW4i8kSQzITefY4nHHspsTszLicxfQsuTwoEfvrnC6O7N7773m6RkRXgA7YAonHTTFu6w5kZFIOQ4tTUJ+U/bau8f792dzxZ36uJCGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681945; c=relaxed/simple;
	bh=B5QichSlxattKgtKVimpN5V37HEqkFVd3NDEBbMnBZU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iAMof9U38XmKd+0SF9aAqO5jcNQcWoU8rRnZtYGj0JyihRNIYtT9u8e2DIg5Z8eq9O6YOy6Dbutr7WlUcjsrihHIl5gu9bPsyN+zndqsPxiLep0gh1ycCxAdylP+RtHXWpt1S1ntWYGArqFRIkEJLvmENrzE2ZlVdreIMm+Evtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rU+gmuFG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=61RO9kn2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 May 2024 10:18:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715681936;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cLM/bz9elEuQlwow0Efo6E4qRhTnI5wiWPPAIEKhX24=;
	b=rU+gmuFGuh5RI68yCH43h3OnvoBhC9TEZIzyquRi76HXzryybOzz2pvNCpwsXDjGhtLZ4D
	EKX2S7mjSa7vF83baccMUKoqtBS6g3cHLX0ogdb61aeM+FJf5r4J1igTgXGdTlXqoAdY2A
	nJWywI7tEPWUVzIhQXhAmpbySfL59kaxpLjua4QWZkOfRxK7dlmhfVA7IhKdOtkO8ybzyz
	Q+X1fSq7P+sz4Bskaj7jdlGJ2d3IejFnoBYfe9b3WuCbEIac+IclsSTz+MuJaMQqbQMzfB
	3QywAgVGJYJ7791pjM/RinvDfbT1mc7OMAdcu4sap5cHGLNrWXpmtzDDo7b4yQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715681936;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cLM/bz9elEuQlwow0Efo6E4qRhTnI5wiWPPAIEKhX24=;
	b=61RO9kn2JUC1NZF59qhC1tcbvC+BY621CVT6JTYEnKWsXayMh+ZGVfe3vaCbfb/7Sh4DLX
	lcUP+Sa9IKSOveCw==
From: "thermal-bot for Raphael Gallais-Pou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/fixes] dt-bindings: thermal: convert
 st,stih407-thermal to DT schema
Cc: "Raphael Gallais-Pou" <rgallaispou@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
 amitk@kernel.org
In-Reply-To: <20240320-thermal-v3-1-700296694c4a@gmail.com>
References: <20240320-thermal-v3-1-700296694c4a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171568193580.10875.18236363448511526020.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     ff96922d33dfeb3cfe7c4fac051267155722c1ae
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//ff96922d33dfeb3cfe7c4fac051267155722c1ae
Author:        Raphael Gallais-Pou <rgallaispou@gmail.com>
AuthorDate:    Wed, 20 Mar 2024 22:33:48 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Apr 2024 12:40:29 +02:00

dt-bindings: thermal: convert st,stih407-thermal to DT schema

'st,passive_colling_temp' does not appear in the device-tree, 'reg' and
'#thermal-sensor-cells' are also missing in the device description.

Convert st,stih407-thermal binding to DT schema format in order to clean
unused 'st,passive_cooling_temp' and add missing properties.

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240320-thermal-v3-1-700296694c4a@gmail.com
---
 Documentation/devicetree/bindings/thermal/st,stih407-thermal.yaml | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 Documentation/devicetree/bindings/thermal/st-thermal.txt          | 32 --------------------------------
 2 files changed, 58 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/st,stih407-thermal.yaml
 delete mode 100644 Documentation/devicetree/bindings/thermal/st-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/st,stih407-thermal.yaml b/Documentation/devicetree/bindings/thermal/st,stih407-thermal.yaml
new file mode 100644
index 0000000..9f6fc5c
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/st,stih407-thermal.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/st,stih407-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STi digital thermal sensor (DTS)
+
+maintainers:
+  - Patrice Chotard <patrice.chotard@foss.st.com>
+  - Lee Jones <lee@kernel.org>
+
+allOf:
+  - $ref: thermal-sensor.yaml
+
+properties:
+  compatible:
+    const: st,stih407-thermal
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: thermal
+
+  interrupts:
+    description:
+      For thermal sensors for which no interrupt has been defined, a polling
+      delay of 1000ms will be used to read the temperature from device.
+    maxItems: 1
+
+  '#thermal-sensor-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    temperature-sensor@91a0000 {
+        compatible = "st,stih407-thermal";
+        reg = <0x91a0000 0x28>;
+        clock-names = "thermal";
+        clocks = <&CLK_SYSIN>;
+        interrupts = <GIC_SPI 205 IRQ_TYPE_EDGE_RISING>;
+        #thermal-sensor-cells = <0>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/thermal/st-thermal.txt b/Documentation/devicetree/bindings/thermal/st-thermal.txt
deleted file mode 100644
index a2f9391..0000000
--- a/Documentation/devicetree/bindings/thermal/st-thermal.txt
+++ /dev/null
@@ -1,32 +0,0 @@
-Binding for Thermal Sensor driver for STMicroelectronics STi series of SoCs.
-
-Required parameters:
--------------------
-
-compatible : 	Should be "st,stih407-thermal"
-
-clock-names : 	Should be "thermal".
-		  See: Documentation/devicetree/bindings/resource-names.txt
-clocks : 	Phandle of the clock used by the thermal sensor.
-		  See: Documentation/devicetree/bindings/clock/clock-bindings.txt
-
-Optional parameters:
--------------------
-
-reg : 		For non-sysconf based sensors, this should be the physical base
-		address and length of the sensor's registers.
-interrupts :	Standard way to define interrupt number.
-		  NB: For thermal sensor's for which no interrupt has been
-		  defined, a polling delay of 1000ms will be used to read the
-		  temperature from device.
-
-Example:
-
-	temp0@91a0000 {
-		compatible = "st,stih407-thermal";
-		reg = <0x91a0000 0x28>;
-		clock-names = "thermal";
-		clocks = <&CLK_SYSIN>;
-		interrupts = <GIC_SPI 205 IRQ_TYPE_EDGE_RISING>;
-		st,passive_cooling_temp = <110>;
-	};

