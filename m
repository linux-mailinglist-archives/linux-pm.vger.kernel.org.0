Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 994A02A4359
	for <lists+linux-pm@lfdr.de>; Tue,  3 Nov 2020 11:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgKCKlq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Nov 2020 05:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbgKCKlp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Nov 2020 05:41:45 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41770C0613D1;
        Tue,  3 Nov 2020 02:41:44 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id g12so13356723pgm.8;
        Tue, 03 Nov 2020 02:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DocRIoraJwCc4pCxgMjpaBmhMvt70LApw/0AXvr850U=;
        b=i5AQzu/HzLImbAH0vojQljhX2dcdbQwywZb9q8tcJpOFdCm1m4l4SdwhYVCTy+mRNt
         zSxen4BalU0mPFGn9HCgE9j6PY9VNwzIi3Rn0jtB6RVl+m52edi069UliRk/h2jTVpz6
         4EGJ2JF2Ih8TO0gbyO1ugtpQXsGNnfEi72hB4hG2p+KXkFId57yCb6vIE4Blq4NgI/Pv
         D/XnGbLwS+UBiv+5Qh7HxdXVSjTkS957ltNSeGU/BDi7V7h+GCUSvegMicTDZnPP6j4U
         nKVXUMYmFmB4/2jmdah3nd55R4M5Z7jrruWnqLxudwa+65YnihFMopWB/AKojoxZkZAv
         iVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DocRIoraJwCc4pCxgMjpaBmhMvt70LApw/0AXvr850U=;
        b=avpBkTZRzDiv9B0c26oR4WjyWK4yOezmyehyCQRbEUvlZwaRw1f8zCuPBcKOw9BdgR
         FeJ1PO6pXf/O6bMKSncn+vTpLjBgT/Sr//K51GLuAksVGJtAfTm5CNZXDzVb3Z5Md7XH
         3o5i0kFydMema9bOEchuMEfI4VwPL5hFFhf0f/xynmVC5PB94vrNnO60LiRnk1FgxRzu
         IWPv0iKg51MZbg8fhi58CrPZVcE9uy5Mnns1gn9QXfMz0/UxYo/d3nGGQDx+WKCO12Zf
         aQi1KFhD2C9P+FKjvAwyN6sO4VifRoEPI6c0d6dyloZIiNLcohWieUDGhJf9Lw4oHEeZ
         diKg==
X-Gm-Message-State: AOAM531IqGVlmfGppnpmpg2Ip41v43F4bd6rSfUjOn64HhwCRaRcoKra
        SPY4ksUzUEyCu9+UsplzGPQ=
X-Google-Smtp-Source: ABdhPJzNFDYFuzU0bZZXg6OnHEiPLOo0Niu/3APBFyIUFWx0UM+AXqL2o0EpsKMJvEcoE8X3+sC9aA==
X-Received: by 2002:a17:90a:cf18:: with SMTP id h24mr3247961pju.72.1604400103861;
        Tue, 03 Nov 2020 02:41:43 -0800 (PST)
Received: from localhost.localdomain ([2402:7500:57a:6823:8ab3:4b5d:4c53:f39b])
        by smtp.gmail.com with ESMTPSA id 26sm5235537pgm.92.2020.11.03.02.41.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2020 02:41:43 -0800 (PST)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     sre@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v2 1/2] dt-bindings: power: Add bindings document for Charger support on MT6360 PMIC
Date:   Tue,  3 Nov 2020 18:41:30 +0800
Message-Id: <1604400091-14618-2-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604400091-14618-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1604400091-14618-1-git-send-email-gene.chen.richtek@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Add bindings document for Charger support on MT6360 PMIC

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 .../bindings/power/supply/mt6360_charger.yaml      | 48 ++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/mt6360_charger.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/mt6360_charger.yaml b/Documentation/devicetree/bindings/power/supply/mt6360_charger.yaml
new file mode 100644
index 0000000..b89b15a
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/mt6360_charger.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/mt6360_charger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Battery charger driver for MT6360 PMIC from MediaTek Integrated.
+
+maintainers:
+  - Gene Chen <gene_chen@richtek.com>
+
+description: |
+  This module is part of the MT6360 MFD device.
+  Provides Battery Charger, Boost for OTG devices and BC1.2 detection.
+
+properties:
+  compatible:
+    const: mediatek,mt6360-chg
+
+  richtek,vinovp-microvolt:
+    description: Maximum CHGIN regulation voltage in uV.
+    enum: [ 5500000, 6500000, 11000000, 14500000 ]
+
+
+  usb-otg-vbus-regulator:
+    type: object
+    description: OTG boost regulator.
+    $ref: /schemas/regulator/regulator.yaml#
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    mt6360_charger: charger {
+      compatible = "mediatek,mt6360-chg";
+      richtek,vinovp-microvolt = <14500000>;
+
+      otg_vbus_regulator: usb-otg-vbus-regulator {
+        regulator-compatible = "usb-otg-vbus";
+        regulator-name = "usb-otg-vbus";
+        regulator-min-microvolt = <4425000>;
+        regulator-max-microvolt = <5825000>;
+      };
+    };
+...
-- 
2.7.4

