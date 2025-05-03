Return-Path: <linux-pm+bounces-26612-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 221B4AA7FD8
	for <lists+linux-pm@lfdr.de>; Sat,  3 May 2025 12:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF572189E6C1
	for <lists+linux-pm@lfdr.de>; Sat,  3 May 2025 10:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7991DF98B;
	Sat,  3 May 2025 10:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYVtCN7W"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4677C1A8403;
	Sat,  3 May 2025 10:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746266836; cv=none; b=MAUUSVmC1O1greFSA4HRlwOKxkhWfAFDrZIKmv16wesTuUK4DWnMIiTE2qsmCNx5KkJ4LwFEKXzqWtbmpyZPRx4cf2hcyvQEaYiekhZnXdPkqA4/pttMQ65aOQf0GXp04Yx8k7ZpFRJJi6AmQjLoaoNOHeZibiXKp7QffFF2x5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746266836; c=relaxed/simple;
	bh=FCj41YuS83lubvQ4sTVq20svbkJeutFtiBUdO/qgxJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m1Utqyv4ag5+ZfLxnMswNx8Y5COi2UYoWadMo9tSYuZFpmwHw8z1XLiTEV0jokzsxqtE5/IIshBhopBYN5jynt/l0v3Ma3j/wKsjA/wX7/2PO3agb7f3w2Yoczg1TuQklAKBh7WNy+zxmjGRtjctydzI8op3gcMegzKr9lIKN5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYVtCN7W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1EF5C4CEF2;
	Sat,  3 May 2025 10:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746266835;
	bh=FCj41YuS83lubvQ4sTVq20svbkJeutFtiBUdO/qgxJc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=aYVtCN7W4K++duwoGczZfIvcv4H17huF7MKXqW1kDVi9fJnbFYZ8w4bljXz1YPxY1
	 OTBwYeHV27gprbXlS0gQHZzBx0Pat35veBQG0tyzq1OlfQOnm+pmxpyMt0Q7jB2FSk
	 NS1j+yp1QP3wTdm+s2tQgJFHfjboxb+SiJXHgoZzpXrOB/C9+01e/q08j6b5Dk3RPX
	 HZIcNaRl9bL2oIhPybTCUkJzUxSteFZKAX2sz7QnJSnv8VZJF6zY4ffVlZ1iolH/2h
	 hNs8ebMj4xwDLCPX7cuCwgmw0Kl7s5IVChTQZHulYQ3BJa1z1+5EVOUxM/AcvCMAII
	 PLLFj3tA8EVTQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C429BC3ABB8;
	Sat,  3 May 2025 10:07:15 +0000 (UTC)
From: Sven Peter via B4 Relay <devnull+sven.svenpeter.dev@kernel.org>
Date: Sat, 03 May 2025 10:06:50 +0000
Subject: [PATCH v4 3/9] dt-bindings: mfd: Add Apple Mac System Management
 Controller
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250503-smc-6-15-v4-3-500b9b6546fc@svenpeter.dev>
References: <20250503-smc-6-15-v4-0-500b9b6546fc@svenpeter.dev>
In-Reply-To: <20250503-smc-6-15-v4-0-500b9b6546fc@svenpeter.dev>
To: Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Hector Martin <marcan@marcan.st>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 Lee Jones <lee@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3091; i=sven@svenpeter.dev;
 h=from:subject:message-id;
 bh=g5ICObcHrqmqje6IzUss8WgmYFLH5P7pKOHUdmrLAhA=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ4boq+PztK3ON3yI529a18uZtTXwzw2+Mw6x5kFGX19Pe
 PFun+TLjlIWBjEOBlkxRZbt++1Nnzx8I7h006X3MHNYmUCGMHBxCsBElDQZGR5/+8p24hhjemWO
 9ws5gxnaS5vnipilxe/ZwsBQ+Wz3z30M/5Pr9aU2bgx1WtEfdO5JwmOr+BN//y//pZK7LyBofea
 1BRwA
X-Developer-Key: i=sven@svenpeter.dev; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@svenpeter.dev/default with
 auth_id=167
X-Original-From: Sven Peter <sven@svenpeter.dev>
Reply-To: sven@svenpeter.dev

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

Add a DT binding for the Apple Mac System Management Controller.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 .../devicetree/bindings/mfd/apple,smc.yaml         | 71 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 72 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/apple,smc.yaml b/Documentation/devicetree/bindings/mfd/apple,smc.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..9f1058c15bbf62d84f8a72fdaa354909b02e2801
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/apple,smc.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/apple,smc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple Mac System Management Controller
+
+maintainers:
+  - Sven Peter <sven@svenpeter.dev>
+
+description:
+  Apple Mac System Management Controller implements various functions
+  such as GPIO, RTC, power, reboot.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - apple,t6000-smc
+          - apple,t8103-smc
+          - apple,t8112-smc
+      - const: apple,smc
+
+  reg:
+    items:
+      - description: SMC area
+      - description: SRAM area
+
+  reg-names:
+    items:
+      - const: smc
+      - const: sram
+
+  mboxes:
+    maxItems: 1
+
+  gpio:
+    $ref: /schemas/gpio/apple,smc-gpio.yaml
+
+  reboot:
+    $ref: /schemas/power/reset/apple,smc-reboot.yaml
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - mboxes
+
+examples:
+  - |
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      smc@23e400000 {
+        compatible = "apple,t8103-smc", "apple,smc";
+        reg = <0x2 0x3e400000 0x0 0x4000>,
+               <0x2 0x3fe00000 0x0 0x100000>;
+        reg-names = "smc", "sram";
+        mboxes = <&smc_mbox>;
+
+        smc_gpio: gpio {
+          compatible = "apple,smc-gpio";
+          gpio-controller;
+          #gpio-cells = <2>;
+        };
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index d85d9d9065db4dc5869788f8a81d9d9a425d7ce3..2c16b2fc3fec76104967530f487123485af1e777 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2275,6 +2275,7 @@ F:	Documentation/devicetree/bindings/iommu/apple,dart.yaml
 F:	Documentation/devicetree/bindings/iommu/apple,sart.yaml
 F:	Documentation/devicetree/bindings/leds/backlight/apple,dwi-bl.yaml
 F:	Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
+F:	Documentation/devicetree/bindings/mfd/apple,smc.yaml
 F:	Documentation/devicetree/bindings/net/bluetooth/brcm,bcm4377-bluetooth.yaml
 F:	Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
 F:	Documentation/devicetree/bindings/nvmem/apple,efuses.yaml

-- 
2.34.1



