Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5E0515D2EC
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2020 08:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgBNHhG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Feb 2020 02:37:06 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34732 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728779AbgBNHhF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Feb 2020 02:37:05 -0500
Received: by mail-lf1-f66.google.com with SMTP id l18so6133210lfc.1;
        Thu, 13 Feb 2020 23:37:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cpHL/FMefeNmXKGIm1elRfDh1SjiQSSKKDy7A4ArDZ8=;
        b=rGvB3BfAGGMwmfG304YLniCdgLijm8xDa7NcbbV3heklvMZcsrcuYRf16DytvnVMH/
         Ep0Bijt0/NtRCZgVvMoqW88E/zEx9Keb7jt832ox1xb4ygk9vO42X+aEBIjPVziiFCge
         9orGMxkbKOonsP9hsuKE8/gqej20C+T/UBMuVQFX11A+N2kS/k8+Ds5UfvI1NQymx/v0
         SUj+cg0iK7gRlRcCjS/e3kXHev+n4C+2laI6yyMRZRw4ER4UhPDyGxvU26a6MNRhu1Ys
         j+7+mfz3Yo4h8PtNEXfPRAj6SdNxbA+y4KeQvvRNMT57wPnTUZ8+eEHAKSiIa6P5i0/a
         DX3Q==
X-Gm-Message-State: APjAAAXScBC6iEPoNEYn+FW1gzZmj0eSJGJZog991Dc66D3uiSrwUVh1
        ZWNCY8VDML8T2PgfZOSptnc=
X-Google-Smtp-Source: APXvYqypqLwhaeWH5coE5ggQ1qlUBDAxnQzGiGWLLRVyV68SmEZGQRl7wSGQUFjb6tloork1SYqmZA==
X-Received: by 2002:ac2:5e9b:: with SMTP id b27mr1031470lfq.184.1581665820488;
        Thu, 13 Feb 2020 23:37:00 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id f9sm2974618ljp.62.2020.02.13.23.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 23:36:59 -0800 (PST)
Date:   Fri, 14 Feb 2020 09:36:47 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     mikko.mutanen@fi.rohmeurope.com, markus.laine@fi.rohmeurope.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 2/5] dt_bindings: ROHM BD99954 Charger
Message-ID: <104b5ef63c2ad4771503d9e6618bf427721042c3.1581597365.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1581597365.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1581597365.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The ROHM BD99954 is a Battery Management LSI for 1-4 cell Lithium-Ion
secondary battery. Intended to be used in space-constraint equipment such
as Low profile Notebook PC, Tablets and other applications. BD99954
provides a Dual-source Battery Charger, two port BC1.2 detection and a
Battery Monitor.

Document the DT bindings for BD99954

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---

It would probably be nice if the charger DT binding yaml could somehow
be listing and evaluating properties that it can use from static battery
nodes - and perhaps some warning could be emitted if unsupported
properties are given from battery nodes(?) Just some thinking here.
What if the charger ignores for example the current limits from battery
node (I am not sure but I think a few may ignore) - I guess it would be
nice to give a nudge to a person who added those properties in his DT
if they won't have any impact? Any thoughts?

 .../bindings/power/supply/rohm,bd9995x.yaml   | 167 ++++++++++++++++++
 1 file changed, 167 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/rohm,bd9995x.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/rohm,bd9995x.yaml b/Documentation/devicetree/bindings/power/supply/rohm,bd9995x.yaml
