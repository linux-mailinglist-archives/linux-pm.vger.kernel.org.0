Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5152FB18C
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jan 2021 07:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbhASGXW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 01:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403947AbhASFuj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2021 00:50:39 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2AFC0613D6
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 21:48:56 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id u11so20524650ljo.13
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 21:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c6jITeAQsweg+hEb7KjyODoZa852s4oIvjjf4EuuYDM=;
        b=R+jLep6zm2Hfh/NUDz9yAHVvg3pBOWNSWOG6oCg3j0vIECH284uKpjA1szYLVt5YLD
         nMscayV8SOT6KMYd0M8OyVIDNrtp4o1K+HHg3Z0i0ZcxcCZz0LHeUqRmQ3E+s/60nJ+B
         mSRe9RGYPInPQSI9d4HOSGUnXLkVn36ws0n5fXljB+28XlrHvHdJgGRRzeDIFYHcMydX
         I/AQdA59FnpMRJ4iNWk6RSODfAPFYSqekYgYbFhufQtFMiexZE+Gd87suEBDJuOQd++q
         daridGB25KMUqGKGQMNsEhiZTUL1DtBt/jwII6lSCxd1bjt7ax7VC27I9dycuweHMqAK
         3rRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c6jITeAQsweg+hEb7KjyODoZa852s4oIvjjf4EuuYDM=;
        b=OZAprF+KFzDL5B4fXBF1WpVorXnv/cm6LhRzOviS8jzonTT35Lk2TpVDV+BUD9wAGJ
         zLq+PiPUNGI4W2Wzwf/RFOKJta/9h5V3OONtfgonsGvEhHq6LFNaJITAz67cE7K16fpN
         WDub8j7TaeEadRymZQZdiBFC2aIm562gSNfBZ/8+CEp/LWe/0iadrgC3E3S7v3cJ4Nfp
         2RvX8kj8Aea4gmD5X5tR1WQa1TIQL0x9TYjf/dMdkiEfO/kpMBHFRTCH1EjhESTcpsFQ
         Xtra/ju+c3+YYesvPF+kbPuRAmXl7KtNWIbaBSoE7TAOfCFWlldIfxAWEX+P7DbQzXx/
         bLEA==
X-Gm-Message-State: AOAM531DFHja3UTECt34gRKFlvT6DXnT6WuEQkLBctUPd+/19Zc2da8d
        q69oRIe2ieJSPcWnpX+AD6lB6Q==
X-Google-Smtp-Source: ABdhPJw6f6kgqF3FjzXDtpECgxdqlro1NM/wkjP7gfHv2x+xWbQdeSjAOUngNQ+2rYSWTzeFNYZ51A==
X-Received: by 2002:a2e:9f13:: with SMTP id u19mr1201181ljk.69.1611035335117;
        Mon, 18 Jan 2021 21:48:55 -0800 (PST)
Received: from eriador.lumag.spb.ru ([188.162.65.64])
        by smtp.gmail.com with ESMTPSA id j3sm2168207lfb.29.2021.01.18.21.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 21:48:54 -0800 (PST)
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
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jishnu Prakash <jprakash@qti.qualcomm.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v12 1/5] dt-bindings: thermal: qcom: add adc-thermal monitor bindings
Date:   Tue, 19 Jan 2021 08:48:44 +0300
Message-Id: <20210119054848.592329-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210119054848.592329-1-dmitry.baryshkov@linaro.org>
References: <20210119054848.592329-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add bindings for thermal monitor, part of Qualcomm PMIC5 chips. It is a
close counterpart of VADC part of those PMICs.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/thermal/qcom-spmi-adc-tm5.yaml   | 153 ++++++++++++++++++
 1 file changed, 153 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml

diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
new file mode 100644
index 000000000000..7cd364430573
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
@@ -0,0 +1,153 @@
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
+  "^([-a-z0-9]*)@[0-7]$":
+    type: object
+    description:
+      Represent one thermal sensor.
+
+    properties:
+      reg:
+        $ref: /schemas/types.yaml#/definitions/uint32
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
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: Time between AMUX getting configured and the ADC starting conversion.
+        enum: [15, 100, 200, 300, 400, 500, 600, 700, 1000, 2000, 4000, 8000, 16000, 32000, 64000, 128000]
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
+        pm8150b_adc: adc@3100 {
+            reg = <0x3100>;
+            compatible = "qcom,spmi-adc5";
+            #address-cells = <1>;
+            #size-cells = <0>;
+            #io-channel-cells = <1>;
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
+                qcom,ratiometric;
+                qcom,hw-settle-time-us = <200>;
+            };
+        };
+    };
+...
-- 
2.29.2

