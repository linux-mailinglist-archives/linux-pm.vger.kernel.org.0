Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481C63AA3C8
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 21:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbhFPTHj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 15:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbhFPTHi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jun 2021 15:07:38 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4382C06175F;
        Wed, 16 Jun 2021 12:05:30 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id f30so6066618lfj.1;
        Wed, 16 Jun 2021 12:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tqgXrdSZnikIQPHeqsJQcSBthMCH/Kxw6gO0NwTKMCg=;
        b=hn4OSUd+RLUEwVokRWXvaG3Y2rjWpvJBHHX2R1kGERFSASYp3miTK3MNqpcgasmShm
         +M+o8dtf0I0Kb+6oaZxc6Ukt6cTzTbacBK6bpunp9kVQfDDskWdLRTVmMqo2Ln5Tln9w
         wI/mSaXM1zIMhu1f6UTeC2qYFWCYlA6MXW3Lc7vhz2i1fLW7qOFX7IvovSpoV9P+0zLB
         ZSJUVlCAkH95fhjFNxIMDfzVkdNBYurRbRzyiXqZRJNJNSp81K3HUyarpz9G3Pfeq50V
         hIJDYVHqtJ97iWclqKeWLFx6XI2vAF1FDBz5nVDacN/cvFSonz8hvqMw8s3YFiigDy0a
         +IUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tqgXrdSZnikIQPHeqsJQcSBthMCH/Kxw6gO0NwTKMCg=;
        b=CURftEy5c5FVu8hUgRBtHMvYr9rmQ9G/03oaZL9SX6a8+/I8Y6drTExsSHI0RPCScT
         Umr7qeLla9hF1Krx+nhJ3SjLb+R2BSzIdntr8ZnCvFgcVA/ZdFfYfgIuudSZEJGVkal2
         lRcNOGuM39mRJOw7g8geA8a7zC5jKRbz9tosSRasvUUnSQVsZnC+cm0gBIQ6bQ4Qbste
         4rAOfz4q6edmolBkf+NJEjOhJ2LRQOBC2SAUHzogznn8BZghckkAM5pp1IypnkEBKRju
         i45CINCb0PDa1LVYX9UJV+gD3GZgLOG5nmJgfPB5XtFCdQWsDWbEyStA35r8Z9AYDtKt
         CU/Q==
X-Gm-Message-State: AOAM5322QrQFlT8sIvpC7eNlgPA1pLekG6WDvgxfOXVhEgqGKTw1boET
        9wWo0zOzWMFpqqGLx4LNdPI=
X-Google-Smtp-Source: ABdhPJw6XJ+EFy+qF76kvV7ysiqCqLYFDyVkZn+xMlnPnDHvKcUTzztdz1Yl9Ubfin/Ra0c8Ji/TlA==
X-Received: by 2002:a19:8185:: with SMTP id c127mr893632lfd.259.1623870329118;
        Wed, 16 Jun 2021 12:05:29 -0700 (PDT)
Received: from localhost.localdomain (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.gmail.com with ESMTPSA id e20sm365951ljk.67.2021.06.16.12.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 12:05:28 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Andreas Westman Dorcsak <hedmoo@yahoo.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Ihor Didenko <tailormoon@rambler.ru>,
        Ion Agorria <ion@agorria.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v4 1/6] dt-bindings: thermal: Add binding for Tegra30 thermal sensor
Date:   Wed, 16 Jun 2021 22:04:12 +0300
Message-Id: <20210616190417.32214-2-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210616190417.32214-1-digetx@gmail.com>
References: <20210616190417.32214-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

All NVIDIA Tegra30 SoCs have on-chip sensors which monitor temperature
and voltage of the SoC. Sensors also controls CPU x2 freq throttle and
emits emergency shutdown signal. TSENSOR has has two separate channels
for each sensor placed in a different parts of the SoC. Add binding for
the sensor hardware.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../thermal/nvidia,tegra30-tsensor.yaml       | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/nvidia,tegra30-tsensor.yaml

diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra30-tsensor.yaml b/Documentation/devicetree/bindings/thermal/nvidia,tegra30-tsensor.yaml
new file mode 100644
index 000000000000..a35da257b070
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra30-tsensor.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/nvidia,tegra30-tsensor.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra30 Thermal Sensor
+
+maintainers:
+  - Dmitry Osipenko <digetx@gmail.com>
+  - Jon Hunter <jonathanh@nvidia.com>
+  - Thierry Reding <thierry.reding@gmail.com>
+
+description: |
+  TSENSOR provides thermal and voltage sensors which monitor temperature
+  and voltage of the chip. Sensors are placed across the die to gauge the
+  temperature of the whole chip. The TSENSOR module:
+
+    Generates an interrupt to SW to lower temperature via DVFS on reaching
+    a certain thermal/voltage threshold.
+
+    Generates a signal to the CAR to reduce CPU frequency by half on reaching
+    a certain thermal/voltage threshold.
+
+    Generates a signal to the PMC when the temperature reaches dangerously high
+    levels to reset the chip and sets a flag in the PMC.
+
+  TSENSOR has two channels which monitor two different spots of the SoC.
+
+properties:
+  compatible:
+    const: nvidia,tegra30-tsensor
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  "#thermal-sensor-cells":
+    const: 1
+
+  assigned-clock-parents: true
+  assigned-clock-rates: true
+  assigned-clocks: true
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+  - interrupts
+  - "#thermal-sensor-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    thermal-sensor@70014000 {
+      compatible = "nvidia,tegra30-tsensor";
+      reg = <0x70014000 0x500>;
+      interrupts = <0 102 4>;
+      clocks = <&clk 100>;
+      resets = <&rst 100>;
+
+      #thermal-sensor-cells = <1>;
+    };
-- 
2.30.2

