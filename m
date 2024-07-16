Return-Path: <linux-pm+bounces-11139-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0FB932320
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 11:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D83D01F21A36
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 09:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8AE198A27;
	Tue, 16 Jul 2024 09:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="FSsyH6F4"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2066.outbound.protection.outlook.com [40.92.52.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6352198E9F;
	Tue, 16 Jul 2024 09:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721122987; cv=fail; b=FIWlThWmpmX42y+6HFfyfgqwzyrbuCuw8eHq/+f2m7g62BOpozsaKkQAfzufQnjADYP0JmfnBaDzIpNe7HsnWW0u23fEaLHEilLZdTiBo6YL6Ah/wTXyyh2IbrgrFSroipxOA0lfRfE52Tjodoc++EqDFRX4lxHavNp0t8bwtBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721122987; c=relaxed/simple;
	bh=/ZcINxLRjuvfr+0SHSDaAp6ZUB1avZp2OhaFzM/hmik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f3mj4PzwYxVOmC6BBzSHr1VXe1OU7WD1DSpDV1S7X3bhM/+UAF76VNx5z/cg0m2q1lJDePM4RM4/IVtxDYvM2Cxk5TRCQt7w23MzTQTz/RFIXl1XEI6dcQl//dQxJKELL4WHn2fiFFSMQothpvEwe9ApUNZLngmw8LrN6vfXaWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=FSsyH6F4; arc=fail smtp.client-ip=40.92.52.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMT+vXmcF4X6phnl4Yb8oAZWaQ7M/SLgTg/AyQA4r7+/lrKnf4NzAb0oJe9OysR53cBehNxLuYT+QfB3twQQ8B67RCEyotcF8akIp+A68lPl4rRdmdN9IBiy0ID6kIFcZG8EkCOMHoPM1DoJ/SnMA7ShiaPrvoOO6IcfPGG69E42k8qASrWYuwVW0cZ56d9CAYt+WcLPaQcUnC8iTEPKpEyPFIRPDcA+10Q9fOSCyLcGu5JBquG985e8pETqkZkhak6l3DeylFzzTgPfqOeW6ontD4yB7OHgAuKLG5kSxYtw08J5xL3FUz7pcE6TxK9xXEyz3VRSTgo4W4Oov1rDSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcjU6u+xZdT4at50y1D8oO1b1LKeJTwhS0qre43U55w=;
 b=pvjW6y6PWLdKPN05ZxAu6N8K1z7QzG3UZr/EWieMzUrizkfEP6q6M97LLsA+pudScwJ+KbJiuZd4rRxDj5FEVPbwlOenigIWfIwmnevM3SSXqfH94xTD2xO94n4xnQn2rBFDzQJ/FuNak8mT/gTr/FnDb2djx/VK1UMYELCVRG5tecLcTnfjMcon8NVF6e6K30HbHMMVrID9RLbGcpLHx5Nu3pCAuzNniaNhoYQJqyBndCHQXh3EwYeNE8+krcxEop18rzdMfOCXNgM55CbI1pBHjmXLZlCX2cWonOs0Yq3ahr3ZytOpp1WiVc9oxQ7fwje8kaqzbvaAyDrrDHU5Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcjU6u+xZdT4at50y1D8oO1b1LKeJTwhS0qre43U55w=;
 b=FSsyH6F41oi8itSNE2BwuGPOKk5bMkX868eMt/1WVRnJS2ejAnLF1cAr+Ab6OAX8sgnlNLb+nkFuvtKXvy7Vz0fNJWoJOhV+UkatDSlc2tRGFADF9IQ41A4a1PswkCcGEDGFGAXzrhAJJsRpInnr/alvX6ZU+Wc8EcUer3r8e5oaxOICbDQaOFAP+IBctHI+F1QR4pgo4pCFxrzD5p+GZVx9tS3d1lLosSQONS3ou/5TETyi4c3pKGg4JFdlQQlI0DbtefJy1mk85YJcvz+RAl1lQ8DnxX9vflc/lxg6NJtqm+sW7g2bUdibwQDw/hXmhHeg6pXoFJDxYX5QOPqfBw==
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12) by TYZPR01MB4895.apcprd01.prod.exchangelabs.com
 (2603:1096:400:281::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 09:42:59 +0000
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756]) by SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756%5]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 09:42:59 +0000
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
Subject: [PATCH v4 2/3] riscv: dts: sophgo: cv18xx: Add sensor device and thermal zone
Date: Tue, 16 Jul 2024 09:42:34 +0000
Message-ID:
 <SEYPR01MB42211B13FF62603E3E18B8DCD7A22@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <SEYPR01MB422158B2766DA03728AD90CBD7A22@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
