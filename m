Return-Path: <linux-pm+bounces-24788-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA702A7B65E
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 05:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3A6178F4B
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 03:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A581C8616;
	Fri,  4 Apr 2025 03:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMWjOXGo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286D91C84BE;
	Fri,  4 Apr 2025 03:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743735602; cv=none; b=mMO5olcXKUDQXfX5CfBY9F3/d3s2bhwywbRBpwKxtPzGHbPiI66fj9otnmaI+93EOsVmU24cHVWxeIxPA7Cc7/YIJOcbM7t2lz9tpJSoqozv1McFHWzh6wWY0+hvEXGnx3V5wBpEE9ReeyY312dEn+ueEqvdwRuXCoPAP8842VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743735602; c=relaxed/simple;
	bh=6cslgmm9oQIu/lOy/Nngvpo3/Efl2kNGCI97+vDsecU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JmBEkMMoTM8UCzNLKfBPMpj0d+1HrhnF5MuDUE27fULruswO4bqwS4W6EnD6ulP/OhaaH8Ce7d6C4crdaHcDoEcV2loU2ZtoPQTzfF3CPB83j54+gG4Cs6ph9bK+nqdCcJ3PAynx+k3FWZFN2FMuwr3iF2uuBRftLWvKUj+LiEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMWjOXGo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C0E7C4CEEA;
	Fri,  4 Apr 2025 03:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743735601;
	bh=6cslgmm9oQIu/lOy/Nngvpo3/Efl2kNGCI97+vDsecU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dMWjOXGofzF2+tDya9v6l8znJNIr0XFdwvGI+daCjlkFRLuMzx9sNn4HHfNMsEjWt
	 pgrdJOHr0uVGh9HgUr/nTO+5y6FiiQlMDGsELglKzmI+PqZrG58NBPEDcwy8l8HpKc
	 JOOXdTwbEZ1iNhXJkRnKTCideHzOnBoxGrg/0mNfDVKWWmx9xxz/wMtFnStrhM473Q
	 5bK2NAeUuwKQJKl6yijneJ+QIiZ4zLzrzf4ypXsZNFc16VAyE2aZgwAl/6H63lCYua
	 EX5vmVkwswaYPlmACGBIfBBDS5IdDS1y/zNsjyKj7uoJoq4RplRjGnqafkptFbZBzh
	 yDi2XjUD/mJ1Q==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 03 Apr 2025 21:59:36 -0500
Subject: [PATCH 15/19] dt-bindings: arm/cpus: Re-wrap 'description' entries
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-dt-cpu-schema-v1-15-076be7171a85@kernel.org>
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

Some of the 'description' entries have odd line wrapping and incorrect
YAML block modifiers. The 'description' entries should typically wrap
at 80 chars. Reformat the entries to follow that along with using '>'
modifiers as appropriate.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 85 +++++++++++--------------
 1 file changed, 36 insertions(+), 49 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 963a9320cba8..3e76de3e950d 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -10,9 +10,9 @@ maintainers:
   - Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
 
 description: |+
-  The device tree allows to describe the layout of CPUs in a system through
-  the "cpus" node, which in turn contains a number of subnodes (ie "cpu")
-  defining properties for every cpu.
+  The device tree allows to describe the layout of CPUs in a system through the
+  "cpus" node, which in turn contains a number of subnodes (ie "cpu") defining
+  properties for every cpu.
 
   Bindings for CPU nodes follow the Devicetree Specification, available from:
 
@@ -41,45 +41,40 @@ description: |+
 properties:
   reg:
     maxItems: 1
-    description: |
-      Usage and definition depend on ARM architecture version and
-      configuration:
+    description: >
+      Usage and definition depend on ARM architecture version and configuration:
 
-      On uniprocessor ARM architectures previous to v7
-      this property is required and must be set to 0.
+      On uniprocessor ARM architectures previous to v7 this property is required
+      and must be set to 0.
 
-      On ARM 11 MPcore based systems this property is
-        required and matches the CPUID[11:0] register bits.
+      On ARM 11 MPcore based systems this property is required and matches the
+      CPUID[11:0] register bits.
 
-        Bits [11:0] in the reg cell must be set to
-        bits [11:0] in CPU ID register.
+        Bits [11:0] in the reg cell must be set to bits [11:0] in CPU ID register.
 
         All other bits in the reg cell must be set to 0.
 
-      On 32-bit ARM v7 or later systems this property is
-        required and matches the CPU MPIDR[23:0] register
-        bits.
+      On 32-bit ARM v7 or later systems this property is required and matches
+      the CPU MPIDR[23:0] register bits.
 
