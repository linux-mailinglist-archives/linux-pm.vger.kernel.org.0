Return-Path: <linux-pm+bounces-28659-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70835AD88D1
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 12:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 210893AD081
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 10:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AAB2D23B2;
	Fri, 13 Jun 2025 10:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kX3hH1sO"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011005.outbound.protection.outlook.com [52.101.70.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2962D2399;
	Fri, 13 Jun 2025 10:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749809188; cv=fail; b=Ljitq0/9Y0UKtf32MECvZDLsZtqE8pq7N4B3+h36rbLtb2twr8sKUNuyJpXEp9ZPrSw6FDbIg+CzUgx9V4vUo4eWwWzdOjdPxccdIPok9HuG3rVv2ZuLRcBRAG3eCijOdYANqBY2aUfFO18+2qLiRtjT4o7zkuxGlUtcSdC23h8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749809188; c=relaxed/simple;
	bh=Mdmcf9ZAZunwIMz/AqQJYzCHLS7ZQaP9Fb12AHXOpnM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aa4FnvYkN3KNibr1IvanwO3V6sJFMJ4n1jfLyFL6RNFDr4DZfsT1hR9pU/SmRfVim2VsIt/2g2FCe5/Me/upGx7d8BmaWcjidEcsKKJ9Hdw1kRXS5RKVEFVfiPRYRn/FLjWhVop8cXDqZpBW1JJI7ZVzIH1qURsG5JJ1WIB+zkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kX3hH1sO; arc=fail smtp.client-ip=52.101.70.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cdosrhIGMKjNWxEUuQXoYFBPWXCo8QnXrGowEZgbLscqiG5CSxnLvv1RlgRJAh4H6QeInFzLiZYb6RPUA5jPEMgMk3MwUoLHSTR4364dmJj0uPHjh9qHUTFungEBm6uMbptNCRwMAYi0oEsoNCeivqrVPgCSMV89Bu4v4/2wPBkXmAUTMAbeEi7/ryOi4j731lzyanwQLbew0l8Nr5xz7MS3wNNo8vRj4N0WgMHmpcgIrt2lznS4wigolIfj/swujxHqhH75WciSVCzxJSqVbz2+fojB+TjqvZ/aQTI3OIkOfqU8BBiYBjScm8b3AIBb2PJJbkncNcgSBn3lG7Pkog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9xqbrsSOH2z20XiNB5+mivIeqiJ52KzLWXDL9kQ1to=;
 b=CphOXtzs2rK8hzv+59lb47O7zcUb88B6Gajkz/0926qRXSwpzb+rKH3IETgTe6GfW1Ktsg462JiA6jeMbyrkM7CmMK4TcGEzAapaBQCcmB1kKCJSdq4g12lF28M3wkY3gHLJzfUkuN1sJ1j2osrRuSVfq099fxZDwGnbRV3oO5SZIUfQg28Pyxakuk9Ta92woBQcyj9kp2ABiLYKKWcyCCOp84IYWb2W3Y3gYtEAxYy8tozna6xz3VL9YqFSMj4rfCB+uQ5SIT9VUJU7/pdoW4dzAaeLjFmorTx5wIfScVRlxLSqvQbK23KpCVHkMM/eueZcXrAWyrzs9wug6t59Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9xqbrsSOH2z20XiNB5+mivIeqiJ52KzLWXDL9kQ1to=;
 b=kX3hH1sOuB3PoeRLeJi1hConJhmLqnREN4eJ2cj5+1FP9lhKS2D41R7fiA0q8F9Em1K+tsrDCTL6v5bxq/PbMiTFy7dtjn2wdogI2lxMnYZw2BNWLFB0WUYHrPQIhF1sKLB/xVrMpzvB4hvPRYu26PoatpoOZao9A4SRhDTLHKaMSGQDVr1fqG7FRRd/cyxbZDNxDpjcNwsykvJukFs90xrfvOhvpcUPY461LPsK2gVjGJYPG8KUeD7M+JB5yfLmmjN40UXXxGBpHWSBLcMUqo/1V1m+rvWK0ujgBW5eXassSZjBfaR2S3p66FtIcPQ3D2uW1l7X2JDLohitH8oTdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by VE1PR04MB7294.eurprd04.prod.outlook.com (2603:10a6:800:1a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Fri, 13 Jun
 2025 10:06:23 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.8813.018; Fri, 13 Jun 2025
 10:06:23 +0000
From: Joy Zou <joy.zou@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	catalin.marinas@arm.com,
	will@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	ulf.hansson@linaro.org,
	richardcochran@gmail.com,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-pm@vger.kernel.org,
	frank.li@nxp.com,
	ye.li@nxp.com,
	ping.bai@nxp.com,
	peng.fan@nxp.com,
	aisheng.dong@nxp.com,
	xiaoning.wang@nxp.com
Subject: [PATCH v5 4/9] arm64: dts: imx93: move i.MX93 specific part from imx91_93_common.dtsi to imx93.dtsi
Date: Fri, 13 Jun 2025 18:02:50 +0800
Message-Id: <20250613100255.2131800-5-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250613100255.2131800-1-joy.zou@nxp.com>
References: <20250613100255.2131800-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::21) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|VE1PR04MB7294:EE_
X-MS-Office365-Filtering-Correlation-Id: 98f8dadf-3dd2-4cb0-b86b-08ddaa61f391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HT1Z+ERGQ0RZuRvsNiuHu/ln251mtIMLbO+dncVcS1qYHfC5MFyuyg6+jB3P?=
 =?us-ascii?Q?ua6N7yEBr86TXb4Fzp/TRrapR+GpKm/4Gu6FTu5LodE4gsww+vWalTgnUhYE?=
 =?us-ascii?Q?8zG1eHZUP35z74xmfDsJKY8+8k0sPOyqMNte/elE6mwsK+8dcOy8IxrudKG0?=
 =?us-ascii?Q?asIn0tDyCo1i49gRV7jPc73DXAyMJN64jyaavUzWVddbe3aDClWcSKI/HX8S?=
 =?us-ascii?Q?qt+ge9pc4QzBJCe91s8PBroLOo+ShEEpkPDFe4NA0N1qaIuywq1rRupdhzTb?=
 =?us-ascii?Q?qaFD2Ni9LrkDWklmVPIqrQobEYLo3lGFg/PZvruZGIq8459KMsBEl9RcTq6g?=
 =?us-ascii?Q?eQbzT/qLxSXc1WOFhYBD7AF4xHF53TeRP0VTH1bBTfQ+gbvwiSG53N0dLeY6?=
 =?us-ascii?Q?46JOgfXLCPPy457ORsFcX+VahLzB4GRWA/6wZYjqmH9blIAVNJpNya4FklsF?=
 =?us-ascii?Q?fSQR+lF3TvRYIRCLcagZuuZXcb6vRHDP1fPpsq46w1vRnp+mehC5EGo9IF/z?=
 =?us-ascii?Q?ilLtlb5tsP1PzsnyfrZDFmHK3c/L2J2EK7ygmDc5aCsWbt9gAxkwtFC6O1cG?=
 =?us-ascii?Q?w4p9q1JR4+JMSY+EIBWsfzSiAN7Rx22F9eF4Dm8ti0pW7XgZEXeU/JfbkKNa?=
 =?us-ascii?Q?JKerZKraBC0y/V5ERoE3HgMdrhcQH7eqoY/+BlJrW4tgYxCF6RX5KGna1ROC?=
 =?us-ascii?Q?ahYkDwkT+prU9lV6mqbfe3eyPfIwuftrPG40WCIVmdp+r8aQRtT9uaS+8/jc?=
 =?us-ascii?Q?/IlIRSg5LXZsLLW8wfbxGXVV0pte0prNdTImztU1txPirHhsBGf3I2ZHiYe4?=
 =?us-ascii?Q?hW/iUM2n4svVrY4GwRsRbngvY6CDHKtHPs9jZrTIYRZ4dOE3uJW1kZ5T+MUe?=
 =?us-ascii?Q?amTRpR+uP5wIUV6RYkxiulPOHGvJ0ckBcLRCfKW+ftVxkc+xSrmoLkfX2r2S?=
 =?us-ascii?Q?DDYCdEI9ZLkCGMCpLZt9K+D/3qsS7SUisXc0LK6d1jj2T8I/rWAid4BQxq3r?=
 =?us-ascii?Q?38NpdhCSrB+qn28DxTyODYIgBQj66Ih0EHiSuh5IDV2z31grTZthPNf/9n8l?=
 =?us-ascii?Q?QZEkQxH0KE4a/lZAUVP612ajbnoBIO9SZjpvVyeu+RKoE19uEYWbgll5OLIk?=
 =?us-ascii?Q?BO/KW0qYKP6NEMJ/TkphloaQfEG9hW+ycs6FQ4A3ur/RsyEtvkuA58MlnZaT?=
 =?us-ascii?Q?OFfcOwG2365vac5RT+v026aQ0Tn9iOrP4D1xqBdd34V/6v+CVLhDC9Zf2zZW?=
 =?us-ascii?Q?SwQr4vSMTnhReeWeY2kSbT9cPEMWNRdjqFworGCwzXXzyFOHdmFhxb9G8Ifr?=
 =?us-ascii?Q?LJuDW+Vq3KUnP3xSZoAjRz6btm+Xi5etnBpsWrHmsmBYn1Xb91QWR9eQXOJb?=
 =?us-ascii?Q?oybuF/cJxkz8jKV2UtMIt+2y9BHUJ06c2/AR9bFiG20vpV4Wgh79RDzwmjxT?=
 =?us-ascii?Q?oU57Vf5u9LWpJ4UDDbqCkDMjEvddKDDdf+O46HTAOIzge5YF/qJ2DmCawyU1?=
 =?us-ascii?Q?txrJZZhlW4WMWWA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bXzrlgjE3y6aQjb3Bq9zpejdmk36l6pKj+q+seDW6/lcRDInv68jRI1JdGXx?=
 =?us-ascii?Q?XKKcjj2nDpbcvSEfFwzbqdleS8nQTEaEmdD6K5NVZ1idkVicZhWJRBlSxCSI?=
 =?us-ascii?Q?3RxxMPdP/v+FBhl6fqqrAsUw8F2bDo24aNLsFrqOrnvPQPN7KItcbyby0rhg?=
 =?us-ascii?Q?It1wjPpwgF7J8B3WYpGyrXgHLAn/4/WAyZFO98MgPRTI0mjbS3kc2swoGpt2?=
 =?us-ascii?Q?qsxNKH3dLss/BnI8DLcDALFO+nd2ESSYe+526Db+aTA2rHRr9J4ilyc6Bu+2?=
 =?us-ascii?Q?B6EX7dpkVSNlfQbAglOzvZZnqCSYBR/ds1vXYMboSKLBbF3EB5qUn8OqhT05?=
 =?us-ascii?Q?cFyqfLEd9TIkKul5fFUbJTeV7DVpk1XdWsNb/vWLY2iM7GcK7JFE8ELLRtXj?=
 =?us-ascii?Q?HPtqZ7/9eepQfQqSTTQ6sQxL32tGi7xe1qsydWZK4mYLtRD5UbD57Y09F4I7?=
 =?us-ascii?Q?x1VPEmWdRKevM7M/DkltJqcxwhaO0RyW5uJnLA/TES98T25HeR27Ml/cmOAW?=
 =?us-ascii?Q?4OY+5IPcaHP+ws8vEM/Ab6+D6rxYFHQSByruwyE+rmp4v7PZtliu7zTuPF/i?=
 =?us-ascii?Q?b/w02P21hD7YEbVr1PKJrVBK/p36NqBSvhRqbW80pWD3znEkut2TagJUFEPj?=
 =?us-ascii?Q?08VNgwW5ELHymf/kxppWiL9P/CSairzCuxgZQM0O8tMzl4vmQj6OGBeJs19g?=
 =?us-ascii?Q?xcDmNacTj4k2RNHaAGa8p7ni5btbXdK+PH03vA+N6wx5M31yHUu5xu/oUBaY?=
 =?us-ascii?Q?lZJWiqNBeNj4Gp18B21WBBz3zImp/OLUw17A84sdejdL0V/ymtsbJc9N3adD?=
 =?us-ascii?Q?eYHH9H0j0rEbbhz6GMLOypXUhZZ/V34CI1528FVeZwpkRmaJfGMnlYjgt80k?=
 =?us-ascii?Q?53xrB2QuDuJq6IFNKLeA2uMkDzm9XMV0cf2qVoJS9macrFradMOLJAvN8wYk?=
 =?us-ascii?Q?jaB+0bT5w56Dg25nELaFTlnozzIlaPtMvHtHxVNG2JfiTFU/U35F4pDk2sKo?=
 =?us-ascii?Q?f9VOTisqC3r+sz6jzqKboEgOalyw5AfxKJFi/gAkT3vcg5S/Da4Tpa7RPK71?=
 =?us-ascii?Q?aYCjIF+GVXzt7Zb2U1Tz/M+Gba9kNWZvWQJxplcsSdpdJeTCZ/bUc2KvnubM?=
 =?us-ascii?Q?ZBrGhkwCvUCrlY40o4asqr6baJ568TYYKdrqxpeu+hw04POLZquOvxmkYHPd?=
 =?us-ascii?Q?UgK4jVsaJskyDJFFy1YTlYz6M8d2Xzaa78alPIyNMk3PWxlRdL9kMjASzl7U?=
 =?us-ascii?Q?zHJodC0oAOb9fbzwtRDnkNtzo6ejG7vNXB2yvZKLQ9gaHk2ftWs0UzFCk+b6?=
 =?us-ascii?Q?fcyZJ47sP2FUbtdcFavGEIjKQGAR71qYvzYpXxpiZHLf0mP50Zl4txGbj2CC?=
 =?us-ascii?Q?H4+XV2pLH9frcnLFHUMTPmdIAjR25IsYkyrVshBGC78zZ6oxb24K27DoJuco?=
 =?us-ascii?Q?Fi563f79YWPZkZ7gscLqtXEJLFm8LBpG0xc8cCH370ncMyjZqm1DEByLvBeH?=
 =?us-ascii?Q?f3l5LGv/TEYaMVJV5dOY6MGfEuUtPG93Zzf6IjGxuI80TMhu2xW28/YXOMf+?=
 =?us-ascii?Q?0tHUMYApGYAywgmnsRvIUop8YNMPuxd3z9GHE9lg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f8dadf-3dd2-4cb0-b86b-08ddaa61f391
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 10:06:23.4530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pZLprSP8zsh1JtbZoCRPf5ALTa/Ntyqa6UEz+q0Ikns0a5YhnphDYqtwBMY3LkG8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7294

