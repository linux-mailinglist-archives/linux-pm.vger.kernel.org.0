Return-Path: <linux-pm+bounces-26615-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 803E8AA7FDE
	for <lists+linux-pm@lfdr.de>; Sat,  3 May 2025 12:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D283189F071
	for <lists+linux-pm@lfdr.de>; Sat,  3 May 2025 10:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E9E1E22FC;
	Sat,  3 May 2025 10:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsuMruyn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4688F1B3956;
	Sat,  3 May 2025 10:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746266836; cv=none; b=h2MK9kwg0gKetgpj2UxwGrQq3XNN8+QfVBctSGf4D6AJjw0qDceHMppz5d2TvDVjAvb5OeqUdav7H9S/lVdNHj1ME2JRqVWBIp7UZM6Gs9zGobKKpSm7w9mGPNvQI2touAKYgGNIS2kqTvYJ2sLTTWJamv4BEszNyBukBiJWpTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746266836; c=relaxed/simple;
	bh=lmuGJqrtlK6jtLh4M5WPn7eIxSCZjPMLV6QMWO6aX4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VZe63uSRwl179y2YNrtV+Clon5/O1bOFiy4cI9HhBRQR9cKzHefXPDxMuoCI/zDSuHLCdvxEBBF14JKfMwCGnXm8xPbsFlU2wK7IrBvdsW5pkkAP/ENRXIo7cn7HQzOr7qGvcoezDtC0PZDUqhn4mbuD7ZsNJxl8jdCUHK0sGME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsuMruyn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3FD1C4CEE9;
	Sat,  3 May 2025 10:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746266835;
	bh=lmuGJqrtlK6jtLh4M5WPn7eIxSCZjPMLV6QMWO6aX4g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bsuMruynfVEaqUB/4MULWEq7jyzt/KNvtIjqWb8paPtYO3bPPsNm10zQ9EozwAOzI
	 gXTUNIt49C8q8oOxf7rzTJncHJKR/fNU5In5TlcL0DaYFx7lNsS6hO7UuIQdRtmWVl
	 ToElnwjLB5Ka1VeQrK1MLswmCoCvFULvx7Fp+KKhyOgAyFsaBJGryrO+5n7iG2RUSw
	 miyJYaNWB57DS+xF9kRWuI5dtFlcJlEGodz+eZWmUNX7Xl7mWITI3+ogrHLA9ecwub
	 zy9apYfuYacnCrLq2mz2BCT52t+1LxsRMa6DlwI2TWtp+RihSD6x4csSkXPXXpume2
	 azShGmCHOZLUA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7399C3ABB7;
	Sat,  3 May 2025 10:07:15 +0000 (UTC)
From: Sven Peter via B4 Relay <devnull+sven.svenpeter.dev@kernel.org>
Date: Sat, 03 May 2025 10:06:49 +0000
Subject: [PATCH v4 2/9] dt-bindings: power: reboot: Add Apple Mac SMC
 Reboot Controller
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250503-smc-6-15-v4-2-500b9b6546fc@svenpeter.dev>
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
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3055; i=sven@svenpeter.dev;
 h=from:subject:message-id;
 bh=n/dAyQF+MHbfUNhqTnwgAGNCT95q0IoVEl/pbDNHSq8=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ4boq6PXxCWrKmf13G3X4Vi5a5Odl3FW+KtvXP9eBEo95
 hKf/HRjRykLgxgHg6yYIsv2/famTx6+EVy66dJ7mDmsTCBDGLg4BWAiLG8Z/gou76yyWqb7+bD3
 jeC35dLNHqyTFwjmlXywNM/6X9zLLsfw37lE7A/L5gkL56utnxLY0uHP+zN4Sqrnr4rjLNPf/dE
 sZwQA
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
index 7f91f0225133490607ba0d79ad4225892ef31a66..d85d9d9065db4dc5869788f8a81d9d9a425d7ce3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2282,6 +2282,7 @@ F:	Documentation/devicetree/bindings/nvmem/apple,spmi-nvmem.yaml
 F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
 F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
 F:	Documentation/devicetree/bindings/power/apple*
+F:	Documentation/devicetree/bindings/power/reset/apple,smc-reboot.yaml
 F:	Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
 F:	Documentation/devicetree/bindings/spi/apple,spi.yaml
 F:	Documentation/devicetree/bindings/spmi/apple,spmi.yaml

-- 
2.34.1



