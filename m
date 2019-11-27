Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54F8A10AA32
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2019 06:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfK0Fab (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Nov 2019 00:30:31 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46306 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfK0FaG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Nov 2019 00:30:06 -0500
Received: by mail-pg1-f196.google.com with SMTP id k1so1837037pga.13;
        Tue, 26 Nov 2019 21:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m+wA1RX04BSPnVjNbxGCBXt8jtUUgOJo5n6EFES/ZC0=;
        b=NAQ6Ywzj9ZjMbYy+Q3DneIn5TOVZ2ug1lpiHFijsVz2JtEvPUBvBkgj8JHiEkdBqyD
         Yo1ds6nVDXNM0cJaEO0kynwlTYTLnDEpcjYckZrlyVH0BIIVQvVKOk9lDDTLM9ygfUiy
         yrqwbgM/5YTex60dV7QIF11UcZndyIwbCpN1qtNBk3y/4b3vsnEZtfKnSlclLcxhcwC4
         7nEwpotg17ZNtV0bX5M4ics/xwBQrih/YNycmZ17Djzt70nBHA2KiO0Cq5goqv+7zWaq
         56Xz1OLjqebh7RxTS0qZzIKBqMDsbpZvvJDVLcdlyl5EtPjYFa4VWrgZ/E67wpN7xy7C
         Davg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m+wA1RX04BSPnVjNbxGCBXt8jtUUgOJo5n6EFES/ZC0=;
        b=dbN2vhyftPSv0bcruoyRQ0mhjsd1Y10wxiPW3qOarvSJhCPngW4H8HjWljJrUxvld1
         n0hDpFbJQBSs9lfMwbusi2QKrz8YiYAED1xeaM0DnGBkO9I9A52ezAebgyA0sKaoqp8P
         eRQ1wFruP0sofQgHg90vX/recnhMUjCiAAr6Oi/wJSD+Xt4rgu840UFpyb5D94bK2xS1
         97a4RF2/B7B55wxogfWO7AVVA11Qk/NF+4whXODijK/DZCs3kOdCeG5Ihdud1hEEzkNS
         yg6GqhLjsp6EgY9rJ2ozeEn0A22ToFqbiOWD6zPPE18y8pGpth2eNHvYcz0mf6k00mdG
         QNcQ==
X-Gm-Message-State: APjAAAUEQLVSW04vEcD/DNH9We03stSyU8LOwuAdg1RMOZdPQL20dPoD
        DzvhqmhKAVSQ5yn5HVD7D10=
X-Google-Smtp-Source: APXvYqw4sNgUo0b8NWUQsBZEeo0fVFA8rx27nKaYJzlqYHZYbIXE3nnctVmDaAM+vNmh+i0i+VgsvQ==
X-Received: by 2002:a63:354e:: with SMTP id c75mr2768495pga.325.1574832604122;
        Tue, 26 Nov 2019 21:30:04 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net. [216.71.213.236])
        by smtp.gmail.com with ESMTPSA id p38sm4360825pjp.27.2019.11.26.21.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 21:30:03 -0800 (PST)
From:   Vasily Khoruzhick <anarsoul@gmail.com>
To:     Yangtao Li <tiny.windzz@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megous@megous.com>,
        linux-kernel@vger.kernel.org
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH v6 2/7] dt-bindings: thermal: add YAML schema for sun8i-thermal driver bindings
Date:   Tue, 26 Nov 2019 21:29:30 -0800
Message-Id: <20191127052935.1719897-3-anarsoul@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127052935.1719897-1-anarsoul@gmail.com>
References: <20191127052935.1719897-1-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

sun8i-thermal driver supports thermal sensor in wide range of Allwinner
SoCs. Add YAML schema for its bindings.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 .../thermal/allwinner,sun8i-a83t-ths.yaml     | 103 ++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml

diff --git a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
new file mode 100644
index 000000000000..e622f0a4be90
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
@@ -0,0 +1,103 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/allwinner,sun8i-a83t-ths.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner SUN8I Thermal Controller Device Tree Bindings
+
+maintainers:
+  - Yangtao Li <tiny.windzz@gmail.com>
+
+properties:
+  compatible:
+    oneOf:
+      - const: allwinner,sun8i-a83t-ths
+      - const: allwinner,sun8i-h3-ths
+      - const: allwinner,sun8i-r40-ths
+      - const: allwinner,sun50i-a64-ths
+      - const: allwinner,sun50i-h5-ths
+      - const: allwinner,sun50i-h6-ths
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    anyOf:
+      - items:
+        - const: bus
+        - const: mod
+      - items:
+        - const: bus
+
+  '#thermal-sensor-cells':
+    enum: [ 0, 1 ]
+    description: |
+      Definition depends on soc version:
+
+      For "allwinner,sun8i-h3-ths",
+      value must be 0.
+      For all other compatibles
+      value must be 1.
+
+  nvmem-cells:
+    maxItems: 1
+    items:
+      - description: Calibration data for thermal sensors
+
+  nvmem-cell-names:
+    items:
+      - const: calibration
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - '#thermal-sensor-cells'
+
+examples:
+  - |
+    ths_a83t: ths@1f04000 {
+         compatible = "allwinner,sun8i-a83t-ths";
+         reg = <0x01f04000 0x100>;
+         interrupts = <0 31 0>;
+         nvmem-cells = <&ths_calibration>;
+         nvmem-cell-names = "calibration";
+         #thermal-sensor-cells = <1>;
+    };
+  - |
+    ths_h3: ths@1c25000 {
+         compatible = "allwinner,sun8i-h3-ths";
+         reg = <0x01c25000 0x400>;
+         clocks = <&ccu 0>, <&ccu 1>;
+         clock-names = "bus", "mod";
+         resets = <&ccu 2>;
+         interrupts = <0 31 0>;
+         nvmem-cells = <&ths_calibration>;
+         nvmem-cell-names = "calibration";
+         #thermal-sensor-cells = <0>;
+    };
+  - |
+    ths_h6: ths@5070400 {
+         compatible = "allwinner,sun50i-h6-ths";
+         reg = <0x05070400 0x100>;
+         clocks = <&ccu 0>;
+         clock-names = "bus";
+         resets = <&ccu 2>;
+         interrupts = <0 15 0>;
+         nvmem-cells = <&ths_calibration>;
+         nvmem-cell-names = "calibration";
+         #thermal-sensor-cells = <1>;
+    };
+
+...
-- 
2.24.0

