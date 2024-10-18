Return-Path: <linux-pm+bounces-15946-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3929A3C02
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 12:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03A62B24A78
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 10:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C452022F0;
	Fri, 18 Oct 2024 10:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMvYjveM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA472010FC;
	Fri, 18 Oct 2024 10:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248559; cv=none; b=vD4AMQ7xRyGWjtLRFvffAWH1Rqg7nQ5PPDsVDU2ISzfq+v0nzClf0SdnSnkrkl5DrbS0rpc182dEw2PRZZQIAE1FIHXwp4PyBDlVwe0DTyoyQ2TzUac8H5Kg33Isl5mNeoCg3ofvPk9UFv9NkuRI/YimtrnIR5wwSZ6OWkFjjO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248559; c=relaxed/simple;
	bh=RSdMFumWyD7Mx4sKNxKfjNlsDJaTB6uemxsTmcKyHuo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qLRxjkJmxG3b/XPrWKB91wTQf8D0+ky4zZetx12dhWzKsPS/ntPxWvoCnwrNaUw3ns/FT44tyrlx4nYYLvbNaJQjzwMjaxsHn/YRXvH3fBlVp79Oi2pJvvdUKNurAkMwclrIELDvMn9Lg9NFYS8JKApEbnFY0boXw/9wMDqEIIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMvYjveM; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d4c1b1455so1480416f8f.3;
        Fri, 18 Oct 2024 03:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729248556; x=1729853356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NRHQQGm7cGssgdoLEtNCNKA/IiRlPKI/cHGPt5rH+50=;
        b=kMvYjveMotunGr76a6OsgU1LFpRaH3V8PBaOZb4UXj74nwe6Zk6cR1gTHeeXY/cjeY
         eoJSmFxrBdr0PO9i2cLdmGyo4wRFQJneAhT/+1/Df/QtsY0JWljeUEWjOSz9GJyalMp1
         h5mj3cc+6kjyyfAQ8dUYOrj8UCikoVJdkZbt/iXKkW+KSQ5ILNFhmSA6xqqse7jpWpc1
         SLMk7MgW1JFgKjNGgOlm+haL83EZDbsndkhDwvO3Evmaty3m9Mx03inEqBL1oRs21Cnl
         gXYItJFwP47gZBTaR33fzvvx8aD3kleCl72AN57aYXwrEFmyEreQZ0MUp+t83mF8RSiC
         40gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729248556; x=1729853356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NRHQQGm7cGssgdoLEtNCNKA/IiRlPKI/cHGPt5rH+50=;
        b=JE3r8ojcwRi4wq9CdNCelwyE2nwyEViJnZwJswmEOE1tjZCTAtayft26ZWMbbzMRli
         mXGKpi7pbcQsR5Y9QkpxT0shtMz+REvgLEbIcY3v3RT+BUsn+9+F8kgpnU/xJ31X5lYj
         e8i/ju/m2aQ4yFyZapVZYoGMlQ8JwSFttUrHhpssG8PXU2+cLOSQfUYUnhgYdRIYwKjR
         cCxFzbJcX8jV3qJEb9Waa+AG3QHShdAnWdWFVU7ZxypHC2vbT9AaM1vQ1oLqdBF7DRyl
         nJFdMblK3zHzPVI7Y/lpKxlWNXzQXQRSOSMQsV+6vM7rC62xfviLzsUOsZbY7Q4BSJRS
         bsuA==
X-Forwarded-Encrypted: i=1; AJvYcCUNPp1lGsiirXDQkI/LItMijBXBgioMfQs+g0uXEmpV8njf61laT4bcqXHNAudLCepq+Lkm7qr5Rvk5xTfB@vger.kernel.org, AJvYcCUU1qRZRqqYhiNaEHqfAEFjtxNMpQTkopcbxY7IdwgbxJhjCCfKsLbOAGNz2edQJ9pAfbtRFj7au/K0@vger.kernel.org, AJvYcCUc1hjiyEGoPK3k6qEa24qbwcK4TxfKd0JNKh0YINSJdAHr5ufyT8GriyDw7NqViTdJdKAmTmq9ym8=@vger.kernel.org
X-Gm-Message-State: AOJu0YykYN7+UIFD/XuNSahhBPs8Wfmq+5VehdY0hY8rM3QE4uHvEPqn
	tvLZgg/TZOfETYI7b2sat//pUKC5sod+fcD/MrjJwjrbNEBYqicA
X-Google-Smtp-Source: AGHT+IH8LYkBdN9+FI+6EBaR0iOr2VBsrCSKHDoBM+xZIc2oRAjfNBoXbr4SfQESdAqEnwFRN/G9IQ==
X-Received: by 2002:a5d:4ec9:0:b0:371:8319:4dcc with SMTP id ffacd0b85a97d-37eaa48f8b5mr1570068f8f.2.1729248555773;
        Fri, 18 Oct 2024 03:49:15 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37ecf0ed5f4sm1606240f8f.68.2024.10.18.03.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 03:49:15 -0700 (PDT)
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
	Lorenzo Bianconi <lorenzo@kernel.org>,
	upstream@airoha.com
Subject: [PATCH v3 1/3] dt-bindings: thermal: Add support for Airoha EN7581 thermal sensor
Date: Fri, 18 Oct 2024 12:48:04 +0200
Message-ID: <20241018104839.13296-1-ansuelsmth@gmail.com>
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


