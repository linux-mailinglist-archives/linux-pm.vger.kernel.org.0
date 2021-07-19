Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5CA3CCCC4
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jul 2021 05:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbhGSDpy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 18 Jul 2021 23:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234435AbhGSDpw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 18 Jul 2021 23:45:52 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9B3C061762;
        Sun, 18 Jul 2021 20:42:53 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id i16-20020a17090acf90b02901736d9d2218so11553427pju.1;
        Sun, 18 Jul 2021 20:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1JuzSaJeX++ckGWb53wf2z0OIXSlH3HjOOCWZ8LzlB8=;
        b=rfSFdAuoGFQZVDyuWy2BxzI4AynDBx0hHl/9vKjc/eQQCvce5P3ypRQpz2bPirqGtz
         go9HCGb+7ZsMzw/bjmIFgomUGOjp/TquQ1Tqrn8Sk6A/D75sutnN3nn/H6RgWg9POzA0
         EI3rlPPbv/xgW6V08J439/bZ92EzXtGOnWa0e7NqozCRzQKTxUAvqOPM6Y+7MPoCcJz0
         aPMvgYjOgH7L9XoEgv5nsQFfHewqOuYw3bV7QsSBwOCmybmgbnL0aAd7SD5UaDPSfhpf
         pkKU38njatxDC4c1S1i7w6OjRmQyura23jmA6Ry4dyrzjmrk7hYClCU5RotbuJrJVkYv
         um2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1JuzSaJeX++ckGWb53wf2z0OIXSlH3HjOOCWZ8LzlB8=;
        b=lzg00pyiiCfc205GhMzpU9Jq5IMiXK1icY5p4tlWmqwNcKH9Ry+RVaQHnriC8K0wBE
         3dwYSJto3DoYVZhDA6x/tI0O5ziZwfuory7N8tEP1mmOLmK/bNSeZ9Zah428/G3Bh5+Y
         1czVKKqo4EWGQN/Hjv1o+SlM3Mx54O4i7PBTPs9vvlE70V7PBQCu0vsQ12gVGwtfVf5d
         9fEPii5zEYf1pPf03DMi3Db5l66jHsEPOkkz3v1ww0Vz9xCp6elQDzm4CM/ODNGFCL9o
         Se1fzjwGxfRCmurLmxqKXxgwBL7I0ZBP0jWSuqJQlHNshkseDr/YXEcNGyPu0tnAbLEC
         jBgg==
X-Gm-Message-State: AOAM5339wsXk0yDH6pl8H0p7m38UXo6HSMDe2nnGob/zkExbEYTVUNVF
        kt7EOW2wJ3PfCepGwHCvnxM=
X-Google-Smtp-Source: ABdhPJzp+ue0kBm5Uego9ybT0VJOyR3eJwMn50/b15mFJpH6Aah0Q2o50anwEnDpFt2fn7k+QVNuAA==
X-Received: by 2002:a17:90b:347:: with SMTP id fh7mr28330233pjb.2.1626666173545;
        Sun, 18 Jul 2021 20:42:53 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:58d:ffe9:427:42b0:88c7:1ff9])
        by smtp.gmail.com with ESMTPSA id c12sm17949448pfl.27.2021.07.18.20.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 20:42:53 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     sre@kernel.org, matthias.bgg@gmail.com,
        matti.vaittinen@fi.rohmeurope.com
Cc:     broonie@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, gene_chen@richtek.com,
        Wilma.Wu@mediatek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com, sebastian.reichel@collabora.com,
        Rob Herring <robh@kernel.org>
Subject: [PATCH resend v6 2/3] dt-bindings: power: Add bindings document for Charger support on MT6360 PMIC
Date:   Mon, 19 Jul 2021 11:39:13 +0800
Message-Id: <20210719033914.16990-3-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210719033914.16990-1-gene.chen.richtek@gmail.com>
References: <20210719033914.16990-1-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Add bindings document for Charger support on MT6360 PMIC

Signed-off-by: Gene Chen <gene_chen@richtek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/power/supply/mt6360_charger.yaml | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/mt6360_charger.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/mt6360_charger.yaml b/Documentation/devicetree/bindings/power/supply/mt6360_charger.yaml
new file mode 100644
index 000000000000..b89b15a5bfa4
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
2.25.1

