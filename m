Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1B175F945
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jul 2023 16:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjGXOGh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jul 2023 10:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjGXOGf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jul 2023 10:06:35 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0C3E64
        for <linux-pm@vger.kernel.org>; Mon, 24 Jul 2023 07:06:33 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fb863edcb6so6570011e87.0
        for <linux-pm@vger.kernel.org>; Mon, 24 Jul 2023 07:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690207591; x=1690812391;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CapD9bYuIwUBKvnkt1qJ6Eemt2zJ1oxS+R4FEv0Bm0g=;
        b=AqcIdqD41SpNK2X2B8hSTnLurI1F5svcZcyRVNqIz4559TniEhyh242n2bKqJS64CQ
         ww+XFroXZCYgSYdT91JQGvcGH3ULmQWSznVIUIW5CSJQrcfzKeq7Xuxu9q0cYQRBn+8h
         MpeIhPTBtrAH7JXpiYOkYJ0rNE6Bgl6eIM0Ajr9XL4JZFGnAWuni+lN608fC6MK3eQSC
         25Qz4FmA1m5US40WJech+ZXWGqMkvfSg8QZpiamVBvUI0mMM1iZncJPGDpmpo67RsTlZ
         nzphsMTbfXZupgUTTQc7XqWMf33/vTYnAXwRiU9clKTzTqSZbE/byxhM9MDCRiECbvke
         3Isw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690207591; x=1690812391;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CapD9bYuIwUBKvnkt1qJ6Eemt2zJ1oxS+R4FEv0Bm0g=;
        b=iKRh5OfdA9LXGuSNhYnZ4EyXhjP5/ahrelvOE+0wmcZ7eoF4qV82+hXteP+Myuv7kR
         6gz1LnEEhxubOHklNI+CzMAFRu8JZ3ZXT/PQbHVVa7Y7+lvg3uuJCpErrB7k0xysHs14
         /+S5uFJKDbW8aydJZMt8iCdndB8zvUAhLUH49ao+4kdajPDIIqn4N2slN+n3V/7u7+fC
         alYTKn36947lGaE1ZHXQrxNG9ON/sZ5J6uR7e6g4HPnHoy71uG61dgadMdbrDBF+KBsh
         Mj+MSvW31BoP1K/rI+vm44CPTqn95HF5GC2Xfc7nNWo2E7qc9sFu1RJhg/NWt6toHUYS
         15Mw==
X-Gm-Message-State: ABy/qLakQKzcSR3NmZQ3GyB99TtUaE0NSVTvCXutf9+vHcWSUJa10wqM
        LHtxAmp2LeWev0Ido8qJABodNw==
X-Google-Smtp-Source: APBJJlGoSgvtMzJreKfCBVlI+zQ88ZIhnA8RdOXSkmJzzxW9cm2bNyTXwgYAtJtQa2iHx7pgmvbOCw==
X-Received: by 2002:a05:6512:15a8:b0:4fd:faf0:6591 with SMTP id bp40-20020a05651215a800b004fdfaf06591mr1587057lfb.10.1690207590869;
        Mon, 24 Jul 2023 07:06:30 -0700 (PDT)
Received: from [192.168.1.101] (abxj221.neoplus.adsl.tpnet.pl. [83.9.3.221])
        by smtp.gmail.com with ESMTPSA id er26-20020a05651248da00b004fbab1f023csm2223481lfb.138.2023.07.24.07.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 07:06:30 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 24 Jul 2023 16:06:27 +0200
Subject: [PATCH v2 1/7] dt-bindings: interconnect: qcom: Introduce
 qcom,rpm-common
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230721-topic-icc_bindings-v2-1-e33d5acbf3bd@linaro.org>
References: <20230721-topic-icc_bindings-v2-0-e33d5acbf3bd@linaro.org>
In-Reply-To: <20230721-topic-icc_bindings-v2-0-e33d5acbf3bd@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690207588; l=3192;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=DFcyR0dd5amSxKhNEmUSmBnWVhsX8Mb+i59oiYKx9c4=;
 b=NbwvG601DWdnCJKIO2oWBvJFf4T6510JL6NWGgxi9ywRj1MSoZDKvluPSNMXZix4dZQqv0nat
 8KgwxsVRsmBCLujdhiN2SBHJVYBQnQYNcM3jEj1Uke/dqn0ryC6hcaK
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The current RPM interconnect bindings are messy. Start cleaning them
up with a common include.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/interconnect/qcom,qcm2290.yaml        | 18 +++++++-------
 .../bindings/interconnect/qcom,rpm-common.yaml     | 28 ++++++++++++++++++++++
 2 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml b/Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml
index f65a2fe846de..df89f390a9b0 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml
@@ -13,6 +13,9 @@ description: |
   The Qualcomm QCM2290 interconnect providers support adjusting the
   bandwidth requirements between the various NoC fabrics.
 
+allOf:
+  - $ref: qcom,rpm-common.yaml#
+
 properties:
   reg:
     maxItems: 1
@@ -23,9 +26,6 @@ properties:
       - qcom,qcm2290-cnoc
       - qcom,qcm2290-snoc
 
-  '#interconnect-cells':
-    const: 1
-
   clock-names:
     items:
       - const: bus
@@ -44,6 +44,9 @@ patternProperties:
       The interconnect providers do not have a separate QoS register space,
       but share parent's space.
 
+    allOf:
+      - $ref: qcom,rpm-common.yaml#
+
     properties:
       compatible:
         enum:
@@ -51,9 +54,6 @@ patternProperties:
           - qcom,qcm2290-mmrt-virt
           - qcom,qcm2290-mmnrt-virt
 
-      '#interconnect-cells':
-        const: 1
-
       clock-names:
         items:
           - const: bus
@@ -66,20 +66,18 @@ patternProperties:
 
     required:
       - compatible
-      - '#interconnect-cells'
       - clock-names
       - clocks
 
-    additionalProperties: false
+    unevaluatedProperties: false
 
 required:
   - compatible
   - reg
-  - '#interconnect-cells'
   - clock-names
   - clocks
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpm-common.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpm-common.yaml
new file mode 100644
index 000000000000..1ea52b091609
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpm-common.yaml
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,rpm-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm RPMh Network-On-Chip Interconnect
+
+maintainers:
+  - Konrad Dybcio <konradybcio@kernel.org>
+
+description:
+  RPM interconnect providers support for managing system bandwidth requirements
+  through manual requests based on either predefined values or as indicated by
+  the bus monitor hardware. Each provider node represents a NoC bus master,
+  driven by a dedicated clock source.
+
+properties:
+  '#interconnect-cells':
+    oneOf:
+      - const: 2
+      - const: 1
+        deprecated: true
+
+required:
+  - '#interconnect-cells'
+
+additionalProperties: true

-- 
2.41.0

