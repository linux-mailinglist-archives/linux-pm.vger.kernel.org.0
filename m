Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65C3B16587F
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 08:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgBTHfV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 02:35:21 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46628 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgBTHfV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 02:35:21 -0500
Received: by mail-lf1-f65.google.com with SMTP id z26so2226263lfg.13;
        Wed, 19 Feb 2020 23:35:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ql2HduRsN3YaSuvoHPSqRaIQbvZ8WP90c57ltIwIGZE=;
        b=qovvFR12gR+m7WOSBSxSgXXbCSF0SuR/Ejo8lElONNU0AJAvBCTEm/OitXsNLWl2Kg
         2Ib4q13q12FvQ/SXKaStvZCY7zm7XGbIjyGxCH4zfk39JInqJaOf/4EgaB3jsDRxocUw
         vC4qFSmorNFa3YWuMC52eBcRIX8WgH0CNPFaCck8CP58KxnruxXAjaj1cKbF7NHKL5F5
         iZb7+f/Jl84PsoIKOjtqQtzNsGsg0rSOzUd8MiaRF0IVeftXj+0fJh49sjHI3WRCCFfX
         xq6e1EKJdlQBvpTaOnnmpxOeZl5Xelyu0hSjXPT3rWWA1T+C/5hc2DWs4rVgAoZ7T5jp
         6Gew==
X-Gm-Message-State: APjAAAX8TEdATZ9pUCRp0qkLhAjaJK1y2Ff+YSm/82ocCNlm8wzNyVVA
        ZqrfE2LwfgHK+yIgnKeYuYw=
X-Google-Smtp-Source: APXvYqwO4DZMfq+31C2aGGMWK5qR56nrlMGuO9YrxpSWEvwrLcfTDoDeewuOjthSQSLClt4hcjeASA==
X-Received: by 2002:ac2:5196:: with SMTP id u22mr14955587lfi.123.1582184117382;
        Wed, 19 Feb 2020 23:35:17 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id j19sm1399556lfb.90.2020.02.19.23.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 23:35:16 -0800 (PST)
Date:   Thu, 20 Feb 2020 09:35:10 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "GitAuthor: Matti Vaittinen" <matti.vaittinen@fi.rohmeurope.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Laine <markus.laine@fi.rohmeurope.com>,
        Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>
Subject: [RFC PATCH v3 2/8] dt_bindings: ROHM BD99954 Charger
Message-ID: <f82f140cd758d435a1ab4e45fef4e17a5af2db5c.1582182989.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1582182989.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1582182989.git.matti.vaittinen@fi.rohmeurope.com>
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
 .../bindings/power/supply/rohm,bd9995x.yaml   | 153 ++++++++++++++++++
 1 file changed, 153 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/rohm,bd9995x.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/rohm,bd9995x.yaml b/Documentation/devicetree/bindings/power/supply/rohm,bd9995x.yaml
new file mode 100644
index 000000000000..032aaa0a305e
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/rohm,bd9995x.yaml
@@ -0,0 +1,153 @@
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
+# - trickle-charge-current-microamp:
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
+  rohm,vsys-regulation-microvolt:
+    description: system specific lower limit for system voltage.
+    minimum: 2560000
+    maximum: 19200000
+    #multipleOf: 64000
+
+  rohm,vbus-input-current-limit-microamp:
+    description: system specific VBUS input current limit (in microamps).
+    minimum: 32000
+    maximum: 16352000
+    #multipleOf: 32000
+
+  rohm,vcc-input-current-limit-microamp:
+    description: system specific VCC/VACP input current limit (in microamps).
+    minimum: 32000
+    maximum: 16352000
+    #multipleOf: 32000
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
