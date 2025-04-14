Return-Path: <linux-pm+bounces-25387-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE45BA88984
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 19:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD69A174122
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 17:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1EA28937C;
	Mon, 14 Apr 2025 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="TqggJRxh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55BC289363;
	Mon, 14 Apr 2025 17:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744650909; cv=none; b=Wr2DZranBuG7qg35MS5sJ5bTCV3xkwvikMBa7J0JmFTTEzuljL7Z4POV/VJZrodTIcdlBSEZkbdWCH8dQhSdSb+fDS94SYFak+jZ3N9iDeKHqyPEV7doWa7bf/y3RxTqvEDSKZ4Yq1xn3eIx5tbZIZXTbvha4I0mLyWt2uCaH4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744650909; c=relaxed/simple;
	bh=1tnykXVOIjy28ixv03ltADMMvf8nQP4gS7WJ/VPSF8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L+jNItyokEN/stEQnvKszj6THyHG4Vr69WodHP2Hrbyx9I2k+I/0jx25vjefxwaV6IiiRR24ayA0xGZCQGxVo8pyCakFMV3PYO86k5q4xXVLJb4LJFDvaR3PzJsWYGbrGcuOuIgqiBSZ6a21EhiMouy9m2ZCb8PNLKew8ZfqWnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=TqggJRxh; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.corp.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id 53F1B1FBF4;
	Mon, 14 Apr 2025 19:15:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1744650903;
	bh=mrRrMAsS1CwfKQ814ULKC44LfgnTXIUp8qxdVDOCCSQ=; h=From:To:Subject;
	b=TqggJRxhsdSLGvyKKqCJFprJIQFZu2pKVrdFPdTAIFXIu0enR/loNvm/l3T1AwAlR
	 Dkk2uvOA9QgI2/l0LyRfQn5eWxQAhmc67+SfsHsDoE9xoFMPniND1zxldY8/FB+VxL
	 9Z0fwSjMvhQP6HIROJJEBdVoZelKA1urcaqpSfY63BOqXgFtFFWGqyhDAgIaaiwdfQ
	 nUsrefFIL/l17xOD+Tzc3yqyH+515LK+KYZw5iJW4ZiNONh1gv14TZoHJYWhhZnME9
	 5jSTyKDYY6JOhFBKIO3kwMcnJyqaUZILifp2pu463zHzlUEO9eYyjtMAID4I7R4LG6
	 9Wcy8aiyQwvLw==
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
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/2] dt-bindings: power: reset: add toradex,smarc-ec
Date: Mon, 14 Apr 2025 19:14:54 +0200
Message-Id: <20250414171455.155155-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414171455.155155-1-francesco@dolcini.it>
References: <20250414171455.155155-1-francesco@dolcini.it>
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
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
v2: fix commit message, add Reviewed-by: Conor
v1: https://lore.kernel.org/lkml/20250407114947.41421-1-francesco@dolcini.it/
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
index c59316109e3f..5ddb279436f8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24408,6 +24408,12 @@ L:	platform-driver-x86@vger.kernel.org
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


