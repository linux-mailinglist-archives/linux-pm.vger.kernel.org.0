Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 960C6190781
	for <lists+linux-pm@lfdr.de>; Tue, 24 Mar 2020 09:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgCXI2Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Mar 2020 04:28:24 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40535 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbgCXI2Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Mar 2020 04:28:24 -0400
Received: by mail-lf1-f65.google.com with SMTP id j17so12459901lfe.7;
        Tue, 24 Mar 2020 01:28:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kRJg84VU9tp6u6sQPu2G+yAX+4Ye9aKZ4f3szcmB6vE=;
        b=ueMOHo0BAHnbYXpUe4LEiO2S3DCcjy75XpBqWcMtqaTq7W7HYxSNRktG3IIDYcnkDg
         78DF0nTr7zrL948ytcuc/ZVwY9SLy8ERH00DDYn83Sk0izLzqXgPtpcnCcrZ7SBMw4vQ
         DhuEXMyzWwD+SNzmZ5nv/2uKGk3F1jsUWRUBV09AWYQAx2oX/9NOohgZtL2FC16jzrMO
         d8i8FWrldN4N9kWBXQNEo4d/YCyyu3w199w2yzIjGa3hXeaMHbBO7lC96kRTgfKEPTT3
         Bl+tE9O79AXlz5xWYoapxosP7jRjvU5MArtVC5wJoUOW0yfCs0b+37R8r9ty/zZHI+SE
         MYdA==
X-Gm-Message-State: ANhLgQ2yhfmUpShp+455L0Vm2Ez0VoWYKUUFentmxI9kzR4EQSYIic2t
        Ai/4x7i00WDLRdUhFh0RmXo=
X-Google-Smtp-Source: ADFU+vtI4InlVmw+OQgIHWxu3hpikd74MhMKUAVtY0A9WnHehR88WKu5TGH1ZxrtwYh2HzGuviBr5g==
X-Received: by 2002:a05:6512:2012:: with SMTP id a18mr4616022lfb.208.1585038500978;
        Tue, 24 Mar 2020 01:28:20 -0700 (PDT)
Received: from localhost.localdomain (dc7t7ryyyyyyyyyyyyybt-3.rev.dnainternet.fi. [2001:14ba:16e1:b700::3])
        by smtp.gmail.com with ESMTPSA id r2sm9362176lfn.92.2020.03.24.01.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 01:28:20 -0700 (PDT)
Date:   Tue, 24 Mar 2020 10:28:12 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>,
        Markus Laine <markus.laine@fi.rohmeurope.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@suse.de>,
        Brendan Higgins <brendanhiggins@google.com>,
        Changbin Du <changbin.du@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Gow <davidgow@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Gary Hook <Gary.Hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Tal Gilboa <talgi@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v6 02/10] dt_bindings: ROHM BD99954 Charger
Message-ID: <7a977e37124324a33b202ac6ffaa128b40044076.1584977512.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1584977512.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1584977512.git.matti.vaittinen@fi.rohmeurope.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/power/supply/rohm,bd99954.yaml   | 155 ++++++++++++++++++
 1 file changed, 155 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/rohm,bd99954.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/rohm,bd99954.yaml b/Documentation/devicetree/bindings/power/supply/rohm,bd99954.yaml
new file mode 100644
index 000000000000..7e0f73a898c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/rohm,bd99954.yaml
@@ -0,0 +1,155 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/rohm,bd99954.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ROHM BD99954 Battery charger
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
+    const: rohm,bd99954
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
+    multipleOf: 64000
+
+  rohm,vbus-input-current-limit-microamp:
+    description: system specific VBUS input current limit (in microamps).
+    minimum: 32000
+    maximum: 16352000
+    multipleOf: 32000
+
+  rohm,vcc-input-current-limit-microamp:
+    description: system specific VCC/VACP input current limit (in microamps).
+    minimum: 32000
+    maximum: 16352000
+    multipleOf: 32000
+
+required:
+  - compatible
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        charger@9 {
+            compatible = "rohm,bd99954";
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
