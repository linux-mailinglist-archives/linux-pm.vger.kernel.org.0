Return-Path: <linux-pm+bounces-24791-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4086EA7B66D
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 05:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC1B23A46AB
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 03:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066981E3DE0;
	Fri,  4 Apr 2025 03:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIydFOU9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEA21E1DF7;
	Fri,  4 Apr 2025 03:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743735605; cv=none; b=ABvrrU/lKaL3W4v/6Sw/i+ChVeMTH7isquA1HwqNUn+liK8wQaECleIqqdArbopjIkIvLK3RPSm5+aBUepIdXlppioUc7y6NVZOfDE2nRTzz58gr8cdGzLZdzrKT62C/s2sZeemUBTLhZjmtImdoe8oBDce90T+x/glFPUN7Luc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743735605; c=relaxed/simple;
	bh=VTRjZwZIi8q294b4YyTHrd0BG++P7ph5Qta/NAw+IT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZJ/603cTIzp5ecrMS613WuWn/ZyXkXVjlXR/LtkD1jwznHSSUQCpi3/a9oO2VwIavbfXnfhpdaFt0vox4f+GdEkU2NG1Kfny1gOO7CciC06U/8AZZwHThm9kvIitipEqn3Ac+wYjCRwUeJrLROgWGBZkMyTT9rCKkoM//nFpv7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIydFOU9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1030DC4CEE9;
	Fri,  4 Apr 2025 03:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743735605;
	bh=VTRjZwZIi8q294b4YyTHrd0BG++P7ph5Qta/NAw+IT8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BIydFOU9aJ9WhFAro8qghVTYQjHFs1Y2yZH4wibAW+ULHXKPCLPkRsy8d5oEx+P1/
	 7Hf6x9eRUkjhWNVFDw8HAyxVL60tteeZLa+l0vLO0aXmI7gnLie+EpmL2PS11qVJYp
	 xtIncqHBwXONuQspx+OM+dasoKJT4dzSHFN57/cN4VWkCms54jj2egjQDdMFmuhRKE
	 mLjNtcfcBBslTMrt3O/4G+vg3XGVeaNpnOm2YoZvIupH38/6PxnwbZhh+59CyPHO7k
	 rN6g4n76GbbVf3pd7BHkiVfkXnCHHO23yIhvWKPkp9pE4zZ+IRqV+P5Mdn30fiwwoM
	 XayRRMFqSmyww==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 03 Apr 2025 21:59:39 -0500
Subject: [PATCH 18/19] dt-bindings: arm/cpus: Add power-domains constraints
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-dt-cpu-schema-v1-18-076be7171a85@kernel.org>
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

The "power-domains" and "power-domains-names" properties are missing any
constraints. Add the constraints and drop the generic descriptions.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 6f74ebfd38df..5bd5822db8af 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -313,19 +313,15 @@ properties:
     maxItems: 1
 
   power-domains:
-    description:
-      List of phandles and PM domain specifiers, as defined by bindings of the
-      PM domain provider (see also ../power_domain.txt).
+    maxItems: 1
 
   power-domain-names:
     description:
-      A list of power domain name strings sorted in the same order as the
-      power-domains property.
-
       For PSCI based platforms, the name corresponding to the index of the PSCI
       PM domain provider, must be "psci". For SCMI based platforms, the name
       corresponding to the index of an SCMI performance domain provider, must be
       "perf".
+    enum: [ psci, perf, cpr ]
 
   resets:
     maxItems: 1

-- 
2.47.2


