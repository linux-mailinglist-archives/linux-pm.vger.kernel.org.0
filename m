Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4715F45C741
	for <lists+linux-pm@lfdr.de>; Wed, 24 Nov 2021 15:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352462AbhKXObB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Nov 2021 09:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349513AbhKXOa4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Nov 2021 09:30:56 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204E6C127921
        for <linux-pm@vger.kernel.org>; Wed, 24 Nov 2021 04:55:17 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id b12so4058277wrh.4
        for <linux-pm@vger.kernel.org>; Wed, 24 Nov 2021 04:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bcW/auQwhx7EDgaXPPuEkhw9cJVDl6vpI/ai2tX4Qwo=;
        b=tTKzfWuTuwCkre9gsqU2sIqF551Xaz8JcKCOhq9JUBEbFEB+2G21uW/GpLRjN3DMfz
         8VupRRQJzBx30JP3IDSUxPXXbvS1/0QHGBDeoIE41I1TNdYh2di6dkl7AHagMZqzPxvb
         FUmJ1gixwftzrdtQRw58g3uG9Fsjy+Zc++7la8N962VtUWVmweugOaLmazVVW/fLxgtx
         OJLGWQ5zs6AIMw03hW2LCXqO1NpKi3XZMr4XIstq39cuBe8SsZI3u+6PVr67QuVEx3bh
         azboOnDk8Hk1yV7kWcr8COu9WGlKIFXx/JyLPo/VMr3Gw54c5cqvCPyWB0opx7U49qXT
         ov5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bcW/auQwhx7EDgaXPPuEkhw9cJVDl6vpI/ai2tX4Qwo=;
        b=6Yu44rCiSfu2i4Pprxk+0LSZhPOdNJGBWfxiDLexTWe8cgWC0eojhdb6rbJHtjlAQ1
         5IzxmRqFS9isypZlsDQK5KLf0hbMu+49CQp8G8mjf/63phG/cxIBm8ak/VqYYQFGdtRy
         WnC/VTIbWYTx3c9XUVpnkXGXRZCb5MscXmRMHrKy0jBxnfunqqWtOq4Ev2+3KuA1hpIM
         UURvvz7Mr6LYPxzZKH6II9Ec6OXQXOxVVwfZenEBsnCl/s3BzzTEsinnpzVv3Ltoaasl
         5NwqXKf1ladmAZqXZJgEyXj3Dld5y9/bbXFXLmKw+R4zKVQ7wEQW0WmJh7aDerNq1x87
         yG8w==
X-Gm-Message-State: AOAM5326j+ovYpb9i+k3b6uE0KmsvPQ8lIOpQ9jdB2dHr9VPYnAyFWJb
        Eu076lS8VrJLeTOJzxGbFj78UQ==
X-Google-Smtp-Source: ABdhPJxzkg22K5gANey5i4Q2uPB/dHz/U2rDt3Pth6C79X87w3QfsCIYi8NjqR99oF7BndbrefSacQ==
X-Received: by 2002:a5d:5303:: with SMTP id e3mr18330457wrv.73.1637758515555;
        Wed, 24 Nov 2021 04:55:15 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:3395:9073:b941:501e])
        by smtp.gmail.com with ESMTPSA id v8sm14916443wrd.84.2021.11.24.04.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 04:55:15 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     robh@kernel.org, arnd@linaro.org, heiko@sntech.de,
        ulf.hansson@linaro.org, rjw@rjwysocki.net,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, lukasz.luba@arm.com,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 1/5] dt-bindings: Powerzone new bindings
Date:   Wed, 24 Nov 2021 13:55:00 +0100
Message-Id: <20211124125506.2971069-1-daniel.lezcano@linaro.org>
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
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 .../devicetree/bindings/power/powerzones.yaml | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/powerzones.yaml

diff --git a/Documentation/devicetree/bindings/power/powerzones.yaml b/Documentation/devicetree/bindings/power/powerzones.yaml
new file mode 100644
index 000000000000..1ae3f82ae29c
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/powerzones.yaml
@@ -0,0 +1,95 @@
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
+  "#powerzone-cells":
+    description:
+      Number of cells in powerzone specifier. Typically 0 for nodes
+      representing but it can be any number in the future to describe
+      parameters of the powerzone.
+
+  powerzone:
+    description:
+      A phandle to a parent powerzone. If no powerzone attribute is set, the
+      described powerzone is the topmost in the hierarchy.
+
+examples:
+  - |
+    powerzones {
+
+      SOC_PZ: soc {
+      };
+
+      PKG_PZ: pkg {
+        #powerzone-cells = <0>;
+        powerzone = <&SOC_PZ>;
+      };
+
+      BIG_PZ: big {
+        #powerzone-cells = <0>;
+        powerzone = <&PKG_PZ>;
+      };
+
+      GPU_PZ: gpu {
+        #powerzone-cells = <0>;
+        powerzone = <&PKG_PZ>;
+      };
+
+      MULTIMEDIA_PZ: multimedia {
+        #powerzone-cells = <0>;
+        powerzone = <&SOC_PZ>;
+      };
+    };
+
+  - |
+    A57_0: big@0 {
+      compatible = "arm,cortex-a57";
+      reg = <0x0 0x0>;
+      device_type = "cpu";
+      #powerzone-cells = <0>;
+      powerzone = <&BIG_PZ>;
+    };
+
+    A57_1: big@1 {
+      compatible = "arm,cortex-a57";
+      reg = <0x0 0x0>;
+      device_type = "cpu";
+      #powerzone-cells = <0>;
+      powerzone = <&BIG_PZ>;
+    };
+...
-- 
2.25.1

