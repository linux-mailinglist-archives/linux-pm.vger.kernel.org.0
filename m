Return-Path: <linux-pm+bounces-25135-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F152A84876
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 17:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1451F9A72D9
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 15:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935DC1EFFAB;
	Thu, 10 Apr 2025 15:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKfnqZne"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C651EF365;
	Thu, 10 Apr 2025 15:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300069; cv=none; b=LdthCRVNdHFQhAcCnBavLc8jWFk4IbeqDB+4UayT5PlQhXNGfkO/pzbTcCVWvhlT2s1Z8v6WlCubDBGG+qj9BwnuhIQpdl2w1fueW4eWdJTsRWVraXOz8yYUtlVOlR4/aOQ4ndNSnep5QqLEmTf/LiaxRZTgJIv3uQ0APoslY9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300069; c=relaxed/simple;
	bh=MJ4WoqvhgC/aZjAy/ZTQhYcG1cI4RNuRYa6MzsWqQtk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VxZTjEWCjLkHz5cJ5oSIEaPopeZcsJ5E7IYLsjizPAhHccg4SOZwdnPmZc2nhuQuAqDXsNqfJN5Dv6CUgqQ1yOCEdQO6MiFOful+3pogDrfqgZwaSqDz9sK/Z/SKuw9bFLKQ99qPybiMpusPSYPgBAQQnLmUOczUlaPeRSsu8+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKfnqZne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E14C4CEEA;
	Thu, 10 Apr 2025 15:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300068;
	bh=MJ4WoqvhgC/aZjAy/ZTQhYcG1cI4RNuRYa6MzsWqQtk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hKfnqZneC+abzLvYTV6plSnmp6les52XSC3Xz9C7Rcp6J4l9nCVNuTwwlTUqDwC2q
	 +72ANtmUuZvc/VC9/xocD3jWreOuzykzBrMs4XMQ+5mfaCArgkpCjWOGupDZjoz5Ow
	 8UosB8hJqyiNrk+9DA7VvUzhvQIATUk+C0zQVQFDi+LPw+XTwEqa/nzR/JLtX1szDN
	 PBgCNHvQouW1ck4kouSglDLfZtlrrW/w97heJkhLLQgWU5bkcf8/K4TkAhklO7XJAd
	 vNyAf87yOvTzcn67GZHe95oSdT4xtwNHwsePQSTvc2Glij/FQIgwfTDE2C7PXQwh/o
	 +h/3lbYv+BgBQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 10 Apr 2025 10:47:23 -0500
Subject: [PATCH v2 02/17] arm64: dts: broadcom: bcm2712: Use "l2-cache" for
 L2 cache node names
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250410-dt-cpu-schema-v2-2-63d7dc9ddd0a@kernel.org>
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
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: b4 0.15-dev

There's no need include the CPU number in the L2 cache node names as
the names are local to the CPU nodes. The documented node name is
also just "l2-cache".

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


