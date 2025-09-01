Return-Path: <linux-pm+bounces-33516-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89442B3D76D
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 05:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40B373B420B
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 03:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8A823B62A;
	Mon,  1 Sep 2025 03:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPUeVGd4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE0F228CA9;
	Mon,  1 Sep 2025 03:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756697665; cv=none; b=huEZL1Cin0Pq6p7xWoirwXxGP9/v5HM+/SbgYR4wRoTJluQnUi3iuhX+49csoHhRhyblqcOgXV8MLOeVWfVMTvT08Uxidgm3RX5nzw1eLHOXcVYCog81fzJ5i0MXA+sk+HI+1sutqJOn2quzcHzBh9GDaJcUa9JE5AlNWhb90Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756697665; c=relaxed/simple;
	bh=vfzUjAHs9kUUHExooapNFCCi682+vu2TqjIXgLPwlhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gFRdk6P9jd41X110dhw4xK+CALgucwy9oJYUXvtyIiPN/pWP2AyuEuTlksx+1YkU9NS9BF6IV3/EgBVXx08f+uStFUqNAdxVeJt5A6aJsx7yLfrWYyMXJ9RwlziC1qSg2xNuLYn37j0Am1k+7EvQqIObu377skqr9sflSoFlz3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPUeVGd4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95774C4CEF0;
	Mon,  1 Sep 2025 03:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756697664;
	bh=vfzUjAHs9kUUHExooapNFCCi682+vu2TqjIXgLPwlhw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KPUeVGd4FhiJTJBhsMsn3Qkmt1mzjAJeBACTuFrL2CoJD2ajPbIvdMcW2iUyLzGtU
	 lpXBJ1RH59t1DXR/FViH5SSevHpVv7RdbgkuVuD/I/Gr1RNBPiJ4B0zo6Tn2Ro3lL+
	 c6/EjqvTsK285r+2wJ0pWYxtMpqUMBacR4sq7i6KgekPTIDNGKrXBzHS3uBptemmrL
	 H+JcV2uMDy1sSzbMVD8B22b43nzwiLtJrV7ra/+GXuLb3A5QPQDFZ4eS9Wpd7u6uOb
	 vDP7mHZDRWSKzhZZtbBz4Ql866eA7sH3cOXHfkaS44nTAdnaUqhCqV1/i0mRps9WFE
	 HZJfujRKih2Ow==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C35BCA1000;
	Mon,  1 Sep 2025 03:34:24 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Sun, 31 Aug 2025 22:33:56 -0500
Subject: [PATCH 8/8] arm64: tegra: Add CPU OPP tables for Tegra194
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250831-tegra186-icc-v1-8-607ddc53b507@gmail.com>
References: <20250831-tegra186-icc-v1-0-607ddc53b507@gmail.com>
In-Reply-To: <20250831-tegra186-icc-v1-0-607ddc53b507@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756697663; l=16615;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=/lyxFq4FtwqFWSe2Uad7pZP8fOmf4A1pwq5iQ+AYobQ=;
 b=X78WLmcY/4LZPMDZZks8BfDNN+qSihsMN4LTQQVWUJuIaBUH2JpBAUbTZ6+mHjkJ2ipXNnf3z
 FfzqVqrvfj6CoNndjJ7FFf0Y9gUlB3GGJiDWjXJ9L3OLjq1GWgjj7q8
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

