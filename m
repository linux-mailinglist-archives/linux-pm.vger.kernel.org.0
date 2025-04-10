Return-Path: <linux-pm+bounces-25139-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD84A848A2
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 17:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77468179AA5
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 15:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EDD28EA48;
	Thu, 10 Apr 2025 15:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGYzjYYn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E4528D85A;
	Thu, 10 Apr 2025 15:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300074; cv=none; b=qd+hZNWgwC5nSrFyny8gPHcfNREBw94cD3ARWKAIK18rp+Xr5+jjqacX1sp4HxjTWwBXBiG/q+itf5zoeNmtydQKNyZwMwNZI4orzt4ptJtZtMzqRjAFmZVE7MQ2pwa9t8tk2/TXB5Dg7d9wnefwKVNQQvy6wbJOlmPBdUVB3mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300074; c=relaxed/simple;
	bh=nVo5X/MosXjoMIZOdVn7ETl8AN7NiwovxfdEw8OmSOs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UQWDIQsSXytOrAQwBVhvW83+RQ8vt8MHB/t60fXqG7OeqwrOmio0BgKh0Yn9cbDFV8I9dU3sBjWQEo+9jIY3zY0K3UYmD1J/mDLipG1gWPql3d1Ku+g1u8F/TOKbI/z1e/1IpP1cw60uCac3lnuuNoRaFxHtxwxc+rt0H6nDY4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGYzjYYn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A8CC4CEE9;
	Thu, 10 Apr 2025 15:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300074;
	bh=nVo5X/MosXjoMIZOdVn7ETl8AN7NiwovxfdEw8OmSOs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uGYzjYYnTyApltpYtEA9/9oZnG7/797Cn8q6jqLk/EiRZu5XNF9EqiZug9/5/DkhX
	 FRosU37qIN5bQ1dUS0YVTjxFaqmabQ38JtCNt1L0lFwpmaWS5mnlYPBXQY6s0rIHQc
	 Nsu2qcZnsHflTkFFwv8LjQyI1/3LA0m8kUxUChx9BT0j/UhiUPJCikDLhEclCZHBIC
	 si6a0LUoUuapa5Y9l8wAc5gqlVpgGczwcdrrgDhN4YbSPiV+50DSgLPVlpyH2bpcbC
	 2MRLG1p4C84SGSxRS3OFcHEyOHInbBplC/dIIFurvHHjPYY9PShPHMVmWUO9mmFbmq
	 8QArAGCBXYMSQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 10 Apr 2025 10:47:27 -0500
Subject: [PATCH v2 06/17] arm64: dts: qcom: msm8992-lg-h815: Fix CPU node
 "enable-method" property dependencies
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-dt-cpu-schema-v2-6-63d7dc9ddd0a@kernel.org>
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
 arch/arm64/boot/dts/qcom/msm8992-lg-h815.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8992-lg-h815.dts b/arch/arm64/boot/dts/qcom/msm8992-lg-h815.dts
index 4520d5d51a29..6a231afad85d 100644
--- a/arch/arm64/boot/dts/qcom/msm8992-lg-h815.dts
+++ b/arch/arm64/boot/dts/qcom/msm8992-lg-h815.dts
@@ -93,26 +93,32 @@ key-vol-up {
 
 &cpu0 {
 	enable-method = "spin-table";
+	cpu-release-addr = /bits/ 64 <0>;
 };
 
 &cpu1 {
 	enable-method = "spin-table";
+	cpu-release-addr = /bits/ 64 <0>;
 };
 
 &cpu2 {
 	enable-method = "spin-table";
+	cpu-release-addr = /bits/ 64 <0>;
 };
 
 &cpu3 {
 	enable-method = "spin-table";
+	cpu-release-addr = /bits/ 64 <0>;
 };
 
 &cpu4 {
 	enable-method = "spin-table";
+	cpu-release-addr = /bits/ 64 <0>;
 };
 
 &cpu5 {
 	enable-method = "spin-table";
+	cpu-release-addr = /bits/ 64 <0>;
 };
 
 &pm8994_resin {

-- 
2.47.2


