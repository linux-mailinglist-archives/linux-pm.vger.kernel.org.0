Return-Path: <linux-pm+bounces-15272-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C58993061
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 17:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4A3D28D0FA
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 15:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69C91D88C4;
	Mon,  7 Oct 2024 15:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="U7Gj/j6Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222CE1D88B9;
	Mon,  7 Oct 2024 15:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313287; cv=none; b=t6LJvZw3l3scK/ikjuFWh4lMHHCGfVbz/tfZAJPVrTXc8FO9TqbH9y5vsKEQAT4J3FwYR1CRUR7NvaXIpK3KvTgZ8D6mrHSmi7UMWJlIZjrbyMfefegTdnvY3XkKPAeAwsH0egpIp8URMtrvberhJ+30vjIArqC8xBusJaWwE/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313287; c=relaxed/simple;
	bh=XPng8doE9Qj+7g0BVLSwFlpUxkCTiQ2wJFS8zuO51xs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CSpAB+5w+15SxVG0w1vK+RLrtI/0D4CaQ9bFYPzDRaPAkkUOEJR9WCFPGN4f0v8lJr9WNL0eSJgETWvGMDHBz+zgevakNhmNCMnl4zh3Tie0sznmXDqCdLSkfLtK/EFCtELyT02pooyw56jN15Km5gLKZKvdOEQdsmbxmZWczJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=U7Gj/j6Y; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=+dJ97ivHNuSVoqD5oW9Fz/1QiIDk+GWOc7V0CKxc+5Q=; b=U7Gj/j6Y5r0OT77+Ipim1lxP6m
	HXiCPO6hGD06wxfRaNnmqJ7L56JsEHspqfkreMD7tA7DcD0A4rcS1LZWOkkBIbR/ju+MijI6D5Pc5
	xtUFVfCpxTuh0EVEmo5rGaLyDnv6GJ6JqhxzxELkClwlhGDk3p0r3En73+Tl2Klv84dlB6EOqW64v
	P/NmtqdeECSxOsyocN4/GJzBSDgqmoNusxlt+tR3w52xqUiXuZMlpcK34slzU5rqJH74Wu9m9Npzz
	k0g/peMuog5FpFREU3BvYY/DUbY76rAyaG6LYDhb7rI2EL0os6NblYnORBLOGmFjNRiIEelxtLbI0
	UmebeC9A==;
From: Andreas Kemnade <andreas@kemnade.info>
To: devicetree@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org,
	tony@atomide.com,
	Rob Herring <robh@kernel.org>,
	linux-pm@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	khilman@baylibre.com,
	linux-omap@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>
Cc: Andreas Kemnade <andreas@kemnade.info>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/4] dt-bindings: power: supply: Add TI TWL603X charger
Date: Mon,  7 Oct 2024 17:01:17 +0200
Message-Id: <20241007150120.1416698-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241007150120.1416698-1-andreas@kemnade.info>
References: <20241007150120.1416698-1-andreas@kemnade.info>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


