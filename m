Return-Path: <linux-pm+bounces-31528-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C54BB14659
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jul 2025 04:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A9BA1895189
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jul 2025 02:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C82E21170D;
	Tue, 29 Jul 2025 02:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="L/svBMRD"
X-Original-To: linux-pm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011026.outbound.protection.outlook.com [52.101.65.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4233920FA9C;
	Tue, 29 Jul 2025 02:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753756688; cv=fail; b=S0oOIDRCVr3geCINbNZRDkCx3pE2k39wxFcMQ6uYDAiKRPxlviIVH0WAUJIlbiYIniYX6KRUya0r4NP9QR/PF2BE6gnA3Y1XDrwLky85JM1m7JYFrKSeXy+UHtc3K7KKC3z8sVQEPUSFbFe9RY+Ibr63A0KSzfrrBue6L/eGCOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753756688; c=relaxed/simple;
	bh=tLu1gomK1QbdJlyZoQLD2zE6K/hDkHv3DZTQ9vAcBso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BGVDTqbONzM14VRU2sqg9dxEVFj8onGj5/MTbwECVeR/Gx1w21UQ4R3xxLUQ3frUXvqc8egmVEguQBtTjADDBroFO7kIXOf1p/SVGZ7GedVqFhqyPydBJ2mALIoMfZkgBsk9HQNXfEecarBIZpadVG5UU4RLTqtzJXVrSdKryBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=L/svBMRD; arc=fail smtp.client-ip=52.101.65.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BTEsdjZaZBwb/RJI6bsaGfATruSicObJDN7bCvHIFN8dcItsqeB/EngDUXUxMZJhbt5Rco7sOPeCyI5w+3+mxT+UB/J5uQi9GfXoqSn3d2nmg8StHMrN0/y/URUQHJpvOB05ZLy3J5EZue/BXAglBLu3ozgHQ92cyhR6ISG2b/wiSv0DEBB4bLzhqjkcyPPzgMU0pmHSSHv7dEIB4o9cP5r2BuWjRRaib9tOQ9ZSaA0beORBToPvLyNFm9nZZNG8jqbvP6OThnTIs0sBjsLFtFugPh5WLnt5zHwyfyTeO1DbOYBhphMws18CmRvhkp9gJbiUrcLcufQn002YEYhq0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Bo1M70aVU9uB6+S9+3myvlKh6FXn1oNOX2U/DuumPU=;
 b=QteU2iO0qh8gZlPlUXDx+RppojTq61XNnjoNejP3uXQo6efDK31ntaC2bn28ob7UfceAy0LFJKvmtyhwoxnOcxxl8l+/jo7srlXRkJJc37WifYiR1cb4RICN2OjbFYiczEy7C750LZCEiut+VqzY4uI3NcOpSWSCjYBuI/9ytPDoPkm79hn0z4g6Nl+WdyeM0R1HDuDx/0+KkBDnc0teIkjwhEeRHofquh54iPGsNmYXaOM4Uwx8m3aAmPeGao38DE2cfaghnYHyfjGl7CDZNRaPqVvVD4H5v/yjd6ecZFP5MfCH0c05W4We/J3C3m5M/0nQTRIFImIgWzAYA+3JnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Bo1M70aVU9uB6+S9+3myvlKh6FXn1oNOX2U/DuumPU=;
 b=L/svBMRDzB5DHfcBkgCPhwdHNZnA9xcNAKgtVM380xgAhWO1gdiN8SAZ3y64qY1KVTZpxWF92hUrZfg8X7i15KGd5afX3i/s7+tcTn9zUQ5QCpkYGUcGeskIiY+u2H/ogN4gGylBeZDBsoPz1pE6/MCTz8gySih3f8obXIB1kp3yk/CN/vd1BgkbwkFyNvkZdSlXAKVLaLwsA7NlRJsqhrY1VBa1Xb+7ajbaqtvdbR1zrks6gioButNRNGuJJOAj7SwHh2EJzLLme9q3f21iN1NtcQ+Wv+IIx4yG1kEgWqmpzmEoONe8xPZnYO5KDO5h/YBCz/QEfIEAh1mdcbjUFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by GVXPR04MB10732.eurprd04.prod.outlook.com (2603:10a6:150:215::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Tue, 29 Jul
 2025 02:38:03 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb%5]) with mapi id 15.20.8964.023; Tue, 29 Jul 2025
 02:38:03 +0000
From: Jacky Bai <ping.bai@nxp.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	festevam@gmail.com
Subject: [PATCH 4/4] arm64: dts: imx93: update the tmu compatible string
Date: Tue, 29 Jul 2025 10:40:39 +0800
Message-Id: <20250729024039.1223771-4-ping.bai@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250729024039.1223771-1-ping.bai@nxp.com>
References: <20250729024039.1223771-1-ping.bai@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::21)
 To AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8642:EE_|GVXPR04MB10732:EE_
