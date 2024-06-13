Return-Path: <linux-pm+bounces-9126-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE12907F17
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 00:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1138E1C22303
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 22:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A6814D281;
	Thu, 13 Jun 2024 22:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ol47/nWk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FB91411C3;
	Thu, 13 Jun 2024 22:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718318529; cv=none; b=eFn6cwq2ZMxQISue5Xi95q/+dBcObtpqyChzIQ+/OtU7VwSObZCdUHWNTDo+zgwNAt0vmxjirc30yxtGbQwwT/OfJ6DhHAsDr3ahVCBZr4NZ19W4RvJdsh0Dl+tGCn+7HR5wt5uTPpkeZvac5ZFZpDz0UVgNiBpbpFjAZJoGYPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718318529; c=relaxed/simple;
	bh=pKzimYJu+TJnM9P7Pi4ugxJsWmzS155PJzX5WrUuVZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=USiTqHjoR4aDOk1Wz4Y/dJIxO2KLZkOMsBa+6yGnR2R6rMTHV8dXxFf7DjXkMUhek0bJmygCmW0Do1VYS67V3zR8qdYFssq9OJoXrWtP8G6h+BzoSGovUtWZdADmbUoASOcTQeWH74z6KBh1ca1jlTpAzpikTKlNq15fhiqgHok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ol47/nWk; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b06bb80d7dso8638896d6.0;
        Thu, 13 Jun 2024 15:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718318527; x=1718923327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RADoyJ/UBTliEUUfZ92D6TpXqH7TNpUCBsNp/aY0Wgk=;
        b=Ol47/nWkXLwkabnCh9m1lSXCBEoUuhtJ/HRGUpWgIvBXIJN3xrFfVoG1BYFddSO9Yx
         tRtYlYceFzPS5AnCBgB5fZNsLlh9nf0cSLEVWPvW/0WFf4daPsO2nK0LXBvIum/3KIJ3
         QKU4KqOujEEF1AT/8NGAhwhyOqnNFD2a9HiizNmj56E/wD3ofD60/rktsPfWoIyZ7q5m
         MCF1oGgjmY1KoSF8cHDJgtXuWxLIkgDvYyUkfuDuc/Gt1ODpp4rwELZsIDzVn2ipkSCt
         YlAownAY8x/ojv4OrWLtUXavYTyUn96XK9EOYi1HYmOPDmRxG3El3t6JiUG+ddfHR6Fq
         JN9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718318527; x=1718923327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RADoyJ/UBTliEUUfZ92D6TpXqH7TNpUCBsNp/aY0Wgk=;
        b=XapcH9XO2QnLH5255wAXWeYtchEgwnNsg9/AWhVKgDuNekUkFofnc+4Gb038c4beow
         7njsWd/VJsJaZTNroGVbYal/Q9kYz8F2eQLPgloq7Yzx1y9D5RRrYAA4efvo5xvQbRoq
         iLvISfQ3SexOab5NQ+7l8rnXfvox4YhPdz9F1Q1Zj3ddOTCppV6pQDOlWHfVylvPH2Nx
         aFprAX8LwqeEbeJR5LvvXBE3PIOflERODZJqSvcsIH4Gxx8jnaXL95vtbYiQHO1hhILj
         8hrB6UEQkYqPnVbPeN9f9XGGiIUc8C2zAATiywEuALTFZQRtrGsirbVacrWLhrYTniBV
         alUg==
X-Forwarded-Encrypted: i=1; AJvYcCUEKlGSTiOM2wBp9lpeibv5W7yXWHS7ky0Zt5hyqhwhBBgQ7bUTMjMEnlTjS+kBaiyxgiO4yfrHdhOF4uzUaeuigs8MH/0E/5yGOutEKq39kropdAc32ZNu3AAkVXHJZfmh0c0Gd7Fd/CFIrcbtjVL0b5KPAmafrIIh7vpylxj9zyyR
X-Gm-Message-State: AOJu0YysQnz6xHpZpPNcLQKoeMMyI/EYve8pfALLGnyEM5EcWojo8VZ3
	pgWqM+0+rZ0RE8WFX780tSqSUvGoUEoVElDZE9vs54Q6eyG0iP2q
X-Google-Smtp-Source: AGHT+IEvJUkiUU6NyCdMVTVPHtaHLCBaU2pS7oRvikAM5BVjCQa8Q1BlYvtY0VSCZbpQCjXJft2Kwg==
X-Received: by 2002:ad4:580b:0:b0:6b0:86ab:feaf with SMTP id 6a1803df08f44-6b2afd5b8b3mr9686656d6.48.1718318527218;
        Thu, 13 Jun 2024 15:42:07 -0700 (PDT)
Received: from sheun-Legion-5-15IAH7H.phub.net.cable.rogers.com ([2607:fea8:bad7:5400:c491:4bd0:7cc:377d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c1064dsm11488326d6.31.2024.06.13.15.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 15:42:06 -0700 (PDT)
From: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com
Subject: [PATCH] dt-bindings: thermal: convert hisilicon-thermal.txt to dt-schema
Date: Thu, 13 Jun 2024 18:42:03 -0400
Message-ID: <20240613224204.185844-1-abdulrasaqolawani@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the hisilicon SoCs tsensor txt bindings to dt-schema

Signed-off-by: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>
---
Validated with dtschema and tested against `hi3660-hikey960.dts`

 .../bindings/thermal/hisilicon-thermal.txt    | 32 ---------
 .../bindings/thermal/hisilicon-thermal.yaml   | 71 +++++++++++++++++++
 2 files changed, 71 insertions(+), 32 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/hisilicon-thermal.yaml

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
diff --git a/Documentation/devicetree/bindings/thermal/hisilicon-thermal.yaml b/Documentation/devicetree/bindings/thermal/hisilicon-thermal.yaml
new file mode 100644
index 000000000000..56ded6ebe1b2
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/hisilicon-thermal.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/hisilicon-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Temperature Sensor on hisilicon SoCs
+
+maintainers:
+  - Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - hisilicon,tsensor
+          - hisilicon,hi3660-tsensor
+
+  reg:
+    description: physical base address of thermal sensor and length of memory mapped region.
+    minItems: 1
+    maxItems: 2
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: thermal_clk
+
+  interrupts:
+    description:
+      The interrupt number to the cpu. Defines the interrupt used
+      by /SOCTHERM/tsensor.
+    maxItems: 1
+
+  # See Documentation/devicetree/bindings/thermal/thermal-sensor.yaml for details
+  '#thermal-sensor-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - '#thermal-sensor-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/hi6220-clock.h>
+
+     // for Hi6220:
+     tsensor: tsensor@0,f7030700 {
+     compatible = "hisilicon,tsensor";
+     reg = <0x0 0xf7030700 0x0 0x1000>;
+     interrupts = <0 7 0x4>;
+     clocks = <&sys_ctrl HI6220_TSENSOR_CLK>;
+     clock-names = "thermal_clk";
+     #thermal-sensor-cells = <1>;
+     };
+
+     // for Hi3660:
+     tsensor1: tsensor@fff30000 {
+     compatible = "hisilicon,hi3660-tsensor";
+     reg = <0x0 0xfff30000 0x0 0x1000>;
+     interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
+     #thermal-sensor-cells = <1>;
+     };
+
-- 
2.43.0


