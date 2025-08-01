Return-Path: <linux-pm+bounces-31739-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9150FB17E09
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 10:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21891C229E6
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 08:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CD61F4188;
	Fri,  1 Aug 2025 08:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aOcQj0RT"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011068.outbound.protection.outlook.com [52.101.70.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D1020B1F4
	for <linux-pm@vger.kernel.org>; Fri,  1 Aug 2025 08:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754035750; cv=fail; b=prtCb0oHNOGvmUpBDKq5eQ64qOO0CG3x4m7TpZLyC6ZQdI5Z+dccGRd7QOJ0Zd7Zv0NRgPL9T5ZnRho4GY92XKQ5vCSERNYUtu5AP6aB58Dk6Xd7HxIa8yPCRSYNQc1mNA1wNjUfGbs6p1cDAOGraigCAgNgkR7yq34DPHGv8RM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754035750; c=relaxed/simple;
	bh=tLu1gomK1QbdJlyZoQLD2zE6K/hDkHv3DZTQ9vAcBso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OKt/Vs2fpf5ZhY3G2VbvE38pK1j1gZiGfA5wHtFW8mdjb6ity8+a7vkoQgb19b24leJNc1TN/lrapXsHkVFBzT/h2xmUySs+2fIQLLH4d7SzJOM9vKHF+drKRKrSdQQ9zzQf/fdOtO9FFSqfH2tElUseZbut65W7d8PtQYH9lYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aOcQj0RT; arc=fail smtp.client-ip=52.101.70.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PkwmpNmE8XVfUKfybHyfX6onetbYD76FneRlPLvHD9dtv8+D0OZLgIJN1df5wKe8UGdz7wCSQ1BTNrtg8HS+FWsOwZdFA+/i79kc5KsU/xUhg/ljxa4MvX5YDGbYOgqOzkMaUr5GZnPD284O1lo1l9awQpVpdx7sgDvKxYtD8CP8FNAAPq1Z8eUsuJO0eL7Pl5SmiYcSDpHrjaafVKbtGAbDt0Dc0XczMY3O2Rw+TJGif5jRr03fMQ3J0Yzx+NLdjDfQAfM+xPc0YU0/YKH2AWN/tQTablZEroTpWkFXVlizX+nqfRp4JVsPi73FlyzJ+ZJpPpCfBFiy+iuS0TvIGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Bo1M70aVU9uB6+S9+3myvlKh6FXn1oNOX2U/DuumPU=;
 b=Bh3znIl5aimyPQK8QwVWbzeOGMKZZTnIGQOR+X50jqvcOZb18A3rVY9gi6ChitajWg7qvvOuC5EopPsGcIFEmZZw5LW5WWh1FVBm05hYSLyt278WMF445z8+tTGjlFTUxzOILoxAv87POg/bf4wiISpDq9WbGAWQszjoBW/TB/qP9KZT0s4RGpk93udNsLiV5DFZnoLYtJkxI7NE7zqzRyRrwwLTDemLt2YL9LOZt5TA1bdxzaOoYUQNuDR2J56TtN1ic8s11FTDH8+SmwuBO38CpWb9Q5zB0xZAPcFifF1w8cU3eCGAXGqqPAoM6Z1PctgZnxFFG4c8mf/k5CfjkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Bo1M70aVU9uB6+S9+3myvlKh6FXn1oNOX2U/DuumPU=;
 b=aOcQj0RT6sN/nMQruVV3Z6ETZ1kYil9RLu+0D0LG6rUAk4ZkTvER1/46cwBmVwkqNNs4C0dRfop1I6gNaqgHgSWjWaGDX3N/zsDlvhRBk1KdkL4jsK+MABRuT1wsgzwu0pzLPue6cUL1WoBSC1ZYTaCV7rFWXVp9s2xxy8cGFCeKiHQSQZZhLGk9nij1xNsYOrR4dFaGUzj9PbJ6SdbVB+jKRPzD2gSQHoLwXy1F69kOj8jKp8/fRitjg8lN1Iq5rj7w06LguZcszFSeYkCtRlWiTHiIiuy2BGeillK8hzw/y5CcbXzHUb5BkCEFY9maoY+rd58UmuE5duQk+WYiJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by PR3PR04MB7484.eurprd04.prod.outlook.com (2603:10a6:102:8d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Fri, 1 Aug
 2025 08:09:06 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb%5]) with mapi id 15.20.8989.015; Fri, 1 Aug 2025
 08:09:06 +0000
From: Jacky Bai <ping.bai@nxp.com>
To: krzk@kernel.org,
	rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	festevam@gmail.com
