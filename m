Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24DD8394D62
	for <lists+linux-pm@lfdr.de>; Sat, 29 May 2021 19:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhE2RMS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 29 May 2021 13:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhE2RMR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 29 May 2021 13:12:17 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215BDC06174A;
        Sat, 29 May 2021 10:10:41 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id a5so10145197lfm.0;
        Sat, 29 May 2021 10:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MpvhPzX1ymg5vSIOj/R3c0XtSN9hCFreWZQ1rMcnPsI=;
        b=cEF/edBeiZoX3EJ9sVxvgswrbajZc3tW0CiapswGcIFOKkVumpG8UnjFduDIad7/xi
         /qdTrL6u6fXfqDndW8DyNesMyQtJ0ZA7LERWemwR9W97ZJTX3Qj/k2UVRTHAzi58yihE
         4ps2ulAHX/WU14f6kKnDvlFwsDiClfbTK3lw1ZDPtnIeWzaf7zRUbrUDSbnw0oWd3SLy
         /zpqbooQuWSMJ9zrLdJoItTHHGystEq50lgTCzZu+I4+1Gu7Mn14NOmdpKVAqSzX29iQ
         v1Evp4UMC1mSxqNvm6R6BqppnpS0sR3CfKV+OB6c/ghkI71ufurjoaMi/OfJDA48FK0b
         lloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MpvhPzX1ymg5vSIOj/R3c0XtSN9hCFreWZQ1rMcnPsI=;
        b=DrDqtlixgvRoTzKs8zw2Dnulhx8HDPvd3+hVtRM003+Uo3atBGmppymDpcbTZNZWZj
         I5TtSI6y/BUjoqB8ECd84285YLWe7BEPN3KpBD1CWtUhciRGpAzx9OL3Olju/EEaVgzK
         U8XptXyKRgrnUT0ZnuwBDasUYUULD/82wLUCtK07f/M5+haUgupK0P5DtRbw3vZJlUes
         rWvlfZ/3JztpgSYS7ZI4IbdjO/t1A3OYzF+HHw1R5XJsUZwrHMagxS9csr70F0O11hp6
         zZFKKCg53ukrB90qrIwTldzMZg+rX0gjyxJpScHjHMKliK8pN47FvtUZILVRCe6oDrxH
         J0Ig==
X-Gm-Message-State: AOAM533W5xdmnov+8ZgC9K4l64c34lXMpfAHCnmdMfBDbJ7evvoUWYdl
        tjAIyPDh6n0GvgpfO0/M707BQGPK0L0=
X-Google-Smtp-Source: ABdhPJy1AnCFjFJkmAbUJDv6G6Zo1zpo1Ym98T8f7DNpUaw/KUnkL21UOb5Zx81JRLHrVw+6MYAf/w==
X-Received: by 2002:a19:ac45:: with SMTP id r5mr10163245lfc.449.1622308239519;
        Sat, 29 May 2021 10:10:39 -0700 (PDT)
Received: from localhost.localdomain (46-138-84-89.dynamic.spd-mgts.ru. [46.138.84.89])
        by smtp.gmail.com with ESMTPSA id h12sm901715ljh.130.2021.05.29.10.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 10:10:39 -0700 (PDT)
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
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v3 1/7] dt-bindings: thermal: Add binding for Tegra30 thermal sensor
Date:   Sat, 29 May 2021 20:09:49 +0300
Message-Id: <20210529170955.32574-2-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210529170955.32574-1-digetx@gmail.com>
References: <20210529170955.32574-1-digetx@gmail.com>
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
 .../thermal/nvidia,tegra30-tsensor.yaml       | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/nvidia,tegra30-tsensor.yaml

diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra30-tsensor.yaml b/Documentation/devicetree/bindings/thermal/nvidia,tegra30-tsensor.yaml
new file mode 100644
index 000000000000..6182090d313c
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra30-tsensor.yaml
@@ -0,0 +1,78 @@
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
+  "#cooling-cells":
+    const: 2
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
+  - "#cooling-cells"
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
+      #cooling-cells = <2>;
+    };
-- 
2.30.2

