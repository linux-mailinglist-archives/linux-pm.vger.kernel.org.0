Return-Path: <linux-pm+bounces-13191-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9E8965204
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 23:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 079A4285045
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 21:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F65F18C009;
	Thu, 29 Aug 2024 21:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4r4nWb0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC6A1411EE;
	Thu, 29 Aug 2024 21:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724967208; cv=none; b=TxAV5tJpwQ7r2E9CSVpbeGzBc3hCqX/dmYXvW9ElzYo28buJxFwns1H6RkXhgy2V+ZG+85MU5nhHsddeWCc7QZrXQ3PmvRHnxmW2NjW6hZRGxAfzEj0Uqx4lB1rcHqDXxRVwfepZkoFegDw7IJK2BhExs+T0v7EuJBNrd8yl9mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724967208; c=relaxed/simple;
	bh=eVqTviXo8V6cwFH8hK97qRzQBwoSafV5MfsrLyhgPco=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UoxhOcXtFX3FxRkbgeEtcCBKVL9vHd7LD1itamOyEB5jE4p95quf7MzCZu9D3gmDvQ40zS1vA46b/zzOV9qsUo2hYTA49h4zxoa/xWLVmSyQxTg7bTUmG93IIyCZmnWuNewNBkj4uhbHoTK7S75qZ6za6KafrUlqX3mLlh4yY7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4r4nWb0; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3df06040fa6so653831b6e.3;
        Thu, 29 Aug 2024 14:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724967205; x=1725572005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/l6Vuy6Yja6nMfuFm5IV/CQv24CYeSkA0vOpwlyExA=;
        b=X4r4nWb0qp/+9mZDev4lYJESMb1nOBJwjsDyEzLWZYbWYF4WkVrzvT5r+CKG5Kgfye
         4AtfJJMT2Ag0sD7v8cgtwDvFUGQu+QJ4kQdBEjP4NH6dXtK+zCXxi05Dgt89euoLr2fQ
         7jKYc7KPdQQKjnJJbAr4c17983dlFNuaPPS1VzbFVMaQo9qPBs2n6NFpuVl9Jdt5T8Sm
         wenvhiCE5eHxQZ2OkxCrWrcNMY5IXL0e5ad0jtsCJvbLLtiAHl310llwiw/x6mueZkdt
         FMO9KkCZY0mzj3oDqYXWUmQWVCLYOLOVdixlGbIzNGNits313MMcFDFuFtWflxii6gXh
         CUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724967205; x=1725572005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/l6Vuy6Yja6nMfuFm5IV/CQv24CYeSkA0vOpwlyExA=;
        b=HfF1k7y1NeuY3D5bJCHEVDUk8RPn3DAWQ88vPnlGuON6uaR9Wt8ABZ/eVQCxXdpFmM
         Uj5I7Makygz6aPXEvixKcbGtsmGNAzNt9oWZsDkhZsDCk7WhzKnYbaYVM6uckzCAWqkA
         VSBoEchUiFB6H21NfyE14D3MOGhwHWm4EzrQddudlfSlCUQ00c59XdeiKeqLDLvbDTP4
         A3qF1xUnEB97cfOBj0eQXcfbmrgVaLWl2iTEltVGDXNMZlyxuGL/zFlEIx+27qFCqbLv
         hzau/CSn7JMnkARcyklccFQCF8vv3Ek+4Y86OmWrqssNs/Q1qhS+1v8rcnrU/ZpCMMVP
         3V4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVoNyd/TY9IQfoc+Pa3ikKxkgTLuzWc6dfn3/f/6xFexOtFVQpwn4sZY1FDMXuRY649sMkKXZ8pzWs8@vger.kernel.org
X-Gm-Message-State: AOJu0YwdNasb83d9Vhf3xC5AJo+Ze1w3i2LHBbnyrpegaZW7bBxHdIJT
	w8VOINisaq9+KMWHtrod7tQIdRJKETz44/+fwlXWXQ2vn2huBxV3Zhy4hg==
