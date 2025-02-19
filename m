Return-Path: <linux-pm+bounces-22400-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A707EA3B9CF
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 10:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E88A3BE3CE
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 09:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BEB1E3779;
	Wed, 19 Feb 2025 09:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjGkec+B"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A1A1DED66;
	Wed, 19 Feb 2025 09:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739957226; cv=none; b=gi/b0KkI1VQPZcegca6ezXVhEIMWYGAuhAxfmCgb9fay4Rvr6LjePuqoFnFWLBMVqsJn0P3mY6H1bhmSeV0k1D64bL4thLULBFi9wgzyY0jLhKOB5GXP1fb/kZ3H7sxbbaU+oMff+vYn282ZwgFv0LW1M/ygz5a4foosr3t1c2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739957226; c=relaxed/simple;
	bh=OeRy+twmD8FQBSJGvaeeiPxoNoz0B9M0gaBTwQgybCY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HtdItYVxZ3zypPcwDJUygjXQHtSjXaq6SOWrPMW0oRL+qDrQFvrJikPTvpsvyGs9B7FwJQ1thKVhQVUuZ+M/s0PQkFnpyGFbKGZRVBsmGR1xUo3wm/45uadbAGhCTOfRaJWUF/qxLpmsjZYQL3xt1+q6qKgXn4/JQ+8iH8XEZXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjGkec+B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2629C4CEEE;
	Wed, 19 Feb 2025 09:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739957225;
	bh=OeRy+twmD8FQBSJGvaeeiPxoNoz0B9M0gaBTwQgybCY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mjGkec+BegjNPVeH4nLLQu2Df7U2/xK2EQ5ol62omqCHnq+eZHyiXyGM0297RY//g
	 dsONx4NR+fdBumU02JxpI4sTL8twIEP2AwzPRyPbm5k7MTbJ17gxw1sIl5b5p/tAT1
	 FJXc30jiC+r2D9HZCCgbGMWkVTy7qNwWwglLhzeweimYqQnkfAN5lLo5HKFgcOB0p4
	 NOXEYXA4VqHfzfccKM2dt6LOi2W50+xVQHWx+B2htKP9/qT25/h9FAVYbHePlUclLZ
	 +iq9tmIeviZO5MYnaLBQ6cXY90Le3fa+HnWUZGOl8t7zXhlfWtHC5Qyq8DzkOjXmRB
	 iklJ6w5Ns+mfA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82C2C021AA;
	Wed, 19 Feb 2025 09:27:05 +0000 (UTC)
From: Sasha Finkelstein via B4 Relay <devnull+fnkl.kernel.gmail.com@kernel.org>
Date: Wed, 19 Feb 2025 10:26:59 +0100
Subject: [PATCH 3/5] media: dt-bindings: Add Apple ISP
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-isp-v1-3-6d3e89b67c31@gmail.com>
References: <20250219-isp-v1-0-6d3e89b67c31@gmail.com>
In-Reply-To: <20250219-isp-v1-0-6d3e89b67c31@gmail.com>
To: Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-media@vger.kernel.org, imx@lists.linux.dev, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739957223; l=5702;
 i=fnkl.kernel@gmail.com; s=20241124; h=from:subject:message-id;
 bh=A9oH4JPrA84M2AIoue7FVKM9TwqTr7E5y+sVJjno88Q=;
 b=XBhltGV9upjAetievVsxuOOHOJqwjFWEQS4CcHPjb8inxvCNo5X/gTHoybc1LTAJ95fVKfZnn
 R/qqq4PjLRxAYmNoyZE26x0HUOU0QvIf2WDp0SQzmEyQYl5M+8cWoMF
X-Developer-Key: i=fnkl.kernel@gmail.com; a=ed25519;
 pk=aSkp1PdZ+eF4jpMO6oLvz/YfT5XkBUneWwyhQrOgmsU=
X-Endpoint-Received: by B4 Relay for fnkl.kernel@gmail.com/20241124 with
 auth_id=283
X-Original-From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reply-To: fnkl.kernel@gmail.com

From: Sasha Finkelstein <fnkl.kernel@gmail.com>

