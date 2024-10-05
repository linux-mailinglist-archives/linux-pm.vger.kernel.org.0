Return-Path: <linux-pm+bounces-15183-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D734C9914BE
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 08:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E6F71F237C0
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 06:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A6276036;
	Sat,  5 Oct 2024 06:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="OfODbaa6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F394085D;
	Sat,  5 Oct 2024 06:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728108318; cv=none; b=ADX7CXmBU6/Hkks6us6gMjM4aiwyVdUZLXXcna8NjfOvRVJ27dxefoVvw3SjqPOpK/5JbP4FlOg3aoy0AXVbYtMuz8MlQkIB9goimEtn8fQiN50aayN+pXd/nLtmZao+FEpRcBPXweC34q8mcUikKnNAVK/t0if4JNqdE2teZOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728108318; c=relaxed/simple;
	bh=XPng8doE9Qj+7g0BVLSwFlpUxkCTiQ2wJFS8zuO51xs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rKEPr9Jz5ainwuI6jhkFXcNhjIcVW+xUR6jCPeLNbiVEJ4pgWBA04JrTJR7Bwvlaou3J244fXZf+L1BcEnsM48IW2xkQo1Ech/ASbQrt3OYuqkhsNDTYD2FfrkdD3HeOdKtPc7sC5f0KxURGGMbGh13gE+RwE63a7SWPZf+x/zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=OfODbaa6; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=+dJ97ivHNuSVoqD5oW9Fz/1QiIDk+GWOc7V0CKxc+5Q=; b=OfODbaa6egnapi2js0seThZQ5G
	VXaQ6GJXFqTnsFMEwUK1C8AUywQgsiC1cKGilWdp7wwR2V+eDJTf6GZlA9yK9rtJGY2oK6XhcpDvy
	jaGfWGHdPYGnEB6j53AgMjaWKI+dMCmBYV1k0gEMbeFs0p3/gjPcS4PNpBimNoBLHc44FOPpePIXz
	tIJA2Bt1fuMQPKXm3jl/KJFRVP6uxTFYdWyxYwRtifgCbf/xmU0udzSYV4+MlKvDsll+kaKtxahUK
	ks28xcS7aQVJ163wAeHLxewTznFXbJ/jA2qU5gTTm3jkWGuk6ZfhNXX11uqBG1fSWjNJb9PSKHBDY
	rJQhD3tQ==;
From: Andreas Kemnade <andreas@kemnade.info>
To: Sebastian Reichel <sre@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	tony@atomide.com,
	linux-kernel@vger.kernel.org,
	khilman@baylibre.com,
	linux-pm@vger.kernel.org,
	linux-omap@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Cc: Andreas Kemnade <andreas@kemnade.info>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/4] dt-bindings: power: supply: Add TI TWL603X charger
Date: Sat,  5 Oct 2024 08:05:08 +0200
Message-Id: <20241005060511.1334049-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241005060511.1334049-1-andreas@kemnade.info>
References: <20241005060511.1334049-1-andreas@kemnade.info>
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


