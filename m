Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7DC3B999F
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 01:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbhGAXqd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 19:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234463AbhGAXq3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 19:46:29 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA8FC061764;
        Thu,  1 Jul 2021 16:43:56 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id f13so10812825ljp.10;
        Thu, 01 Jul 2021 16:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IwL3qryTNfgwkU5i7nwmV+nzWjMAB8DcHs6NfVFo2aw=;
        b=BKUihBPIMJywpAfV/nid00lybHpBf24+14TosiwolYNHAWVQ1+ZCPdvTtNtHpWb5cG
         b6BfqWKWW6mzuvAa6BBo3ybzmtC+dpgWeT8Cwduiphwhqrc//uAwQLYwbibnBHbJV3Vj
         DxhYXow8WAWwt2b/84OvpnchgOODlf7csu70bMNI8wypYk5qKaZQBEFQUNkqBkycOO/Y
         mvG6n9gEFDrcaTIrJ/RBVsWopnDYRP919T1wn69hWNZA6PC1f7yJzAlkNzYJhg+HaUrX
         zZ0LmhjMOg2N8qC2EoqFrwF0c27d+4MS3ETUXR9jeqb7CC+YWfTjYd9ZN1PDjCTorD+9
         mhfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IwL3qryTNfgwkU5i7nwmV+nzWjMAB8DcHs6NfVFo2aw=;
        b=O7FH8nUXWDhTxlLbz0erWLtfEM0RLRQdJmmJkedEk0x9o0eEyhIP+RBi4ZSM4NZ5eR
         WuDI5ZU664gZaWYfvp7qJF9OjO0oqEJ4USeY3PE5408fRB11VF2xVmoojzzn8FIpi0yD
         rF4RwifihNNgZkcR3BpmDQ/1w81HiXa6mW4UwE6hXAYSACGLGRUQyxcVCPf+/SHKYJEq
         vKdeIF01yOFZBYi1//lE3MSqnaUzr4XbNGMRpiOn7Mv52H2mJQHxle+H1Hnz3eocQID8
         zibpoFytf62FHtTnw+lWdVhrD5PnG0DZ7XnirRbb6PstyyjwdjK8fH1UIvyFD4vIbQwJ
         8aPg==
X-Gm-Message-State: AOAM5325j6xTWW8UgvEJLd/KVd/pE8X+vRRd9OgmTBRo512AlTXOkFxd
        1fgEX95KKS6UmY/sAspm8PM=
X-Google-Smtp-Source: ABdhPJxsCwE3BLANWd00uATwXAW/o0frKYGXJeT8IRA1iLbVbOX28mWmGwQOWtwob0GtIxj7x/SqUQ==
X-Received: by 2002:a2e:b8c9:: with SMTP id s9mr1591294ljp.426.1625183034746;
        Thu, 01 Jul 2021 16:43:54 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id e23sm60743lfq.221.2021.07.01.16.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:43:54 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v2 06/12] dt-bindings: power: supply: smb347-charger: Document USB VBUS regulator
Date:   Fri,  2 Jul 2021 02:43:11 +0300
Message-Id: <20210701234317.26393-7-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701234317.26393-1-digetx@gmail.com>
References: <20210701234317.26393-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SMB347 can supply power to USB VBUS, which is required by OTG-cable
devices that want to switch USB port into the host mode. Add USB VBUS
regulator properties.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../power/supply/summit,smb347-charger.yaml   | 28 +++++++++++++++++++
 .../dt-bindings/power/summit,smb347-charger.h |  4 +++
 2 files changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml b/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml
index 983fc215c1e5..cd3d834f734d 100644
--- a/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml
+++ b/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml
@@ -73,6 +73,24 @@ properties:
       - 1 # SMB3XX_SOFT_TEMP_COMPENSATE_CURRENT Current compensation
       - 2 # SMB3XX_SOFT_TEMP_COMPENSATE_VOLTAGE Voltage compensation
 
+  summit,inok-polarity:
+    description: |
+      Polarity of INOK signal indicating presence of external power supply.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 0 # SMB3XX_SYSOK_INOK_ACTIVE_LOW
+      - 1 # SMB3XX_SYSOK_INOK_ACTIVE_HIGH
+
+  usb-vbus:
+    $ref: "../../regulator/regulator.yaml#"
+    type: object
+
+    properties:
+      summit,needs-inok-toggle:
+        type: boolean
+        description: INOK signal is fixed and polarity needs to be toggled
+                     in order to enable/disable output mode.
+
 allOf:
   - if:
       properties:
@@ -134,6 +152,7 @@ examples:
             reg = <0x7f>;
 
             summit,enable-charge-control = <SMB3XX_CHG_ENABLE_PIN_ACTIVE_HIGH>;
+            summit,inok-polarity = <SMB3XX_SYSOK_INOK_ACTIVE_LOW>;
             summit,chip-temperature-threshold-celsius = <110>;
             summit,mains-current-limit-microamp = <2000000>;
             summit,usb-current-limit-microamp = <500000>;
@@ -141,6 +160,15 @@ examples:
             summit,enable-mains-charging;
 
             monitored-battery = <&battery>;
+
+            usb-vbus {
+                regulator-name = "usb_vbus";
+                regulator-min-microvolt = <5000000>;
+                regulator-max-microvolt = <5000000>;
+                regulator-min-microamp = <750000>;
+                regulator-max-microamp = <750000>;
+                summit,needs-inok-toggle;
+            };
         };
     };
 
diff --git a/include/dt-bindings/power/summit,smb347-charger.h b/include/dt-bindings/power/summit,smb347-charger.h
index d918bf321a71..3205699b5e41 100644
--- a/include/dt-bindings/power/summit,smb347-charger.h
+++ b/include/dt-bindings/power/summit,smb347-charger.h
@@ -16,4 +16,8 @@
 #define SMB3XX_CHG_ENABLE_PIN_ACTIVE_LOW	1
 #define SMB3XX_CHG_ENABLE_PIN_ACTIVE_HIGH	2
 
+/* Polarity of INOK signal */
+#define SMB3XX_SYSOK_INOK_ACTIVE_LOW		0
+#define SMB3XX_SYSOK_INOK_ACTIVE_HIGH		1
+
 #endif
-- 
2.30.2

