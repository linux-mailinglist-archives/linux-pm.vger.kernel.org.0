Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D063D79BC
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jul 2021 17:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbhG0P2N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Jul 2021 11:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237144AbhG0PZu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jul 2021 11:25:50 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D7BC0617BB
        for <linux-pm@vger.kernel.org>; Tue, 27 Jul 2021 08:25:20 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id 190so12658202qkk.12
        for <linux-pm@vger.kernel.org>; Tue, 27 Jul 2021 08:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kycIfl94BWOjfFMzSRGtEoWUIk1Jet/dpDk6BSkSujI=;
        b=GMh+pJ51nGqKocaP2RML6oUkQ6B1xnjUGeAdhaEmqVtZAaMen3q+CDPaCP3IYDK0jJ
         qjUuIB4QHo+Lm4UiaJh3RUvO691vx+eoxtSHD0gD806UemhEWfyVSdh/u0WWQ7LnvRjk
         aRZPxFVk87S8y0m/z+LmWM2QywjnzQsZCucfq+hFhdrZisdou6ItHN09H70g9NOouE7R
         doDi3tOEKieuEZb6GnyywUmvmqxFVigB9lyV1jHtk5rgCc6u/Xullx+Sswp8tyOtJNAJ
         AUJczJLotoXQl4aF769VuN7MEQKy3z3zLZdPqme5DqtOWeKnjg8fU4p6ukHcHtAOrGJ+
         qXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kycIfl94BWOjfFMzSRGtEoWUIk1Jet/dpDk6BSkSujI=;
        b=Kp2f0di8sMyx47LKHR3z6lmqDCB9Z6zmYow98J7dh/FkWpNiQMx5QtiAmzU2/sWwQ0
         bpmco2nuQ70O1do2rA3GK4aJHxv837qgb5W5s4zqNmp/xlNAN4mHOgO3+uORB4jcC/kj
         IGYR9woA6NIXbgBfuDPTPZGUNyGkV1GmpSrSnyAHNbP4zWbtJy/offDAQ4SldsYfWRxA
         E2xUJz5c+wV1jzq5ofQViA7JYd68mKcbirDKogIxD6u1fPm0Zarl/7ucveuQBOOPKtX0
         VIl1pKA90J43ZymEI1THhFlMLYFvLDheGGk8u2GR0O/TTGeTeF0It68B3NeJcxp4be0m
         MNzQ==
X-Gm-Message-State: AOAM530ZRN2lJzW+cyAIC+TDxu4SOQBMZrXExLtIZ1UGeq7fAbe+WfBv
        huJ9zSvG4wIMAwcDR6MVOEr/ig==
X-Google-Smtp-Source: ABdhPJzoeNlwxVvSYbPgsZt6m0XxvaHdTUZD6yrkTePVOk64Kact//1gGceaWVO0tSEcySSjY+pLtw==
X-Received: by 2002:a05:620a:2f5:: with SMTP id a21mr22634440qko.36.1627399519596;
        Tue, 27 Jul 2021 08:25:19 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id q4sm1539663qtr.20.2021.07.27.08.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 08:25:19 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        rjw@rjwysocki.net, robh+dt@kernel.org
Cc:     steev@kali.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [Patch v4 6/6] dt-bindings: thermal: Add dt binding for QCOM LMh
Date:   Tue, 27 Jul 2021 11:25:12 -0400
Message-Id: <20210727152512.1098329-7-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210727152512.1098329-1-thara.gopinath@linaro.org>
References: <20210727152512.1098329-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add dt binding documentation to describe Qualcomm
Limits Management Hardware node.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---

v3->v4:
	- Changed dt property qcom,lmh-cpu-id to qcom,lmh-cpu and made it
	  a phandle pointing to the cpu node instead of a number as per
	  Rob Herring's review comments.
	- Added suffix -millicelsius to all temperature properties as per
	  Rob Herring's review comments.
	- Dropped unnecessary #includes in the example as pointed out by Bjorn.
	- Other minor fixes.

 .../devicetree/bindings/thermal/qcom-lmh.yaml | 100 ++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/qcom-lmh.yaml

diff --git a/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
new file mode 100644
index 000000000000..0978f458b9ec
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2021 Linaro Ltd.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/qcom-lmh.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Limits Management Hardware(LMh)
+
+maintainers:
+  - Thara Gopinath <thara.gopinath@linaro.org>
+
+description:
+  Limits Management Hardware(LMh) is a hardware infrastructure on some
+  Qualcomm SoCs that can enforce temperature and current limits as
+  programmed by software for certain IPs like CPU.
+
+properties:
+  compatible:
+    enum:
+      - qcom,sdm845-lmh
+
+  reg:
+    items:
+      - description: core registers
+
+  interrupts:
+    maxItems: 1
+
+  '#interrupt-cells':
+    const: 1
+
+  interrupt-controller: true
+
+  qcom,lmh-cpu:
+    description:
+      phandle of the first cpu in the LMh cluster
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  qcom,lmh-temp-arm-millicelsius:
+    description:
+      An integer expressing temperature threshold at which the LMh thermal
+      FSM is engaged.
+    $ref: /schemas/types.yaml#/definitions/int32
+
+  qcom,lmh-temp-low-millicelsius:
+    description:
+      An integer expressing temperature threshold at which the state machine
+      will attempt to remove frequency throttling.
+    $ref: /schemas/types.yaml#/definitions/int32
+
+  qcom,lmh-temp-high-millicelsius:
+    description:
+      An integer expressing temperature threshold at which the state machine
+      will attempt to throttle the frequency.
+    $ref: /schemas/types.yaml#/definitions/int32
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - #interrupt-cells
+  - interrupt-controller
+  - qcom,lmh-cpu
+  - qcom,lmh-temp-arm-millicelsius
+  - qcom,lmh-temp-low-millicelsius
+  - qcom,lmh-temp-high-millicelsius
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    lmh_cluster1: lmh@17d70800 {
+      compatible = "qcom,sdm845-lmh";
+      reg = <0x17d70800 0x401>;
+      interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+      qcom,lmh-cpu = <&CPU4>;
+      qcom,lmh-temp-arm-millicelsius = <65000>;
+      qcom,lmh-temp-low-millicelsius = <94500>;
+      qcom,lmh-temp-high-millicelsius = <95000>;
+      interrupt-controller;
+      #interrupt-cells = <1>;
+    };
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    lmh_cluster0: lmh@17d78800 {
+      compatible = "qcom,sdm845-lmh";
+      reg = <0x17d78800 0x401>;
+      interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+      qcom,lmh-cpu = <&CPU0>;
+      qcom,lmh-temp-arm-millicelsius = <65000>;
+      qcom,lmh-temp-low-millicelsius = <94500>;
+      qcom,lmh-temp-high-millicelsius = <95000>;
+      interrupt-controller;
+      #interrupt-cells = <1>;
+    };
+  - |
-- 
2.25.1

