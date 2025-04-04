Return-Path: <linux-pm+bounces-24775-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6803AA7B610
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 05:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F25C6189B8DC
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 03:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3430914F9EB;
	Fri,  4 Apr 2025 02:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJ0e7SAx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81B8149E17;
	Fri,  4 Apr 2025 02:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743735584; cv=none; b=bsPWlCa/qHC/QpeGh/7dNnrara+DWPat5CgysTEbrvu4HdOFZPOx7ciXrVIGKuwJHPA+ukdv43obWLorZM3t9wp1W5sMNHp8qsJ0rxZSiuvAtW4nHTpITBsXh2VtVA11G3V4IaiyqwtPvxQ0z7ikhcg1lDD44H1W/Q1McadeqDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743735584; c=relaxed/simple;
	bh=BFNG9yNPBQp7lePtcF6xD0SGvnVh48+ACatG3ueW7Nc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ndkbzm/yf17XGrYIrf/jhMl/aKBzHGI9U9B6bA+Ac8JT21uQi1TPcXK+lMBXDeaGZ6GE9nIraxkglIzDc4HYT9XfeUo6TWkBbehiDiZfkc3/6rOfMlzG025xll8xN3QEJBvo+xdZY6A7EIXHVegleRuLr86OCsNNbeOrKz3OlHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJ0e7SAx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DBB4C4CEF9;
	Fri,  4 Apr 2025 02:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743735583;
	bh=BFNG9yNPBQp7lePtcF6xD0SGvnVh48+ACatG3ueW7Nc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VJ0e7SAxLo+dcCqV1y3fiUbeOj8nzMsubkIcSK61bhYmhFqk2usnd0d5OPi7EKFdM
	 DRyI+aUiub90+OB8O8n9WkGNHSq5XjDhMNm+jODyHcVHCh8hI7SogIEa2XHIKBVbw8
	 6tHA5u923suAWQtSIIk/r+qK55kVswhMUDnDMPy8x6G2h1iJ6myNUFghF4bIy9SHk7
	 1uL3lBV9f3bS0qy+RIFP3V8Bnxf3aItkKniTAn6Dhy/J/vRlG5X3AfYwDnSpkSqKXZ
	 5Fe4SyAA72tc2gCFbxbhmwKehbH+Di1xzgWfn9O8OHHZMPggV0LnlKOpky195Gw6O8
	 kIqHaQHcEPOZg==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 03 Apr 2025 21:59:23 -0500
Subject: [PATCH 02/19] arm64: dts: broadcom: bcm2712: Use "l2-cache" for L2
 cache node names
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-dt-cpu-schema-v1-2-076be7171a85@kernel.org>
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

There's no need include the CPU number in the L2 cache node names as
the names are local to the CPU nodes. The documented node name is
also just "l2-cache".

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
index 9e610a89a337..ad0cac8e4444 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
@@ -64,7 +64,7 @@ cpu0: cpu@0 {
 			i-cache-sets = <256>; // 64KiB(size)/64(line-size)=1024ways/4-way set
 			next-level-cache = <&l2_cache_l0>;
 
-			l2_cache_l0: l2-cache-l0 {
+			l2_cache_l0: l2-cache {
 				compatible = "cache";
 				cache-size = <0x80000>;
 				cache-line-size = <64>;
@@ -88,7 +88,7 @@ cpu1: cpu@1 {
 			i-cache-sets = <256>; // 64KiB(size)/64(line-size)=1024ways/4-way set
 			next-level-cache = <&l2_cache_l1>;
 
-			l2_cache_l1: l2-cache-l1 {
+			l2_cache_l1: l2-cache {
 				compatible = "cache";
 				cache-size = <0x80000>;
 				cache-line-size = <64>;
@@ -112,7 +112,7 @@ cpu2: cpu@2 {
 			i-cache-sets = <256>; // 64KiB(size)/64(line-size)=1024ways/4-way set
 			next-level-cache = <&l2_cache_l2>;
 
-			l2_cache_l2: l2-cache-l2 {
+			l2_cache_l2: l2-cache {
 				compatible = "cache";
 				cache-size = <0x80000>;
 				cache-line-size = <64>;
@@ -136,7 +136,7 @@ cpu3: cpu@3 {
 			i-cache-sets = <256>; // 64KiB(size)/64(line-size)=1024ways/4-way set
 			next-level-cache = <&l2_cache_l3>;
 
-			l2_cache_l3: l2-cache-l3 {
+			l2_cache_l3: l2-cache {
 				compatible = "cache";
 				cache-size = <0x80000>;
 				cache-line-size = <64>;

-- 
2.47.2


