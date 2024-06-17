Return-Path: <linux-pm+bounces-9341-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C2D90B365
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 17:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AD771C238F8
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 15:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C8F14D715;
	Mon, 17 Jun 2024 14:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UaUHpI94"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC3314D6E5;
	Mon, 17 Jun 2024 14:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718634056; cv=none; b=cxMTVdn6EwK5wO7iu/8DuF61jhpb6Rgb+/E3RfRNlR5bh/lOVsVSePRpEOzxRIcz6AMN03vtXiXfWV3Zpppx/rsT7P2a70iwDW3R1Vk4CYoI+0qxGqLOgdMHXv86fcEfsznLc+WuJp+FQRj8WoOoYGtlH+Dv+ZB5NGW1S1cCFHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718634056; c=relaxed/simple;
	bh=unPUtePx4FTeKKBmH9jeU3M6vc1xY06k0mJbsHVvoRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dwop1LlkdDRPGhlkR9Bx8mSoky2KqtT4sGQOtUvudaV42Pg4gfWUijmMBIv11X/X8FOoEBkXyGkw4PwIiThXWRNMt6b27SQRksZN39U+V266lyjpc4KuIYtYfhnyKpNuALmKb0rMQ4FJ5q8gG1/pluTKBsh/2CsPX7vx6BHEiW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UaUHpI94; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6b065d12e81so21700736d6.0;
        Mon, 17 Jun 2024 07:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718634054; x=1719238854; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PaTJzZNQnKML5wOALCFr7UKAYUQ4uDtj0s8DKZQbERU=;
        b=UaUHpI94jf3oSGoH7rCc//ZtSGHc/meBLsXzwgKo7T5gjnF1hkqmiVSw05YVgBgOx/
         b3hBJb9Xd3w5G5iZSxybPbyhbZM572sEzYNZv+id8njWsc80Y4E+2mIIorDFM3wwFMsL
         jadERNyUe58vi6JgblQwmzKjTT0Bg9imiIlUVRdSOpsuMiYJF6/2zKhQArHhAF9brgsx
         hhq6HXId4EByT3UD1V3UC06yvafSvdcfkJZ0w5WLsxTn7ugEnVW8T973AX6F9B6S75NO
         d9OrmTIe+ejQExdxzl/hqOLausbnTWif4GIgN0B4tfhmtB2ojqOnI2M7rhTDcnmizf2r
         okcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718634054; x=1719238854;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PaTJzZNQnKML5wOALCFr7UKAYUQ4uDtj0s8DKZQbERU=;
        b=xKOn1nwud13y9F+Hv/jkawaGmlmglmJZKAbTf7ki7V9MGmDnGl4a9iK7WaQY08DwxS
         7PWS3zE9U4s4GIiQD8S18SmPkkhpzrt+MTN8VMqz+to9b+1gyTZWEJAHax6eybeHPpzC
         Dq0tNuZrDbkn5AbjlVz49IHeWBhmoinG/8Cq1+LLbLbsKL1YiRvT7up8ul6lAHi1epD5
         A6jrrARVgSZKi8SkSpv2WjkuPo2D5Ev9l10H2uLN8CXAXfKgC6HUELvlBF4AjspatVXP
         7dk0YPeyoa2d/Xk/dEBdX+g5HcbeI7UAt990IItEzaLlxB5TVkK3BSC/OKGQzdfVlhdU
         l2VA==
X-Forwarded-Encrypted: i=1; AJvYcCUnRU9mRvVTHThcVdEjld+WqbAOFBUv68GOokfYpqNekUAEl8CagDU0DooqXJtYmVAoNuRN+uBjawPDcHMa6LE658d8xiuF2H/Ose3Rti3NCSbZlGF0nG1hy+3E0Ps2j7VgtLeLk913kZ61pY1GkKJgYee+qiM5Tb5bzbxDFrF+JJid
X-Gm-Message-State: AOJu0Yz3fcYZIl+PQHBMg7MyChCAs393taFAVZ3Ucw6K1d5GfoGdWJBN
	Uuc2RHgl/68H4vKgbXNI9edSpTdqnKLaYhAJXhJxk+JiOjdDFDLgOE1FYXf7
X-Google-Smtp-Source: AGHT+IFDaQH3oE9wnnPykHX6d3ceULs7zIEDhV5rSBjBtx7IebGxMyd2ReuaF/wrLpBqk8ly6W7Vew==
X-Received: by 2002:a0c:e58b:0:b0:6b0:7997:ee3b with SMTP id 6a1803df08f44-6b2afcd99a2mr97733156d6.35.1718634054139;
        Mon, 17 Jun 2024 07:20:54 -0700 (PDT)
