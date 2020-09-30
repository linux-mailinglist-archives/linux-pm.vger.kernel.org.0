Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2807027E382
	for <lists+linux-pm@lfdr.de>; Wed, 30 Sep 2020 10:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbgI3IR2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Sep 2020 04:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728725AbgI3IRY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Sep 2020 04:17:24 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2F4C0613D0
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2020 01:17:24 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y6so566321plt.9
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2020 01:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BGhR3ixFZ3T1rH5pcCCHtcmssYCPj4zheAYYg6rvF9s=;
        b=J5Akn54ze8Y63+8WnmQlq/AJxOdu2JqyJr1upEfhpWHwn0fiNjCsWcnlnHUQWk4t9h
         FNSGRADj/H4UN9auwEVyRAXiJ5EHbRh3ro0EgHptp42tOwbvbDZMYIMSYUyeEe1mYt0m
         FjlJ3T+n/swndo493fW64XJQQddoSQ7lz73v+rnwpsD208nNjPD2OpnuQlyNchPPzp1+
         HdC2PBdndyXAx+e1rxClcov3xwo9UTHz2mjR4kXiwlXbhXUc3PcXy6Gz1AvYtlrHzPIN
         AX7pfYSd71l19MJcF6+SDDkCwlUYoXIKbB6i7FrUN3ChkGbkzPuJlOz6jw4DXi34Jt37
         q2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BGhR3ixFZ3T1rH5pcCCHtcmssYCPj4zheAYYg6rvF9s=;
        b=mBy0DLGwuKthUZiFVNt4x2D8asXsSJkCWVQ8JzyX7uIMntWTc9fv77FfyEptjr8rGm
         apppbjDF6EL0IebZEajkuhE1Thg4m9qUhgvwfJ1tjoZ7cbu96UoMp1NvlHqbMCnu2NX3
         l6Ae96PBPMl1tZHGN1LjS2ZBIAZ2nTlecYnd4nRidqIA3QZdC9lFethOmV6AGqRnY4Oc
         3fwcYMaiuBPdxIoJrCNyqWXsNYp72V5XBZl/xJa+XCxhNyucZq9mR3srQjK5QL/vNxKk
         OY4cDKhCpcQ3yz1kTB5WBx9oAkBiXE0auvZQlAqRylWvMuPbxbeEJrzx4CM4v7SlHIKY
         HfJA==
X-Gm-Message-State: AOAM531onLtWSP3vssepX33o/Xf14c6MiKdkCNgfCY54hJW/cnphS3Ii
        qa3SmrW57C1/s6NfFSQ7G/ZJAw==
X-Google-Smtp-Source: ABdhPJyiuuTTZi9NkvesFEUUGRP1qukst/42J7XkHdxgmoBelLXqJL8dx5FZOm+l74FR9trQtgvAtQ==
X-Received: by 2002:a17:902:267:b029:d2:6180:4a46 with SMTP id 94-20020a1709020267b02900d261804a46mr1289126plc.26.1601453843645;
        Wed, 30 Sep 2020 01:17:23 -0700 (PDT)
Received: from localhost.localdomain (li519-153.members.linode.com. [66.175.222.153])
        by smtp.gmail.com with ESMTPSA id q15sm1385345pje.29.2020.09.30.01.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 01:17:23 -0700 (PDT)
From:   Jun Nie <jun.nie@linaro.org>
To:     devicetree@vger.kernel.org, georgi.djakov@linaro.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org
Cc:     shawn.guo@linaro.org, Jun Nie <jun.nie@linaro.org>
Subject: [PATCH 3/5] dt-bindings: interconnect: single yaml file for RPM interconnect drivers
Date:   Wed, 30 Sep 2020 16:16:43 +0800
Message-Id: <20200930081645.3434-4-jun.nie@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200930081645.3434-1-jun.nie@linaro.org>
References: <20200930081645.3434-1-jun.nie@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

