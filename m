Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625A327B5D1
	for <lists+linux-pm@lfdr.de>; Mon, 28 Sep 2020 21:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgI1T7H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Sep 2020 15:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbgI1T7C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Sep 2020 15:59:02 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DF6C0613CE;
        Mon, 28 Sep 2020 12:59:02 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id o5so2629566wrn.13;
        Mon, 28 Sep 2020 12:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NbGMC82aTOHw69bBF16p394ydgQFm7eLIkNq9Ff7svQ=;
        b=d4VeKgmfatPXqcyO6XPFl5Qo4rREUj/LJRcodj8RyAlelnhAxznsv+FWqw+1k7A5n3
         ckWZw5D/CaKHYaYYLlriu9Y58GAXx11Z1JYxXeLsuG0qUrZvpR2IkAAzloJKwrt3hVeg
         pMSthIDsge5xxWpbOgph0VeF7Qh4/nWSuHcd0bs6TZ5JuSs5yRQFJS5CmKiVofEpJak8
         r0nFf/wqNDw5FA4e01A6sRJsR9Ar1/0zJKjR7hqnZhJDtNyhjh64aI9p9+Cwr3ab/e7A
         n8RaCg4sRQYzaWImE6SEqd86MRC2yrhjpqI8x/jn1K2rfvGs3VxLrl0VdISvS8fr+amn
         i4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NbGMC82aTOHw69bBF16p394ydgQFm7eLIkNq9Ff7svQ=;
        b=Edgk/jQCd1UA8oijD3m4HjOSBpmwIgAWN+0G/a4MUzRdz1fOfmMRwTdX9Qm9pTbQEE
         J/FGFQqpblsqfpp2QS4LCzl3Qxrv2gK41avNhk3x9T8R3Yn0Hh/3jSAT1A+Ponzze4aS
         qvJK5n5c4ZU4szHzO00Ky0NQN6hAXpx9tFOCy65lfWzi1b7BIeagytajvsTg9DadTdiQ
         AwDPsU4Y4busl8HzjnYomQTbas8KVBD+/um2coKSvuxogQbMz+cjpIcE/TmlYhoJAYH4
         O2rMmAhHAkxRxRXtLy2uJVArDC5IlFwmGAFh4rSf9SiH8F1wFgKlaiMtFNyDK5cd2U1j
         W4yg==
X-Gm-Message-State: AOAM531YxutBRLXxDJyWuFHvL+vSPxrNQV4P5jlfqSxNXtHk3ByJS2D6
        Y8J+aaMmWiWbmZgOsSg/cww=
X-Google-Smtp-Source: ABdhPJya85/3p5+S9n9FcBpz3/kV9Q2zQVoxdyp9XDV/ritX+EuRAaJsknb/YBtOLMbrZLlxDw3zuQ==
X-Received: by 2002:a5d:518b:: with SMTP id k11mr102696wrv.369.1601323140707;
        Mon, 28 Sep 2020 12:59:00 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu ([2.237.20.237])
        by smtp.gmail.com with ESMTPSA id q4sm2607434wru.65.2020.09.28.12.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 12:59:00 -0700 (PDT)
From:   kholk11@gmail.com
To:     bjorn.andersson@linaro.org
Cc:     robh+dt@kernel.org, agross@kernel.org, georgi.djakov@linaro.org,
        kholk11@gmail.com, marijns95@gmail.com, konradybcio@gmail.com,
        martin.botka1@gmail.com, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] dt-bindings: interconnect: Add bindings for Qualcomm SDM660 NoC
Date:   Mon, 28 Sep 2020 21:58:53 +0200
Message-Id: <20200928195853.40084-3-kholk11@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928195853.40084-1-kholk11@gmail.com>
References: <20200928195853.40084-1-kholk11@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: AngeloGioacchino Del Regno <kholk11@gmail.com>

Add the bindings for the Qualcomm SDM660-class NoC, valid for
SDM630, SDM636, SDM660 and SDA variants.

Signed-off-by: AngeloGioacchino Del Regno <kholk11@gmail.com>
---
 .../bindings/interconnect/qcom,sdm660.yaml    | 147 ++++++++++++++++++
 1 file changed, 147 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml
