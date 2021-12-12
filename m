Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 859444719C3
	for <lists+linux-pm@lfdr.de>; Sun, 12 Dec 2021 12:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhLLLUj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Dec 2021 06:20:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57770 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhLLLUh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Dec 2021 06:20:37 -0500
Date:   Sun, 12 Dec 2021 11:20:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639308036;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JGLaRYQuITBP7WyEaR88+/eVqc4pQ87kl6EIZ9Tpi34=;
        b=s2TRmsDrnjEAN94xaVQlJLPpCghde7nhFhJYqxlOgRkuwEWeA+2WIu9AdciJJj5S6EXHA5
        A4TdLYKA0WQfloaFTCqxC77PKD7Z4lwDe5ymDpj7eTYux3GikYWJ9mRTjUG4az5l4UqhCg
        5P7yUCI25JAJu5neQdRCQQ+Dm1WtfPxZEIsgwGDD4YDF8IWYQsJ4BW9S65p5BPH2tmEFSw
        3hoxSywkckKiDYodq35zNN5cED4FWkGzdDi+fKfxhlnoLaVK1YZux2KVys6DySLCZIBMYm
        LnXRorxccxQ3h5U8uF6ScdvKcwOBkhz0SNAd5wh7g6DlCs3sj9gcg6xrS5OQnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639308036;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JGLaRYQuITBP7WyEaR88+/eVqc4pQ87kl6EIZ9Tpi34=;
        b=yt2hoZ3UhJxnYZVlzSRgkT91P5IDSvpPwuZ777mA8wRQWjrSPEFhO+LB5SBHLNONAwtt80
        eylm0QUe4KdTvfBw==
From:   "thermal-bot for Biju Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] dt-bindings: thermal: Document Renesas RZ/G2L TSU
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20211130155757.17837-2-biju.das.jz@bp.renesas.com>
References: <20211130155757.17837-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Message-ID: <163930803580.23020.16954701211179962674.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     9460347192add5644236d492f79ecab6d83504d4
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//9460347192add5644236d492f79ecab6d83504d4
Author:        Biju Das <biju.das.jz@bp.renesas.com>
AuthorDate:    Tue, 30 Nov 2021 15:57:56 
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 30 Nov 2021 17:27:45 +01:00

dt-bindings: thermal: Document Renesas RZ/G2L TSU

Document the Thermal Sensor Unit(TSU) in the RZ/G2L SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20211130155757.17837-2-biju.das.jz@bp.renesas.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml | 76 +++++++-
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml b/Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml
new file mode 100644
index 0000000..ccab951
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/rzg2l-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/G2L Thermal Sensor Unit
+
+description:
+  On RZ/G2L SoCs, the thermal sensor unit (TSU) measures the
+  temperature(Tj) inside the LSI.
+
+maintainers:
+  - Biju Das <biju.das.jz@bp.renesas.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - renesas,r9a07g044-tsu # RZ/G2{L,LC}
+      - const: renesas,rzg2l-tsu
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  "#thermal-sensor-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - power-domains
+  - resets
+  - "#thermal-sensor-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/r9a07g044-cpg.h>
+
+    tsu: thermal@10059400 {
+            compatible = "renesas,r9a07g044-tsu",
+                         "renesas,rzg2l-tsu";
+            reg = <0x10059400 0x400>;
+            clocks = <&cpg CPG_MOD R9A07G044_TSU_PCLK>;
+            resets = <&cpg R9A07G044_TSU_PRESETN>;
+            power-domains = <&cpg>;
+            #thermal-sensor-cells = <1>;
+    };
+
+    thermal-zones {
+            cpu-thermal {
+                    polling-delay-passive = <250>;
+                    polling-delay = <1000>;
+                    thermal-sensors = <&tsu 0>;
+
+                    trips {
+                            sensor_crit: sensor-crit {
+                                    temperature = <125000>;
+                                    hysteresis = <1000>;
+                                    type = "critical";
+                            };
+                    };
+            };
+    };
