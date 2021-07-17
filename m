Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9413CC575
	for <lists+linux-pm@lfdr.de>; Sat, 17 Jul 2021 20:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235837AbhGQS0h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Jul 2021 14:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbhGQS0F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 17 Jul 2021 14:26:05 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F95AC061767;
        Sat, 17 Jul 2021 11:23:08 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id g8so15764854lfh.8;
        Sat, 17 Jul 2021 11:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Vgfkn6aojezGyNshrp4rdUuCsXyIjMI3yAFc0juggw=;
        b=dB+8mmmwzGt+/Vy7uuglaj10Q8xGvMXumt3y0N/FQd01CCNkYOLiONJQTitQUgpnjR
         mOja3Z+IPjQ6NrCqXRfwfMo4n90CMjJVLsFXx4WpIGJg57tbeozxs5dYMFQps6AuMpmA
         AogzkcbUpR23cTnZa0bFcA7iJB86WtfsViFdoC+h3m8h/Zayu4C5pIp5Kz0DjAO97k3/
         1Iva72Qkkl8KwE8ZebPEwpuDpVIAZ5MyxYVnXTyJ/N0QzXfA5HfUeI5aa35pDEXIdiJ9
         pKPBWtQ2jw1fQ310DLC5W2vujqMYP+C/YRxRdoryEP8w+N5M33I91eSZw/E19ws65Iu7
         6jOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Vgfkn6aojezGyNshrp4rdUuCsXyIjMI3yAFc0juggw=;
        b=ER0j+120iGDNciI7J8AFata+vWK5iT4J5m79R8s9ByW8FEdUnz+YZuIi1/vUBQ+Tqq
         8UtzqeNUxApMdkaXO6/80b+znqhMY3AROx970ORCVvuBr6KKAN2E4YnZbu0Jnv2RWEET
         U6K9xh3QpXBLSsnjr3IlmDDossXRxgt66y3u4iH9FXaN/jdJVUSNl2RAUQShRSYJCkc1
         bQHrGtHVpIs/4u5gn4klqNERguipENoB6unU4haaNDxNmLIdKu3Zds53QnQIfT4+F2jx
         jD8T26RBFb6c64AFcddqe/tkTrjiJ6Fksra715HUREyd2VnEb1XM05ju08lctlAKEqCT
         Pebw==
X-Gm-Message-State: AOAM531G1OOJp/z5128K1YBV+k5w33DtJHFsSMA05f4hPjYVy23aDoPC
        CyuRqwuFp28ckIx6I6k1SJQ=
X-Google-Smtp-Source: ABdhPJwNiE2Ba5A66eTVEdLqAWKmYI5rMLDUIsmfcF2G529UU5aO0hwhC2ISCZTWSC4j76AM8hkQ+g==
X-Received: by 2002:a19:7408:: with SMTP id v8mr12332827lfe.508.1626546186467;
        Sat, 17 Jul 2021 11:23:06 -0700 (PDT)
Received: from localhost.localdomain (46-138-17-250.dynamic.spd-mgts.ru. [46.138.17.250])
        by smtp.gmail.com with ESMTPSA id z20sm1409532ljk.123.2021.07.17.11.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 11:23:06 -0700 (PDT)
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
Subject: [PATCH v5 06/12] dt-bindings: power: supply: smb347-charger: Document USB VBUS regulator
Date:   Sat, 17 Jul 2021 21:21:28 +0300
Message-Id: <20210717182134.30262-7-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210717182134.30262-1-digetx@gmail.com>
References: <20210717182134.30262-1-digetx@gmail.com>
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

