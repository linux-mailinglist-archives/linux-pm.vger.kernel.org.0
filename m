Return-Path: <linux-pm+bounces-15783-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 951999A0E71
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 17:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26132B21F8D
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 15:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939D320E029;
	Wed, 16 Oct 2024 15:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4hnsSRC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D1B107A0;
	Wed, 16 Oct 2024 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729093013; cv=none; b=sAMJWUAU2oo8jyef0hVDSMtux2+8nrDSsAGIGLCd+8JxMMElECWYMpD8o4OgkuivXwKv2N34C6TAIcXOf8C9gP1SW7Po0uhiZmSxLtdjCOZtflYFEmQhfF157X26YO3Oyb3xZShUa75Qrv6vrva4tiMaXgGV/AmIsqRwT3Nlzd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729093013; c=relaxed/simple;
	bh=xkb8b0ItzLeiZrA+CiYd5exlClYZEZIB0U5kfNMG0cs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GHcFUOkX7I8KchUD+XbYsihJvdFsn/QRP3yVZKIrnqaTt43hgiKYOXQB7pt+GkThMCux9jDcMYB3aHxtbcjj/k4rrGYNDz8Zn8DY4xHETlznTtwr83DoLFRp6NwGI8ieeD1wG7RIdq+dr/BHJimeO3H9NaqqigXevDFgFyPYj5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4hnsSRC; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a156513a1so440162566b.0;
        Wed, 16 Oct 2024 08:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729093010; x=1729697810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5fQzn5M9AjqoW0Bg4PEUOl2UHPKd6sbQpASpgMZ5Coo=;
        b=A4hnsSRCFWaG9Xt9x+i5Al26fI0rOzlnHLU+RWOQJVXMbTrync+bM9mZF9U5Bl4a6f
         fKDfzsqrE4Jet1uJwLY1STefkO9MyYKIpYEGR+iAL876jnLxLOD6Rji3w6zCKxmbXV4D
         NadidRAYpMS1TZ1ygMwk+CxTcqJBZFD1G+6djMjQtUMEkh27gxmpd8a62X1LwUilqbkR
         hu3x4zTfSkmyBzl6/0uR6YyGbCZSNrsb8SzNg2POsIwnjW7HalF8LLwUr77HVhRN5rfQ
         MWiuZRPZc0xu7/BBn2QNAMWhb5IMe/7OhFTmdoikBNijHXCB910HpmhexYgM63A2OOBD
         Mupg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729093010; x=1729697810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5fQzn5M9AjqoW0Bg4PEUOl2UHPKd6sbQpASpgMZ5Coo=;
        b=nJok6IU3JTMoOv2ikIl5dyOloKy8ZkUg5dkCQH4IKRN+bQZJpWpHyGoTZTkZh5cs15
         7L6XLI++0hd09Yn0lUY6IvYpyy03bs9yJQH3byddRmE483qflmHKnTZvjCPG/YyHUeb5
         2Sy30omGylyDbR96rKCvB+NcIyQIJoHoorTZRJISSN5Xs0cJVfAIRuuon5+9XtpAIW6f
         lRF/gIWaieYnHRwRsJOZtC4CTToS0KNEnVAyblq4E2MUF3qhK0mC4xMqLC6YOxOx5eIk
         kyYuzfm4csyNnRZB/g2lqSuR0CgS5TdOij6SjMSGbbOiQmmpHN1DmMHIPSH2zOc32Hep
         8IYA==
X-Forwarded-Encrypted: i=1; AJvYcCVYQSU/V3bgwMbQX2Y7dXO4r3ZzltUJZ1BCZN0Z7JhXy5FvbASzMzYaO+03IGhtWRL/iQaLXM9n3Pp/iS1b@vger.kernel.org, AJvYcCVvFSCJEVUKxAaYJLhaDQnDKLPBOipHt9OGKNAIcMj/aJgo/oK9Kf70F+1SWwq+8cJ6jKo8r4Va0Pw=@vger.kernel.org, AJvYcCW4aLtYG9g+ZFl0EVc29Y2w0hKHA+qWjVaMlxrx+H/gskAY9UU7Tl4OzHI+09VwJmdTOPOsb6Qm7vg4@vger.kernel.org
X-Gm-Message-State: AOJu0YyrW9upi0Y/U4Sml0XOxnKLrsvMPd98KDyT6JEwVbsAdM1ef6J1
	pup2ci5es68HvSlA55DHn9xLoN3U0ZAOGZp0vhW1zwlwa5w7FnaF
X-Google-Smtp-Source: AGHT+IG5Ra7K8yYd8HJ9d4E2o2lEEQjASQ+GHxw8TzN9H/8ONKK7TJckyZHoENBY1fg18pub8WvD1Q==
X-Received: by 2002:a17:906:d7c2:b0:a99:4152:1cb4 with SMTP id a640c23a62f3a-a9a34dfeb58mr371922666b.42.1729093009880;
        Wed, 16 Oct 2024 08:36:49 -0700 (PDT)
Received: from localhost.localdomain ([62.19.118.125])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9a2988afa0sm195951466b.208.2024.10.16.08.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 08:36:49 -0700 (PDT)
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
Subject: [PATCH 1/2] dt-bindings: thermal: Add support for Airoha EN7581 thermal sensor
Date: Wed, 16 Oct 2024 17:35:48 +0200
Message-ID: <20241016153613.25501-1-ansuelsmth@gmail.com>
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
---
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


