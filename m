Return-Path: <linux-pm+bounces-14961-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E47A98A925
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 17:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B285E2828D3
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 15:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8F0192B90;
	Mon, 30 Sep 2024 15:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="mV+w+DFW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6BC1917F1;
	Mon, 30 Sep 2024 15:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727711655; cv=none; b=FWoxGG7XHV0jEkmhs1JrbAuchdLpGBTNl3sh4uzPdWDblAlwmqR70fVfKmFBVfHRP4It9Uu7o8krRa0uhDMR/Btsaxky7AE0hdp1YymIDoCqKBJbNvCuX1QntWovtX20zztKFVy67asb0fs9IGFh6DU0gm5xDVcCtRGPXThnaqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727711655; c=relaxed/simple;
	bh=uCw4sJgPTRrBhyyiV2rV4GSCNpacFw6LdJi+FM86SUs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ppCCTOC1qUdbSgTujU+wfP81wgxYL0ihnLadobb47o/jUfzCXWEO2BoxbwYsrPjI7OF8zZfQfZIByeU6x5qzKv70EYuwinNlhdQlhpKzUEqCGd3CfahJ3BjkPxvPBAzah8D6yauyXCvcbwRiGMBhAlnm/RXNwbJXwcldIJfJlmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=mV+w+DFW; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Lprc2mWe3wMlZf/u5ddBzzFHd5v6rZdCrc6ZZqNdG9A=; b=mV+w+DFW/aTFsxCREwnvcjhy0j
	kukBUpjvFdNYf6IwnA3ffFRK/IhhMKYjEH0QXQj1Tkip71bG/mmIAqJe2BRFHC59kvHq8k01ooYvm
	N4qOfHioiqkv98uwljBjEhKgqd/z1o7mwIMbjnfzM62esY+cFXm5q/Nfjq37dY1m39E5a1kgq05L1
	Tj0qVNCY+4J/EYuCxyL6J/2aS5cg5DTDSB604zjCrSa0cctsWpLCtDQqQWLQJjcnMY6oJFJKAzSGD
	GgxvMJEUvzAihsW3wGoE/oiwkwbEG2p8RhS72tgO6sAHKgW2jgTAVT6JTV1CNQQTUt5ZF/P6Ae5q3
	YGwJ77Og==;
From: Andreas Kemnade <andreas@kemnade.info>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	tony@atomide.com,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	devicetree@vger.kernel.org,
	Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2 1/3] dt-bindings: power: supply: Add TI TWL603X charger
Date: Mon, 30 Sep 2024 17:54:02 +0200
Message-Id: <20240930155404.1275702-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240930155404.1275702-1-andreas@kemnade.info>
References: <20240930155404.1275702-1-andreas@kemnade.info>
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
 .../power/supply/ti,twl6030-charger.yaml      | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/ti,twl6030-charger.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/ti,twl6030-charger.yaml b/Documentation/devicetree/bindings/power/supply/ti,twl6030-charger.yaml
new file mode 100644
index 0000000000000..fc604d8a469df
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/ti,twl6030-charger.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/ti,twl6030-charger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TWL6030/32 BCI (Battery Charger Interface)
+
+description:
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
+      - const: ti,twl6030-charger
+      - items:
+          - const: ti,twl6032-charger
+          - const: ti,twl6030-charger
+
+  interrupts:
+    items:
+      - description: Charger Control Interrupt
+      - description: Charger Fault Interrupt
+
+  io-channels:
+    items:
+      - description: VBUS Voltage Channel
+
+  io-channel-names:
+    items:
+      - const: vusb
+
+  monitored-battery: true
+
+required:
+  - compatible
+  - interrupts
+  - monitored-battery
+
+additionalProperties: false
-- 
2.39.2


