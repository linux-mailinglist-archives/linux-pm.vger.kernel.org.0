Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3284C789D85
	for <lists+linux-pm@lfdr.de>; Sun, 27 Aug 2023 13:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjH0LvR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Aug 2023 07:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjH0Lup (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Aug 2023 07:50:45 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DBE1BC
        for <linux-pm@vger.kernel.org>; Sun, 27 Aug 2023 04:50:39 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-500760b296aso2789822e87.0
        for <linux-pm@vger.kernel.org>; Sun, 27 Aug 2023 04:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693137038; x=1693741838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1h5yZ1ON0tbidIVRhLbpjEGcgJUDJL2iKVUumFLXMN4=;
        b=a7muBL9IUjqVns3i7KW6R+6B7wM+KGnCPlxLztBTGwmKd+7z0pZeGLdaSXFwCjJhfX
         9Ub944wky508FCfEE8IQHBzo3TJlucAi5N1NkR7K+gAVoqa5iZkw9CddGPC2PS80cqVT
         HZD51xtrHwKHyC/GFCx+xAL2moQUGk0xmcXgrjtG2grNG4NaKBOH97WPa83SEOCP/CMW
         jGzVMk176p7kQNitmRfBRVlDQsllaRWQFkBtGkBobzd6rwr5MumkHM49mMYqOrdkXMVV
         PigGQa4KeXaau44rGImOqs1sReH4OGRItWGNBkknm82QaVKarQcnuYOQkSCNkWGXS4WF
         iYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693137038; x=1693741838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1h5yZ1ON0tbidIVRhLbpjEGcgJUDJL2iKVUumFLXMN4=;
        b=Mh7p2Sko5xxL89d3BKloHTHATOiDxbQH8aM3E7VePZIsDEn5j2H+lkTUZ7XPkxuEub
         G9KX5xcor4rLfaZCuIgQi2Zs2u30icaU/Oo3PfxVa+3pQJPmXXvcgzJtOiTMK/dp2MVb
         asnJbuOxtxS67KHLvGA6DDMHi+QmRf8aHplwrVMw+zfd2HdHOF/vyGAZm+Vdr4sx0oK5
         N7QRGCljB+DQuOO1N5c88x1P6UIkaMwqwIiWvMuqUMPZa03BC5tJNOnLPSmjshrifU2l
         SGOktv4ZVHUzPSigHUxCHRaGGNPVgH6a2+6m7ulT6ebAaEfL2ZO8V7qnSSjwMCfsW7gd
         46Bg==
X-Gm-Message-State: AOJu0YzGQWJfp5i+zFA6WgYOKMy3QydYCCZv8iDQAb6WiZFGlfa65YsX
        FbO69BcveV0NvNplaTcaZ4htNQ==
X-Google-Smtp-Source: AGHT+IGW0g5PxPyHdiA94zEf8AFi046HCvktmj51b88ouBJ1A4lNV4gblc4U8fgDj2Haet1KdvtBvA==
X-Received: by 2002:a05:6512:3096:b0:500:a008:a2e8 with SMTP id z22-20020a056512309600b00500a008a2e8mr3090179lfd.12.1693137038048;
        Sun, 27 Aug 2023 04:50:38 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id a8-20020a19f808000000b004ff9f88b86esm1114770lff.308.2023.08.27.04.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 04:50:37 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v4 04/23] dt-bindings: cache: describe L2 cache on Qualcomm Krait platforms
Date:   Sun, 27 Aug 2023 14:50:14 +0300
Message-Id: <20230827115033.935089-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230827115033.935089-1-dmitry.baryshkov@linaro.org>
References: <20230827115033.935089-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The L2 cache device on Qualcomm Krait platforms controls the supplying
voltages and the cache frequency. Add corresponding bindings for this
device.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../bindings/cache/qcom,krait-l2-cache.yaml   | 86 +++++++++++++++++++
 include/dt-bindings/soc/qcom,krait-l2-cache.h | 12 +++
 2 files changed, 98 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cache/qcom,krait-l2-cache.yaml
 create mode 100644 include/dt-bindings/soc/qcom,krait-l2-cache.h

diff --git a/Documentation/devicetree/bindings/cache/qcom,krait-l2-cache.yaml b/Documentation/devicetree/bindings/cache/qcom,krait-l2-cache.yaml
new file mode 100644
index 000000000000..59ce11dd0a24
--- /dev/null
+++ b/Documentation/devicetree/bindings/cache/qcom,krait-l2-cache.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Krait L2 Cache
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+
+description:
+  L2 cache on Qualcomm Krait platforms is shared between all CPU cores. L2
+  cache frequency and voltages should be scaled according to the needs of the
+  cores.
+
+allOf:
+  - $ref: /schemas/cache-controller.yaml#
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - qcom,krait-l2-cache
+
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - const: qcom,krait-l2-cache
+      - const: cache
+
+  clocks:
+    maxItems: 1
+
+  '#interconnect-cells':
+    const: 1
+
+  vdd-mem-supply:
+    description: suppling regulator for the memory cells of the cache
+
+  vdd-dig-supply:
+    description: suppling regulator for the digital logic of the cache
+
+  operating-points-v2: true
+  opp-table:
+    type: object
+
+required:
+  - compatible
+  - cache-level
+  - cache-unified
+  - clocks
+  - '#interconnect-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/soc/qcom,krait-l2-cache.h>
+
+    l2-cache {
+        compatible = "qcom,krait-l2-cache", "cache";
+        cache-level = <2>;
+        cache-unified;
+        vdd-mem-supply = <&pm8921_l24>;
+        vdd-dig-supply = <&pm8921_s3>;
+        clocks = <&kraitcc 4>;
+        #interconnect-cells = <1>;
+        operating-points-v2 = <&l2_opp_table>;
+
+        l2_opp_table: opp-table {
+            compatible = "operating-points-v2";
+
+            opp-384000000 {
+                opp-hz = /bits/ 64 <384000000>;
+                opp-microvolt = <1050000 1050000 1150000>,
+                                <950000 950000 1150000>;
+            };
+        };
+    };
+...
+
diff --git a/include/dt-bindings/soc/qcom,krait-l2-cache.h b/include/dt-bindings/soc/qcom,krait-l2-cache.h
new file mode 100644
index 000000000000..c9a38d368111
--- /dev/null
+++ b/include/dt-bindings/soc/qcom,krait-l2-cache.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) 2023 Linaro Ltd. All rights reserved.
+ */
+
+#ifndef __DT_BINDINGS_SOC_QCOM_KRAIT_L2_CACHE_H
+#define __DT_BINDINGS_SOC_QCOM_KRAIT_L2_CACHE_H
+
+#define MASTER_KRAIT_L2		0
+#define SLAVE_KRAIT_L2		1
+
+#endif
-- 
2.39.2