X-MS-Office365-Filtering-Correlation-Id: ff7d894a-3f8b-403d-5c66-08ddce48f114
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PBLVTdqvtgAQVUvQbxQWEAkrHMxi75sgvsjiHtaQq4VBVx+19KIEa/6Lo/D2?=
 =?us-ascii?Q?+69aHK2xPXJvodTmLM2VL8JPVFUzTEGT6xgwzkwnnsLZcW0EHrufPfnMu/0S?=
 =?us-ascii?Q?Ys00c4tXVsSIVCCwmPOhFTtcQeKfHpV8nKIRG7j5Lz6T4YKyLvRq15PA/arp?=
 =?us-ascii?Q?AZw7V7W5ZhgfAwiasB6dLOoF1ZEqWMZJYXJVwpUO6KnqB677uKO0k356dXtF?=
 =?us-ascii?Q?/pqYBhTBOxiP0JgaEWVlIttXj1GjnFxcnIKbZJehwmU84FnjDMWLn/HFeUYj?=
 =?us-ascii?Q?CMgUwQWTIgecNZT7uJjj0km9tpUaTzbOVz1wh+La2HBTytipz88WkP6wyXYN?=
 =?us-ascii?Q?ZBTtgeeeEIy/th2w/72vD4cF9oXP3317QflDjgHxkbhnSBLKXIUQZotZ6omU?=
 =?us-ascii?Q?/83vzmyqcoDuzbnvrgcOPDhS0GiBF6WwIf3WOXdBI1Q12hnIXvJCjc2uaE7W?=
 =?us-ascii?Q?W3eXMC5wy3QBbfLGeos6HgrnZUnBHyeSiyQczeQvZ5iE0Cnu2nlHMi6qAZts?=
 =?us-ascii?Q?t03okulJ+CfbNaTtXz6M4VePD7UuvTnyBsfRT043TawL17Nhle5+zf1EWK1R?=
 =?us-ascii?Q?oTzXVE90QIPBg7Zu3eLjH3l03/Ue0hZkb7BbYyQ0qNMzpzTw/COZ0p8eze5W?=
 =?us-ascii?Q?730H0x4tT19ei4hS3/SVTOeRcjkU2lmSydPUBLWfDm/lTh3jCzF+auA3vrBI?=
 =?us-ascii?Q?r9rLqa56P+iByeoG20wP2IRU3+9u3n57Waa23GoOP9fgs2RHwscMPSrBPsNx?=
 =?us-ascii?Q?Pa18H3xwtJXdy2yp1KmhuPs8/U3qRApR9UCvvWZAxwAqQIpTzxEZ51E2fEs6?=
 =?us-ascii?Q?4IXmtsfEoKLugY7I5nyP/3dpvHWrqck3WqfTIr2EWPW2Jb3sRP90VOX+kjfO?=
 =?us-ascii?Q?kP2Cdl56fvdEkC/RTlQRBEdy16lCX59ajw+hlMQBm2KC6aMr7hwQxFZNitxJ?=
 =?us-ascii?Q?vYBcscwF5TByB9LqLl+Mi/1ZcKYAT0GKo1Rg74nz9E62jVtkHGUdT1vEfkef?=
 =?us-ascii?Q?oqrVbpfkcSjbN9fCjlxxyIuC2oan27WQDzLwV+X+51O9Zvb4v3mgaC0ajEnP?=
 =?us-ascii?Q?VsJIlEPGoZGwCrXhw9UMJTIDsENIrNDNtvrt29kMHiuPnfkc6PAjj3IhDDK8?=
 =?us-ascii?Q?+BQn51l/HHkOzMttXH+zAzUYKP7LwWU4DAikF0PknxXBH9apUyLnyVMv9sI2?=
 =?us-ascii?Q?RN7dkVJgeZxtF+rVZXa35PoKljc7rvXEuCIS6dR1goUj8MzF5Hj0EFxOF7K3?=
 =?us-ascii?Q?QzdLYcwWRJWVJLN6LQxRFAM+my+lKmtB17RIfpgDKLt9+0URHYqdiVr2M1KI?=
 =?us-ascii?Q?ALtAtXlX1Cv9WsSqUziueEkipHEhV2JRAueUI/EsTvg83lTHAGdHA2UuJvB0?=
 =?us-ascii?Q?7NhuSssAKdl912dSsx6g92dXYR8AOxpOfpqNzFrThayawYzWu3e7SxDyxxTf?=
 =?us-ascii?Q?uZRa4ComxBtT/Oj+/obD4EshFGCLsP/Av4SLJZKUN1HVc7rAxsAroQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MrRGX1R8oTraofMKNGDSFyEMW0/4Fni4Nx06URYEg7ow887jEWRtp67Rp2eA?=
 =?us-ascii?Q?FW+K9yirCkakQwHSW+ZpSyh9HE2JDKiS9q6qmXHUfwWtgODjjxYs4vzVJ5ZN?=
 =?us-ascii?Q?x/T7Hb09/fr3I2UsFdBQCR6umnff/SF4Fi2XnLkyLvBmLppy1cMB9n1utsDf?=
 =?us-ascii?Q?dmdXBGC1+kJ9MezqLHj2WXDH6GAECks2nWAeAdrUkm8p10hDxr6D98PtRMPW?=
 =?us-ascii?Q?qehTdliRl817XeIW1WHyjxvA87WhNQ1Xe1/+yu+Oo6uuRyuYk2RfLbn1NOTM?=
 =?us-ascii?Q?OYsnHy6l6rtuCXK23OMFDY/6n2191lTDBLzcm51w6B7Sot2TDUNY5EbOSGor?=
 =?us-ascii?Q?CzoVqqIQ4/zGpaLRC75MyZbVMARXxYUWQJCQ6gBQBdJDneorVQ1x8DSzkIKY?=
 =?us-ascii?Q?IfcHguUfXo67dabpdDOzcbTcdiuuzpQpWxtDs1TUxH0C+bKUQKCBK7lWULAd?=
 =?us-ascii?Q?56PcjV6Fb+puKsbLWM2cqRkVVAmF2y3TanZGKh8ICaYr8OFjSsDICjZUJRNC?=
 =?us-ascii?Q?OmQQFhLcAfu9EjQhxwFBSkO6gor/fFh9x2JNM8TQKjFZle0aitDxZp/AxTyc?=
 =?us-ascii?Q?bxX/CGPTQRgGxxVOfSwuoxu23qeBVShchFgEBPPDxsYIQ1i57vZFCD0tA117?=
 =?us-ascii?Q?nmghH7mZ5tAqirhdIiWhI0qT92xxfJqyahMHx7lkGRHy2J1teldhPuhajiuk?=
 =?us-ascii?Q?DRJpWUA47Zce1JeTFBcN3klXOGbyowYSovsRevru/04UqUIjISGUi69DvGfV?=
 =?us-ascii?Q?72lzrcsaJ50n8ItRDQBtS3iQxPDv+A9DzOd3E3DdR9PcEjCqYOObcDEzcuYm?=
 =?us-ascii?Q?AWKqgyIa7GysUnyESraSkBP13o/Bp3OCG6hjrhemnK8vVyou760VU68GH4ae?=
 =?us-ascii?Q?vTaVHB/XzlGW+0Uc3L9wu5C72+JQ1oKemV/NJ8Tn7VwC31Y0SoF9bU4NI9Zf?=
 =?us-ascii?Q?G2OIpJ5u2YWuMCHHLIb96XvtwQpm/v6M91KiSmKZInn4PS1D32YT+AaY4Zkt?=
 =?us-ascii?Q?vSFvuZKBETa+DnH9+Vox9vx2Nbi3n+6p4IbBqOAapXIbTVRmmviKYyOIzxFq?=
 =?us-ascii?Q?hruBS70GmadWqeZou+gFNQ8zCdewe1ZmPgScDfzw5DK2PcfFXzhc774jdQSR?=
 =?us-ascii?Q?Z/y1aCqtCcnCoYbRDpuZIqdFm5jbjf3EUKje1eRTt/0rJOMpcExa5AzK4Fwj?=
 =?us-ascii?Q?fS8F9R9IPe7qUb+2godFw9QeSko9Hbwt7ABdvRahRDp6voOKEF5RDj4/APa5?=
 =?us-ascii?Q?lo+sg8V6YQvC6bIsHl99kOanQwZCfOll6yyt088nyCTmij+SI9fJ1URiKasK?=
 =?us-ascii?Q?skx8J6iXEPfC8KDwHoNGliQrzjlXDwc/pxPDRgIZVRQvHlbRk5fmagTKltVc?=
 =?us-ascii?Q?1R2jl1jn7B4C3iJuryoL8IitF/UJDzj1QC2VuIs6Ex9l3DkdLq52j5aOyrwm?=
 =?us-ascii?Q?UWXrfdl3FyFQ31sZVkFqQAxgbCSCYI8oHusV8UR6pLwTDrId81AlJLrrWwhE?=
 =?us-ascii?Q?iPplAxlwaakA7T1Q/RGgv2Gm11qsXzm8NZvy8XNMJXqkMM6astzsRkVFlbOr?=
 =?us-ascii?Q?eGgeXRGIoMHXjUQlLMcwj4KmVarkWqtLWQo4oH3/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7d894a-3f8b-403d-5c66-08ddce48f114
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 02:38:03.8376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MDt/ELBKzEUtaeN4gGO7W9+ocG0MdDNXujohM/FaOzhpZx7+mKAUKhGKn5HfkJFF9fISTEwlzvU/9Wlcyj+UZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10732

Update the tmu compatible string.

Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 8a7f1cd76c76..2f1db9cbfa4e 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -544,7 +544,7 @@ clock-controller@44480000 {
 			};
 
 			tmu: tmu@44482000 {
-				compatible = "fsl,qoriq-tmu";
+				compatible = "fsl,imx93-tmu", "fsl,qoriq-tmu";
 				reg = <0x44482000 0x1000>;
 				interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_TMC_GATE>;
-- 
2.34.1


