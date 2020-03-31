Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37E49199657
	for <lists+linux-pm@lfdr.de>; Tue, 31 Mar 2020 14:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730686AbgCaMWi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Mar 2020 08:22:38 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34638 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730642AbgCaMWi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Mar 2020 08:22:38 -0400
Received: by mail-lf1-f66.google.com with SMTP id e7so17139196lfq.1;
        Tue, 31 Mar 2020 05:22:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UBgWQY8O2F7lxf+qlrGLLmfAbdQp9uenUJ2LLEFCY+I=;
        b=FA0L0Vucj2Bi8fancseIrNIj1S+zUu/R0nz9081nrqqnMRXpYZ/4A7T8fbRUIGenj/
         NJ7p+aBZ0I3CllRFI4q9Wd8IoSdpn3evCyUkTIaFNpWMAgldluZFxfVC3eMSYU9AU1EU
         KwBTITrDyu6ekOMdo+x9rfXpWleRGN2mM2S3h0+Iv/R2m33DUne7x0bP0cAaH5nZsJuj
         ZoyDeZeEpc92kQBeJlltD+LkfbO1bLcGrXqm88b0lgOPDlKBzSDvXFpu4QrCMKK2AJsS
         mm4iyQGjsWfZ3PAas8ttOxEEtm6xeV8+SxGlEopoLD/kN/3C2pywqpgCJi6rovqkhWOp
         BDBA==
X-Gm-Message-State: AGi0PuZodsGszHfRoAVcKckn+D1qHptQvRo4kye7AgdUEV8OksObLfxC
        pZonDp9Mz4RinWPYXsb41Rc=
X-Google-Smtp-Source: APiQypKSpyM7gTf8vsK/YmSi8DCSdFxmXspsOqBWITM1iQn/Ax6p33kSuZtfNICn6M4ebqPCtLEf6g==
X-Received: by 2002:ac2:4578:: with SMTP id k24mr11245652lfm.180.1585657354746;
        Tue, 31 Mar 2020 05:22:34 -0700 (PDT)
Received: from localhost.localdomain (dc7t7ryyyyyyyyyyyyybt-3.rev.dnainternet.fi. [2001:14ba:16e1:b700::3])
        by smtp.gmail.com with ESMTPSA id b16sm4442821ljh.20.2020.03.31.05.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 05:22:34 -0700 (PDT)
Date:   Tue, 31 Mar 2020 15:22:26 +0300
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
Subject: [PATCH v7 02/10] dt_bindings: ROHM BD99954 Charger
Message-ID: <8e47af93563b266020924f66b2c40311304cbccd.1585656143.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1585656143.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1585656143.git.matti.vaittinen@fi.rohmeurope.com>
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

No changes since v6

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
