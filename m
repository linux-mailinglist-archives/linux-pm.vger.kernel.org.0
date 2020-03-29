Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E348196FBB
	for <lists+linux-pm@lfdr.de>; Sun, 29 Mar 2020 21:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgC2Tgu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Mar 2020 15:36:50 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:34982 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727330AbgC2Tgu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Mar 2020 15:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1585510605;
        s=strato-dkim-0002; d=goldelico.com;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=LGEWryyfK/Q4YmTBmmWe/YtpTjCpoE18SQ1zSiub5+0=;
        b=s2cFM7cJN9nbvSDJSp/eLgprnBwpBxsxEjT7gCAEW8qExxHQaoy0uho/CSyfUdEOFH
        B686KYlnjKdv9gVgE4PcFXnhZjYDvUl/ZV23FClJaNGAc92EuCVKQwcPX4MEgw76AcPo
        JdN2ldRGsBKnP1llv+Cyqtssabi6LBaKmo29aELnRclTIkstnk2yU6MH9G/BwhEaULcL
        CrIloBljC/twBts0MD1zLz4yhmXnfKBiCcpMpu+NPfIo9rOZ3goYDSxYdrL7qg+itLXK
        B7r2F4/gTZ3c34duRily4VUd/GixwfxlTGgrZ4uWrTJ9/UJjxsZiaM75m3g9UN9Vcy7t
        C3CA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0pDz2rsNxxv"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 46.2.1 DYNA|AUTH)
        with ESMTPSA id m02241w2TJaTBbV
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Sun, 29 Mar 2020 21:36:29 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [RFC] dt-bindings.yaml: power: supply: add bindings for TI bq24296/7
Date:   Sun, 29 Mar 2020 21:36:29 +0200
Message-Id: <7d7602574b5eda80bd1d40f79854ba3670201c6e.1585510588.git.hns@goldelico.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is an attempt to define a schema for the bq24296/7
charger and power supply controllers with battery monitoring
and OTG booster.

We model it as a dual regulator because it can generate
a VSYS (with controllable voltage) and optionally an
OTG voltage either from the battery or from external power
supply.

This scheme works well with e.g. the dwc3 setup of the
OMAP5 to turn on OTG regulator on demand.

The DT should provide a reference to a monitored battery
description so that initial and operation parameters
of the battery can be specified to control the charger
parameters.

To support different initial charging current for USB
and AC charger mode, an optional gpio should be provided
that the driver can use to set defaults.

A driver is available and working for several years,
but the bindings should be clarified first.

The example shows what we are successfully using for
the working system.

Since the omap5 Pyra Handheld is not yet in the DTS tree,
there would be no explicit user of this driver. So
the plan is to submit a full patch set for the Pyra
later.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 .../bindings/power/supply/bq2429x.yaml        | 122 ++++++++++++++++++
 1 file changed, 122 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq2429x.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/bq2429x.yaml b/Documentation/devicetree/bindings/power/supply/bq2429x.yaml
new file mode 100644
index 000000000000..1b31ece4026e
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/bq2429x.yaml
@@ -0,0 +1,122 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/bq2429x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI bq24296/24297 and MPS MP2624 Li-Ion Charger with OTG booster
+
+maintainers:
+  - H. Nikolaus Schaller <hns@goldelico.com>
+
+description: |+
+  This binding will support the bq24296 and bq24297.
+  There are other ICs in the same family but those have
+  not been addressed.
+  The MP2624 is very similar to the bq24297 but not exactly
+  identical.
+  This chip is used by the OMAP5 based Pyra-Handheld.
+
+properties:
+  compatible:
+    oneOf:
+      - const: mps,mp2624
+      - const: ti,bq24296
+      - const: ti,bq24297
+
+  reg:
+    const: 0x6b
+
+  interrupts:
+    minItems: 1
+
+  monitored-battery:
+    - description: phandle to the battery node
+    - allOf:
+      - $ref: /schemas/types.yaml#/definitions/phandle
+# QUESTION : how can we correctly describe that we support only the following phandle properties and ignore the others?
+    - enum:
+      - voltage-max-design-microvolt:
+        - default: 4200000
+      - voltage-min-design-microvolt:
+        - default: 3200000
+      - constant-charge-current-max-microamp:
+        - default: as defined by boot loader
+      - precharge-current-microamp:
+        - default: 128000
+      - charge-term-current-microamp:
+        - default: 128000
+
+  regulators:
+    minItems: 2
+    maxItems: 2
+    items:
+# QUESTION: can we specify that these are to be regulator nodes?
+      - description: |
+          two regulator child nodes for
+          [0] vsys (battery or usb input -> system output)
+          [1] otg (battery input -> usb output).
+
+  dc-det-gpios:
+    items:
+# QUESTION: how do we specify that it should be a gpio?
+      - description: gpio for detecting two different DC sources
+      - default: use usb-input-current-microamp only
+
+  ti,usb-input-current-microamp:
+    items:
+      - description: initial current for USB source (if dc-det is 0)
+      - default: value as defined by boot loader
+
+  ti,adp-input-current-microamp:
+    items:
+      - description: initial current for other source (if dc-det is 1)
+      - default: 2048000µA
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - regulators
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    bat: battery {
+      compatible = "simple-battery", "pyra-battery";
+      voltage-min-design-microvolt = <3200000>;
+      voltage-max-design-microvolt = <4200000>;
+      energy-full-design-microwatt-hours = <22200000>;
+      charge-full-design-microamp-hours = <6000000>;
+      charge-term-current-microamp = <128000>;
+      constant-charge-current-max-microamp = <1000000>;
+    };
+
+    bq24297@6b {
+      compatible = "ti,bq24297";
+      reg = <0x6b>;
+      monitored-battery = <&bat>;
+      interrupt-parent = <&gpio99>;
+      interrupts = <(1*8+3) IRQ_TYPE_EDGE_FALLING>;   /* P13 */
+      regulators {
+        vsys_reg: vsys_regulator {
+          regulator-compatible = "bq2429x-vsys";
+          regulator-name = "vsys";
+          regulator-min-microvolt = <3500000>;
+          regulator-max-microvolt = <4200000>;
+          regulator-always-on;
+          regulator-boot-on;
+        };
+        otg_reg: otg_regulator {
+          regulator-compatible = "bq2429x-otg";
+          regulator-name = "otg";
+          regulator-min-microvolt = <4900000>;
+          regulator-max-microvolt = <5100000>;
+        };
+      };
+    };
+
+...
-- 
2.25.1

