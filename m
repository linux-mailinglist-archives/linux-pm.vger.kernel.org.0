Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAFF42F0BD
	for <lists+linux-pm@lfdr.de>; Fri, 15 Oct 2021 14:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238810AbhJOM2Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Oct 2021 08:28:16 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:53583 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233784AbhJOM2Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Oct 2021 08:28:16 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 56825580ECC;
        Fri, 15 Oct 2021 08:26:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 15 Oct 2021 08:26:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=DiwHj+vaHXUQK
        XyQ9BUo+GIG90hR4W/o3+wsmuFsT8o=; b=VkBYDutVyK0gALaDt0iiqbf1540eX
        ySJScIoE4EfPZesrMCGIKmtzjvV4G5VVJJ0Pd6PmUxoTCjbA55gWDbH2TxaAU0PB
        +L0mrGFGBUk2LBL+xs0A0ifDqNck7ajViMurpyOlo2E6pqCMin3FcyJ/hJsnoUmb
        bKqdcRfUda65DADU1gu0yuIOxiDQCEylz8IwIkPirB25CyOpgdkmwQS8RIlDjCHi
        w1ZMhe4D3Q4U4gikcuBzD8v4m6699IDPBc36vKsIObKoZqK6GpDFz8suBy2f5S3l
        oaLeOYSE1Yw4K/D+CpD0xndDGE5x2iW4EoD3glVTUDUY9IE5jiQUABrug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=DiwHj+vaHXUQKXyQ9BUo+GIG90hR4W/o3+wsmuFsT8o=; b=EwY4c9g0
        jfACM9SX3iNRA1TDK7CnTctKOsZ108lcqcIEQAnqWSXWq7JchIGZoRib0OTIyMO/
        MwJuSpexy3KPiL8Ck1XLVMcfnFr90TDUvfLpogOFEQ3egB0XUu24Qqpjnqvassgn
        tltY3CPQY9M5advqf4zP8o9K0z1qFYj/JrH5gMQlPIgQHjmXI8XEZdK6iLABgZdF
        rnn2m9I/lw9Jv8mhMMHrIaW7eyDCrXq//POP6yJYz0ujm+Qtg6q6QsLar2VnocEK
        vEfdPrU46W6JSC0J7kXu2Jy5Wjjj1Ddf+9SCKJDVcarJ8fqqJlSpRbdhMimxJV1t
        VaFdmDgzm6twUw==
X-ME-Sender: <xms:YXNpYUuAyh88PcaSodGClUGlJfhRNkuj4yI2MUDBpqsnZ10jJUUMgg>
    <xme:YXNpYRcelg8pZsYEUcHtd-MEVPkrkkTwhTbS-JmARoNh8vwX1VpYA98n5_FpXZANv
    wjygieoEHHjM3Hlcgg>
X-ME-Received: <xmr:YXNpYfzRhyiQZpRJ7EkOHD2cF-R5ZC8CrTwc8qY_f6rxR5PlH64wbdXWz01xCuzzOhkubWcTD5kc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddugedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetlhhishht
    rghirhcuhfhrrghntghishcuoegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
    eqnecuggftrfgrthhtvghrnhepffdthffggefglefgkeejhfekiefgleelfefhtefhheef
    teelgeeggefgfeffvddtnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishht
    rghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:YXNpYXM8sKnYHSP8oFyrwc4flCwbty_MIgnE1Z6hOqtF-0spqa9BJA>
    <xmx:YXNpYU_ToEaBV1ppbfZtQAPb_vS5cXS2Nya88CFBoFZAQLT_Gg73TQ>
    <xmx:YXNpYfWODWD6d9nSzpOusuCNEzyvBhXdGa0Rtuq2GQNTh0XK5aaGLg>
    <xmx:YXNpYUPIYD0_EXssvAf3vELw-NkkLh-OFjo_1isTSOckYdG66HXvDw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Oct 2021 08:26:03 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, kernel@pengutronix.de
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, linux-imx@nxp.com,
        amitk@kernel.org, rui.zhang@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org,
        Alistair Francis <alistair@alistair23.me>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v13 1/9] dt-bindings: mfd: Initial commit of silergy,sy7636a.yaml
Date:   Fri, 15 Oct 2021 22:25:43 +1000
Message-Id: <20211015122551.38951-2-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211015122551.38951-1-alistair@alistair23.me>
References: <20211015122551.38951-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Initial support for the Silergy SY7636A Power Management chip
and regulator.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/mfd/silergy,sy7636a.yaml         | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml

diff --git a/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml b/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
new file mode 100644
index 000000000000..0566f9498e2f
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/silergy,sy7636a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: silergy sy7636a PMIC
+
+maintainers:
+  - Alistair Francis <alistair@alistair23.me>
+
+properties:
+  compatible:
+    const: silergy,sy7636a
+
+  reg:
+    description:
+      I2C device address.
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  '#thermal-sensor-cells':
+    const: 0
+
+  epd-pwr-good-gpios:
+    description:
+      Specifying the power good GPIOs.
+    maxItems: 1
+
+  regulators:
+    type: object
+
+    properties:
+      compatible:
+        const: silergy,sy7636a-regulator
+
+      vcom:
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        properties:
+          regulator-name:
+            const: vcom
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - '#thermal-sensor-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      pmic@62 {
+        compatible = "silergy,sy7636a";
+        reg = <0x62>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_epdpmic>;
+        #thermal-sensor-cells = <0>;
+
+        regulators {
+          reg_epdpmic: vcom {
+            regulator-name = "vcom";
+            regulator-boot-on;
+          };
+        };
+      };
+    };
+...
-- 
2.31.1

