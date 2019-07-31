Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF067C6C0
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 17:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbfGaPfg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 11:35:36 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35109 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729041AbfGaPfe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 11:35:34 -0400
Received: by mail-wm1-f68.google.com with SMTP id l2so60222313wmg.0
        for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2019 08:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H1Sjaa8cz7i5glOX1PPxwlXLvIYHZMeRObMTEKwKyto=;
        b=c3EFEBNT6i2kOMObQOpFalgCmDnhp4V7I28AFBh+gZ6W8GhaG0wFL3Q7Y7W61TLsr3
         5mtoNNC9KGuLcf3M2c1z7f7XjCn+TLqcO94CsRZELhc8qbWdt3y1FcgYbfJImhXNDNcm
         mcgtNMpG8S9UrqxD0ItemaLYMYHFApqV1lUuO2ibwrUyahDlIhFESkrnSvM22x4aJL/O
         qXkId+RSUrKL9L/wuqM4Nkukc5rLN/bO2WWx+pLJKSZ1vLc2wTs5EIfq5uc03SGjsiLX
         j+cFO/uCezEdvPBABnuAIX2C/x1IM4YbwdvWusd9u38yiUtzexD1tkW1AvfHqE6ywu6n
         MYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H1Sjaa8cz7i5glOX1PPxwlXLvIYHZMeRObMTEKwKyto=;
        b=lSZEnLj0YW0fohiRbdJj01h60U5GnIp91RJthvMFbwdSSfUIK3KvRtBuzfxm0o92L/
         Hz9XBzq2+w2edBWZ80ki7DnggD6nGr7dyW9sVeUJkwKUrgGRVdf4pXnaRKsM8SYk/4Zs
         vZ8Gp+AWXkfYGC8LbLIxH8OJ+/zKrai9lOF/mot6BhRBPoL51wxeFHeYHogxB0vHLre/
         FO4Tv3cEnPtv6c4IdgXWHO7+tzT9CULsaePwAjdEGwdnO/6TrKafrP9rCzFQtAgUnjuO
         Lf51dZiVgzfAq4wuYjDdFCxt885kjqraiG22f+u2Lou/DUjtPgrjYekXjipoiinvE9cJ
         WD2A==
X-Gm-Message-State: APjAAAUYnkCSGzZhZPQR5K98G1R15JOdZPZ2FC1JKkt3Jsmlz6fLlOqu
        JUoRcKSgfl2SEBGomfq0Yyf+rA==
X-Google-Smtp-Source: APXvYqwi/mxyDfTaLNfjPLXTxNpEjZnEgzg93rTwxWBssbCJDK1mqwZ8VkQPDQY8zNbK8m0dVkEHSw==
X-Received: by 2002:a7b:c40c:: with SMTP id k12mr103602947wmi.122.1564587332704;
        Wed, 31 Jul 2019 08:35:32 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id i13sm62834396wrr.73.2019.07.31.08.35.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 08:35:32 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     daniel.lezcano@linaro.org, khilman@baylibre.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/6] dt-bindings: thermal: Add DT bindings documentation for Amlogic Thermal
Date:   Wed, 31 Jul 2019 17:35:24 +0200
Message-Id: <20190731153529.30159-2-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731153529.30159-1-glaroque@baylibre.com>
References: <20190731153529.30159-1-glaroque@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Adding the devicetree binding documentation for the Amlogic temperature
sensor found in the Amlogic Meson G12 SoCs.
the G12A  and G12B SoCs are supported.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 .../bindings/thermal/amlogic,thermal.yaml     | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
new file mode 100644
index 000000000000..f10537ab4c8b
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/amlogic,thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Thermal Driver
+
+maintainers:
+  - Guillaume La Roque <glaroque@baylibre.com>
+
+description: Amlogic Thermal driver
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - amlogic,g12-cpu-thermal
+              - amlogic,g12-ddr-thermal
+          - const:
+              - amlogic,g12-thermal
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  amlogic,ao-secure:
+    description: phandle to the ao-secure syscon
+    allOf:
+     - $ref: /schemas/types.yaml#/definitions/uint32
+
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - amlogic,ao-secure
+
+examples:
+  - |
+        cpu_temp: temperature-sensor@ff634800 {
+                compatible = "amlogic,g12-cpu-thermal",
+                             "amlogic,g12-thermal";
+                reg = <0x0 0xff634800 0x0 0x50>;
+                interrupts = <0x0 0x24 0x0>;
+                clocks = <&clk 164>;
+                status = "okay";
+                #thermal-sensor-cells = <0>;
+                amlogic,ao-secure = <&sec_AO>;
+        };
+...
\ No newline at end of file
-- 
2.17.1

