Return-Path: <linux-pm+bounces-31291-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5887B0E225
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 18:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E555189021C
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 16:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7A427E071;
	Tue, 22 Jul 2025 16:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFbmZZoO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA7A27A462;
	Tue, 22 Jul 2025 16:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753203039; cv=none; b=kCHZU4Bu/AIQyE2rX657yyh5YltdLk0Saot+09MU64O3XQaNOJG8imGI+ZE34aQO7mDXy3lWZY9aloZRAJuy852d25K7LJlfRxmK33gyg+tSVkKhA1q9E2CtYF2Pf/Evspw9GqAN2YbQqkJcGJoB9USebsa5rZCgIQqBnFBi16c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753203039; c=relaxed/simple;
	bh=30AneE3GLPOCsop/jgx4q6DCQawTpvUtEEBBU4gYbo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KYwg5cK6gwejEzRP3GLkHQbmNHROkZXbBil+9RxLmhfu5hd7LFlto2pZaQJD+Z4oTHFBr4LKo4jjY1tAcmPM2osBCB1ZTFmFCrYHmTIlv/rBTJP7SlLlUjcOVUGTcXE6q3dPst35g8odkBel4Xgh0p8Yosq5wKzh3CoameX8xdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFbmZZoO; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-41b309ce799so4014631b6e.2;
        Tue, 22 Jul 2025 09:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753203036; x=1753807836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwhaNZ08bBHEsR9rXeumkyMkgjmU5QxiFqlW2m7YgJA=;
        b=OFbmZZoOquIsfLx50E1xKHK/DN2gsnWWqMo3bESNM9uFe3YpAc+MrcQhOwTpB2CeUX
         HJ+UxfORp0hAkr5Qrwj7Q3lpEpbRXxOSkYymdP38A714r8EQUdzOTLqMvhaS1XS4yQcS
         wEo0fyT1X+Vct+PtJR64S/iZkW5DHV8mjmSTTgbHHdizh/0BDi3IxNYnC83K0nhMiEKq
         IdNav4of/K1a7hdg7nWURP7ZcIyTqCTi7jpz/IYdeJ4h8czz6Rqod2Zvgwt9bLLJ5g5U
         bjz+lCEQXqfDzMK6Sg33p5+VI/jxgorTisZF3KnmkP7ff6Mj7UvmC4r8F+FclZlNFNNO
         cLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753203036; x=1753807836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rwhaNZ08bBHEsR9rXeumkyMkgjmU5QxiFqlW2m7YgJA=;
        b=d9q/Kk4d+HXcSes3P7VO6b6nwK/uQIV2Av/D4YQrxEyfmX1bxAhJ/vJ+QYQuu5R/hP
         36E66ZBQsY7uMoAzk9qFpyoejKYecyLLlMvjEMMKAZyUjjn0svEWIxV+L9iOjEFuQ37y
         iuR26MSqrOV1vas6u9OUI3AUvf1MYyPx3svqHi0oVXdkCqg0W+z1IhMRCrkIap7CpZRb
         Pxs487S/e9pTE5+KpZHyAsulX/0mGFVI6zDeFJalHlAfEtIOgo/VrOXH47G6wxxAVVKh
         x8glMviPezjFy/ZuxZYzHHSLWqwMHtEnaoZvtPMwapcCFhz0VRl/arIk4PQ+YQvdrzop
         8kbg==
X-Forwarded-Encrypted: i=1; AJvYcCUOBVi72x15daVIZvaf3khLztiRf4qUh7wcCCI6wDY/3EYjU8OotIdiP0/cpTD6gT6KTaQLjTJ1pbkL@vger.kernel.org
X-Gm-Message-State: AOJu0Yzaz7/kh9c1071b/vNw724d3Z1sDM3P6hkkMThkaa0cBsWcTlRN
	YlmGqt3BgepS0XH2eWdM81yA3p7akUtxpH+IB5qBFskvCDotVEHCkcLYEOHj9g==
X-Gm-Gg: ASbGncvDcuDdTzU6RNosq23w0zqg1ak0v3okECvwWrZajPkXCM8XUtmAODr5/W2usZk
	cA3BQi7uaTyhAUw+ZDicHgrSAKDGUc2Bbr8ILyxeLh/p1XIRpH1nDJH8JGEPmpxcwGf5AjwjIV5
	xj3XkkLChXlosR+cmp5YLGf7GA9SvQ53tU5JE5RUUTWbYCeFwJOc2hv+H1XNk7T2wll25CVuLVX
	deSO4N4MNztWQntlgG5x28nFHU4BGe1H1P0OCpJ1i+dqYO5LcI/xXI4QoVs8YqbZcgjNBkKJPW0
	DqIR4nUtpdrQzvBY7sAyYxM5LQXnHOCGjLUqn1p2lica6RSfyhuf/xs2XgfcTZ2zj2Jdp9EcrPO
	SdEcyVEtmZIgGYwbMFs0eKeFIVslvSrzvYqcQaEL6fw==
X-Google-Smtp-Source: AGHT+IFvyhKDm2vjt3qbNveipU06hYF+b/GBJZQY4ZrBYhcW8LzR1y78N4yFBsC0SSxFw6knLZTQXA==
X-Received: by 2002:a05:6808:221f:b0:406:794b:462 with SMTP id 5614622812f47-426b6ef2e6fmr16756b6e.0.1753203035947;
        Tue, 22 Jul 2025 09:50:35 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:a130:f3a0:d203:abc8])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-41fd59531d8sm2935217b6e.42.2025.07.22.09.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 09:50:35 -0700 (PDT)
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
	Chris Morgan <macromorgan@hotmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/5] dt-bindings: mfd: ti,bq25703a: Add TI BQ25703A Charger
Date: Tue, 22 Jul 2025 11:48:08 -0500
Message-ID: <20250722164813.2110874-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250722164813.2110874-1-macroalpha82@gmail.com>
References: <20250722164813.2110874-1-macroalpha82@gmail.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


