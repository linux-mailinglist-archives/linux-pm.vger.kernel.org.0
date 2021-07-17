Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7320C3CC31E
	for <lists+linux-pm@lfdr.de>; Sat, 17 Jul 2021 14:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbhGQMOj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Jul 2021 08:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbhGQMOb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 17 Jul 2021 08:14:31 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F401C061767;
        Sat, 17 Jul 2021 05:11:32 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id i5so20629662lfe.2;
        Sat, 17 Jul 2021 05:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Vgfkn6aojezGyNshrp4rdUuCsXyIjMI3yAFc0juggw=;
        b=UHvrWhhwpcUuQOIPpK22jHEi7JX3plC7DsT9NNkpvpszcO4q4AYRGk77Y943U+ra2u
         nXyG0zzmOLYkxYMSYcuQhMJQ5ZtjNuc2b1DACwbJyZHqIf5532jCD2N2UMNDmgPCndgO
         xPXN0bC8uqJ31A7Kvbh8YyESVQ7aH2IBOZLtD/FHWMmHrg7EtSno864xiU1eSukh5BJk
         EmUAHhTQn6DTW+kynY7nXz0YXDCrmUf7xDazYfDeOFzqHKKvfz83e8obyRWNmwQxzh9n
         pvd5Oo1pksbXBOGGq3eDeZgVaMYdz5bNd2E5HGqlmDLTFxQRed9F+EWG0mhoUWLTruxb
         ZlOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Vgfkn6aojezGyNshrp4rdUuCsXyIjMI3yAFc0juggw=;
        b=bF2yEVFe6oGAPJMO0jHsKqYXEVjzf5XDR3P6rO5mOLr6ccV1I3x5GXyX3V0yEGIZQ2
         Teucu3edhR/7OJljjEAL+3XIUfgagiYh3avc2Aqn2AhsFdtAdMWV81PwrIWbaUMkL8lq
         jvyrizqXWsn0RWdhuPzimwjReVGvV9CoYKth4mtzr9gM7LHee5BqnV5zs0JY+TXkrPUV
         DPWRkQCUvgvycxc5U5lukJRLpHP5y5DSAN02teCYW4PPYMuyjSozutcEZvbHnM0i62WQ
         S314sIxGnJ1QbnfxFHsiPbzbagVLKu5vFFn9TIAGY+iqNLtLVPNWUs9j0SsvBAaijM9m
         793Q==
X-Gm-Message-State: AOAM532N/NEzQZeGfRFvsY41/lRw4U0VWkKnbK7y3vBCS/pk6JYMYgA8
        /y/1X0obuxNeSz9uz8PgBpE=
X-Google-Smtp-Source: ABdhPJyO8g0219TmdUe8/OktK+NJx29ZTQWj7jvkILuLCrT8d3J2SKnl+79bNkLx+V8PXGMZhphuvg==
X-Received: by 2002:a19:8588:: with SMTP id h130mr11315847lfd.501.1626523890842;
        Sat, 17 Jul 2021 05:11:30 -0700 (PDT)
Received: from localhost.localdomain (46-138-17-250.dynamic.spd-mgts.ru. [46.138.17.250])
        by smtp.gmail.com with ESMTPSA id m16sm852597lfq.23.2021.07.17.05.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 05:11:30 -0700 (PDT)
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
Subject: [PATCH v4 06/12] dt-bindings: power: supply: smb347-charger: Document USB VBUS regulator
Date:   Sat, 17 Jul 2021 15:11:06 +0300
Message-Id: <20210717121112.3248-7-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210717121112.3248-1-digetx@gmail.com>
References: <20210717121112.3248-1-digetx@gmail.com>
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

