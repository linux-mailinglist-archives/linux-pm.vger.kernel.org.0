Return-Path: <linux-pm+bounces-26995-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C61AB2728
	for <lists+linux-pm@lfdr.de>; Sun, 11 May 2025 10:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25439176238
	for <lists+linux-pm@lfdr.de>; Sun, 11 May 2025 08:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC11F1B21AD;
	Sun, 11 May 2025 08:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xdrd5F98"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7EC19ABB6;
	Sun, 11 May 2025 08:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746951549; cv=none; b=de+NEIyk3BKb+8aI19RAZeGfBTHrbmt7mKcvRz5kGzFuCYS8uodCnXxpg6ZP9c2JpvHCcCCeeTZ62ervtdzcKen+tTZ+WXaJkVSiavKUglsk2DLAJawrDqDr4d0VTbF4S7Mr1/BBqszMyXjcd9YhivZMOuvSbjwn4z9cua+vmc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746951549; c=relaxed/simple;
	bh=uWe8qh87ExX4KnWWAtN1zN7SlDbrD5p0GmXjI1WRNjM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Owtjkc1pRsPccv/W2fVNBUZ4HXb/WGzNGDsdSFtOsYhTP7zsTMIB9h0W4EqXrRW2JFTdoklSKrkVUlUQ6hj0tVr4O11HCFZtBs+v0CFAp90jF3PVHZ1FG5bW4T43ixePCZbMcc09Do55Y+DqbDkykmQ3Xp9q/nsF2GJ8CMkmfcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xdrd5F98; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B061C4CEE7;
	Sun, 11 May 2025 08:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746951549;
	bh=uWe8qh87ExX4KnWWAtN1zN7SlDbrD5p0GmXjI1WRNjM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Xdrd5F98QdisJFI7+dxM81+tnO+xPANtMDHX7DfRqAZjf7mcxtIxg91hNzOaEsxcv
	 FYnEYYzzOm6GCnMlCXWBG39X1qnqcCcxnNZyiagB5CSu4uqpsSdaYMKOLLVSSavxwC
	 FCOGnP6Elefl/doHGrmX8Y4uRhfYGQkOhuADh7fgaGycqrRsdEyJPVTwFY/H/Ya0wv
	 rtVMhNB2Z5ZI/C3jK5SKMwN58teZh/X9T2nhr5oesDff8imMifsFHbj9iWl+95DfOG
	 yYsvz2IX0aFy6D2smMGQ5zivsqSYlmgyViYyZhyyMpZY+KwRPNdI8udi9IwxScTrJl
	 IFL9rCObzsUrg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9EFC3ABCF;
	Sun, 11 May 2025 08:19:09 +0000 (UTC)
From: Sven Peter via B4 Relay <devnull+sven.svenpeter.dev@kernel.org>
Date: Sun, 11 May 2025 08:18:37 +0000
Subject: [PATCH v5 02/10] dt-bindings: power: reboot: Add Apple Mac SMC
 Reboot Controller
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250511-smc-6-15-v5-2-f5980bdb18bd@svenpeter.dev>
References: <20250511-smc-6-15-v5-0-f5980bdb18bd@svenpeter.dev>
In-Reply-To: <20250511-smc-6-15-v5-0-f5980bdb18bd@svenpeter.dev>
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
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3109; i=sven@svenpeter.dev;
 h=from:subject:message-id;
 bh=+4oM83Wg94VnBoHK+/rIFrK9rKEEbg6fWxXfUSzB4dk=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ4ZCbJFr6ptV3k1zWetSWlkZFSu7519k9rzlKeAZ+9RSw
 zqoVaKjlIVBjINBVkyRZft+e9MnD98ILt106T3MHFYmkCEMXJwCMJF+IUaGj+EdrEwTL93eef2H
 lmym9ZLoukc3vbxObyhldIx++T/zBCPDhLq7ETfuhsvUbHt5xWyb86zS7ff4J5327O9UeJngdV6
 NCQA=
X-Developer-Key: i=sven@svenpeter.dev; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@svenpeter.dev/default with
 auth_id=167
X-Original-From: Sven Peter <sven@svenpeter.dev>
Reply-To: sven@svenpeter.dev

From: Sven Peter <sven@svenpeter.dev>

On Apple Silicon machines a clean shutdown or reboot requires
talking to SMC and writing to NVMEM cells. Add a binding for
this MFD sub-device.

Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 .../bindings/power/reset/apple,smc-reboot.yaml     | 52 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 53 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/reset/apple,smc-reboot.yaml b/Documentation/devicetree/bindings/power/reset/apple,smc-reboot.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..e55e524914c2f57f7acf239fdefcbdc7a993b69f
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/apple,smc-reboot.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/reset/apple,smc-reboot.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple SMC Reboot Controller
+
+description: |
+  The Apple System Management Controller (SMC) provides reboot functionality
+  on Apple Silicon SoCs. It uses NVMEM cells to store and track various
+  system state information related to boot, shutdown, and panic events.
+
+maintainers:
+  - Sven Peter <sven@svenpeter.dev>
+
+properties:
+  compatible:
+    const: apple,smc-reboot
+
+  nvmem-cells:
+    items:
+      - description: Flag indicating shutdown (as opposed to reboot)
+      - description: Stage at which the boot process stopped (0x30 for normal boot)
+      - description: Counter for boot errors
+      - description: Counter for system panics
+      - description: Power management settings
+
+  nvmem-cell-names:
+    items:
+      - const: shutdown_flag
+      - const: boot_stage
+      - const: boot_error_count
+      - const: panic_count
+      - const: pm_setting
+
+required:
+  - compatible
+  - nvmem-cells
+  - nvmem-cell-names
+
+additionalProperties: false
+
+examples:
+  - |
+    reboot {
+      compatible = "apple,smc-reboot";
+      nvmem-cells = <&shutdown_flag>, <&boot_stage>,
+                    <&boot_error_count>, <&panic_count>, <&pm_setting>;
+      nvmem-cell-names = "shutdown_flag", "boot_stage",
+                         "boot_error_count", "panic_count", "pm_setting";
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index b53f3929b06006f9f38f5cda048516891c18c7ab..3f32d028ab49994a0da9f3882f37b9c3b183f5b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2281,6 +2281,7 @@ F:	Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
 F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
 F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
 F:	Documentation/devicetree/bindings/power/apple*
+F:	Documentation/devicetree/bindings/power/reset/apple,smc-reboot.yaml
 F:	Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
 F:	Documentation/devicetree/bindings/spi/apple,spi.yaml
 F:	Documentation/devicetree/bindings/watchdog/apple,wdt.yaml

-- 
2.34.1



