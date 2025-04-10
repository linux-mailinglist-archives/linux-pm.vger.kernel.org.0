Return-Path: <linux-pm+bounces-25145-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 578E7A848AD
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 17:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 903C51BA5CB5
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 15:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9F6290BAA;
	Thu, 10 Apr 2025 15:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvr+MRXW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C972900BE;
	Thu, 10 Apr 2025 15:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300083; cv=none; b=fILZjVH78Fm5Xqu/zZn0/of87Ywu7PUOahnszuphx1S27cy7TDKiVCbx/XV0eIwcnhfgPJJxLZbBJZ1DoPtAz4sSE+yo7GAQhrsbv6HrRGznPZ9PjphQWlPStl408D5dIrQMLGrjAOH5rHL3MwwDxWGntNbF/B4oGakls1iAtDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300083; c=relaxed/simple;
	bh=08ZHSMoqcp6muzXlw3I6sj8QXRZ+fQyHgNMZj1SSrdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P1wLPMb2ETXeoNxF8JFFfaV32UYKkrKkOvnE0Tqi6x1XcL1u7DXTDfY1pT/s1nMioTyoOqIeT1iVoVjPchNUEb7xfSapXgI1ALRNxXfAT1hP9a+Mc0FN1k5tRUR5HdHHn8GKzBbOWE7wCQxSLvbGHFCCVKAczE5e+Xk5vGDflNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvr+MRXW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007AAC4CEDD;
	Thu, 10 Apr 2025 15:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300083;
	bh=08ZHSMoqcp6muzXlw3I6sj8QXRZ+fQyHgNMZj1SSrdY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hvr+MRXWz6zZDqbGyKtarK07qSeX1tVPFXSoarGPEnD0U89TtphwqxdOSRLJUGR8s
	 ijse85CijxUfmz4anXLpHxCZKbQPb/AX1QQ1dN4FedmWWau4+rvqXhgNFDAbFrPvhw
	 YJWwW+1vted2FUTHOwDNhA8UGfbMx+nKhAZ19SWkUTR1SsMURjrv54YmGB6PV9SS9Z
	 1khj6/sx3iSVKSHhelpuYN7tfbIQtVcdGpfcBIKLpQ/MjxraUlaGtpNhleFxFwq1Ku
	 QimonuVOeh0Zwbj5EUUOk5DYIoJ/qmzM2cUcj12IC6hrggz5lNM2kXaBE3kWR3MwXo
	 cL4uCcB7HchBA==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 10 Apr 2025 10:47:33 -0500
Subject: [PATCH v2 12/17] dt-bindings: arm/cpus: Add schemas for
 "enable-method" dependencies
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-dt-cpu-schema-v2-12-63d7dc9ddd0a@kernel.org>
References: <20250410-dt-cpu-schema-v2-0-63d7dc9ddd0a@kernel.org>
In-Reply-To: <20250410-dt-cpu-schema-v2-0-63d7dc9ddd0a@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Conor Dooley <conor@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Steen Hegelund <Steen.Hegelund@microchip.com>, 
 Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Heiko Stuebner <heiko@sntech.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Andy Gross <agross@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, zhouyanjie@wanyeetech.com, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, imx@lists.linux.dev, 
 linux-rockchip@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-renesas-soc@vger.kernel.org, linux-mips@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 Sudeep Holla <sudeep.holla@arm.com>
X-Mailer: b4 0.15-dev

Replace the prose for properties dependent on specific "enable-method"
values with schemas defining the same requirements.

Both "qcom,acc" and "qcom,saw" properties appear to be required for any
of the Qualcomm enable-method values, so the schema is a bit simpler
than what the text said. The properties are also needed on some Qualcomm
platforms with other enable-method values. It's limited to Cortex A53
based platforms so use that to disable the properties. The references
to arm/msm/qcom,saw2.txt and arm/msm/qcom,kpss-acc.txt are out of date,
so just drop them.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
---
v2:
 - Only disallow qcom,acc and qcom,saw on !cortex-a53
 - Fix example in qcom,saw2.yaml
---
 Documentation/devicetree/bindings/arm/cpus.yaml    | 91 ++++++++++++++--------
 .../devicetree/bindings/soc/qcom/qcom,saw2.yaml    |  3 +-
 2 files changed, 60 insertions(+), 34 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 2e666b2a4dcd..351be2f77581 100644
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
@@ -378,22 +365,60 @@ properties:
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
+  - if:
+      # 2 Qualcomm platforms bootloaders need qcom,acc and qcom,saw yet use
+      # "spin-table" or "psci" enable-methods. Disallowing the properties for
+      # all other CPUs is the best we can do as there's not any way to
+      # distinguish these Qualcomm platforms.
+      not:
+        properties:
+          compatible:
+            const: arm,cortex-a53
+    then:
+      properties:
+        qcom,acc: false
+        qcom,saw: false
 
 required:
   - device_type
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,saw2.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,saw2.yaml
index ca4bce817273..c2f1f5946cfa 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,saw2.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,saw2.yaml
@@ -73,9 +73,10 @@ examples:
         #size-cells = <0>;
 
         cpu@0 {
-            compatible = "qcom,kryo";
+            compatible = "arm,cortex-a53";
             device_type = "cpu";
             enable-method = "qcom,kpss-acc-v2";
+            qcom,acc = <&acc0>;
             qcom,saw = <&saw0>;
             reg = <0x0>;
             operating-points-v2 = <&cpu_opp_table>;

-- 
2.47.2


