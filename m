Return-Path: <linux-pm+bounces-24875-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76112A7DCDE
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 13:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 825737A3BBE
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 11:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86861248864;
	Mon,  7 Apr 2025 11:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="sbQLoGrk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC90824503B;
	Mon,  7 Apr 2025 11:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744026597; cv=none; b=PtmQIik2x/gv3LC9KvCzjUovRkeQmK0Qo8MyvxZXWMmaH8JHFWoz4uGaNvKEHoCpD4gQAsAfh1oCLOYmx9QZvlEdZhACWu3z1djFNG6xxY4OHDRjM+oUzI67+jSAKrhtUhGXUkKAro/bnCCGkYugmODZ2zY4RcUaoXH0XqTkUtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744026597; c=relaxed/simple;
	bh=6YqIs5gviyNJ+KbHiarRRu4kyM66Ie18rjsKM3B8JKg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F+ylLKJxPNGBpZXymxhO7bWJm/IDvLONGFoxoI/53RtXuUF69uM9C+FOpG447k/aaX+R7LAEEo8WfJOIK2tbi7aR9nueV3tWjU5UkSYP5ODqwUVppHQwKVEQS5u1mRxlj5/hRPaIIG8CIUeeD8bWNpHlaEY4ybmUtNkqDrL66Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=sbQLoGrk; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 647311FC0A;
	Mon,  7 Apr 2025 13:49:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1744026592;
	bh=HD/1lth7KJ0DdObt1wm9UQQQCXtj18mBGj0Wbi0gW+c=; h=From:To:Subject;
	b=sbQLoGrkAFj4GVkDhVXjdc4K86QsHzvJnCZiTS0ukSaEsplh+IukOv41t5H46IW8F
	 VAxudnMg1zR3OQHG7dg8fc6HyY7H+3WY59Dmrp1VcRJSfIko53DM51pKu9OhXgHMs8
	 z3uB0/GNBqteL3BBDjUOQfFFLduB2HH/JRP1M0QH0mMiZ4UORU/X7gUvTH1bfXLvQj
	 L9pMwK8hbhzc0jpTJsvEMxQHB7m71VY0uftjejYbjC+kos/jQ5B+TrB9Gqt7I/UlYF
	 A61cc68NjcmQmLnynkcc8FG0HUZHC9Rf9GfSpic/g0Q5xvIZgGNJEwTSWH20Kp1RzN
	 AqSLSW+j0qayQ==
From: Francesco Dolcini <francesco@dolcini.it>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: firmware: add toradex,smarc-ec
Date: Mon,  7 Apr 2025 13:49:46 +0200
Message-Id: <20250407114947.41421-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407114947.41421-1-francesco@dolcini.it>
References: <20250407114947.41421-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

The Toradex Embedded Controller provides system power-off and restart
functionalities.
The two variants, SMARC iMX95 and SMARC iMX8P, have a compatible
I2C interface.
Besides this, different compatible values are defined to allow for
future implementation differences.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 .../power/reset/toradex,smarc-ec.yaml         | 52 +++++++++++++++++++
 MAINTAINERS                                   |  6 +++
 2 files changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/toradex,smarc-ec.yaml

diff --git a/Documentation/devicetree/bindings/power/reset/toradex,smarc-ec.yaml b/Documentation/devicetree/bindings/power/reset/toradex,smarc-ec.yaml
new file mode 100644
index 000000000000..ffcd5f2c2bf6
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/toradex,smarc-ec.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/reset/toradex,smarc-ec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Toradex Embedded Controller
+
+maintainers:
+  - Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
+  - Francesco Dolcini <francesco.dolcini@toradex.com>
+
+description: |
+  The Toradex Embedded Controller (EC) is used on Toradex SMARC modules,
+  primarily to manage power and reset functionalities.
+
+  The EC provides the following functions:
+    - Reads the SMARC POWER_BTN# and RESET_IN# signals and controls the PMIC accordingly.
+    - Controls the SoC boot mode signals based on the SMARC BOOT_SEL# and FORCE_RECOV# inputs.
+    - Manages the CARRIER_STDBY# signal in response to relevant SoC signals.
+
+  The EC runs a small firmware, factory programmed into its internal flash, and communicates over I2C.
+  It allows software to control power-off and reset functionalities of the module.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - toradex,smarc-imx95-ec
+          - toradex,smarc-imx8mp-ec
+      - const: toradex,smarc-ec
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        reset-controller@28 {
+            compatible = "toradex,smarc-imx95-ec", "toradex,smarc-ec";
+            reg = <0x28>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 96b827049501..e6903d2bb741 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24406,6 +24406,12 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/topstar-laptop.c
 
+TORADEX EMBEDDED CONTROLLER DRIVER
+M:	Emanuele Ghidoli <ghidoliemanuele@gmail.com>
+M:	Francesco Dolcini <francesco@dolcini.it>
+S:	Maintained
+F:	Documentation/devicetree/bindings/power/reset/toradex,smarc-ec.yaml
+
 TORTURE-TEST MODULES
 M:	Davidlohr Bueso <dave@stgolabs.net>
 M:	"Paul E. McKenney" <paulmck@kernel.org>
-- 
2.39.5


