Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B3922FFC5
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jul 2020 04:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgG1Cjr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 22:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbgG1Cjq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 22:39:46 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C631DC0619D4
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2020 19:39:45 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id s15so4064929qvv.7
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2020 19:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BsqPZ0XK5KxOBsJDhy4IA2RMRHhLCVsHp4kme64uz/I=;
        b=0EvAbl63wJZ0o6r0mX2NkvUUN85M2+6KiLtS+P4ptN1Uzw+sjqf7EydA1uXA7HNV9p
         rm9k1+FO/65etsED8cvXGQoVWFuRQflwM07infMMDwacptAEJq93qbsBsN/zokdhs/G/
         i4Rrv21/F7Zhi8aGxAaZcDt4DkdhcOLjITBHCdi7a2a2bDIwCK5WJBmTJINFxQPvByuK
         G9uuzxJW4t9+3UsSF2plh25qdgxCkiMjywWRw1RxbV1RlYkfGMHpk09a6UydRla7gHtn
         U9grSJ/hgThkO7mgX8+3Bi7xm6azOsQXBr9qzheQwewXxgebpaR0fPEY70y5h2lfNBWz
         SYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BsqPZ0XK5KxOBsJDhy4IA2RMRHhLCVsHp4kme64uz/I=;
        b=A3uUPo9mQGU7dQzehnCIdS7JJilN1UWTmoqFa2YBDzkwbq6NVg2/xK73WFezruF/S/
         DpDxdtfQgoXSfhuGLF7XKvw/2/Pe/7PL98hBznHmo+RDsJDVLCw7euBEy/Bv9+gJ1Gjk
         73Yn+qAlZJjwIazc4QPn0sue+4e/hh2SVqhpr6UCr871Mz6tCWGkpVe3bWq++9lvH3g+
         /mcVKd/HXyi0JBtJ61uxWGwIsC+vWrzMoHd4gzAqxjpKww1dybcEg3tO0MvmjMurEiGn
         Kezy3ofNDuPeKiWgbNPvSAvntvLNL4Xohydq+OntuaPJRkH8E34hsrfH+SAldE8kS0lG
         02Ug==
X-Gm-Message-State: AOAM531OG10XlWhrj30P9s0gRnWKeLN6abLcU7MpMEvYuB92607t56u/
        0fqRZQhLZzS1OukeGZaphGt6Zg==
X-Google-Smtp-Source: ABdhPJwSBR9k7+IQldew4BpIXSPT/ksfrunWCNXWeVkUhSbn7nl4/CjiIPbtR+pAHO95zeck6sfWDQ==
X-Received: by 2002:ad4:5748:: with SMTP id q8mr24551032qvx.1.1595903985030;
        Mon, 27 Jul 2020 19:39:45 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id z3sm13885548qkc.4.2020.07.27.19.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 19:39:44 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        linux-pm@vger.kernel.org (open list:INTERCONNECT API),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/7] dt-bindings: interconnect: single yaml file for RPMh interconnect drivers
Date:   Mon, 27 Jul 2020 22:38:00 -0400
Message-Id: <20200728023811.5607-2-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200728023811.5607-1-jonathan@marek.ca>
References: <20200728023811.5607-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

These two bindings are almost identical, so combine them into one. This
will make it easier to add the sm8150 and sm8250 interconnect bindings.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 .../{qcom,sdm845.yaml => qcom,rpmh.yaml}      | 20 ++++-
 .../bindings/interconnect/qcom,sc7180.yaml    | 85 -------------------
 2 files changed, 17 insertions(+), 88 deletions(-)
 rename Documentation/devicetree/bindings/interconnect/{qcom,sdm845.yaml => qcom,rpmh.yaml} (76%)
 delete mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
similarity index 76%
rename from Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml
rename to Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
index 74536747b51d..6a457f914bb5 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
@@ -1,16 +1,17 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/interconnect/qcom,sdm845.yaml#
+$id: http://devicetree.org/schemas/interconnect/qcom,rpmh.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title:  Qualcomm SDM845 Network-On-Chip Interconnect
+title:  Qualcomm RPMh Network-On-Chip Interconnect
 
 maintainers:
   - Georgi Djakov <georgi.djakov@linaro.org>
