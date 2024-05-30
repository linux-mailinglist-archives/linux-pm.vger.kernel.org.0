Return-Path: <linux-pm+bounces-8426-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F938D4D24
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 15:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F36271F234D9
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 13:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89FD176235;
	Thu, 30 May 2024 13:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="QdoOIsER"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2028.outbound.protection.outlook.com [40.92.52.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D6E176225;
	Thu, 30 May 2024 13:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717076953; cv=fail; b=LE0F7haC18qBYSYclG1HjE9w3MYvjib3o2xcHXCJTyRVk+0Sktrjwwm1EgSQg7ArZMCgKhNx4j+PN/lVCaN4SSHWmwO/CuTe450wabNbcOSroWE03LPGroMXRxx7sH9dlj5wVeCvwbYn0JWNx/4Qi5P41QN8XjE32TMUhyD2sz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717076953; c=relaxed/simple;
	bh=e1QlM2OLDJfzWxcO+pmlfwMn48vErJvYrEkU7v4/y94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OhlpQ0JgzQtG1YCU9HOmvDcf+Rkw39DRXH8KfU9FUKwy0IA+wgtgk5NMBKGa7O6/t1KklpW7iKsTI857UpVvT090FJf8jKqEExH8vyrnXzUAINNP7rRxnKSlx4zNSxWO0gPUSQS3jZ321sDX0XL4Qpr3N7+lByFYjhYmsb8/Y4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=QdoOIsER; arc=fail smtp.client-ip=40.92.52.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EwGNxihuVk4M4+josK/ui3HYxzTY2B3nFrCrkUGSeqYjZkiw6INSwEychwSZTggf4jG7RP2JzoTt3nSCXAZlXmn7t8Ro5UTiFdiC5aN5dpWSnL0sjdIdJqjgaROxOu9ZmV/4emXaYi7VPTs7xeCYLsNQWV3y8/3IRSRrNCQiDDoKXUPdduySZjzSiN728rwn7JXnTni3dDkN8ZQvz/ntdkMogvoFBdfSxVt2ivdICv9QnZrtf6Jp63upEXSR/pPLRUN52koAYoE6YLEKS4KBIUBts4RZB/4cdk3Eheg4ii1GKx74eSyfkE5Jmj0NaLDp4s2nDz+6/WthMff8+mQ7GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GtGZvbT+opLTcEOyl33/qy+kzhnzNCZA6o30Kwn1ZU0=;
 b=bqCLsZQ78yXaA4OXgFXulGo8SDvwNKMAK72JwiE8ZiLXVhstm5oibeTYdPcV+oH49/63v7n3GeKrr2wkeCKFbziRrVXbwf4ywbvkW39FqvjYQW8ah/iQAE1SpttyfcFIUJojd4ihes7pToFCrExZ1nFFPG1f3NtlcZ85bi/Yu95ht10MLlcOeWGGWbUkTiCBO49ZWBLFtaIOrbqxgg+tdCDdT+NMZMxF6hfXAP+6ttz7hldE3P/dBDejX3Jb8YXLML73tWvtfbjiNV7dIgDfpSsxLDBc26Yp2XvYA8Mbk9wuDPuFiWFr3G3K4VFrQyIpfUzM0wbbQr0U/JfOfArjrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtGZvbT+opLTcEOyl33/qy+kzhnzNCZA6o30Kwn1ZU0=;
 b=QdoOIsERtH0Tas2HUeRc5d9Ye/ekdhfwir0enjsGtPbPgYjPPEUHVEOknowYKClpD41IrIO41AOx6xQG2Ybgq6LLRP0O2gVWQ24llNPUZbDyFm5ry3II67bfXWatgGGFn7gEKk3Yw5ENfCP1HBcrEEhUx7kClcXwJymKQg0nPgVDqBg2Rs/SFu0TNn/XVRx/D8Qqo2EMK/vFLNzRiwK4cO1/T1VYYBl7Zt/k9ls+x+7ndRpGFFq40JBSaieS2tbx/hjjPxIFKaQAt+9aMM1/r7WfJAePwu9oRnuJ/6vKSDKhoSxs2f60l/R5ouJmLkBYLw2jNGC0n3I8qbk7BcBg6Q==
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12) by TYSPR01MB5657.apcprd01.prod.exchangelabs.com
 (2603:1096:400:42c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Thu, 30 May
 2024 13:49:08 +0000
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756]) by SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756%4]) with mapi id 15.20.7611.030; Thu, 30 May 2024
 13:49:08 +0000
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
Subject: [PATCH 2/3] riscv: dts: sophgo: cv18xx: Add sensor device and thermal zone
Date: Thu, 30 May 2024 13:48:26 +0000
Message-ID:
 <SEYPR01MB42213647922C5B93C8D3DF0AD7F32@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <SEYPR01MB422119B40F4CF05B823F93DCD7F32@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
