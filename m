Return-Path: <linux-pm+bounces-25138-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF77A84889
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 17:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E6A19C337A
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 15:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F245228D839;
	Thu, 10 Apr 2025 15:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osXSzsJi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B416128D827;
	Thu, 10 Apr 2025 15:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300073; cv=none; b=MkHrV47KuA0kzeHr8w8elr10yFWEICvPIidtfLHAcvqkvlGkKXclVBdaOlH3KmTNHd4pmx/3uD8hrrxOwt/33S+xuMjSuVIDJ95KOvTkoJnRZ1fg4gIpwF+V2/roh202ncbWD2R5agzxnf7bKb1cghXJZM3dc3pmpckJSIH9XMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300073; c=relaxed/simple;
	bh=ra1+/x5tvvdws+NLgU93cbl0GnrL59uh7spZ77Nu2f0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hq6lsWl+u7XIgrB4Ix5F37CmjWoQAbvOVNj3zO4r4bTb21DTU/dBZP8A33EKktEcevTBwPZLff8R2YoLFS23mKBga5/JaySEfPTheOobLytV1kKBJqkWerLM/Pkutn4NE48eNHnnaVmruWmryjP/LNgXPrxtYFojQ/lK486i1YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osXSzsJi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B12C4CEDD;
	Thu, 10 Apr 2025 15:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300073;
	bh=ra1+/x5tvvdws+NLgU93cbl0GnrL59uh7spZ77Nu2f0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=osXSzsJizztnuyucaAb6gJ3UnBpmWkaUistvD0lZeqHTGwkjWKi3KEbYTQc9vnNd8
	 sYwJPDNuPwtCN3FbYhNJzKOH8iR0FyZoK9WBBgXFt3JR+GViSj93+J7IKND0x4Nqx3
	 mteKEAyhxOqLlMAH+Bld4AJLE7kyo0qJreNViUmg0SphBF/SUah93W5gpNiwKwgnJZ
	 h8VkECzVm/u3cjOq1pgdbjQHY2CAAKM63iZNYoXv2C4afiK7sga5pqTFTt4hVSadce
	 Hn9ZuGY+KfW+EEWq/+17zPu4G+BWN7J8jRcwOdp4injNxLwJPJaVG76MQRoToHmJKa
	 BhezofOyJOZaQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 10 Apr 2025 10:47:26 -0500
Subject: [PATCH v2 05/17] arm64: dts: qcom: msm8939: Fix CPU node
 "enable-method" property dependencies
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-dt-cpu-schema-v2-5-63d7dc9ddd0a@kernel.org>
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
 linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org
X-Mailer: b4 0.15-dev

The "spin-table" enable-method requires "cpu-release-addr" property,
so add a dummy entry. It is assumed the bootloader will fill in the
correct values.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v2:
 - Keep qcom,saw and qcom,acc properties
---
 arch/arm64/boot/dts/qcom/msm8939.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
index 7cd5660de1b3..72f01953e65c 100644
--- a/arch/arm64/boot/dts/qcom/msm8939.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
@@ -46,6 +46,7 @@ cpu0: cpu@100 {
 			compatible = "arm,cortex-a53";
 			device_type = "cpu";
 			enable-method = "spin-table";
+			cpu-release-addr = /bits/ 64 <0>;
 			reg = <0x100>;
 			next-level-cache = <&l2_1>;
 			qcom,acc = <&acc0>;
@@ -64,6 +65,7 @@ cpu1: cpu@101 {
 			compatible = "arm,cortex-a53";
 			device_type = "cpu";
 			enable-method = "spin-table";
+			cpu-release-addr = /bits/ 64 <0>;
 			reg = <0x101>;
 			next-level-cache = <&l2_1>;
 			qcom,acc = <&acc1>;
@@ -77,6 +79,7 @@ cpu2: cpu@102 {
 			compatible = "arm,cortex-a53";
 			device_type = "cpu";
 			enable-method = "spin-table";
+			cpu-release-addr = /bits/ 64 <0>;
 			reg = <0x102>;
 			next-level-cache = <&l2_1>;
 			qcom,acc = <&acc2>;
@@ -90,6 +93,7 @@ cpu3: cpu@103 {
 			compatible = "arm,cortex-a53";
 			device_type = "cpu";
 			enable-method = "spin-table";
+			cpu-release-addr = /bits/ 64 <0>;
 			reg = <0x103>;
 			next-level-cache = <&l2_1>;
 			qcom,acc = <&acc3>;
@@ -103,6 +107,7 @@ cpu4: cpu@0 {
 			compatible = "arm,cortex-a53";
 			device_type = "cpu";
 			enable-method = "spin-table";
+			cpu-release-addr = /bits/ 64 <0>;
 			reg = <0x0>;
 			qcom,acc = <&acc4>;
 			qcom,saw = <&saw4>;
@@ -121,6 +126,7 @@ cpu5: cpu@1 {
 			compatible = "arm,cortex-a53";
 			device_type = "cpu";
 			enable-method = "spin-table";
+			cpu-release-addr = /bits/ 64 <0>;
 			reg = <0x1>;
 			next-level-cache = <&l2_0>;
 			qcom,acc = <&acc5>;
@@ -134,6 +140,7 @@ cpu6: cpu@2 {
 			compatible = "arm,cortex-a53";
 			device_type = "cpu";
 			enable-method = "spin-table";
+			cpu-release-addr = /bits/ 64 <0>;
 			reg = <0x2>;
 			next-level-cache = <&l2_0>;
 			qcom,acc = <&acc6>;
@@ -147,6 +154,7 @@ cpu7: cpu@3 {
 			compatible = "arm,cortex-a53";
 			device_type = "cpu";
 			enable-method = "spin-table";
+			cpu-release-addr = /bits/ 64 <0>;
 			reg = <0x3>;
 			next-level-cache = <&l2_0>;
 			qcom,acc = <&acc7>;

-- 
2.47.2


