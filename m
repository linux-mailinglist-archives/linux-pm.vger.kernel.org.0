Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F9A44C13C
	for <lists+linux-pm@lfdr.de>; Wed, 10 Nov 2021 13:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbhKJMcw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Nov 2021 07:32:52 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:40977 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229653AbhKJMcv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Nov 2021 07:32:51 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id D6C9658086C;
        Wed, 10 Nov 2021 07:30:03 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 10 Nov 2021 07:30:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=xPIOWPlEpcSPg
        VeMbUyqzIh0yquJ8UKRhzhIcmgwvNU=; b=vGFIeCbcjdwHw05iRAS3FQRI0E3Gg
        Rx2hyhmX6ExPgKIx81LSzYsmfVaR5wuOqz515OtweVEZsbfrjYW0dpY9DLtTjeCP
        9yr3gMPecNCczIOxyRMK7aMwNMke71sRP1XRSbjc/J6bdujIvn0pUq92J9jafz74
        +2gRR7BzA4LL7j3NmyY3XQBUN27Nl9loJ9LcZZ6zIAxg0XJzFNLLuQDpAcFjGXhL
        LjxTMta0AfF+BSyKYTyvse/YXqfHuj8uEcFw6alJUYZNzrCW2/1vasQWZQL1T+tP
        mtm4O+xSPxg9KnmpDZBjquZeKUOG8m/9AoX/mm1Cs2aWScJfTTW0SGy+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=xPIOWPlEpcSPgVeMbUyqzIh0yquJ8UKRhzhIcmgwvNU=; b=dcKRWJXD
        bi8qTwrHPoVvDQxbgtgcEtYijl46IUzPVSzM7bVAI6zOl9So1arSCPHIhDYSN4CS
        pfmhP0giK//p1sM0ZJhfyTCa7m/acfYOJZCQ+O4LuU708jJF/UkVq1E5jQg5GnGv
        BOrg2YjeEC/xg5CnG3dNvArCk040YKguXEsTuXFVApSMqqhXctZOamZousIjwMy0
        zrUWgXvUvcyFuUVqc0mWNP1BAF2EE+HYqr3/JPsR8W9ArEqT9wyqPuykDHEmZlt0
        LPKE17agECOZygyloLSk4K/+VZh01NhkJnOQEPcnBoZCEtWbsyQnH1eDJztoVnPb
        YJGHOMjefq35+Q==
X-ME-Sender: <xms:S7uLYX-0v77QUO-wn4XVfjpTnTZp_q1gcdtb06g6JGLFyCK9fsh5jQ>
    <xme:S7uLYTsQ1EJ6KBt6BJZevNsePMMPcmUbbixnJbNcE5vzJHwLTHdWjpBQXg5MxzgTA
    dHzp1yTKQEocsiZ9rk>
X-ME-Received: <xmr:S7uLYVBDpBKAM9TgiSyyxrMK_ptL3Xwcr45SjzaTY5cyKJfBPx0NNfOKyTdA2YWosu1OpijjlJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudejgdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihhsthgr
    ihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvqe
    enucggtffrrghtthgvrhhnpefftdfhgfeggfelgfekjefhkeeigfelleefhfethfehfeet
    leeggeeggfefffdvtdenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:S7uLYTf1DTeXv7RMXRoXl9uuxxgnSjmPUp2EmsiKzoq4h3XpUzYDqA>
    <xmx:S7uLYcOWOPhry-9676lOHiiGVfg9xrSh7tTbXSTunqMgmiQtkaIdrQ>
    <xmx:S7uLYVn_NR538xywvaMdRuaoBl95qm8vu5RNJuJkeDpn5JFK5bRHWw>
    <xmx:S7uLYZzqh73lHbZQCoVvRLBireNE0Izc7YASC7s6v8KrV8654k8B3Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Nov 2021 07:29:57 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, broonie@kernel.org, kernel@pengutronix.de,
        lgirdwood@gmail.com, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        s.hauer@pengutronix.de, linux-hwmon@vger.kernel.org,
        amitk@kernel.org, linux-pm@vger.kernel.org, linux-imx@nxp.com,
        alistair23@gmail.com, andreas@kemnade.info, shawnguo@kernel.org,
        Alistair Francis <alistair@alistair23.me>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v15 1/8] dt-bindings: mfd: Initial commit of silergy,sy7636a.yaml
Date:   Wed, 10 Nov 2021 22:29:41 +1000
Message-Id: <20211110122948.188683-2-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211110122948.188683-1-alistair@alistair23.me>
References: <20211110122948.188683-1-alistair@alistair23.me>
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

