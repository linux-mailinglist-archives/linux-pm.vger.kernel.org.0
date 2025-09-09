Return-Path: <linux-pm+bounces-34201-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF41AB4A20C
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 08:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADE1E1BC23E0
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 06:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F3E3043C6;
	Tue,  9 Sep 2025 06:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYKSEWEu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E79303A0A;
	Tue,  9 Sep 2025 06:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757398895; cv=none; b=car1HMPWa5mMK0PYBXUXZsRgtnhi8nO+Z/o5vkyHtSl2A1h50ruVJAJS/Emv9P/zh4c5d+EgI8ICk1uOnj29L4BzSjDw/7jpCBffdLvNqGSAIaIwrff1WBSSmu802m02KfdgheTY0qlv2lsjKlv199WmYvJQEOQMSA85gd0EHKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757398895; c=relaxed/simple;
	bh=so/6Lvkh7D0Xbak/MOpijQ4NlkUCx9YkMr63SoPhB/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OjRTSAiJ/cKtDm0YEMcbY8iF6RTXhmeqUedoeqh14vZ5FUqV3PV7vmnUjm/8h9guFzuk4PN2Iogwaph/cjUVkN6DJGZACLfn5/J+61zIqoFf0zI3v2xRBJrWlaRL58fWpnilbeJJMx6BQg049YSr76GnseWt2qSq4e6f3u9sbd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYKSEWEu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B87FBC2BC86;
	Tue,  9 Sep 2025 06:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757398894;
	bh=so/6Lvkh7D0Xbak/MOpijQ4NlkUCx9YkMr63SoPhB/c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=QYKSEWEunLO+wzwqqNErs48i1mIfmoy6QRRCQmOZE2CXNm//K3H6ZdZOgaUJTBaMf
	 EejNxZgfgukG83/V3brv3xXhBKFKUoQhZW3S3YUJNzn/yvuebeF9xD9F0MGmm0YfPB
	 9oBjSaZNBXBt4sazd1+BRS96/LlUNd4UJ0IEHzZcOjDUsH+VTXz6SdvSxAvqWXkpeW
	 ZyMvPDGNb2ideGxRJ4cGHUGGMp/pZsnU9ltwRE9C+P7cn4VJ/jxNeKsSRwFf076ysJ
	 cJjjBOZ4dwopWapAq3zp9ev666GXEYTfV2ilWosam9/J4wJvUSojamZ5uFJ4BfoHuF
	 4UsmeWeGpmEXw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC6FCAC587;
	Tue,  9 Sep 2025 06:21:34 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Tue, 09 Sep 2025 01:21:35 -0500
Subject: [PATCH v2 7/8] arm64: tegra: Add CPU OPP tables for Tegra186
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-tegra186-icc-v2-7-09413724e781@gmail.com>
References: <20250909-tegra186-icc-v2-0-09413724e781@gmail.com>
In-Reply-To: <20250909-tegra186-icc-v2-0-09413724e781@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757398893; l=9142;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=uZssU7heZXFbFMQlclW4XJXqxgp1LYUFan3iXKZGfg4=;
 b=QOq9Zgi2/T7xFuJ+D0DnP09EbkrRocXBH6KVeWk744qYlO8ThdXt414mNA025fl+bGNDyLD/W
 aZq+hfbaI3pAzNvBxgpIGxPViOCql2GI1YS0XCl4wuzWdpmd/nztv8r
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

