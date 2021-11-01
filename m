Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D44C441595
	for <lists+linux-pm@lfdr.de>; Mon,  1 Nov 2021 09:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbhKAIry (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Nov 2021 04:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbhKAIrx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Nov 2021 04:47:53 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E58C061746;
        Mon,  1 Nov 2021 01:45:19 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id om14so11650026pjb.5;
        Mon, 01 Nov 2021 01:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DekNLEfhhgLvATAHmAlir4Xk1UwXtcvay+PcI5jYhb0=;
        b=DhZHZkgukvhWnsld3/nxeteD0mpgKJ3U3aHd+0EgMsfh5yNPD8pMW1mtA3VFxJr+Gg
         PgogT7rViQu61TyRlGn8vdie+cEUlAUS/MtIESwMhIpDaBytO11rveddQOWXqz4RU0Km
         ytcAo5SBOFNTZFPSf5IYMYEeHpg1S8NIs1c9la8jTExJQ4bH2adP/uhzTqmhNRNtZZZ/
         061mC4NNaSGEs7CurV4UjiTmKAoihG9yf4XV6fkfyTC5PYNqUMzh+yMMGZ/Yq0aE6WAh
         CZ0GSAUEdt8TomxsneykM46RwqrBP4ntNw8J0P0HokaKC9JgD4Q2bIyhpSSR5wyRmaJh
         JLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DekNLEfhhgLvATAHmAlir4Xk1UwXtcvay+PcI5jYhb0=;
        b=ItJzNPhGDbAGYhXgmjAItNFj0XTuaXp5SRf45ih0pXIhELCZp+GqwMJkSDsyy1DqK+
         3/oNNJhkfG8b4RQCnBrWcaqSCJ+ml59P6/ZLwRCkz4ZMIyEdg1mvc/ysBZFVfkmLI5nz
         tKNPnO6FPJ9SIVVEbxjq6vtG06z0nPws1lKRb7Cr4ypEguePKnlQcfUPyX3cGz0cXemF
         yW6VIfplBNnddP4to9f1J0inTwHmoFfibmzHxZTl3S2eMAjUxMQFaQqcUx4+StTbV+kK
         TSUwFVMu2FV2jMe2aSy4yEtSd8aIyfEkPKNvtN8HBe7TwYWsRC7kuNeDgkVFZcN3OeSU
         tD1g==
X-Gm-Message-State: AOAM530vAKPqJNCNfZOXc2DmmJjo5VV31Ub8KIfN8iJjdosVR5EBXan0
        EyvaBJOutmYvU4vmHwFGecg=
X-Google-Smtp-Source: ABdhPJwpAGf5449u2A8iy5LG/WkxsJjrEQiZWq714+cO4aQXKm92kn0lu/SbogKFNJ45D+NlnxfLrg==
X-Received: by 2002:a17:903:244d:b0:140:6573:43ce with SMTP id l13-20020a170903244d00b00140657343cemr24110005pls.54.1635756318415;
        Mon, 01 Nov 2021 01:45:18 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id nv5sm13406574pjb.10.2021.11.01.01.45.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Nov 2021 01:45:18 -0700 (PDT)
From:   "LH.Kuo" <lhjeff911@gmail.com>
X-Google-Original-From: "LH.Kuo" <lh.kuo@sunplus.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     qinjian@cqplus1.com, wells.lu@sunplus.com,
        "LH.Kuo" <lh.kuo@sunplus.com>
Subject: [PATCH 2/2] devicetree bindings THERMAL Add bindings doc for Sunplus SP7021
Date:   Mon,  1 Nov 2021 16:45:10 +0800
Message-Id: <1635756310-25415-3-git-send-email-lh.kuo@sunplus.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1635756310-25415-1-git-send-email-lh.kuo@sunplus.com>
References: <1635756310-25415-1-git-send-email-lh.kuo@sunplus.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add devicetree bindings THERMAL Add bindings doc for Sunplus SP7021

Signed-off-by: LH.Kuo <lh.kuo@sunplus.com>
---
 .../bindings/thermal/sunplus_thermal.yaml          | 52 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sunplus_thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/sunplus_thermal.yaml b/Documentation/devicetree/bindings/thermal/sunplus_thermal.yaml
new file mode 100644
index 0000000..1875d04
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/sunplus_thermal.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) Sunplus Co., Ltd. 2021
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/sunplus_thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sunplus Thermal controller
+
+maintainers:
+  - lh.kuo <lh.kuo@sunplus.com>
+
+properties:
+  compatible:
+    enum:
+      - sunplus,sp7021-thermal
+
+  reg:
+    items:
+      - description: Base address and length of the Thermal registers
+      - description: Base address and length of the Thermal calibration registers
+
+  reg-names:
+    items:
+      - const: thermal_reg
+      - const: thermal_moon4
+
+  nvmem-cells:
+    maxItems: 1
+
+  nvmem-cell-names:
+    const: therm_calib
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - nvmem-cells
+  - nvmem-cell-names
+
+additionalProperties: false
+
+examples:
+  - |
+    thermal: serial@9c000280 {
+        compatible = "sunplus,sp7021-thermal";
+        reg = <0x9c000280 0x80>, <0x9c000200 0x80>;
+        reg-names = "thermal_reg", "thermal_moon4";
+        nvmem-cells = <&therm_calib>;
+        nvmem-cell-names = "therm_calib";
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index dff822b..2080b00 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17949,6 +17949,7 @@ SUNPLUS THERMAL DRIVER
 M:	LH Kuo <lh.kuo@sunplus.com>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/thermal/sunplus_thermal.yaml
 F:	drivers/thermal/sunplus_thermal.c
 
 SUPERH
-- 
2.7.4