Add bindings for the ISP used with the webcam in Apple
ARM laptops.

Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
---
 .../devicetree/bindings/media/apple,isp.yaml       | 151 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 2 files changed, 152 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/apple,isp.yaml b/Documentation/devicetree/bindings/media/apple,isp.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..67d536b61851af30fcc5bc452a761138876c6b18
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/apple,isp.yaml
@@ -0,0 +1,151 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/apple,isp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: An ISP block used in Apple products
+
+maintainers:
+  - Sasha Finkelstein <fnkl.kernel@gmail.com>
+
+description:
+  The ISP in charge of webcams on ARM Apple laptops
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - apple,t8103-isp
+          - apple,t8112-isp
+          - apple,t6000-isp
+          - apple,t6020-isp
+      - const: apple,isp
+
+  reg:
+    items:
+      - description: ASC coprocessor control
+      - description: Peripheral to host mailbox
+      - description: General-purpose ASC IO registers
+      - description: Host to peripheral mailbox
+
+  reg-names:
+    items:
+      - const: coproc
+      - const: mbox
+      - const: gpio
+      - const: mbox2
+
+  iommus:
+    description: All 3 must be kept in sync
+    minItems: 3
+    maxItems: 3
+
+  interrupts:
+    maxItems: 1
+
+  power-domains:
+    minItems: 1
+    maxItems: 20
+    description: All necessary power domains. Driver will enable them in order
+
+  memory-region:
+    maxItems: 1
+
+  apple,dart-vm-size:
+    description: Supported device memory range
+    $ref: /schemas/types.yaml#/definitions/uint64
+
+  apple,platform-id:
+    description: Platform id for firmware
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  apple,temporal-filter:
+    description: Whether temporal filter should be enabled in firmware
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  sensor-presets:
+    additionalProperties: false
+
+    patternProperties:
+      '^preset[0-9]+$':
+        type: object
+
+        additionalProperties: false
+
+        properties:
+          apple,config-index:
+            description: Firmware config index
+            $ref: /schemas/types.yaml#/definitions/uint32
+
+          apple,input-size:
+            $ref: /schemas/types.yaml#/definitions/uint32-array
+            minItems: 2
+            maxItems: 2
+            description: Raw sensor size
+
+          apple,output-size:
+            $ref: /schemas/types.yaml#/definitions/uint32-array
+            minItems: 2
+            maxItems: 2
+            description: Cropped and scaled image size
+
+          apple,crop:
+            $ref: /schemas/types.yaml#/definitions/uint32-array
+            minItems: 4
+            maxItems: 4
+            description: Area to crop
+
+        required:
+          - apple,config-index
+          - apple,input-size
+          - apple,output-size
+          - apple,crop
+
+required:
+  - compatible
+  - reg
+  - iommus
+  - interrupts
+  - power-domains
+  - memory-region
+  - apple,dart-vm-size
+  - apple,platform-id
+  - apple,temporal-filter
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/apple-aic.h>
+    isp: isp@2a000000 {
+        compatible = "apple,t8103-isp", "apple,isp";
+        reg = <0x2a000000 0x2000000>,
+              <0x2c104000 0x100>,
+              <0x2c104170 0x100>,
+              <0x2c1043f0 0x100>;
+        reg-names = "coproc", "mbox", "gpio", "mbox2";
+        iommus = <&isp_dart0 0>, <&isp_dart1 0>, <&isp_dart2 0>;
+        interrupt-parent = <&aic>;
+        interrupts = <AIC_IRQ 246 IRQ_TYPE_LEVEL_HIGH>;
+        power-domains = <&ps_isp_sys>, <&ps_isp_set0>,
+                        <&ps_isp_set1>, <&ps_isp_set2>, <&ps_isp_fe>,
+                        <&ps_isp_set4>, <&ps_isp_set5>, <&ps_isp_set6>,
+                        <&ps_isp_set7>, <&ps_isp_set8>, <&ps_isp_set9>,
+                        <&ps_isp_set10>, <&ps_isp_set11>,
+                        <&ps_isp_set12>;
+        memory-region = <&isp_heap>;
+        apple,dart-vm-size = <0x0 0xa0000000>;
+        apple,platform-id = <1>;
+        apple,temporal-filter = <0>;
+
+        sensor-presets {
+            preset0 {
+                apple,config-index = <0>;
+                apple,input-size = <1296 736>;
+                apple,output-size = <1280 720>;
+                apple,crop = <8 8 1280 720>;
+            };
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index efee40ea589f70bc5e4a390072a4543234616743..dea7239ee0f5464b31efed5a2e0e5e602bcb6439 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2228,6 +2228,7 @@ F:	Documentation/devicetree/bindings/interrupt-controller/apple,*
 F:	Documentation/devicetree/bindings/iommu/apple,dart.yaml
 F:	Documentation/devicetree/bindings/iommu/apple,sart.yaml
 F:	Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
+F:	Documentation/devicetree/bindings/media/apple,isp.yaml
 F:	Documentation/devicetree/bindings/net/bluetooth/brcm,bcm4377-bluetooth.yaml
 F:	Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
 F:	Documentation/devicetree/bindings/nvmem/apple,efuses.yaml

-- 
2.48.1



