Return-Path: <linux-pm+bounces-27024-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90575AB2A6F
	for <lists+linux-pm@lfdr.de>; Sun, 11 May 2025 20:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19E6E18971EF
	for <lists+linux-pm@lfdr.de>; Sun, 11 May 2025 18:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB86C19CC28;
	Sun, 11 May 2025 18:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQQZyC0s"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AAE2576;
	Sun, 11 May 2025 18:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746989439; cv=none; b=EMfmoAry2GOJfaM0haTySNwPi+2Qb57cSTVbPoCcoZouhsr0jMwS0M20/oHzeGpn7z4Nk09dmyQNjKw+hZtRDq3HgWobZj6BMhWT27h8xM8XdQC0vxN7iyeCvnenN1F2jE11ox13ZdNhYbf+DcabCfvmzmEcV7EA7/DtFHPQzWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746989439; c=relaxed/simple;
	bh=PVR2/5euqOuyaXdAuwW8N/x5gcI97G4iFgoEvQ6Vw9o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XG7p8h+TCDmR7NbUR6twfqnD2+zAqU8YOpzIkagNvcLre9SkDdt75PjxRPtQAHm9TBv8T/UJrwM33qNrcvvY/CGqpt9M3iOUgBYlvaUJjGlaiXf9G9Sb1ZW8J3mcPDAqmt/bFhlfSXMF0egoOG0GY6Ei/mGlpPVc6axB78vDkG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQQZyC0s; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-442d146a1aaso35024465e9.1;
        Sun, 11 May 2025 11:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746989436; x=1747594236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=loWaUTc3ItqSmmSDVC847qIYyYkmIRUdKWPahuJRyf0=;
        b=CQQZyC0sRaIceplsYaGptsOaZydqT52+sBjAB6CB4eu+3GCvhYHmVLXI6pr/M3S45c
         RBRAQW1BzBgdGBThSRP/tcsh4wkpws6sR+K7LKdCPUe+3Y24bW0Z9rZGoR+3khkJkjal
         tHYW+THs45Viwj53DBRwhFyfcVeJuXdy4+hDxzz0PyUDFiFGIots8XxxqV/3aPjUkCxZ
         5ExPbuGMqF+JW3TuWScEhtfkrKUnJH+NzPR5fZxBAJ5H/BijK8KbOf8ql4pN9eU+qBZ8
         xxgEfYEcSZfum1QNvs5oCX83oH+DCNfoJTXf3dfhznVtu+ykpvPZhEEAG3RTDkuvc81z
         zzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746989436; x=1747594236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=loWaUTc3ItqSmmSDVC847qIYyYkmIRUdKWPahuJRyf0=;
        b=e4QlKtKnXVrdnoKnLAjYWQBuLOnMtiwt/hGhNFU1bWnzhfZ40rs9Hb3PoJct4ctizb
         84++hpE4HiBRuu2t0pebu9QMJW0SGgJjMuphLIbnLjEURASiHwk5opzhM0KNLnF0SiEo
         8pkr5F6f0eGDJLyjffJnC162SKYtmnmOCWDsXf6fPsLLfzxC94v7gB0VbCcnBAproXDS
         nmzEadf2RI8xG6G8i3+vQYc1Qv3E4qHmjIjAYg2iCb8JSi8s0XGxtEifUV78E3kh/M1H
         ere9UmKwIrKtvUVYvmhSIZK2roggpe1i/wbtywxj4z4a/gBMNi04TGmMjhWxi4cgfhth
         Sd4g==
X-Forwarded-Encrypted: i=1; AJvYcCUwLM7xeFm9huYytCCquCCp/Mv+o3hN8F1p2utYisXopHAQYRFHj7XTruc8a96yF2fZh/5XUexoBmE=@vger.kernel.org, AJvYcCVxF8BnNSGZedVvTO7VbhURH12OKQyKvIrChossyPlFsOqZInjip9fgl+oT6p+TDaGbYGRGE9YXfplaL/0N@vger.kernel.org, AJvYcCX+9nFZ+8gV93n/ww9iftdXu51fEP1uTFMO7V1YFy/ik1BfpLjj+z8uFJ0213xP7igYU/zn5fgi3Oqo@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1CVvW3FIFs7Y6jbSN64jEZE+uZuVPF0kgdKO0hRKplGC22CfA
	eb+oDbexmIKNZNCub5oF2V63zKcisTt+zCAFPyLbaSuGQbXsmKQG
X-Gm-Gg: ASbGncvqVUhF81E3X/33R/EyivhHu5OoDncffXTEw6+mQCpwrCVs2vL9QKulDqj7wX8
	muSPsUs5xklrgo9jjYWVzUn0t+SqGoxu0T+d7BdE2uhx7opRc7NZKN5WLhfpSlNdDFZ65Rd+Dq/
	Cquyds+xhZ3b9VMQjQKb2LwwUfb3uJqD0hgc+6nCtOBGToIbP9LJAFOH7374lK0kptPpUlzHI10
	eB4I9Ej4/s4TNp2YNQsJrNlaJQP8OE4bp2NryEIYBJPzTeNerEdasMTTf0FlqOhJkTTQ4aE0ylg
	Ce7G2f/C0EuBEpzBOOECWj5rNCaV+gSOygtyvvOYdiLhcZS85dF2eG59PYx1prVUqZ8ibF77obj
	isbPylqN+3CyxZJgrPGTiyMos9haVM6Y=
X-Google-Smtp-Source: AGHT+IG51dzBBCDBR2uiDSd2l5oLlZrdptUt2qiEMrM0hguJxCgHfALPfGmRu+IVZfqSfApN6uqRyw==
X-Received: by 2002:a05:600c:46c7:b0:43c:ec28:d31b with SMTP id 5b1f17b1804b1-442d6d3e373mr99987515e9.10.1746989435961;
        Sun, 11 May 2025 11:50:35 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442cd34be0csm141257725e9.18.2025.05.11.11.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 11:50:35 -0700 (PDT)
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
Subject: [PATCH v7 1/2] dt-bindings: thermal: Add support for Airoha EN7581 thermal sensor
Date: Sun, 11 May 2025 20:49:54 +0200
Message-ID: <20250511185003.3754495-1-ansuelsmth@gmail.com>
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