MSM8916 and QCS404 bindings are almost identical, so combine them into one.
This will make it easier to add interconnect bindings for more SoC with RPM.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 .../bindings/interconnect/qcom,qcs404.yaml    | 77 -------------------
 .../{qcom,msm8916.yaml => qcom,rpm.yaml}      | 24 +++---
 2 files changed, 14 insertions(+), 87 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcs404.yaml
 rename Documentation/devicetree/bindings/interconnect/{qcom,msm8916.yaml => qcom,rpm.yaml} (76%)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,qcs404.yaml b/Documentation/devicetree/bindings/interconnect/qcom,qcs404.yaml
deleted file mode 100644
index 3fbb8785fbc9..000000000000
--- a/Documentation/devicetree/bindings/interconnect/qcom,qcs404.yaml
+++ /dev/null
@@ -1,77 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/interconnect/qcom,qcs404.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Qualcomm QCS404 Network-On-Chip interconnect
-
-maintainers:
-  - Georgi Djakov <georgi.djakov@linaro.org>
-
-description: |
-  The Qualcomm QCS404 interconnect providers support adjusting the
-  bandwidth requirements between the various NoC fabrics.
-
-properties:
-  reg:
-    maxItems: 1
-
-  compatible:
-    enum:
-      - qcom,qcs404-bimc
-      - qcom,qcs404-pcnoc
-      - qcom,qcs404-snoc
-
-  '#interconnect-cells':
-    const: 1
-
-  clock-names:
-    items:
-      - const: bus
-      - const: bus_a
-
-  clocks:
-    items:
-      - description: Bus Clock
-      - description: Bus A Clock
-
-required:
-  - compatible
-  - reg
-  - '#interconnect-cells'
-  - clock-names
-  - clocks
-
-additionalProperties: false
-
-examples:
-  - |
-      #include <dt-bindings/clock/qcom,rpmcc.h>
-
-      bimc: interconnect@400000 {
-              reg = <0x00400000 0x80000>;
-              compatible = "qcom,qcs404-bimc";
-              #interconnect-cells = <1>;
-              clock-names = "bus", "bus_a";
-              clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
-                       <&rpmcc RPM_SMD_BIMC_A_CLK>;
-      };
-
-      pnoc: interconnect@500000 {
-             reg = <0x00500000 0x15080>;
-             compatible = "qcom,qcs404-pcnoc";
-             #interconnect-cells = <1>;
-             clock-names = "bus", "bus_a";
-             clocks = <&rpmcc RPM_SMD_PNOC_CLK>,
-                      <&rpmcc RPM_SMD_PNOC_A_CLK>;
-      };
-
-      snoc: interconnect@580000 {
-            reg = <0x00580000 0x23080>;
-            compatible = "qcom,qcs404-snoc";
-            #interconnect-cells = <1>;
-            clock-names = "bus", "bus_a";
-            clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
-                     <&rpmcc RPM_SMD_SNOC_A_CLK>;
-      };
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8916.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
similarity index 76%
rename from Documentation/devicetree/bindings/interconnect/qcom,msm8916.yaml
rename to Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
index e1009ae4e8f7..e9f856357822 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8916.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
@@ -1,28 +1,32 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/interconnect/qcom,msm8916.yaml#
+$id: http://devicetree.org/schemas/interconnect/qcom,rpm.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm MSM8916 Network-On-Chip interconnect
+title: Qualcomm RPM Network-On-Chip Interconnect
 
 maintainers:
   - Georgi Djakov <georgi.djakov@linaro.org>
 
 description: |
-  The Qualcomm MSM8916 interconnect providers support adjusting the
-  bandwidth requirements between the various NoC fabrics.
+   RPM interconnect providers support system bandwidth requirements through
+   RPM processor. The provider is able to communicate with the RPM through
+   the RPM shared memory device.
 
 properties:
-  compatible:
-    enum:
-      - qcom,msm8916-bimc
-      - qcom,msm8916-pcnoc
-      - qcom,msm8916-snoc
-
   reg:
     maxItems: 1
 
+  compatible:
+        enum:
+          - qcom,msm8916-bimc
+          - qcom,msm8916-pcnoc
+          - qcom,msm8916-snoc
+          - qcom,qcs404-bimc
+          - qcom,qcs404-pcnoc
+          - qcom,qcs404-snoc
+
   '#interconnect-cells':
     const: 1
 
-- 
2.17.1