Add OPP table and interconnects property to scale DDR frequency with
CPU frequency for better performance. Each operating point entry of
the OPP table has CPU freq to per MC channel bandwidth mapping.
One table is added for each cluster even though the table data is
same because the bandwidth request is per cluster. This is done
because the OPP framework creates a single icc path and hence single
bandwidth request if the table is marked as 'opp-shared' and shared
among all clusters. For us, the OPP table data is same but the MC
Client ID argument to interconnects property is different for each
cluster. So, having per cluster tables makes different icc paths for
each cluster and helps to make per cluster BW requests.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 636 +++++++++++++++++++++++++++++++
 1 file changed, 636 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 1399342f23e1c4f73b278adc66dfb948fc30d326..a6c4c6c73707354f62f778bbea5afaec3fdbe22d 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -2890,6 +2890,8 @@ cpu0_0: cpu@0 {
 			device_type = "cpu";
 			reg = <0x000>;
 			enable-method = "psci";
+			operating-points-v2 = <&cl0_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER0 &emc>;
 			i-cache-size = <131072>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <512>;
@@ -2904,6 +2906,8 @@ cpu0_1: cpu@1 {
 			device_type = "cpu";
 			reg = <0x001>;
 			enable-method = "psci";
+			operating-points-v2 = <&cl0_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER0 &emc>;
 			i-cache-size = <131072>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <512>;
@@ -2918,6 +2922,8 @@ cpu1_0: cpu@100 {
 			device_type = "cpu";
 			reg = <0x100>;
 			enable-method = "psci";
+			operating-points-v2 = <&cl1_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER1 &emc>;
 			i-cache-size = <131072>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <512>;
@@ -2932,6 +2938,8 @@ cpu1_1: cpu@101 {
 			device_type = "cpu";
 			reg = <0x101>;
 			enable-method = "psci";
+			operating-points-v2 = <&cl1_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER1 &emc>;
 			i-cache-size = <131072>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <512>;
@@ -2946,6 +2954,8 @@ cpu2_0: cpu@200 {
 			device_type = "cpu";
 			reg = <0x200>;
 			enable-method = "psci";
+			operating-points-v2 = <&cl2_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER2 &emc>;
 			i-cache-size = <131072>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <512>;
@@ -2960,6 +2970,8 @@ cpu2_1: cpu@201 {
 			device_type = "cpu";
 			reg = <0x201>;
 			enable-method = "psci";
+			operating-points-v2 = <&cl2_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER2 &emc>;
 			i-cache-size = <131072>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <512>;
@@ -2974,6 +2986,8 @@ cpu3_0: cpu@300 {
 			device_type = "cpu";
 			reg = <0x300>;
 			enable-method = "psci";
+			operating-points-v2 = <&cl3_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER3 &emc>;
 			i-cache-size = <131072>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <512>;
@@ -2988,6 +3002,8 @@ cpu3_1: cpu@301 {
 			device_type = "cpu";
 			reg = <0x301>;
 			enable-method = "psci";
+			operating-points-v2 = <&cl3_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER3 &emc>;
 			i-cache-size = <131072>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <512>;
@@ -3181,4 +3197,624 @@ timer {
 		interrupt-parent = <&gic>;
 		always-on;
 	};
+
+	cl0_opp_tbl: opp-table-cluster0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-115200000 {
+			  opp-hz = /bits/ 64 <115200000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-192000000 {
+			  opp-hz = /bits/ 64 <192000000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-268800000 {
+			  opp-hz = /bits/ 64 <268800000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-345600000 {
+			  opp-hz = /bits/ 64 <345600000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-422400000 {
+			  opp-hz = /bits/ 64 <422400000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-499200000 {
+			  opp-hz = /bits/ 64 <499200000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-576000000 {
+			  opp-hz = /bits/ 64 <576000000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-652800000 {
+			  opp-hz = /bits/ 64 <652800000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-729600000 {
+			  opp-hz = /bits/ 64 <729600000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-806400000 {
+			  opp-hz = /bits/ 64 <806400000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-883200000 {
+			  opp-hz = /bits/ 64 <883200000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-960000000 {
+			  opp-hz = /bits/ 64 <960000000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-1036800000 {
+			  opp-hz = /bits/ 64 <1036800000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-1113600000 {
+			  opp-hz = /bits/ 64 <1113600000>;
+			  opp-peak-kBps = <1600000>;
+		};
+
+		opp-1190400000 {
+			  opp-hz = /bits/ 64 <1190400000>;
+			  opp-peak-kBps = <1600000>;
+		};
+
+		opp-1267200000 {
+			  opp-hz = /bits/ 64 <1267200000>;
+			  opp-peak-kBps = <1600000>;
+		};
+
+		opp-1344000000 {
+			  opp-hz = /bits/ 64 <1344000000>;
+			  opp-peak-kBps = <1600000>;
+		};
+
+		opp-1420800000 {
+			  opp-hz = /bits/ 64 <1420800000>;
+			  opp-peak-kBps = <1600000>;
+		};
+
+		opp-1497600000 {
+			  opp-hz = /bits/ 64 <1497600000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1574400000 {
+			  opp-hz = /bits/ 64 <1574400000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1651200000 {
+			  opp-hz = /bits/ 64 <1651200000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1728000000 {
+			  opp-hz = /bits/ 64 <1728000000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1804800000 {
+			  opp-hz = /bits/ 64 <1804800000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1881600000 {
+			  opp-hz = /bits/ 64 <1881600000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1907200000 {
+			  opp-hz = /bits/ 64 <1907200000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1958400000 {
+			  opp-hz = /bits/ 64 <1958400000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-2035200000 {
+			  opp-hz = /bits/ 64 <2035200000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-2112000000 {
+			  opp-hz = /bits/ 64 <2112000000>;
+			  opp-peak-kBps = <4266000>;
+		};
+
+		opp-2188800000 {
+			  opp-hz = /bits/ 64 <2188800000>;
+			  opp-peak-kBps = <4266000>;
+		};
+
+		opp-2265600000 {
+			  opp-hz = /bits/ 64 <2265600000>;
+			  opp-peak-kBps = <4266000>;
+		};
+	};
+
+	cl1_opp_tbl: opp-table-cluster1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-115200000 {
+			  opp-hz = /bits/ 64 <115200000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-192000000 {
+			  opp-hz = /bits/ 64 <192000000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-268800000 {
+			  opp-hz = /bits/ 64 <268800000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-345600000 {
+			  opp-hz = /bits/ 64 <345600000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-422400000 {
+			  opp-hz = /bits/ 64 <422400000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-499200000 {
+			  opp-hz = /bits/ 64 <499200000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-576000000 {
+			  opp-hz = /bits/ 64 <576000000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-652800000 {
+			  opp-hz = /bits/ 64 <652800000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-729600000 {
+			  opp-hz = /bits/ 64 <729600000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-806400000 {
+			  opp-hz = /bits/ 64 <806400000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-883200000 {
+			  opp-hz = /bits/ 64 <883200000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-960000000 {
+			  opp-hz = /bits/ 64 <960000000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-1036800000 {
+			  opp-hz = /bits/ 64 <1036800000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-1113600000 {
+			  opp-hz = /bits/ 64 <1113600000>;
+			  opp-peak-kBps = <1600000>;
+		};
+
+		opp-1190400000 {
+			  opp-hz = /bits/ 64 <1190400000>;
+			  opp-peak-kBps = <1600000>;
+		};
+
+		opp-1267200000 {
+			  opp-hz = /bits/ 64 <1267200000>;
+			  opp-peak-kBps = <1600000>;
+		};
+
+		opp-1344000000 {
+			  opp-hz = /bits/ 64 <1344000000>;
+			  opp-peak-kBps = <1600000>;
+		};
+
+		opp-1420800000 {
+			  opp-hz = /bits/ 64 <1420800000>;
+			  opp-peak-kBps = <1600000>;
+		};
+
+		opp-1497600000 {
+			  opp-hz = /bits/ 64 <1497600000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1574400000 {
+			  opp-hz = /bits/ 64 <1574400000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1651200000 {
+			  opp-hz = /bits/ 64 <1651200000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1728000000 {
+			  opp-hz = /bits/ 64 <1728000000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1804800000 {
+			  opp-hz = /bits/ 64 <1804800000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1881600000 {
+			  opp-hz = /bits/ 64 <1881600000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1907200000 {
+			  opp-hz = /bits/ 64 <1907200000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1958400000 {
+			  opp-hz = /bits/ 64 <1958400000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-2035200000 {
+			  opp-hz = /bits/ 64 <2035200000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-2112000000 {
+			  opp-hz = /bits/ 64 <2112000000>;
+			  opp-peak-kBps = <4266000>;
+		};
+
+		opp-2188800000 {
+			  opp-hz = /bits/ 64 <2188800000>;
+			  opp-peak-kBps = <4266000>;
+		};
+
+		opp-2265600000 {
+			  opp-hz = /bits/ 64 <2265600000>;
+			  opp-peak-kBps = <4266000>;
+		};
+	};
+
+	cl2_opp_tbl: opp-table-cluster2 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-115200000 {
+			  opp-hz = /bits/ 64 <115200000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-192000000 {
+			  opp-hz = /bits/ 64 <192000000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-268800000 {
+			  opp-hz = /bits/ 64 <268800000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-345600000 {
+			  opp-hz = /bits/ 64 <345600000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-422400000 {
+			  opp-hz = /bits/ 64 <422400000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-499200000 {
+			  opp-hz = /bits/ 64 <499200000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-576000000 {
+			  opp-hz = /bits/ 64 <576000000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-652800000 {
+			  opp-hz = /bits/ 64 <652800000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-729600000 {
+			  opp-hz = /bits/ 64 <729600000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-806400000 {
+			  opp-hz = /bits/ 64 <806400000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-883200000 {
+			  opp-hz = /bits/ 64 <883200000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-960000000 {
+			  opp-hz = /bits/ 64 <960000000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-1036800000 {
+			  opp-hz = /bits/ 64 <1036800000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-1113600000 {
+			  opp-hz = /bits/ 64 <1113600000>;
+			  opp-peak-kBps = <1600000>;
+		};
+
+		opp-1190400000 {
+			  opp-hz = /bits/ 64 <1190400000>;
+			  opp-peak-kBps = <1600000>;
+		};
+
+		opp-1267200000 {
+			  opp-hz = /bits/ 64 <1267200000>;
+			  opp-peak-kBps = <1600000>;
+		};
+
+		opp-1344000000 {
+			  opp-hz = /bits/ 64 <1344000000>;
+			  opp-peak-kBps = <1600000>;
+		};
+
+		opp-1420800000 {
+			  opp-hz = /bits/ 64 <1420800000>;
+			  opp-peak-kBps = <1600000>;
+		};
+
+		opp-1497600000 {
+			  opp-hz = /bits/ 64 <1497600000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1574400000 {
+			  opp-hz = /bits/ 64 <1574400000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1651200000 {
+			  opp-hz = /bits/ 64 <1651200000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1728000000 {
+			  opp-hz = /bits/ 64 <1728000000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1804800000 {
+			  opp-hz = /bits/ 64 <1804800000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1881600000 {
+			  opp-hz = /bits/ 64 <1881600000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1907200000 {
+			  opp-hz = /bits/ 64 <1907200000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1958400000 {
+			  opp-hz = /bits/ 64 <1958400000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-2035200000 {
+			  opp-hz = /bits/ 64 <2035200000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-2112000000 {
+			  opp-hz = /bits/ 64 <2112000000>;
+			  opp-peak-kBps = <4266000>;
+		};
+
+		opp-2188800000 {
+			  opp-hz = /bits/ 64 <2188800000>;
+			  opp-peak-kBps = <4266000>;
+		};
+
+		opp-2265600000 {
+			  opp-hz = /bits/ 64 <2265600000>;
+			  opp-peak-kBps = <4266000>;
+		};
+	};
+
+	cl3_opp_tbl: opp-table-cluster3 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-115200000 {
+			  opp-hz = /bits/ 64 <115200000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-192000000 {
+			  opp-hz = /bits/ 64 <192000000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-268800000 {
+			  opp-hz = /bits/ 64 <268800000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-345600000 {
+			  opp-hz = /bits/ 64 <345600000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-422400000 {
+			  opp-hz = /bits/ 64 <422400000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-499200000 {
+			  opp-hz = /bits/ 64 <499200000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-576000000 {
+			  opp-hz = /bits/ 64 <576000000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-652800000 {
+			  opp-hz = /bits/ 64 <652800000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-729600000 {
+			  opp-hz = /bits/ 64 <729600000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-806400000 {
+			  opp-hz = /bits/ 64 <806400000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-883200000 {
+			  opp-hz = /bits/ 64 <883200000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-960000000 {
+			  opp-hz = /bits/ 64 <960000000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-1036800000 {
+			  opp-hz = /bits/ 64 <1036800000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-1113600000 {
+			  opp-hz = /bits/ 64 <1113600000>;
+			  opp-peak-kBps = <1600000>;
+		};
+
+		opp-1190400000 {
+			  opp-hz = /bits/ 64 <1190400000>;
+			  opp-peak-kBps = <1600000>;
+		};
+
+		opp-1267200000 {
+			  opp-hz = /bits/ 64 <1267200000>;
+			  opp-peak-kBps = <1600000>;
+		};
+
+		opp-1344000000 {
+			  opp-hz = /bits/ 64 <1344000000>;
+			  opp-peak-kBps = <1600000>;
+		};
+
+		opp-1420800000 {
+			  opp-hz = /bits/ 64 <1420800000>;
+			  opp-peak-kBps = <1600000>;
+		};
+
+		opp-1497600000 {
+			  opp-hz = /bits/ 64 <1497600000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1574400000 {
+			  opp-hz = /bits/ 64 <1574400000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1651200000 {
+			  opp-hz = /bits/ 64 <1651200000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1728000000 {
+			  opp-hz = /bits/ 64 <1728000000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1804800000 {
+			  opp-hz = /bits/ 64 <1804800000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1881600000 {
+			  opp-hz = /bits/ 64 <1881600000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1907200000 {
+			  opp-hz = /bits/ 64 <1907200000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1958400000 {
+			  opp-hz = /bits/ 64 <1958400000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-2035200000 {
+			  opp-hz = /bits/ 64 <2035200000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-2112000000 {
+			  opp-hz = /bits/ 64 <2112000000>;
+			  opp-peak-kBps = <4266000>;
+		};
+
+		opp-2188800000 {
+			  opp-hz = /bits/ 64 <2188800000>;
+			  opp-peak-kBps = <4266000>;
+		};
+
+		opp-2265600000 {
+			  opp-hz = /bits/ 64 <2265600000>;
+			  opp-peak-kBps = <4266000>;
+		};
+	};
 };

-- 
2.50.1



