Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28146550D2
	for <lists+linux-pm@lfdr.de>; Fri, 23 Dec 2022 14:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236286AbiLWNUx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Dec 2022 08:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236227AbiLWNUu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Dec 2022 08:20:50 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A76B16
        for <linux-pm@vger.kernel.org>; Fri, 23 Dec 2022 05:20:45 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id q2so5005721ljp.6
        for <linux-pm@vger.kernel.org>; Fri, 23 Dec 2022 05:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KAqjOZmQgKpq60Hvn4MV1XO42eVbyH2AUxe/oo8PbSo=;
        b=iPbMYCW4kcVxICq2SMG51HRVwi9b1fAuglq/YZ9KmuY41FJF3IscgecvvVuMoXPk2Z
         KHQTokgaiDi3da8YzmIWqv2E1433lF8w77qA2wVwRDMBBgXtKqNvAjwae6Y8qQM0VIHc
         y9GbR5PRtFDyiZI5yiJQvLM2w46fbykxmPZYkzJ1qaiWIoX4nklIAQkoGXwsrKgUN3qC
         DalWUscp/lX6doZmF7LCQ4Aozn71POxyIwFeY3AF2G1b5mN7N3rvOhOTXgzGY/qe0a2S
         wcFozyi+Rcg9mv/CGYrh6/PuSpWMJRmeGVMylb0ze6SUzutPGcIVE6vn+CeJJY8miKEd
         0/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KAqjOZmQgKpq60Hvn4MV1XO42eVbyH2AUxe/oo8PbSo=;
        b=JoMgROuLUbklMQ0LVVGxKYm10nS04bqBEKgl21sw0D2i6V7kSf2ipUbxhWd4JKgu1U
         n1ycrl6mLv1SKav7ou5bWNLQUh0kK5yDKgNWA88Y2Qqx9jVcwFmNn3N+TqoD/Woyk+fl
         eP1ZxDWY3lacCaBwz1LD6ytNVY46yR7G5EiVlbLKsZzWtuGMEmIdGxB1Xz15XNRfjv7H
         DE9pmPKviLehxJUBJBM+qG3yBrFml4GXnQegBhkOHljE5idr/jr+LJ9smks1ReAhKfLy
         ysws3Aq3VemLC6SNs0wSZXPeuakDIQGg5ThhaivykzupZKQYd+ctqqvu4Ooa+rqsIDzK
         Y4yA==
X-Gm-Message-State: AFqh2koYpFKHuV7/uy0ppSwBYPHGWagJiTqYc/5Ds/0KcCwMbT2KYJ+v
        6/WNX2VfR1dHP8EtKMOa1I/u/A==
X-Google-Smtp-Source: AMrXdXtE/yG/W2lBdxxiEduIdQ9CUndTh3wxJcNaAGJ0JB9jFBLOeqdQ3xWLW1v99YnSR1Jn3M+yiA==
X-Received: by 2002:a2e:2e18:0:b0:279:2199:5787 with SMTP id u24-20020a2e2e18000000b0027921995787mr2442494lju.1.1671801644270;
        Fri, 23 Dec 2022 05:20:44 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v11-20020a2ea60b000000b0026c2baa72d4sm426753ljp.27.2022.12.23.05.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 05:20:43 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] dt-bindings: interconnect: split SC8280XP to own schema
Date:   Fri, 23 Dec 2022 14:20:39 +0100
Message-Id: <20221223132040.80858-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221223132040.80858-1-krzysztof.kozlowski@linaro.org>
References: <20221223132040.80858-1-krzysztof.kozlowski@linaro.org>
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

SC8280XP comes with interconnects without IO address space, so split it
from common file for easier maintenancen and to fix warnings like:

  sc8280xp-lenovo-thinkpad-x13s.dtb: interconnect-mc-virt: 'reg' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/interconnect/qcom,rpmh.yaml      | 12 -----
 .../interconnect/qcom,sc8280xp-rpmh.yaml      | 49 +++++++++++++++++++
 2 files changed, 49 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sc8280xp-rpmh.yaml

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
index 4bdcc014c46b..448829ecf6b6 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
@@ -51,18 +51,6 @@ properties:
       - qcom,sc8180x-mmss-noc
       - qcom,sc8180x-qup-virt
       - qcom,sc8180x-system-noc
-      - qcom,sc8280xp-aggre1-noc
-      - qcom,sc8280xp-aggre2-noc
-      - qcom,sc8280xp-clk-virt
-      - qcom,sc8280xp-config-noc
-      - qcom,sc8280xp-dc-noc
-      - qcom,sc8280xp-gem-noc
-      - qcom,sc8280xp-lpass-ag-noc
-      - qcom,sc8280xp-mc-virt
-      - qcom,sc8280xp-mmss-noc
-      - qcom,sc8280xp-nspa-noc
-      - qcom,sc8280xp-nspb-noc
-      - qcom,sc8280xp-system-noc
       - qcom,sdm845-aggre1-noc
       - qcom,sdm845-aggre2-noc
       - qcom,sdm845-config-noc
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sc8280xp-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sc8280xp-rpmh.yaml
new file mode 100644
index 000000000000..6c2da03f0cd2
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sc8280xp-rpmh.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,sc8280xp-rpmh.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm RPMh Network-On-Chip Interconnect on SC8280XP
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Konrad Dybcio <konrad.dybcio@linaro.org>
+
+description: |
+  RPMh interconnect providers support system bandwidth requirements through
+  RPMh hardware accelerators known as Bus Clock Manager (BCM).
+
+  See also:: include/dt-bindings/interconnect/qcom,sc8280xp.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,sc8280xp-aggre1-noc
+      - qcom,sc8280xp-aggre2-noc
+      - qcom,sc8280xp-clk-virt
+      - qcom,sc8280xp-config-noc
+      - qcom,sc8280xp-dc-noc
+      - qcom,sc8280xp-gem-noc
+      - qcom,sc8280xp-lpass-ag-noc
+      - qcom,sc8280xp-mc-virt
+      - qcom,sc8280xp-mmss-noc
+      - qcom,sc8280xp-nspa-noc
+      - qcom,sc8280xp-nspb-noc
+      - qcom,sc8280xp-system-noc
+
+required:
+  - compatible
+
+allOf:
+  - $ref: qcom,rpmh-common.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    interconnect-0 {
+        compatible = "qcom,sc8280xp-aggre1-noc";
+        #interconnect-cells = <2>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+    };
-- 
2.34.1