Received: from [127.0.1.1] ([2607:fea8:bad7:5400:2557:2c70:d69f:574f])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441ef4f5875sm46640001cf.28.2024.06.17.07.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 07:20:53 -0700 (PDT)
From: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>
Date: Mon, 17 Jun 2024 10:20:52 -0400
Subject: [PATCH v2] dt-bindings: thermal: convert hisilicon-thermal.txt to
 dt-schema
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-hisilicon-thermal-dt-bindings-conversion-v2-1-5eea9bc59c77@gmail.com>
X-B4-Tracking: v=1; b=H4sIAENGcGYC/63Qz2rDMAwG8FcpPk/Df1Sn66nvMXZwbDkxJE5xg
 tkoefcpZYMcW+jxE+L3Id3ETCXRLM6HmyhU05ymzEG/HYTvXe4IUuAstNQorTLQ88qQ/JRh6am
 MboCwQJtySLmbgeeVyoaAcUhGoYzSnQRz10Ixfd+rPr84M7RM5efeXPU2/S/Bx0uqBgVkrW8Dm
 qjx49KNLg3vfhq3zj+weRI8YnMkZSnY1r8GNFJ5Is0faXfg9oZq9qc/AxuGbTgFxChjaHAPr+v
 6CwMPbXDbAQAA
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>
X-Mailer: b4 0.14-dev-0bd45
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718634053; l=3876;
 i=abdulrasaqolawani@gmail.com; s=20240613; h=from:subject:message-id;
 bh=unPUtePx4FTeKKBmH9jeU3M6vc1xY06k0mJbsHVvoRc=;
 b=Leg+7ppemKw7KR0Vj2wUHEQU2L6Ut0RFyUwj7sP7YHJqFB7qmnJtB+JS/FyATEfDV2aaVaJ59
 IvB53yo3rxwAYnWE2WpJkVkfSATG9xekvH7CKsX1Q001E0pYK/15Xuu
X-Developer-Key: i=abdulrasaqolawani@gmail.com; a=ed25519;
 pk=cUqfinPW5pkopFB8ShBc0ZTNgYvSW5ZTa8aLIFPGp/w=

Convert the hisilicon SoCs tsensor txt bindings to dt-schema

Signed-off-by: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>
---
Changes in v2:
- Remove extra node in example.
- Use standard node name in example.
- Include additional defines from includes.
- Add reference to thermal-sensor.yaml.
- Remove redundant properties and comments.

- Link to v1: https://lore.kernel.org/all/20240613224204.185844-1-abdulrasaqolawani@gmail.com
---

Validated with dtschema and tested against `hi3660-hikey960.dts`.
---
 .../bindings/thermal/hisilicon,tsensor.yaml        | 57 ++++++++++++++++++++++
 .../bindings/thermal/hisilicon-thermal.txt         | 32 ------------
 2 files changed, 57 insertions(+), 32 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/hisilicon,tsensor.yaml b/Documentation/devicetree/bindings/thermal/hisilicon,tsensor.yaml
new file mode 100644
index 000000000000..8b898fbfb200
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/hisilicon,tsensor.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/hisilicon,tsensor.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Temperature Sensor on HiSilicon SoCs
+
+maintainers:
+  - Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>
+
+allOf:
+  - $ref: thermal-sensor.yaml
+
+properties:
+  compatible:
+    enum:
+      - hisilicon,tsensor
+      - hisilicon,hi3660-tsensor
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: thermal_clk
+
+  interrupts:
+    maxItems: 1
+
+  '#thermal-sensor-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - '#thermal-sensor-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/hi6220-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+     temperature-sensor@f7030700 {
+        compatible = "hisilicon,tsensor";
+        reg = <0xf7030700 0x1000>;
+        interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&sys_ctrl HI6220_TSENSOR_CLK>;
+        clock-names = "thermal_clk";
+        #thermal-sensor-cells = <1>;
+     };
diff --git a/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt b/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
deleted file mode 100644
index 4b19d80e6558..000000000000
--- a/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
+++ /dev/null
@@ -1,32 +0,0 @@
-* Temperature Sensor on hisilicon SoCs
-
-** Required properties :
-
-- compatible: "hisilicon,tsensor".
-- reg: physical base address of thermal sensor and length of memory mapped
-  region.
-- interrupt: The interrupt number to the cpu. Defines the interrupt used
-  by /SOCTHERM/tsensor.
-- clock-names: Input clock name, should be 'thermal_clk'.
-- clocks: phandles for clock specified in "clock-names" property.
-- #thermal-sensor-cells: Should be 1. See Documentation/devicetree/bindings/thermal/thermal-sensor.yaml for a description.
-
-Example :
-
-for Hi6220:
-	tsensor: tsensor@0,f7030700 {
-		compatible = "hisilicon,tsensor";
-		reg = <0x0 0xf7030700 0x0 0x1000>;
-		interrupts = <0 7 0x4>;
-		clocks = <&sys_ctrl HI6220_TSENSOR_CLK>;
-		clock-names = "thermal_clk";
-		#thermal-sensor-cells = <1>;
-	}
-
-for Hi3660:
-	tsensor: tsensor@fff30000 {
-		compatible = "hisilicon,hi3660-tsensor";
-		reg = <0x0 0xfff30000 0x0 0x1000>;
-		interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
-		#thermal-sensor-cells = <1>;
-	};

---
base-commit: 8d5ed3dd17c9c1bdb39ecb125f0e28dfb5111dd9
change-id: 20240613-hisilicon-thermal-dt-bindings-conversion-3a4e3140f0a8

Best regards,
-- 
Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>


