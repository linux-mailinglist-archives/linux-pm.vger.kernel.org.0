Return-Path: <linux-pm+bounces-35247-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 880ACB96EBE
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 19:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D34C17C72B
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 17:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B851A27B35C;
	Tue, 23 Sep 2025 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAYDhiir"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C154277CA1;
	Tue, 23 Sep 2025 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758647135; cv=none; b=YZHZk4fWm8jOb1+LvMnFFiUG1FPnPvBqSEBZyXJpurtquHuZVcE8WBYALqQUGfXPHSTzHKmUMqH187NLgHXnuBsbvG2sLbixp9jV7tJVr5oVOaqUBNdjf/CrZUCFPZybOgvlN8TZQ9HEGnLfVJne1DK75/NBXNpjqx7VYnex5jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758647135; c=relaxed/simple;
	bh=hV14NGi5CrH131Wx4M4fOh7wVGQBwgsL+TxbUFT+uBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hOOaLf+KyXIN0E4c7EeI5rQioW0ts93AGqMPDBmeuPIP6yVaGpiKCWmgP9vcPIHiNe/28qL2HEqUvAufFeiOnaj3xxIji0+j0d3TwXA+K8U7Ky24UhkJZxmsuJTqeSon6kyuLV4JMEJoafGtgq9DMfUPYMng873i/2QjUIWbvlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAYDhiir; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D767C2BC86;
	Tue, 23 Sep 2025 17:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758647135;
	bh=hV14NGi5CrH131Wx4M4fOh7wVGQBwgsL+TxbUFT+uBo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mAYDhiir9Cd+uHfrMHR5MPH2vu0QSRIhGXawHgU6C1WyNJ4ULLP5aYu47KttHlzM8
	 iARw7VBJnK6/6rZ0s+k+QPPTLMTZTUZi191gPV/W3s/rzjZ0SY+a5gTobPlDnoK8vN
	 tVn+lOavmXlgTv6EF4ADJfu6bjtnXipxrJMIxjgtO8pQzEbVH0wahVitgCBvMK/ChT
	 hPXeJEZtLYDFVJNcqBNXQeg1BvDpp0G2Dz6hDGMUbizic8xYy/K0EhNI7qLPGMy/WO
	 ThXw8Yyf4WczQsxw4cxvqAWCcX0RCZws1LyyarubjpgaJ4Ef3/DEMlRYNvck/Hh3Iy
	 zdIg7nfO3XeGQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233B5CAC5AC;
	Tue, 23 Sep 2025 17:05:35 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Tue, 23 Sep 2025 12:05:35 -0500
Subject: [PATCH v4 9/9] arm64: tegra: Add OPP tables on Tegra210
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-t210-actmon-v4-9-442d1eb6377c@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758647133; l=4992;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=c3UF+J0NFIjfjdyZNjJHy/D9Hy0JzM3QHoSqUqe7xkk=;
 b=kKOZJHcy7C7xYTI4sjBiVHRZ/QjSbg5uowuD/80WIXj5bhEQ0YLSW5SE7FeCXvOqfxCgxei5+
 ojR/V2uI015Bw/0y/APIV6Vo8MGo2dJnBEkg8pgAIfrvUg6keNuZ5dq
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

This adds OPP tables for actmon and emc, enabling dynamic frequency
scaling for ram.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 .../boot/dts/nvidia/tegra210-peripherals-opp.dtsi  | 135 +++++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |   7 ++
 2 files changed, 142 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-peripherals-opp.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-peripherals-opp.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..bf2527d737932a1f41aa83d61f44d87ba52b0519
