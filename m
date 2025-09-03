Return-Path: <linux-pm+bounces-33768-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 863AFB42A44
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 21:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40C65484608
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 19:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA7636CC70;
	Wed,  3 Sep 2025 19:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcrmfJmJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E5F369995;
	Wed,  3 Sep 2025 19:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756929082; cv=none; b=VgNzzAHzWGRSCzIR9BHwIpLWUgK7geO9hBpOAWm5oSTEnreqrBkl3A/LdPuIfYd/lSHMi+a3UGNG8EeSKg4sE4cHJW1fplGClErQa5Mud7DvLnYNBXI7cJK/0fIKG4WxY4oeDoRickNOXgjSZc5akk3wCobcybreLEurSOI+0n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756929082; c=relaxed/simple;
	bh=Xd0tRNw2ps86hJT24DbMzh+hXIm82G3Vlj9OA8R/33g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YsYNvnIhInLKa5nl8NYAAnBNtZeE11mI+SMiddnYj6WHAyzHeg8SnnO5wSNd3SzWGOV6hBCkRjPhnir7lHXYh8sV5aadjDl9eSmxfDJThYpEMk4LKgYis2zU9kbZer82NpEzeB7xdLuL/WPEux0/wRjwFErZbwDTUhSKjYmyJBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcrmfJmJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57939C4CEFB;
	Wed,  3 Sep 2025 19:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756929082;
	bh=Xd0tRNw2ps86hJT24DbMzh+hXIm82G3Vlj9OA8R/33g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fcrmfJmJHnwQKScdguQ1uYtj2GhPVQFa5Fq2svgvy6cnCsKOc5ojGZrzfg0QCLCh3
	 GqGDDTdmDi4ZVtEowR81oDNjRRoNNIY/dauA5MTXwmZtBW+deLErHXjtqpSf+HsVOE
	 FvVh3abw46MbbU2SwuMXYFsCgKwvu+I6ZMDhakJR8JZgOV1geOLqYgMWYWyeGO14c4
	 twR/yIig55fipcbkCPZB9G1JudOu1GExCzNdfy6YUzY6uWWkMdIPx7mgpPzeGrnAQa
	 RQ/lpJySlQtoTbcYpCRokSupVjNje6JUoc4Dyc/mTZHC+o+lQgSNj6OocaNxbK+Jc2
	 yLd0M6H8Woo1A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E811CA1017;
	Wed,  3 Sep 2025 19:51:22 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Wed, 03 Sep 2025 14:50:14 -0500
Subject: [PATCH v2 8/8] arm64: tegra: Add OPP tables on Tegra210
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-t210-actmon-v2-8-e0d534d4f8ea@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756929080; l=4992;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=BuMztMnAqa18LOpanMPfXZmvaUGQqA9O6CgvPF/UAwU=;
 b=miTCqaJTF7Z6CMFpHfUX7yUg4mXsyzbJAYSjxF4Colc94wdeub5zc7nIuqQBh8TBv7fuKrRHS
 B40PCiHuQGcDlv7RmpO46VYQSWn+Nbel3/7HOepGjOtLjL+RUuDNw7Q
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
2.50.1



