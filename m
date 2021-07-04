Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D838D3BAF80
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jul 2021 00:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbhGDW6r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Jul 2021 18:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbhGDW6m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Jul 2021 18:58:42 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E1AC061574;
        Sun,  4 Jul 2021 15:56:05 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id t30so2042370ljo.5;
        Sun, 04 Jul 2021 15:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JqSUXf/ZgNGuB1vWN3GmV72dPap7cFs2CpoCHTXSAoU=;
        b=WP/0jNtEwZ0sjun+btlq67YNd80T7cXwE1IkniyePIhpdmHXXMvv9yymm8kYFf63nQ
         FJxqgb4OPYQTr2hBvnesT/9XFmX9mG0Q1abGUkdFncYhCQUdCpY7d2//ngeCtZW3AQG7
         Az+UUKqW6E0JcqNlkMaFsml6iI2xNTTE/EjHwBenklwTnj+0cdwJWFOEV6F8tueAlx3w
         va4kWCkMqAu8cQwYe9Vbs4nvE0vjaxh893t8+H0m4YdTE8UczFZJxegFBzKEgmmTwTJi
         glZc8L5QpHNrvP6h00my/jHrWh4xcI/RlYYdO0XhoGnnIPp7CyTvH6h6U7QVxTvpLNkp
         wGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JqSUXf/ZgNGuB1vWN3GmV72dPap7cFs2CpoCHTXSAoU=;
        b=I5T9pYHpK44P7yHbWSVjbzUHtkcLdrdp4Nt92AIAFCrastFKwUGJVT12NQzv01NOUV
         B87yRt8jto78vkaAHosUkG64Hi7FtbvVYF6cRAuPGjQl359Up49zXq1fD5iln32QlDFu
         Z7O7zdmAz6bJyR439slxD0l85F3f+iTqLpCojdyiLrL5boMV10cPGfbGKGFxVcCNCjxQ
         FgsfekeUbpfvhFmWN4uoq7rl8ndNQlLhAdCNSigTfI39AA6kf7pNLdFSWfVObPE1qVi1
         WinCBizm12JkZr9h7uEpWVQorLWjIZAnqKXnhEBL4jYO9GtDEyLCi7NEiBvvaXhhyeKC
         evgw==
X-Gm-Message-State: AOAM533tdh+CB1YWl16/52oDHLW3ww7C0BpG47v0g+n084+XIF8I6ZIq
        +CeC4Sxp6sOByVqRvu07bo8=
X-Google-Smtp-Source: ABdhPJz3cgnktcm6j8vgfJzh0t0Ttm7cJvw7C4vIbbXS9x25qz6uPZP9dTQA850q/qi+fDfF/07ZkQ==
X-Received: by 2002:a05:651c:a07:: with SMTP id k7mr9022928ljq.477.1625439364325;
        Sun, 04 Jul 2021 15:56:04 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id i13sm497921lfc.111.2021.07.04.15.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 15:56:04 -0700 (PDT)
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
Subject: [PATCH v3 06/12] dt-bindings: power: supply: smb347-charger: Document USB VBUS regulator
Date:   Mon,  5 Jul 2021 01:54:27 +0300
Message-Id: <20210704225433.32029-7-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210704225433.32029-1-digetx@gmail.com>
References: <20210704225433.32029-1-digetx@gmail.com>
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
2.32.0

