Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 654CB4FCF0
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jun 2019 18:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfFWQmQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Jun 2019 12:42:16 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41192 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfFWQmP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Jun 2019 12:42:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id m30so6103234pff.8;
        Sun, 23 Jun 2019 09:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GJ1/rKutIQEKHvyH14ecs6l1ZdLbW/7MgqbbW+zZyME=;
        b=aPkTDQYg6YxMR3LTtRqUOO2PX5D4buJBQKeJG5SSksdp94O1WOG6qh7fzioBgPa3I9
         hC6vdUBCy3i4vqfbfzBTA/md92U4B/cEKPIelHy0Q3bl9TkucGocmA290racdD5hqA+D
         /l1E+fld70hWvvHqRU9W0Hl0SiUJelPC8gB4jRE1AXcm9za3kNhEYLxEjdVMP2lVRP/u
         q68qtw9uV3ZNjoh+qa2qr3NpaKh/sVlNciRaVcdWxwiQLWsDJGeP9N42hO1pWYH9u6hW
         wM1OpitX/5R8JL7GRo8ez064bZhvDxyKXToUaaYc1pEbJS8fEUhWqhXsCOJnA7JigVzr
         RVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GJ1/rKutIQEKHvyH14ecs6l1ZdLbW/7MgqbbW+zZyME=;
        b=Vg+8j1sC9a9om6KwtoNfhgP4khAd1lVmIqzrXGjVazokc0gIEOnTTPBplqOYZj+yN1
         Dvi/eIAeccYo47ya+N7UaTBUwh6yildp8Jm9qJ6E249LwsdOCO2iOzi3R2g/1dUhZo/H
         XfEqMD6MMOTGSgNFB7ULKrKKbCvrKlbyW4MWwXxYZ4jbmfNaZiYTnCQtVtTP3SovhyX/
         TteF9enfs82+Zk3iFKlV566ZzpXXjYZG98G0wNfLYXW9ecEaP4BqKv/cW0XMB8UAsMil
         TcjjTXgEkMKxgzDL9hopAvgmbGK/uo4sQR6hClHPsuqWVPYKeIAygb7pnx0Ov8d2siXM
         qHng==
X-Gm-Message-State: APjAAAUw0gbmuXWWwQN7i551sdkB4VlTVyAPwkOfh6ksUvvdNJNobkVj
        vmdFD4p5s7SOxosk+Imb85k=
X-Google-Smtp-Source: APXvYqzr3IL15+QRlPgzFQhfOuJbPNix+LH7PczxPb49B9YhZvIzUrQxfMsNEB8dxxedXBBzTMPQWw==
X-Received: by 2002:a63:4553:: with SMTP id u19mr28484919pgk.420.1561308134980;
        Sun, 23 Jun 2019 09:42:14 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id k16sm9059855pfa.87.2019.06.23.09.42.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Jun 2019 09:42:14 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        mchehab+samsung@kernel.org, linus.walleij@linaro.org,
        nicolas.ferre@microchip.com, paulmck@linux.ibm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v4 02/11] dt-bindings: thermal: add binding document for h6 thermal controller
Date:   Sun, 23 Jun 2019 12:41:57 -0400
Message-Id: <20190623164206.7467-3-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190623164206.7467-1-tiny.windzz@gmail.com>
References: <20190623164206.7467-1-tiny.windzz@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds binding document for allwinner h6 thermal controller.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 .../bindings/thermal/sun8i-thermal.yaml       | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml b/Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
new file mode 100644
index 000000000000..2c5acc61ed03
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/sun8i-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner SUN8I Thermal Controller Device Tree Bindings
+
+maintainers:
+  - Yangtao Li <tiny.windzz@gmail.com>
+
+description: |-
+  This describes the device tree binding for the Allwinner thermal
+  controller which measures the on-SoC temperatures.
+
+properties:
+  compatible:
+    enum:
+      - allwinner,sun50i-h6-ths
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
+    maxItems: 1
+
+  clock-names:
+    const: bus
+
+  '#thermal-sensor-cells':
+    const: 1
+
+  nvmem-cells:
+    items:
+      - description: ths calibrate data
+
+  nvmem-cell-names:
+    items:
+      - const: calib
+
+required:
+  - compatible
+  - reg
+  - reset
+  - clocks
+  - clock-names
+  - interrupts
+  - '#thermal-sensor-cells'
+
+examples:
+  - |
+    ths: ths@5070400 {
+         compatible = "allwinner,sun50i-h6-ths";
+         reg = <0x05070400 0x100>;
+         clocks = <&ccu CLK_BUS_THS>;
+         clock-names = "bus";
+         resets = <&ccu RST_BUS_THS>;
+         interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+         nvmem-cells = <&tsen_calib>;
+         nvmem-cell-names = "calib";
+         #thermal-sensor-cells = <1>;
+    };
+
+...
-- 
2.17.1

