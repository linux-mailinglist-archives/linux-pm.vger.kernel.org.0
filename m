Return-Path: <linux-pm+bounces-9524-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2623F90E1A2
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 04:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA541B20A6D
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 02:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4038127446;
	Wed, 19 Jun 2024 02:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHm9xAeZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3F22599;
	Wed, 19 Jun 2024 02:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718764300; cv=none; b=iO/eQtYb6wN/TgAge3cendE1+JQqVDdoyxOB93gYyJeY7Ty8Rfng/GYm6DRRhupAIIxSN2XMeZsmaoJgJIqRzYiv3Pa1PyEenjOBlpaKTldhK6nHuz8MyR0kWSJsf8ya4oDfRoxyCiOzCYyAS5lQNF3Im56qyE1mImxIWKFuM7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718764300; c=relaxed/simple;
	bh=tON+1ko1+L9sLXDmaPD3JWG8AGbdMBPXq8ldPeXQYsM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SLf0FIujXxD6uRY8i/oMt8qjd99o1P+XlDirWzxC0HL8DrYQyEzSxf+AgVmlNHo1eiQ5z/PCkGKN0xT68lUeyf3fzLq3TfCMlRhYYnf07lnOKcPEKEmKsLhVpzd0Qm1xlp40DNwTGFg0fEOO0jFF7Z670lzBjKIJNn4hPDxmxOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHm9xAeZ; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4405743ac19so3946521cf.0;
        Tue, 18 Jun 2024 19:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718764297; x=1719369097; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jJWducu000Gylf5XAOa8WIhgRCeIrgAnJZ+kHKrkDe0=;
        b=aHm9xAeZhjpoEwvCZLdh7hTZks5R4eqrFLAT4vQYmyZ4Lagr5X8DD+KNT1nhXGzIDb
         lCeukbuiABKa+ERIxOy+k9xOI3fhbUk/wn7/vtlQdY+6ILen4lmbytC6E6x/VeRV69JB
         0276vhA8sNpygbC87eP/aZOttH9QqFyrJsVkywanrZKjbM6Y+0jp3vFVKrofPPujXdT3
         CzZDqbROmpwU+NBGwCRkhdW8k/xOSFfwNLeAxPluG4zr3BCxX2cOGjMLhNdrnrSAvCxc
         RijUefiWMoHowNqWNcRw1UYJuHSOKIECAUPRcL4qjBGfWDvJt5TKTFxBrAp9Tz/CWc5b
         VUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718764297; x=1719369097;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jJWducu000Gylf5XAOa8WIhgRCeIrgAnJZ+kHKrkDe0=;
        b=v5f2BAoDJSgCJU0A20I3B+1X5APORLHrDROlJKc6jkOo1KgyurszQ0bqi16Blg3Sd7
         soJ4MmrPp6AfEkfL9vD3QefdkbVn3qH/LWLgAWTdd+DMCiDOiFej36LJE/sSa+wmfTed
         DN85ERwhzDGymTUSX8LkCJjZvXM7qzp0zY8Jw5sqvbXPwLM+7Cea8KoeDqz5+rm1Qq9/
         J0DKg6rgvq8Q879Yee+fOvZUqHAdbCvPPOD4fOjcx4C5/EK/5yAM9vO+2Dk8M0a7kocu
         XwQDCzjmKCPQ5zGNxnVelawgt6nIxKyhsmvYYvHm+QyJOOIzWYnYFNpKSW5FhouM24WX
         KJ5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPMDTvz2a+YQU2/3Ss0J768McAAQ/zOR8FX4ELdLK3rYw8VVYI7K4nNiqA8dU7vBEsOSMgZpGeERyfDEhyM6AMkR2F1bMFzskETFqbdOYUmKbUdC/mjQRIl1iY4QRtX0b3w+zT3ar0ImtCYneJmbd9lpgGkAOJKIBY3EghzDBdLH7U
X-Gm-Message-State: AOJu0YwcHKw6J30hiIx9BxTItokRQOnGyPGrlD0oRlNqfqWXZpJm/JqX
	2plb3dWUMS9YFBNu1BbyyqQo7ElPFCOd5WyX99F4aRenyVTSpzuy
X-Google-Smtp-Source: AGHT+IE+HAIxr8nOrosxxzcdbM00QsPfxTRPEYuk5G+mgX2XurEoYtjncDIdow1JK4U189/2i89J0A==
X-Received: by 2002:a05:622a:138b:b0:442:1204:5d72 with SMTP id d75a77b69052e-444a78dcc3fmr36077401cf.30.1718764297372;
        Tue, 18 Jun 2024 19:31:37 -0700 (PDT)
Received: from [127.0.1.1] ([2607:fea8:bad7:5400:f8a2:b06e:a96b:63dd])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441f2fceea3sm61651211cf.78.2024.06.18.19.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 19:31:36 -0700 (PDT)
From: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>
Date: Tue, 18 Jun 2024 22:31:35 -0400
Subject: [PATCH v4] dt-bindings: thermal: convert hisilicon-thermal.txt to
 dt-schema
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-hisilicon-thermal-dt-bindings-conversion-v4-1-7eba97fbe6d0@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAZDcmYC/63QS4rDMBAE0KsEraNBn7YUZ5V7DFno07IFthxkI
 yYE333kMANeJpBlNc0rqAeZMUecyfnwIBlLnOOUaoDjgbjepA5p9DUTwQQwxSXt68sQ3ZTo0mM
 ezUD9Qm1MPqZupvVeMG8IlQZQcmCBmROp3C1jiD/Pqu9rzRVapnx/NhexXf9L4PWSIiinqJSzH
 mQQ0F660cThy03j1vkH6jfBBnSDXKFX1n0GlIw7RFEXsZ8BEU1rXdM6rXfgtmuR+y3fgWWFlT9
 5gMCC17CH13X9BZ4krxksAgAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718764296; l=4182;
 i=abdulrasaqolawani@gmail.com; s=20240613; h=from:subject:message-id;
 bh=tON+1ko1+L9sLXDmaPD3JWG8AGbdMBPXq8ldPeXQYsM=;
 b=XKaE+TM/hnfwscXjITuSt+j4OEluklmc8wyfhJyQ6cuz6y4k7Flwt5XmRW3CLyrQlxYyu2MWd
 r2MWZcn91uDDcP706FFLsb4ecGT0mVgj+Lx8nqMkNm8AicLfjJqHlgu
X-Developer-Key: i=abdulrasaqolawani@gmail.com; a=ed25519;
 pk=cUqfinPW5pkopFB8ShBc0ZTNgYvSW5ZTa8aLIFPGp/w=

Convert the hisilicon SoCs tsensor txt bindings to dt-schema

Signed-off-by: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>
---
Changes in v4:
- Update the indentation for 'examples'.

- Link to v3: https://lore.kernel.org/all/71b58547-545e-4953-baa0-f3c6c8c3d2f9@kernel.org/

Changes in v3:
- Same as v2 

- Link to v2: https://lore.kernel.org/r/20240617-hisilicon-thermal-dt-bindings-conversion-v2-1-5eea9bc59c77@gmail.com

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
index 000000000000..11aca2b749d7
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
+    temperature-sensor@f7030700 {
+        compatible = "hisilicon,tsensor";
+        reg = <0xf7030700 0x1000>;
+        interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&sys_ctrl HI6220_TSENSOR_CLK>;
+        clock-names = "thermal_clk";
+        #thermal-sensor-cells = <1>;
+    };
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


