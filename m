Return-Path: <linux-pm+bounces-14395-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7E897B984
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 10:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49DFA1F266A2
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 08:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2DC178377;
	Wed, 18 Sep 2024 08:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="nc5jIo7F"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672ED172BDE;
	Wed, 18 Sep 2024 08:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726648905; cv=none; b=WJ+bEmA7UjeTRCvaVZ/o/DypoTpEb5vhfS/qzDmFmchM70095tPAD7zkrzZ91DwovPUC5QJDImWZuNYrk1F+Ma6KGVrSgtuCDJwlMzkNe9KY/dCQX6rDm9O5NlruK3THdIyLGaEMWlQdjerJDw0MiBBwGZzIBqVGzsRtH6sDgkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726648905; c=relaxed/simple;
	bh=W4opFcAyGJt+gVGAPhpqKO5birJKF1iz2gTMT2IzV7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aRgyVnqww+cSm3f3MpkzWo67gvWztKPA+KtyfDsO4+S8zNjtV//RkZ0X8qdTm4qoNVWD1Ayn9bE9FiepMOEx/AwezrZcpa/oXjr4bRSkuqhH60RtrxTGKm4XKFZsZUxHK4npA62k7YsN7mA4LmqXcoJyDBBmnn6QkFwISqDmXfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=nc5jIo7F; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=9mMztIRsqDKVxJSygzTSR8PjswT/not/4ik7gtz/nXw=; b=nc5jIo7FZghcMHfCkRjdpgnLeh
	GN576dVHJ2yscCze/wKqc9DoueJmJan4OpyqqUPBCOR3Flxc3Rsg4We5puspGQkPk1WeJzRj/0H2n
	J7ItQY4cp/3ooykXf9K6VT3aekJrgTgsl55plLHHN5NjS8KXOn4OESRHRXcKaVnyWP4PrFyBYP/nv
	BazT+pg6Nl3+fCP+FSKwGL8gobiehYZTLVWSXaIsXZ9Bgw0y3FClFlHqwDjfzy027UdApBwyNMpik
	yBDosVddBmpRqdQBccNLkSXlh+HNcWT4z5uI3+ZGIQqJm6sxZNAEE2Nwi7dKLKbJXeZ8cCiC9ncKv
	AUjgCUoQ==;
From: Andreas Kemnade <andreas@kemnade.info>
To: tony@atomide.com,
	Sebastian Reichel <sre@kernel.org>,
	linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 1/3] dt-bindings: power: supply: Add TI TWL603X charger
Date: Wed, 18 Sep 2024 10:41:30 +0200
Message-Id: <20240918084132.928295-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240918084132.928295-1-andreas@kemnade.info>
References: <20240918084132.928295-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a fallback compatible since for especially for generic
defensive setup of parameters, both 6030 and 6032 are the same and
U-Boot actually uses a generic 6030/32 function to enable the
charger.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 .../power/supply/ti,twl6030-charger.yaml      | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/ti,twl6030-charger.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/ti,twl6030-charger.yaml b/Documentation/devicetree/bindings/power/supply/ti,twl6030-charger.yaml
new file mode 100644
index 0000000000000..fe0fe9a78761c
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/ti,twl6030-charger.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/ti,twl6030-charger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TWL6030/32 BCI (Battery Charger Interface)
+
+description: |
+  The battery charger needs to be configured to do any charging besides of
+  precharging. The GPADC in the PMIC has to be used to get the related
+  voltages.
+
+maintainers:
+  - Andreas Kemnade <andreas@kemnade.info>
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: "ti,twl6030-charger"
+      - items:
+          - const: "ti,twl6032-charger"
+          - const: "ti,twl6030-charger"
+
+  interrupts:
+    minItems: 2
+    maxItems: 2
+
+  io-channels:
+    items:
+      - description: VBUS Voltage Channel
+
+  io-channel-names:
+    items:
+      - const: vusb
+
+  monitored-battery:
+    description:
+      phandle of battery characteristics devicetree node
+
+required:
+  - compatible
+  - interrupts
+  - monitored-battery
+
+additionalProperties: false
+
+examples:
+  - |
+    pmic {
+      bci {
+        compatible = "ti,twl6032-charger", "ti,twl6030-charger";
+        interrupts = <2>, <5>;
+        io-channels = <&gpadc 10>;
+        io-channel-names = "vusb";
+        monitored-battery = <&bat>;
+      };
+    };
-- 
2.39.2


