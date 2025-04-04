Return-Path: <linux-pm+bounces-24777-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D70A7B622
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 05:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625A93B8801
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 03:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C450617F4F6;
	Fri,  4 Apr 2025 02:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGkOYwQv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8616617A318;
	Fri,  4 Apr 2025 02:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743735586; cv=none; b=B495s353vuBplVcMJGn542Az/k8G+5NI2Kb2y/I6OkEhIDxZyqRe81oyaSaFrDk2pwhamjkzTdQVUPA4GRjPRFSIYJ4NSp5K51fvOUm4DArRsl0fXLEMEpD9eZIvEG8Y68oS6cYUvEwsTK0g6iydKG0t30+wpDDvgM5CPjvn/Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743735586; c=relaxed/simple;
	bh=Z1vjAGywXYfiVgOwNiyG0noL4S7j+UnQpBh2x5H0shU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dGVH4+Nt9DI/O0iAaFVFRmYaHRwNYDhONut+9gZAW6Io+ZfkbhyEc6BGF3LE0quIbG3+2cmhXVtz3364eQ3WgLFQEIfO6u5YlD6/7oua3180loB7AuDNRCAyGJtiUUbYwFvsB7d+kLlPJpvdvRQniNDqyYOOS65tK+SsW63ULGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGkOYwQv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4E3C4CEE3;
	Fri,  4 Apr 2025 02:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743735586;
	bh=Z1vjAGywXYfiVgOwNiyG0noL4S7j+UnQpBh2x5H0shU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qGkOYwQvYSxLYVzVO275Gh1fX6j5hRYE+1mqVqk/+RSIeVV6WelGep2C9jlA5gi/U
	 J8f32eUfkmjd4CKkjwzjMcFCCYuNbc3W7cDHzU8kV+CoIIW2I7zifAImjHi6xO5APq
	 GP7ZY4d3hqhJw3Ll3TqtcJCCdiSrMhjekkx/TYEQsNcn83Lvtqo5F0u6LGEAelzhCs
	 K8y8ktRzgD4FEsRcLIpliun0dZS+cO9Hsq4AfvtqOnRUDs9uilMS65MUAIHz+2naEI
	 1XY946kOQqa6r5pNxrcjViJzQwrOwIzKcD5DlB6RkVhJUJwH3QGAuvJNQwbBiyQEoT
	 JNFST/H+h3Szw==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 03 Apr 2025 21:59:25 -0500
Subject: [PATCH 04/19] arm64: dts: microchip: sparx5: Fix CPU node
 "enable-method" property dependencies
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-dt-cpu-schema-v1-4-076be7171a85@kernel.org>
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

The "spin-table" enable-method requires "cpu-release-addr" property,
so add a dummy entry. It is assumed the bootloader will fill in the
correct values.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm64/boot/dts/microchip/sparx5_pcb_common.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb_common.dtsi b/arch/arm64/boot/dts/microchip/sparx5_pcb_common.dtsi
index 32bb76b3202a..83bf5c81b5f7 100644
--- a/arch/arm64/boot/dts/microchip/sparx5_pcb_common.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5_pcb_common.dtsi
@@ -12,10 +12,12 @@ &psci {
 
 &cpu0 {
 	enable-method = "spin-table";
+	cpu-release-addr = /bits/ 64 <0>;
 };
 
 &cpu1 {
 	enable-method = "spin-table";
+	cpu-release-addr = /bits/ 64 <0>;
 };
 
 &uart0 {

-- 
2.47.2


