Return-Path: <linux-pm+bounces-35249-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 899F1B96ECA
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 19:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 517AA2A3275
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 17:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67CC27CCF0;
	Tue, 23 Sep 2025 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGrKay+O"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F062765DC;
	Tue, 23 Sep 2025 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758647135; cv=none; b=GexBtoTFvOQQexveYPoDfycsAKU4YYMAJbz2susm3vosLu7lLqWa+wtu7MJXoz3tQ0mTJDVi0NZgr5+vwc/bcGSCQSo9v61plI3ECTLrXE92Nl/Sg5HVbLP2cj8y0Usd0D5l72lWtlmFJ9+Sw/n+RXjdklMbUbmxH08KgPqjlIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758647135; c=relaxed/simple;
	bh=/ou2szmYLHFv7ykIjQ/e1wg1hrXhydZMIDKjYoStfrw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gNYx2Bed3VfFrbnXOn10OrmTAsmaTS0yThAK0EwSVh7gMYe6shpkJu4MPhRlwutlXcycTQHhNI8lGyoiOzVez7kUaauVkBvHLcbqo8ZTb7QZUC6JBSHJNeso0/m4+FVS8jYWsF//YfUHnK7vfXghYFazUhYg2Fcvj/QJTThVwuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGrKay+O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E1FAC19423;
	Tue, 23 Sep 2025 17:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758647135;
	bh=/ou2szmYLHFv7ykIjQ/e1wg1hrXhydZMIDKjYoStfrw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kGrKay+O8ct10/qGYugpikCUwlCUPoflIVWIk7FjCzE+YXpvx/H1VfOFKt4QfD1mG
	 OQd1j7KWIh4oI2IqWNRz62YNRuUi800OuWeJ9HNLRUEV/nzqs61qYI5V0u+9x8u76V
	 sEFFsYx/UGKseJWlz+ms4LnRxLRVqpDOy5gK7txqP7zteiV/PRR51qCbFcyVE1OBVH
	 /hge6/oHUSI46bHhPG4nZCyjbXHL+Alz0w3LSmqEH1aOkZuo7xvJSIi7B+fM+gsWoZ
	 CX54VIHVqQKt28WP68SQWeYqOcBGnKMgOVVmv9XyzfY7/INj+1VqkfoPzdKG35OgYO
	 qfdYX+CPCDjaw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05618CAC5A5;
	Tue, 23 Sep 2025 17:05:35 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Tue, 23 Sep 2025 12:05:33 -0500
Subject: [PATCH v4 7/9] arm64: tegra: tegra210: Add actmon
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-t210-actmon-v4-7-442d1eb6377c@gmail.com>
References: <20250923-t210-actmon-v4-0-442d1eb6377c@gmail.com>
In-Reply-To: <20250923-t210-actmon-v4-0-442d1eb6377c@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758647133; l=1154;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=wlz7VuhgvpflHfZWQNafqWTwhXBSYIJPNM/UlFKQ87I=;
 b=4MSQ4IepFSM8Hr6St9+fslzQNssNBk0Pxa7LhMYcId3DxwYFQYnd3SVqWA0T2DCW4mzUEIe4F
 J6aKmQqByQkB8wwZ2traEMQDwu4p4HDweBoyLAXoIOXFioetVT90Eqm
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
2.51.0



