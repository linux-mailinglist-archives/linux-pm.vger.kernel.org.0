Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FADE45F4CA
	for <lists+linux-pm@lfdr.de>; Fri, 26 Nov 2021 19:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242077AbhKZSoq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Nov 2021 13:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242420AbhKZSmq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Nov 2021 13:42:46 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36594C061A2D
        for <linux-pm@vger.kernel.org>; Fri, 26 Nov 2021 10:15:31 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso11291543wmr.4
        for <linux-pm@vger.kernel.org>; Fri, 26 Nov 2021 10:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g9uaiAS8rteev9sJRA3o7T/1l7AHsmYBngwMi1vxmK8=;
        b=BAkyi9ayU/v7U9tndCqtCSeCq/kK3lB6rJyKxICpSWmd6Qj2ovp4nEeu7vJmEGMvdg
         J6rN636jEuTcpdmPIbnGl6LGqcUf49IoS9w8c51hGgvrknJPkVyc3CrPnnqakUtdHzYb
         tEpchh3Jj/Xvb6YhDpjCY4tC3wl4AzQXZWfGsqLW+S/0qNpk4fdpyjTruBBd1pgsiCZZ
         wXKFU67koxoJSliUbQI8eMMuDdRizXA7kowmLz+PVGGLadQSMv8Q4Z5FFKgCNGp3UnCH
         G6WxbMDgkKqKI9UOKXSOpW4b+7WtyqR9antHPOsyT+k9XbK1s/Oeain/KcEoMsqT+OC3
         8klw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g9uaiAS8rteev9sJRA3o7T/1l7AHsmYBngwMi1vxmK8=;
        b=0Ax01dDw+t1g8c4nBmv0vmPlQdVkqyjU8mqkO2pmGln967/jKRT9NRQPxHKOBhmXgD
         LAjR+viyxdyD/rYVKkQ4xtvRZYQTvk83qT9WaJv5YUoVFeI6BOHWu+9EJ5+5zT3Max8K
         xvLeM2D3O/dct9S/hE9cQ2LANtiVg8yL47idDD+ozOjAjCXTLP1nIrcgIcaM9BDINQA9
         Mn5eN6KosJe+h+q2pldPFk9RznI7bnzsKoF0CI1PKEJnyVXStssklMmOoIGHti5J4n7B
         tSy2u6QDNRWBLxXXGDzgTjjydaEEdNzyKZbho7J9gwL5hTtepT/K76WAAWRHBn5ZLtmK
         Zg1w==
X-Gm-Message-State: AOAM5311YM1f+t0n5WG1OC5F9OvZU7Kog+hilreIiEPpXD7PiaIo+D+i
        iCw93xFuN6tFFiBwlHuHiPMKdw==
X-Google-Smtp-Source: ABdhPJx+Qt2NfkQr7hF6e2hnC9OJRio8otVHvclUZwzyUsgPV+q0kjDBmEzTswVIaBmRc8r9d0Iqtg==
X-Received: by 2002:a1c:4306:: with SMTP id q6mr17028525wma.29.1637950529466;
        Fri, 26 Nov 2021 10:15:29 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:70b:e5b5:f868:20cf])
        by smtp.gmail.com with ESMTPSA id r83sm11744735wma.22.2021.11.26.10.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 10:15:28 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     robh@kernel.org, arnd@linaro.org, heiko@sntech.de,
        ulf.hansson@linaro.org, rjw@rjwysocki.net,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, lukasz.luba@arm.com,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 1/5] dt-bindings: Powerzone new bindings
Date:   Fri, 26 Nov 2021 19:14:54 +0100
Message-Id: <20211126181500.3404129-1-daniel.lezcano@linaro.org>
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
exists with the hardware or can be represented an computed from the
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
   V1: Initial post
   V2:
     - Added pattern properties and stick to powerzone-*
     - Added required property compatible and powerzone-cells
     - Added additionnal property
     - Added compatible
     - Renamed to 'powerzones'
     - Added missing powerzone-cells to the topmost node
     - Fixed errors reported by 'make DT_CHECKER_FLAGS=-m dt_binding_check'
---
 .../devicetree/bindings/power/powerzones.yaml | 109 ++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/powerzones.yaml

diff --git a/Documentation/devicetree/bindings/power/powerzones.yaml b/Documentation/devicetree/bindings/power/powerzones.yaml
new file mode 100644
index 000000000000..6e63bbc750c6
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/powerzones.yaml
@@ -0,0 +1,109 @@
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
+  compatible:
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
+required:
+  - compatible
+
+additionalProperties: true
+
+examples:
+  - |
+    powerzones {
+
+      compatible = "powerzones";
+
+      #powerzone-cells = <0>;
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
+      #powerzone-cells = <0>;
+      powerzones = <&PKG_PZ>;
+    };
+
+    A57_1: big@1 {
+      compatible = "arm,cortex-a57";
+      reg = <0x0 0x0>;
+      device_type = "cpu";
+      #powerzone-cells = <0>;
+      powerzones = <&PKG_PZ>;
+    };
+...
-- 
2.25.1

