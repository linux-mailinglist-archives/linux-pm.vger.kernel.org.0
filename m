Return-Path: <linux-pm+bounces-17578-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 119459C9414
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 22:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC82AB2678F
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 21:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7EB1AC429;
	Thu, 14 Nov 2024 21:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpAIzehH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE98F2905;
	Thu, 14 Nov 2024 21:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731619240; cv=none; b=gUWGUobELylzmQpx69UNH4kiptaOggRKOy4Quw1vlkog/Ql+myqwkOlXqt8KOYj9Pw5+CUoNWQJ9kosdJ0N6JOypR6Fi7zWJuUIF80wPYkEdypm/HQMMpjyOYPczongy4wHkHD9A/PLJQ5B7dYxeoWfVpz6E2BNugUrCffOcGIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731619240; c=relaxed/simple;
	bh=RSdMFumWyD7Mx4sKNxKfjNlsDJaTB6uemxsTmcKyHuo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ghySWJn6g7I75EWeqHSpvTqBMZkXUV0kTDYiRqLu/gUBBFeZ4aT8mkkJdGOAwlveGkXZ30qVpc7bzWeG4sQoa2xEB+lDSkqmQ8wdJm3Pq7US/X7s5tqbkQdXaapA6OBoza00LeDq7Ty3VunlWAqsQIDp47tytikj4d4k4fY7sVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpAIzehH; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-381ee2e10dfso658308f8f.0;
        Thu, 14 Nov 2024 13:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731619237; x=1732224037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NRHQQGm7cGssgdoLEtNCNKA/IiRlPKI/cHGPt5rH+50=;
        b=hpAIzehHe08InXCJTRTgNBnKU4Keet11Szsh3esc09GtTZ/96qOtzTrOBqAPNKiPsP
         UdDaoCW1XhgBPWsgPgsdowMWmSktaI6Wfcs5Ej2ug983u7SI1FkGZLsGZIM9XvOgQLQP
         58+1awpY4Gs40Gv2m99rbKryM6euMMeYgdawc+yRa0IEAMbzHdoJobuA6PBqZCsrnT9Z
         aUuuU6qU1KiR1ZLyvIA11rUWar6/81AzlNaeqWkBbWRLrTTYrujsOdGnAVuRsqJIVr/7
         /EtfdyRES+OQ6HjHgk5oZq6+Fdy+twmur8rZbwhX8uNBD8rT1AI/jkBCdXBaUmhFKtdU
         Xfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731619237; x=1732224037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NRHQQGm7cGssgdoLEtNCNKA/IiRlPKI/cHGPt5rH+50=;
        b=F1WnY8sqFpYXSZd/unrqTy5c9cTwBTHTeXdiv89NiLNPQhJk1U/Z7lFv6+hXVM2QKQ
         PsnrqZQ6gIB2N9M52oCRudXnqx9ZlbiArbsad61o3Qw2cq+pXpJ6wsiQ1/hJA0EJDdpi
         YjqP8mCP/WvygXTTsDSOcLiMTWy67hwRkVvs86P/UY9SK+iWnMsMpe/VbXFK9JNmB3qS
         1iQQbK2Vir3QgWl8+W+GkpB1d7NZyVDJnAZ9v2xixOWLihEFOJmYxp1ZovwpTk+sZXvN
         +Mf9hOKq2FywpoFPb1oWlvXBNh0u8PcxN0vttRoJTLLHd1ibEWTn6QqlApEwrO1Qs7mY
         F1sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbLII+tm1tqRW3wfUhAW7k1W6o/dJKLHZETjFJNIxR9cWirr0Y68Ewty45QKHQ/xe1+qjoDMnA4HIa+jj4@vger.kernel.org, AJvYcCUtMfklG4XIzMYZTrriumwJxLYm65qeobeBmPESPQDol3EXF/aylUSzBUdKciVjaYa4vfk7kyVe2Bg=@vger.kernel.org, AJvYcCWy2ibXLmS9kY1uMPzvgpwq62fa+HInftYnQV3izOU/tM7OiI9SQuvjv9bNOetDPUiwjxbjrVtbcs5f@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu4fKFoPxiNKCLQaM1Y09l4U8y1NnFXrS9pmTDltzZzemYLezi
	Be2l3iTzDRSlCS8M0/29UtYuIV2gazShhi36sN0eRloPk+GC9qPO
X-Google-Smtp-Source: AGHT+IH4eNfTBo347F2reziJ9J68i6vmkQGmWtEeQ0AaQ1477/sBXTHrQDRhtpu9S3WNFlj2rpIXiA==
X-Received: by 2002:a5d:6da8:0:b0:382:2553:dbc9 with SMTP id ffacd0b85a97d-38225a85e45mr159707f8f.32.1731619236812;
        Thu, 14 Nov 2024 13:20:36 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3821adad97csm2462236f8f.35.2024.11.14.13.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 13:20:36 -0800 (PST)
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
	linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: [PATCH v4 1/2] dt-bindings: thermal: Add support for Airoha EN7581 thermal sensor
Date: Thu, 14 Nov 2024 22:19:18 +0100
Message-ID: <20241114211958.32137-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
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
2.45.2


