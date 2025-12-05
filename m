Return-Path: <linux-pm+bounces-39230-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47621CA5DF2
	for <lists+linux-pm@lfdr.de>; Fri, 05 Dec 2025 03:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 483A0319F1B1
	for <lists+linux-pm@lfdr.de>; Fri,  5 Dec 2025 02:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065FD27990A;
	Fri,  5 Dec 2025 01:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="V6VYtpR2"
X-Original-To: linux-pm@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011062.outbound.protection.outlook.com [40.107.130.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB6825CC7A;
	Fri,  5 Dec 2025 01:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764899743; cv=fail; b=UDdEi+DvQPZucoNTmUV8sqxzt30UcCqm4VFdKa2pDDBAJoTZwtakOZDEHHWlEzstambtNi/bRL9jOAQSZtp2jhTi92+aRv8rq3jCZMRcq3YBRl3tMtadixdHJmltW9BfJtIKniv5EhxvdXPZyVgNVFrnMCVUEUEonGugN1qgFTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764899743; c=relaxed/simple;
	bh=FUte49axEV3Dht5QLyO1p75wKwx06GvNDLFKxNZUjDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZXwWx9fE/TiGWyC4wFwoxsNklyqRXqeO96GT6PWwAYwPhiJ5GFb+D/QZh6ooPG6XqLaDDj6xHjm5aMPXaNuIFCGE61bgKk3x17JEO16jo56TESUp5aWRQC+raLQ1Zp5D7UODJU3TOr/A3UddrlVVmuCowVt4xNFMeXx8xddQmAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=V6VYtpR2; arc=fail smtp.client-ip=40.107.130.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sapDWQTDUbIPT1UV/UpUfYSmrySTGfkUUfeSinpqdmhbGn5conipkbgmvRB/Wgr74mxNoJ008ZlpW0UQgV/CDeWOfQHS/kbl84FZpaPyvCtrojBGr+g/YOVbXXMGT4Bul/PIowIene8+SrU8d8mw1XGmjsMrvRSGiJg4h3lS3pwVYRhlrIW73ZM2iz4mO2F6xYGXOP8RKxSXs9c/oQWrksiUy6YYehQ9I5/L2Rn3sX7QRNLuGb4uUcrgIaJPEuZb10xbgegOs7FAi4bw7aijO/mYcMtoDKhph5Y15N1S17vBAPU0uDXY7g14cq4rmHlecCfpJCu2XJoWioEJhvwTdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SiN8JFh+z4ieke1hYTeVdAJEv13CZxw/IrpZ/ZUyt1w=;
 b=teLDLfH/92E0aI38XZDbfl3DLr4ZOZlczD4H5+vdnoD4aDX/efh8bLBggDroZiLrZPbQMfc3Px4iF4sxZJdkkhJ39pdr5iOGTE1b66BInvxs7W/2W+4AG4qpmrBi3bZ6th6YlaCL9qsJF4OMgXVH5BXY/tZkOJVokPIuspIDj17G3KGOUFBN7HjjtMooP6Kz+wzmDV++5GSDg9ngaGwkdfUJ4SBIVAVXVmhHA37tX1rdob5GTcYxwLc+S/2i9crq0j0w3SJXbsPA04jFbVFQIQ96njy/9OWvOBRxsGXYT3d4UuUb4D1QA2QKg4TF988BVRTTkafrWFzpQPCJCwLACQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiN8JFh+z4ieke1hYTeVdAJEv13CZxw/IrpZ/ZUyt1w=;
 b=V6VYtpR2g3t5jFQzEFlkh2sXoQ+vUOFtw3evwkaOzhF8P+3FBSHaor7YnqAx16fib+qRsI5DgYpxPqqbcTVdjGU94Si55b67Tr8Fis7+mWTGEgI1x7gMvPU/XWpSBgGWmy74iR1yWWuWzqP+nKe0Ksi1qiKoR5xZkJ8ovJvG5kRHbyIHndFfWkHxT4ZeKvWB3DyKkUI9zzCKztyZkcIHFP9RXGqMJ6ko/BTvgfJvGNTjG7R/VUzrhxXv3awDAFi/1gLTyYK+qs4QiQS4ZM87VOg43s7vIwYxrNSBs6lBm36SXP7EYLQAgznpyb+xujcl1fBYf0s6N1udANiWfZ6Z9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 by DB9PR04MB8313.eurprd04.prod.outlook.com (2603:10a6:10:241::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Fri, 5 Dec
 2025 01:55:32 +0000
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87]) by PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87%4]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 01:55:32 +0000
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
	Frank.li@nxp.com,
	peng.fan@nxp.com,
	eagle.zhou@nxp.com,
	imx@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 2/3] pmdomain: imx8m-blk-ctrl: Remove separate rst and clk mask for 8mq vpu
