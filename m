Return-Path: <linux-pm+bounces-38341-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC63C77E1F
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 09:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 4558D31582
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 08:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770C133CEA1;
	Fri, 21 Nov 2025 08:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TZV6ap8X"
X-Original-To: linux-pm@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013017.outbound.protection.outlook.com [40.107.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0539033C50E;
	Fri, 21 Nov 2025 08:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713252; cv=fail; b=Nq/QBlfhyvlhADYO4zMVSHL7DqqiBOOtJvys2kkKSubdCkBdKlJbrV/SOIBwRvLRDJWUsk6wdsMQScqe8D3kIRoyYF71zpW75gS1vATrzY0lBGYOPKm2M3mt0TLv0F89OUjC+ZzZFDBDEY+U467Uj4bEHBMDuAUMFF5AovNaymo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713252; c=relaxed/simple;
	bh=DK4FNyl6zxzbVLC99CJAVXX3yVMCulDj4+YPivZ39CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DMxCowjJspWEGJMSNobnQHnz6Mv24ULmrGRvG9vCkeHUTtXMkJGzcIIvpIVd2JDqA3dJsUgyzX6IQNMOrRHZG4qL1Mx51+sTe0tgYiKhjmoAIp8qWBOQX2KVTEDxXeEO5Yk2GI/yHVKCRJWpgse4UaDsuQPfnm+zB/4r9ppp/D8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=TZV6ap8X; arc=fail smtp.client-ip=40.107.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3DoGdURsxh7PL4DWxdZtv5j9MDpGoT8nai3k0JkiyIGYwpqCcXOGmnJDqZxvUhFnjCyN/U0qMHfgg/njnhlCBrbLKmI6vm1E+t7Cib4NqCPlipvhO0p1BifU36QjojdjKA5eQRjGWqQQraYhyN0hY1+BxoVhIkHPmRyGH5W3Uxo+d6/4pQt1Q5nURPODiK0Rpil8RZG9fmqZUhBDa8BZxV0/hE4dN+FhgRbuCUXFlHqEsR/WIZq4o7OS2GKCGFKkSEhfMNnJgKBs6LPgIvPSWy4strd2hbnlLGo5615ct7AF6tsUF0q/Et2jB5toUcmRX/R0whhIKf+Gs/ULCT45Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HAUBncDj0ifdzfKG+Va5lfsRKyaZaQq5VEwqL4YTwTk=;
 b=XjTEH0OVUifaXEn1Ku1Lle/z5u+mX9aOJo4HfMDgh64dx2vicgHoknAwYBa0AuFXGamJPC12GjMosJcSS/6XbKzFY1VqFKAGV8RcEuGsUzLWJggDxNlFR6eBLEL89+BnDpshQD4M58C1U7QWub1h6sJyZfd9EwkHuz5v2wJkBJKx5S+dOSUtNZF6Tjn+zvu/NjzMGaW4InAAL6hawJN98yZfZbvhXp+UEY5TelF7KyBlTnoQbsj10lKbp0Wh2VsrL0J3TARFDSa9wKZALEPglSyaCcSsatNYW5LBEnrSGYfd1yfoQJm0q4AAAzORkGwbQFyIoPA16C+4hrGosLW4kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAUBncDj0ifdzfKG+Va5lfsRKyaZaQq5VEwqL4YTwTk=;
 b=TZV6ap8XIb3ZQDV3a6Czdyo0uKAPjGtUiEdxB1kFaVLFHL8GuWl19Mh3lf2Uge5mNZUHksrl3w/3r575icq89SMgqgb2l45FmmyKijae1rJoTvEiomlq5uApfeD2Gf8Xmu5XxMtvT1if45aHa6I/Ofts9MyECAeeiFbM31KS5juIhdZJyrKLKt7K9YqeMGWbIRlPOhaqAyPWxBuk9NvTfYf9kVRBJUrKjXIG1OOUbT6b2f2+3in+gIHt2qplVN0wyPiZkSiMWsEpirQsAnUhxMSnhtHFaMJxjAXxNsQiiyFncpAjpafKNAqGmndLikW1+G4ePDGhK6rtZkf5zbWYuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 by GVXPR04MB10405.eurprd04.prod.outlook.com (2603:10a6:150:1d8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Fri, 21 Nov
 2025 08:20:15 +0000
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87]) by PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87%4]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 08:20:15 +0000
From: ming.qian@oss.nxp.com
To: linux-media@vger.kernel.org
Cc: mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl,
	nicolas@ndufresne.ca,
	benjamin.gaignard@collabora.com,
	p.zabel@pengutronix.de,
	sebastian.fricke@collabora.com,
	shawnguo@kernel.org,
	ulf.hansson@linaro.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	l.stach@pengutronix.de,
	peng.fan@nxp.com,
	eagle.zhou@nxp.com,
	imx@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] media: verisilicon: Avoid G2 bus error while decoding H.264 and HEVC
