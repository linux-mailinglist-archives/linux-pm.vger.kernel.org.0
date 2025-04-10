Return-Path: <linux-pm+bounces-25148-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDBCA848CE
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 17:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A57F4E6A67
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 15:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F0D293B63;
	Thu, 10 Apr 2025 15:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNAb1E5V"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFB8293B54;
	Thu, 10 Apr 2025 15:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300088; cv=none; b=WEVQkRnx5gZeS92XVC8eIDZo3XOzNub38wTBQkYPLXMA0HK/f/xNHeYCuKg53C8ugVPqTK/naZFIht6zyNbTBgoFkF/gO+I0PfPEBnjW7iTgY6pwqperz6VATyLop+79E3QH36g8ksglwU/dAyS+CgNMvsBmNjGYVyz703o2t2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300088; c=relaxed/simple;
	bh=TllkH9uFMCMy3fpbEojTrBhyQXHNcCjD8yUla2JfvUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fXDs+Q+oYdyPGLShd199VCrXfB5iHB+NezjsKUg4hWCmLGK/btpfNDVxCB3crb6cp7UH31qFuy07BUC3nuh/zI+eUSwIaAhxe+fVFGfbK58/aSjmvSEudiunXSZFGlyGj9m/PN2npqu1fVrEoIH8lPKa6A97/1y73tpXkKTcIys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNAb1E5V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA7BC4CEDD;
	Thu, 10 Apr 2025 15:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300087;
	bh=TllkH9uFMCMy3fpbEojTrBhyQXHNcCjD8yUla2JfvUo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sNAb1E5VbKgvxSB5W3oXYM6325xj/OjVnNTVVDPRi2u7yWVdb5WhwxzWS3GnEI8IU
	 QXfRiPgLCaC4MN87EoSVzc7bDHTOs4ov/CKCH9VUY2KNPFXJKR18ahp2xr8D2IVZgv
	 cl7KHWg33at5mbc2qs8CfQaFuBtnK2XJ9D10oset4tdFmRUWcPuQL3NfdSk8wSegaA
	 BegkCLM6ILpgSAtCD/PoTDG7BfGxhZ7m4gdEFhuVmedd9Dp3VnapsdudQww5uL9pBy
	 +0RrwJFf84k44bfu2YJhTdWyGl7y/yqV2ZkgnYsMCv5AGyoSDscCPSW2Ow5DRLshbo
	 i29dHN5eZOggw==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 10 Apr 2025 10:47:36 -0500
Subject: [PATCH v2 15/17] dt-bindings: arm/cpus: Add missing properties
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-dt-cpu-schema-v2-15-63d7dc9ddd0a@kernel.org>
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
 Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>
X-Mailer: b4 0.15-dev

The Arm CPU schema is missing a number of properties already in use.
This has gone unnoticed as extra properties have not been restricted.
Add a missing reference to cpu.yaml, and add all the missing properties.

As "clock-latency" and "voltage-tolerance" are related to opp-v1, add
those properties to the opp-v1.yaml schema.

With this, other properties can be prevented from creeping in with
'unevaluatedProperties: false'.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/arm/cpus.yaml   | 46 ++++++++++++++++++++++-
 Documentation/devicetree/bindings/opp/opp-v1.yaml | 16 ++++++++
 2 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 5af1396d631f..3846f13ded5b 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -299,6 +299,16 @@ properties:
 
       where voltage is in V, frequency is in MHz.
 
+  interconnects:
+    minItems: 1
+    maxItems: 2
+
+  nvmem-cells:
+    maxItems: 1
+
+  nvmem-cell-names:
+    const: speed_grade
+
   performance-domains:
     maxItems: 1
 
@@ -317,6 +327,31 @@ properties:
       corresponding to the index of an SCMI performance domain provider, must be
       "perf".
 
+  resets:
+    maxItems: 1
+
+  arm-supply:
+    deprecated: true
+    description: Use 'cpu-supply' instead
+
+  cpu0-supply:
+    deprecated: true
+    description: Use 'cpu-supply' instead
+
+  mem-supply: true
+
+  proc-supply:
+    deprecated: true
+    description: Use 'cpu-supply' instead
+
+  sram-supply:
+    deprecated: true
+    description: Use 'mem-supply' instead
+
+  mediatek,cci:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Link to Mediatek Cache Coherent Interconnect
+
   qcom,saw:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
@@ -327,6 +362,11 @@ properties:
     description:
       Specifies the ACC node associated with this CPU.
 
+  qcom,freq-domain:
+    description: Specifies the QCom CPUFREQ HW associated with the CPU.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    maxItems: 1
+
   rockchip,pmu:
     $ref: /schemas/types.yaml#/definitions/phandle
     description: >
@@ -352,7 +392,11 @@ properties:
       formed by encoding the target CPU id into the low bits of the
       physical start address it should jump to.
 
+  thermal-idle:
+    type: object
+
 allOf:
+  - $ref: /schemas/cpu.yaml#
   - $ref: /schemas/opp/opp-v1.yaml#
   - if:
       # If the enable-method property contains one of those values
@@ -416,7 +460,7 @@ required:
 dependencies:
   rockchip,pmu: [enable-method]
 
-additionalProperties: true
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/opp/opp-v1.yaml b/Documentation/devicetree/bindings/opp/opp-v1.yaml
index 1b59b103dab6..61c080e50859 100644
--- a/Documentation/devicetree/bindings/opp/opp-v1.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v1.yaml
@@ -21,6 +21,18 @@ description: |+
 deprecated: true
 
 properties:
+  clock-latency:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The latency in nanoseconds for clock changes. Use OPP tables for new
+      designs instead.
+
+  voltage-tolerance:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 10
+    description:
+      The voltage tolerance in percent. Use OPP tables for new designs instead.
+
   operating-points:
     $ref: /schemas/types.yaml#/definitions/uint32-matrix
     items:
@@ -28,8 +40,12 @@ properties:
         - description: Frequency in kHz
         - description: Voltage for OPP in uV
 
+dependencies:
+  clock-latency: [ operating-points ]
+  voltage-tolerance: [ operating-points ]
 
 additionalProperties: true
+
 examples:
   - |
     cpus {

-- 
2.47.2


