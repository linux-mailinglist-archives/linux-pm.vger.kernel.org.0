Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47714279A2
	for <lists+linux-pm@lfdr.de>; Sat,  9 Oct 2021 13:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbhJILwy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 Oct 2021 07:52:54 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:53559 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232967AbhJILwu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 9 Oct 2021 07:52:50 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 07E59580A0F;
        Sat,  9 Oct 2021 07:50:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 09 Oct 2021 07:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=DiwHj+vaHXUQK
        XyQ9BUo+GIG90hR4W/o3+wsmuFsT8o=; b=G9otH0hTuvTBZrKLrU12TNBbLBBfZ
        lPN/4q0bSZPeqP3kp0fKB/TC/07R7GrozvMxP+uzTIKmNmrfjkiPoaM06LmNKPIr
        QEo4Vfhz1MVSO+3iOkrQgr2saTM3zwawxi2FJrVCHHYiy5HfpRZNYaB/CHAp98xQ
        5IKTYnYrFKGBLKaanFFbm7gdjh5aaFqUqeq38CHSSqqKwiDGVktUlT/Keq20ewBf
        qdDM39e8WPWiQLqjbqMGInvPB/rCBaxTphqTAOzUAeeDxrPj0ibiGk0TMRuaCOTN
        +HHygzwyIj/Sd98FZF25ZGKfZe/VSrNM2S0hMxlKnpTx3GM5CWJzMOx4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=DiwHj+vaHXUQKXyQ9BUo+GIG90hR4W/o3+wsmuFsT8o=; b=eQnjtpS0
        TMgJuue4gg5PRYwwN4aTwiCyY8u0ftuBklXqUpF9HQqV60bSUqT41KfFwAObEza8
        A7g9LQUjlmboh/XNRXlUCGKctsBH3HWi2S7NZfgaHvdA3L691j5Gj2mnq9vlrdGm
        4VO19MyzDqRWWiNyqUNdg+h3SSLFueBFW1tAtu8gFBqjz8w4+LHG2Om6cotkbeRn
        d8n3ZUwHLQE4cTAU+CXKoC2YB4HqDAew/Nyv9gb35W22QAqQ+VNwvqjBto6yvMzt
        W44kLb6InjRL9ZuX/w29hkJc4vBvzlkWdeavdWJ6NOhA9OUA+L5Bcs9CHzSWRCyk
        Fo+7OhDEqfL+rQ==
X-ME-Sender: <xms:HIJhYTkvKG8Wlm6NAtlbI_LQRS4ndMQuuzoWuRRs0upEGlXEB2h9qg>
    <xme:HIJhYW1tC63-BTJy99oKdRy9wIO4ZfZ3aZRdzTv8qTzl6eDbMqEJ3yVfZnGtZBTEN
    JjgwZ3ksOTKntrEC9I>
X-ME-Received: <xmr:HIJhYZrdCVC-fNVcXwshEn6X4m4DU5d14rO-FzxLRGRyKE_9SG8kNhTE8zyni8Cw-Hvic4EUIFDTwwXOmrNgpHIWOEkfquaWg4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddtvddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetlhhishht
    rghirhcuhfhrrghntghishcuoegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
    eqnecuggftrfgrthhtvghrnhepffdthffggefglefgkeejhfekiefgleelfefhtefhheef
    teelgeeggefgfeffvddtnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishht
    rghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:HIJhYbkiJwzbZF8qJNpUY1vhJxxOdVJ0xBCCdPxQBYzTHtD0nJXTFw>
    <xmx:HIJhYR3DqwIxQRwz-VI5HE1lzQKMC2rKYIA8sY7mg_mpqJuyc6D1ew>
    <xmx:HIJhYau9EPrwWBuLSfdjAfplqNJ2qWpjwxmE_nozcZeHYbk4dxVreQ>
    <xmx:HYJhYSF9NB65qKLHyLEIX5G8y6yLlQX4bbbM-FOCwY2O1gGssKNxlA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Oct 2021 07:50:46 -0400 (EDT)
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
Subject: [PATCH v12 01/10] dt-bindings: mfd: Initial commit of silergy,sy7636a.yaml
Date:   Sat,  9 Oct 2021 21:50:20 +1000
Message-Id: <20211009115031.18392-2-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211009115031.18392-1-alistair@alistair23.me>
References: <20211009115031.18392-1-alistair@alistair23.me>
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