--- /dev/null
+++ b/arch/arm64/boot/dts/nvidia/tegra210-peripherals-opp.dtsi
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/ {
+	/* EMC DVFS OPP table */
+	emc_icc_dvfs_opp_table: opp-table-dvfs0 {
+		compatible = "operating-points-v2";
+
+		opp-40800000-800 {
+			opp-microvolt = <800000 800000 1150000>;
+			opp-hz = /bits/ 64 <40800000>;
+			opp-supported-hw = <0x0003>;
+		};
+
+		opp-68000000-800 {
+			opp-microvolt = <800000 800000 1150000>;
+			opp-hz = /bits/ 64 <68000000>;
+			opp-supported-hw = <0x0003>;
+		};
+
+		opp-102000000-800 {
+			opp-microvolt = <800000 800000 1150000>;
+			opp-hz = /bits/ 64 <102000000>;
+			opp-supported-hw = <0x0003>;
+		};
+
+		opp-204000000-800 {
+			opp-microvolt = <800000 800000 1150000>;
+			opp-hz = /bits/ 64 <204000000>;
+			opp-supported-hw = <0x0007>;
+			opp-suspend;
+		};
+
+		opp-408000000-812 {
+			opp-microvolt = <812000 812000 1150000>;
+			opp-hz = /bits/ 64 <408000000>;
+			opp-supported-hw = <0x0003>;
+		};
+
+		opp-665600000-825 {
+			opp-microvolt = <825000 825000 1150000>;
+			opp-hz = /bits/ 64 <665600000>;
+			opp-supported-hw = <0x0003>;
+		};
+
+		opp-800000000-825 {
+			opp-microvolt = <825000 825000 1150000>;
+			opp-hz = /bits/ 64 <800000000>;
+			opp-supported-hw = <0x0003>;
+		};
+
+		opp-1065600000-837 {
+			opp-microvolt = <837000 837000 1150000>;
+			opp-hz = /bits/ 64 <1065600000>;
+			opp-supported-hw = <0x0003>;
+		};
+
+		opp-1331200000-850 {
+			opp-microvolt = <850000 850000 1150000>;
+			opp-hz = /bits/ 64 <1331200000>;
+			opp-supported-hw = <0x0003>;
+		};
+
+		opp-1600000000-887 {
+			opp-microvolt = <887000 887000 1150000>;
+			opp-hz = /bits/ 64 <1600000000>;
+			opp-supported-hw = <0x0007>;
+		};
+	};
+
+	/* EMC bandwidth OPP table */
+	emc_bw_dfs_opp_table: opp-table-dvfs1 {
+		compatible = "operating-points-v2";
+
+		opp-40800000 {
+			opp-hz = /bits/ 64 <40800000>;
+			opp-supported-hw = <0x0003>;
+			opp-peak-kBps = <652800>;
+		};
+
+		opp-68000000 {
+			opp-hz = /bits/ 64 <68000000>;
+			opp-supported-hw = <0x0003>;
+			opp-peak-kBps = <1088000>;
+		};
+
+		opp-102000000 {
+			opp-hz = /bits/ 64 <102000000>;
+			opp-supported-hw = <0x0003>;
+			opp-peak-kBps = <1632000>;
+		};
+
+		opp-204000000 {
+			opp-hz = /bits/ 64 <204000000>;
+			opp-supported-hw = <0x0007>;
+			opp-peak-kBps = <3264000>;
+			opp-suspend;
+		};
+
+		opp-408000000 {
+			opp-hz = /bits/ 64 <408000000>;
+			opp-supported-hw = <0x0003>;
+			opp-peak-kBps = <6528000>;
+		};
+
+		opp-665600000 {
+			opp-hz = /bits/ 64 <665600000>;
+			opp-supported-hw = <0x0003>;
+			opp-peak-kBps = <10649600>;
+		};
+
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-supported-hw = <0x001F>;
+			opp-peak-kBps = <12800000>;
+		};
+
+		opp-1065600000 {
+			opp-hz = /bits/ 64 <1065600000>;
+			opp-supported-hw = <0x0003>;
+			opp-peak-kBps = <17049600>;
+		};
+
+		opp-1331200000 {
+			opp-hz = /bits/ 64 <1331200000>;
+			opp-supported-hw = <0x0003>;
+			opp-peak-kBps = <21299200>;
+		};
+
+		opp-1600000000 {
+			opp-hz = /bits/ 64 <1600000000>;
+			opp-supported-hw = <0x0007>;
+			opp-peak-kBps = <25600000>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 2fcc7a28690f7100d49e8b93c4fb77de7947b002..f2961c9e12db1cf91254b75389779955f2a0956d 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -9,6 +9,8 @@
 #include <dt-bindings/thermal/tegra124-soctherm.h>
 #include <dt-bindings/soc/tegra-pmc.h>
 
+#include "tegra210-peripherals-opp.dtsi"
+
 / {
 	compatible = "nvidia,tegra210";
 	interrupt-parent = <&lic>;
@@ -516,6 +518,9 @@ actmon@6000c800 {
 		clock-names = "actmon", "emc";
 		resets = <&tegra_car 119>;
 		reset-names = "actmon";
+		operating-points-v2 = <&emc_bw_dfs_opp_table>;
+		interconnects = <&mc TEGRA210_MC_MPCORER &emc>;
+		interconnect-names = "cpu-read";
 		#cooling-cells = <2>;
 	};
 
@@ -1024,6 +1029,8 @@ emc: external-memory-controller@7001b000 {
 		clock-names = "emc";
 		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 		nvidia,memory-controller = <&mc>;
+		operating-points-v2 = <&emc_icc_dvfs_opp_table>;
+
 		#interconnect-cells = <0>;
 		#cooling-cells = <2>;
 	};

-- 
2.51.0