References: <SEYPR01MB422158B2766DA03728AD90CBD7A22@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [Eo9T4eB2h0SntHEZUaT+rg5aja+x/XjK]
X-ClientProxiedBy: SI2PR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:4:197::11) To SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12)
X-Microsoft-Original-Message-ID: <20240716094235.51679-2-heylenay@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB4221:EE_|TYZPR01MB4895:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f41dfd2-29c1-4cc7-6aa7-08dca57bad9e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|461199028|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	pGASelZbKVobZLqUtgYm4Y5s9y+k6YIlQaP7toyXnYbPDrJyU3RiZtgTVdFeSUGcx9FLdCElqOovyfVAu0JSMjBlxqO42DEXA2GMq6UfgDjp22NqRrXJ3ec8ET/N9365kZE1r091TNzQ5w+Gdq+zQmaZv+8K9i4cXNw1DduUNmOiL0JnXDoL2eBc/nyOGvNj45c8HjPP8TeORxwaxQrvXsGamDxI86SKCSlx95Z8HFng0A97agLWEFVNz3Tf2d9n98A2Yd3YizIF3d9QPvtB+nqRLI5Bu0rWPyxFFS5W/2/AW0y0oECYMmAyXQkedaC3rkiez1DsATlXDi3RcHWnP78+JYGOW1gfqecJremXyrNwX3J5tYM4bFCF9gyfC755a8kJThWAMNqIH3MYvhQ+qFdkDia3n8b4Y5jillD8HXrjm/mxiteoR+1W0+Hmb8l+Yhgis2rmHlQZHPeBTxysxZgd5utpaK2glS/mt+MbmbQEh32+jwHC9wmnwL2vBFRRhqJMK1UHzYiWtANaQW8Xe7OnCkEaEVK2Vu1MiP6Kj06/F3BlpqZrwfIs3JDqyYUlhxa2HJm/l1iiu5HUKJJDsPVDLKsTe64x7T8lbGoW4UhB9jaH1SyU+89oIDuUw6j5BpkDzWQv0l1MxmsCyQu+XBaiAxsamKX6AX0ExzywFjT1Zkt4ljdpJeQBU0LRjgIr
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c7kDy3rorXMByYQyhMV0jIvga2In6417eRVKWR9WJaTYYMY29ZHK7Vmfzbr/?=
 =?us-ascii?Q?iW09kKJls7RwST2HiR6aJ28dNllaxiIDY4fULK5dCk5xh4JGcwZb6tlM/n4p?=
 =?us-ascii?Q?/rksAtzITQ4viNB19bNIfycYB0gNP9hwnmFVLJJSMckMFDWUQaMHo0wzZ6AJ?=
 =?us-ascii?Q?YDv00kqu3VqrwOTYZykjzejcEUo28BVzwUj+b07xRA/DcG/D+bSJRDSElOIA?=
 =?us-ascii?Q?84vSrJZO0cdFgQhuJ5fTR2sIQN0K36HnNhovC2EQmPxOlhgPPCYffwooXcmk?=
 =?us-ascii?Q?hYe3tnLgGWZriCe5Ov7gNs4GpJ+vfmAG6K1p6imMeaptj14hYKEDpsVQioS0?=
 =?us-ascii?Q?/RucQl8ynGDbO363+fxjWH+5tjkVqQhR8KgS13oNMqGsTqTqbjO6dhMtNvAV?=
 =?us-ascii?Q?dRhHJrQ6V2Q4eX1WMekencYFsijx5vsrhSC9ZsRcyn+S4GwisyE+66RfUHo2?=
 =?us-ascii?Q?ldLpF3f7Jgp8EqMi46mOnJhLuxJrdtEn5FiLVzQNTCj0UK1NnljF/f7MyVRN?=
 =?us-ascii?Q?6bSgJ9AeifmvKqCgwkCHerOmhRWq0QIWhWDSBOs9GH94mxzplxsODhmpjH8i?=
 =?us-ascii?Q?yHa1Sm4giV2pIvtS4O3z5rrFl3jrAvL5aHSABwVxwihdhsbPHRTlRXoNJ7Kq?=
 =?us-ascii?Q?+ZH1XfkSkD35aumY7+dlUE9Ai+t/YnQLA92Tw0xtiPVqr5X1j42S3RHT56gb?=
 =?us-ascii?Q?BLrmCZpyMbl5N8ba0Hip3Q5AqnxNRCwOspXbzOsHuEDfUQO1Kl5ZCWiG9/A8?=
 =?us-ascii?Q?zggr6DJ+BtYWzKO97g3S5Czj1lB5vamQj+JC9FGoq/BKgwPdbIT4N51Zwl8x?=
 =?us-ascii?Q?XRx8bsG+WFCwrZM1ge0GBYaNqTisjfAICjV4LJKW1EVyoDDm6kpX1PLmIZLt?=
 =?us-ascii?Q?K5zUV8d9JW04qjUMPdEDw/MA+YwIx7F0k2at9C7SYb5T7VudOkHvut0W9jj9?=
 =?us-ascii?Q?pS9nLq4Ze7+yV3d35w8i8MdtOkMQfw1W8tixcaU9amSRfpAErO2RqWKfYu+6?=
 =?us-ascii?Q?LueFkFANPdm0gldolxNKerrr7ry0cHIWNKPnE7thhrhCeRqWOcihrAqUmai+?=
 =?us-ascii?Q?A1I1J172fUhe4MdrtqiNKqX4Nc0YyRMTNXQSFhXd0dgyL6eV2D8tS0ejmh6K?=
 =?us-ascii?Q?HjY4xt2mGA4rLOCnAuEVjXtE7/HpdaTGc/7E86fY91/NwrzEGRMYlpniBMC2?=
 =?us-ascii?Q?EP1kIJL7LmW9pjfaCRxIBOAoh/W7sv/hYS0J6ORLpZ7LlBCOgL7PLVzi/u8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f41dfd2-29c1-4cc7-6aa7-08dca57bad9e
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB4221.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 09:42:59.4496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4895

Add common sensor device Sophgo CV18xx SoCs and thermal zone for
CV1800b SoCs.

Signed-off-by: Haylen Chu <heylenay@outlook.com>
---
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 30 +++++++++++++++++++++++++
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi  |  8 +++++++
 2 files changed, 38 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
index ec9530972ae2..0b5c7bc94b05 100644
--- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
@@ -12,6 +12,34 @@ memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x4000000>;
 	};
+
+	thermal-zones {
+		soc-thermal {
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
index 891932ae470f..76b02cc279aa 100644
--- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
@@ -310,5 +310,13 @@ clint: timer@74000000 {
 			reg = <0x74000000 0x10000>;
 			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
 		};
+
+		soc_temp: thermal-sensor@30e0000 {
+			compatible = "sophgo,cv1800-thermal";
+			reg = <0x30e0000 0x100>;
+			clocks = <&clk CLK_TEMPSEN>;
+			interrupts = <16 IRQ_TYPE_LEVEL_HIGH>;
+			#thermal-sensor-cells = <0>;
+		};
 	};
 };
-- 
2.45.2


