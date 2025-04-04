Return-Path: <linux-pm+bounces-24789-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28504A7B67B
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 05:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E6A6189EC87
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 03:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E51F1D79B3;
	Fri,  4 Apr 2025 03:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uK9nKufj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F306A1CF284;
	Fri,  4 Apr 2025 03:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743735603; cv=none; b=Uoe3bVOQmPbm/SJWud15QFajmFy1DRlXNobKBcbtL3SVEqNQ68QtHPWBu7camP8M077jsVUsBpz0sYUyOVhXfbA7RHJmV2B/LVCZhYvDGjhCFBYVuVMjRXLqNWQx+BVuiSOtw1hRmNEIRx7L0tzJz8HbMNng5phXfEB7NUTmQuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743735603; c=relaxed/simple;
	bh=oVGi9LwOUr1+hNrJwoDMMLjyDofanD4Qd7/JOe/aRMw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lpkmv558NhZhl+HiMcBaADdICvimo36idwzaqvil3wrhG0+iBtOSKq1LcJoW9kRD9rMLGCpffewUk4qbrZeTm/SGxJ2Vaf3VST29qd2eEKr1xuWqLo/IGR8TDZ1AQnmHeipigQHQs/ltKh9U6/NmePulb3orbuWg/to8OlZWUp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uK9nKufj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A8EC4CEE7;
	Fri,  4 Apr 2025 03:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743735602;
	bh=oVGi9LwOUr1+hNrJwoDMMLjyDofanD4Qd7/JOe/aRMw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uK9nKufjP+IzSykFxQTjmnYd2dqL7STkiN6hiK8+ji7QTyS6gWUiu1u9C2OsGHn4A
	 UUVKxicewOK3olz4cK7R8+rvVygmEeyOjYJ/XybvE2hSdAaUShwA26AC3kdkFRm0Ke
	 PnwjgfqxaA+k1p/yF9dzhXAO38jVYb7c1vGDsm5R6/bWI22AYdeZdV8SwVwUo/uph6
	 8njaUuSZePjfDVosNksNGLsMU5CGBgO2SMVw3zxckT0uAcfgSYU7Gf4VdpmsDExi8O
	 i8AjKEoK9kCcyO2xwncvhJekKB/D/3D6qqXPOB/9b35CSHw88934H5EB3tERPiGyrB
	 plN55+SUAVCew==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 03 Apr 2025 21:59:37 -0500
Subject: [PATCH 16/19] dt-bindings: Reference opp-v1 schema in CPU schemas
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-dt-cpu-schema-v1-16-076be7171a85@kernel.org>
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

The opp-v1 binding is only used in MIPS and arm32 CPU nodes, so add a
$ref to it in the CPU schemas and drop the "select".

As opp-v1 has long been deprecated, mark it as such.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/cpus.yaml   | 1 +
 Documentation/devicetree/bindings/mips/cpus.yaml  | 3 ++-
 Documentation/devicetree/bindings/opp/opp-v1.yaml | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 3e76de3e950d..3d2b6286efb8 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -353,6 +353,7 @@ properties:
       physical start address it should jump to.
 
 allOf:
+  - $ref: /schemas/opp/opp-v1.yaml#
   - if:
       # If the enable-method property contains one of those values
       properties:
diff --git a/Documentation/devicetree/bindings/mips/cpus.yaml b/Documentation/devicetree/bindings/mips/cpus.yaml
index a85137add668..471373ad0cfb 100644
--- a/Documentation/devicetree/bindings/mips/cpus.yaml
+++ b/Documentation/devicetree/bindings/mips/cpus.yaml
@@ -50,6 +50,7 @@ properties:
   device_type: true
 
 allOf:
+  - $ref: /schemas/opp/opp-v1.yaml#
   - if:
       properties:
         compatible:
@@ -68,7 +69,7 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/opp/opp-v1.yaml b/Documentation/devicetree/bindings/opp/opp-v1.yaml
index 07e26c267815..1b59b103dab6 100644
--- a/Documentation/devicetree/bindings/opp/opp-v1.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v1.yaml
@@ -18,7 +18,7 @@ description: |+
 
   This binding only supports voltage-frequency pairs.
 
-select: true
+deprecated: true
 
 properties:
   operating-points:

-- 
2.47.2