Move i.MX93 specific part from imx91_93_common.dtsi to imx93.dtsi.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
 .../boot/dts/freescale/imx91_93_common.dtsi   | 140 +---------------
 arch/arm64/boot/dts/freescale/imx93.dtsi      | 155 ++++++++++++++++++
 2 files changed, 157 insertions(+), 138 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx91_93_common.dtsi b/arch/arm64/boot/dts/freescale/imx91_93_common.dtsi
index 64cd0776b43d..da4c1c0699b3 100644
--- a/arch/arm64/boot/dts/freescale/imx91_93_common.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx91_93_common.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Copyright 2022 NXP
+ * Copyright 2025 NXP
  */
 
 #include <dt-bindings/clock/imx93-clock.h>
@@ -52,7 +52,7 @@ aliases {
 		spi7 = &lpspi8;
 	};
 
-	cpus {
+	cpus: cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
@@ -77,58 +77,6 @@ A55_0: cpu@0 {
 			enable-method = "psci";
 			#cooling-cells = <2>;
 			cpu-idle-states = <&cpu_pd_wait>;
-			i-cache-size = <32768>;
-			i-cache-line-size = <64>;
-			i-cache-sets = <128>;
-			d-cache-size = <32768>;
-			d-cache-line-size = <64>;
-			d-cache-sets = <128>;
-			next-level-cache = <&l2_cache_l0>;
-		};
-
-		A55_1: cpu@100 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a55";
-			reg = <0x100>;
-			enable-method = "psci";
-			#cooling-cells = <2>;
-			cpu-idle-states = <&cpu_pd_wait>;
-			i-cache-size = <32768>;
-			i-cache-line-size = <64>;
-			i-cache-sets = <128>;
-			d-cache-size = <32768>;
-			d-cache-line-size = <64>;
-			d-cache-sets = <128>;
-			next-level-cache = <&l2_cache_l1>;
-		};
-
-		l2_cache_l0: l2-cache-l0 {
-			compatible = "cache";
-			cache-size = <65536>;
-			cache-line-size = <64>;
-			cache-sets = <256>;
-			cache-level = <2>;
-			cache-unified;
-			next-level-cache = <&l3_cache>;
-		};
-
-		l2_cache_l1: l2-cache-l1 {
-			compatible = "cache";
-			cache-size = <65536>;
-			cache-line-size = <64>;
-			cache-sets = <256>;
-			cache-level = <2>;
-			cache-unified;
-			next-level-cache = <&l3_cache>;
-		};
-
-		l3_cache: l3-cache {
-			compatible = "cache";
-			cache-size = <262144>;
-			cache-line-size = <64>;
-			cache-sets = <256>;
-			cache-level = <3>;
-			cache-unified;
 		};
 	};
 
