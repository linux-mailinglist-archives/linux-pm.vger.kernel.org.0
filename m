Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2279598745
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2019 00:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731130AbfHUWY1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Aug 2019 18:24:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45576 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729758AbfHUWY0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Aug 2019 18:24:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id q12so3456145wrj.12
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2019 15:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XcX2XfXI5RWl+qmPGtbnaP1+JiH+jtO4YYoKGP+64Jw=;
        b=Y19lRcDFSb95UM2o4oHaVdAKInX7LjtGZ7ONvY71k8sb/Qi4XJNB5NDm0gZnNN4X7m
         vNc1hVwSIMSEFjOv1lkFOHTZ1V9W26/uHhYWFn/Srei6PxJpDIF0gAasNX14rLuRZ4Mh
         m1MSnZcfCTJ+ZtRwjEmGq84hSXItsG/4WnwE3H4WiM3OqI6ZsuufCsxY1bZimNfMcBVE
         IDLvgqkRptXGX4iul+cGO8JqMB+n9kJiwCSJgSFQRnfBqc+QXSDOJBq6yie8VCCyaBX4
         ni0i6EQ5dKFOjV1IWf19d14VDfXrE/2LrshZ02orC624BzJvRl+WRTMxcVbcbiLx34wH
         JLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XcX2XfXI5RWl+qmPGtbnaP1+JiH+jtO4YYoKGP+64Jw=;
        b=rvL7Z801Gnu3hSCIElXoGbeYxNhD8qqn5l70VdzpSdFQn/LxYMvLnwtx80GVQmD6pV
         UJpNw582R+H4edCpdbX0McjnitamOntEc2CCJr5H+ILXLb+e6OGJntWyMORPt01aBzKo
         NNLXxr31gWd5WlCZ6X1RlIEjal0j/CKHsUgl8L5amO0sYm5VWiBEZh8xViZqDee0C1Sk
         MyPl2Uoa1guxMECwrnD03dgYbwY+EZbpPkHrUyAMmL5fmcVJqXun8DWzUVP7cRY6HKsg
         M9LHklH9AtjPMnvlv7AhxZJEVtLHikfGWPbJKPCFMwmu5gaG4wWSv3+NqoyiR45Zvymz
         JtFw==
X-Gm-Message-State: APjAAAULEIkjnM7TKxQFVpeU1c3314kfmb6hkmxd+SIP469K6CcIVvjE
        6FSELQ8gtIVRSGLcwqfztnuqdQ==
X-Google-Smtp-Source: APXvYqzio+ssPLSEM+HBqzThdCWa9cLYSj5TVfppU45s05F6VnVEL6giT+0XA9MorRrbp7MOZttjaQ==
X-Received: by 2002:a5d:6606:: with SMTP id n6mr45412511wru.346.1566426264948;
        Wed, 21 Aug 2019 15:24:24 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:6e7:d500:82a9:347a:43f3:d2ca])
        by smtp.gmail.com with ESMTPSA id f197sm3548549wme.22.2019.08.21.15.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 15:24:24 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v4 1/6] dt-bindings: thermal: Add DT bindings documentation for Amlogic Thermal
Date:   Thu, 22 Aug 2019 00:24:16 +0200
Message-Id: <20190821222421.30242-2-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821222421.30242-1-glaroque@baylibre.com>
References: <20190821222421.30242-1-glaroque@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Adding the devicetree binding documentation for the Amlogic temperature
sensor found in the Amlogic Meson G12 SoCs.
the G12A  and G12B SoCs are supported.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/thermal/amlogic,thermal.yaml     | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
new file mode 100644
index 000000000000..f761681e4c0d
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/amlogic,thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Thermal
+
+maintainers:
+  - Guillaume La Roque <glaroque@baylibre.com>
+
+description: Binding for Amlogic Thermal
+
+properties:
+  compatible:
+      items:
+        - enum:
+            - amlogic,g12a-cpu-thermal
+            - amlogic,g12a-ddr-thermal
+        - const: amlogic,g12a-thermal
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  amlogic,ao-secure:
+    description: phandle to the ao-secure syscon
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - amlogic,ao-secure
+
+examples:
+  - |
+        cpu_temp: temperature-sensor@ff634800 {
+                compatible = "amlogic,g12a-cpu-thermal",
+                             "amlogic,g12a-thermal";
+                reg = <0xff634800 0x50>;
+                interrupts = <0x0 0x24 0x0>;
+                clocks = <&clk 164>;
+                #thermal-sensor-cells = <0>;
+                amlogic,ao-secure = <&sec_AO>;
+        };
+...
-- 
2.17.1

