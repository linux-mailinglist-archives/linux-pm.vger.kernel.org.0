Return-Path: <linux-pm+bounces-33767-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A0AB42A40
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 21:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0F711C20E82
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 19:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014C236C091;
	Wed,  3 Sep 2025 19:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWtqH2Li"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F939369986;
	Wed,  3 Sep 2025 19:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756929082; cv=none; b=n6GBOg6hQX7MnIgNVJ9ySe9Ewmg35CehAd6rM2du5VQHl/J+yF4SGt1mSo+P1NGuHAoKfu7uVXMRD2LOG3RS5DLaIdt+UZLQRK52CxEQtZmkKBYDsovhMt5H1jlJRtSenVKjOc1p88TgEm/RDhboXtxFuKot/Ub6rxTClYRwd4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756929082; c=relaxed/simple;
	bh=+IqvVuotGYuZApHW8p/VIh20PCQhO97R0C9yu9c5l84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SKyroJTMfWkR9/jHCuWjY3/p4pzwf/CWlnzTx3Lsq9ZlzipmsiqrbElnhW+c24Xv5VTTOKYs3YptzAYCHIPCy6b9h6Fm29YSL+3THJ3wstkebJWVTrpAtWf+E6zDr8CEkVG5la4DdxmrxXjR3UKnGBgOW/1t6HsIqIu3tjcJ6FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWtqH2Li; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A661C116B1;
	Wed,  3 Sep 2025 19:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756929082;
	bh=+IqvVuotGYuZApHW8p/VIh20PCQhO97R0C9yu9c5l84=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VWtqH2Libz3xV35o/XEIhEBMgaagiCtll9jJYb8Gm4DxIH/C37MtkBtpGleJnc21J
	 MrrQPsU/KWK45W9Nuq3U6BJi1dT31LPAGbP4wyuaRT47T3DAl0WiN+/YCl+nT3RaJ5
	 rUgFbvc12cag0563gT7Nfh0peDWL382nEXg6GCR8H6v9AqekFCpp9h37sVY/BxnVoo
	 jC3kyaE50L9m5OrnK9IknMpzgTBb6+bP0XwpMXIQOsokE18UpM1X+1o5ePGoP531wo
	 a3f9xwKjMdRLUGDEkV5C1s1tuBudCKPMkqn9TBXO1lLnrI2VE6i0QfpIbmY5QWfii3
	 2I9BEfC0xFGNQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314C5CA1009;
	Wed,  3 Sep 2025 19:51:22 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Wed, 03 Sep 2025 14:50:12 -0500
Subject: [PATCH v2 6/8] arm64: tegra: tegra210: Add actmon
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-t210-actmon-v2-6-e0d534d4f8ea@gmail.com>
References: <20250903-t210-actmon-v2-0-e0d534d4f8ea@gmail.com>
In-Reply-To: <20250903-t210-actmon-v2-0-e0d534d4f8ea@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756929080; l=1154;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=JRVT2B6B9kttupzRP71VsPsEx2g3JnQatmD4nEG5i7w=;
 b=tK/yeA0Clmk2KMcK6eJEewCclUF8la2f+9G3a9FcbvVdJ8AAeLfTrmhpF96kECJUZXi8wcw1v
 sf1p0n9OfWpCqGzr92/Ya8b4JrEkn5zM0iXa43P1Ni+e3Ey0DkQF4jC
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



