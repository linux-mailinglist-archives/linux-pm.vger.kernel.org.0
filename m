Return-Path: <linux-pm+bounces-789-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFE5808699
	for <lists+linux-pm@lfdr.de>; Thu,  7 Dec 2023 12:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C07D1C21F61
	for <lists+linux-pm@lfdr.de>; Thu,  7 Dec 2023 11:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8E537D33;
	Thu,  7 Dec 2023 11:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b="AFiJP5ce"
X-Original-To: linux-pm@vger.kernel.org
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B1CFA;
	Thu,  7 Dec 2023 03:21:44 -0800 (PST)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id 3273242BF5;
	Thu,  7 Dec 2023 16:21:31 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1701948091; bh=OVug0fcHzBuiMohyozxqFLLN6RaBpXIu8wb22geRV3k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AFiJP5cesn6C0ry0Vs93cSIjOwvMQcr7q+77X71CT35XVWok2Tf8pn14LSUocbdRI
	 qHm2rR2h4gr5tVoDk0GbSBCl64Ovkc/BiScBEtrIgfSj9ze3mbws0PwXJYlzSWF2IF
	 Qa4t6NWZY9XgL7ilDD0IKpc86o1qjfTGZ6sCfDe0yXGWAIAjOmIgvD+73+SZ2hjcp9
	 oxgn+hgPq5PEzmd6CywNQyWtnEuv2ZTL39Zd57tWGVhhiADcjxDra9L+rpHA4Vakk+
	 8k6wn3Rsvs2TPieBLccbjCPBAQ3BbIXyTKk2LsW5RrMnAwfXb2rA9bu2E0bjvYuvUM
	 zsn+lp+L7UKtQ==
From: Nikita Travkin <nikita@trvn.ru>
Date: Thu, 07 Dec 2023 16:20:14 +0500
Subject: [PATCH 1/3] dt-bindings: power: supply: Add Acer Aspire 1 EC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231207-aspire1-ec-v1-1-ba9e1c227007@trvn.ru>
References: <20231207-aspire1-ec-v1-0-ba9e1c227007@trvn.ru>
In-Reply-To: <20231207-aspire1-ec-v1-0-ba9e1c227007@trvn.ru>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2421; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=OVug0fcHzBuiMohyozxqFLLN6RaBpXIu8wb22geRV3k=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBlcaq409/BVxOnfWYZ+z1ZJYYE8Xc6MJ6xU1cIP
 lBvSsE9U5GJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZXGquAAKCRBDHOzuKBm/
 df6zEACse1aIpU1mRX3tSoIe5Y7M3NMqOpxe8iJhp1i0mB0m2vom80/IwOYuNMp4MmMxwFhh7H0
 yKC2PsrMXliSFKX/50RruA7mealm3XHgGoI3L+t3ZOSo3HCbiOTGgqUH4HTe/uqzsX/N0HoY07q
 QRwLTlFXppYc1+cCw1b2175ICR3Al1qvSBOJRm0YeyVW0A3XabyrwbC3PbjGEXt6rL+SWIt+7Hl
 9q8+z++PhgP2RNJq3KeY02CrrFqViPCgabDzjWXWlcDHkgc/pSSlKWge+WGi9Smr8tfBqb/2rir
 JkGAPwr6ocvAMctcWXgxLz6ZbEqQsiaMY3Ns7OF5T/XyUTPNWpaeY7ray5JMpiBhUPw70yVzJrs
 e4pZtwwcZq9iECrHG4piUUvncMBA/JlrGuxRsrr94dX5Io3hKqk3xvI3+T7oHMB/f769d24R+SG
 cxLcEzrMfRPf3mPstaIOy+sb/A2CN+WkZnOY6PtTP+E94O2TekkSZW+IzxtX6SsNJ149yqoqeZS
 8YTfLdRSa9gAXpW1+NxhpjabNBn/OC1Iy9W3xSkmU3i85fPR67LTli8AwDDx3CW3HLpPiFkc5lL
 yv+/vJ2IUcT0Zw4p5cMho9ANgYebeGhX/K98Po+6flMdUX7AgB+W27Dgj/aigHF4q7u6+Atxo5O
 WpbpKiiEWMUnqcQ==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75

Add binding for the EC found in the Acer Aspire 1 laptop.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 .../bindings/power/supply/acer,aspire1-ec.yaml     | 73 ++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/acer,aspire1-ec.yaml b/Documentation/devicetree/bindings/power/supply/acer,aspire1-ec.yaml
new file mode 100644
index 000000000000..3fc6dea7fa5c
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/acer,aspire1-ec.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/acer,aspire1-ec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Acer Aspire 1 Embedded Controller
+
+maintainers:
+  - Nikita Travkin <nikita@trvn.ru>
+
+description:
+  The Acer Aspire 1 laptop uses an embedded controller to control battery
+  and charging as well as to provide a set of misc features such as the
+  laptop lid status and HPD events for the USB Type-C DP alt mode.
+
+properties:
+  compatible:
+    const: acer,aspire1-ec
+
+  reg:
+    const: 0x76
+
+  interrupts:
+    maxItems: 1
+
+  acer,media-keys-on-top:
+    description: Configure the keyboard layout to use media features of
+      the fn row when the fn key is not pressed. The firmware may choose
+      to add this property when user selects the fn mode in the firmware
+      setup utility.
+    type: boolean
+
+  connector:
+    $ref: /schemas/connector/usb-connector.yaml#
+
+    properties:
+      reg:
+        maxItems: 1
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |+
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        embedded-controller@76 {
+            compatible = "acer,aspire1-ec";
+            reg = <0x76>;
+
+            interrupts-extended = <&tlmm 30 IRQ_TYPE_LEVEL_LOW>;
+
+            connector {
+                compatible = "usb-c-connector";
+
+                port {
+                    ec_dp_in: endpoint {
+                        remote-endpoint = <&mdss_dp_out>;
+                    };
+                };
+            };
+        };
+    };

-- 
2.43.0