Subject: [PATCH v2 4/4] arm64: dts: imx93: update the tmu compatible string
Date: Fri,  1 Aug 2025 16:11:19 +0800
Message-Id: <20250801081119.1999298-4-ping.bai@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250801081119.1999298-1-ping.bai@nxp.com>
References: <20250801081119.1999298-1-ping.bai@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:4:197::11) To AS8PR04MB8642.eurprd04.prod.outlook.com
 (2603:10a6:20b:429::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8642:EE_|PR3PR04MB7484:EE_
X-MS-Office365-Filtering-Correlation-Id: 84ba0373-2e6c-4e3b-9540-08ddd0d2af50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vXzipq4tiN7RJisUn7QJQkI+ev0GhusiDQKidPbCbPbEHxoNF+7Nw7Jy6ST1?=
 =?us-ascii?Q?+e58smWFS+rInbinMRMtdnpvvQEs6Hk6D2pdm7Yx7/cSKb9+WGG40X6y1ZDe?=
 =?us-ascii?Q?2p+JnJIO0b5lQiSIfQsGac1LjrhyJ79tId1FWk+MSDAuq9HvLD4JWQ2D3OtL?=
 =?us-ascii?Q?g+XQZWunTVo9pS1gYjzHldXxXPxGuu+nhMqg+ER3p330w3U1jhc058Oq1ykH?=
 =?us-ascii?Q?QTo2/4vm/NwPpcL3WTe+3GC07SBAGEap74WKKc9Z05a65CWG9Ii9/Kko7iSM?=
 =?us-ascii?Q?yaaLqnHQ6CpAf6VgcPEBR+EzpqVhOIIlEaWa7dedmbChvvrnd/sHojWZn+Jc?=
 =?us-ascii?Q?KXYyBodPcfnBA+eM6WiCem5/+7u3ev4pHP454xYNZN29CPROHUjbyLoEBEB+?=
 =?us-ascii?Q?v2wzOGtR2g6CnFhtj6HHqAisL7+uKcMTJziMvAZYsPk3WU6Yx4MeTRwV4Bt2?=
 =?us-ascii?Q?Zaenv1XucQJur6HkGmJQ9Av4AsteHZgMlKjTMUp9ZJbCVBKOo00EQ1XDawes?=
 =?us-ascii?Q?Oho7c2O2SK0yPFugErZ9P26A/cbvtymRIx9gVTlA7zoOiQXO3k49BiDSdv/o?=
 =?us-ascii?Q?e4nK/RBAxB3nxvJve0iLHwWIMCmUGOz84x6U/nh+K2kuH4YySspa0gi2QtxC?=
 =?us-ascii?Q?xr1Y5ctVGlZ242W8v2G9ULd8LGDa791fjF8wKYcXu5M5ctvkI7yQX+++zVkV?=
 =?us-ascii?Q?eG80xcdIu8h/QCv1mMVifQYjqOnJb1Axpc4ZqktM8NjvjEKRYBGIU41xAJ04?=
 =?us-ascii?Q?RbdTTSJfIiAhKRmv+a1uP19ap8fer8esGnzYSQgARn+NlZ9R8P6qfiuzIvG3?=
 =?us-ascii?Q?EpqYtDIXlqxkMVGUVg1DBEcCKXN9Drv5iZ0Bl3teXEo17PW9CSYYhDMu5vA0?=
 =?us-ascii?Q?C6SU+c1m2xP4lRU79saDD32LcbcU4KvlQmptKZYv42eOiEiEj5zmF+ftJ6JI?=
 =?us-ascii?Q?ZZpdLFT6sF29Wy6LjPkR/oJCz9DJeqOJcVt0lDdhPsyQ7+ZjdCghDOynPfvA?=
 =?us-ascii?Q?N+1BjVaJMyM1qE+qbXJdbS3dLksAv/Vm7g7sGaYpakLDIf3UnYU0Ky5rpCyG?=
 =?us-ascii?Q?3+FhnJkEQiZl6ItrlseeYx5DYS7dPNKKriy75uqldlIN8mgHE4WnC8m3Q4zv?=
 =?us-ascii?Q?a5L8Ipg+voNmaPwAHgYyYBUWnsL+45o2HRaeAiw7bfXZXazpjKD40L47gzzk?=
 =?us-ascii?Q?FVvrG3+yOS91d5eLc8hUkl22cDxDjU3Vm0HMBZpn/BWrQFc7ZRfJP0B7E6IF?=
 =?us-ascii?Q?5Wn0n3dEOn1D2im1f1//FeTEqsPLNvPWpDkWEc7DTi49RbnocSKAuDovK3vP?=
 =?us-ascii?Q?vFB8oDyRxnJGxWW9zz9Ci24lkRIm/JgyPmO3+K25mxCgIkrDpJZ6S5u20/p8?=
 =?us-ascii?Q?h+rUX5sFiIsBRqEsyfoY+JgRXAiB7ULwmKvRHC+pbxluP40VoRtTJPskSZz+?=
 =?us-ascii?Q?yiAUfTRe57mNYuS3haWy3xXsiL+XEnyKy1vmg9bche7/9znwlwZoDg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(52116014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oDkFFbhUVQpM5WJE/DYNJ5EH7JBDc9BhtxOdnB3GXLdd40DuCjkKPUMP0ePl?=
 =?us-ascii?Q?FcgQNIWProp+wqAobTVLtzHHE0GGH3sY/auFhPmgko8k9yALYD7xQSLErwhb?=
 =?us-ascii?Q?M9DwfWxl+xYVIyP3e9vz8cP8pRqs3SudQFEe9AzqyZK/EstPL4n6gorTvAGw?=
 =?us-ascii?Q?2CN6vXuO5N5tHIY6ik3xVWp65sqIx+YsQ0b0C38VOppHoyugDpkMkFDRzVEF?=
 =?us-ascii?Q?oRLc2vU1mJNXUD0DQmQCQTpskb0OD0Jw6V3fVvGeEzbkOfLdQqr8j5B+8b97?=
 =?us-ascii?Q?TWPOpVra4ro9JIxtUQ68y7N+1XYWB57cy01ml3MNoXy/3+8wUJQ9fm1C+t86?=
 =?us-ascii?Q?rffCC49WoSJEjY88646QcMqX2r0JAWs4N75qTUBPexIYg8JdfJAdC1E8NM6P?=
 =?us-ascii?Q?x1k+f9cRCnoIswML+WqGZEnZHKqqvdK+9/aha3rpbslt0p0ACQmca15kXWIs?=
 =?us-ascii?Q?X3jXw/3TWtU3H6hv3a7CrfilnGsS5aV8NXINoOmxMYaZSl5RV31AV92TeEmr?=
 =?us-ascii?Q?3tnYOutwc/u6kjZw+bS0iPBJ3uBzmsv+RSugzX7t7i4abhz8P+CTSBMq/xV4?=
 =?us-ascii?Q?Pj/PGH3yktDULfzNdwh8L/TT8fxKVTEell0t2V0XhvmrEi0jeww6k8udxPOL?=
 =?us-ascii?Q?9CfN+LnLtRcHtyNNFHSP35/s1cgUzkztOfmwdAos05o7K+QGYIsrJzrmdIfM?=
 =?us-ascii?Q?pag0fVDSv7p6KELd/ffeq6w26P+nYzf6clKjJ4echTOh4U8P2DKdtaiZk8sT?=
 =?us-ascii?Q?3l3gz1qUt6orv8TT/G6fHHhMr70zS1d3tjzAbW94ksWAIvrGH49Eq/3rGb0P?=
 =?us-ascii?Q?6Q0TBdu3CdhUAE3o3B75W8G68RNkplg7G4F8YdFz5Z+ANGhEKTEi2sWYlWoI?=
 =?us-ascii?Q?h71bTbbQQ2kzi8JBWt/6w2VV9NR7SRcMsoKL1FGk7hHrfOg8SXCfqTveizMD?=
 =?us-ascii?Q?XiutDgwQ9G9+BmHaOwf1/npw9+AKkiklrd3TbLlMRasNTtymXBdQcbgG9ko/?=
 =?us-ascii?Q?s0iK9ZZsiJRUSvZq89zRr8FNkTVsBDVMcEaHUTynJ26uVWxqTGHPiJZA3Bb4?=
 =?us-ascii?Q?pDpZGJeV2QIcxglWZgg40QFVRjCWczBKjxia2dTwpr2RYqCuTt2HXmN+btPP?=
 =?us-ascii?Q?gB8OYsBOkRSuLiRXiKsSSCe2h0dEzvjPg5RCaqs7Vx0wCxW91wEa7Pnc0d+J?=
 =?us-ascii?Q?rXKFsh5XXD2ASTCFgOFvIKf6P0Y/YOD88qDI3XBD4EjoaCSQzjYnGD1wyCr6?=
 =?us-ascii?Q?WP2KE+mCLlsyQ6Sd5hvnWoFzn+Rg6cajn8hkDUeFIBFf5utoF8iNDxKeg2JS?=
 =?us-ascii?Q?HuVRUSoMvXzRwmxXl4okdgGbAwLacKe+TLPHEE8TfCiQJdbdYc6rII7RAuHG?=
 =?us-ascii?Q?VY/PsYaMU/dpwwwHCXVkqjgQE2UkstAYF49lMVe1nmdj3RBhtTcCGbibODhN?=
 =?us-ascii?Q?Rh4nINIFbv/iXArehwbmKChVAnvkuq4XzbHysU+AwgieBjamZ64JE6DR9HbK?=
 =?us-ascii?Q?KQtPw54EoPpKfIAiHHgXW+2NJZv4TAYsbo45v0v6oJXhUYU/caMdQWhgweVJ?=
 =?us-ascii?Q?s7e/21ZCcKrynyZ1c8gH+LdSq4hmF5n8ZzrPDqeR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ba0373-2e6c-4e3b-9540-08ddd0d2af50
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 08:09:06.2939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EN888rmOP12laGs6lLsH+jmfTbPZwVxgKp0iKVRUlVt5g/fXcvJ/3S3Go2Ebd52BstKcr1nTqOJUpyyxirTxqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7484

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


