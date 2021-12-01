Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48DF46530A
	for <lists+linux-pm@lfdr.de>; Wed,  1 Dec 2021 17:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351235AbhLAQpW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Dec 2021 11:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243690AbhLAQpW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Dec 2021 11:45:22 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E35FC06174A
        for <linux-pm@vger.kernel.org>; Wed,  1 Dec 2021 08:42:01 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id q3so30791444wru.5
        for <linux-pm@vger.kernel.org>; Wed, 01 Dec 2021 08:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3BE63UjIea96EvWdRiabOg7XkHyFmGcLZ5+e2gzNYLQ=;
        b=zB3jquT5qUdpkKO6qjWfpveRmENlToJ9TwSRZzPzuMDt+XI/McIR4vcRceMtBD6h4p
         tJnimoJvFAwQOtQB42/b50V+W/LJx4yXWwZQ+x8K+TzcFBA2zlAT//GESDnAdfitfQbd
         A3d+07cO8EX7JlaVGpo0ZpsNzJd8iOmS5a96sMprvxf4QllQ1vBCsddEKlt80vx8v1Eu
         O2eF/RjQwmiEV2Wp4D0yDjtYtfBeicdpf7U+CzYaGE0wrUokjtYsOBK1KK0Z8cEpJ5qK
         07SYQ+PqwHoe6cZ9OYsli0VcXmrcJ7J5ZL5BOfal2n+BpYWja//bnHJt7cG2SkpdWIAW
         LxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3BE63UjIea96EvWdRiabOg7XkHyFmGcLZ5+e2gzNYLQ=;
        b=LBXN+Yxf8HrOcTeG2MdiNG6trif0xmVht89qzInd06D/ehtDiUs+u1HZVLFkGNIvo9
         e5n0GTOyLckasbMf3Q/0UDmvPrv0RhcwWRJ71qtMBexRypkXxiZg/Rm6tPsS9oY16p2J
         utVenPpd2CpyzCi12EHT+i9NNWGILJaBxN+I26AbE9VGuxJ1xsD/DOuCaE2m9rx9Kxe1
         lvW95nFYAPh5OtU+8RsVe7uU66G3OEdz9w7zmdaG9AoxHmIBRSl6aoR7/CwntckDTdgb
         /FkaVUpO2geSQI8NqdeR4vOkwLgxZLE3WrgMgp8NUu9Q7raLub8L6ilvngR2Dkjy3vCv
         NsEg==
X-Gm-Message-State: AOAM533U/STMvJWC9tEScwvYLTWg5onIdsPCnVTZmxM+A5NAD0qRe/1f
        hZiwzShw+ocTSzVBbajhh0agXw==
X-Google-Smtp-Source: ABdhPJyji0CmyijyOZLAdo2xKamQ3JhV7HZ1zTsvkoYMmG5KkLCwm1Y3vZ8cbtL+LN/Zh7EYKgX0ow==
X-Received: by 2002:adf:cd89:: with SMTP id q9mr7948147wrj.205.1638376919412;
        Wed, 01 Dec 2021 08:41:59 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:72d0:52a1:d4ea:f564])
        by smtp.gmail.com with ESMTPSA id v8sm255547wrd.84.2021.12.01.08.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 08:41:58 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, robh@kernel.org
Cc:     arnd@linaro.org, heiko@sntech.de, ulf.hansson@linaro.org,
        rjw@rjwysocki.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 1/5] dt-bindings: Powerzone new bindings
Date:   Wed,  1 Dec 2021 17:38:50 +0100
Message-Id: <20211201163856.41419-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The proposed bindings are describing a set of powerzones.

A power zone is the logical name for a component which is capable of
power capping and where we can measure the power consumption.

A power zone can aggregate several power zones in terms of power
measurement and power limitations. That allows to apply power
constraint to a group of components and let the system balance the
allocated power in order to comply with the constraint.

The ARM System Control and Management Interface (SCMI) can provide a
power zone description.

The powerzone semantic is also found on the Intel platform with the
RAPL register.

The Linux kernel powercap framework deals with the powerzones:

https://www.kernel.org/doc/html/latest/power/powercap/powercap.html

