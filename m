Return-Path: <linux-pm+bounces-8575-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 690FD8FB307
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 14:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B9E11C2182B
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 12:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD69C1487EB;
	Tue,  4 Jun 2024 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pzOR5sBN"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2024.outbound.protection.outlook.com [40.92.53.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0559A1487D6;
	Tue,  4 Jun 2024 12:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717505707; cv=fail; b=ijyDkd661fpW0Thf7y0dtA3/+fjRIPnLVsipTNyXbFJV/1VuxTHN9ijUcSNZFRaAYyAhvVSBw65jVU+aY22UiS63nJt9AlAJGCQgg6rAjypuWmj0ckJqlMclVwrvtqyu1O4q7Ip+hrjwE/1eLv3QW/bnJEN1nXH1phbAsBHm5iM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717505707; c=relaxed/simple;
	bh=BtQW6WAfCgPvuMVaKmtf6ITFNqRNzzCDENDNu88VuyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BCQFhE2pQBjRZh04fuVJIh4zhQnUNgEYb4yL+vyJCVeBjytjSU/y4nIjxYr/eitfh2BViCpd6rmvhQZ98oktXTYxqhXyAODEOyN4FWsA7+XuxDXpL0D1w9dp0iur1LZOHRO6o2KSE4vN0y4HtXkF/2asucgAhkeX6YwjRRa/94o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pzOR5sBN; arc=fail smtp.client-ip=40.92.53.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgdNPwu0Md2GuNW696dUjAHPqrzUhl2gyxcxGRwwS8WZJt+UsNFBcku5t9xSwxcnHCoAA3Bky+GGqKB+OY+OvhZ6yMj73w/4g8J3F13WF58zpslSe3YxDBEANcNs1jPiSTRr8mC5QECBpo0x9XGAmGYLPkkufXWgn4TlqMkQxT7uWEt80Vsf3tfw7xdzZkVDEyDSNmHUxTmuzZgGT2knjrzDozDy4zbRNebLZUioGxF+u+9krJB1qQxs2e7LxZYNTU9Wq1ytWpCGUVUxdH5yWOu2N2xgY2jk6X5G43j0WoPX6B2YAPYZafYH2nowjPlPpggrMnE07vw4e2iBjjrw3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CanOnmomuL8OhB7wn/HzJYLRKIYL6i7z4wOnYfojBT4=;
 b=OFM7CJNqF1GimnklmcDWHASBSGQN66XLhegMKml02yCbrkx+XDgijO6GKOWxShkDMG++tN+53OtpjTMx5qqvJKUWmCxm0cXMguuptgIbAdOGbGQV0CLR2/7XwgtfxiW8FjnSzG5DpEm4W9S5NUb8RIQFP5eYDdFz4WsJ8xAENwhMFeo21ifATIDEDhsg7/7TOsWVk8CDfUBInR5x2YOr0IDzuZBuWwBPSI/AnE++aicT/EZEo9hX/rW12lIHk1IsOOhSqLtkWMnIhDa9rTNW5O3kBALlSss2QlGPDg29N0tgiNJ8POA8xPDXvAtrUAFtUHd4QQO4sI5SnAgUr60DEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CanOnmomuL8OhB7wn/HzJYLRKIYL6i7z4wOnYfojBT4=;
 b=pzOR5sBNZ7ftp7yQtpbMeBTjk3WVwNGjZxBMRFF3L1CZoJoczZdonx8CDFyNJXA5Q+Y/uqobEr//HdsR38d7FLMF88/vDMqlEn2TpKfPHUmovl5qCUijNEXkcdO/Cb3HiNpBo7QBotyfJ7NZum5AlyK9/8R+MgcLdfGSlAlOImG7F7IN2d4J0KW/ATjJLcuDeK9tPw+Eq7C9bPOmzPG0lHPMW6RXYA/XHmqvTnjcJ+F6qj3EuKU/z7//75cAPtsrD5znoZEuJZ0w3flgfEZunVALQg8x4OPkKOhQcfQYy6owbMnS79ccUIBtRy6ZitbdFfFeerTm1SHBs0agFPri3w==
