Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEF641675B
	for <lists+linux-pm@lfdr.de>; Thu, 23 Sep 2021 23:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243284AbhIWVYJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Sep 2021 17:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243285AbhIWVYH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Sep 2021 17:24:07 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D13C06175F
        for <linux-pm@vger.kernel.org>; Thu, 23 Sep 2021 14:22:35 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id x33-20020a9d37a4000000b0054733a85462so10409417otb.10
        for <linux-pm@vger.kernel.org>; Thu, 23 Sep 2021 14:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/6A+BjV+mykuVUC2yZOjUlN9HFvZIQm7jxw8ugHVF80=;
        b=GPFY1cYmYxtrUASTD65etNm37G3Fs+JeI6mThv6HeJzMWej+nZf38O8qUOkSwp5qK9
         j4kK946oroUr41yDvutgKu5KOoaeGdWooMroREWBxZfmChIjPWGJGMM2o5BZoT6WcD1k
         Dk8SeAhvk9of4qtKK5D1JCVWtdyBVnl0lLxhDu3HMrkMzE0TUXdoinjN6XS8Vnk8xlcr
         S025gAoExERTCW1cn36Qmj7+nDNk477VXSIVgohzYWLeoab165o+cdqQxvoQKFLtPlNW
         JDlskz28ul6mF2Kfpsggg3QyYbHlURkPoIp0XVzWmUYrBxswWkj0/FXw4eij9PEkaRQe
         WzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/6A+BjV+mykuVUC2yZOjUlN9HFvZIQm7jxw8ugHVF80=;
        b=kGmeK27L/F42P4N2GjsRAg5QiaZ1h7/iK80pq0Ok6M+yXkKqWqixIZVZGomZ7wwNY9
         KN9jhM4DhMz5omcvxBDaUANcnxzJNUygw+CItZ5lrF4vzynuLmyJLWYp3qHFVQaSATkk
         iGWrEtwV5Ng1nlOY5hu8PJZbJbud0OA55TcnTRzFTy8ApVk9LFshrJY7vcTm/LprWUWd
         fcClVgjLhiTdy2Nd1InlSkfYoP28AtjeTgtg5XcfQbhJLKZQN2FOb+Ttvu8f6ktv3+N6
         27UdA2d0x8z2ZADXbbCDue0T4CR+TfaL/D+f2DEW7ls2XoB2dEQW349puTBRJQsMbRiJ
         p/xg==
X-Gm-Message-State: AOAM533jPU1v+Xv5WRXeYrQwrbe+wva8EnviOLByCF9fCtyDYq6Pe8H/
        aI6MuZAFhsKS2ZWO5rqY41J+nQ==
X-Google-Smtp-Source: ABdhPJyhTHQiL6oW8tDRS1T5zZVHYa68bMqwl1ItV6ymG1zLfwXEwsgEaIy6rnyYQ5HQyEUtNd8QtA==
X-Received: by 2002:a9d:6295:: with SMTP id x21mr808134otk.88.1632432155001;
        Thu, 23 Sep 2021 14:22:35 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id e16sm1586820oie.17.2021.09.23.14.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 14:22:34 -0700 (PDT)
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
Subject: [PATCH v2 1/4] dt-bindings: thermal: qcom: add HC variant of adc-thermal monitor bindings
Date:   Thu, 23 Sep 2021 14:23:08 -0700
Message-Id: <20210923212311.2877048-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210923212311.2877048-1-bjorn.andersson@linaro.org>
References: <20210923212311.2877048-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The HC generation of the ADC Thermal Monitor is quite similar to the 5th
generation, but differs in valid values for a few properties. Create a
new binding for the HC version of the harware, rather than sprinkle
conditionals throughout the existing binding.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

I tried to represent the enum differences from adc5 using conditionals, but the
binding became a complete mess. So hopefully this is acceptable instead.

Changes since v1:
- New patch

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

