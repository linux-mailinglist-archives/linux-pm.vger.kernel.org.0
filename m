Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E04F21BDF2
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 21:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgGJTqQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 15:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728535AbgGJTqN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2020 15:46:13 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9524DC08E6DC;
        Fri, 10 Jul 2020 12:46:13 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id w6so7305356ejq.6;
        Fri, 10 Jul 2020 12:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Neukk5Ha30hw7xCMR87weS6wdEy4yDg0uzyL5tr2Zk=;
        b=sFQFMa5MwgkhmWpwuF4Tqu66g6+70VZ96IG1D1bGOW/13LYgHhxJDi/ScNr7F4cOfm
         zEl3/5l6Apw9O73pIeE5+lQe4qnkH1ciwhbT9i3Gm/gzJsuuJXzyYcleBgPMxL1U2ZQq
         Ex6LqNDV36UVm92LsCTd0raOaa2EG/qu4hr/2BHUPEAJKdQEmWUnC2NRPe+BRYCYulcX
         mS+NXXobRtQ/ddxIQjffZbLH3OX7TKHt7R25J0CYuWzDu82AZWSfcqDptDL20vnKVkWu
         x5stIIGSsCCPGsoni3+cNFG1pYsulANcwnXpCXSoqbtc2elCcE5NfQ78Ik1CpcqgsoX3
         Jw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Neukk5Ha30hw7xCMR87weS6wdEy4yDg0uzyL5tr2Zk=;
        b=p9YN4paKmw9yz0gNgcP2+0XJ302oh9OBX3HxEapXIM/cWPETNukpCH4YusAdI7O7TP
         YBPQwB2fFTJMogzYC9Vdpos7NYu06biuTg/4TTJifFnrV6s2RgrRqlNBLHAAUgOFBoqH
         uE3eCJm8Wt8NrXgd8fwgrEBbd1gDrSA39Q4zBDuqMBiQE/m0fIRet+cN2bUzItJyBHSq
         XsteVeplb+kaOJDQH4O0TnQPVHEP4pnuvsVnBxkkfRuZGrw2qHhANquTY2HwUESluuwZ
         jJoPAYgNjuLxmvDWGe3TpWGgg8u1Qkw9wEkNQ+wP9zNXKPTPsuYtvdUmAOsFHBWa3qOT
         VZLw==
X-Gm-Message-State: AOAM530pglxR4WMn9a5lnVG352q7RsMyrtMxBiDidpmcg0yGUKz3CU6s
        PQl8ji+WQgHvbiqy14iwsM2z3Tivrtg=
X-Google-Smtp-Source: ABdhPJz6Da6O0pPqNk+DasQ9vpu/01bXtZQv/a1Bp7pcRV30Cdw2jj2veKSqdoXlPu39xMduWFE1Mg==
X-Received: by 2002:a17:906:391:: with SMTP id b17mr49916697eja.282.1594410371260;
        Fri, 10 Jul 2020 12:46:11 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-87-16-250-164.retail.telecomitalia.it. [87.16.250.164])
        by smtp.googlemail.com with ESMTPSA id kt4sm4155768ejb.48.2020.07.10.12.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 12:46:10 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] dt-bindings: thermal: tsens: document ipq8064 bindings
Date:   Fri, 10 Jul 2020 21:45:54 +0200
Message-Id: <20200710194558.26487-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710194558.26487-1-ansuelsmth@gmail.com>
References: <20200710194558.26487-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Document the use of regmap phandle for ipq8064 SoCs

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .../bindings/thermal/qcom-tsens.yaml          | 53 ++++++++++++++++---
 1 file changed, 46 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index d7be931b42d2..964a68d194d2 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -19,6 +19,11 @@ description: |
 properties:
   compatible:
     oneOf:
+      - description: msm9860 TSENS based
+        items:
+          - enum:
+            - qcom,ipq8064-tsens
+
       - description: v0.1 of TSENS
         items:
           - enum:
@@ -47,6 +52,11 @@ properties:
       - description: TM registers
       - description: SROT registers
 
+  regmap:
+    description:
+      Phandle to the gcc. On ipq8064 SoCs gcc and tsense share the same regs.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
   interrupts:
     minItems: 1
     items:
@@ -85,12 +95,18 @@ properties:
       Number of cells required to uniquely identify the thermal sensors. Since
       we have multiple sensors this is set to 1
 
+required:
+  - compatible
+  - interrupts
+  - "#thermal-sensor-cells"
+
 allOf:
   - if:
       properties:
         compatible:
           contains:
             enum:
+              - qcom,ipq8064-tsens
               - qcom,msm8916-tsens
               - qcom,msm8974-tsens
               - qcom,msm8976-tsens
@@ -111,17 +127,40 @@ allOf:
         interrupt-names:
           minItems: 2
 
-required:
-  - compatible
-  - reg
-  - "#qcom,sensors"
-  - interrupts
-  - interrupt-names
-  - "#thermal-sensor-cells"
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq8064-tsens
+    then:
+      required:
+        - regmap
+
+    else:
+      required:
+        - reg
+        - interrupt-names
+        - "#qcom,sensors"
 
 additionalProperties: false
 
 examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    // Example msm9860 based SoC (ipq8064):
+    tsens: thermal-sensor {
+           compatible = "qcom,ipq8064-tsens";
+           regmap = <&gcc>;
+
+           nvmem-cells = <&tsens_calib>, <&tsens_calsel>;
+           nvmem-cell-names = "calib", "calib_sel";
+
+           interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
+
+           #thermal-sensor-cells = <1>;
+    };
+
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     // Example 1 (legacy: for pre v1 IP):
-- 
2.27.0

