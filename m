Return-Path: <linux-pm+bounces-32089-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55359B1F9DB
	for <lists+linux-pm@lfdr.de>; Sun, 10 Aug 2025 14:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6D751898E99
	for <lists+linux-pm@lfdr.de>; Sun, 10 Aug 2025 12:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BDE2566D1;
	Sun, 10 Aug 2025 12:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="UY7BG+yo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FAC2505CB
	for <linux-pm@vger.kernel.org>; Sun, 10 Aug 2025 12:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754828506; cv=none; b=CVy5AyKh+OFYZF3YKAxLzbE0+S1VsJReLs3VJTqTX58Cr/6PMP9egaH8dG1Aq+JBjuCTpSna4KY77fgexkqaZW1e8keQPbhStNRP6ffkjSCHaMdvBa054daPH/KORD1y13BaUafVzBKcrk4JxsH6SDB0nqssuVoNRPUTz5vvR1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754828506; c=relaxed/simple;
	bh=4kUC8UfJIq18b2XMjcez718pUOrhRiCrn/TDW7CP+6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HrUNHLxpemo5djZCz4+rc76qodw3RyqA4TjD3PkT8E+umdBikLSHw4R1+LO926ryyTeiV/GnJUwUWt+NsC19Q0Frd0nW6kAULUiNwPDbKm7DCXi38ZDtZrn70E7PSHPYMwsWNd9YDlKvQygrsJXXPJFxxPbD6r75mNukGuyUh/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=UY7BG+yo; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-61557997574so5026542a12.3
        for <linux-pm@vger.kernel.org>; Sun, 10 Aug 2025 05:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1754828502; x=1755433302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UfWmFS5ER401fuRy1i+KSp84qUrDXaJMiV7A2WK6mME=;
        b=UY7BG+yoiHfxc1vnMZJcX9sm9XhwF5mdlk3KB0J2iy+3tBcyywZFLvwBMeonTNeRP/
         wiYRUGB3vH9NmIcj0mosj+q9Tz329q2U+O+HFQYgr8KCsb2lyFLerIPAXktEbwGPDOAI
         ZAECOIXDnGW+vWUTBOTQ7frq3a/u/lMkoLWLnrWGq5yRqrjBtsU9BIBqClibGeKIsKeq
         UWvTUgyhYstsQhqn4yRowlwkBmKsCYrJ5Z2eBjok14/4XlQPGjAvjrw+HMVYLs9iiAoA
         wq676rPasGHWAhiD+WvTciywERwN0Gl2MGnkYrE2dnMSHKTmhsBs/U+Q/ptL+2paS3/P
         fV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754828502; x=1755433302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UfWmFS5ER401fuRy1i+KSp84qUrDXaJMiV7A2WK6mME=;
        b=nmNJ0FqdKajgO6uQp2AVw5Qd3IvHWQ8prNyVDI6aHWnRtqj+ro5zqdfQvPj6ZFqFc/
         05IQeX+jcBHjUj2aF+VSEvnbWCuQH3a7Tim2WVNxIrChbSH/RMMprAFjBcbP5gJRkfmy
         pJqd8y5Zi8vwAA0Kb/zVLpOiFk+ZiUAMnHwy1/4l20rRihCHXqI/CEwPouh1B32+8tEu
         VzV6QPDTtjayh7zBkd/pn+bJie0Yw8kIH/TW4gT8+JDxnVMMcKI1efnFmwaNTpX0jH9b
         Qv5EDRn94wgTJlFSz8IxkCejIO/pDtdKJc246eEbTZu4eYOE9la5nkn+DSYHCDtBrQPa
         QpHg==
X-Forwarded-Encrypted: i=1; AJvYcCUNJwrfTPCYiMxy9z5O+QTv/jDfWhnwcNXhfOdYeC9/L/H8tDD75OHNsJ0VV/W0MiJHP0EwgaMO4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YznWwu69WEBp3xe3s24hxyXCkVDrADNWD2mxWxVnQhqVmxnKmth
	/e7hW9RDd1VyFG0IusDuYTpbzxlL8FdCUKAdpJIorE20MRMtsBeHrKnOYpfYyyM21ws=
