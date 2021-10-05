Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72DDB421CE0
	for <lists+linux-pm@lfdr.de>; Tue,  5 Oct 2021 05:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbhJEDZl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Oct 2021 23:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbhJEDZk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Oct 2021 23:25:40 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA41FC061745
        for <linux-pm@vger.kernel.org>; Mon,  4 Oct 2021 20:23:50 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 5-20020a9d0685000000b0054706d7b8e5so24239687otx.3
        for <linux-pm@vger.kernel.org>; Mon, 04 Oct 2021 20:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5F9P+rsu48FUbDV9TizntpJNt5FGTMagwmpzztCYYIw=;
        b=Vgnf2JNJ6OouXm7x/ldZOtSiEBU9yaIGBuePc25n9LYJz7oTjHqtLMbpOy+DiE8yIC
         +bCLgob2aVTyOTtF+ltOjjwjX0Nro3SOfDRrylKn17hldGv6KKiQIqacFJumID5GcZEN
         cjoX0u1fz/8xwfXhSSISiSmb/8YZIO2o9zcqU6QwgEPzSfnnMK6kalPihkksXoEyBdjq
         0U+GG1xvEb89Q9uSNygFIdMIRKA8BX48trA5bdmoeXsOD8D+jHKmJ3z5gxQlLN4dgP+L
         bRmtdhiTa0mCO6vvbhL6mU4f53vxCvA6973/kQYNdgKqNQ7Dz5heVCyNOKtZYESt41Xn
         XCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5F9P+rsu48FUbDV9TizntpJNt5FGTMagwmpzztCYYIw=;
        b=5UXUyYq/y3y7CqhI71fUmFEDRrGu76fa8AsBaPseeNovWOjZaXBTWRIsG9bkf0CtIa
         emjfHAM34TDeiMErsgrjuJh03+QLzxu6XSBuzMnzFwuHv14Q2Jt2YN5Mz5TVjb4i43M5
         gVx48294RAKx65jLDcXcmkdzs1Ogbw5OA4rVQPpcTs5TKnR0dgkAs48GHHzddYCThPSW
         peUujwhKReRt13KL4YKygzBBHeQD5BmPDeRQiJoKWw5BPf1e11cYuv5tVgUDJ2j4kPHi
         29PDxL8vAx90s1PHdb3OMpYDyjVHfll1AdgCRq3aFMQFkPhfDJnkUbN4O2UsAl8v2AnK
         K0Bg==
X-Gm-Message-State: AOAM533cPaTzBDwOx5/fOEmfOVHUexGuqFsmzz0Clzw47vTp9nnG/VGI
        q5cuqaLBQZJhhRR0Ns3UPZAUjw==
X-Google-Smtp-Source: ABdhPJwlAARTmLd3RxM8TmQEU67BvdMOr6403mm2vbc3R957cl9jAHBfr0HIn7uK4/BRRaB/LZkTEA==
X-Received: by 2002:a05:6830:22d6:: with SMTP id q22mr11873976otc.344.1633404230029;
        Mon, 04 Oct 2021 20:23:50 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id j4sm3111955oia.56.2021.10.04.20.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 20:23:49 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] dt-bindings: thermal: qcom: add HC variant of adc-thermal monitor bindings
Date:   Mon,  4 Oct 2021 20:25:28 -0700
Message-Id: <20211005032531.2251928-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211005032531.2251928-1-bjorn.andersson@linaro.org>
References: <20211005032531.2251928-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The HC generation of the ADC Thermal Monitor is quite similar to the 5th
generation, but differs in valid values for a few properties. Create a
new binding for the HC version of the hardware, rather than sprinkle
conditionals throughout the existing binding.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- None

 .../bindings/thermal/qcom-spmi-adc-tm-hc.yaml | 149 ++++++++++++++++++
 1 file changed, 149 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml

diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml
new file mode 100644
index 000000000000..8273ac55b63f
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml
@@ -0,0 +1,149 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/qcom-spmi-adc-tm-hc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm's SPMI PMIC ADC HC Thermal Monitoring
+maintainers:
+  - Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
+
+properties:
+  compatible:
+    const: qcom,spmi-adc-tm-hc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  "#thermal-sensor-cells":
+    const: 1
+    description:
+      Number of cells required to uniquely identify the thermal sensors. Since
+      we have multiple sensors this is set to 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  qcom,avg-samples:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Number of samples to be used for measurement.
+    enum:
+      - 1
+      - 2
+      - 4
+      - 8
+      - 16
+    default: 1
+
+  qcom,decimation:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: This parameter is used to decrease ADC sampling rate.
+            Quicker measurements can be made by reducing decimation ratio.
+    enum:
+      - 256
+      - 512
+      - 1024
+    default: 1024
+
+patternProperties:
+  "^([-a-z0-9]*)@[0-7]$":
+    type: object
+    description:
+      Represent one thermal sensor.
+
+    properties:
+      reg:
+        description: Specify the sensor channel. There are 8 channels in PMIC5's ADC TM
+        minimum: 0
+        maximum: 7
+
+      io-channels:
+        description:
+          From common IIO binding. Used to pipe PMIC ADC channel to thermal monitor
+
+      qcom,ratiometric:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          Channel calibration type.
+          If this property is specified VADC will use the VDD reference
+          (1.875V) and GND for channel calibration. If property is not found,
+          channel will be calibrated with 0V and 1.25V reference channels,
+          also known as absolute calibration.
+
+      qcom,hw-settle-time-us:
+        description: Time between AMUX getting configured and the ADC starting conversion.
+        enum: [0, 100, 200, 300, 400, 500, 600, 700, 1000, 2000, 4000, 6000, 8000, 10000]
+
+      qcom,pre-scaling:
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        description: Used for scaling the channel input signal before the
+          signal is fed to VADC. The configuration for this node is to know the
+          pre-determined ratio and use it for post scaling. It is a pair of
+          integers, denoting the numerator and denominator of the fraction by
+          which input signal is multiplied. For example, <1 3> indicates the
+          signal is scaled down to 1/3 of its value before ADC measurement.  If
+          property is not found default value depending on chip will be used.
+        items:
+          - const: 1
+          - enum: [ 1, 3, 4, 6, 20, 8, 10 ]
+
+    required:
+      - reg
+      - io-channels
+
+    additionalProperties:
+      false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - "#address-cells"
+  - "#size-cells"
+  - "#thermal-sensor-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/iio/qcom,spmi-vadc.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spmi_bus {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        pm8998_adc: adc@3100 {
+            reg = <0x3100>;
+            compatible = "qcom,spmi-adc-rev2";
+            #address-cells = <1>;
+            #size-cells = <0>;
+            #io-channel-cells = <1>;
+
+            /* Other propreties are omitted */
+            adc-chan@4c {
+                reg = <ADC5_XO_THERM_100K_PU>;
+            };
+        };
+
+        pm8998_adc_tm: adc-tm@3400 {
+            compatible = "qcom,spmi-adc-tm-hc";
+            reg = <0x3400>;
+            interrupts = <0x2 0x34 0x0 IRQ_TYPE_EDGE_RISING>;
+            #thermal-sensor-cells = <1>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            thermistor@1 {
+                reg = <1>;
+                io-channels = <&pm8998_adc ADC5_XO_THERM_100K_PU>;
+                qcom,ratiometric;
+                qcom,hw-settle-time-us = <200>;
+            };
+        };
+    };
+...
-- 
2.29.2

