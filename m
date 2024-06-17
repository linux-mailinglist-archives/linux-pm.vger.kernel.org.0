Return-Path: <linux-pm+bounces-9340-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6CE90B356
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 17:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D217C1C23C66
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 15:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17066145B37;
	Mon, 17 Jun 2024 14:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcH39vhQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9DE145353;
	Mon, 17 Jun 2024 14:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718633863; cv=none; b=mthJFnZvXfWyW1DVEBoDxMKFFgbJ9e8BeGf1cagLms3ENfY6WpIhmnQhg26Y8PYfcHj5eZwhVnop8Xh1dmtjdL68LqRcNjGcJrSe3cgvSoOWetr74slrxesFoVx6sBVePmQarxwEOY8np1g7lPO3WQZMDmIrUi7GXjYkSoEpLXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718633863; c=relaxed/simple;
	bh=unPUtePx4FTeKKBmH9jeU3M6vc1xY06k0mJbsHVvoRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=M5XDA+fHzrkdO/MCEvyG6smfy/r5Z1JVUsINgNQqx57H47MC0ogA74fmeqy8xrcSAFkZW4Sct1D5GUkPAEPWj0O8Wfn7fTh0lhyNQoJVUtWWdqvb+waAAGj+g0W4SiiDTIeHedt/Qb16PZfMARhqBXBlCag1Xa1vtmER5ikFpTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcH39vhQ; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6b0825b8421so28240426d6.1;
        Mon, 17 Jun 2024 07:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718633860; x=1719238660; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PaTJzZNQnKML5wOALCFr7UKAYUQ4uDtj0s8DKZQbERU=;
        b=XcH39vhQtX13VnD54uSBGNDU+sPcQNgf3ScXtCo9SQ7cCBWR6zJfXapwW59j93sec6
         r8+/Uq8dFIz5zFMuWWkMlKBPwv4/SxzbNIfS4WCRmgpYg0dM7Q0BV1ZRwI9iiu+rGQFD
         PmyAaei/VR/ELLBX2lOQ3jW0nzzJB670ESTGn5eo+TVYYZCj2iDfRYPDPLPncg1c69Dc
         0eudl/UMLof3TfNQjSQupowJu6GF+aG4CCcW/qYw0NvkrXHmSh1LLaUTaPaL/ikJcvpK
         tNl//zsDs7jYyTbbI8ve46y2ipIW2PvKU+3YPVLg9bRPb/lNUgZxqMoxIGOrWJ5R6fu0
         9x5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718633860; x=1719238660;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PaTJzZNQnKML5wOALCFr7UKAYUQ4uDtj0s8DKZQbERU=;
        b=pXALwu/XzAFbNJjrpss5vu2mboIQWARitdt2zErQ0yBrIIrIJTME5maGJtKIVPYOJ1
         a4rjbDudjF1KqprLPRcWbncUsBDd38bD+XDddOnQCYjP+zDS8Mon8GPSyJJ4IL5cie3Y
         qi77yuCq27DP/GVYMAX3Dn7rVVQ3o+7iciwyhY2dzU/xfj7gotF0Bj2d+e4YEZsVhO/0
         dogmTs/zEmdwpH2y4DZ+1oBS5/IC5Zg5ZQY9A1SNsipLY90KZ3Ye7CXHaW57mZowWScg
         W+2q82i64LFMi0wFtNlkL0uT/6HQV53y5NBpW1cKojSCzWUFydvdMqD/Yju8hguFySGW
         4GmA==
X-Forwarded-Encrypted: i=1; AJvYcCWT3GIia4WBWzE6mzXrEsnTZfjhn7K7uFJxVBvc5sYjknvxPgNdTTy26cNbZ22Wik99PVxeBpSmt7Pc7dO6WnPB02A7TF5BLVe25sYyEIxp7Xez1NQNuyH4UXW2rcmgaM0ZZ1axZWjmcdJTF9ZnkKvdzdn3lU9PQ9C2inmW25q5JD27
X-Gm-Message-State: AOJu0YwToUmeHH4NRQGBnxVV47wfY4VfAXD+x9WOxFNvOi0WbOh2UKnG
	efkWWcsJbKscM6zWvWeBPnqfhiRD9JleslrkuBo/qAdwCwM3Ob6d
X-Google-Smtp-Source: AGHT+IHqNA7Hy85okL7xpyZ/7QISvh1He39PSKvujADcfZY4+hL17fmwWnLS8hcrToZMOtjyQIcu7w==
X-Received: by 2002:a0c:e110:0:b0:6b2:5569:b383 with SMTP id 6a1803df08f44-6b2afd5b8f2mr103495526d6.43.1718633860123;
        Mon, 17 Jun 2024 07:17:40 -0700 (PDT)
Received: from [127.0.1.1] ([2607:fea8:bad7:5400:2557:2c70:d69f:574f])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5eb4a49sm55782976d6.96.2024.06.17.07.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 07:17:39 -0700 (PDT)
From: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>
Date: Mon, 17 Jun 2024 10:17:31 -0400
Subject: [PATCH v3] dt-bindings: thermal: convert hisilicon-thermal.txt to
 dt-schema
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-hisilicon-thermal-dt-bindings-conversion-v3-1-6d8d44f0fd74@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHpFcGYC/62QzQrCMBAGX0VydiV/TdWT7yE9pMm2XWhTSUtRS
 t/dtCh4VPA4H8sM7MwGjIQDO+9mFnGigfqQQO13zDU21AjkEzPJpeZGKGjSSUuuDzA2GDvbgh+
 hpOAp1AOkfcK4SkBZjUpoXnF7ZEl3i1jRfUtdi8RJNPbxsZUnua7viP4+MkkQgMa40mtVSX261
 J2l9uD6bm2+hPmPwkznGQqD3pTuP0LFhUOU6SPlh7BYluUJEKiy/4IBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718633858; l=3876;
 i=abdulrasaqolawani@gmail.com; s=20240613; h=from:subject:message-id;
 bh=unPUtePx4FTeKKBmH9jeU3M6vc1xY06k0mJbsHVvoRc=;
 b=sfv+x1m6NRbFhOkRfOAfvKc3Th6z3oLr3ZyWmva/FhRrqb91gfK+7+sNiJCLGG3Hj4U7rNwZI
 /Ulv3qtqF25BkcRjjUcwJtBzggAK7UooJG/d5e91V9spy26e2CAC99L
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


