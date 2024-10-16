Return-Path: <linux-pm+bounces-15742-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D1D9A0397
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 10:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59A451C28271
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 08:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085FE1D5171;
	Wed, 16 Oct 2024 08:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="3hLQQjG2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590B21D514B;
	Wed, 16 Oct 2024 08:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729065811; cv=none; b=QkW2KRFOvEZhaWfS7DvpL6JQYCXcwTS5INy25sslEut27gZFErzq4ijfp/siOCinGdfqAHE50/QxP+76IsCjoZemT95Kd+jWFF3XTfJCENh774NOqJ7FsPPElZXDlPoaGLolXJndXbtFkEXBzud/Lzs9l50yQ4aloa/N+hlkPEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729065811; c=relaxed/simple;
	bh=XPng8doE9Qj+7g0BVLSwFlpUxkCTiQ2wJFS8zuO51xs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mfb9MavaKBAmqk31nUHMt8/Xlwn5sS5eytqXcrdq0TEn5v8QFK6hK/cKMfE9qYplxH5Ult5DYlNsPSMr452Sw3D1yXjoMdkCHCGuphBUZiNmz824GUHFTiNpf5GYXvrEMjLCSuzS/dvdl4sD3xYVf1Uw27aghGNSgzE4E9MDkt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=3hLQQjG2; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=+dJ97ivHNuSVoqD5oW9Fz/1QiIDk+GWOc7V0CKxc+5Q=; b=3hLQQjG24CKC63TZp0T4/sdcUz
	Ql84sckbEERl/25iPXYKoogltgXB8D8YcZDLv6JP+TF0XAzVzjxu1ZI+v6faoJ9HX0BqOJinpCP6S
	a1p6gjafMiSGT1+Fadh+ZWk8oa9xM6UIKkiW21UGERI+juU/tGcxhab/quBPXngj2+wmK8fGlQC2t
	kBKydlwLvPB1LBzig5BcwFqC3/g+/Qigtmj5ISupUJtiWKWPB9JQMW4KZI1BmRGDPz0HqewGEHXoD
	TgWnqAPr8LpUIv0WcXe3GWQpiz6BXt+f4jP/HqK12X0rHaQt9j7GsDZ2rQR0gfrM+bLyWfX1c0u91
	jKQZY3Kw==;
From: Andreas Kemnade <andreas@kemnade.info>
To: khilman@baylibre.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	tony@atomide.com,
	linux-omap@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/3] dt-bindings: power: supply: Add TI TWL603X charger
Date: Wed, 16 Oct 2024 10:03:12 +0200
Message-Id: <20241016080314.222674-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241016080314.222674-1-andreas@kemnade.info>
References: <20241016080314.222674-1-andreas@kemnade.info>
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


