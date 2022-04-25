Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928AA50EBBC
	for <lists+linux-pm@lfdr.de>; Tue, 26 Apr 2022 00:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236742AbiDYWYw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Apr 2022 18:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343531AbiDYVbD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Apr 2022 17:31:03 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0E93CA79
        for <linux-pm@vger.kernel.org>; Mon, 25 Apr 2022 14:27:57 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id w19so28530174lfu.11
        for <linux-pm@vger.kernel.org>; Mon, 25 Apr 2022 14:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oPLNTV7n0Ijb4QN5+/ZP2G9taYmSFsaYJE9s/1u9hZM=;
        b=naJmfFn/7aQnWrxs9416P0rXLGU3UuoRg12Hd2uPQ7aG8ExsuJJ3O5N0UcqtwH1Gjr
         D6KcqvTJmL3XaOU50e05bhYTtDlDs49JFC1bebV+ilqiPq6mrUkL2R/ar7nsfLaY51FH
         qpVp8cyC6ZngTFZT5gxmL0I+IaCaR6cY42SEdIPYG5osUdiy6R8zwSwx/sySiV+5as5j
         +D50vkEtXK+eWPp5fRkHt3NJXwVP+J7rQVTTYxuJvwC981dGs34YVBq5HpbS59acGsuQ
         QPZdfcTlVHuIPXk5Xili/MiDQcAocHnGhkisRPsqs5FOG+mxscW2ee7JJ92Vgl3Y5WMJ
         eqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oPLNTV7n0Ijb4QN5+/ZP2G9taYmSFsaYJE9s/1u9hZM=;
        b=kc5hsjl8b0SREzugLvVW0A8gJwN+RQwZ/SZjByHZswBnIlJAfSQ9PdYn1VFqhnCpRa
         FDHmc5SAonLrMicncWU59df50+/WIiTKUpfXkE8VbEhrg6UnQla5d9ED5gmaPhah8FAv
         GwFQAKB1fIEkYR8TrvioPKxg9IMetgypv7e1EvHIGwzHUYrPotl/9nwTq3Q5gYH0h0Po
         6yhZ7iZ1zYyxardficimBIm3H4H8QnLo4ZoCpPqdo2tCR0VFo3EqaC1Er6E0VdOzR1cN
         hfdDcbNd4aIS3/d0C866zRgKrOFCoyegL4iHy6JDfdJiZVLuG0gsDepSVy9AnSQw5poQ
         3whQ==
X-Gm-Message-State: AOAM531V/KUJ/HiR/PDb7EvBbEWB2rfwN0kOnPZ/HlW5Wo1Qm5cvtESx
        jriIMchnlzZabNE7D6qG9u1K5A==
X-Google-Smtp-Source: ABdhPJzEO2UHb/QHosYyH0Xm5NQj8w1ENiOVLuq2H7eBIiIfNVF7f3HXW7kbOg0E9EVBQJ9SZt36WQ==
X-Received: by 2002:ac2:4203:0:b0:448:8053:d402 with SMTP id y3-20020ac24203000000b004488053d402mr14176200lfh.687.1650922075466;
        Mon, 25 Apr 2022 14:27:55 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id l13-20020a19494d000000b0046ba0e38750sm1533314lfj.3.2022.04.25.14.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 14:27:54 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v3 3/3] dt-bindings: clock: qcom,gcc-apq8064: split tsens to the child node
Date:   Tue, 26 Apr 2022 00:27:50 +0300
Message-Id: <20220425212750.2749135-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220425212750.2749135-1-dmitry.baryshkov@linaro.org>
References: <20220425212750.2749135-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Split tsens properties to the child node of the gcc. This follows the
lead of ipq8064 (which also uses a separate node for tsens) and makes
device tree closer to other platforms, where tsens is a completely
separate device.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../bindings/clock/qcom,gcc-apq8064.yaml      | 45 +++++++------------
 1 file changed, 17 insertions(+), 28 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
index b867da12761e..f2762599f679 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
@@ -23,47 +23,36 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - qcom,gcc-apq8064
-      - qcom,gcc-msm8060
-
-  nvmem-cells:
-    minItems: 1
-    maxItems: 2
-    description:
-      Qualcomm TSENS (thermal sensor device) on some devices can
-      be part of GCC and hence the TSENS properties can also be part
-      of the GCC/clock-controller node.
-      For more details on the TSENS properties please refer
-      Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
-
-  nvmem-cell-names:
-    minItems: 1
     items:
-      - const: calib
-      - const: calib_backup
-
-  '#thermal-sensor-cells':
-    const: 1
+      - enum:
+          - qcom,gcc-apq8064
+          - qcom,gcc-msm8060
+      - const: syscon
 
 required:
   - compatible
-  - nvmem-cells
-  - nvmem-cell-names
-  - '#thermal-sensor-cells'
 
 unevaluatedProperties: false
 
 examples:
   - |
     clock-controller@900000 {
-      compatible = "qcom,gcc-apq8064";
+      compatible = "qcom,gcc-apq8064", "syscon";
       reg = <0x00900000 0x4000>;
-      nvmem-cells = <&tsens_calib>, <&tsens_backup>;
-      nvmem-cell-names = "calib", "calib_backup";
       #clock-cells = <1>;
       #reset-cells = <1>;
       #power-domain-cells = <1>;
-      #thermal-sensor-cells = <1>;
+
+      thermal-sensor {
+        compatible = "qcom,msm8960-tsens";
+
+        nvmem-cells = <&tsens_calib>, <&tsens_backup>;
+        nvmem-cell-names = "calib", "calib_backup";
+        interrupts = <0 178 4>;
+        interrupt-names = "uplow";
+
+        #qcom,sensors = <11>;
+        #thermal-sensor-cells = <1>;
+        };
     };
 ...
-- 
2.35.1

