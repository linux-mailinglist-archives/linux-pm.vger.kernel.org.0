Return-Path: <linux-pm+bounces-29193-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4478FAE2AF3
	for <lists+linux-pm@lfdr.de>; Sat, 21 Jun 2025 20:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C85521769F0
	for <lists+linux-pm@lfdr.de>; Sat, 21 Jun 2025 18:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBB626A1AA;
	Sat, 21 Jun 2025 18:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4OiAM6s"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ADB1F4CBD;
	Sat, 21 Jun 2025 18:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750529031; cv=none; b=WbdoqZZGioX+f+tpFyZlLja2npYl42kHUYdiVembLaTjFnpKDDUk+tx7EIDdz2sqm/aMche6sCrelpOT26n4sPh5agxssqTjL+gvQa6NY3io1gRtAqJKypq4+jBvAKOc2BpVFOgnikiPjHlI5a0JhfJqUZ4+ukwyrGZf8iLTFCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750529031; c=relaxed/simple;
	bh=1UXgOknVeCFRMsB+NlQ3rDYA4BCzukd/eLxXcIj4A48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nc+OOvF1LcTRU+E74TpDuB0wU2gMlTma2a43JDLPffXLZFk1C1dyAREz6hKCFGOyrtNCZ7hFiw4UhqszMwwaiIImCvi+wFmDJwr7KxFlp5Ir6VXzbjqbMcK+1sRkmYyLuk1EUGyMl5XJ9B/DyLXv3LwWuyfIippCf4dnnaIUqu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4OiAM6s; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-735a53ef4feso2069714a34.0;
        Sat, 21 Jun 2025 11:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750529028; x=1751133828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4Gq1SBjrOYc646ur4hahi6Z9le2MFhsfRKOcTdYR/s=;
        b=P4OiAM6sBNkDsUSKcItIi+vAG+I7oY9S2lgGpHf1uoG4DY0yxwH2EN9u7j2e5WBZXQ
         YSkLp7GpHBtUsHzLACicS89MMa9+Pf+A2l+NGIFoYp5iJviEq2yiRrs8zytR4e1z4Ydj
         PzGaiTbTQgpLtMMFOh5arSXRooePOceRA6ng0vzCQRmlLjOMm+V2XuhRyncCuRsBYsDH
         Q84I2p2wUinD8HZUK3+G8B0J/Nf6qQoBTcRhx0OOFfsIxKZktgXDAtV0yOAHJvzSdpMs
         qeNlfn7D9VFCWwMaoEoZhBJH08l0lPe7pXPiOVjB3QIbEx/9oor60Cy9CrO8ZQu8t0hH
         x/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750529028; x=1751133828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y4Gq1SBjrOYc646ur4hahi6Z9le2MFhsfRKOcTdYR/s=;
        b=KwF8brfdOe2r+QVPvGx/FxkCODun/Lh0JDROLk8P5omf1w6V78Vaxju6r8YYCzW+dj
         DEOm5SSsR/vR4GBmrhckO3N4w0VQIIGg+jO6ZP8pl6on2CL8GJwIWDDOYp2b1gNSqmoc
         c9Sy6sbc7wjJNy2NMJhtFFOQS/inazuMNVC+ZL++hbo6TsmTfwdlJGGaAotPTBUaq2oo
         fxWUGncZar8FtJXxFyBDJ0+qqEHpMZe3DoEUY/9lDxfdLvZ4RQduo5FwfuZU9xtQ+wq1
         O/JhGu5mmBc2elOe4+h646sOgluAORhvlqynkz+Yp9w5lgROjQggFxDf9016uE7rmz66
         P3rQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSTD3n0VUsy97ZW0YoTJx5UPDAeo4t8j2sKZO52pAP1mpfgQ44nalmxKLd68B+zRU8GxJx6dwGHtaO@vger.kernel.org
X-Gm-Message-State: AOJu0YyszKrHI/wM/GPcQPPYCYJhDDO0b5AHyANumkmQbPIRYNYzlx4c
	XOa0ctu1x4pLTri1Nhlk4Su7QCgjG0Trl7eH7p/P6HtRB69ExJ44HJ5Vocgzlw==
X-Gm-Gg: ASbGnctAGb9g3dNK69I/k4T/3R3/YUwuinIOciO7xCBLKdfAFfyC6BGBLBDRC8VCWbT
	WQX9NMWjUaZRqCgLtjAMMihOX3YzSTvztWkcPUg9GU+ov2ft5Egk77uRynE3x88w2NlmRrh3Pj8
	xxCRp8Z1f9/zuHqIrSgvWD73uIxTKYj8TFmmCzbUIgdLKOLqrBMC1zUlcsUwOpFRwtyu6tAF2wJ
	J2jJWYz9fE4JSvHxodAFn0BaHEW1xvPlAP5zMpgCs9CJALSGABJ7wG/P1A1rLUBUiJaPSUYyxT1
	rShOWZQInqybu5dAIEo9sK38/XNWCuBQ93Wv0nfFfhax8tj0sOq9igvIPPvBQkfy8N6xy8o=
X-Google-Smtp-Source: AGHT+IGAz59q9ITvjFFtDnoqT64AfQ1+JJ8gmFMwBnIyV/T34ES1ka9yICRj7qrFh+7lVjAb9JWL9w==
X-Received: by 2002:a05:6830:8208:b0:72a:f44b:13ed with SMTP id 46e09a7af769-73a91a7825cmr3939211a34.2.1750529028326;
        Sat, 21 Jun 2025 11:03:48 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73a90ca8707sm782895a34.46.2025.06.21.11.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jun 2025 11:03:47 -0700 (PDT)
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
Subject: [PATCH V2 1/5] dt-bindings: mfd: ti,bq25703a: Add TI BQ25703A Charger
Date: Sat, 21 Jun 2025 13:01:15 -0500
Message-ID: <20250621180119.163423-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621180119.163423-1-macroalpha82@gmail.com>
References: <20250621180119.163423-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Document the Texas instruments BQ25703A series of charger managers/
buck/boost regulators.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../devicetree/bindings/mfd/ti,bq25703a.yaml  | 123 ++++++++++++++++++
 1 file changed, 123 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml

diff --git a/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml b/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
new file mode 100644
index 000000000000..baaeadc2a3ab
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
@@ -0,0 +1,123 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/ti,bq25703a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: BQ25703A Charger Manager/Buck/Boost Converter
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
+      The phandle for a power supply that provides input power.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  monitored-battery:
+    description:
+      The phandle for a simple-battery connected to this gauge.
+      A minimum of constant-charge-current-max-microamp,
+      constant-charge-voltage-max-microvolt, and
+      voltage-min-design-microvolt are required.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  input-current-limit-microamp:
+    description:
+      Maximum total input current allowed used for both charging and
+      powering the device.
+    minimum: 50000
+    maximum: 6400000
+    default: 3250000
+
+  regulators:
+    type: object
+    additionalProperties: false
+    description:
+      Boost converter regulator output of bq257xx.
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
+        additionalProperties: false
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
+  - input-current-limit-microamp
+  - monitored-battery
+  - power-supplies
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
+        bq25703: charger@6b {
+            compatible = "ti,bq25703a";
+            reg = <0x6b>;
+            input-current-limit-microamp = <5000000>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <RK_PD5 IRQ_TYPE_LEVEL_LOW>;
+            monitored-battery = <&battery>;
+            power-supplies = <&fusb302>;
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
2.43.0


