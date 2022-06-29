Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202C355F9B1
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jun 2022 09:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbiF2Hx0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jun 2022 03:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbiF2HxK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jun 2022 03:53:10 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBFA3BBD4
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 00:52:57 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z7so20968062edm.13
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 00:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7DTWZB97Om2EveO4+LeSiMIgS7q933Vk+cFtrI7PvsQ=;
        b=zo3HdiH3SVClA6tRFUsSAldlGZ7jiFDvugQ1kWdZQ9ekf/Ozhrgk0z81b6Nqrbpks3
         sgzhA4O8dTYtfjFIoiPvk0XL60KrbJFjttz5TXomBBdytDCt7EZKt2bHWZaPeeA2FzgW
         s4k2egFMvlEQ0/QNpZlIJ6QtDVCLs0gBl5m9pBsl6CHVSeB65s3AiwkYVKsCFAAxGLec
         dpWKx3YtpMzMTcYzySduJwZ/ormwujS1GbV6+4t2PSlZx8HAiXzo7XADHPvJ0AoXpmj1
         PwSXz49zZFIqJ+c2emCj4D0xfckpewGxmXZnTBt4zhpkrZ6p2JTfSOxduK7cqJjMnVQX
         Y/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7DTWZB97Om2EveO4+LeSiMIgS7q933Vk+cFtrI7PvsQ=;
        b=4tUEie9J4LwRw8sf/QJkZRQX3DuNIp2VrEN2RqqlhUEsIdyeXfF1IGP2REzzAljzr6
         8/W51kmv2IPYHilTiM9rdj75MD1ZXnk7BccqenMX1jIIXJgpcgl4oYYY376c7EwKMkUN
         oFGYdj/pD9+w6NxXYeHE34RA+Ug0C2ctnjoXoEeKwFotaPofEYbesI/5Q/iUS9//ZIu9
         8le2+xzVb2bEvUr1yKeHN69yapQ8/pOzQgvQ4CSeVy6iB5ixL6qefHXvkbwB+0CZ7jTK
         yPYrAfpyftfrut2I6d0Lqf+9SFnMs2IqczWzp8MsRJDYX1HsDj9kcTZtMmjnunJeUMuj
         +myw==
X-Gm-Message-State: AJIora8m2lQ57QQYdDpOQ2E3nf5sFbxNcUrO1OzMOx5izhq1vhKDh+3L
        Yx8/qb2tEjraH7vtZ2g+/S3i2A==
X-Google-Smtp-Source: AGRyM1sGnv4r6LBIqWOayPAKavY0QnXJXgNgdvqXcunixTUkX0nrbuEnqPm5BwFm8eZCnGx2l6S/Gg==
X-Received: by 2002:aa7:d353:0:b0:435:6a15:139f with SMTP id m19-20020aa7d353000000b004356a15139fmr2507062edr.19.1656489175969;
        Wed, 29 Jun 2022 00:52:55 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id t2-20020a056402020200b00437db6acaeesm432173edv.95.2022.06.29.00.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 00:52:55 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh@kernel.org>
Subject: [PATCH v5 1/4] dt-bindings: interconnect: qcom,msm8998-cpu-bwmon: add BWMON device
Date:   Wed, 29 Jun 2022 09:52:47 +0200
Message-Id: <20220629075250.17610-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220629075250.17610-1-krzysztof.kozlowski@linaro.org>
References: <20220629075250.17610-1-krzysztof.kozlowski@linaro.org>
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
performance data on interconnects.  The bindings describe only BWMON CPU
(version 4), e.g. the instance which appeared for the first on Qualcomm
MSM8998 SoC and is also used on SDM845.  This BWMON device sits between
CPU and Last Level Cache Controller.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Georgi Djakov <djakov@kernel.org>
---
 .../interconnect/qcom,msm8998-cpu-bwmon.yaml  | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,msm8998-cpu-bwmon.yaml

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-cpu-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-cpu-bwmon.yaml
new file mode 100644
index 000000000000..b6ced53b92f7
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-cpu-bwmon.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,msm8998-cpu-bwmon.yaml#
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
+    oneOf:
+      - items:
+          - enum:
+              - qcom,sdm845-cpu-bwmon
+          - const: qcom,msm8998-cpu-bwmon
+      - const: qcom,msm8998-cpu-bwmon       # BWMON v4
+
+  interconnects:
+    maxItems: 1
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
+  - interrupts
+  - operating-points-v2
+  - opp-table
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interconnect/qcom,sdm845.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    pmu@1436400 {
+        compatible = "qcom,sdm845-cpu-bwmon", "qcom,msm8998-cpu-bwmon";
+        reg = <0x01436400 0x600>;
+        interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
+        interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_LLCC 3>;
+
+        operating-points-v2 = <&cpu_bwmon_opp_table>;
+
+        cpu_bwmon_opp_table: opp-table {
+            compatible = "operating-points-v2";
+            opp-0 {
+                opp-peak-kBps = <4800000>;
+            };
+            opp-1 {
+                opp-peak-kBps = <9216000>;
+            };
+            opp-2 {
+                opp-peak-kBps = <15052800>;
+            };
+            opp-3 {
+                opp-peak-kBps = <20889600>;
+            };
+            opp-4 {
+                opp-peak-kBps = <25497600>;
+            };
+        };
+    };
-- 
2.34.1