Date: Fri, 21 Nov 2025 16:19:09 +0800
Message-ID: <20251121081911.1682-2-ming.qian@oss.nxp.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20251121081911.1682-1-ming.qian@oss.nxp.com>
References: <20251121081911.1682-1-ming.qian@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To PAXPR04MB8254.eurprd04.prod.outlook.com
 (2603:10a6:102:1cd::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8254:EE_|GVXPR04MB10405:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fc9eac2-2bfc-4847-5595-08de28d6cc3a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FeteNeGGkgmIZg6eNOLzlHa2DAGhUt0YnEVQdI+rACdd49OLciEW11fPGE1K?=
 =?us-ascii?Q?MP+hbvgvHTxYRJhnKAn5amH4l6EBn97AXSu2Tj1+YWyHVV4NHAvpAsO25Pot?=
 =?us-ascii?Q?SAke38F84AjllOyO6a21IuAD/as7QpjcmEM65sCsR/6+yuiDTS+2tPOpji0m?=
 =?us-ascii?Q?ZcjAoqCsBnZwJrH6KTjnHfq3uxG0APSe9f5iMjrwGY3Lw4FbQnBnT909wjkX?=
 =?us-ascii?Q?IArklm2ZOQjr5Wd9+5wrUx90HH7qYyL+C8SGJfiEOqqZSzYF/fMWSJFYNRCV?=
 =?us-ascii?Q?Owgu44nRBkEWE/oFLtTD7mBI1Qt6IBzAqAFUkImt4P5J6VtNGa7M86QRddNG?=
 =?us-ascii?Q?5bqc0aWIllgVErQK2hhizJRYrhPYQ3hH1oc6wEKNOpIvJJUPM+/wG1o0lFSQ?=
 =?us-ascii?Q?/ckxDytiHHotkCKC6bci3MzA6hZBxiX4K1skQinuIPN0UnnmvAHs2TeyT0PB?=
 =?us-ascii?Q?DW2rRF+8XYVoR9K0deke3qs9bbEacfxyfw3TnfDha4La3vOQTJFPdA9QI8M8?=
 =?us-ascii?Q?worX4MIvvIbyBVounuduOPiT50jOsdwVHyj16IsIjye0lapbX06jw0mPgSYW?=
 =?us-ascii?Q?a6rtY8XztF5cfHFf3X8QKQuVvGf0V1Ua77NptjQpmcBaNjzVPus1dIN4OBZD?=
 =?us-ascii?Q?XP9MWlp78i7cpaz+Q2WugEJpaTaf9ai4lNxSxDvdTYGmFcbhQJu4/fTflQCj?=
 =?us-ascii?Q?8owSO7ApKJVf2/pH9HdnW5/MSh9KL3shKpURgnGSqUjNFknM1/jG++hCri9Q?=
 =?us-ascii?Q?n6tEe4Y3yrMiWxkd6HlVohlTM1jF/bmCdtfnPmNgbFlAlbfg5l3c08jJNmeu?=
 =?us-ascii?Q?egN9K5mP65tD5isQ49/8U2K8VG1sCmjaRe352XLexbrwcqWm86L0bj/IrFuN?=
 =?us-ascii?Q?5NSLNNxiMXyQRsoOcaFVNkSkmz7DIpZHuM9wS28OZFanNa4wd89COVRT5sAs?=
 =?us-ascii?Q?5dVd66/dCxbcmt+cVtPdGwGU9/2K5tOW2Ct0IGmLPpo5KYcS0OLff+FvjqEo?=
 =?us-ascii?Q?cjBddUyLvEq+3IkY/R3rEmk0cvuDKVM+lx5uq3XhcW2m+fUUWVy5WzyyG4Ve?=
 =?us-ascii?Q?4VxOc2p/kXiNmAkFTLOC0uzFxQdbw/MsdogWt1vuE/s0Xpwokd1xLRxW+Ijc?=
 =?us-ascii?Q?6vLJVBI0t+rqcXEXXtqn3d8fetawE3xzW23tp5Alk+DSkITCErE4yZSfe66B?=
 =?us-ascii?Q?koL6sldPMjjLhYaV5NHT87zhBXJ3kuqT945OLoReQyw36wAvHOs0r1fI6tBn?=
 =?us-ascii?Q?4pTyRp1bVoAFEmoNteuZSegnSE+lDnciZSE/SfiLNJg7V4LLlyCj7teKvlS7?=
 =?us-ascii?Q?IbSDqL88c3pgLP3hEErX+85ZqLOD4mPfp4TeSL0E52in2LOP06lTQSY+7106?=
 =?us-ascii?Q?OGGF9bzpT4mdcCd0/pFs2L9xepRe/YeMSZkUoaxIzS9ogcn8ZRszYivI32Dq?=
 =?us-ascii?Q?kdZLUuHMw7jgV9QoC5G99Ku6ehFGdXYmCNz+aMX0ORlabuWNwZ3/LWkfOOBm?=
 =?us-ascii?Q?ioAPd1z+juOHCvYenBt4jaZ8qtmDBH3peUN3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8254.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SzJXKJPRjFTJ8L2uxOhXhbnB3ilmS8ry8J7Ly5+PberZf2QKCTdO10Umqxar?=
 =?us-ascii?Q?eO3eJCm0H4uhOMnj5n+Z2CGIzin6DoPDH+JQKFdRuL/eE1ruTPndSutUKtyh?=
 =?us-ascii?Q?qQc7CSysk0zHM5gAbkX1CO3YPlB0Oi4m8z71eZbgVq0a7dC0A3ONEyCo3//g?=
 =?us-ascii?Q?8TthteixobEPl8If0MfrOGkAeE0w35gOy82LxoiyXUuxo9OYk56ZeO+eVLp6?=
 =?us-ascii?Q?NZIwd52NqdrFcTIfTPBBNHjhhQaNaNUeChNqXEuOHi9O3nJo+yj4Ykz0G6lj?=
 =?us-ascii?Q?hDJ2Z9nOdGgiASP8HTmY/ZvwZAT6SL3h4phl6a9vR/r+dpqqO03EiuHcQcgI?=
 =?us-ascii?Q?nAGvLoXKcMwZhxFpzqjrEQx+YtQvVCdDNTfVinEn85GwmrfDmvGHxp+zaa56?=
 =?us-ascii?Q?ByFi7gRxTqHOcq219vNGsCpSf1qOsG7vSxxowrqEmzJvR+XX29aPP66MO7LF?=
 =?us-ascii?Q?Dgtnfj+tN3Qdgtdcxt4UhAZivsBwsBaEzxIL9a+WIfCm6EnAuGBz1je8rBTc?=
 =?us-ascii?Q?NmX6L3rLJ4SWEBGFElFK+mkp+yznEyghNsMEMWswhkgvGXvIhXnsZ1EmLZco?=
 =?us-ascii?Q?RCO4567Xs6PTscTBNTJvZZWFopi2fepFkgRoobcHcR0kdQXbIbrCXRJblNCr?=
 =?us-ascii?Q?/1ZrvlNTo+DBxONm9hF0UM+50cBDvEGyA5nTjGm2dNYNEDpJwDl4qnqxoa2P?=
 =?us-ascii?Q?Z7BMPgGJuiZ+n+Oc/jLV64ODIhut6aBsOw4YpR+RauHuxxBv8RTYfQt0YH5Z?=
 =?us-ascii?Q?kkBQPQM5cVLF8Lj3ecHnE4SywfadaVOTLPA4X6RcLAto7i+LitUMsIwGlgy2?=
 =?us-ascii?Q?0x7NI65Z8TOyzquO4T9qd4S4g6vCeAl0Crhce9A92nRsbu/0vUZqThBUU1Fo?=
 =?us-ascii?Q?7vz8P+2FU5PA4IGu186v2ryFNzmfcRhpXhwLHd+woSnzMOAixxSYEeij78Am?=
 =?us-ascii?Q?fXWuXgfPQV9pd2qCUaaZtdYHpyWbMW+qfKR0f3ukEQ1uCTZnA8WQ2dtk9nqh?=
 =?us-ascii?Q?zPjG1kvLkmzT2Wb1tRkU5e1/UT9+V5i55viZM34Dszbh4Ua0HsRipTiCPcZ8?=
 =?us-ascii?Q?zcitVaK6r0857wDp+bBEnW7We8j5b27GMjhgwvUfCXkGBC1jApwIp0nYwW0l?=
 =?us-ascii?Q?poUF8J1gTtJSm1kB/xGemj9DiDWWNONxcr9+fom51Fm7ejuhiYp2TJauP4OS?=
 =?us-ascii?Q?A0YLQX9dQYCrKQbqVbxC5EqIj6fgWcYfNlQJO8FxERTlATwM4o6hBttufw5r?=
 =?us-ascii?Q?IJpOcqRRbE73HYxbmxYA79ZZ38qfltqbjmo1rgRogU7NibLnT+KGjclFj9Rt?=
 =?us-ascii?Q?6ureRPxH/1pya5j/0C8YE7KrKMzUgqJlYYEhR/5taInbOberqk/YmVyESIkh?=
 =?us-ascii?Q?xnMaUx9h6pB92C0rFsjclcotqvHUjyTDq1zRGkgMA0PTjtQItfe2Pq6wxwQO?=
 =?us-ascii?Q?7UyzUEm/Sc1rEHqtC4c4+rOsFyr+B1SWNiHSSXiYyrsTNTNpmA9/hx+CfVmd?=
 =?us-ascii?Q?FOf2d50pYtK8fr1RSbpqJpdfYAzTmYFY6cZKu2CNjLLffuhQakjWQGZCIA3S?=
 =?us-ascii?Q?xA2HlAs1ZKjQfsVQO62q5tIqkq8xmXTCadG9QZUG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc9eac2-2bfc-4847-5595-08de28d6cc3a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8254.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 08:20:15.0933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pYxFouBC7c8R2yybTPqTaodKIuKK70+jdafDaqqM2mkIMhoHemqbm2UpYIlzn9LhBjM14GCFAOsmbZ3DwQ9hxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10405

From: Ming Qian <ming.qian@oss.nxp.com>

For the i.MX8MQ platform, there is a hardware limitation: the g1 VPU and
g2 VPU cannot decode simultaneously; otherwise, it will cause below bus
error and produce corrupted pictures, even led to system hang.

[  110.527986] hantro-vpu 38310000.video-codec: frame decode timed out.
[  110.583517] hantro-vpu 38310000.video-codec: bus error detected.

Therefore, it is necessary to ensure that g1 and g2 operate alternately.
Then this allows for successful multi-instance decoding of H.264 and HEVC.

Fixes: cb5dd5a0fa518 ("media: hantro: Introduce G2/HEVC decoder")
Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
---
 drivers/media/platform/verisilicon/hantro.h   |  1 +
 .../media/platform/verisilicon/hantro_drv.c   | 26 +++++++++++++++++++
 .../media/platform/verisilicon/imx8m_vpu_hw.c |  4 +++
 3 files changed, 31 insertions(+)

diff --git a/drivers/media/platform/verisilicon/hantro.h b/drivers/media/platform/verisilicon/hantro.h
index e0fdc4535b2d..8baebf767d26 100644
--- a/drivers/media/platform/verisilicon/hantro.h
+++ b/drivers/media/platform/verisilicon/hantro.h
@@ -101,6 +101,7 @@ struct hantro_variant {
 	unsigned int double_buffer : 1;
 	unsigned int legacy_regs : 1;
 	unsigned int late_postproc : 1;
+	atomic_t *shared_resource;
 };
 
 /**
diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index 60b95b5d8565..036ce43c9359 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 #include <linux/videodev2.h>
 #include <linux/workqueue.h>
+#include <linux/iopoll.h>
 #include <media/v4l2-event.h>
 #include <media/v4l2-mem2mem.h>
 #include <media/videobuf2-core.h>
@@ -93,6 +94,9 @@ static void hantro_job_finish(struct hantro_dev *vpu,
 
 	clk_bulk_disable(vpu->variant->num_clocks, vpu->clocks);
 
+	if (vpu->variant->shared_resource)
+		atomic_cmpxchg(vpu->variant->shared_resource, 0, 1);
+
 	hantro_job_finish_no_pm(vpu, ctx, result);
 }
 
@@ -166,12 +170,34 @@ void hantro_end_prepare_run(struct hantro_ctx *ctx)
 			      msecs_to_jiffies(2000));
 }
 
+static int hantro_wait_shared_resource(struct hantro_dev *vpu)
+{
+	u32 data;
+	int ret;
+
+	if (!vpu->variant->shared_resource)
+		return 0;
+
+	ret = read_poll_timeout(atomic_cmpxchg, data, data, 10, 300 * NSEC_PER_MSEC, false,
+				vpu->variant->shared_resource, 1, 0);
+	if (ret) {
+		dev_err(vpu->dev, "Failed to wait shared resource\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static void device_run(void *priv)
 {
 	struct hantro_ctx *ctx = priv;
 	struct vb2_v4l2_buffer *src, *dst;
 	int ret;
 
+	ret = hantro_wait_shared_resource(ctx->dev);
+	if (ret < 0)
+		goto err_cancel_job;
+
 	src = hantro_get_src_buf(ctx);
 	dst = hantro_get_dst_buf(ctx);
 
diff --git a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
index 5be0e2e76882..1b3a0bfbf890 100644
--- a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
+++ b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
@@ -324,6 +324,8 @@ static const char * const imx8mq_reg_names[] = { "g1", "g2", "ctrl" };
 static const char * const imx8mq_g1_clk_names[] = { "g1" };
 static const char * const imx8mq_g2_clk_names[] = { "g2" };
 
+static atomic_t imx8mq_shared_resource = ATOMIC_INIT(1);
+
 const struct hantro_variant imx8mq_vpu_variant = {
 	.dec_fmts = imx8m_vpu_dec_fmts,
 	.num_dec_fmts = ARRAY_SIZE(imx8m_vpu_dec_fmts),
@@ -356,6 +358,7 @@ const struct hantro_variant imx8mq_vpu_g1_variant = {
 	.num_irqs = ARRAY_SIZE(imx8mq_irqs),
 	.clk_names = imx8mq_g1_clk_names,
 	.num_clocks = ARRAY_SIZE(imx8mq_g1_clk_names),
+	.shared_resource = &imx8mq_shared_resource,
 };
 
 const struct hantro_variant imx8mq_vpu_g2_variant = {
@@ -371,6 +374,7 @@ const struct hantro_variant imx8mq_vpu_g2_variant = {
 	.num_irqs = ARRAY_SIZE(imx8mq_g2_irqs),
 	.clk_names = imx8mq_g2_clk_names,
 	.num_clocks = ARRAY_SIZE(imx8mq_g2_clk_names),
+	.shared_resource = &imx8mq_shared_resource,
 };
 
 const struct hantro_variant imx8mm_vpu_g1_variant = {
-- 
2.34.1