@@ -184,44 +132,6 @@ gic: interrupt-controller@48000000 {
 		interrupt-parent = <&gic>;
 	};
 
-	thermal-zones {
-		cpu-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <2000>;
-
-			thermal-sensors = <&tmu 0>;
-
-			trips {
-				cpu_alert: cpu-alert {
-					temperature = <80000>;
-					hysteresis = <2000>;
-					type = "passive";
-				};
-
-				cpu_crit: cpu-crit {
-					temperature = <90000>;
-					hysteresis = <2000>;
-					type = "critical";
-				};
-			};
-
-			cooling-maps {
-				map0 {
-					trip = <&cpu_alert>;
-					cooling-device =
-						<&A55_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-						<&A55_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				};
-			};
-		};
-	};
-
-	cm33: remoteproc-cm33 {
-		compatible = "fsl,imx93-cm33";
-		clocks = <&clk IMX93_CLK_CM33_GATE>;
-		status = "disabled";
-	};
-
 	mqs1: mqs1 {
 		compatible = "fsl,imx93-mqs";
 		gpr = <&aonmix_ns_gpr>;
@@ -307,15 +217,6 @@ aonmix_ns_gpr: syscon@44210000 {
 				reg = <0x44210000 0x1000>;
 			};
 
-			mu1: mailbox@44230000 {
-				compatible = "fsl,imx93-mu", "fsl,imx8ulp-mu";
-				reg = <0x44230000 0x10000>;
-				interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_MU1_B_GATE>;
-				#mbox-cells = <2>;
-				status = "disabled";
-			};
-
 			system_counter: timer@44290000 {
 				compatible = "nxp,sysctr-timer";
 				reg = <0x44290000 0x30000>;
@@ -519,14 +420,6 @@ src: system-controller@44460000 {
 				#size-cells = <1>;
 				ranges;
 
-				mlmix: power-domain@44461800 {
-					compatible = "fsl,imx93-src-slice";
-					reg = <0x44461800 0x400>, <0x44464800 0x400>;
-					#power-domain-cells = <0>;
-					clocks = <&clk IMX93_CLK_ML_APB>,
-						 <&clk IMX93_CLK_ML>;
-				};
-
 				mediamix: power-domain@44462400 {
 					compatible = "fsl,imx93-src-slice";
 					reg = <0x44462400 0x400>, <0x44465800 0x400>;
@@ -542,26 +435,6 @@ clock-controller@44480000 {
 				#clock-cells = <1>;
 			};
 
-			tmu: tmu@44482000 {
-				compatible = "fsl,qoriq-tmu";
-				reg = <0x44482000 0x1000>;
-				interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_TMC_GATE>;
-				little-endian;
-				fsl,tmu-range = <0x800000da 0x800000e9
-						 0x80000102 0x8000012a
-						 0x80000166 0x800001a7
-						 0x800001b6>;
-				fsl,tmu-calibration = <0x00000000 0x0000000e
-						       0x00000001 0x00000029
-						       0x00000002 0x00000056
-						       0x00000003 0x000000a2
-						       0x00000004 0x00000116
-						       0x00000005 0x00000195
-						       0x00000006 0x000001b2>;
-				#thermal-sensor-cells = <1>;
-			};
-
 			micfil: micfil@44520000 {
 				compatible = "fsl,imx93-micfil";
 				reg = <0x44520000 0x10000>;
@@ -677,15 +550,6 @@ wakeupmix_gpr: syscon@42420000 {
 				reg = <0x42420000 0x1000>;
 			};
 
-			mu2: mailbox@42440000 {
-				compatible = "fsl,imx93-mu", "fsl,imx8ulp-mu";
-				reg = <0x42440000 0x10000>;
-				interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_MU2_B_GATE>;
-				#mbox-cells = <2>;
-				status = "disabled";
-			};
-
 			wdog3: watchdog@42490000 {
 				compatible = "fsl,imx93-wdt";
 				reg = <0x42490000 0x10000>;
diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index bebb7b4490fb..e7a9348bad7f 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -4,3 +4,158 @@
  */
 
 #include "imx91_93_common.dtsi"
+
+/{
+	cm33: remoteproc-cm33 {
+		compatible = "fsl,imx93-cm33";
+		clocks = <&clk IMX93_CLK_CM33_GATE>;
+		status = "disabled";
+	};
+
+	thermal-zones {
+		cpu-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <2000>;
+
+			thermal-sensors = <&tmu 0>;
+
+			trips {
+				cpu_alert: cpu-alert {
+					temperature = <80000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu_crit: cpu-crit {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0: map0 {
+					trip = <&cpu_alert>;
+					cooling-device =
+						<&A55_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&A55_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+	};
+};
+
+&aips1 {
+	mu1: mailbox@44230000 {
+		compatible = "fsl,imx93-mu", "fsl,imx8ulp-mu";
+		reg = <0x44230000 0x10000>;
+		interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clk IMX93_CLK_MU1_B_GATE>;
+		#mbox-cells = <2>;
+		status = "disabled";
+	};
+
+	tmu: tmu@44482000 {
+		compatible = "fsl,qoriq-tmu";
+		reg = <0x44482000 0x1000>;
+		interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clk IMX93_CLK_TMC_GATE>;
+		#thermal-sensor-cells = <1>;
+		little-endian;
+		fsl,tmu-range = <0x800000da 0x800000e9
+				 0x80000102 0x8000012a
+				 0x80000166 0x800001a7
+				 0x800001b6>;
+		fsl,tmu-calibration = <0x00000000 0x0000000e
+				       0x00000001 0x00000029
+				       0x00000002 0x00000056
+				       0x00000003 0x000000a2
+				       0x00000004 0x00000116
+				       0x00000005 0x00000195
+				       0x00000006 0x000001b2>;
+	};
+};
+
+&aips2 {
+	mu2: mailbox@42440000 {
+		compatible = "fsl,imx93-mu", "fsl,imx8ulp-mu";
+		reg = <0x42440000 0x10000>;
+		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clk IMX93_CLK_MU2_B_GATE>;
+		#mbox-cells = <2>;
+		status = "disabled";
+	};
+};
+
+&cpus {
+	A55_0: cpu@0 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a55";
+		reg = <0x0>;
+		enable-method = "psci";
+		#cooling-cells = <2>;
+		cpu-idle-states = <&cpu_pd_wait>;
+		i-cache-size = <32768>;
+		i-cache-line-size = <64>;
+		i-cache-sets = <128>;
+		d-cache-size = <32768>;
+		d-cache-line-size = <64>;
+		d-cache-sets = <128>;
+		next-level-cache = <&l2_cache_l0>;
+	};
+
+	A55_1: cpu@100 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a55";
+		reg = <0x100>;
+		enable-method = "psci";
+		#cooling-cells = <2>;
+		cpu-idle-states = <&cpu_pd_wait>;
+		i-cache-size = <32768>;
+		i-cache-line-size = <64>;
+		i-cache-sets = <128>;
+		d-cache-size = <32768>;
+		d-cache-line-size = <64>;
+		d-cache-sets = <128>;
+		next-level-cache = <&l2_cache_l1>;
+	};
+
+	l2_cache_l0: l2-cache-l0 {
+		compatible = "cache";
+		cache-size = <65536>;
+		cache-line-size = <64>;
+		cache-sets = <256>;
+		cache-level = <2>;
+		cache-unified;
+		next-level-cache = <&l3_cache>;
+	};
+
+	l2_cache_l1: l2-cache-l1 {
+		compatible = "cache";
+		cache-size = <65536>;
+		cache-line-size = <64>;
+		cache-sets = <256>;
+		cache-level = <2>;
+		cache-unified;
+		next-level-cache = <&l3_cache>;
+	};
+
+	l3_cache: l3-cache {
+		compatible = "cache";
+		cache-size = <262144>;
+		cache-line-size = <64>;
+		cache-sets = <256>;
+		cache-level = <3>;
+		cache-unified;
+	};
+};
+
+&src {
+	mlmix: power-domain@44461800 {
+		compatible = "fsl,imx93-src-slice";
+		reg = <0x44461800 0x400>, <0x44464800 0x400>;
+		clocks = <&clk IMX93_CLK_ML_APB>,
+			 <&clk IMX93_CLK_ML>;
+		#power-domain-cells = <0>;
+	};
+};
-- 
2.37.1


