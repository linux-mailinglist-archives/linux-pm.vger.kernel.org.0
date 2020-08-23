Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E73324ED8C
	for <lists+linux-pm@lfdr.de>; Sun, 23 Aug 2020 16:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgHWOK1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Aug 2020 10:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbgHWOKH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Aug 2020 10:10:07 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE880C061755;
        Sun, 23 Aug 2020 07:10:06 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id w14so6741505ljj.4;
        Sun, 23 Aug 2020 07:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g/A5BJAqO3o60ofL2OeIr3Lct01dCdXmoNfEGqHHX7U=;
        b=JjBN7AHhSwp2xb1TUIgSXzCe/4yD2jVrnUC0Qhv+K23T7MbkDm6ce15rwF5bXR5X55
         R8yc9Ex9UwIOFG3XJVIQe0lfNtfLKQ8U9lR4xpKTg384kSzCETY5Wbvw6IQOiuAjlrt+
         1D2dp8lWtaYrvpRwA9aQBEj7MJ9/Q4Xdi14YbZVdh6KwuRFffbTY+jiEY82wRFeTb19D
         4xbIeNiBSlSpZDkVrpVwWr326wPbCXpmyQ1vVEXUyjA23VE/ypRlh2hn9tG0N2uiG6h+
         H5GkyLBgPke0H/Xn+BsZOiF1ScJAxG27DFWTvnW0il5X6yjBY2ZEGB5gRwyOF+JxL4ZK
         ajNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g/A5BJAqO3o60ofL2OeIr3Lct01dCdXmoNfEGqHHX7U=;
        b=WVSxyRE0wFe1rqvdMsJl6ESsygZOxM5m0SVV3UfjToYBExzYyaYz2VIawbUZc/CM9t
         dL13T5+CVJvTqAW1SDZ57JYkCiF3Xi9fsq/Z0Uxy7/f9pAiZJU7UJCHFVs0ePdyacAd5
         nHDh9G8cCiEblcuAfz6A+C9EnES3mgQUo4lvJ83XuBv3YY8JAhXyaYk6aifjiRMWYilI
         fC5sbptMwUDER2Kh+nr10Jf4hzZaqZ1H4vtmsli2KGJsx57knvEqpAoz+9u0/byKr42R
         6pW1OHQUnAotC1Au/7dltH4GBK2r39ayJSIv3qSZD1L1Mrkm0XbwE+USv3HifARxp6EE
         O6fw==
X-Gm-Message-State: AOAM530GrWH+sEpB8qxw1FyukS8vRYy4bB1vVTB37YiLQdDIBUPPz9cn
        OItxZKCF49TnczDb0aUfn3A=
X-Google-Smtp-Source: ABdhPJx8D96B8T4FXjs4YzL/JnebMSsAmx2Yz/x+2JS+7sByGFV7qsXKEhfRROpuF67tJ3sJpWVcHg==
X-Received: by 2002:a2e:86d6:: with SMTP id n22mr662601ljj.440.1598191805168;
        Sun, 23 Aug 2020 07:10:05 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id b17sm1641342ljp.9.2020.08.23.07.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2020 07:10:04 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sre@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/6] dt-bindings: mfd: ene-kb3930: Document power-supplies and monitored-battery properties
Date:   Sun, 23 Aug 2020 17:08:45 +0300
Message-Id: <20200823140846.19299-6-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200823140846.19299-1-digetx@gmail.com>
References: <20200823140846.19299-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Battery could be connected to the controller and in this case controller
will provide a battery-monitor function.

The power-supplies phandle property is needed in order to describe the
power supply which is used for charging of the battery, this allows to
determine whither battery is charging or discharging, depending on the
supply state.

The monitored-battery phandle provides information about the battery cell
characteristics.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../devicetree/bindings/mfd/ene-kb3930.yaml    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/ene-kb3930.yaml b/Documentation/devicetree/bindings/mfd/ene-kb3930.yaml
index 5a1c4a959d9c..435728054f3a 100644
--- a/Documentation/devicetree/bindings/mfd/ene-kb3930.yaml
+++ b/Documentation/devicetree/bindings/mfd/ene-kb3930.yaml
@@ -29,6 +29,8 @@ properties:
     description: GPIO used with the shutdown protocol on Ariel
     maxItems: 2
 
+  monitored-battery: true
+  power-supplies: true
   system-power-controller: true
 
 required:
@@ -41,6 +43,19 @@ examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
 
+    battery: battery-cell {
+            compatible = "simple-battery";
+            charge-full-design-microamp-hours = <3260000>;
+            energy-full-design-microwatt-hours = <24000000>;
+            operating-range-celsius = <0 40>;
+    };
+
+    mains: ac-adapter {
+      compatible = "gpio-charger";
+      charger-type = "mains";
+      gpios = <&gpio 125 GPIO_ACTIVE_LOW>;
+    };
+
     i2c {
       #address-cells = <1>;
       #size-cells = <0>;
@@ -52,6 +67,9 @@ examples:
 
         off-gpios = <&gpio 126 GPIO_ACTIVE_HIGH>,
                     <&gpio 127 GPIO_ACTIVE_HIGH>;
+
+        monitored-battery = <&battery>;
+        power-supplies = <&mains>;
       };
     };
 
-- 
2.27.0

