Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E2D68B091
	for <lists+linux-pm@lfdr.de>; Sun,  5 Feb 2023 16:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjBEP2P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Feb 2023 10:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjBEP2O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Feb 2023 10:28:14 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3895C1C32E
        for <linux-pm@vger.kernel.org>; Sun,  5 Feb 2023 07:28:13 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id q19so9428084edd.2
        for <linux-pm@vger.kernel.org>; Sun, 05 Feb 2023 07:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YuSwnfqMynmwuBIvw62Jsv5v7L+ueU/osrgj84wLvF0=;
        b=Lt8L8N6qnQwUwjQ2bkRRTEHsM/UQ0AA0MbEyTa5147/G6RgwhAFWTLiRfQIMc48AKH
         UMwMXt9c5ua3oES47iQVxnGO5WibAgTCfyITiJYB3tQcTDkNsoomr+IiFpchXc8msRbc
         u2Wqp7vXgAMUAKer4aI/7/sHpMrgAFkz8yxDGXgFNpn5CQGEHEdYWL4JkfXBl7CfS4m6
         kyHhxJOt8flPI0AdQlBA75HUti4HvtYdxLRbIjo4Kl9VG/1kqpWcLOeOX03NIwWK8OsY
         urav+wMfVlyAdfYfCfo+VFHukRJAPZm2jrVmyxYd43hZKjXC01z0ztxPM3yGZd66FbG9
         i4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YuSwnfqMynmwuBIvw62Jsv5v7L+ueU/osrgj84wLvF0=;
        b=crN/ZyeAy5MPh/gB8i7elOL3BHBEea7BuXewKB+9ZAXZcQVMan8dtC8o5IIy3IIHQx
         1BkVmTGs5kP+VtTJqRxFDJ/GGt3aRYAPC0ML7IeBF/GgOTUI7l/BozdqHC5DqK2PevAm
         HG78mzuduelkpapE8Z3ssP3ITM148tR11lhpVGGruh+XDrCQK/6VNd5cs8ldm7tfg/05
         RoGQmsGOv2gy6TIcLs3tsAei41g6pYUxgZ09kE/wUgxsaHCkGTDyulKzIjPLEZP4IolZ
         jdHV7uWF49CGEgfY+G4BDgbmsVUacTgwHEB0iy8xAFiEzY8WyxPpuzEKvvjBPTLyycwe
         V61w==
X-Gm-Message-State: AO0yUKUlOcRswrfBmngXnIJlfoix9xvkbJjOkKL0L/kyGVljP//Igq4c
        hn7F1/ipwAKivTkKAfgFyPWjMw==
X-Google-Smtp-Source: AK7set/MFdoDE7MGm+A+An+HMf85yLu/7ryWhPYprf0udou0OurjE3+krss9njP/r77tinQ4e3DkMw==
X-Received: by 2002:a05:6402:c41:b0:48f:a9a2:29fa with SMTP id cs1-20020a0564020c4100b0048fa9a229famr18027066edb.2.1675610891792;
        Sun, 05 Feb 2023 07:28:11 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id fg10-20020a056402548a00b004a23558f01fsm3889178edb.43.2023.02.05.07.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 07:28:11 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: power: supply: Add Lenovo Yoga C630 EC
Date:   Sun,  5 Feb 2023 17:28:07 +0200
Message-Id: <20230205152809.2233436-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230205152809.2233436-1-dmitry.baryshkov@linaro.org>
References: <20230205152809.2233436-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

Add binding for the Embedded Controller found in the Qualcomm
Snapdragon-based Lenovo Yoga C630.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../power/supply/lenovo,yoga-c630-ec.yaml     | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/lenovo,yoga-c630-ec.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/lenovo,yoga-c630-ec.yaml b/Documentation/devicetree/bindings/power/supply/lenovo,yoga-c630-ec.yaml
new file mode 100644
index 000000000000..37977344f157
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/lenovo,yoga-c630-ec.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/lenovo,yoga-c630-ec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Lenovo Yoga C630 Embedded Controller.
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+description:
+  The Qualcomm Snapdragon-based Lenovo Yoga C630 has an Embedded Controller
+  (EC) which handles things such as battery and USB Type-C. This binding
+  describes the interface, on an I2C bus, to this EC.
+
+properties:
+  compatible:
+    const: lenovo,yoga-c630-ec
+
+  reg:
+    const: 0x70
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  interrupts:
+    maxItems: 1
+
+patternProperties:
+  '^connector@[01]$':
+    $ref: /schemas/connector/usb-connector.yaml#
+
+    properties:
+      reg:
+        maxItems: 1
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |+
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c1 {
+        clock-frequency = <400000>;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        embedded-controller@70 {
+            compatible = "lenovo,yoga-c630-ec";
+            reg = <0x70>;
+
+            interrupts-extended = <&tlmm 20 IRQ_TYPE_LEVEL_HIGH>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            connector@0 {
+                compatible = "usb-c-connector";
+                reg = <0>;
+                power-role = "source";
+                data-role = "host";
+            };
+
+            connector@1 {
+                compatible = "usb-c-connector";
+                reg = <1>;
+                power-role = "source";
+                data-role = "host";
+            };
+        };
+    };
+...
-- 
2.39.1

