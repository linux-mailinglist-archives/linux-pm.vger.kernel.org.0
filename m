Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0C62FA036
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 13:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404201AbhARMmn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jan 2021 07:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404195AbhARMmj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2021 07:42:39 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBCEC061574;
        Mon, 18 Jan 2021 04:41:59 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id r4so8576157pls.11;
        Mon, 18 Jan 2021 04:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LevLbOCn+wWVy1pSLuh/5mjmYuoAJpxbht7K62GCCWA=;
        b=TJd4T2BeDxzLCoqjwoGu3zS2UKxa+G11wyaADQoVAXFk45xEP7GlVaUp/yO+RrAvQv
         p/Ya6QNpi7YrATI+Ko2KUBKgMnKWp6n/UY6hZzD54fHYevXh5D+HjY5Fi4C/v4ahZ0vk
         FwDH4++2YZueH1FFvuii66SnD4fTM/qMCJTMh8eVMIae5UzLtjR5hcsUk1xu0CBiFSzP
         NEGIXaRx+gZeRDUC+qoTzn7ZN/0RHfoAcii75A52L719pt6TDjwidGZrdcJE9QWvhQ0j
         rVKKuUN3VLXs6jXGzzFOVT6peF/ieiJ2j7fV917on+4ch2rUHVJdp5tsHDiC2UCNvkUG
         XKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LevLbOCn+wWVy1pSLuh/5mjmYuoAJpxbht7K62GCCWA=;
        b=E0PbBXCWe4d9dkPk+zIq+YP01Ti9hZ8qFRiZlwjVpAPySJiFJk1ks67bc42FyoQv9l
         QE1P48opQRAS3N1Z9/8Rfms5HVFaaQTSN0v/N2aiERw8DLS17BH1s+FbhQsKF8KHz2KX
         jh69zf+lZ8t39D63JWBc3b43/JYHUkSB9w9ks/zR/lkvAR47OvxD8BO+6sfTPDOj6uu0
         /L/sMaOrIXXkRXs5Xj+QlQ/DeT4Z171Qvu4hGZamqHltSPcTKQOXM+VY7wJ1iYHVGR5W
         3RXkzjHLGtJdjQ3lSjN8Dhw6PNpACd56fAM7DRlPzZ4YzDVHE4qJ72ZUA4p9k1FsEYmG
         1juw==
X-Gm-Message-State: AOAM531mDHPxuzITcWhbfsQRphcGrJX5PFEUAsv15Ch6dLyKXANGpxIx
        FD1niQ0hxivc+oSiVHIX5mY=
X-Google-Smtp-Source: ABdhPJw3Oabx0M15W9R/YssWtIM/hMbMPttfatugEnRjKI6KOwhPbiLN5GdY98Jj1TTA4YFFZtW0Sw==
X-Received: by 2002:a17:902:d4d1:b029:de:30a4:360f with SMTP id o17-20020a170902d4d1b02900de30a4360fmr26446042plg.83.1610973718920;
        Mon, 18 Jan 2021 04:41:58 -0800 (PST)
Received: from localhost.localdomain ([2402:7500:57a:fa4f:eecf:e69a:c4f:ee4e])
        by smtp.gmail.com with ESMTPSA id np7sm15563431pjb.10.2021.01.18.04.41.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2021 04:41:58 -0800 (PST)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     sre@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v4 1/2] dt-bindings: power: Add bindings document for Charger support on MT6360 PMIC
Date:   Mon, 18 Jan 2021 20:41:42 +0800
Message-Id: <1610973703-676-2-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1610973703-676-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1610973703-676-1-git-send-email-gene.chen.richtek@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Add bindings document for Charger support on MT6360 PMIC

Signed-off-by: Gene Chen <gene_chen@richtek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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

