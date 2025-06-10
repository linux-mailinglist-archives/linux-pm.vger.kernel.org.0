Return-Path: <linux-pm+bounces-28397-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4BEAD3E6C
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 18:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E724D165228
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 16:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3666A241116;
	Tue, 10 Jun 2025 16:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUx/WFc+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E667C23C50E;
	Tue, 10 Jun 2025 16:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749571840; cv=none; b=uYcAI/MOcPq+sAc8RWbB2isQKl2pQLklehvLYcajXNbrcTdDEkVplSqMMiM+GXoSz6Zqa0hMYbHo5h7Zz84T6+MEgsOwy6+mE5cO62BOfgVt+j5W8QoPQE+7udhg4Zuwedz/UjzfRZNUlJUkDhZKE/aXMBotfCkPpcDOM1Q4bhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749571840; c=relaxed/simple;
	bh=QLsFhzpHRYmA1ajW0KypVDBYFMUVDXC7AICzYhpICrc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZMx+xRlkzfLjpUmXi+I6ZnWY0vVQgtngIQMTnskoVPSDD3oEDCrCMqdmFXFNRw3l6SnAPsxqDsd4D7keBTVBrA7IZu9XwE6JIyqwCm/h6SzFnGRF6WwYx7rTHEoKScHzMXdjg9rn2LHoiEpHKqc8QA+knlML6zx3lGuz12lv12U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUx/WFc+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67FAFC4CEF2;
	Tue, 10 Jun 2025 16:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749571839;
	bh=QLsFhzpHRYmA1ajW0KypVDBYFMUVDXC7AICzYhpICrc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OUx/WFc+WeDHtK2TSCOwJd4TFXkbevR7wu9y4wrq1Do1CL5Rx8TPQGaVScpPfEmCJ
	 jE92dmiY0qOXWKxjbrc4evGQPiaryiwQbiK46SbROpGEqh+WhbHLoem74q1TTrI0e0
	 FcSHByHErtFeuP2otQ4kV5GzwZ5krv4NFKDRbqWlMwtl0VpDJ1hAOy0j7lYoWk3qS1
	 7KEj/rQdficA6VFps3Z5gqeohrFoFPcTNmTz11EmrNorUU5zjD3LxOC29WTT1/8ZgN
	 yqR2V6nxkn1GqfD0rLkVa5XHhCFDBWb8U5zAdAGfuHOsTDjgMcSL3cRD8EP+LNizuf
	 BkWdFBrQiPd9Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579BFC677C4;
	Tue, 10 Jun 2025 16:10:39 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Tue, 10 Jun 2025 15:29:43 +0000
Subject: [PATCH v7 02/10] dt-bindings: power: reboot: Add Apple Mac SMC
 Reboot Controller
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-smc-6-15-v7-2-556cafd771d3@kernel.org>
References: <20250610-smc-6-15-v7-0-556cafd771d3@kernel.org>
In-Reply-To: <20250610-smc-6-15-v7-0-556cafd771d3@kernel.org>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2766; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=QLsFhzpHRYmA1ajW0KypVDBYFMUVDXC7AICzYhpICrc=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ4aHf9Hn32suSFhNTdyT4XxIdtv/vq9WUZ8t3ito7c3md
 lU8sWtRRykLgxgHg6yYIsv2/famTx6+EVy66dJ7mDmsTCBDGLg4BWAiS1YyMrxafbupQ+HVTJml
 H3eWNJ/Z/VrT3bPr9/6dTx+WvvJMkMpnZFiwed2Gbx5mE+9u3arxZd6EnX5xrZFzvSarHTncdlh
 ymhIfAA==
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

On Apple Silicon machines a clean shutdown or reboot requires
talking to SMC and writing to NVMEM cells. Add a binding for
this MFD sub-device.

Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Sven Peter <sven@kernel.org>
---
 .../bindings/power/reset/apple,smc-reboot.yaml     | 40 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 41 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/reset/apple,smc-reboot.yaml b/Documentation/devicetree/bindings/power/reset/apple,smc-reboot.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..ce5ed88493cdb60bfc8b444cd9e1d36714890ffe
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/apple,smc-reboot.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/reset/apple,smc-reboot.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple SMC Reboot Controller
+
+description:
+  The Apple System Management Controller (SMC) provides reboot functionality
+  on Apple Silicon SoCs. It uses NVMEM cells to store and track various
+  system state information related to boot, shutdown, and panic events.
+
+maintainers:
+  - Sven Peter <sven@kernel.org>
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
+
+  nvmem-cell-names:
+    items:
+      - const: shutdown_flag
+      - const: boot_stage
+      - const: boot_error_count
+      - const: panic_count
+
+required:
+  - compatible
+  - nvmem-cells
+  - nvmem-cell-names
+
+additionalProperties: false
diff --git a/MAINTAINERS b/MAINTAINERS
index 68097b1a44251b076bfd55cc07cffa5d0e3e83c5..1dd004f7dff669e3a3609e5f1702887129d8ff35 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2346,6 +2346,7 @@ F:	Documentation/devicetree/bindings/nvmem/apple,spmi-nvmem.yaml
 F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
 F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
 F:	Documentation/devicetree/bindings/power/apple*
+F:	Documentation/devicetree/bindings/power/reset/apple,smc-reboot.yaml
 F:	Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
 F:	Documentation/devicetree/bindings/spi/apple,spi.yaml
 F:	Documentation/devicetree/bindings/spmi/apple,spmi.yaml

-- 
2.34.1



