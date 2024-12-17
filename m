Return-Path: <linux-pm+bounces-19380-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FA99F53F0
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 18:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C53D1893A0D
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 17:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76DD1F8ACF;
	Tue, 17 Dec 2024 17:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXsAMxZv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89BE1F8696;
	Tue, 17 Dec 2024 17:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456640; cv=none; b=S4WDVK/QlHC1CHAJjl6DUjp3rP7mdyKAmRuD1ot2gH2fWFFcunpTE6rNAAOLbLkzoNaAmlqUfkvaIDdGTRtXwiK9njm0BQx1ub8dLNkNraaIoZFYzW4lpOnGVQGku439QVpteYLTLxrrOz8abvBEvGuvGerSjPMWqSfc2r+rBdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456640; c=relaxed/simple;
	bh=Ysdm0MPXNFcWymQ1oyL7kJl3xM+8vynFf2bNEkduhGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TNQNjhW24mxy4sG3uPn4Tj8y0M2dIZRhVq5KiZB4KW9BbS3OQ2YVvDcgkF65SNXXIoYAPyCys79bcCA/vkNnV7oK4+3Y/c88BNM6NEobbeDRbYrWYzhC+5iNxc2Nl48iNdG2xsjWg6tNH1LqKg4sTaKq9CHB5ZFDAg25hRTYrLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXsAMxZv; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa69107179cso1034747366b.0;
        Tue, 17 Dec 2024 09:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734456637; x=1735061437; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cz+dnEpOOSJD4rTGFvNS16veou5VGvcPUuKa01+C17g=;
        b=AXsAMxZv1P/DfilUZTqGPNTX8DVnpVrlN28hhYHFJsoVc/UeMVmPtr8O5qcNwwLohJ
         XnyCCLa1xBgts9CC5XSO9p8APkgmVukh6TepcrdLqJ+zH4/R656Sm2BcJnnayVeMQ7km
         H76luKodFa1yd+vCHqNq8FZb2Zvbpi2ypMvtRRfbuu+xm17UjbM6vXotHDQCWkUMMHeD
         +J4XHI4dS+4nLdkZpQ1Ol2mutBP6cE8d+j7raou9hPX03U/GL2SPjAJuWtDzCAKaaupQ
         inRICrWpldwFkksZtp58/QdG2uVL3IfvI+dwV00qlZdb4e/JBM0zATOOZd6iyUDzqL9Y
         zDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734456637; x=1735061437;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cz+dnEpOOSJD4rTGFvNS16veou5VGvcPUuKa01+C17g=;
        b=bcbMHqIcNXv6MTUsl8+l9+aCtyLLNdTaGCdOTuwSRtbrAOGd6+bqMIEdg1J/CcvUD8
         /tTZJcdu/kLHDvqvVeUwtG2g4v0Nf492FDZy46i3WomUrMe7uYv9d8GigmCHaL7P5dFm
         1CCA+Mk8kA7MPY2giFhJzXtBwnW7XqH6atRhd6s21ytz4WOHX9vg9/OSOcuxVTOvS05X
         farbCSxixM8ZuI7rXhwJ96sHeoY7Dq4/WQ7FQmiOIDCjXl52d00hnW21IU/XsBqDKPGJ
         /IjW0Kl+lNyBQbzh00ITmnWi9V9LyUrQVoediQpUuGKK57kazb014vQPWy2gLSU5buLf
         f7XA==
X-Forwarded-Encrypted: i=1; AJvYcCV9yXs9UHqzxCbOfbHWmj4nQC477K2GjoXeU4wX9hwEHr76c6QFHOt7UuvAx7Fe4q1HvUCv0kqwlbOrVxLW@vger.kernel.org, AJvYcCVQOEM4Bnim0f+CyWdDHlwEiD5ZNis2M+UWKTVZwPa7HWq+GqrnjoKJiR3N5NKTCxYRKxPAdEXH/3bS@vger.kernel.org, AJvYcCVbaDsm6KBQJ/4ACFqOWL4ujkeYIE6dpmreducD5rkTveVbHFzX69k4+hSVWRTmOpx+xiQoDfBfQMS927w=@vger.kernel.org, AJvYcCWO5UC+XLkG7jurjWR8BUkIUj40ryz/BTI8Zss8swZAwD80k6B8HsSM7YnCoJ9/Alu0ra1IcbSpHpi27Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjcrFsuvz2Q9Q3Fs1XU0ZD8a6CgPmOnw7Zfdnx0Dz6B2TzfDZf
	HHVC03+Ecf4FJ1wqKfrma149e5Gur/A/JWphwG6NIEvoOnChd47j
X-Gm-Gg: ASbGncvN1O1G472VpKkXjUM70Eeb8kW4+JkrA2ERlip7xrMwEa8v3KpLCwfh3ge6ZvK
	3R35Ru5Edmd4UHy0iJELoH6UlWrT2Q8gBArX5v223+MPcqS9ApeJZmH1iD14q3iRPWymz9t9jYe
	W234c6Pza0j/qzpVwu1UjGoEIqAFFdXLIpVjPLLz4uf9reVaBXsVWy7QU5XtrzmBukBX30SpPpm
	56PbOd7YmiSX8fiGzD4thpwTWTJuDS71gbpyPN1X5UTdElYFrzK6+M=
