Return-Path: <linux-pm+bounces-38505-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A30C82954
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 22:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B5C84E22B8
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 21:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2768132FA23;
	Mon, 24 Nov 2025 21:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKnRuBIF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B7632F772;
	Mon, 24 Nov 2025 21:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764021218; cv=none; b=gWn6jlJOmNjKkrivmtmqgDI2xTbxG/RJk97Td9d1MHhClnl+al3K/orLQ8pvwHPi9HfWqkII6BFMbyxiRK3es3lVUoYtOVp5BIFwrPz2P4Zoard+p7OIwgjvfmEBbpcuUn9vO1fmld3oZAKe6jsgxjF4A5aiMYADmqhNdtTMMFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764021218; c=relaxed/simple;
	bh=+pBsNNQtLItEUIogavMTQxGMrQEuwJbUHzlRDsNE40k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zc2qodGTZHp+YFESZMpnItQ72KkOwom5qipSlLEewvJuo3lvgBRkdzoHrF5gvpwWn/lcWBTmX1n35rzrWSw4TfPFQEEOdcbMTiYTAMv0mmI1ZAbpTannL5Aahr6vcU7OO41v4if43mM2p2TG8jJ8G4VfVSAOJEY/XDlkAaiBgAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKnRuBIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2CFD7C16AAE;
	Mon, 24 Nov 2025 21:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764021218;
	bh=+pBsNNQtLItEUIogavMTQxGMrQEuwJbUHzlRDsNE40k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sKnRuBIF3PYkOz+2iAEZyhzjtg1avtmxmy3W2REDYbKwD6jv33opqn6O6L/L7YtdX
	 /+Ja3XjbOMqLIaYfJuc0N0udXK8Bx8uIoZTDz3I9WX61NlJwflK132XqZ8VV3f6+1E
	 RMpAN2NppbZvS0LYi37vFgdEy0GrTYEizZvye8hyO4yloOW8Hu0BmHWRWiNzzXVy5f
	 N72Ul0YNM/I5t+sqSUuZHvbRSTf5HCiY8RDI/SmQBGorcpvvFb3QkxxpmNbnk7YhpH
	 mFtFpEuLNTDI6FplNTFC7cUrrHzjwwXGRu+bCYOuHvpU56d0vfqsPIn2DjyrwyFPPc
	 ymwqw501XAbiA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22151CFD35F;
	Mon, 24 Nov 2025 21:53:38 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Mon, 24 Nov 2025 22:53:34 +0100
Subject: [PATCH RFC 1/8] dt-bindings: power: supply: Add schema for
 Qualcomm pmi8998 fuel gauge
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251124-pmi8998_fuel_gauge-v1-1-dd3791f61478@ixit.cz>
References: <20251124-pmi8998_fuel_gauge-v1-0-dd3791f61478@ixit.cz>
In-Reply-To: <20251124-pmi8998_fuel_gauge-v1-0-dd3791f61478@ixit.cz>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Casey Connolly <casey@connolly.tech>, Joel Selvaraj <foss@joelselvaraj.com>, 
 Yassine Oudjana <y.oudjana@protonmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Alexander Martinz <amartinz@shiftphones.com>, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 Richard Acayan <mailingradian@gmail.com>, 
 Alexey Minnekhanov <alexeymin@postmarketos.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2537; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=8gDcJuVR00nr5ImU9LywPVZeG4RNmdnomhcdhAvXSQU=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBpJNPfKWxSxscYEJAYp0SZC4kEMTmRSgRMI64xj
 rQ01rKQLCGJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaSTT3wAKCRBgAj/E00kg
 cvywD/44kARU05lAFhs0AM2MeVjrNig/NHmW+MGYEYMB/NjjZhFdlAEW2mW3SDWCOVZsDI3D+GO
 vjP++xsbeZeNP71XrakQ2eVD1Qzzv4DQvbmIMAxUrutiJklsbsHss2jAJIAXFZ9mQ8BTXafGmQg
 5QHQ2IjNqg2FejoJfBEWUs0hs9+gYieJ9w15xoWpCG2WWa75wqRGfM5588iTYad1XgSRy/opK+9
 K6Hi5GAbCSNUR1QfAKTOeIty1pJYalKQ1AXHflttX2gghCqUHI533EC8LTC3D+TGzzQo2fB1h0B
 Ouz9Kwtp8FsrQCS3o9C2aPuKVBWkvxTr4yCL038A1IRWsgH6quQ7jGU0BU3Qgv8LuqdhTbdScb6
 4K6rYCnpgGiG5xGRJcMgYg8ZHdHURY+Z7I2MEbHeTq7n18KXos3oNf2DzVA+mRR2OP9ZQZWDqWC
 UyXIGTv4h4vA2TdD9cSB6WG3RYJqRf5IGCMIbk6ENdzDUuSzZmlgRKdi3nA1MFLQSAh3m3wqEtM
 4Qp/IQyP3ktpTg+EsrzHh+PY49I+eGXTWifdnXJAEZVgne2k44igHbNNEU7tKbmoQe1qRJSF4bT
 niN4FbblG68cu2nvm6tWzI2S28R5wT9HXcMRtyiBenjGRyMnVjuMfT7/pxQqU5tzHd/y3U8p1i6
 V8uLRsbV9ElYgvw==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: Yassine Oudjana <y.oudjana@protonmail.com>

Add a device-tree schema for Qualcomm PMIC 8998 fuel gauge.

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 .../bindings/power/supply/qcom,pmi8998-fg.yaml     | 77 ++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-fg.yaml b/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-fg.yaml
new file mode 100644
index 0000000000000..9acc1a7f04cda
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-fg.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-3-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/qcom,pmi8998-fg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm PMI8998 PMIC Fuel Gauge
+
+maintainers:
+  - Casey Connolly <casey@connolly.tech>
+  - Joel Selvaraj <foss@joelselvaraj.com>
+  - Yassine Oudjana <y.oudjana@protonmail.com>
+
+allOf:
+  - $ref: /schemas/power/supply/power-supply.yaml#
+
+properties:
+  compatible:
+    const: qcom,pmi8998-fg
+
+  reg:
+    maxItems: 1
+
+  monitored-battery:
+    description: |
+       phandle of battery characteristics node.
+       The fuel gauge uses the following battery properties:
+       - charge-full-design-microamp-hours
+       - voltage-min-design-microvolt
+       - voltage-max-design-microvolt
+       See Documentation/devicetree/bindings/power/supply/battery.yaml
+
+  interrupts:
+    items:
+      - description: State of charge change interrupt
+
+  interrupt-names:
+    items:
+      - const: soc-delta
+
+  power-supplies: true
+
+required:
+  - compatible
+  - reg
+  - monitored-battery
+  - interrupts
+  - interrupt-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    battery: battery {
+      compatible = "simple-battery";
+
+      charge-full-design-microamp-hours = <4070000>;
+      voltage-min-design-microvolt = <3400000>;
+      voltage-max-design-microvolt = <4400000>;
+    };
+
+    pmic {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      fuel-gauge@4000 {
+        compatible = "qcom,pmi8998-fg";
+        reg = <0x4000>;
+
+        interrupts = <0x2 0x40 0x4 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "soc-delta";
+
+        monitored-battery = <&battery>;
+      };
+    };

-- 
2.51.0