References: <SEYPR01MB422119B40F4CF05B823F93DCD7F32@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [cDqv6Z6241IZmUbL7wqkd8seSOTSEdn2]
X-ClientProxiedBy: SG2P153CA0036.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::23)
 To SEYPR01MB4221.apcprd01.prod.exchangelabs.com (2603:1096:101:56::12)
X-Microsoft-Original-Message-ID: <20240530134827.53431-2-heylenay@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB4221:EE_|TYSPR01MB5657:EE_
X-MS-Office365-Filtering-Correlation-Id: cd5c6725-0690-4bef-c82c-08dc80af4735
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|3430499023|440099019|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	4sDYTCID00s/eiq0M545+AAkXR+oaF3ejYE6OQJr4leSLkr9DHLriY9WF3LJJDKlWe8kxsHbDWk1cdD7eaCHoaIju2IUMvValEGJgBofzvXTe8Hs6YWmVG1cw2KQpgWEu6T2VAPaPxaLCc+Ev+20et/N64TU53g3YhDut4TFQHEOZF/iKV3jS2EfA3XI/5KixJ5wrSaJOkWpIOVXUpIJgdDuPzmp8LBl4VrEIWWF3vXMVkVJFok3+acUZWVM9PA21u7VEuJe8MAHhGIuIE+ZKl/0rkTDjksD8bOrDLm5tjh7WJl9m8UEeH6JnaVM3B5mOTH0qHTKWXkrl0Uo5/YIRudo6IVJmKBgjOAy4rmud+4/cbxHWs5ljFarTmGB96ec3w7/G2b0ooXtp4wLc4l+Py6DIGFNtZ341F/qV9wOApOooCWP0Iuo76RKu3hjZ760lOjdrssy8BDxih+kvx4Yz/xaoLeqPKED0Cl/rCFGsOZz0BB72Qqpg2pWXcFrBnZmZL/5iFHX3Mlbz0fyj4hM2rfvnwLwLubXGiE3VcAzwimKROmJCpLUTkp0u2fd7Wl1p7yWnlI8YdLlt+cnzwh9Tm3ZgAgcZ1BP9u5ajmv3IYUi+65hpZV0X+PzaWTBppNC
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OdILJRq6SHzwPtF3IDlMfb2WTC8PVwO1FFGtQY0oLlHA7c8rOA21d8BLifDi?=
 =?us-ascii?Q?OYFkYIa+FBU97D8pRPqJ9KkeLupUY6nX1d9MFkD1D18andCeUy6DSfNas8YK?=
 =?us-ascii?Q?YgQpy0+8AwKz5i54uxaovgVjCI8BJnw+MyOOKWLmgs+76bt675Bg0Dtuw5pg?=
 =?us-ascii?Q?/hEUSKFVxd+Fl6FU13OKqRxvqvb8ovH6GWWPNG196jvXtzTbZeqK3h50xMyj?=
 =?us-ascii?Q?cUOnDGwe50zNJTFHy6r4faslWiV6a9rMCU5i2AsAFy8BZF9b8z9dFEMYlJsD?=
 =?us-ascii?Q?OO1Kemuwn3QnnV3N2FO48YXJZmDVP1hNC+ia7gIrezSjji/vfwpyGSVSgUcf?=
 =?us-ascii?Q?kLiJ8CIBj9uMVpYBh5QtQSmuJSRlTyU1heoibgqzHzVieQdYRkH3s/xZZSjV?=
 =?us-ascii?Q?q55zmKDFyneVdrVto5XCVNN9rXrL91A99F5TDwib+wCnxgqOITFVam5FK8Es?=
 =?us-ascii?Q?VfoYh4eKU8Q6YoPpJLx7KqQUn0XkUK2yoqgAbpZhsE68UG8KYdcDd4y5MGPy?=
 =?us-ascii?Q?oAzbv6JTcWFDtOzUIF+vM3JIsDphuXXcbCBeZLIWTzobm4Szt347+rVJbQFm?=
 =?us-ascii?Q?gxXlNqz5uqc5CLegAf4iNPiTXJFgmDMgTVYFGjt/7obC2S4e30/e2sEGkHOt?=
 =?us-ascii?Q?R8YalFMchVjquiWR009S6hI+m3z87b93l9l4SFohwGvI3AQQSzalPFSBrI1l?=
 =?us-ascii?Q?k9rsHGygbS5nAGswbopYBFdzfhVurycs4VOj0tALWT0pizomgiSAIIeK3Phl?=
 =?us-ascii?Q?Tol4hXGbOKSNdUr7ZwcNw5XF8orKFifeVSRVIwER6dHkQ1mw0nyMQeDl1zVN?=
 =?us-ascii?Q?8O0ZRxqfia1Vg9oBjwfMK32F1NnBhA3620uckU7S230JbJH0BYG72tuQsJfK?=
 =?us-ascii?Q?gG/M7/J8FA3LZRefX+UXSaRBjbewm2pYz37BU25prFPDYUsuvZNiVAg/1yBL?=
 =?us-ascii?Q?6CwIX1PCLmAjf0jnUc3DY2Sw2MEFlf2bbiwZVG5os9SyHBKEFtXsF9FMK3RE?=
 =?us-ascii?Q?+eTSShnGusNsuCMS8xvhoJLIrPYPZi5tBCzIC5ZF5RCp0/Ujlzt4IWGJps8e?=
 =?us-ascii?Q?lh10Jbef917fPUAlBztxeqPio3UB9XHg12xfsOMJ+Gq16euyHEKst6LJtaYK?=
 =?us-ascii?Q?Mok6mpAphpTS5fE7NRNizX39c6LIMUdbnCGEdZufRqkYpe2UULj854wtrw09?=
 =?us-ascii?Q?knFGmAcNxBlKV8G9rPc1o2GkDvIsHHbQ2D3m4eThdhLBk7BznaInaepV2AY?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd5c6725-0690-4bef-c82c-08dc80af4735
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB4221.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 13:49:08.4807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR01MB5657

Add common sensor device and thermal zones for Sophgo CV18xx SoCs.

Signed-off-by: Haylen Chu <heylenay@outlook.com>
---
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi | 36 ++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
index 891932ae470f..dfb4bb6eb319 100644
--- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
@@ -310,5 +310,41 @@ clint: timer@74000000 {
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
+	};
+
+	thermal-zones {
+		soc-thermal-0 {
+			polling-delay-passive	= <1000>;
+			polling-delay		= <1000>;
+			thermal-sensors		= <&soc_temp>;
+
+			trips {
+				soc_passive: soc-passive {
+					temperature	= <75000>;
+					hysteresis	= <5000>;
+					type		= "passive";
+				};
+
+				soc_hot: soc-hot {
+					temperature	= <85000>;
+					hysteresis	= <5000>;
+					type		= "hot";
+				};
+
+				soc_critical: soc-critical {
+					temperature	= <100000>;
+					hysteresis	= <0>;
+					type		= "critical";
+				};
+			};
+		};
 	};
 };
-- 
2.45.1