Add OPP table and interconnects property to scale DDR frequency with
CPU frequency for better performance. Each operating point entry of
the OPP table has CPU freq to per MC channel bandwidth mapping. One
table is added for each cluster because the different cpu types have
different scaling curves.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 317 +++++++++++++++++++++++++++++++
 1 file changed, 317 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 5778c93af3e6e72f5f14a9fcee1e7abf80d2d2c5..d3f6a938a9b019a043ce2de7ec17bd00155b3eb2 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -1943,6 +1943,8 @@ cpus {
 		denver_0: cpu@0 {
 			compatible = "nvidia,tegra186-denver";
 			device_type = "cpu";
+			operating-points-v2 = <&dnv_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER0 &emc>;
 			i-cache-size = <0x20000>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <512>;
@@ -1956,6 +1958,8 @@ denver_0: cpu@0 {
 		denver_1: cpu@1 {
 			compatible = "nvidia,tegra186-denver";
 			device_type = "cpu";
+			operating-points-v2 = <&dnv_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER0 &emc>;
 			i-cache-size = <0x20000>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <512>;
@@ -1969,6 +1973,8 @@ denver_1: cpu@1 {
 		ca57_0: cpu@2 {
 			compatible = "arm,cortex-a57";
 			device_type = "cpu";
+			operating-points-v2 = <&a57_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER1 &emc>;
 			i-cache-size = <0xC000>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -1982,6 +1988,8 @@ ca57_0: cpu@2 {
 		ca57_1: cpu@3 {
 			compatible = "arm,cortex-a57";
 			device_type = "cpu";
+			operating-points-v2 = <&a57_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER1 &emc>;
 			i-cache-size = <0xC000>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -1995,6 +2003,8 @@ ca57_1: cpu@3 {
 		ca57_2: cpu@4 {
 			compatible = "arm,cortex-a57";
 			device_type = "cpu";
+			operating-points-v2 = <&a57_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER1 &emc>;
 			i-cache-size = <0xC000>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -2008,6 +2018,8 @@ ca57_2: cpu@4 {
 		ca57_3: cpu@5 {
 			compatible = "arm,cortex-a57";
 			device_type = "cpu";
+			operating-points-v2 = <&a57_opp_tbl>;
+			interconnects = <&mc TEGRA_ICC_MC_CPU_CLUSTER1 &emc>;
 			i-cache-size = <0xC000>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -2182,4 +2194,309 @@ timer {
 		interrupt-parent = <&gic>;
 		always-on;
 	};
+
+	dnv_opp_tbl: opp-table-cluster0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-998400000 {
+			  opp-hz = /bits/ 64 <998400000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-1036800000 {
+			  opp-hz = /bits/ 64 <1036800000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-1075200000 {
+			  opp-hz = /bits/ 64 <1075200000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-1113600000 {
+			  opp-hz = /bits/ 64 <1113600000>;
+			  opp-peak-kBps = <1600000>;
+		};
+
+		opp-1152000000 {
+			  opp-hz = /bits/ 64 <1152000000>;
+			  opp-peak-kBps = <1600000>;
+		};
+
+		opp-1190400000 {
+			  opp-hz = /bits/ 64 <1190400000>;
+			  opp-peak-kBps = <1600000>;
+		};
+
+		opp-1228800000 {
+			  opp-hz = /bits/ 64 <1228800000>;
+			  opp-peak-kBps = <1600000>;
+		};
+
+		opp-1267200000 {
+			  opp-hz = /bits/ 64 <1267200000>;
+			  opp-peak-kBps = <1600000>;
+		};
+
+		opp-1305600000 {
+			  opp-hz = /bits/ 64 <1305600000>;
+			  opp-peak-kBps = <1600000>;
+		};
+
+		opp-1344000000 {
+			  opp-hz = /bits/ 64 <1344000000>;
+			  opp-peak-kBps = <1600000>;
+		};
+
+		opp-1382400000 {
+			  opp-hz = /bits/ 64 <1382400000>;
+			  opp-peak-kBps = <1600000>;
+		};
+
+		opp-1420800000 {
+			  opp-hz = /bits/ 64 <1420800000>;
+			  opp-peak-kBps = <1600000>;
+		};
+
+		opp-1459200000 {
+			  opp-hz = /bits/ 64 <1459200000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1497600000 {
+			  opp-hz = /bits/ 64 <1497600000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1536000000 {
+			  opp-hz = /bits/ 64 <1536000000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1574400000 {
+			  opp-hz = /bits/ 64 <1574400000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1612800000 {
+			  opp-hz = /bits/ 64 <1612800000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1651200000 {
+			  opp-hz = /bits/ 64 <1651200000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1689600000 {
+			  opp-hz = /bits/ 64 <1689600000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1728000000 {
+			  opp-hz = /bits/ 64 <1728000000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1766400000 {
+			  opp-hz = /bits/ 64 <1766400000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1804800000 {
+			  opp-hz = /bits/ 64 <1804800000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1843200000 {
+			  opp-hz = /bits/ 64 <1843200000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1881600000 {
+			  opp-hz = /bits/ 64 <1881600000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1920000000 {
+			  opp-hz = /bits/ 64 <1920000000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1958400000 {
+			  opp-hz = /bits/ 64 <1958400000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1996800000 {
+			  opp-hz = /bits/ 64 <1996800000>;
+			  opp-peak-kBps = <3732000>;
+		};
+
+		opp-2035200000 {
+			  opp-hz = /bits/ 64 <2035200000>;
+			  opp-peak-kBps = <3732000>;
+		};
+	};
+
+	a57_opp_tbl: opp-table-cluster1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-883200000 {
+			  opp-hz = /bits/ 64 <883200000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-921600000 {
+			  opp-hz = /bits/ 64 <921600000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-960000000 {
+			  opp-hz = /bits/ 64 <960000000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-998400000 {
+			  opp-hz = /bits/ 64 <998400000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-1036800000 {
+			  opp-hz = /bits/ 64 <1036800000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-1075200000 {
+			  opp-hz = /bits/ 64 <1075200000>;
+			  opp-peak-kBps = <816000>;
+		};
+
+		opp-1113600000 {
+			  opp-hz = /bits/ 64 <1113600000>;
+			  opp-peak-kBps = <1600000>;
+		};
+
+		opp-1152000000 {
+			  opp-hz = /bits/ 64 <1152000000>;
+			  opp-peak-kBps = <1600000>;
+		};
+
+		opp-1190400000 {
+			  opp-hz = /bits/ 64 <1190400000>;
+			  opp-peak-kBps = <1600000>;
+		};
+
+		opp-1228800000 {
+			  opp-hz = /bits/ 64 <1228800000>;
+			  opp-peak-kBps = <1600000>;
+		};
+
+		opp-1267200000 {
+			  opp-hz = /bits/ 64 <1267200000>;
+			  opp-peak-kBps = <1600000>;
+		};
+
+		opp-1305600000 {
+			  opp-hz = /bits/ 64 <1305600000>;
+			  opp-peak-kBps = <1600000>;
+		};
+
+		opp-1344000000 {
+			  opp-hz = /bits/ 64 <1344000000>;
+			  opp-peak-kBps = <1600000>;
+		};
+
+		opp-1382400000 {
+			  opp-hz = /bits/ 64 <1382400000>;
+			  opp-peak-kBps = <1600000>;
+		};
+
+		opp-1420800000 {
+			  opp-hz = /bits/ 64 <1420800000>;
+			  opp-peak-kBps = <1600000>;
+		};
+
+		opp-1459200000 {
+			  opp-hz = /bits/ 64 <1459200000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1497600000 {
+			  opp-hz = /bits/ 64 <1497600000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1536000000 {
+			  opp-hz = /bits/ 64 <1536000000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1574400000 {
+			  opp-hz = /bits/ 64 <1574400000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1612800000 {
+			  opp-hz = /bits/ 64 <1612800000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1651200000 {
+			  opp-hz = /bits/ 64 <1651200000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1689600000 {
+			  opp-hz = /bits/ 64 <1689600000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1728000000 {
+			  opp-hz = /bits/ 64 <1728000000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1766400000 {
+			  opp-hz = /bits/ 64 <1766400000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1804800000 {
+			  opp-hz = /bits/ 64 <1804800000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1843200000 {
+			  opp-hz = /bits/ 64 <1843200000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1881600000 {
+			  opp-hz = /bits/ 64 <1881600000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1920000000 {
+			  opp-hz = /bits/ 64 <1920000000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1958400000 {
+			  opp-hz = /bits/ 64 <1958400000>;
+			  opp-peak-kBps = <3200000>;
+		};
+
+		opp-1996800000 {
+			  opp-hz = /bits/ 64 <1996800000>;
+			  opp-peak-kBps = <3732000>;
+		};
+
+		opp-2035200000 {
+			  opp-hz = /bits/ 64 <2035200000>;
+			  opp-peak-kBps = <3732000>;
+		};
+	};
 };

-- 
2.50.1