-        Bits [23:0] in the reg cell must be set to
-        bits [23:0] in MPIDR.
+        Bits [23:0] in the reg cell must be set to bits [23:0] in MPIDR.
 
         All other bits in the reg cell must be set to 0.
 
-      On ARM v8 64-bit systems this property is required
-        and matches the MPIDR_EL1 register affinity bits.
+      On ARM v8 64-bit systems this property is required and matches the
+      MPIDR_EL1 register affinity bits.
 
         * If cpus node's #address-cells property is set to 2
 
-          The first reg cell bits [7:0] must be set to
-          bits [39:32] of MPIDR_EL1.
+          The first reg cell bits [7:0] must be set to bits [39:32] of
+          MPIDR_EL1.
 
-          The second reg cell bits [23:0] must be set to
-          bits [23:0] of MPIDR_EL1.
+          The second reg cell bits [23:0] must be set to bits [23:0] of
+          MPIDR_EL1.
 
         * If cpus node's #address-cells property is set to 1
 
-          The reg cell bits [23:0] must be set to bits [23:0]
-          of MPIDR_EL1.
+          The reg cell bits [23:0] must be set to bits [23:0] of MPIDR_EL1.
 
       All other bits in the reg cells must be set to 0.
 
@@ -278,29 +273,26 @@ properties:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     items:
       maxItems: 1
-    description: |
-      List of phandles to idle state nodes supported
-      by this cpu (see ./idle-states.yaml).
+    description:
+      List of phandles to idle state nodes supported by this cpu (see
+      ./idle-states.yaml).
 
   capacity-dmips-mhz:
     description:
       u32 value representing CPU capacity (see ../cpu/cpu-capacity.txt) in
-      DMIPS/MHz, relative to highest capacity-dmips-mhz
-      in the system.
+      DMIPS/MHz, relative to highest capacity-dmips-mhz in the system.
 
   cci-control-port: true
 
   dynamic-power-coefficient:
     $ref: /schemas/types.yaml#/definitions/uint32
-    description:
-      A u32 value that represents the running time dynamic
-      power coefficient in units of uW/MHz/V^2. The
-      coefficient can either be calculated from power
+    description: >
+      A u32 value that represents the running time dynamic power coefficient in
+      units of uW/MHz/V^2. The coefficient can either be calculated from power
       measurements or derived by analysis.
 
-      The dynamic power consumption of the CPU  is
-      proportional to the square of the Voltage (V) and
-      the clock frequency (f). The coefficient is used to
+      The dynamic power consumption of the CPU  is proportional to the square of
+      the Voltage (V) and the clock frequency (f). The coefficient is used to
       calculate the dynamic power as below -
 
       Pdyn = dynamic-power-coefficient * V^2 * f
@@ -309,10 +301,6 @@ properties:
 
   performance-domains:
     maxItems: 1
-    description:
-      List of phandles and performance domain specifiers, as defined by
-      bindings of the performance domain provider. See also
-      dvfs/performance-domain.yaml.
 
   power-domains:
     description:
@@ -341,22 +329,21 @@ properties:
 
   rockchip,pmu:
     $ref: /schemas/types.yaml#/definitions/phandle
-    description: |
+    description: >
       Specifies the syscon node controlling the cpu core power domains.
 
-      Optional for systems that have an "enable-method"
-      property value of "rockchip,rk3066-smp"
-      While optional, it is the preferred way to get access to
-      the cpu-core power-domains.
+      Optional for systems that have an "enable-method" property value of
+      "rockchip,rk3066-smp". While optional, it is the preferred way to get
+      access to the cpu-core power-domains.
 
   secondary-boot-reg:
     $ref: /schemas/types.yaml#/definitions/uint32
-    description: |
+    description: >
       Required for systems that have an "enable-method" property value of
       "brcm,bcm11351-cpu-method", "brcm,bcm23550" or "brcm,bcm-nsp-smp".
 
-      This includes the following SoCs: |
-      BCM11130, BCM11140, BCM11351, BCM28145, BCM28155, BCM21664, BCM23550
+      This includes the following SoCs:
+      BCM11130, BCM11140, BCM11351, BCM28145, BCM28155, BCM21664, BCM23550,
       BCM58522, BCM58525, BCM58535, BCM58622, BCM58623, BCM58625, BCM88312
 
       The secondary-boot-reg property is a u32 value that specifies the

-- 
2.47.2


