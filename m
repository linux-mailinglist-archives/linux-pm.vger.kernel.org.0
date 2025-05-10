Return-Path: <linux-pm+bounces-26989-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89781AB24CE
	for <lists+linux-pm@lfdr.de>; Sat, 10 May 2025 19:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B9AB4A5DE3
	for <lists+linux-pm@lfdr.de>; Sat, 10 May 2025 17:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C09243956;
	Sat, 10 May 2025 17:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8c7BKCt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF92231837;
	Sat, 10 May 2025 17:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746897943; cv=none; b=aqTRUmbDlpxOw5mEz24umUspGj2NwODVO2YuF1PGNlQPnMjY8XREhhUtP+MvDwhQoXPu84BUaNpEooqaj9Yw6r1zmzmy3q20AgNDr44TR8Zxc+SDf79XD8cWKWml9fFVAlZ/wFvLo3XhKjN9YD38lzl4lCcnVKTW9hAuv6WZ40M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746897943; c=relaxed/simple;
	bh=PVR2/5euqOuyaXdAuwW8N/x5gcI97G4iFgoEvQ6Vw9o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=pC0H24nS1BTzJQdY9myymJSahLKp/Q8nL+y23hrM+SSp6Pj+zWuNG95RfB1OZk1RRovb+wJ7vZ8xPkivU1O/C7OFCaMU/pNJx0vVFHSVeuke33RycQ2Dve4JaZDgxzjY7mz94P2NuAxvUtA4WQ5gsnkIsT2enTz5o80hmy/j6xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8c7BKCt; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3995ff6b066so1712278f8f.3;
        Sat, 10 May 2025 10:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746897940; x=1747502740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=loWaUTc3ItqSmmSDVC847qIYyYkmIRUdKWPahuJRyf0=;
        b=Y8c7BKCtGx2gO3tS/VeTYAd0ac+bya9uVNemUMCr8RefaiPr5U9RvtUpHix8LZ11RK
         ap4c6rlfo2SzPlqFqI7XQRgNCYAKLJtt4Hwa2eM/4jtXkhEo0vSzH+J1Fe4k9RKKLYS0
         NAYd2tOajmbF2yd76t1J3Ofk/pgCkcImsmBmOkXJ0mtexQyB8lWZ388FH5TPI6gtDc1R
         Kh5+09U1GpxLM4jjjLjJ3ErCTHJ+6sHO/sZQg9Vn/eiDkzJ322wyC7xgr4VUrL6B/Act
         8grA64PVUlyKnszMWc+7SyIVL+4nNTYGuiceckZIfBdZsMoUZIWVPav33eez6h0sOcCQ
         3UCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746897940; x=1747502740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=loWaUTc3ItqSmmSDVC847qIYyYkmIRUdKWPahuJRyf0=;
        b=R84cmP6+Ezmd9UPKxvYSWxLfXcx066PJGuV7L8hoDGNVmG+oGh7NeAg6F+rAT+g7ui
         PzUtjuKNKlgslUay7h2GEHNBxHvRR41DtPZYy+qIZ3luqppDEWg5z5TwqlGK22KiJHqp
         8odVdFBabFbuXDgE5oPGcVHC0ss39HSBiaCFuWn4i71TWA6SZPh80Gbup+R3iIcRDjPT
         dlzohC0pqUcVold50UnbZmTysciAcUpM7Iw+P8N9N1ejkqPo8tgc/RQNfXuL0C95kB/o
         /VkROV5lIbf6piQf5PZ+Chg+57Q0gindayoNEbz6q2CXnkYVrAbUU4fue0skGQKmu+tE
         JbJg==
X-Forwarded-Encrypted: i=1; AJvYcCUBwVGXoTFN4dgklmdyNjtGdJywvOjXRveu2FYyllfSxN97l0J9iSbQoCguUeIPVCDRqzq9kb3bXrnj@vger.kernel.org, AJvYcCXNOgebeYbeGPoXMWiPbLkMF9FBXjuWw5sB7AtyumvVYH/wYLjbsSCYQ6jFoBdiVoEG1dacHgGkJGQ=@vger.kernel.org, AJvYcCXp73BJzOwuFZM6v0wYurIhSYaf5h0FhUeTiopsZdU7PfpKmUu5jmzesjnlzTBIhHdXXzyYRr8f96763tIC@vger.kernel.org
X-Gm-Message-State: AOJu0YxCssrR7rPtrHQSo6FlnIch+vt1fcy4H2cEXHJNP8MfrkXOJu4n
	1o+UcrhAPKEnatbSkw16+SWqiWflVr/sds0XwXyVJ35w5AltsREU
X-Gm-Gg: ASbGnctm05to+r1bLFcs80leVukimcJOaxsODAa1472/FtkwUyQs7WOOaJGGNwUHF32
	hzmecYbwkmDeQ0bTAbrQ8kDeRO1/dlv6kRxjLfv4wJgy7ll+S6lug7tdZvLEk1MVys7l8qUcaIT
	51CavoKyzLAH2pbjSJyQoVDnRiJRjz6ViaNSXiDw7dtLmT3zYJTyzbs4ZITUpnwjq0pdilc0wDy
	aIhO1HRqHMyGaSQYmLVwvul/7gK9Q63uBNosTrOZlyudmwRvybGD209BdO0YhzCj0KxXWpuFYdA
	XSLvMhh8fjoWJTxUWEgpdkeP9qzOFI8AyTsMaNqtulvjHO+Rc2Y399Z8YO1qQRInklkGyhy88tc
	i1+2JdifnZkbM0XA78N2h
X-Google-Smtp-Source: AGHT+IGbq9qkv/gQaa4vYjk1kyBAHtxX/8ZAWD7AWGJwOJ9AAPk0sMxB6VvwhFWwD1gF6So1rIVe0g==
X-Received: by 2002:a5d:5f48:0:b0:3a0:8298:143d with SMTP id ffacd0b85a97d-3a1f647ae37mr6557233f8f.13.1746897939956;
        Sat, 10 May 2025 10:25:39 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a1f57dde6bsm7032009f8f.13.2025.05.10.10.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 10:25:39 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] dt-bindings: thermal: Add support for Airoha EN7581 thermal sensor
Date: Sat, 10 May 2025 19:25:01 +0200
Message-ID: <20250510172509.2547273-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Airoha EN7581 thermal sensor and monitor. This is a
simple sensor for the CPU or SoC Package that provide thermal sensor and
trip point for hot low and critical condition to fire interrupt and
react on the abnormal state.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
Changes v2:
- Add Reviewed-by tag

 .../thermal/airoha,en7581-thermal.yaml        | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/airoha,en7581-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/airoha,en7581-thermal.yaml b/Documentation/devicetree/bindings/thermal/airoha,en7581-thermal.yaml
new file mode 100644
index 000000000000..ca0242ef0378
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/airoha,en7581-thermal.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/airoha,en7581-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha EN7581 Thermal Sensor and Monitor
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+properties:
+  compatible:
+    const: airoha,en7581-thermal
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  airoha,chip-scu:
+    description: phandle to the chip SCU syscon
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  '#thermal-sensor-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - airoha,chip-scu
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    thermal-sensor@1efbd800 {
+        compatible = "airoha,en7581-thermal";
+        reg = <0x1efbd000 0xd5c>;
+        interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+        airoha,chip-scu = <&chip_scu>;
+
+        #thermal-sensor-cells = <0>;
+    };
-- 
2.48.1