Date: Fri,  5 Dec 2025 09:54:25 +0800
Message-ID: <20251205015428.643-3-ming.qian@oss.nxp.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20251205015428.643-1-ming.qian@oss.nxp.com>
References: <20251205015428.643-1-ming.qian@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:196::10) To PAXPR04MB8254.eurprd04.prod.outlook.com
 (2603:10a6:102:1cd::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8254:EE_|DB9PR04MB8313:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aee85b5-242b-49bd-88f5-08de33a15f7e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K0nLfB4uJV3jIPKMa6yjFv6oxt7oFLMoSKp7IzViBRzGHx95qxy/q4iUJ1ao?=
 =?us-ascii?Q?hgJNqDezK91RFSLqr3cZODbeKNCqIDtPGZrdqOLlYWt1GwqB5eq9F2US1i3f?=
 =?us-ascii?Q?GwZQ1mW2dKIRxtovMr2cnInFlkoPoW87vnCdy1VaHoXNHlmyE9X1WcKt3aNB?=
 =?us-ascii?Q?nc1rl6lm+NXBWU0AmIdaZ9WKboD6J7h0uUsKq9i5e0kg64oX3Q3UHvdblmid?=
 =?us-ascii?Q?qpLQGhitxJlspfiWqUMv1tQypOMr9aVtg/zq/oXhJRYFFSpdShB3lwn1yyxo?=
 =?us-ascii?Q?eyYGuBTzNpWs8DP5JqJOSOsYtUv9CWQAzNrH2oh+g6x9QT4O+1WPNwKwaWWh?=
 =?us-ascii?Q?VEmMUpxUNGBIpeoAlxNRNts3irmupARP6a9PkXtWIW5LiLzpxeUiXsnk4UYJ?=
 =?us-ascii?Q?t377D3sdy91mNnX7i9FAoxl9rE0guaRE3H9mWodRKVL+qLWkB2xlQzM7DOMu?=
 =?us-ascii?Q?jK+R9dSzLAzigE6vYBXrsc+18+0tW2PIvM5EoIw/OMk4p5PomS2Kvgp+vuSg?=
 =?us-ascii?Q?4XOKxSVkFDkDtY+NCqGWv8pNUGVTgVmURxCxmPMzaWqmHGhRYY48dpCaZEB5?=
 =?us-ascii?Q?6oEkYOxDYNzlox/CarOBUY0eEC9If5WJCCkRkgqPSfthzKJyEXG85SmFMiFj?=
 =?us-ascii?Q?gbnmkOlYCxXLHpYfJBwxzlHEranbnYPG3Kk+PhK6Jvqs9cl7Z8LtPwJeomRo?=
 =?us-ascii?Q?4o2f2BjyW01cqalMjRJmWEg8H+hR28SLR6SuMC36ivF7eES7HTI3iutSq2ZJ?=
 =?us-ascii?Q?0i/ColErw7WSXH8xI5KCTRRQpghGEYycz1mjTWw6JfuE0XxScVoHW72+2Pzw?=
 =?us-ascii?Q?are0RdLUB2ADuUtH9yDv3LM5CFcN139cIyz6pWz5rBiq1EZSndC/05K2JmF9?=
 =?us-ascii?Q?encXe9QWRPagOT/jGW+ZRyWyf8zQP6lzjRZzgLTPietkQaaaG0OJ6ZLkD7dn?=
 =?us-ascii?Q?EEbCMxExKm9brULdkWJ/NQkih9kIXxcVNb9YAkynspsj6PvYeSbanKJheom9?=
 =?us-ascii?Q?P1u+RMJo58im9spyfthmNowtrwiCRotdJCw6ZLuiGuqrIm1YwcB2e96Uw7dH?=
 =?us-ascii?Q?jusnNxngcdfuWuVbq9+Gjbo71Q2axenH9qkeKT+jTjQB3SSy9ZhOZ2Gi47UQ?=
 =?us-ascii?Q?XMrJ9opUn0diXilx3VhNCvCyvmIf0u+n556aWmcc8EHJDFtk1mu7tTYLJ5js?=
 =?us-ascii?Q?EEdnIl48U+Rxp5a3EqSf7surL9lC+awFqWrG+YF/+EYeUhxdvIgreEZCWPFo?=
 =?us-ascii?Q?13tMpDW5ZHGt9btqfca2yYMjfOygaJpxwav6c5bb9YZrBM314Z/nVl51jkVf?=
 =?us-ascii?Q?J7r2ayL84XqnVT+y8Wo4hsSoG+i+04b4RusXtSbjG47I/FLAd7XKwq64RRXx?=
 =?us-ascii?Q?AeWQ3ticROmg+2Y2Ai8zEvTtkPny5dSoj4lFfWLRDi+0Hv7WZa0L+szhAC3H?=
 =?us-ascii?Q?SwKoxHZZliy0VRoxpFgs7UPeXRY/HmrTrZciVG70pPvhbiqawdkFysKJi4HU?=
 =?us-ascii?Q?NFfy7AMXEyMRnXASJN7oK5MBZcvyPwzQ72DC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8254.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1e2zfM9VMKkf+z9N3VZAitotMqZRVScsUL6+G6D6758AFGpJdsSTi8iPMZzV?=
 =?us-ascii?Q?2Lcz5yobW3yrruUI5oyIU6ulr93WmBFuk9ZLGVVDQBhjGdTphfoQW3Im1fyZ?=
 =?us-ascii?Q?lCJypknbY5OdrVpMFsgzbNEBz6CtygfhM7PJ4VOndkB+IvoR205htltHcd5/?=
 =?us-ascii?Q?kLfDuh3kRWMhi/Qio3YYQfXasC6qgV+c033uxgj+JAel4+h+3U+3pQ1ol8KM?=
 =?us-ascii?Q?/W9dM6kXKSOKLKxZWCgY2Lp3/Mh/zIbVg1chSiIrizS9FvYVUBjeT7Vw2xPi?=
 =?us-ascii?Q?YhlFqpTwuNNoQuWzWog2hwydEMDtvCoEzYO3JfiRhq9TXpvosKfYOQ8F3srM?=
 =?us-ascii?Q?LS9o3m6iG8HUesxKD+C77diGYNOlDQLd3CI9PKTNRgiFR5EOM8DKIDDedqBc?=
 =?us-ascii?Q?dcf1iAoTUKQYLdXTYrm5hKVi2A8ZNJwGicN/gU9kYwkQFnYkkY8DEy4RFNBJ?=
 =?us-ascii?Q?0pg4paKT2cHvO+x3OtwVxmYWaohoubZDKNJTUx4X7DS99fgiW2En7VXGEeKY?=
 =?us-ascii?Q?UdRpARjaqHvcGcuK+6C8dnyJGijc2xh9W5VQbb+SAvuqp8/Jh4xCe2EJV4gu?=
 =?us-ascii?Q?Ec5IaE0p650Ng5son6A4MwqiA901mLxSvBuopQ+ywKF90lqRi+ZlOjcRtHAm?=
 =?us-ascii?Q?KT08QOJ7qq3ss/UzqkylmfIMWRWz8dG+4M3td06DyI0NFIwiPGCImNVcafL6?=
 =?us-ascii?Q?JZHXszoIKN3SwCa1wmCPX/RKviEWQdKzkiEsujZphMJNOv2WP8kB2Hqu7YQY?=
 =?us-ascii?Q?IhZmhr2YSFXtDxH0gJOOHGdXA4TLDW/iHqW8ZmFoIFZYiBHctQrubHgQiPOy?=
 =?us-ascii?Q?a6Gm+i/NULJMUQIVjdi2q7JWhBeTE1vG+oNwB3MEL3hZ+xvpNq++R8FWuQID?=
 =?us-ascii?Q?QtXXnmI8xPR3LRuZ4Uu8qZeplCwDQ524u2dw6cPo0zA/bbWbUOzDGzTA5h+6?=
 =?us-ascii?Q?28NUm8ac1EmJ/7adUZXvcBZ51FsbAUWmDXusuBFvDSHShWOF+y2Hq7Wl9Yni?=
 =?us-ascii?Q?qEnX1PQlI+CUkySaM5zf5JpxoukYXsoXITc2yICXboE+bx2OVZrXok7S5E3M?=
 =?us-ascii?Q?rW1QSGUJtUBWewPe1Egv2Nc9c0/rBSpO+QwH6CfcRNBnUA0AdIjLmLqpr+G1?=
 =?us-ascii?Q?c8rMch0NI5PImnry1r2ze/arfhp3s9LpPm4lWFyS0mqSDqHdB1KuB2UJWiqW?=
 =?us-ascii?Q?sLE4OpwdHdzIL8vlsUZDlLNKdUrGdBWbaEEstCXO67sbLrtCpWnNfCS7w8Dc?=
 =?us-ascii?Q?mUlItuh0qrioyNsMlzcS0qfv+IhJIvmlK7g/G8lN2Aq6tCPjJn75CmZbcvuD?=
 =?us-ascii?Q?Q7fJA4b26o6Aap6/cCdekFp1IL+96kTCBnxL4+LFo2SKGnw8TJTdOr7r48I5?=
 =?us-ascii?Q?8glKyhYFBZzD14b93RaQGSBZ3zqhYfDYQUOMEVdJLcs463W1Hz9V+2NxxG8z?=
 =?us-ascii?Q?mMcC/GWOUqYcKlPF+AlbIg4WcNi5IlppPwbpSZLM7ggHGFqJRbpUH5mJPwRr?=
 =?us-ascii?Q?IWwSzRgRQIpkxzbF6MPSpbTEIqH0yKBqZ5jSWGP6pKQWmOrAloQ7sJFLhZnQ?=
 =?us-ascii?Q?TFC2ZenOAMPjmKH/s0Lg3wARfHoiCvq3cv6vNC7A?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aee85b5-242b-49bd-88f5-08de33a15f7e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8254.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 01:55:32.0821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 649Z73QT8Eq2WDE4IssgrJ/fnf3B9+wAcaGEwLgzsLLJnCxwBEW5Ga5qrt4l8Ri3WcPHbYkUqKcy0gAvJnJ0vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8313

From: Ming Qian <ming.qian@oss.nxp.com>

For i.MX8MQ platform, the ADB in the VPUMIX domain has no separate reset
and clock enable bits, but is ungated and reset together with the VPUs.
So we can't reset G1 or G2 separately, it may led to the system hang.
Remove rst_mask and clk_mask of imx8mq_vpu_blk_ctl_domain_data.
Let imx8mq_vpu_power_notifier() do really vpu reset.

Fixes: 608d7c325e85 ("soc: imx: imx8m-blk-ctrl: add i.MX8MQ VPU blk-ctrl")
Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
v3
- Add some comments
v2
- Update commit message

 drivers/pmdomain/imx/imx8m-blk-ctrl.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
index 5c83e5599f1e..74bf4936991d 100644
--- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
@@ -846,22 +846,25 @@ static int imx8mq_vpu_power_notifier(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
+/*
+ * For i.MX8MQ, the ADB in the VPUMIX domain has no separate reset and clock
+ * enable bits, but is ungated and reset together with the VPUs.
+ * Resetting G1 or G2 separately may led to system hang.
+ * Remove the rst_mask and clk_mask from the domain data of G1 and G2,
+ * Let imx8mq_vpu_power_notifier() do really vpu reset.
+ */
 static const struct imx8m_blk_ctrl_domain_data imx8mq_vpu_blk_ctl_domain_data[] = {
 	[IMX8MQ_VPUBLK_PD_G1] = {
 		.name = "vpublk-g1",
 		.clk_names = (const char *[]){ "g1", },
 		.num_clks = 1,
 		.gpc_name = "g1",
-		.rst_mask = BIT(1),
-		.clk_mask = BIT(1),
 	},
 	[IMX8MQ_VPUBLK_PD_G2] = {
 		.name = "vpublk-g2",
 		.clk_names = (const char *[]){ "g2", },
 		.num_clks = 1,
 		.gpc_name = "g2",
-		.rst_mask = BIT(0),
-		.clk_mask = BIT(0),
 	},
 };
 
-- 
2.52.0


