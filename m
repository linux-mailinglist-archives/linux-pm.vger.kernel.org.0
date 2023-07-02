Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5CF744EE8
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jul 2023 19:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjGBRnV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Jul 2023 13:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjGBRm5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Jul 2023 13:42:57 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64197E60
        for <linux-pm@vger.kernel.org>; Sun,  2 Jul 2023 10:42:54 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b69f71a7easo58284611fa.1
        for <linux-pm@vger.kernel.org>; Sun, 02 Jul 2023 10:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688319772; x=1690911772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6IQl2jydqEVzMHgyvXGKi5dP1nmhqYFToeW0usGn04=;
        b=t3krUNGgPtG8KhJZgAOluB5qNbULkHrsggCGWOE3+9WkK/Nke8uZExATygIMC5eQr8
         51lm7CQ7oTP88c2nBhVE6Pennr1wfbTKKtrgJxEGkiWlBm3k5J0hMWXS45LfdiZZgz/B
         cZHfzR8C5KdvJe7ja0DU0HzrY+XlI0Y612i9PLs+dwqoDLoCd8vcKdC7TnYdjsEn38H9
         GN4lG7GZYZxMIkjnFMZvW3izmfoPD0NrWBM3CQMOm5G3TBnVjemcVFdugkxwSrq+LZsh
         q57FEDVUgzpdBuKrBCyyU2+J2Co7wLq+7/mTTcyCRBF0Duz6Un2tiHoA876jZpkD0jNM
         en0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688319772; x=1690911772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6IQl2jydqEVzMHgyvXGKi5dP1nmhqYFToeW0usGn04=;
        b=iQ7DmPFasRqafxDGEm64PoFlZNUWCp58IKEtDF4+k2d1cUF/7+NTK61f+8DQj5R5Eg
         Z37Exa62BfSsu0SoeGS+fDNcONjfjHK/sGdiXGENV+S0olNK3r7XMLTGF02nB145S+S8
         DhUeNYsc5jA/1TP9dkidxRxTDiipRCXl03DSJ5Ag6XD5qTw74IZRujx5Rbox5TlnZ28+
         w2C7NL19POt3X+KdN06aJxOUsQePuTv9fNIOIvuhOPLiBRw1fQBs/oneTSS3F952Brvu
         wcaCyuBC7rFrxR5sx9eGfF4iQJyWjSYD7dbL53uSrXtQfChhFI66NiJUZuqWsOg4Y1k6
         yH8g==
X-Gm-Message-State: ABy/qLb+aRqMlJDeKRCTiVADqopdAA8gz6MR9BXDNNQ3V0vqbeC/uGUn
        XqunZLNeTWAMfyq7cmX8PUX42A==
X-Google-Smtp-Source: APBJJlFS99hCzi3mAHUe1l02+2XjqYaJe00YvrgpaEEhLTYEwQtg5DIyyxbRohMVrZXBCGGoRP94GQ==
X-Received: by 2002:a05:651c:105a:b0:2b6:d8d4:15b with SMTP id x26-20020a05651c105a00b002b6d8d4015bmr2924331ljm.26.1688319772599;
        Sun, 02 Jul 2023 10:42:52 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id v23-20020a2e9917000000b002b6daa3fa2csm1372550lji.69.2023.07.02.10.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 10:42:52 -0700 (PDT)
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
Subject: [PATCH v3 05/28] dt-bindings: cache: describe L2 cache on Qualcomm Krait platforms
Date:   Sun,  2 Jul 2023 20:42:23 +0300
Message-Id: <20230702174246.121656-6-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702174246.121656-1-dmitry.baryshkov@linaro.org>
References: <20230702174246.121656-1-dmitry.baryshkov@linaro.org>
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

The L2 cache device on Qualcomm Krait platforms controls the supplying
voltages and the cache frequency. Add corresponding bindings for this
device.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../bindings/cache/qcom,krait-l2-cache.yaml   | 75 +++++++++++++++++++
 include/dt-bindings/soc/qcom,krait-l2-cache.h | 12 +++
 2 files changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cache/qcom,krait-l2-cache.yaml
 create mode 100644 include/dt-bindings/soc/qcom,krait-l2-cache.h

diff --git a/Documentation/devicetree/bindings/cache/qcom,krait-l2-cache.yaml b/Documentation/devicetree/bindings/cache/qcom,krait-l2-cache.yaml
new file mode 100644
index 000000000000..1dcf8165135b
--- /dev/null
+++ b/Documentation/devicetree/bindings/cache/qcom,krait-l2-cache.yaml
@@ -0,0 +1,75 @@
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
+  - $ref: ../cache-controller.yaml#
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
+  opp-table-l2: true
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
+        l2_opp_table: opp-table-l2 {
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

