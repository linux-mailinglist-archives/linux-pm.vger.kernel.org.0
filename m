Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28EC03AE665
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 11:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhFUJtN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 05:49:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43238 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbhFUJs7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 05:48:59 -0400
Date:   Mon, 21 Jun 2021 09:46:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624268804;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zOU+tdixvEvWkf6SpfISMHP2u4tcmioJxIiqhlZVuEU=;
        b=CDPsFoKGt5iG/8+fwgyxWn8jPsYGtwiN2fRFXTpdKKTLSDBwqHM6FqhdijU5vzeGRlpKfO
        VHbmeHDC0JY0uvQuSbUxBCi3Hgs/GorAE4ByMtcyPhHqNQrIryQw1mdKYZddv5+AvlSwpS
        4vfJfADh+MRpiipxWXdVPMS8/l8gItrWHtKLltBDl39/1xepQKsbmmYRXlv0uASoqe30Sp
        swyzoBtA5+RaJ3EMQZAz9L3IwMzc89sZfAboOzYGWHhAysT8ak18evN3wlG0zLVs7DUGpM
        s2s9Ce78QBkTwhlbq92O6ASht7+JcfHAFAhZkN5yCsvbhMhp/sH4/NZxpRTC4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624268804;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zOU+tdixvEvWkf6SpfISMHP2u4tcmioJxIiqhlZVuEU=;
        b=1w9yJ5NOcVlvE8zMp3z9ycL+rbh4rkB0Bq8YhcG/v4LhVayEzT2QyB7nVbuHIHBo2zDc47
        0Yx7XmHaxDneVABg==
From:   "thermal-bot for Dmitry Osipenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] dt-bindings: thermal: Add binding for Tegra30
 thermal sensor
Cc:     Rob Herring <robh@kernel.org>, Dmitry Osipenko <digetx@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210616190417.32214-2-digetx@gmail.com>
References: <20210616190417.32214-2-digetx@gmail.com>
MIME-Version: 1.0
Message-ID: <162426880365.395.10578901827528266115.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     6380829885ccf8a5ec556ef2b3bb69f5961f9dde
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//6380829885ccf8a5ec556ef2b3bb69f5961f9dde
Author:        Dmitry Osipenko <digetx@gmail.com>
AuthorDate:    Wed, 16 Jun 2021 22:04:12 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 18 Jun 2021 12:38:33 +02:00

dt-bindings: thermal: Add binding for Tegra30 thermal sensor

All NVIDIA Tegra30 SoCs have on-chip sensors which monitor temperature
and voltage of the SoC. Sensors also controls CPU x2 freq throttle and
emits emergency shutdown signal. TSENSOR has has two separate channels
for each sensor placed in a different parts of the SoC. Add binding for
the sensor hardware.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210616190417.32214-2-digetx@gmail.com
---
 Documentation/devicetree/bindings/thermal/nvidia,tegra30-tsensor.yaml | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/nvidia,tegra30-tsensor.yaml

diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra30-tsensor.yaml b/Documentation/devicetree/bindings/thermal/nvidia,tegra30-tsensor.yaml
new file mode 100644
index 0000000..a35da25
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
