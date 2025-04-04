Return-Path: <linux-pm+bounces-24787-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB825A7B657
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 05:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E109F17909A
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 03:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FED91B4242;
	Fri,  4 Apr 2025 03:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/nOEnzC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7441B4227;
	Fri,  4 Apr 2025 03:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743735601; cv=none; b=Lg3oTMW5gJeOr1/5/H/fAW0m+zInYbnxl1yXOcM2Fm8J2esnPNtj53zrMyzus9gWfEGlu5FFH87PAP4oV0xCmX2glcxAOG9f1ZZ9t1vgPh+yShNyxDElR4vyUhl3wFcT0JwBAd+tLhRSZUqW0gK2V8H3qFsjh4t8fA3uYpcg1Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743735601; c=relaxed/simple;
	bh=jooiBRiLZ5KXTeX7sTZYMvh719V+Qu5vq1GtZM6CWWA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qK+danf0uib9EwofYbky4KPao56Q3d0GfI4IUz4IM2d6r1cp7qv5ell5h9fs1+Gmi1KyDuX3Gpt495eJ4ite4Vuz7ACd7l4lyIkVwHRso7OliOhZgG0RJJLC0fHRlnTjieZtJujnO1e1bnwtjIlxCotwiZDganGUx7B81yXgVQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/nOEnzC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4003C4CEE3;
	Fri,  4 Apr 2025 02:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743735600;
	bh=jooiBRiLZ5KXTeX7sTZYMvh719V+Qu5vq1GtZM6CWWA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g/nOEnzC90yU3P0Hon/50j7bjUU/KNblbpYe76syN5W2QOwwzzoNvatmCdI8LKjVB
	 GXztCu4IL/A0IORZ4wEe5qoYTPu5Pg2qdTI/GADX2IpCtl7Qlq3BQHZO/zX+1p8D+1
	 WWVmMPsdLpyQouxJvuQnVlL4t01jBhIea2T09Usomwxj5PZfFpxRCGDgrurnsztTdB
	 LvDckdMjWvj4seYBkbJOQVVX3OvNQDV+Z/f9IycDIz/I8RnpgnpRFLLS+VkO+vHJ7g
	 W15YUZMzei1FJHwfHbyfxPUCyc1xy9tvhheao1yd31ibmMsHDhN8tRCzytLaIxuI+5
	 QtnT/Tce6b/3w==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 03 Apr 2025 21:59:35 -0500
Subject: [PATCH 14/19] dt-bindings: arm/cpus: Add schemas for
 "enable-method" dependencies
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-dt-cpu-schema-v1-14-076be7171a85@kernel.org>
References: <20250403-dt-cpu-schema-v1-0-076be7171a85@kernel.org>
In-Reply-To: <20250403-dt-cpu-schema-v1-0-076be7171a85@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, zhouyanjie@wanyeetech.com, 
 Conor Dooley <conor@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Steen Hegelund <Steen.Hegelund@microchip.com>, 
 Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Heiko Stuebner <heiko@sntech.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-mips@vger.kernel.org, 
 imx@lists.linux.dev, linux-rockchip@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-renesas-soc@vger.kernel.org
X-Mailer: b4 0.15-dev

Replace the prose for properties dependent on specific "enable-method"
values with schemas defining the same requirements.

Both "qcom,acc" and "qcom,saw" properties appear to be required for any
of the Qualcomm enable-method values, so the schema is a bit simpler
than what the text said. The references to arm/msm/qcom,saw2.txt and
arm/msm/qcom,kpss-acc.txt are out of date, so just drop them.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 82 +++++++++++++++----------
 1 file changed, 49 insertions(+), 33 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 2e666b2a4dcd..963a9320cba8 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -273,8 +273,6 @@ properties:
     description:
       The DT specification defines this as 64-bit always, but some 32-bit Arm
       systems have used a 32-bit value which must be supported.
-      Required for systems that have an "enable-method"
-        property value of "spin-table".
 
   cpu-idle-states:
     $ref: /schemas/types.yaml#/definitions/phandle-array
@@ -333,24 +331,13 @@ properties:
 
   qcom,saw:
     $ref: /schemas/types.yaml#/definitions/phandle
-    description: |
-      Specifies the SAW* node associated with this CPU.
-
-      Required for systems that have an "enable-method" property
-      value of "qcom,kpss-acc-v1" or "qcom,kpss-acc-v2"
-
-      * arm/msm/qcom,saw2.txt
+    description:
+      Specifies the SAW node associated with this CPU.
 
   qcom,acc:
     $ref: /schemas/types.yaml#/definitions/phandle
-    description: |
-      Specifies the ACC* node associated with this CPU.
-
-      Required for systems that have an "enable-method" property
-      value of "qcom,kpss-acc-v1", "qcom,kpss-acc-v2", "qcom,msm8226-smp" or
-      "qcom,msm8916-smp".
-
-      * arm/msm/qcom,kpss-acc.txt
+    description:
+      Specifies the ACC node associated with this CPU.
 
   rockchip,pmu:
     $ref: /schemas/types.yaml#/definitions/phandle
@@ -378,22 +365,51 @@ properties:
       formed by encoding the target CPU id into the low bits of the
       physical start address it should jump to.
 
-if:
-  # If the enable-method property contains one of those values
-  properties:
-    enable-method:
-      contains:
-        enum:
-          - brcm,bcm11351-cpu-method
-          - brcm,bcm23550
-          - brcm,bcm-nsp-smp
-  # and if enable-method is present
-  required:
-    - enable-method
-
-then:
-  required:
-    - secondary-boot-reg
+allOf:
+  - if:
+      # If the enable-method property contains one of those values
+      properties:
+        enable-method:
+          contains:
+            enum:
+              - brcm,bcm11351-cpu-method
+              - brcm,bcm23550
+              - brcm,bcm-nsp-smp
+      # and if enable-method is present
+      required:
+        - enable-method
+    then:
+      required:
+        - secondary-boot-reg
+  - if:
+      properties:
+        enable-method:
+          enum:
+            - spin-table
+            - renesas,r9a06g032-smp
+      required:
+        - enable-method
+    then:
+      required:
+        - cpu-release-addr
+  - if:
+      properties:
+        enable-method:
+          enum:
+            - qcom,kpss-acc-v1
+            - qcom,kpss-acc-v2
+            - qcom,msm8226-smp
+            - qcom,msm8916-smp
+      required:
+        - enable-method
+    then:
+      required:
+        - qcom,acc
+        - qcom,saw
+    else:
+      properties:
+        qcom,acc: false
+        qcom,saw: false
 
 required:
   - device_type

-- 
2.47.2


