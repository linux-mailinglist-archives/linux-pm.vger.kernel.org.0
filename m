Return-Path: <linux-pm+bounces-25147-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 420AAA848BD
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 17:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 160069C2319
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 15:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C14293457;
	Thu, 10 Apr 2025 15:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qg97LQXx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510AF29344A;
	Thu, 10 Apr 2025 15:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300086; cv=none; b=HV5gHtifVp/Y2hQWea+OWOnOJnqPMXeCgIQ3Nyf3XCwgxzMUeeJSwKcnNOXjbI3wXHlPXu3Q430uNPWjeoNZIWC1cSBx+8xGnn07p3hh2DFO2YVfmn248GzHF9qhAZl2oo6aebpc3MgIiOR359ottY/XRbZAjC2GkJLvff1/0no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300086; c=relaxed/simple;
	bh=d2xEle5JR0P+8ywA0siIkzQPF9OlhK/me+6AtXOc0AY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Osx311PQ79Mk5Phqr/2hx4+zu8QY5Fu5KOjVyuB3hCfv/ptXgakIsw2OAkM2187wHB3i7FZOIjd0DwR5MCAyFwyQgR79p7gpcsYaEugzvLPl2NFbzx0vI2uqlyRA7uqflbkFd41xrFC79k+6f0rg2KqRiIp4kIN3rARwexJ53yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qg97LQXx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C31C4CEDD;
	Thu, 10 Apr 2025 15:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300086;
	bh=d2xEle5JR0P+8ywA0siIkzQPF9OlhK/me+6AtXOc0AY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qg97LQXxGV9ue31R3MdJVO2YsWgEzGw16N4u8DA8cSMGiQre4zl71TcotrYsR03/s
	 qxPvL6r0xo8sAMHg/GmU2Ydh7pqHl4uCL4KwtnVRK4bZcRVsku0EjD5jyo920SnEgM
	 3YPNYEJKauEYI/YTN2EPPH9Sgs2M98xRB4VCeDSvhZ0XTwsK3MYnJyr5+oehnPZQPR
	 x7DBrqvDUukbGMNLfanV1kuogiP7OWadByi5f7drA7qqyQOQ/TrgE8YzeedwdpTED9
	 TzmFsWHaGHmHPqL4Wkm1pjhIUHDaaOUuQh+21Lzzb9zRW9meTqoHS7x7RiG56MLbUg
	 XAsxucDqzahhA==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 10 Apr 2025 10:47:35 -0500
Subject: [PATCH v2 14/17] dt-bindings: Reference opp-v1 schema in CPU
 schemas
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-dt-cpu-schema-v2-14-63d7dc9ddd0a@kernel.org>
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
 Viresh Kumar <viresh.kumar@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>
X-Mailer: b4 0.15-dev

The opp-v1 binding is only used in MIPS and arm32 CPU nodes, so add a
$ref to it in the CPU schemas and drop the "select".

As opp-v1 has long been deprecated, mark it as such.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
---
 Documentation/devicetree/bindings/arm/cpus.yaml   | 1 +
 Documentation/devicetree/bindings/mips/cpus.yaml  | 3 ++-
 Documentation/devicetree/bindings/opp/opp-v1.yaml | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index acf38b3518dd..5af1396d631f 100644
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


