Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC352A662
	for <lists+linux-pm@lfdr.de>; Sat, 25 May 2019 20:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfEYSNj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 25 May 2019 14:13:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42148 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbfEYSNh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 25 May 2019 14:13:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id r22so4328258pfh.9;
        Sat, 25 May 2019 11:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G+xQDY4NgbdOhNfnVsTOZ1zXd6nCy3MVGYQPOyxe4yI=;
        b=FS4CgB9gYD6Eg2VljLyZogHNHtVp41eRjKNEh7vZJ8R7KkzouEFVN1rKJe5QJ/mcdI
         hzh3oRKmWkvDyf09nsIVPxZtYXKEG4S6A61SupalYg5P9LWi0y3Zn8OUvinwc0JLfbUq
         A4pKoYel9h8ekqt26ctgWGq9qmAr9pw/x6+oeVwpYYHRYkYq5KNs+uEgM1OyAHkSxk0I
         qjCtaemHqYnUPaQWq3gvp15hk9rHwoESYdCKd8GpExiXfHGJMD6HYD/bhNJQih2pQ2dc
         er/qTfweb/0hg7LSDlzrqX7gFWaF1tkqMjXEp8ejeOxFzQn4kUBg9jjZi/R1SuPE2gHG
         hTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G+xQDY4NgbdOhNfnVsTOZ1zXd6nCy3MVGYQPOyxe4yI=;
        b=XXDEMniP3JY5mBLJPMvsdj6HrJM4Hj9J5JMdl5bC3at4objwGmVwsWU+IVSk5UWBiT
         cv/brmrUAwGDUUNNTob17wqR6yCd/I3dQYMe9GKc9vJEpZ66HbPkaAXAO4J/IUMP1K/O
         pAvYPpGmt2peo0+YRhd30h3+St1cPafdCH8+aIG2nsDhL2cG/4YwhbZL2UhV+vbau2ff
         AM1CrK9wXLr6rageKZbVcrY/37H9uQz2KdnsbLpp2Su5ZcAQ+qWtnKBqs6ZpUIgfCdsV
         hG10KNydH1VfkRve/GZI+IJnIM33hzHUupGMPZa6N521JSk05GQ5wfJLf5h1i+KrzJOc
         rvdA==
X-Gm-Message-State: APjAAAWhDRowcdVpyjIBOl2aEwzz7ksirkFLRFyBwj28MXaJcI1dqwSi
        AzvA9gDQJOGNFhCnmKttDKQ=
X-Google-Smtp-Source: APXvYqy9G1fyaENg/3CGzNWn7jnGIZjEs0X/vD+ci2R8s+qv434po80SA5TWA1V8/lfEZLr5gXKSXQ==
X-Received: by 2002:aa7:98c6:: with SMTP id e6mr119766182pfm.191.1558808017054;
        Sat, 25 May 2019 11:13:37 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id 127sm6623553pfc.159.2019.05.25.11.13.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 May 2019 11:13:36 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, linus.walleij@linaro.org,
        nicolas.ferre@microchip.com, paulmck@linux.ibm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v3 2/3] dt-bindings: thermal: add binding document for h6 thermal controller
Date:   Sat, 25 May 2019 14:13:28 -0400
Message-Id: <20190525181329.18657-3-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190525181329.18657-1-tiny.windzz@gmail.com>
References: <20190525181329.18657-1-tiny.windzz@gmail.com>
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
index 000000000000..54cf1277870e
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
+    items:
+      - description: ths bus clock
+
+  clock-names:
+    items:
+      - const: bus
+
+  "#thermal-sensor-cells":
+    enum: [ 0, 1 ]
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
+  - interrupts
+  - reset
+  - clocks
+  - clock-names
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
2.17.0