X-Gm-Gg: ASbGncun6CIKegZhkCe7j1KR7rsYE9TAbvQSMYgMUC5VgPUV3UY01RW2KcxEZMVTlm6
	8pk4NcYNpZZ4wkfSoQhrKMEOhpG86faNUzxEWSEbGA8tKNoMrVIrTye/HG280XDWJZaqBbOmZaC
	rekvJGG3LQVLOHPS2c40c0rIp+NZNk9st/4oBaDNKMkntz7LLxRbeswz9c0GanEeSW72rF3g6g0
	iz1qoL3Br0YUXKxHGKXkTNTpeCK4mWk4CtsJOASS9fHIcoZc2H0OdAJbjgiEALnYjg2rGNmjBC1
	hwMhA5mtl+78lhEuU/ub1cJhRqcK0lGPpBBFBFA07n4K58UqtM/+H8pqVu9bbLV36wCrkae8b3n
	x+zaz7tMekAfLXqnyLxl7TGTXPPF08jabqdGmZ2x88tCZ5QXiDQoF
X-Google-Smtp-Source: AGHT+IH2BxpYN+/o9cgRtTlYf8Owzh1LVUE4C25JyBYtNyqSEZQBYiszthjxHQH7Zc1QUqUs0PMx2A==
X-Received: by 2002:a05:6402:2808:b0:615:539b:7acf with SMTP id 4fb4d7f45d1cf-617e2b70974mr7908566a12.2.1754828501614;
        Sun, 10 Aug 2025 05:21:41 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.188])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a86758fcsm16611897a12.0.2025.08.10.05.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 05:21:40 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	niklas.soderlund@ragnatech.se,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v4 1/4] dt-bindings: thermal: r9a08g045-tsu: Document the TSU unit
Date: Sun, 10 Aug 2025 15:21:22 +0300
Message-ID: <20250810122125.792966-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250810122125.792966-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250810122125.792966-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The Renesas RZ/G3S SoC includes a Thermal Sensor Unit (TSU) block designed
to measure the junction temperature. The temperature is measured using
the RZ/G3S ADC, with a dedicated ADC channel directly connected to the TSU.
Add documentation for it.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- none

Changes in v3:
- none

Changes in v2:
- collected tags

 .../thermal/renesas,r9a08g045-tsu.yaml        | 93 +++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/renesas,r9a08g045-tsu.yaml

diff --git a/Documentation/devicetree/bindings/thermal/renesas,r9a08g045-tsu.yaml b/Documentation/devicetree/bindings/thermal/renesas,r9a08g045-tsu.yaml
new file mode 100644
index 000000000000..573e2b9d3752
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/renesas,r9a08g045-tsu.yaml
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/renesas,r9a08g045-tsu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/G3S Thermal Sensor Unit
+
+description:
+  The thermal sensor unit (TSU) measures the temperature(Tj) inside
+  the LSI.
+
+maintainers:
+  - Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
+
+$ref: thermal-sensor.yaml#
+
+properties:
+  compatible:
+    const: renesas,r9a08g045-tsu
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: TSU module clock
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    items:
+      - description: TSU module reset
+
+  io-channels:
+    items:
+      - description: ADC channel which reports the TSU temperature
+
+  io-channel-names:
+    items:
+      - const: tsu
+
+  "#thermal-sensor-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - power-domains
+  - resets
+  - io-channels
+  - io-channel-names
+  - '#thermal-sensor-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/r9a08g045-cpg.h>
+
+    tsu: thermal@10059000 {
+        compatible = "renesas,r9a08g045-tsu";
+        reg = <0x10059000 0x1000>;
+        clocks = <&cpg CPG_MOD R9A08G045_TSU_PCLK>;
+        resets = <&cpg R9A08G045_TSU_PRESETN>;
+        power-domains = <&cpg>;
+        #thermal-sensor-cells = <0>;
+        io-channels = <&adc 8>;
+        io-channel-names = "tsu";
+    };
+
+    thermal-zones {
+        cpu-thermal {
+            polling-delay-passive = <250>;
+            polling-delay = <1000>;
+            thermal-sensors = <&tsu>;
+
+            trips {
+                sensor_crit: sensor-crit {
+                    temperature = <125000>;
+                    hysteresis = <1000>;
+                    type = "critical";
+                };
+                target: trip-point {
+                    temperature = <100000>;
+                    hysteresis = <1000>;
+                    type = "passive";
+                };
+            };
+        };
+    };
-- 
2.43.0


