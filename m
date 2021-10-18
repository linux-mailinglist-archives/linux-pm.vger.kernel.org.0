Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7DAD431149
	for <lists+linux-pm@lfdr.de>; Mon, 18 Oct 2021 09:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhJRHUC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Oct 2021 03:20:02 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:15804 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbhJRHUC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Oct 2021 03:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1634541471; x=1666077471;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=ccKtCxZdu4gFjQYBt6CXv3rmuli2NT7/4Lb9YNS2ayc=;
  b=UPla4Oja23ebDSArdeu4wdXG1x6ablAeSjfyUq/mEPHS6E4aiwwZBUaQ
   t/nOMkvvE9tbgaAi7KaOgbvSgI6Er603y1ZrGiGicy9/vxjkxvIayfpnj
   6W4tJnoB0rf8S5QkINCfMQwfvF/4nkogw+p9ePJwKfMs5lQjpv69MTgbD
   Y=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 18 Oct 2021 00:17:51 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2021 00:17:49 -0700
Received: from jprakash-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Mon, 18 Oct 2021 00:17:43 -0700
From:   Jishnu Prakash <quic_jprakash@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <devicetree@vger.kernel.org>, <mka@chromium.org>,
        <linus.walleij@linaro.org>, <dmitry.baryshkov@linaro.org>,
        <Jonathan.Cameron@huawei.com>, <quic_kgunda@quicinc.com>,
        <quic_aghayal@quicinc.com>, <quic_subbaram@quicinc.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        "Zhang Rui" <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-arm-msm-owner@vger.kernel.org>,
        Jishnu Prakash <quic_jprakash@quicinc.com>
Subject: [PATCH 1/2] dt-bindings: thermal: qcom: add PMIC5 Gen2 ADC_TM bindings
Date:   Mon, 18 Oct 2021 12:47:08 +0530
Message-ID: <1634541429-3215-2-git-send-email-quic_jprakash@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1634541429-3215-1-git-send-email-quic_jprakash@quicinc.com>
References: <1634541429-3215-1-git-send-email-quic_jprakash@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add documentation for PMIC5 Gen2 ADC_TM peripheral.
It is used for monitoring ADC channel thresholds for PMIC7-type
PMICs. It is present on PMK8350, like PMIC7 ADC and can be used
to monitor up to 8 ADC channels, from any of the PMIC7 PMICs
on a target, through PBS(Programmable Boot Sequence).

Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
---
 .../bindings/thermal/qcom-spmi-adc-tm5.yaml        | 83 +++++++++++++++++++++-
 1 file changed, 81 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
index 3ea8c0c..71a05a3 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
@@ -10,7 +10,9 @@ maintainers:
 
 properties:
   compatible:
-    const: qcom,spmi-adc-tm5
+    enum:
+      - qcom,spmi-adc-tm5
+      - qcom,spmi-adc-tm5-gen2
 
   reg:
     maxItems: 1
@@ -33,6 +35,7 @@ properties:
   qcom,avg-samples:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: Number of samples to be used for measurement.
+            Not applicable for Gen2 ADC_TM peripheral.
     enum:
       - 1
       - 2
@@ -45,6 +48,7 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: This parameter is used to decrease ADC sampling rate.
             Quicker measurements can be made by reducing decimation ratio.
+            Not applicable for Gen2 ADC_TM peripheral.
     enum:
       - 250
       - 420
@@ -93,6 +97,29 @@ patternProperties:
           - const: 1
           - enum: [ 1, 3, 4, 6, 20, 8, 10 ]
 
+      qcom,avg-samples:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: Number of samples to be used for measurement.
+          This property in child node is applicable only for Gen2 ADC_TM peripheral.
+        enum:
+          - 1
+          - 2
+          - 4
+          - 8
+          - 16
+        default: 1
+
+      qcom,decimation:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: This parameter is used to decrease ADC sampling rate.
+          Quicker measurements can be made by reducing decimation ratio.
+          This property in child node is applicable only for Gen2 ADC_TM peripheral.
+        enum:
+          - 85
+          - 340
+          - 1360
+        default: 1360
+
     required:
       - reg
       - io-channels
@@ -124,7 +151,7 @@ examples:
             #size-cells = <0>;
             #io-channel-cells = <1>;
 
-            /* Other propreties are omitted */
+            /* Other properties are omitted */
             conn-therm@4f {
                 reg = <ADC5_AMUX_THM3_100K_PU>;
                 qcom,ratiometric;
@@ -148,4 +175,56 @@ examples:
             };
         };
     };
+
+  - |
+    #include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
+    #include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spmi_bus {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        pmk8350_vadc: adc@3100 {
+            reg = <0x3100>;
+            compatible = "qcom,spmi-adc7";
+            #address-cells = <1>;
+            #size-cells = <0>;
+            #io-channel-cells = <1>;
+
+            /* Other properties are omitted */
+            xo-therm@44 {
+                reg = <PMK8350_ADC7_AMUX_THM1_100K_PU>;
+                qcom,ratiometric;
+                qcom,hw-settle-time = <200>;
+            };
+
+            conn-therm@47 {
+                reg = <PM8350_ADC7_AMUX_THM4_100K_PU>;
+                qcom,ratiometric;
+                qcom,hw-settle-time = <200>;
+            };
+        };
+
+        pmk8350_adc_tm: adc-tm@3400 {
+            compatible = "qcom,spmi-adc-tm5-gen2";
+            reg = <0x3400>;
+            interrupts = <0x0 0x34 0x0 IRQ_TYPE_EDGE_RISING>;
+            #thermal-sensor-cells = <1>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            pmk8350-xo-therm@0 {
+                reg = <0>;
+                io-channels = <&pmk8350_vadc PMK8350_ADC7_AMUX_THM1_100K_PU>;
+                qcom,ratiometric;
+                qcom,hw-settle-time-us = <200>;
+            };
+
+            conn-therm@1 {
+                reg = <1>;
+                io-channels = <&pmk8350_vadc PM8350_ADC7_AMUX_THM4_100K_PU>;
+                qcom,ratiometric;
+                qcom,hw-settle-time-us = <200>;
+            };
+        };
+    };
 ...
-- 
2.7.4

