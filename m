Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CC9275705
	for <lists+linux-pm@lfdr.de>; Wed, 23 Sep 2020 13:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgIWLSi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Sep 2020 07:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgIWLSi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Sep 2020 07:18:38 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FE4C0613CE;
        Wed, 23 Sep 2020 04:18:38 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id f2so14192056pgd.3;
        Wed, 23 Sep 2020 04:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7WNGKPx7P80fSH8HCUI8e1FELBKekz/aYKgxcKHN5ds=;
        b=fLswLrk+e7QN82DV+NF1kTEJSNPNUN/srUAt5gMWtLZMkHrb4UbLKgx4r3IkHbPpN/
         1iMmRXtqrj7Xefvf6Pjk14wawK4M9if8nUOG8IRRS2C0eLm4nE2b2EmegCRq/1MsZClp
         p/KmYzVy0a+ZIgo7dY4U7vS5ezZsutdJybqqamuB+AXbYyvo9+1CjtOJ2BDKM8kTdAJf
         MtTH6FzgEBz2bFoqrDCeDSixXloPviCZlgTug14Fq88EeQA5QW3BfMdtnD7NBPUKhjDA
         iklYpeP23Dbz37yYpHefzBIMzDhOnwd8tAmdb5Ez4b9kNuEtvkL3Lwuy+4iMKiQsIQnA
         ySgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7WNGKPx7P80fSH8HCUI8e1FELBKekz/aYKgxcKHN5ds=;
        b=tgf9ywQOI5wMxyVErvw1+mv8iY6UyNGAzYzqNKbIF1Zou0dbmwUc5bn3M38AHSMLbb
         cwMUeP2d3PX9xCbL2BxUQ1LxZRXwUxIaksuXsGW4385SIPs50EE0bzHBhFPpTpuFZPQE
         Vni6cq8eooKY81VZEGThI669vcQepE8N8Yq4i77xLYm7b80oKMToUgPajyUMyTkHDPi5
         F4JL3djt+v3WkZLyYu97p5gc4QPPlK0VNmYysbH2g4j+BFf0efrECz1+oalh5KHjBmub
         Kwe7bOx5q/W/MtlXeiSmqXoFvgCACarYaAsmEKQorVHo90o+5c7+ACTeSvJYM57+MDy0
         8UVw==
X-Gm-Message-State: AOAM532Jo+c+R9sGR04+pr+GOroFX8RS3S0IGd7krjpOJr7N6dGZUwB1
        2jArJzHaY3LPS/FbUTBRrto=
X-Google-Smtp-Source: ABdhPJwJ3sGbKfNfOeDqNYze2sgU8ZtcXt+CyLHpXNk8j1WSvxzSE/U9SkUgM3Bo2HbUrGN6JQ7EsQ==
X-Received: by 2002:a63:547:: with SMTP id 68mr4498525pgf.177.1600859917914;
        Wed, 23 Sep 2020 04:18:37 -0700 (PDT)
Received: from localhost.localdomain ([117.19.194.39])
        by smtp.gmail.com with ESMTPSA id 25sm17549693pfj.35.2020.09.23.04.18.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Sep 2020 04:18:37 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     sre@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gene Chen <gene_chen@richtek.com>
Subject: [PATCH 1/2] dt-bindings: power: Add bindings document for Charger support on MT6360 PMIC
Date:   Wed, 23 Sep 2020 19:18:29 +0800
Message-Id: <1600859910-15855-1-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Add bindings document for Charger support on MT6360 PMIC

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 .../bindings/power/supply/mt6360_charger.yaml      | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/mt6360_charger.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/mt6360_charger.yaml b/Documentation/devicetree/bindings/power/supply/mt6360_charger.yaml
new file mode 100644
index 0000000..711fc19
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/mt6360_charger.yaml
@@ -0,0 +1,44 @@
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
+  vinovp:
+    description:
+      Maximum CHGIN regulation voltage.
+
+  usb-otg-vbus:
+      $ref: /schemas/regulator/regulator.yaml#
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    mt6360_chg: chg {
+      compatible = "mediatek,mt6360-chg";
+      vinovp = <14500000>;
+      otg_vbus: usb-otg-vbus {
+        regulator-compatible = "usb-otg-vbus";
+        regulator-name = "usb-otg-vbus";
+        regulator-min-microvolt = <4425000>;
+        regulator-max-microvolt = <5825000>;
+      };
+    };
+...
-- 
2.7.4

