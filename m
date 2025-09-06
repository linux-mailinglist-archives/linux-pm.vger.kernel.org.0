Return-Path: <linux-pm+bounces-34082-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E191B47710
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 22:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 495CA7C60AA
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 20:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C314C2BF002;
	Sat,  6 Sep 2025 20:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWFCuawi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDF329BDBA;
	Sat,  6 Sep 2025 20:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757189856; cv=none; b=ZlGTFX4RhO5z6UdF2hnE0R6xadFcvM+NnmeDBOAMwg+M2RBBMqlS/5QcE+12lHTxqVK1cQHdGtBKAjcDvCOYRa5t/WODiVsozpgtzPUo7pRSrB0TqaCaOcreZ9tPBUsyA/6XAFxbpEUrdnnCJUgfLsrVUOc8U9ETA4hoU5iWhvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757189856; c=relaxed/simple;
	bh=Xd0tRNw2ps86hJT24DbMzh+hXIm82G3Vlj9OA8R/33g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aefqzDMtMgl+NkiYYq/VtFS5C/Wl/aFyETKgANTb2zaehOr+68hlkw48jzkqQH3OpAWKzr6MgXFYo3ZCbu6n/ExL6h9SLhbbu/tk7xghK6WiSymTe3dfTNNGhCjpBEhp7eK7sgn6cr1OYIP60GEpQMFAnF0gmbeMyH6Fc6g0kR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWFCuawi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1E6FC4CEFB;
	Sat,  6 Sep 2025 20:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757189855;
	bh=Xd0tRNw2ps86hJT24DbMzh+hXIm82G3Vlj9OA8R/33g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cWFCuawiwmQk8/U/EPLBLf4vuXJX5OkY3QbR7IigiT6ClvN950THAMmRcQ7A3Kwht
	 XMkr4f18TEOW7jY6BK9c/bk6hy1ZaDoa52FI6wBgDQEeFCmRAcT939ppwy3FHcqJn8
	 nER79AXdx/xe3BPjYobd3NA3YQJqBdtXI8fkgkz+QyU0VRCIcu3tn5lkU41a8/1SQS
	 l3Iv5eVU+iISgI02Hsao55RMzo4fwJQapOtLzAQIWJ8iKTzEunLDhGV+L5ax/roAQX
	 zsfnfqI3DLCeLnnHJe4Ckj2cczVB2AU4TkiKxqBFGgIj1gm45heKMsB1HkJcQJAsWu
	 06nfreBkNZLig==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3E0CA0FED;
	Sat,  6 Sep 2025 20:17:35 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Sat, 06 Sep 2025 15:16:59 -0500
Subject: [PATCH v3 9/9] arm64: tegra: Add OPP tables on Tegra210
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250906-t210-actmon-v3-9-1403365d571e@gmail.com>
References: <20250906-t210-actmon-v3-0-1403365d571e@gmail.com>
In-Reply-To: <20250906-t210-actmon-v3-0-1403365d571e@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757189854; l=4992;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=BuMztMnAqa18LOpanMPfXZmvaUGQqA9O6CgvPF/UAwU=;
 b=eFekEBzfuYZIf1hLENyeEVVI0RDYPqtMvwfaX/vi62E9SVvKpTam39MEI9y+C+rFiqKSEsrLY
 xGPnyw0KE7LD34sZeDYucAIjzLZGZs2S9RNw/rRzkwoeSH4lmkGsSbd
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