X-Google-Smtp-Source: AGHT+IGwmz9YnrEkFF8KJaxjIXYmB5yyVIVxDSOSbE4ZkDUdZr0/8ybnU98EgeGum7+g1K9/fJchlg==
X-Received: by 2002:a17:907:7290:b0:aa6:a7cb:4b9e with SMTP id a640c23a62f3a-aab778d9d91mr2038215266b.1.1734456636690;
        Tue, 17 Dec 2024 09:30:36 -0800 (PST)
Received: from [127.0.1.1] ([46.53.242.72])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aab95d813afsm470444166b.0.2024.12.17.09.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 09:30:36 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 17 Dec 2024 20:30:00 +0300
Subject: [PATCH v12 02/11] dt-bindings: power: supply: max17042: split on 2
 files
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-starqltechn_integration_upstream-v12-2-ed840944f948@gmail.com>
References: <20241217-starqltechn_integration_upstream-v12-0-ed840944f948@gmail.com>
In-Reply-To: <20241217-starqltechn_integration_upstream-v12-0-ed840944f948@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734456632; l=5442;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=Ysdm0MPXNFcWymQ1oyL7kJl3xM+8vynFf2bNEkduhGY=;
 b=HNp31paxlevWLqOZGpyGyV9rCN9EiCyf9tWLkAlifleRTF3H4WY3mjsOzqRQ/Hw3wM7p1m3Wk
 iRt2P46qoemDnnf2ObbY/dcU+5mUmvMtXaPOidlTH+opOG43+jJb0U9
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Move max17042 common binding part to separate file, to
reuse it for MFDs with platform driver version.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>

Changes on v12:
- add addtionalProperties: true on common file
- rename *-base file to *-common
- remove compatibles from shared shema
- move required properties to final schema
- remove max77705 compatible from binding - it will be used in
  mfd77705 binding
---
 Documentation/devicetree/bindings/power/supply/maxim,max17042-common.yaml | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml        | 43 +++----------------------------------------
 MAINTAINERS                                                               |  2 +-
 3 files changed, 58 insertions(+), 41 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max17042-common.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max17042-common.yaml
new file mode 100644
index 000000000000..67e673ca7970
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max17042-common.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/maxim,max17042-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim 17042 fuel gauge series
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  interrupts:
+    maxItems: 1
+    description: |
+      The ALRT pin, an open-drain interrupt.
+
+  maxim,rsns-microohm:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Resistance of rsns resistor in micro Ohms (datasheet-recommended value is 10000).
+      Defining this property enables current-sense functionality.
+
+  maxim,cold-temp:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Temperature threshold to report battery as cold (in tenths of degree Celsius).
+      Default is not to report cold events.
+
+  maxim,over-heat-temp:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Temperature threshold to report battery as over heated (in tenths of degree Celsius).
+      Default is not to report over heating events.
+
+  maxim,dead-volt:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Voltage threshold to report battery as dead (in mV).
+      Default is not to report dead battery events.
+
+  maxim,over-volt:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Voltage threshold to report battery as over voltage (in mV).
+      Default is not to report over-voltage events.
+
+  power-supplies: true
+
+additionalProperties: true
+
diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
index 085e2504d0dc..0832aa5f5eb0 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Sebastian Reichel <sre@kernel.org>
 
 allOf:
-  - $ref: power-supply.yaml#
+  - $ref: maxim,max17042-common.yaml#
 
 properties:
   compatible:
@@ -24,48 +24,11 @@ properties:
   reg:
     maxItems: 1
 
-  interrupts:
-    maxItems: 1
-    description: |
-      The ALRT pin, an open-drain interrupt.
-
-  maxim,rsns-microohm:
-    $ref: /schemas/types.yaml#/definitions/uint32
-    description: |
-      Resistance of rsns resistor in micro Ohms (datasheet-recommended value is 10000).
-      Defining this property enables current-sense functionality.
-
-  maxim,cold-temp:
-    $ref: /schemas/types.yaml#/definitions/uint32
-    description: |
-      Temperature threshold to report battery as cold (in tenths of degree Celsius).
-      Default is not to report cold events.
-
-  maxim,over-heat-temp:
-    $ref: /schemas/types.yaml#/definitions/uint32
-    description: |
-      Temperature threshold to report battery as over heated (in tenths of degree Celsius).
-      Default is not to report over heating events.
-
-  maxim,dead-volt:
-    $ref: /schemas/types.yaml#/definitions/uint32
-    description: |
-      Voltage threshold to report battery as dead (in mV).
-      Default is not to report dead battery events.
-
-  maxim,over-volt:
-    $ref: /schemas/types.yaml#/definitions/uint32
-    description: |
-      Voltage threshold to report battery as over voltage (in mV).
-      Default is not to report over-voltage events.
-
-  power-supplies: true
-
 required:
-  - compatible
   - reg
+  - compatible
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/MAINTAINERS b/MAINTAINERS
index 81348dbce8ca..0816fe0f3c80 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14164,7 +14164,7 @@ R:	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
 R:	Purism Kernel Team <kernel@puri.sm>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
+F:	Documentation/devicetree/bindings/power/supply/maxim,max17042*.yaml
 F:	drivers/power/supply/max17042_battery.c
 
 MAXIM MAX20086 CAMERA POWER PROTECTOR DRIVER

-- 
2.39.5


