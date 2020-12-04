Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2562CE8FA
	for <lists+linux-pm@lfdr.de>; Fri,  4 Dec 2020 08:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387456AbgLDHza (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Dec 2020 02:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387444AbgLDHz3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Dec 2020 02:55:29 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EE0C08E864
        for <linux-pm@vger.kernel.org>; Thu,  3 Dec 2020 23:54:24 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id j1so2670872pld.3
        for <linux-pm@vger.kernel.org>; Thu, 03 Dec 2020 23:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Lm1+FijB9EOGGroxnsZ4TR7k5iwLmk9ywUmiI4uDdNQ=;
        b=TaR88oJ7zJ5znwmeRC+87havp7+aDdffgvy7clrGsspwIKOeeMHB4ElYh6N5vBTP0h
         VZkIP6KFJYbzU/3f2Z2d6xvQF1ZPuADdNLlquPvdcOcjkz6iX67xEAiAXd6u0qDQPXuQ
         Vx4dX4F65gYB2KD7tKGH8bdk6mIJfJncYpktd7M7b884+HccnGvQCYEO7k37Xe7DIKdD
         z6wT1AgQO8RA4D3DcysA9ujO7eXLg3CcRGOtnAfU3lgUD2NGvxyGD5D31ilfQLIkRmNO
         n1dkS5TYAm+P23YbWe+V/pvakQefhGWIM8oY3EkfjMOQ9ssfuoJwzsY+FDXeTtbwKR9V
         sazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Lm1+FijB9EOGGroxnsZ4TR7k5iwLmk9ywUmiI4uDdNQ=;
        b=B4iSCFfPXPjdz50KUSE/dsRS9kOTEYleqZo0eU6h8PD43uJ2GUW3IVBZR0kLAjKYbZ
         +LXf9MHXoHofETwXClb4ZyTxfmAZ4CcqjRBePXbH/wFlpEX7cT4eR1YWmt30430o/fDV
         a4RnBMD56FIv6jzXdVdCGTQYvFfBR/AhtGvcXlrC40voL9J0kRnUNcuHOmQ1oQdm+uMB
         VJ28gP/vg+iTcJEtgKz6oseqTnTP4SuajuWeXUKZAjm+xEzG4BqdFz0cu4cRXOnpBFg5
         IufMixzKIHvyFPBW4OH0N0AFAQ+cKJvXXElGLkmWuKEfmU1L8jzuN/7lSWIcnphdAxH/
         LSXA==
X-Gm-Message-State: AOAM531T/+wcazI3cljFyon3LFL+VjbTb+HY5oD0fUMxQSMDNTM3ahvC
        SHbJv6n78U2jXt2tgFX3jeuViw==
X-Google-Smtp-Source: ABdhPJygGhrYD3Y6b1GvmOvAuDkr2sHyel+ReMF5zN40dlMIQ5AAbsnXF2U7cqjMfSP79mql6lgPjQ==
X-Received: by 2002:a17:90a:178b:: with SMTP id q11mr2978600pja.132.1607068463747;
        Thu, 03 Dec 2020 23:54:23 -0800 (PST)
Received: from localhost.localdomain (li519-153.members.linode.com. [66.175.222.153])
        by smtp.gmail.com with ESMTPSA id l190sm3822262pfl.205.2020.12.03.23.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 23:54:23 -0800 (PST)
From:   Jun Nie <jun.nie@linaro.org>
To:     devicetree@vger.kernel.org, georgi.djakov@linaro.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org
Cc:     vincent.knecht@mailoo.org, shawn.guo@linaro.org,
        Jun Nie <jun.nie@linaro.org>
Subject: [PATCH v2 3/5] dt-bindings: interconnect: single yaml file for RPM interconnect drivers
Date:   Fri,  4 Dec 2020 15:53:43 +0800
Message-Id: <20201204075345.5161-4-jun.nie@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201204075345.5161-1-jun.nie@linaro.org>
References: <20201204075345.5161-1-jun.nie@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

MSM8916 and QCS404 bindings are almost identical, so combine them into one.
This will make it easier to add interconnect bindings for more SoC with RPM.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/interconnect/qcom,qcs404.yaml    | 77 -------------------
 .../{qcom,msm8916.yaml => qcom,rpm.yaml}      | 18 +++--
 2 files changed, 11 insertions(+), 84 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcs404.yaml
 rename Documentation/devicetree/bindings/interconnect/{qcom,msm8916.yaml => qcom,rpm.yaml} (81%)

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
similarity index 81%
rename from Documentation/devicetree/bindings/interconnect/qcom,msm8916.yaml
rename to Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
index e1009ae4e8f7..d720b68b3ead 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8916.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
@@ -1,27 +1,31 @@
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
+  RPM interconnect providers support system bandwidth requirements through
+  RPM processor. The provider is able to communicate with the RPM through
+  the RPM shared memory device.
 
 properties:
+  reg:
+    maxItems: 1
+
   compatible:
     enum:
       - qcom,msm8916-bimc
       - qcom,msm8916-pcnoc
       - qcom,msm8916-snoc
-
-  reg:
-    maxItems: 1
+      - qcom,qcs404-bimc
+      - qcom,qcs404-pcnoc
+      - qcom,qcs404-snoc
 
   '#interconnect-cells':
     const: 1
-- 
2.17.1