new file mode 100644
index 000000000000..bd1e37ee644d
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/rohm,bd9995x.yaml
@@ -0,0 +1,167 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/rohm,bd9995x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ROHM BD99954 Battery charger driver
+
+maintainers:
+  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
+  - Markus Laine <markus.laine@fi.rohmeurope.com>
+  - Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>
+
+description: |
+  The ROHM BD99954 is a Battery Management LSI for 1-4 cell Lithium-Ion
+  secondary battery intended to be used in space-constraint equipment such
+  as Low profile Notebook PC, Tablets and other applications. BD99954
+  provides a Dual-source Battery Charger, two port BC1.2 detection and a
+  Battery Monitor.
+
+Optional properties:
+- monitored-battery: phandle of battery characteristics devicetree node
+  The charger uses the following battery properties:
+    + precharge-current-microamp: maximum charge current during precharge
+      phase (typically 20% of battery capacity).
+    + charge-term-current-microamp: a charge cycle terminates when the
+      battery voltage is above recharge threshold, and the current is below
+      this setting (typically 10% of battery capacity).
+  See also Documentation/devicetree/bindings/power/supply/battery.txt
+- ti,system-minimum-microvolt: when power is connected and the battery is below
+  minimum system voltage, the system will be regulated above this setting.
+
+properties:
+  compatible:
+    const: rohm,bd9995x-charger
+#
+#    The battery charging profile of BD99954.
+#
+#    Curve (1) represents charging current.
+#    Curve (2) represents battery voltage.
+#
+#    The BD99954 data sheet divides charging to three phases.
+#    a) Trickle-charge with constant current (8).
+#    b) pre-charge with constant current (6)
+#    c) fast-charge with:
+#       First a constant current (5) phase (CC)
+#       Then constant voltage (CV) phase (after the battery voltage has reached
+#       target level - until charging current has dropped to termination
+#       level (7)
+#
+#     V ^                                                        ^ I
+#       .                                                        .
+#       .                                                        .
+# (4)- -.- - - - - - - - - - - - - -  +++++++++++++++++++++++++++.
+#       .                            /                           .
+#       .                     ++++++/++ - - - - - - - - - - - - -.- - (5)
+#       .                     +    /  +                          .
+#       .                     +   -   --                         .
+#       .                     +  -     +                         .
+#       .                     +.-      -:                        .
+#       .                    .+         +`                       .
+#       .                  .- +       | `/                       .
+#       .               .."   +          .:                      .
+#       .             -"      +           --                     .
+#       .    (2)  ..."        +       |    :-                    .
+#       .    ...""            +             -:                   .
+# (3)- -.-.""- - - - -+++++++++ - - - - - - -.:- - - - - - - - - .- - (6)
+#       .             +                       `:.                .
+#       .             +               |         -:               .
+#       .             +                           -:             .
+#       .             +                             ..           .
+#       .   (1)       +               |               "+++- - - -.- - (7)
+#       -++++++++++++++- - - - - - - - - - - - - - - - - + - - - .- - (8)
+#       .                                                +       -
+#       -------------------------------------------------+++++++++-->
+#       |             |       |   CC   |      CV         |
+#       | --trickle-- | -pre- | ---------fast----------- |
+#
+#   The charger uses the following battery properties
+# - tricklecharge-current-microamp:
+#     Current used at trickle-charge phase (8 in above chart)
+#     minimum: 64000
+#     maximum: 1024000
+#     multipleOf: 64000
+# - precharge-current-microamp:
+#     Current used at pre-charge phase (6 in above chart)
+#     minimum: 64000
+#     maximum: 1024000
+#     multipleOf: 64000
+# - constant-charge-current-max-microamp
+#     Current used at fast charge constant current phase (5 in above chart)
+#     minimum: 64000
+#     maximum: 1024000
+#     multipleOf: 64000
+# - constant-charge-voltage-max-microvolt
+#     The constant voltage used in fast charging phase (4 in above chart)
+#     minimum: 2560000
+#     maximum: 19200000
+#     multipleOf: 16000
+# - precharge-upper-limit-microvolt
+#     charging mode is changed from trickle charging to pre-charging
+#     when battery voltage exceeds this limit voltage (3 in above chart)
+#     minimum: 2048000
+#     maximum: 19200000
+#     multipleOf: 64000
+# - re-charge-voltage-microvolt
+#     minimum: 2560000
+#     maximum: 19200000
+#     multipleOf: 16000
+#     re-charging is automatically started when battry has been discharging
+#     to the point where the battery voltage drops below this limit
+# - over-voltage-threshold-microvolt
+#     battery is expected to be faulty if battery voltage exceeds this limit.
+#     Charger will then enter to a "battery faulty" -state
+#     minimum: 2560000
+#     maximum: 19200000
+#     multipleOf: 16000
+# - charge-term-current-microamp
+#     minimum: 0
+#     maximum: 1024000
+#     multipleOf: 64000
+#     a charge cycle terminates when the battery voltage is above recharge
+#     threshold, and the current is below this setting (7 in above chart)
+#   See also Documentation/devicetree/bindings/power/supply/battery.txt
+
+  monitored-battery:
+    description:
+      phandle of battery characteristics devicetree node
+
+  rohm,vbus-input-current-limit-microamp:
+    description:
+      system specific VBUS input current limit (in microamps).
+    minimum: 32000
+    maximum: 16352000
+    multipleOf: 32000
+
+  rohm,vcc-input-current-limit-microamp:
+    description:
+      system specific VCC/VACP input current limit (in microamps).
+    minimum: 32000
+    maximum: 16352000
+    multipleOf: 32000
+
+  rohm,vsys-regulation-microvolt:
+    description:
+      system specific lower limit for system voltage.
+    minimum: 2560000
+    maximum: 19200000
+    multipleOf: 64000
+
+required:
+  - compatible
+
+examples:
+  - |
+    i2c {
+        charger@9 {
+            compatible = "rohm,bd9995x-charger";
+            monitored-battery = <&battery>;
+            reg = <0x9>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <29 8>;
+            rohm,vsys-regulation-microvolt = <8960000>;
+            rohm,vbus-input-current-limit-microamp = <1472000>;
+            rohm,vcc-input-current-limit-microamp = <1472000>;
+        };
+    };
-- 
2.21.0


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
