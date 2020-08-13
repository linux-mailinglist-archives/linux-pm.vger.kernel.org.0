Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A89F2440A0
	for <lists+linux-pm@lfdr.de>; Thu, 13 Aug 2020 23:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgHMVef (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 17:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbgHMVee (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 17:34:34 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18BBC061757;
        Thu, 13 Aug 2020 14:34:33 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id t23so7823763ljc.3;
        Thu, 13 Aug 2020 14:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yO29YDGuBtqi3W2Ytkv38r6JCCBE5Jw2QeGc0NUGWBo=;
        b=dJkbke/BSwBTQzlUTUwCrheZnN7Xv3dnQiWBS51aIOCl3Soj/2AHLspVne01kGXzJE
         9VbMB/cLvBzzLGHCl0tnsDKXZQynO40Opwt/FvyiCG9zljermb/uicaz0zomjETYj6ux
         zmksCqwu76qufPxBsONr+TJEQTidITKPdFSmxsSYFKl+yCDyr0v90k4vhsrEWChiuWD7
         Hpk9c0DJCgFiYif0nFRBEFafVz/yyyzpWlOMEoDVwsnLX69h71STvmoY71K98Leu88f6
         WUN0intA0K7PRZ+WwR3cu7SqpkS385XgBavm38/VPVme0AkDa99HZLIGMgpEBnTqUARI
         tGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yO29YDGuBtqi3W2Ytkv38r6JCCBE5Jw2QeGc0NUGWBo=;
        b=bVhNDCp7L2P/MBrzXTO5eK96qQX2RVQzxTe7mBhpjBokJpHMmDUSjjB/wMLx3eNfj/
         3PfO/sgNIoo+gS16FQKofL3jIj9bvEHWQWN/THBMhEC2YNbF+pforK+h4qVE69W+iTmX
         F+UUkURu/3CfHlfaK+gtuZXxHe/ebznuoMrdeXQQNfcaLMYbo8DkIZErPs5ZDPISHnrs
         xXMLa3ub6lSvGq/I5sxashQ4myqaorcJvPyIBIrn6oXtsjUO+BEQpYsDLPxb/a6rpod1
         McbPFn5eRZN997dNlMAWwEJwgVi2lxgojvMUXzeJ7BI5ufQZboKV9MmsZJKTN+iJ34R4
         ay3w==
X-Gm-Message-State: AOAM53298Wxlf5+Tgc+/6QuqeiVwS1WKfAxkuPIJFfL9xA5ZvbaaLiey
        htJtl8zIhg8Ah1huUcnq108=
X-Google-Smtp-Source: ABdhPJz1UIQ1B2CMDWWp9Ca5EXYgvhI3lrx+GPEzaTSWoAQ1DIijg1h10CYehPTKYGDxU6lO5YSslQ==
X-Received: by 2002:a2e:503:: with SMTP id 3mr3110264ljf.225.1597354472112;
        Thu, 13 Aug 2020 14:34:32 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id j2sm1345309ljb.98.2020.08.13.14.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 14:34:31 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Heidelberg <david@ixit.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Bruce E . Robertson" <bruce.e.robertson@intel.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        John Stultz <john.stultz@linaro.org>,
        Vinay Simha BN <simhavcs@gmail.com>,
        linux-tegra@vger.kernel.org
Subject: [PATCH v3 02/10] dt-bindings: power: supply: Add device-tree binding for Summit SMB3xx
Date:   Fri, 14 Aug 2020 00:34:01 +0300
Message-Id: <20200813213409.24222-3-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200813213409.24222-1-digetx@gmail.com>
References: <20200813213409.24222-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: David Heidelberg <david@ixit.cz>

Summit SMB3xx series is a Programmable Switching Li+ Battery Charger.
This patch adds device-tree binding for Summit SMB345, SMB347 and SMB358
chargers.

Signed-off-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../power/supply/summit,smb347-charger.yaml   | 152 ++++++++++++++++++
 .../dt-bindings/power/summit,smb347-charger.h |  19 +++
 2 files changed, 171 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml
 create mode 100644 include/dt-bindings/power/summit,smb347-charger.h

diff --git a/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml b/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml
new file mode 100644
index 000000000000..193a23af2007
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml
@@ -0,0 +1,152 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/summit,smb347-charger.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Battery charger driver for SMB345, SMB347 and SMB358
+
+maintainers:
+  - David Heidelberg <david@ixit.cz>
+  - Dmitry Osipenko <digetx@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - summit,smb345
+      - summit,smb347
+      - summit,smb358
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  monitored-battery:
+    description: phandle to the battery node
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  summit,enable-usb-charging:
+    type: boolean
+    description: Enable charging through USB.
+
+  summit,enable-otg-charging:
+    type: boolean
+    description: Provide power for USB OTG
+
+  summit,enable-mains-charging:
+    type: boolean
+    description: Enable charging through mains
+
+  summit,enable-charge-control:
+    description: Enable charging control
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 0 # SMB3XX_CHG_ENABLE_SW SW (I2C interface)
+      - 1 # SMB3XX_CHG_ENABLE_PIN_ACTIVE_LOW Pin control (Active Low)
+      - 2 # SMB3XX_CHG_ENABLE_PIN_ACTIVE_HIGH Pin control (Active High)
+
+  summit,fast-voltage-threshold-microvolt:
+    description: Voltage threshold to transit to fast charge mode (in uV)
+    minimum: 2400000
+    maximum: 3000000
+
+  summit,mains-current-limit-microamp:
+    description: Maximum input current from AC/DC input (in uA)
+
+  summit,usb-current-limit-microamp:
+    description: Maximum input current from USB input (in uA)
+
+  summit,charge-current-compensation-microamp:
+    description: Charge current compensation (in uA)
+
+  summit,chip-temperature-threshold-celsius:
+    description: Chip temperature for thermal regulation in °C.
+    enum: [100, 110, 120, 130]
+
+  summit,soft-compensation-method:
+    description: Soft temperature limit compensation method
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 0 # SMB3XX_SOFT_TEMP_COMPENSATE_NONE Compensation none
+      - 1 # SMB3XX_SOFT_TEMP_COMPENSATE_CURRENT Current compensation
+      - 2 # SMB3XX_SOFT_TEMP_COMPENSATE_VOLTAGE Voltage compensation
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - summit,smb345
+            - summit,smb358
+
+    then:
+      properties:
+        summit,mains-current-limit-microamp:
+          enum: [ 300000,  500000,  700000, 1000000,
+                 1500000, 1800000, 2000000]
+
+        summit,usb-current-limit-microamp:
+          enum: [ 300000,  500000,  700000, 1000000,
+                 1500000, 1800000, 2000000]
+
+        summit,charge-current-compensation-microamp:
+          enum: [200000, 450000, 600000, 900000]
+
+    else:
+      properties:
+        summit,mains-current-limit-microamp:
+          enum: [ 300000,  500000,  700000,  900000, 1200000,
+                 1500000, 1800000, 2000000, 2200000, 2500000]
+
+        summit,usb-current-limit-microamp:
+          enum: [ 300000,  500000,  700000,  900000, 1200000,
+                 1500000, 1800000, 2000000, 2200000, 2500000]
+
+        summit,charge-current-compensation-microamp:
+          enum: [250000, 700000, 900000, 1200000]
+
+required:
+  - compatible
+  - reg
+
+anyOf:
+  - required:
+      - summit,enable-usb-charging
+  - required:
+      - summit,enable-otg-charging
+  - required:
+      - summit,enable-mains-charging
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/power/summit,smb347-charger.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        charger@7f {
+            compatible = "summit,smb347";
+            reg = <0x7f>;
+
+            summit,enable-charge-control = <SMB3XX_CHG_ENABLE_PIN_ACTIVE_HIGH>;
+            summit,chip-temperature-threshold-celsius = <110>;
+            summit,mains-current-limit-microamp = <2000000>;
+            summit,usb-current-limit-microamp = <500000>;
+            summit,enable-usb-charging;
+            summit,enable-mains-charging;
+
+            monitored-battery = <&battery>;
+        };
+    };
+
+    battery: battery-cell {
+        compatible = "simple-battery";
+        constant-charge-current-max-microamp = <1800000>;
+        operating-range-celsius = <0 45>;
+        alert-celsius = <3 42>;
+    };
diff --git a/include/dt-bindings/power/summit,smb347-charger.h b/include/dt-bindings/power/summit,smb347-charger.h
new file mode 100644
index 000000000000..d918bf321a71
--- /dev/null
+++ b/include/dt-bindings/power/summit,smb347-charger.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: (GPL-2.0-or-later or MIT) */
+/*
+ * Author: David Heidelberg <david@ixit.cz>
+ */
+
+#ifndef _DT_BINDINGS_SMB347_CHARGER_H
+#define _DT_BINDINGS_SMB347_CHARGER_H
+
+/* Charging compensation method */
+#define SMB3XX_SOFT_TEMP_COMPENSATE_NONE	0
+#define SMB3XX_SOFT_TEMP_COMPENSATE_CURRENT	1
+#define SMB3XX_SOFT_TEMP_COMPENSATE_VOLTAGE	2
+
+/* Charging enable control */
+#define SMB3XX_CHG_ENABLE_SW			0
+#define SMB3XX_CHG_ENABLE_PIN_ACTIVE_LOW	1
+#define SMB3XX_CHG_ENABLE_PIN_ACTIVE_HIGH	2
+
+#endif
-- 
2.27.0