Received: from SG2PR01MB4218.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1ca::8) by TYZPR01MB5214.apcprd01.prod.exchangelabs.com
 (2603:1096:400:340::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.28; Tue, 4 Jun
 2024 12:55:00 +0000
Received: from SG2PR01MB4218.apcprd01.prod.exchangelabs.com
 ([fe80::7155:e92c:291b:fc1c]) by SG2PR01MB4218.apcprd01.prod.exchangelabs.com
 ([fe80::7155:e92c:291b:fc1c%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 12:55:00 +0000
From: Haylen Chu <heylenay@outlook.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Haylen Chu <heylenay@outlook.com>
Subject: [PATCH v2 2/3] riscv: dts: sophgo: cv18xx: Add sensor device and thermal zone
Date: Tue,  4 Jun 2024 12:54:20 +0000
Message-ID:
 <SG2PR01MB42184CFE2C3D3E210CC6F7DAD7F82@SG2PR01MB4218.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <SG2PR01MB4218013241B3EED779D3BAE8D7F82@SG2PR01MB4218.apcprd01.prod.exchangelabs.com>
References: <SG2PR01MB4218013241B3EED779D3BAE8D7F82@SG2PR01MB4218.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [Tqhe6//Jkf/ZrJg/frjR8BmonXGjNZOm]
X-ClientProxiedBy: SI2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:4:186::16) To SG2PR01MB4218.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1ca::8)
X-Microsoft-Original-Message-ID: <20240604125420.22638-3-heylenay@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR01MB4218:EE_|TYZPR01MB5214:EE_
X-MS-Office365-Filtering-Correlation-Id: ff353792-fef4-43eb-61b5-08dc84958ae3
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	Fyw8WZ0V6mdz/TwwrZo08S5+miVgjTDG3q1XSquEKJBKYL2KLBfVFLQLm2VOck7qtAafG4pQjsvzeHfHlm1Gl9wXkgVUcmVNKLuvYs8lHR9t4xRkAbKcfECnBw5KoMoy9eGe37a9QP1HUhfWfMgKW1vSe7DsHDqYcpwGY5oDRCfqLUQDK/BSLIcIM/oTIpsJveHxz79yQmam9WZOnk0lXvOZfq2kpXWenstQ3ERlTWkAwuhYVRvq0nw7Q1wvscl1ssgb0EDTJ9qe7iLZm9bSS1UxYdfUCLQ7EqEIvh4nwSJBMbHHC9R+ocE8g0ZDPFlJzJIRMB5447F+CStGqLcqaibpfIaA15l9PJrcXMss/xZBVEZlUihjAzT6p8Yy0C2i06oUVJ/jqNjk1U+bqmBGPMVWtsiJMdP4tg89wwCMVExW23PtKYH/UET6b3m5aF49AGC0C9UVC/MoOz9/tk19HbjbXFJ3nDeTyUWyXxD5T0Q8KKup6okjowORcLCKIyZFmYVMdrWfnpWTms/j7jRbdQEU9vRdvsY7uVYJ/bSC57TidfDPGoaq7Re26cHgY1U9xXwQ5DScNhHzXFDKGXXJoUycPxvTZav2YsYyeETyEorrBJDUtwiI6+64bAiH10f+
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u0B6MMhn6ceAgFlX2RnlQz9dfs8lhX+megcEnsGNq2UHmLl6hH/NW5des6Q6?=
 =?us-ascii?Q?veF0U9w280/en2ni+Jl8cHAQ6y+MLFpezBTKF4NHUfbvqSiN8R6DakjmBMB1?=
 =?us-ascii?Q?nWyVi/pgOHZu5Lc5esPcvLmjQisxgutqBVHOEMzYcjWDa6AMydW7O9ZrMTA9?=
 =?us-ascii?Q?ds96mYvEgyedaDqIHG2hjIONH+haYfyVYchveUOxQ6Mab6HpksZ7sN26ay6P?=
 =?us-ascii?Q?0BIKNufwqf63BWJQ5FMCqMGx1zymG1sR8KMzUYnIBNyqoqXKaCSlwTNFFf3S?=
 =?us-ascii?Q?ki5OBoYAVL5OAVayy7Nx4kTXHbguIl8OZCk4mLLFrdtUZIAUoJtDx/99rTvs?=
 =?us-ascii?Q?lJqxISUBR5uD3AOnikPbhMC5rYD9VngviwBFRx1lm5Us4AFhNQ7NBBdvf9bd?=
 =?us-ascii?Q?7+ofgRXwV1KQMJ7zhcYI5ZlsMnKOOBy67WD51YPUNTiEXfvQOiGlUnJdp5rc?=
 =?us-ascii?Q?DG+IUByjVj1VTTUlLDVQwajfmiCeW+dFn2o1LUvQ0p2usg/5B5rxlGF2j0kP?=
 =?us-ascii?Q?sPPXxR4Cj+BXRtyhnOG44yizJW9a/vaEWMapOO1tu6M9JLYd1gV5srgwi6Co?=
 =?us-ascii?Q?7lqayq1CcxPkF/6bG4Cx+jJylyRYtZqubGX0pIp9H61nBVWzlLhkDY03c4oC?=
 =?us-ascii?Q?zN8Z5Hc+2QN52dkT8m72oApcEYUgsFXGZzydAtuvqKgTr3bY5yLswxgZS2Nm?=
 =?us-ascii?Q?udzVoonsUCrrpWBzWWW0eomZOii3/0SMYxNmWdTX0EzugkmVsuDJ4pTUyyT6?=
 =?us-ascii?Q?LJLbC2w//THLBorUrYZBBBL9oHIKs5kqBDkTyPCnB7ZTiQ2h9mvgzFIkjjzi?=
 =?us-ascii?Q?XmX9QxgFA8ETDXXqrqwBQ7VFOu6hk+bHLqOtYhV2KqrCB6S0TAc3Wn+nF4+Q?=
 =?us-ascii?Q?Cb8s5l6zAdVTbRxceZkm0SkGW+NayBJAW2jbXktIu6IcOYVjUwV+hVJV1p+8?=
 =?us-ascii?Q?YQObp9w3YcNpbt4JjclAZBcXMVXFAcRC+g77HLJS2bAJf3ylmQXzHyt4uCHs?=
 =?us-ascii?Q?2n13PQvmU8OlkX3fOSNz8H/wTx3ZTguvCzh5bvt2a2rodFrouFMzqjx8Id5G?=
 =?us-ascii?Q?GLFB6FPrGE5c+vEyqiso2Tz6gR2vferIysSkymTiJhcAppD9Uaz5vylgXiDs?=
 =?us-ascii?Q?PxpSH/GCv7pQVxE79OkBF6vb/hYK+KnMyg48B9qfz4SBRrvHjOfNAqs6GUwV?=
 =?us-ascii?Q?RmFrstWtkwidxhmnfut2yuWag1LP+uBXYe/5KCFa5W0Dydw54da/iX+Hm0A?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff353792-fef4-43eb-61b5-08dc84958ae3
X-MS-Exchange-CrossTenant-AuthSource: SG2PR01MB4218.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 12:55:00.0110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB5214

Add common sensor device Sophgo CV18xx SoCs and thermal zone for
CV1800b SoCs.

Signed-off-by: Haylen Chu <heylenay@outlook.com>
---
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 30 +++++++++++++++++++++++++
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi  |  8 +++++++
 2 files changed, 38 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
index ec9530972ae2..9e669ab35380 100644
--- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
@@ -12,6 +12,34 @@ memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x4000000>;
 	};
+
+	thermal-zones {
+		soc-thermal-0 {
+			polling-delay-passive   = <1000>;
+			polling-delay           = <1000>;
+			thermal-sensors         = <&soc_temp>;
+
+			trips {
+				soc_passive: soc-passive {
+					temperature     = <75000>;
+					hysteresis      = <5000>;
+					type            = "passive";
+				};
+
+				soc_hot: soc-hot {
+					temperature     = <85000>;
+					hysteresis      = <5000>;
+					type            = "hot";
+				};
+
+				soc_critical: soc-critical {
+					temperature     = <100000>;
+					hysteresis      = <0>;
+					type            = "critical";
+				};
+			};
+		};
+	};
 };
 
 &plic {
@@ -25,3 +53,5 @@ &clint {
 &clk {
 	compatible = "sophgo,cv1800-clk";
 };
+
+
diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
index 891932ae470f..b165866d4cad 100644
--- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
@@ -310,5 +310,13 @@ clint: timer@74000000 {
 			reg = <0x74000000 0x10000>;
 			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
 		};
+
+		soc_temp: thermal-sensor@30e0000 {
+			compatible = "sophgo,cv180x-thermal";
+			reg = <0x30e0000 0x100>;
+			clocks = <&clk CLK_TEMPSEN>;
+			clock-names = "clk_tempsen";
+			#thermal-sensor-cells = <0>;
+		};
 	};
 };
-- 
2.45.2


