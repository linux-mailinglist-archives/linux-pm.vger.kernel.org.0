Return-Path: <linux-pm+bounces-26434-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D811AA42A3
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 07:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C5CE4C0333
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 05:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1851D1E5701;
	Wed, 30 Apr 2025 05:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azITOiTG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7EE1E411C;
	Wed, 30 Apr 2025 05:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745992315; cv=none; b=LeCOpCO25Sj/V95LmkBCsSDsafFxyiG3a5aTyU4fQ/TTAw2CxfisvBSVlO/lzzGtiNtHvKSjg6bXgAw2FDzU8ZKY0AslE8FCkBWdDOvPnH9D3e1DKhzKqd0mKEDuNZwl1d55W/diq/HicRL4hzaCzUZQIYUK9Vaj4QUBgr7jJPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745992315; c=relaxed/simple;
	bh=7Ax9hARW5Y1MU2CX/R6xFwaAF2EH+tE3B+J9bCfEVv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=amqul3anQk7zRmGv3PujIgJOlWUJbZ12vMLLzypNWRTrUh5kN4wruoYJPLD7iiXFpS2K6PFlus6L5WRm4ev06TfA+dx54pECatmfYkuBYlaJfXz7Rr8fpTNEz2+WruHfCxUVqz3/lOOi1HdKZ7rrcI8FJVxPsrvVGYtwxj3MriQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azITOiTG; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac6e8cf9132so1347164866b.2;
        Tue, 29 Apr 2025 22:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745992310; x=1746597110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TP6KuGlJXsBGNrZx3tBoQ3loAPKq243fuUuEcwk0zfY=;
        b=azITOiTGog7Dxs9UXR7vUrMGhMtwFK0SltLTVF7cbKfItBwnPmnddueOpIz09P3p1N
         gdjE9vl5czEPVVSS5h1jXGYrgrqQlV0/huqpiFhDUV2xfd77Am8M4dbRWU0DhCCHQ90v
         S2GvHISCM/CW6mDt9R8sf4nJAcR4o7RpO5rdnA3faaXT1SM29N2vMDsZ/hJYL4owRkae
         Z3GQWjk981TT5LcQgYhIAn1E6uFe8giqqAgHyagiTekGHARudPglHWI/N8rXXvjn8dgD
         uIl3E+D+Q4vlR/EfAMLH9+3ndwbJT6OOlZbKFVF0RK0NLUK9cgjCWIuml6Kw1bS59+XI
         cR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745992310; x=1746597110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TP6KuGlJXsBGNrZx3tBoQ3loAPKq243fuUuEcwk0zfY=;
        b=NheF3AZ2B8C/bkzDE/YM014xL6NIh2Cd4zDKVpceVB6942NrEHLJ6ncV2dwKp2OMzd
         yNJDNv3Yubl9Jb0GcQJiOFkRvY/03REIwfzci+6Hwc+dTZvkoAkqstm6ZFAXja5YKuti
         coti9NKJR9zT7VCYEx+FU0DAcCNYGXRIq4xT3N2WBoOjaXu/mJz1xpiK/7T/A/loxBLs
         mnIVjc0nNmHyB8BQVXQGErUHPv+1tKKIUhFYVAI8/W2Duf/pOopbNs/rPlu5GxQ52ELP
         53WujrJhTD+kgkYV1FIuoY47QDNY65+gCFN92qQwJER466ZsVv4h9K7bpxhR4fpKXRey
         O4SQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTwKrWKpTXifBQCPE18/i0kd0epc9vENQA4YOjG7u9FzOOBKqkBhqoWehlXQuSHSJoOgcBnQtCxcXCS+b7@vger.kernel.org, AJvYcCWijlddWo+teu9ss/tOzbxlhxbZnGrEBYVYuEIj1FdBOI89zZVQpvL+rztzNZPjaPV4imeZeehCv5Zy@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4MTiu86KIitq6nvI6SLqGSL4eCk5CJ3u0I0kwr20sneKBi4EK
	evFllAGMM2p2tlhI+tYuFq3WPn6DUasKPjX/fY1YU0+EytEtRwu0
X-Gm-Gg: ASbGnct4NV3K/PgYXn+N1tcuvzMSGtakuUHyeeSOaZkrSHdTSXWd+hEEXzIyqwubFvy
	GCCJozQSIlEMS4mjbOUMLE2/WobiQm61AwzWPFd5NtTgxHOCxx27E3p14o+BaGj9rdkYqFFSY9w
	lwkwwD3L7TICRaXHN1lnjDTmRoBJdO2BL5Hzq9K3dRi4gquMdzXhwRQsIJxeqmc2G/NmcVhsjRq
	4lEbYVkpPA7x4q9YVIbmvA1O+z9B2z+z1a+B1pTw1yuBqABTugHwZ1Uty4AdV0fLVRZp97AwQLF
	61zDm4D/4JO26BqSxHGdw7y4uR41IxD04cFykRxjlRU=
X-Google-Smtp-Source: AGHT+IFwt/ms5maHvwVzWzatBsLqwCaD+gEOaI1YaeLjLDv4PlIqnALvDzE6U6ZahTBRFHKHHavrJw==
X-Received: by 2002:a17:907:6d17:b0:ac2:2ba5:5471 with SMTP id a640c23a62f3a-acedc5f1686mr203757366b.24.1745992310319;
        Tue, 29 Apr 2025 22:51:50 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acebe7a4f1csm299929566b.51.2025.04.29.22.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 22:51:50 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] dt-bindings: power: supply: Document Maxim MAX8971 charger
Date: Wed, 30 Apr 2025 08:51:13 +0300
Message-ID: <20250430055114.11469-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250430055114.11469-1-clamor95@gmail.com>
References: <20250430055114.11469-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bindings for Maxim MAX8971 charger.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/power/supply/maxim,max8971.yaml  | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml
new file mode 100644
index 000000000000..2244cc3d45a6
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/maxim,max8971.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX8971 IC charger
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+description:
+  The MAX8971 is a compact, high-frequency, high-efficiency switch-mode charger
+  for a one-cell lithium-ion (Li+) battery.
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    const: maxim,max8971
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  monitored-battery: true
+
+  port:
+    description:
+      An optional port node to link the extcon device to detect type of plug.
+    $ref: /schemas/graph.yaml#/properties/port
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        charger@35 {
+            compatible = "maxim,max8971";
+            reg = <0x35>;
+
+            interrupt-parent = <&gpio>;
+            interrupts = <74 IRQ_TYPE_LEVEL_LOW>;
+
+            monitored-battery = <&battery>;
+
+            port {
+                charger_input: endpoint {
+                    remote-endpoint = <&extcon_output>;
+                };
+            };
+        };
+    };
+...
-- 
2.48.1


