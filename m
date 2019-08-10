Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7B7C88866
	for <lists+linux-pm@lfdr.de>; Sat, 10 Aug 2019 07:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfHJF3R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Aug 2019 01:29:17 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37401 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfHJF3R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Aug 2019 01:29:17 -0400
Received: by mail-pg1-f196.google.com with SMTP id d1so14035611pgp.4;
        Fri, 09 Aug 2019 22:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WD7K8OdpREzm1d+Yp/Bs4WvDvu3iqySNq1hJesChH3M=;
        b=ZjZzeIglNii9MVXF4P8OwuiKgvJ2AHN60l4wGAcONk09u1ivPdMkqI43JqxPDri+QV
         PB7H0lw2f709GHYwg8FyAv7TLYfOtBcTEAHgEXmuJGAtb/pGf948Gw/pq5z+ObqEqiXB
         +b8C7S2ZilSzoKFdc98s2LsPtBS31O5PClOucmS+EebLVEBlcsvNFm9JH2WM/Nunka5I
         qutMLMsCHQ9F5bGjneCFosdCy0NTeuj61nsSVehEjP+jf9VzKBnOwEXj4ErcqdbK82gx
         cs09OuO4nIZkTGqUeR3Il7kHmrEAKg6/d++iHP2zpXtSH7PUTO03SfQSZfakvFpXnndq
         lk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WD7K8OdpREzm1d+Yp/Bs4WvDvu3iqySNq1hJesChH3M=;
        b=VbNJUamJmHFCBVbJaaqifoDmnP70H2cX3sSumDdKPIICA28L2sA2RxxVR738vXlPfO
         ilBCfAMoczRe4Lrn3v9Sh20DYMwXwLG86jzg7157EJno/cAGK08D97cP1CqRsEcJZu2j
         uRMMROjkHcl6wTk0gaZcSRCd71yLbADNvYGM/mCyaOpyLoFf8L/eqTeUW2j4d1eFX+tI
         mjbn7HgZKSGELSCThPuYZq7oTg1YfuhmNzSurw3rBnvp0vmJkg2sMJ3dekwMaRsfubdY
         yor3U1/mowzBZrpcFNIvaGYKHsXiZKRrct5Kc4z3fdPrzC0oFvZjbarlPln/YOggVcMz
         0TRQ==
X-Gm-Message-State: APjAAAVlB40y2oVTaWdI/8nnAeCfP4sVlPdRPGMKOaZeXH66HoL3hy33
        r8LSuza/jILkdBjHL4U0FlM=
X-Google-Smtp-Source: APXvYqxOuJTk2SD/x1hTFhYbreUKUwvlmtGBd51QcJppuCmzl0G9FTfJ2bbK6b1tELoE8SPSEf8lcg==
X-Received: by 2002:aa7:818b:: with SMTP id g11mr25731541pfi.122.1565414956974;
        Fri, 09 Aug 2019 22:29:16 -0700 (PDT)
Received: from localhost ([202.182.106.211])
        by smtp.gmail.com with ESMTPSA id k5sm6083835pjl.32.2019.08.09.22.29.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Aug 2019 22:29:16 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        nicolas.ferre@microchip.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v5 02/18] dt-bindings: thermal: add binding document for h6 thermal controller
Date:   Sat, 10 Aug 2019 05:28:13 +0000
Message-Id: <20190810052829.6032-3-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190810052829.6032-1-tiny.windzz@gmail.com>
References: <20190810052829.6032-1-tiny.windzz@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds binding document for allwinner h6 thermal controller.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 .../bindings/thermal/sun8i-thermal.yaml       | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml b/Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
new file mode 100644
index 000000000000..e0973199ba3c
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
@@ -0,0 +1,79 @@
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
+    maxItems: 1
+
+  clock-names:
+    const: bus
+
+  "#thermal-sensor-cells":
+    const: 1
+
+  nvmem-cells:
+    description: ths calibrate data
+
+  nvmem-cell-names:
+    const: calib
+
+required:
+  - compatible
+  - reg
+  - reset
+  - clocks
+  - clock-names
+  - interrupts
+  - "#thermal-sensor-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    ths: ths@5070400 {
+        compatible = "allwinner,sun50i-h6-ths";
+        reg = <0x05070400 0x100>;
+        clocks = <&ccu CLK_BUS_THS>;
+        clock-names = "bus";
+        resets = <&ccu RST_BUS_THS>;
+        interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+        nvmem-cells = <&tsen_calib>;
+        nvmem-cell-names = "calib";
+        #thermal-sensor-cells = <1>;
+    };
+
+    sid: sid@3006000 {
+        compatible = "allwinner,sun50i-h6-sid";
+        reg = <0x03006000 0x400>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        tsen_calib: calib@14 {
+                reg = <0x14 6>;
+        };
+    };
+...
-- 
2.17.1

