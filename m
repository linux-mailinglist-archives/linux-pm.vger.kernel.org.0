Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB2343941C
	for <lists+linux-pm@lfdr.de>; Mon, 25 Oct 2021 12:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbhJYKz4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Oct 2021 06:55:56 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:58005 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232837AbhJYKzz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Oct 2021 06:55:55 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id E34F158045A;
        Mon, 25 Oct 2021 06:53:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 25 Oct 2021 06:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=xPIOWPlEpcSPg
        VeMbUyqzIh0yquJ8UKRhzhIcmgwvNU=; b=MyMo3f0t/4hNgBQPbTN0Vfo5b0L2Y
        my6Ff2ag4qDoUP0xA7eFSf5OgI2rjk+gJTXfvUeUxomNKTfS9ZCzBDoeiUS77FHT
        zHAG27671eFMGvtPW14LGistc3Ljr20ZooC4MM+j+vmSLMbZVCAvN8mtAugI0KND
        zfrxBCdQcX3MbQgyVuu9k42JVIzyo2HqPKCXTa1YyXG3Eh7J5U7X6BujLWH/5tF/
        FNvFIi08oTpPhvDW+D1owBeFt0eZO8DEz1SDPoTI0bLM0EXrgYIWKY1niP/Gd3FI
        IlKtG7P3ud6CP5WgeN3+0f2jyGtZSBQPgSBRPFdPyA39xxOSXC1/DiDtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=xPIOWPlEpcSPgVeMbUyqzIh0yquJ8UKRhzhIcmgwvNU=; b=EzYtRWQB
        FIKNpZxoTZHUoaHAFA9x2FKhVJ+D0rXaoPk6/YiZGpDgajsE+eDB9kscZHtz9uZa
        aGi5eY7lyRku/EujHylPasBZN4xKiqLkUq+mOh/SXtcfWqP96sd4HttcTxXPKNGK
        q8vPLsdDNAhZdCIJ7YCOUqfsRl635lWOaXsKcFv9WTntSpmDv6OJwxH5pr2/JTN5
        av/RoUl7vExbETbN3IvzC276XANCYLl/Q5mYu2hD5QGc+O2i7RTlqPwAGSUUk5+J
        uh+/FAF+6dyEeDm7YRIXDK0ANDvQ2zlWZgoi3AkhJPUWq8XnV8vxxT9rOn04+/ov
        QlI9VezkmrBUrg==
X-ME-Sender: <xms:q4x2Yele2fONxIMNkWeHzrALhUo56Oa7Zs0_WFJUNNEd-wMjyLoraw>
    <xme:q4x2YV3blPML3hzlOrvXb1ewuzUxbk3YzfJKdSpFlU4pMvJTnI4TYyJU7STY7G3eI
    tQ5wbjbV9dEAcva_fk>
X-ME-Received: <xmr:q4x2YcpMk0rE15O_gFug9UjdY971wanDYAyeRUvw5oj968zLgFHpt-DzGscxBYS8ka9r1IAIF1aC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdefhedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetlhhishht
    rghirhcuhfhrrghntghishcuoegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
    eqnecuggftrfgrthhtvghrnhepffdthffggefglefgkeejhfekiefgleelfefhtefhheef
    teelgeeggefgfeffvddtnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishht
    rghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:q4x2YSma0FL2-QHjJNSlHnwPZkl7H8fyC_ggcdtWmQXcmYkXcY8N9g>
    <xmx:q4x2Yc09YpWoQYcXE3-ORQm83UgXuz19XO4kTBq8Iy4F1nLGPBpoLg>
    <xmx:q4x2YZsaPR5zOX-JKnr96smMtAnPxpzS6R7ZS5oMbxTn4-deFLzi9g>
    <xmx:q4x2YU4suk1rmB1q1eE4v0LLQEs-k_7UNtQjMhVU8nbwBM-lmBa9yg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Oct 2021 06:53:21 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     robh+dt@kernel.org, kernel@pengutronix.de, lgirdwood@gmail.com,
        lee.jones@linaro.org, broonie@kernel.org
Cc:     s.hauer@pengutronix.de, rui.zhang@intel.com,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        amitk@kernel.org, shawnguo@kernel.org, alistair23@gmail.com,
        devicetree@vger.kernel.org, linux-imx@nxp.com,
        andreas@kemnade.info, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alistair Francis <alistair@alistair23.me>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v14 1/8] dt-bindings: mfd: Initial commit of silergy,sy7636a.yaml
Date:   Mon, 25 Oct 2021 20:53:02 +1000
Message-Id: <20211025105309.37942-2-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211025105309.37942-1-alistair@alistair23.me>
References: <20211025105309.37942-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Initial support for the Silergy SY7636A Power Management chip
and regulator.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
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

