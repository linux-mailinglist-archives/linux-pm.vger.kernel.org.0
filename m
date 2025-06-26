Return-Path: <linux-pm+bounces-29615-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 840A0AEA77C
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 21:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD6E14E3B51
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 19:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C852F0056;
	Thu, 26 Jun 2025 19:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTvyvgIG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5B1253F3D;
	Thu, 26 Jun 2025 19:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750967769; cv=none; b=MpuNFkuKDtwMMGH9vYF4jcsaW+DVMkG9lCQD5uhz53L/bbkYkNTrlryEba/GovZrar3GLZ5RhjCwIbPbi9G6TeTmYbpila/M9mDJoufZ5tEAiG+ULckw7glcXu+t9rtqfBOK+gt8A+Ai1AYxleOdj//y6MLC4PgHe4KUBEr52sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750967769; c=relaxed/simple;
	bh=ivEmUEvnG2hulT0W4rNmSX8WOc9nuwfQ3yWX6e208nM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m1K7tQikX5wzVEwk51zYvFhOnifPcCt4wa5Bdl9DBlm2axAiCF4kpgfEqxS+qNbPifcxwDpTUSFpcayX19KvZVPWdqAtkEwvTJf4wCoyxW0kVkL9WmlvsHfagE//acqALp5fSLlnp1XIkrKMKiTP2A1/Xz7yEHmUtF29D2R7vVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTvyvgIG; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-610d87553b6so593471eaf.2;
        Thu, 26 Jun 2025 12:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750967767; x=1751572567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMpDCcFT/4xis8BHvECtD3Eg/SXcPfGFzJVSLI+fMms=;
        b=VTvyvgIGgj1R/FNJUiAMzvqlsM1+ZQyIVUmhjmwnKVakt9QJm0Q+95K+RgI2Rq/A92
         tx8lMWlG1zTIAXFtjujSgBLnBZmcyAKyvI+HgYkIgewC9vtiOropBya4M+lzJS80DKJt
         4PX9brcwS5i47pra2aXTYZ1F81WM0odC8KHkP03RklTGKZiMLRnKts4JKPL/joInFJ6T
         nwnWZsVmv81CnCD0n4kotA2+7g3p6bY2FU5J4CNdi0FUgxPMoa5TBQIiKRFH2eU6Xpo2
         5Wzne5okJ/de/Pwea+0OpyFodkxDm3GpjpLam2KsiAqEL3FO7ouep22tXg7l4NTMZMEY
         R/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750967767; x=1751572567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mMpDCcFT/4xis8BHvECtD3Eg/SXcPfGFzJVSLI+fMms=;
        b=JF6KyiBGjyfQq7OLRiuU0xgz/hE5s/SUQEoNNtY1KvD9UbrK+ryyeAVxNBrk4ie0gL
         trCuRqUCSUx7YaNO8EG850L6nVQmOs+Nneb29QZJB+rtIid+ITCewEvfpCNaEvAZFfum
         9KB6dx6U3uQd9QthjofwuEPY8ECdXkJUGiXDgiccS+Q04KK5g2dNCE0SsDgDNFLiFki6
         H7y3MAB3pdyfxs8Ds4zS3VeyWiHGYaILkWjfqxQJc9VaQTMD3U+PfcWVlb2yTRjaSJVi
         kucRFOcpZdx2XPNkACpEAxOi6lanjI0KZEIxKvPBzinU1sWSSLiKCYRaaoPGB/Yyv3c6
         2CLw==
X-Forwarded-Encrypted: i=1; AJvYcCWfkE8Vxc00g7SnPUwyOFNLQw2ezTwxGe74jP/rbBlrciaUNoshbfJsIZoE2cvuzTWC1D9hR+Yh/jSS@vger.kernel.org
X-Gm-Message-State: AOJu0YzICLF1JWAQ/NrgZ0p9C2Gfbo/BVHeuTPb8DqX/7YicJFjgnScl
	0PYT258PUsB69VUmS7eiER91XeX0TpoUoTo3MTNryL9wEwEP+NZ8i037S1hVAQ==
X-Gm-Gg: ASbGncsnC6flm13GuPFUdPiswNOg+M7rgTElxzCC79TA8zU2jHClVDSGFs9s4EnyPwV
	npATjjb9ryvD5ZbOoiMEvHtNZKdF55XfSXOPWQqt9iJKVyuF5T4+xZzmaMKJAM0PiShDSwod2Rk
	fP+cNTn/m3PevXvaRN3FJnrsFBrxzFERql1DZxcmBYTZWd8yqn2NB/JK3MvjK6vZElp49X+KL8v
	I2ihLGp4j54gnDG6r4WDcPP4nN2/rrheIErnAuP8p3sb/BrjxdmogZDut2Dfwf1HBKViogMpMRv
	5yccHazoiRhAymce+WM5vv6OCzy7q6GJwBc+F2zyqX2sOgg4WQAIbW1zp/2ri8DOz/OicGlXIeP
	Vw+PNbg==
X-Google-Smtp-Source: AGHT+IFAMSEfVKviYPBWYLsf7KJQHEh6Idjewbd6Ne+/AzGsF/wbxKbNMnjZ7XUV9beM5fyeH9i+Qg==
X-Received: by 2002:a05:6820:1798:b0:611:641a:9db3 with SMTP id 006d021491bc7-611b90ecfeemr599623eaf.7.1750967766656;
        Thu, 26 Jun 2025 12:56:06 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:f978:7e9c:c207:c035])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-611b8582352sm66915eaf.22.2025.06.26.12.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 12:56:06 -0700 (PDT)
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
Subject: [PATCH V4 1/5] dt-bindings: mfd: ti,bq25703a: Add TI BQ25703A Charger
Date: Thu, 26 Jun 2025 14:53:39 -0500
Message-ID: <20250626195343.54653-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250626195343.54653-1-macroalpha82@gmail.com>
References: <20250626195343.54653-1-macroalpha82@gmail.com>
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
 .../devicetree/bindings/mfd/ti,bq25703a.yaml  | 117 ++++++++++++++++++
 1 file changed, 117 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml

diff --git a/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml b/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
new file mode 100644
index 000000000000..ba14663c9266
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
@@ -0,0 +1,117 @@
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
+allOf:
+  - $ref: /schemas/power/supply/power-supply.yaml#
+
+properties:
+  compatible:
+    const: ti,bq25703a
+
+  reg:
+    const: 0x6b
+
+  input-current-limit-microamp:
+    description:
+      Maximum total input current allowed used for both charging and
+      powering the device.
+    minimum: 50000
+    maximum: 6400000
+    default: 3250000
+
+  interrupts:
+    maxItems: 1
+
+  monitored-battery:
+    description:
+      A minimum of constant-charge-current-max-microamp,
+      constant-charge-voltage-max-microvolt, and
+      voltage-min-design-microvolt are required.
+
+  regulators:
+    type: object
+    additionalProperties: false
+    description:
+      Boost converter regulator output of bq257xx.
+
+    properties:
+      vbus:
+        type: object
+        $ref: /schemas/regulator/regulator.yaml
+        additionalProperties: false
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
+        required:
+          - regulator-name
+          - regulator-min-microamp
+          - regulator-max-microamp
+          - regulator-min-microvolt
+          - regulator-max-microvolt
+
+unevaluatedProperties: false
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
+                usb_otg_vbus: vbus {
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


