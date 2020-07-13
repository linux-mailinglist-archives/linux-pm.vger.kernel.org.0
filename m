Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058C421DA5A
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 17:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbgGMPmv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 11:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729806AbgGMPmu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 11:42:50 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C293CC061755
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 08:42:50 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id i3so10234477qtq.13
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 08:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fBkvJA+OBYCqy/w9rh6WipjqZaqykhBizHU4FH5/a70=;
        b=T1eIEg5BnGK/MhA+kO5ZwkyNTOvU1AQe2uAoEEV3EK7g+C1fboIWcjjn0tiTEwETNo
         kVLT0j5e2igwTSgRk6vBfQSHHZb+mY4VntOkMyRRWaT3smHLIQaL0UlEzhIecvBwxmXi
         bLjImdJWrg8+bD1RtI5Us6ovapmOaHhn3a5HEa7o3e7fYDw1lBzqdTR6H8IQocu1e+zP
         XpJt3NZ+xK7Um8cf/CsG6A2JgmXwapklcQy9XIcFsNymkSEoBRDmmK3MJMdkwswZKy3m
         ee4jrr2hlMD4Mg9d+Z3TdG99f6EJ0N5JwVxEheu5NqRXD17AaffEzDOzNWZZsCt038fr
         8KlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fBkvJA+OBYCqy/w9rh6WipjqZaqykhBizHU4FH5/a70=;
        b=BxmK7+tX+gOs/8S72oFVQgG0qX18Fh3j3Nb9SgULaUOKTKkAgMOQLazG5XXPTBgTN9
         spGekTrCCn/C1lVuxH+Ab45sGEf4fldgUwXtOCENbBwDKUNDiznKu9D32d4jTdG5kNX7
         fglP8tn9YZHKXKfMN6Jqg7kMPhzL9SX/LoxqQstxefKgfSslarzpXCJGerpXb5wPaBdi
         IIHNAVaHZiStvRfXYu16X/9mWFjn9hwtISaoJGWplVrj04odm8AGFY5fbqaTZJj9zQXn
         Fo/yNnLjW02KzkW+4OY20MeBDWQzPteoDCudSY6bphy26e/2jsl8LAcLY9BKqin3NuCd
         lvvg==
X-Gm-Message-State: AOAM532t86k0QCpxJLc5/+PctEGT5y/31KnTDHojGwCv7KTENDTQFFZ3
        vM0hmuWeYFfShZK0S4Lja2pJBQ==
X-Google-Smtp-Source: ABdhPJzT3RNLlaSDxmjw/n9TGbDLbX3SwdZUPFcQFBMS7zAG+klDiStL4IjP2cad6vI1u6DUb42dYQ==
X-Received: by 2002:ac8:1ac4:: with SMTP id h4mr87960956qtk.249.1594654969941;
        Mon, 13 Jul 2020 08:42:49 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id l1sm19806371qtk.18.2020.07.13.08.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 08:42:49 -0700 (PDT)
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
Subject: [PATCH v2 1/7] dt-bindings: interconnect: single yaml file for RPMh interconnect drivers
Date:   Mon, 13 Jul 2020 11:41:10 -0400
Message-Id: <20200713154121.22094-2-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200713154121.22094-1-jonathan@marek.ca>
References: <20200713154121.22094-1-jonathan@marek.ca>
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
 .../{qcom,sc7180.yaml => qcom,rpmh.yaml}      | 33 ++++++++-
 .../bindings/interconnect/qcom,sdm845.yaml    | 74 -------------------
 2 files changed, 30 insertions(+), 77 deletions(-)
 rename Documentation/devicetree/bindings/interconnect/{qcom,sc7180.yaml => qcom,rpmh.yaml} (67%)
 delete mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
similarity index 67%
rename from Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml
rename to Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
index d01bac80d416..9878139a73b8 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
@@ -1,16 +1,17 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/interconnect/qcom,sc7180.yaml#
+$id: http://devicetree.org/schemas/interconnect/qcom,rpmh.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title:  Qualcomm SC7180 Network-On-Chip Interconnect
+title:  Qualcomm RPMh Network-On-Chip Interconnect
 
 maintainers:
+  - Georgi Djakov <georgi.djakov@linaro.org>
   - Odelu Kukatla <okukatla@codeaurora.org>
 
 description: |
-   SC7180 interconnect providers support system bandwidth requirements through
+   RPMh interconnect providers support system bandwidth requirements through
    RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
    able to communicate with the BCM through the Resource State Coordinator (RSC)
    associated with each execution environment. Provider nodes must point to at
@@ -36,6 +37,14 @@ properties:
       - qcom,sc7180-npu-noc
       - qcom,sc7180-qup-virt
       - qcom,sc7180-system-noc
+      - qcom,sdm845-aggre1-noc
+      - qcom,sdm845-aggre2-noc
+      - qcom,sdm845-config-noc
+      - qcom,sdm845-dc-noc
+      - qcom,sdm845-gladiator-noc
+      - qcom,sdm845-mem-noc
+      - qcom,sdm845-mmss-noc
+      - qcom,sdm845-system-noc
 
   '#interconnect-cells':
     const: 1
@@ -60,6 +69,24 @@ required:
 additionalProperties: false
 
 examples:
+  - |
+      #include <dt-bindings/interconnect/qcom,sdm845.h>
+
+      mem_noc: interconnect@1380000 {
+             compatible = "qcom,sdm845-mem-noc";
+             reg = <0x01380000 0x27200>;
+             #interconnect-cells = <1>;
+             qcom,bcm-voters = <&apps_bcm_voter>;
+      };
+
+      mmss_noc: interconnect@1740000 {
+             compatible = "qcom,sdm845-mmss-noc";
+             reg = <0x01740000 0x1c1000>;
+             #interconnect-cells = <1>;
+             qcom,bcm-voter-names = "apps", "disp";
+             qcom,bcm-voters = <&apps_bcm_voter>, <&disp_bcm_voter>;
+      };
+
   - |
       #include <dt-bindings/interconnect/qcom,sc7180.h>
 
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml
deleted file mode 100644
index 74536747b51d..000000000000
--- a/Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml
+++ /dev/null
@@ -1,74 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/interconnect/qcom,sdm845.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title:  Qualcomm SDM845 Network-On-Chip Interconnect
-
-maintainers:
-  - Georgi Djakov <georgi.djakov@linaro.org>
-
-description: |
-   SDM845 interconnect providers support system bandwidth requirements through
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
-      - qcom,sdm845-aggre1-noc
-      - qcom,sdm845-aggre2-noc
-      - qcom,sdm845-config-noc
-      - qcom,sdm845-dc-noc
-      - qcom,sdm845-gladiator-noc
-      - qcom,sdm845-mem-noc
-      - qcom,sdm845-mmss-noc
-      - qcom,sdm845-system-noc
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
-      #include <dt-bindings/interconnect/qcom,sdm845.h>
-
-      mem_noc: interconnect@1380000 {
-             compatible = "qcom,sdm845-mem-noc";
-             reg = <0x01380000 0x27200>;
-             #interconnect-cells = <1>;
-             qcom,bcm-voters = <&apps_bcm_voter>;
-      };
-
-      mmss_noc: interconnect@1740000 {
-             compatible = "qcom,sdm845-mmss-noc";
-             reg = <0x01740000 0x1c1000>;
-             #interconnect-cells = <1>;
-             qcom,bcm-voter-names = "apps", "disp";
-             qcom,bcm-voters = <&apps_bcm_voter>, <&disp_bcm_voter>;
-      };
-- 
2.26.1

