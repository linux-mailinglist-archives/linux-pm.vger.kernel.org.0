Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF902E254C
	for <lists+linux-pm@lfdr.de>; Thu, 24 Dec 2020 08:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgLXHuM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Dec 2020 02:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgLXHuM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Dec 2020 02:50:12 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08D8C06179C;
        Wed, 23 Dec 2020 23:49:31 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id b5so780496pjk.2;
        Wed, 23 Dec 2020 23:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LevLbOCn+wWVy1pSLuh/5mjmYuoAJpxbht7K62GCCWA=;
        b=tzqbqwygQ3ka6OWxbTeYVwkeh8hblHBEAD/zgH6gju0AYFgvfPGps54I76kfpj0WlA
         iFSqCiI+8fIcB0xPWXqbLfL4+SrDHwHNNLla7xhwtKUjYDNWtg4DSSKqsZzgP0FkYj1a
         c6lSTHKtK5AdzTrTdT7Yi5duh9c2YfnZibDxGdtYkwCN5n8Xfis464wkVkF+5/v2Kmnv
         EI6KtE/oduiYNZgcihpXL/IP4ghYUHY8lLi12Cex2ekQi/S/hx0OLX0PvMGKNZ8BE+jS
         DlCu6e64J49RcgRN0vBZvMIk2kAZtoPLRxOlSkqKwevB24wVy/ehTTxyRuLqjiW78rhI
         1a3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LevLbOCn+wWVy1pSLuh/5mjmYuoAJpxbht7K62GCCWA=;
        b=XVziMJY0fp/jHTL3KIEpKY3RfqFUEwUEcYXbtSicnwzzBFYT2mu4XTGagsPsrm/PVd
         XqP+KzGwTzpCLE83v0+nq93+6WjBEqKGtQbMDCEYURqGtLpXgF/C8Zd+M6vjZYOZOWO4
         D5XLewxT93l0pGWk9+xQ6S/FeCji1lp6rJbxvQIIn3IrapBcSdHsVvFqRbee9P5Yz9HK
         5zJCdDrzUT8kjCE1MPSrDxgtyNTetHn9jfB+wc7yrpkDbfHKsJyUlA69PD2BK2qjfpxc
         UD/8Ev6MmutYyMElLSI32el3rGEtf+NLjAnwfWHw1jlNf5fahshjLEWzTRs25nX/04TW
         Gibg==
X-Gm-Message-State: AOAM533v8JKYUvFVEEbWYUyZuFZmGBarOsmb/m3PMEwYIkkt3sEbX6L9
        5lYtp2VnS72f0FLoWkpJ4Io=
X-Google-Smtp-Source: ABdhPJz44WBFy35ALxHWjoN7jxZoDC0DXsbw3FdnIR9Ez4VsXCyW+8X/UpApzBCC2Bl6urjQFhbJLQ==
X-Received: by 2002:a17:902:7e42:b029:dc:f98:44e2 with SMTP id a2-20020a1709027e42b02900dc0f9844e2mr28256913pln.49.1608796171402;
        Wed, 23 Dec 2020 23:49:31 -0800 (PST)
Received: from localhost.localdomain ([2402:7500:492:86cf:7e4a:b265:b394:eefd])
        by smtp.gmail.com with ESMTPSA id y9sm1743507pjt.37.2020.12.23.23.49.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Dec 2020 23:49:30 -0800 (PST)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     sre@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v3 1/2] dt-bindings: power: Add bindings document for Charger support on MT6360 PMIC
Date:   Thu, 24 Dec 2020 15:48:03 +0800
Message-Id: <1608796084-29418-2-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1608796084-29418-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1608796084-29418-1-git-send-email-gene.chen.richtek@gmail.com>
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