new file mode 100644
index 000000000000..440e9bc1382a
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml
@@ -0,0 +1,147 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,sdm660.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SDM660 Network-On-Chip interconnect
+
+maintainers:
+  - Georgi Djakov <georgi.djakov@linaro.org>
+
+description: |
+  The Qualcomm SDM660 interconnect providers support adjusting the
+  bandwidth requirements between the various NoC fabrics.
+
+properties:
+  reg:
+    maxItems: 1
+
+  compatible:
+    enum:
+      - qcom,sdm660-a2noc
+      - qcom,sdm660-bimc
+      - qcom,sdm660-cnoc
+      - qcom,sdm660-gnoc
+      - qcom,sdm660-mnoc
+      - qcom,sdm660-snoc
+
+  '#interconnect-cells':
+    const: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 3
+
+  clock-names:
+    minItems: 1
+    maxItems: 3
+
+required:
+  - compatible
+  - reg
+  - '#interconnect-cells'
+  - clock-names
+  - clocks
+
+additionalProperties: false
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sdm660-mnoc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Bus Clock.
+            - description: Bus A Clock.
+            - description: CPU-NoC High-performance Bus Clock.
+        clock-names:
+          items:
+            - const: bus
+            - const: bus_a
+            - const: iface
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sdm660-a2noc
+              - qcom,sdm660-bimc
+              - qcom,sdm660-cnoc
+              - qcom,sdm660-gnoc
+              - qcom,sdm660-snoc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Bus Clock.
+            - description: Bus A Clock.
+        clock-names:
+          items:
+            - const: bus
+            - const: bus_a
+
+examples:
+  - |
+      #include <dt-bindings/clock/qcom,rpmcc.h>
+      #include <dt-bindings/clock/qcom,mmcc-sdm660.h>
+
+      bimc: interconnect@1008000 {
+              compatible = "qcom,sdm660-bimc";
+              reg = <0x01008000 0x78000>;
+              #interconnect-cells = <1>;
+              clock-names = "bus", "bus_a";
+              clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
+                       <&rpmcc RPM_SMD_BIMC_A_CLK>;
+      };
+
+      cnoc: interconnect@1500000 {
+              compatible = "qcom,sdm660-cnoc";
+              reg = <0x01500000 0x10000>;
+              #interconnect-cells = <1>;
+              clock-names = "bus", "bus_a";
+              clocks = <&rpmcc RPM_SMD_CNOC_CLK>,
+                       <&rpmcc RPM_SMD_CNOC_A_CLK>;
+      };
+
+      snoc: interconnect@1626000 {
+              compatible = "qcom,sdm660-snoc";
+              reg = <0x01626000 0x7090>;
+              #interconnect-cells = <1>;
+              clock-names = "bus", "bus_a";
+              clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
+                       <&rpmcc RPM_SMD_SNOC_A_CLK>;
+      };
+
+      a2noc: interconnect@1704000 {
+              compatible = "qcom,sdm660-a2noc";
+              reg = <0x01704000 0xc100>;
+              #interconnect-cells = <1>;
+              clock-names = "bus", "bus_a";
+              clocks = <&rpmcc RPM_SMD_AGGR2_NOC_CLK>,
+                       <&rpmcc RPM_SMD_AGGR2_NOC_A_CLK>;
+      };
+
+      mnoc: interconnect@1745000 {
+              compatible = "qcom,sdm660-mnoc";
+              reg = <0x01745000 0xa010>;
+              #interconnect-cells = <1>;
+              clock-names = "bus", "bus_a", "iface";
+              clocks = <&rpmcc RPM_SMD_MMSSNOC_AXI_CLK>,
+                       <&rpmcc RPM_SMD_MMSSNOC_AXI_CLK_A>,
+                       <&mmcc AHB_CLK_SRC>;
+      };
+
+      gnoc: interconnect@17900000 {
+              compatible = "qcom,sdm660-gnoc";
+              reg = <0x17900000 0xe000>;
+              #interconnect-cells = <1>;
+              clock-names = "bus", "bus_a";
+              clocks = <&xo_board>, <&xo_board>;
+      };
-- 
2.28.0

