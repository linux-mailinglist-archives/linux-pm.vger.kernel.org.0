Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E859C2652FC
	for <lists+linux-pm@lfdr.de>; Thu, 10 Sep 2020 23:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgIJV1B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Sep 2020 17:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731054AbgIJOK1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2020 10:10:27 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B85C0617B9
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2020 07:00:15 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id y2so3631559lfy.10
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2020 07:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0I6pQWwOhUWc2K65OlZG19X3KN2sWbUfhTEkKlMLufk=;
        b=xGTfHy55igiiYK6bgyw405lH2EtFNFnJvlAcrXT54GNglJh7Bis2x8BKPsrJjQBFWD
         BFKd6CogmmwW5E/AMPL6G/vQNXNKyMv8MI+RqUlYvL/WYvnetd119tZCxTSqsXzxvBdA
         khyOlWSRZgdmBaWgGwEqrfsbJqygyju+9Q9X7lNGRvlbE3Icjn1j/iGUcp3tmGtrtPHs
         bzXsuHxFeHULvWaSR0d2Tnns0O2KYkw/ss/FiHR/xpdSNU/qBgvGMxo76dnIhk7B5Twl
         ohVt6KfNJNOdBxJ2KUEEcYWNjn5C0guN4QsqMzZ245bEvihqCZATAnf7/EWh6MDuXjzp
         PgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0I6pQWwOhUWc2K65OlZG19X3KN2sWbUfhTEkKlMLufk=;
        b=ikZXbmh+CEUC46+qd946u1ZAFZgupO654494vZ7OHZi5RDyIhH2gopyVRptEIdWoQR
         s8An7nB0qIIzL8FuPl3yxL9R6ksV2+lluZ9E3Qg7rJsFhGBy625z3C4Wx0IMST/T9oqL
         rWfJQdDwrWzRTqTQ2bfsjwXeO+OASkHa/TDiAysrXLldhybQyUmIFBWOqiuAh6+lyaHi
         CL6VPWw+ZgfP2/TXeOOgB+SdMBvzp+Bw/G6AJsGA67SMrYfscFfgvYonH3P6JYU9TkCe
         x4+osgmyiwpoJAjRdbi9XBN3MCe4TLeGs/WzWdGJdn2Tyshi9HF7LLJGYzUGAWdOqT6d
         LMVQ==
X-Gm-Message-State: AOAM533CxAois7USbAB+rwQshd4NsDo0n/ZryRS/mXujdSquQsiiRcYr
        3utLuveqFl4vHL1wpa27psNCLA==
X-Google-Smtp-Source: ABdhPJwuDTJMvIDU4B2g8FCgzdZ8i5NqWgAut6BhFEjNEwHrwdFafdlvccqiBqkf0uVJ7pMrC2paVA==
X-Received: by 2002:a19:dc19:: with SMTP id t25mr4235141lfg.114.1599746413666;
        Thu, 10 Sep 2020 07:00:13 -0700 (PDT)
Received: from eriador.lan ([188.162.64.156])
        by smtp.gmail.com with ESMTPSA id t82sm1367646lff.43.2020.09.10.07.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 07:00:13 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 02/10] dt-bindings: thermal: qcom: add adc-thermal monitor bindings
Date:   Thu, 10 Sep 2020 16:59:52 +0300
Message-Id: <20200910140000.324091-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910140000.324091-1-dmitry.baryshkov@linaro.org>
References: <20200910140000.324091-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add bindings for thermal monitor, part of Qualcomm PMIC5 chips. It is a
close counterpart of VADC part of those PMICs.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../bindings/thermal/qcom-spmi-adc-tm5.yaml   | 151 ++++++++++++++++++
 1 file changed, 151 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml

diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
new file mode 100644
index 000000000000..432a65839b89
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
@@ -0,0 +1,151 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/qcom-spmi-adc-tm5.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm's SPMI PMIC ADC Thermal Monitoring
+maintainers:
+  - Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
+
+properties:
+  compatible:
+    const: qcom,spmi-adc-tm5
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
+      - 250
+      - 420
+      - 840
+    default: 840
+
+patternProperties:
+  "^([-a-z0-9]*)@[0-9]+$":
+    type: object
+    description:
+      Represent one thermal sensor.
+
+    properties:
+      reg:
+        description: Specify the sensor channel.
+        maxItems: 1
+
+      io-channels:
+        description:
+          From common IIO binding. Used to pipe PMIC ADC channel to thermal monitor
+
+      qcom,adc-channel:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: Corresponding ADC channel ID.
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
+      qcom,hw-settle-time:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: Time between AMUX getting configured and the ADC starting conversion.
+
+      qcom,pre-scaling:
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        description: Used for scaling the channel input signal before the
+          signal is fed to VADC. See qcom,spi-vadc specification for the list
+          of possible values.
+        minItems: 2
+        maxItems: 2
+
+    required:
+      - reg
+      - qcom,adc-channel
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
+        pm8150b_adc: adc@3100 {
+            reg = <0x3100>;
+            compatible = "qcom,spmi-adc5";
+            #address-cells = <1>;
+            #size-cells = <0>;
+            #io-channel-cells = <1>;
+            io-channel-ranges;
+
+            /* Other propreties are omitted */
+            conn-therm@4f {
+                reg = <ADC5_AMUX_THM3_100K_PU>;
+                qcom,ratiometric;
+                qcom,hw-settle-time = <200>;
+            };
+        };
+
+        pm8150b_adc_tm: adc-tm@3500 {
+            compatible = "qcom,spmi-adc-tm5";
+            reg = <0x3500>;
+            interrupts = <0x2 0x35 0x0 IRQ_TYPE_EDGE_RISING>;
+            #thermal-sensor-cells = <1>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            conn-therm@0 {
+                reg = <0>;
+                io-channels = <&pm8150b_adc ADC5_AMUX_THM3_100K_PU>;
+                qcom,adc-channel = <ADC5_AMUX_THM3_100K_PU>;
+                qcom,ratiometric;
+                qcom,hw-settle-time = <200>;
+            };
+        };
+    };
+...
-- 
2.28.0