X-Google-Smtp-Source: AGHT+IEWu+O+TSKWVKhbXLuQSSvCgo+TCWgZ3yKoVGpE8zXP4ZswpIwCFYRo+byFPALHaw73+yBZuw==
X-Received: by 2002:a05:6808:238b:b0:3da:b3c2:b4c0 with SMTP id 5614622812f47-3df05ec779emr4477287b6e.31.1724967205478;
        Thu, 29 Aug 2024 14:33:25 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3df11865de3sm93097b6e.42.2024.08.29.14.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 14:33:25 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-pm@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	broonie@kernel.org,
	lgirdwood@gmail.com,
	sre@kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lee@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [RFC 1/5] dt-bindings: mfd: ti,bq25703a: Add TI BQ25703A Charger
Date: Thu, 29 Aug 2024 16:30:58 -0500
Message-Id: <20240829213102.448047-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829213102.448047-1-macroalpha82@gmail.com>
References: <20240829213102.448047-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Document the Texas instruments BQ25703 series of charger managers/
buck/boost regulators.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../devicetree/bindings/mfd/ti,bq25703a.yaml  | 143 ++++++++++++++++++
 1 file changed, 143 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml

diff --git a/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml b/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
new file mode 100644
index 000000000000..e555aa60f9ad
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
@@ -0,0 +1,143 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/ti,bq25703a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: BQ25703 Charger Manager/Buck/Boost Converter
+
+maintainers:
+  - Chris Morgan <macromorgan@hotmail.com>
+
+properties:
+  compatible:
+    const: ti,bq25703a
+
+  reg:
+    const: 0x6b
+    description: I2C slave address
+
+  interrupts:
+    maxItems: 1
+
+  power-supplies:
+    description:
+      phandle of the power supply that provides input power
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  ti,charge-current:
+    description:
+      maximum current to apply to charging the battery
+    minimum: 0
+    maximum: 8128000
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  ti,current-limit:
+    description:
+      maximum total input current allowed
+    minimum: 50000
+    maximum: 6400000
+    default: 3250000
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  ti,max-charge-voltage:
+    description:
+      maximum voltage to apply to charging the battery
+    minimum: 1024000
+    maximum: 19200000
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  ti,minimum-sys-voltage:
+    description:
+      minimum system voltage while on battery power, with default value
+      depending based on cell configuration
+    minimum: 1024000
+    maximum: 16128000
+    default:
+      enum: [3584000, 6144000, 9216000, 16128000]
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  regulators:
+    type: object
+    additionalProperties: false
+    description:
+      Boost converter regulator output of bq257xx
+
+    properties:
+      "usb-otg-vbus":
+        type: object
+        $ref: /schemas/regulator/regulator.yaml
+
+        properties:
+          regulator-name: true
+          regulator-min-microamp:
+            minimum: 0
+            maximum: 6350000
+          regulator-max-microamp:
+            minimum: 0
+            maximum: 6350000
+          regulator-min-microvolt:
+            minimum: 4480000
+            maximum: 20800000
+          regulator-max-microvolt:
+            minimum: 4480000
+            maximum: 20800000
+          enable-gpios:
+            description:
+              The BQ25703 may require both a register write and a GPIO
+              toggle to enable the boost regulator.
+
+        additionalProperties: true
+
+        required:
+          - regulator-name
+          - regulator-min-microamp
+          - regulator-max-microamp
+          - regulator-min-microvolt
+          - regulator-max-microvolt
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - power-supplies
+  - ti,charge-current
+  - ti,current-limit
+  - ti,max-charge-voltage
+  - ti,minimum-sys-voltage
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/pinctrl/rockchip.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        bq25703: bq25703@6b {
+            compatible = "ti,bq25703a";
+            reg = <0x6b>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <RK_PD5 IRQ_TYPE_LEVEL_LOW>;
+            power-supplies = <&fusb302>;
+            ti,charge-current = <2500000>;
+            ti,current-limit = <5000000>;
+            ti,max-charge-voltage = <8750000>;
+            ti,minimum-sys-voltage = <7400000>;
+
+            regulators {
+                usb_otg_vbus: usb-otg-vbus {
+                    enable-gpios = <&gpio4 RK_PA6 GPIO_ACTIVE_HIGH>;
+                    regulator-max-microamp = <960000>;
+                    regulator-max-microvolt = <5088000>;
+                    regulator-min-microamp = <512000>;
+                    regulator-min-microvolt = <4992000>;
+                    regulator-name = "usb_otg_vbus";
+                };
+            };
+        };
+    };
+
+...
-- 
2.34.1


