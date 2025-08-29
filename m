Return-Path: <linux-pm+bounces-33361-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DE8B3B1EC
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 06:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 540567C657A
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 04:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3D3234964;
	Fri, 29 Aug 2025 04:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hax1Y5x4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A05221F15;
	Fri, 29 Aug 2025 04:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756440093; cv=none; b=KBBFNCNH+FjfAajl0OgB+IyscpO6gX/AR3hWAzNgyWaiWfTW9bxtOVufX22xbMUj5p9ozGyB4tWTkdctU2uFmpBP6/opcOGwLdbxb00G78vqRRC62kIOk+T58Ve2gtL7C7bCdZ8GK6VKHnOAkJ2REqfpQQpWK9wM4PYreOCn9TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756440093; c=relaxed/simple;
	bh=+IqvVuotGYuZApHW8p/VIh20PCQhO97R0C9yu9c5l84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g6JUoSJKWn7zz6I85hot+toXuUk3VNCbyBBX4Hz52oex1y+LjshljFc77/RkpEy/2dpYEPCYfEy7bptGEw/E03iKQK0azdzqPFHBy7u2qUON8BpkqLbUBuLyCDvdgFizbsyOjGCipX4uxTnjHWEXJouaEuzYU20i9aF8GmGARmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hax1Y5x4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF4D0C4CEF8;
	Fri, 29 Aug 2025 04:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756440093;
	bh=+IqvVuotGYuZApHW8p/VIh20PCQhO97R0C9yu9c5l84=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hax1Y5x4LFOjVzFlMFePgqHIqFskcgsH8SwfhbADbkkvUMjvZyUU97vzjcMJTAo/z
	 bxsS6QITdx9YpMSstSLwOz+AmnTVPbmN07Qz5LPp/6QzHXzeYdwdyDoWf1ULGitPrv
	 Qed3RnY+RwlSvuCZolkibgaUDJEnmc94PcimDo6JAHk+iviQlj6vWw7oHX19brs4ko
	 kdnBr8k2iPD1XmyKmJRtVnGUk6Ssxh2zJxjjynBC0NA/c8I96qsiIEyO/2XXKNhC8v
	 D10xBgVjcUYWhfvLCNUIMu+Dp96Oh2jyzqfa1wZUC1N7aUtjABMHsX7KHTVkbQRhH4
	 lZlFBP6CoHwNw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE808CA0FFD;
	Fri, 29 Aug 2025 04:01:32 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Thu, 28 Aug 2025 23:01:31 -0500
Subject: [PATCH RFC 5/7] arm64: tegra: tegra210: Add actmon
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-t210-actmon-v1-5-aeb19ec1f244@gmail.com>
References: <20250828-t210-actmon-v1-0-aeb19ec1f244@gmail.com>
In-Reply-To: <20250828-t210-actmon-v1-0-aeb19ec1f244@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Dmitry Osipenko <digetx@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756440091; l=1154;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=JRVT2B6B9kttupzRP71VsPsEx2g3JnQatmD4nEG5i7w=;
 b=ume6WM1Y/mV4gjJyWs58SkXgqzr3RBXtRyPd9dWA37DL7gi6M86+yC2bKVfR7xONdBiuW1wnK
 zBH3x8J3/brDJtppA8RPePAZgMcvmxiuczXJvx83Ut3ICkdmRgTeVA5
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

This enables the action monitor to facilitate dynamic frequency scaling.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 402b0ede1472af625d9d9e811f5af306d436cc98..6da10db893add44a98fde1666c382511212fd43c 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -485,6 +485,18 @@ flow-controller@60007000 {
 		reg = <0x0 0x60007000 0x0 0x1000>;
 	};
 
+	actmon@6000c800 {
+		compatible = "nvidia,tegra210-actmon", "nvidia,tegra124-actmon";
+		reg = <0x0 0x6000c800 0x0 0x400>;
+		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA210_CLK_ACTMON>,
+			 <&tegra_car TEGRA210_CLK_EMC>;
+		clock-names = "actmon", "emc";
+		resets = <&tegra_car 119>;
+		reset-names = "actmon";
+		#cooling-cells = <2>;
+	};
+
 	gpio: gpio@6000d000 {
 		compatible = "nvidia,tegra210-gpio", "nvidia,tegra30-gpio";
 		reg = <0x0 0x6000d000 0x0 0x1000>;

-- 
2.50.1