The powerzone can also represent a group of children powerzones, hence
the description can result on a hierarchy. Such hierarchy already
exists with the hardware or can be represented and computed from the
kernel.

The hierarchical description was initially proposed but not desired
given there are other descriptions like the power domain proposing
almost the same description.

https://lore.kernel.org/all/CAL_JsqLuLcHj7525tTUmh7pLqe7T2j6UcznyhV7joS8ipyb_VQ@mail.gmail.com/

The description gives the power constraint dependencies to apply on a
specific group of logically or physically aggregated devices. They do
not represent the physical location or the power domains of the SoC
even if the description could be similar.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
   V3:
     - Removed required property 'compatible'
     - Removed powerzone-cells from the topmost node
     - Removed powerzone-cells from cpus 'consumers' in example
     - Set additionnal property to false
   V2:
     - Added pattern properties and stick to powerzone-*
     - Added required property compatible and powerzone-cells
     - Added additionnal property
     - Added compatible
     - Renamed to 'powerzones'
     - Added missing powerzone-cells to the topmost node
     - Fixed errors reported by 'make DT_CHECKER_FLAGS=-m dt_binding_check'
   V1: Initial post
---
 .../devicetree/bindings/power/powerzones.yaml | 97 +++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/powerzones.yaml

diff --git a/Documentation/devicetree/bindings/power/powerzones.yaml b/Documentation/devicetree/bindings/power/powerzones.yaml
new file mode 100644
index 000000000000..ddb790acfea6
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/powerzones.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/powerzones.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Power zones description
+
+maintainers:
+  - Daniel Lezcano <daniel.lezcano@linaro.org>
+
+description: |+
+
+  A System on Chip contains a multitude of active components and each
+  of them is a source of heat. Even if a temperature sensor is not
+  present, a source of heat can be controlled by acting on the
+  consumed power via different techniques.
+
+  A powerzone describes a component or a group of components where we
+  can control the maximum power consumption. For instance, a group of
+  CPUs via the performance domain, a LCD screen via the brightness,
+  etc ...
+
+  Different components when they are used together can significantly
+  increase the overall temperature, so the description needs to
+  reflect this dependency in order to assign a power budget for a
+  group of powerzones.
+
+  This description is done via a hierarchy and the DT reflects it. It
+  does not represent the physical location or a topology, eg. on a
+  big.Little system, the little CPUs may not be represented as they do
+  not contribute significantly to the heat, however the GPU can be
+  tied with the big CPUs as they usually have a connection for
+  multimedia or game workloads.
+    
+properties:
+  $nodename:
+    const: powerzones
+
+patternProperties:
+  "^(powerzone)([@-].*)?$":
+    type: object
+    description:
+      A node representing a powerzone acting as an aggregator for all
+      its children powerzones.
+
+    properties:
+      "#powerzone-cells":
+        description:
+          Number of cells in powerzone specifier. Typically 0 for nodes
+          representing but it can be any number in the future to
+          describe parameters of the powerzone.
+
+      powerzones:
+        description:
+          A phandle to a parent powerzone. If no powerzone attribute is
+          set, the described powerzone is the topmost in the hierarchy.
+
+    required:
+      - "#powerzone-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    powerzones {
+
+      SOC_PZ: powerzone-soc {
+        #powerzone-cells = <0>;
+      };
+
+      PKG_PZ: powerzone-pkg {
+        #powerzone-cells = <0>;
+        powerzones = <&SOC_PZ>;
+      };
+
+      GPU_PZ: powerzone-gpu {
+        #powerzone-cells = <0>;
+        powerzones = <&PKG_PZ>;
+      };
+    };
+
+  - |
+    A57_0: big@0 {
+      compatible = "arm,cortex-a57";
+      reg = <0x0 0x0>;
+      device_type = "cpu";
+      powerzones = <&PKG_PZ>;
+    };
+
+    A57_1: big@1 {
+      compatible = "arm,cortex-a57";
+      reg = <0x0 0x0>;
+      device_type = "cpu";
+      powerzones = <&PKG_PZ>;
+    };
+...
-- 
2.25.1