+  - Odelu Kukatla <okukatla@codeaurora.org>
 
 description: |
-   SDM845 interconnect providers support system bandwidth requirements through
+   RPMh interconnect providers support system bandwidth requirements through
    RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
    able to communicate with the BCM through the Resource State Coordinator (RSC)
    associated with each execution environment. Provider nodes must point to at
@@ -23,6 +24,19 @@ properties:
 
   compatible:
     enum:
+      - qcom,sc7180-aggre1-noc
+      - qcom,sc7180-aggre2-noc
+      - qcom,sc7180-camnoc-virt
+      - qcom,sc7180-compute-noc
+      - qcom,sc7180-config-noc
+      - qcom,sc7180-dc-noc
+      - qcom,sc7180-gem-noc
+      - qcom,sc7180-ipa-virt
+      - qcom,sc7180-mc-virt
+      - qcom,sc7180-mmss-noc
+      - qcom,sc7180-npu-noc
+      - qcom,sc7180-qup-virt
+      - qcom,sc7180-system-noc
       - qcom,sdm845-aggre1-noc
       - qcom,sdm845-aggre2-noc
       - qcom,sdm845-config-noc
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml
deleted file mode 100644
index d01bac80d416..000000000000
--- a/Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml
+++ /dev/null
@@ -1,85 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/interconnect/qcom,sc7180.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title:  Qualcomm SC7180 Network-On-Chip Interconnect
-
-maintainers:
-  - Odelu Kukatla <okukatla@codeaurora.org>
-
-description: |
-   SC7180 interconnect providers support system bandwidth requirements through
-   RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
-   able to communicate with the BCM through the Resource State Coordinator (RSC)
-   associated with each execution environment. Provider nodes must point to at
-   least one RPMh device child node pertaining to their RSC and each provider
-   can map to multiple RPMh resources.
-
-properties:
-  reg:
-    maxItems: 1
-
-  compatible:
-    enum:
-      - qcom,sc7180-aggre1-noc
-      - qcom,sc7180-aggre2-noc
-      - qcom,sc7180-camnoc-virt
-      - qcom,sc7180-compute-noc
-      - qcom,sc7180-config-noc
-      - qcom,sc7180-dc-noc
-      - qcom,sc7180-gem-noc
-      - qcom,sc7180-ipa-virt
-      - qcom,sc7180-mc-virt
-      - qcom,sc7180-mmss-noc
-      - qcom,sc7180-npu-noc
-      - qcom,sc7180-qup-virt
-      - qcom,sc7180-system-noc
-
-  '#interconnect-cells':
-    const: 1
-
-  qcom,bcm-voters:
-    $ref: /schemas/types.yaml#/definitions/phandle-array
-    description: |
-      List of phandles to qcom,bcm-voter nodes that are required by
-      this interconnect to send RPMh commands.
-
-  qcom,bcm-voter-names:
-    $ref: /schemas/types.yaml#/definitions/string-array
-    description: |
-      Names for each of the qcom,bcm-voters specified.
-
-required:
-  - compatible
-  - reg
-  - '#interconnect-cells'
-  - qcom,bcm-voters
-
-additionalProperties: false
-
-examples:
-  - |
-      #include <dt-bindings/interconnect/qcom,sc7180.h>
-
-      config_noc: interconnect@1500000 {
-            compatible = "qcom,sc7180-config-noc";
-            reg = <0x01500000 0x28000>;
-            #interconnect-cells = <1>;
-            qcom,bcm-voters = <&apps_bcm_voter>;
-      };
-
-      system_noc: interconnect@1620000 {
-            compatible = "qcom,sc7180-system-noc";
-            reg = <0x01620000 0x17080>;
-            #interconnect-cells = <1>;
-            qcom,bcm-voters = <&apps_bcm_voter>;
-      };
-
-      mmss_noc: interconnect@1740000 {
-            compatible = "qcom,sc7180-mmss-noc";
-            reg = <0x01740000 0x1c100>;
-            #interconnect-cells = <1>;
-            qcom,bcm-voters = <&apps_bcm_voter>;
-      };
-- 
2.26.1

