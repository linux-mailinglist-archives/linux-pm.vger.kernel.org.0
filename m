Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD7F3DC753
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jul 2021 19:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbhGaRjU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 31 Jul 2021 13:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbhGaRjK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 31 Jul 2021 13:39:10 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C293DC061799;
        Sat, 31 Jul 2021 10:39:02 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id n6so17567567ljp.9;
        Sat, 31 Jul 2021 10:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Vgfkn6aojezGyNshrp4rdUuCsXyIjMI3yAFc0juggw=;
        b=gauVPPgwiGt8ErLfBme1SVcn/jTVSdGmVRVLRPBNWtxUGhPLo0TUjBkdWHF5elmHbo
         l70UVj14dtJsaDwaStcz9zH3lV5ZXxHXI321l+4IP17PTjSUIVmH3ZIjsNdj943WenWI
         LAQCHM8cCXnaBUqvbdImp8e+QVGFJdGqSnaADvo91EnEfu/rgHAffm2pt0Zh/ybkVKEz
         V6PavU/zklKWKIbD0/A012tZ7aNpFMMgzI/VtyTDRN0LCQM23ZjG7QWf4ENugZg2iRSX
         eeLjCtvaRYU4q4eKBLa+LdzuudieLl4tVdLPL6hg1U9irj5hfERepsWhNQ0sEd/wXJk3
         QYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Vgfkn6aojezGyNshrp4rdUuCsXyIjMI3yAFc0juggw=;
        b=BJIVHtv/ndpGf6RJJ0D2J4I6FFevktZpzHYFz4xqlsUM/fRMJGVJxNjgbDEe5F4kt7
         b7DrwAlgwd8wPrETQWFWODDyf0nTz9aZUzsFtrzcYwsuXlkgrD2vZiBCeril/cdW0EGu
         tefdbDG5zbnwIODtHVFYRxqeOyRUEUk4byVkLDPC7ZLtiPT7GTqCf0HIAWTraWaKDI5/
         nCYqg1ttxZS3prERZ/zXkNoM8ROAahNUCObM43E1yNgzNU+bfm4D2WV/eUrDie5oyiPK
         EXyPw7QXl6Ro5cwdYXJqrpE/H6KOSCxSMlRJF3looY9xJHwz5acywuoiQ9fDdE4WjMBr
         rvGw==
X-Gm-Message-State: AOAM530Fc6jk2h2MbuaN1hVPTASB36iUuonOLFhoUEYC6FSbnJSJv1ML
        4X4qKWsy9hyJYQgH45KBR3w=
X-Google-Smtp-Source: ABdhPJzn3O1EE2THzEqYtm1WlY8piOMjVy5iPFAKo9qlyyq0vsr1AjD05fW7XfJR+X2hq6nMonHNQA==
X-Received: by 2002:a2e:a36d:: with SMTP id i13mr5790035ljn.510.1627753141219;
        Sat, 31 Jul 2021 10:39:01 -0700 (PDT)
Received: from localhost.localdomain (94-29-22-96.dynamic.spd-mgts.ru. [94.29.22.96])
        by smtp.gmail.com with ESMTPSA id s15sm445272lfp.216.2021.07.31.10.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 10:39:00 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v6 05/12] dt-bindings: power: supply: smb347-charger: Document USB VBUS regulator
Date:   Sat, 31 Jul 2021 20:38:35 +0300
Message-Id: <20210731173842.19643-6-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210731173842.19643-1-digetx@gmail.com>
References: <20210731173842.19643-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SMB347 can supply power to USB VBUS, which is required by OTG-cable
devices that want to switch USB port into the host mode. Add USB VBUS
regulator properties.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../power/supply/summit,smb347-charger.yaml   | 30 +++++++++++++++++++
 .../dt-bindings/power/summit,smb347-charger.h |  4 +++
 2 files changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml b/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml
index 983fc215c1e5..20862cdfc116 100644
--- a/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml
+++ b/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml
@@ -73,6 +73,26 @@ properties:
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
+    unevaluatedProperties: false
+
 allOf:
   - if:
       properties:
@@ -134,6 +154,7 @@ examples:
             reg = <0x7f>;
 
             summit,enable-charge-control = <SMB3XX_CHG_ENABLE_PIN_ACTIVE_HIGH>;
+            summit,inok-polarity = <SMB3XX_SYSOK_INOK_ACTIVE_LOW>;
             summit,chip-temperature-threshold-celsius = <110>;
             summit,mains-current-limit-microamp = <2000000>;
             summit,usb-current-limit-microamp = <500000>;
@@ -141,6 +162,15 @@ examples:
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
2.32.0

