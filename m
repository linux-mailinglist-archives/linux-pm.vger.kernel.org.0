Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBB63B8C28
	for <lists+linux-pm@lfdr.de>; Thu,  1 Jul 2021 04:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238666AbhGAC1W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Jun 2021 22:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238639AbhGAC1U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Jun 2021 22:27:20 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76256C0617A8;
        Wed, 30 Jun 2021 19:24:50 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id u25so6132690ljj.11;
        Wed, 30 Jun 2021 19:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IwL3qryTNfgwkU5i7nwmV+nzWjMAB8DcHs6NfVFo2aw=;
        b=tIusmnHfpa7QldsC+QYuL0IiSy5lUtLgTU2ip2anCvjeciwgULJeDsonrJ+yE7Xk6l
         tXLc10VR93uc2MwE5oVK0C+bXZmKMJvoll+Rj4AmzqJuQzUqCW1M0L0eWMWSxh9Iu639
         3KahBcBhl8XapWawTh3V18wJmhZaaYOzYVEsyf89hLwbVa/88wTEggdv5HeA0gginkZ2
         +SPq5XqFyvKOYLUDRA3tLGlkR94ffAxn6FoTPGSvcTUD13aQajiSkTWkrBw4oUgevK3c
         NAIyLzZOwBkTFdiQHvDRoBdFKz6nLpu5V6/Lf62iaz5JVJzGuV4tcLru5TVJri5ZtrVu
         tXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IwL3qryTNfgwkU5i7nwmV+nzWjMAB8DcHs6NfVFo2aw=;
        b=UVHqQaq1Sx+pgyLZZLEHYv4kGN+28tiHUHsYqYXDXDg3gpawWW6nAC9MhEg6aMJaUZ
         jgUr0Xh3zBqtAM2XRiTRgQz1m6rqAyZf4l8dDo8vVDcl9b7U3I0TP32F6J6zRNyrtm1B
         cDfFsYJrh8fB/v7SuxAd1QDK4ZQ1IQtRK6rmqgl3Fv5pHi75OPY42vXWRLSCmv0S098a
         a1or6PTUSTjRjo+rbcgF4C8oVew3vPINQmInXXf+IeSOvBkUBxtlfbo8cLDnBHOwC2PH
         NjHQ15zsO+R2U/U4ouARggN5A+WplWsLctoOinpQ2qSFKo0koOl+Q4QWpHV+MQ+y4WxE
         9Iog==
X-Gm-Message-State: AOAM533uc1U4ndVxcL7TbY27/E+88nmDKWdbdKvHjqr7/hMA3YD7UMJP
        YL7KvEwe+LsyLrHBrpC8JKM=
X-Google-Smtp-Source: ABdhPJz3UUBzoGKmaBnOPlxMEk6Za+dxEHeTazeZhoLEMO5I1u8ovsFD22Y1hTttln9f0lqnfwyINQ==
X-Received: by 2002:a2e:9cd:: with SMTP id 196mr10135948ljj.98.1625106288905;
        Wed, 30 Jun 2021 19:24:48 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id v7sm2407262ljn.14.2021.06.30.19.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 19:24:48 -0700 (PDT)
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
Subject: [PATCH v1 06/12] dt-bindings: power: supply: smb347-charger: Document USB VBUS regulator
Date:   Thu,  1 Jul 2021 05:23:59 +0300
Message-Id: <20210701022405.10817-7-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701022405.10817-1-digetx@gmail.com>
References: <20210701022405.10817-1-digetx@gmail.com>
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

