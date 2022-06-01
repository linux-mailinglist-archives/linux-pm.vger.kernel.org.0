Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E2653A215
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jun 2022 12:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351744AbiFAKLx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jun 2022 06:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350861AbiFAKLv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jun 2022 06:11:51 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FEBDF12
        for <linux-pm@vger.kernel.org>; Wed,  1 Jun 2022 03:11:49 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id gi33so2733022ejc.3
        for <linux-pm@vger.kernel.org>; Wed, 01 Jun 2022 03:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p7mIRFKlf7mUQrcHty6Iw1fiOYErDnQJ/9BxNwewsYs=;
        b=LoAg86P0ntllSU1bmFjpKTAEgl1pUq8J8eUjUhYimzTR+IgaCgrABf4gfdnwJCq6cI
         J44NtFFuVX5TBWsKrdAQgMij796UY8blB8Y/OxW+Zp3c/EMVCdOZA9mS74Q8S0TQQmKt
         X5NS7BEdSOUabe0f6ooMrygh3NQX2IgQgU2l/XPWy4tIbGSuluYzUOzqQfF0RV4q8r8l
         5fdwyBZE6g0iCPIRYmKW2nzCEqzsqxABmckVbdwW+n1zJBhOXDWwFWAIN9FlpkUuwd/K
         TKlN5EclXdtUV3cy69iZzXTJwMots7jS2gpu0rIIzdBReY7OvaTFxngXwcFPyfOn2wND
         s9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p7mIRFKlf7mUQrcHty6Iw1fiOYErDnQJ/9BxNwewsYs=;
        b=wVhIYBfeEKcR9FD/d1/1Pi/gStvuvy+OwNiF7GxSv4gzIrYS4Ke8Hrw6sdh27YX9SU
         XR76jxGj5XGhNuwBQMKpZVePGmcFUV8nMBKRxwNEt6DokmwhW1tzufRQUQvY3jxPWz21
         Ecvc5UTusKoZ9Yo+AFXwVfkxNiE7wkUFO3W0KF7VUDo8+g49zs6TmsV9v3AFITL/A5BY
         tkOMdcOlzOGxb980YTqO39suDdiouebM2bloWYa5YGXwjP80xIcFAAWvxK2bHBFtKoS4
         XI41EauOv3YEEwSriWzeMddGEncU9W0JMW4qXXi+NzfNfev0qCaQuhiCbvPbjySDfaE3
         gWpA==
X-Gm-Message-State: AOAM530JRb+fLc1mP1CfkoB48k3pdthyeb611kTsNOijmO8SnB8ueciG
        P5w9QXITSuFbFCL/05hNKTOki89BZWSzokaE
X-Google-Smtp-Source: ABdhPJyT9So5bIYBc+pW45JBr6rYx/7IiRsRiGG9ClcYrySm3ENR8qbdFOnC8qAXj2Jkp66w43ohcA==
X-Received: by 2002:a17:907:3f9a:b0:6ff:25ba:57ea with SMTP id hr26-20020a1709073f9a00b006ff25ba57eamr25929701ejc.141.1654078308199;
        Wed, 01 Jun 2022 03:11:48 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id m9-20020a170906580900b006feb7b1379dsm501373ejq.181.2022.06.01.03.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 03:11:47 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/4] dt-bindings: interconnect: qcom,sdm845-cpu-bwmon: add BWMON device
Date:   Wed,  1 Jun 2022 12:11:37 +0200
Message-Id: <20220601101140.170504-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220601101140.170504-1-krzysztof.kozlowski@linaro.org>
References: <20220601101140.170504-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add bindings for the Qualcomm Bandwidth Monitor device providing
performance data on interconnects.  The bindings describe only BWMON
version 4, e.g. the instance on SDM845 between CPU and Last Level Cache
Controller.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Georgi Djakov <djakov@kernel.org>
---
 .../interconnect/qcom,sdm845-cpu-bwmon.yaml   | 97 +++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845-cpu-bwmon.yaml

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sdm845-cpu-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sdm845-cpu-bwmon.yaml
new file mode 100644
index 000000000000..8c82e06ee432
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sdm845-cpu-bwmon.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,sdm845-cpu-bwmon.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Interconnect Bandwidth Monitor
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+description:
+  Bandwidth Monitor measures current throughput on buses between various NoC
+  fabrics and provides information when it crosses configured thresholds.
+
+properties:
+  compatible:
+    enum:
+      - qcom,sdm845-cpu-bwmon       # BWMON v4
+
+  interconnects:
+    maxItems: 2
+
+  interconnect-names:
+    items:
+      - const: ddr
+      - const: l3c
+
+  interrupts:
+    maxItems: 1
+
+  operating-points-v2: true
+  opp-table: true
+
+  reg:
+    # Currently described BWMON v4 and v5 use one register address space.
+    # BWMON v2 uses two register spaces - not yet described.
+    maxItems: 1
+
+required:
+  - compatible
+  - interconnects
+  - interconnect-names
+  - interrupts
+  - operating-points-v2
+  - opp-table
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interconnect/qcom,osm-l3.h>
+    #include <dt-bindings/interconnect/qcom,sdm845.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    pmu@1436400 {
+        compatible = "qcom,sdm845-cpu-bwmon";
+        reg = <0x01436400 0x600>;
+
+        interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
+
+        interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
+                        <&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+        interconnect-names = "ddr", "l3c";
+
+        operating-points-v2 = <&cpu_bwmon_opp_table>;
+
+        cpu_bwmon_opp_table: opp-table {
+            compatible = "operating-points-v2";
+
+            opp-0 {
+                opp-peak-kBps = <800000 4800000>;
+            };
+            opp-1 {
+                opp-peak-kBps = <1804000 9216000>;
+            };
+            opp-2 {
+                opp-peak-kBps = <2188000 11980800>;
+            };
+            opp-3 {
+                opp-peak-kBps = <3072000 15052800>;
+            };
+            opp-4 {
+                opp-peak-kBps = <4068000 19353600>;
+            };
+            opp-5 {
+                opp-peak-kBps = <5412000 20889600>;
+            };
+            opp-6 {
+                opp-peak-kBps = <6220000 22425600>;
+            };
+            opp-7 {
+                opp-peak-kBps = <7216000 25497600>;
+            };
+        };
+    };
-- 
2.34.1

