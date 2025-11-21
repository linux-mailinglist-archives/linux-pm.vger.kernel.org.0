Return-Path: <linux-pm+bounces-38340-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34546C77E19
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 09:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id E61A931219
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 08:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44CE33C530;
	Fri, 21 Nov 2025 08:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ju/8x5qz"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011051.outbound.protection.outlook.com [52.101.70.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39538330B34;
	Fri, 21 Nov 2025 08:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713251; cv=fail; b=mm4ojVWM0sa869TkIq+dZNBGApGrKrYoHXjRuq+ABHFd4wf5fmlkorTW1RKXYG+6EvH3zQ14a3RawjaVdV4enZP896nEBI05e3/FHv2XLSdAQxQWe3229kpklhX4iM9iWLQZcLC4UMu4fWdWftVWcQBRPFt5WjjmxZR1gxsTzec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713251; c=relaxed/simple;
	bh=IoGzUl85eohuIFau4UV0cT6geWmfdfz/r0Zc8bbXBqw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pXMdQ1aHzmkZdPjhW5K3ITiusWADFRDTahiVI1IN+Jm7uiQN/IAuNFMwelgk0/8CQXOY3GGM33KgQSUTVRiZYoRRMvLWF6STxj25oq46tYpJBLCBjGyIr4UJ6xOUlkTL3dd5a6touQkjv7LnwTfr7n9DigezSEus+ABIho/Yk4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ju/8x5qz; arc=fail smtp.client-ip=52.101.70.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K9EEDQ7MluM27/b5buG1ZaZEIWQejastYeKNOw1Wm6SYenDbf5954wPky+If/hMLUSrX0UhJdLCXfGFF25hU7X2N4I41YH3tTybzGEHQgUKtJwPKj3TLW9ejG6mfzcSVdu/4f6Fshy2bBQYsrlFWDtVM9Mv90JzgzZLcS7FhVUXHzIhjgqewyhfc9HQp2QWqBZ6iJ1LM9Afo63WidRLf9tTLI5tALBwkpKuOhRBcLUXiS2xFktnamJkEWinnQb1BtuY2HNtSVKzpkb0cSCaBWT0NU8G168ki+AO/OFMeYC5YJbMf0TWfXdl4A8ZEx1sj58HGo2CEKxjj8t58goL2DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MneVRDmEM8I/07pmVk3/j2bspTpZzzS1EYP1wMbyQiY=;
 b=r2xGNY4U0i7qbjgu6cIjBrHZZfsIOhSoXqPeB7n2pkSOiqfVtpQo5/168GTNtXAuxheirJsgFHS0y7ylxNjRbd8lGaUujHu4onS1GavvcgClGOFudDtGljChNSmB43tLmYQJAYK0CbDyxPp+BzZE0nVcRLrEU0Ijr+AMnjBcMKbsHSJmP2uu4ErB24r6cA8BfjRE7gVq6snGy/W29+jCIBtNDPSL5Lkqh21aufMDkgKpILy8ubCPMKM38trg7bJFazekvejdu/8vXV92rJzNl+w1jqMnIy54/ewySs4UATuz8eRRCG9BMb0mlvEVv+bmSpwVJg8FD1qHNWq6spdzVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MneVRDmEM8I/07pmVk3/j2bspTpZzzS1EYP1wMbyQiY=;
 b=ju/8x5qz8weAD3cagBhlUag4xmD9kUijZCJKk71DvwGpFTW38ueMJeg5ZGWHVRtzVeHPFRIroE8U0aA/LOS5vgP1Eby55Wx1CjpeIh8/2fQO9xSvyg3+mHoUAri2vIniXgIWmomnCiiGAT6xivdMmK8tn6yTnCquwg1NKKbFuIBKBl+pUiAIzrd/DjbOrsjINVAVoxtRvhRbeuiRuB3QvpQ0j4tTjC26tQMUYTaeoZgTqxzmOutNLaCpc/LPTmv0VtEzMJNLkR6ygkPPGl83xAc4WGzNPE2IUvHrdZw0E11SE7jOugz1+ZAenhM5Wr3MrS5QaKcMIpBsMdHnqY8yHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 by AM8PR04MB8036.eurprd04.prod.outlook.com (2603:10a6:20b:242::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 08:20:08 +0000
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87]) by PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87%4]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 08:20:08 +0000
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
Subject: [PATCH 1/2] pmdomain: imx8m-blk-ctrl: Remove separate rst and clk mask for 8mq vpu
Date: Fri, 21 Nov 2025 16:19:08 +0800
Message-ID: <20251121081911.1682-1-ming.qian@oss.nxp.com>
X-Mailer: git-send-email 2.48.1.windows.1
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8254:EE_|AM8PR04MB8036:EE_
X-MS-Office365-Filtering-Correlation-Id: 6325d751-9c29-44e2-37f4-08de28d6c81e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|19092799006|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2a859GN8ZjkMgFC9im8aAPwr93IcRQ5K3Wxy3QYtIKS01XI7Z1Wg0QxXWr+D?=
 =?us-ascii?Q?WGJXUMptUvwDmm1auQllV7sg9Erxrj2urNgH5qsIkPq8aXDWw0qp+R8IFCkR?=
 =?us-ascii?Q?W6cAucOy2XYNw4s9zEXhT4VFtpIBR4O5KbsfYf4j5v2LF19AI5444UeqjMfP?=
 =?us-ascii?Q?LrBCAwRz1oKnyAvJfPHmmKz3zTiEHxKfprjNSt2uR0mw06VIiK65yga9KQaS?=
 =?us-ascii?Q?f2mTA+daYAxeySNnSaeyRMW18WrMeFYzTjiZAWriBt1rHqrRZRPKN+x9jtkv?=
 =?us-ascii?Q?f5DF+0bNymfSIX6ZVrJmXDzDiw54MazYObdNOQtLiOEMeBaG/H0Ne8x0gqNe?=
 =?us-ascii?Q?U4SsuhbkhRfDraGP0YN3Q87x0qpZfA0Qh28L4EXXN1iuZvfHbNxwUDzlIb/+?=
 =?us-ascii?Q?TfLn8IhhkxqIxTZJ45EOP/dsz2rQpS1QRMZNqyqVvqCvQ6DdaZx5nFNKy6hN?=
 =?us-ascii?Q?HoixIan0hO9J680Wr5/+i8w8JILzGW7ohDMj2U3tQ+EkvyP21wz7S+rb4764?=
 =?us-ascii?Q?xpYkz65Bzs+jMVBSezOsIVl9gvBAU9V4GptiWN7l0+54CXP+4O5uHNEQh+gT?=
 =?us-ascii?Q?L+Qvn7WAUccUShHwN7V2A2dk7Q6CEwsEJ9CDvX5SYrhjo34PVUqNSZdecYKi?=
 =?us-ascii?Q?7EjIR4tE4znVHGqKuBLoGb65MeNnOPgBbe6S4mC/wRAldO+b5s11oLq1UmGB?=
 =?us-ascii?Q?bid1Z5xn9CsxhNTjq/FZSdy0km2XXMjjhyqFxtU9rz/vdq5A6fv9bVME3JiD?=
 =?us-ascii?Q?g8LXqBBjKkC1pqunbF84MAWP9sM8YRq9pmohgZLqU91UVvzXjUeVCXfJkko/?=
 =?us-ascii?Q?jRQoDyhFV7jYIDQtnViI1yLOWPJ7A7ZpItEQ43NUzGHjORvUf2+5IfLCagZY?=
 =?us-ascii?Q?EN4eJ80543un5hWWF/e/d70NP8U9UxKEbIdYVrnetdXvc8Cq3Ame2wHslXn8?=
 =?us-ascii?Q?KG8VWKtJJF54eSN6zNIWxgOeLNlbIncXBYDKV+vP3O72QzjmhHQXhLMGgTy4?=
 =?us-ascii?Q?eL8NScxzJ9dESkjLXOyKdt57aBSzHH+urmTWkDCmWaYa6Z5FSFZK4Nza4XA0?=
 =?us-ascii?Q?a942FV7GQ+Lk6C0vLuPV/vzXospOZa7amnZnXJf9pEZ3Jhl3LVGNKKHllG2I?=
 =?us-ascii?Q?PnZry14ODpSecUWwGF9VWWTtFfNsFY417f5hq/TAayh3b5zMPpVUEupKnvZL?=
 =?us-ascii?Q?HFRmpRpbJ3AauLg+GCy0mLRE/FBivMQKNTwJEvLhd3bP552z/DjKTPrRUJ5N?=
 =?us-ascii?Q?gbLwQlN0kIzFlFfcYMXAq0R1qPhstC4gYRIZF6Q/3+Tr/zYs2CV0MsU1uzqE?=
 =?us-ascii?Q?jMxIs6T0TXNmGa9icj2lufWw0YSNTTzbfrGENEw8Xy/NS6tifW+/Xi1+cEMM?=
 =?us-ascii?Q?keN4PtZGerVz7nFkKiIN9myh6N6zidhK/Dqnk4+st0WjzGWawCQO4RzhtAWs?=
 =?us-ascii?Q?AhjDcAl+0MBogRGn9YNC12+kvbNwBJmK32o6fmFQCTne7kWEJWrH3GWo6zf3?=
 =?us-ascii?Q?eJzAXxY5PlJEftMOlNZ5CbjV/BDZBi28n45y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8254.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(19092799006)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WlEDqZsCYsG5fWuzo+89yJ/+0bfaStxCq0p318B6ShguQ1TqgSMGE0or6/78?=
 =?us-ascii?Q?RLl0VpHuVJPWD90ScDsDBUaL/Z1GqwpbO/CPjgnasGEwgu009KA98qv1HTy6?=
 =?us-ascii?Q?uPVEO/Jd5370WR0JypcpJxBgnfG65Uj/UcgKYNZTPCri3p4fJoWSHjIQPvGY?=
 =?us-ascii?Q?gAK12aLiZyk4woTQyp0pn4YG7xsUkyud7ZiZe82XNEnlOhx8L8EJXZwbJQNd?=
 =?us-ascii?Q?emsN9tyDuJcpTVKlciZ9dsf0kS5Be/e+cTLGLoc3rvdh6ucJVagSR/yVPdkq?=
 =?us-ascii?Q?Wmb25qU/4lrhajDmH0dl92XwbCsXO7a+ELRn42E9PUW+jgQnh+p8un0MYsT8?=
 =?us-ascii?Q?8bw0hzeYNOXh38N79Bg3D/WsUEhBFDN84q7rzsEo87QD7oQve/B5G/3m7tv7?=
 =?us-ascii?Q?LTVKWJ1SB54egTVu1htY94Z5BHaeH4AT7WpjnOEnBRAqyZ61gBdpUKTgHRhf?=
 =?us-ascii?Q?0prHHtZT3PIWrntrwNQs7ChuxKDs1iUUWu8sN5qB0e1GILegD1sOPmUfTBpe?=
 =?us-ascii?Q?9cQc5efjzc6kXeOXVO8zCo2n6ehB9QPF1okUXyK50gar7OPefF9/+V13G204?=
 =?us-ascii?Q?E0nh4hW1NQikiKI7N04tvW+aB9UomJbrfWIxnRXVqVuamDsI5+1fUiy5Z3k+?=
 =?us-ascii?Q?nASJ4d40gDBiA1z4Bmg4fjapEImawkPHrasUI68oYLkxWeBKvFtnejM+d3TK?=
 =?us-ascii?Q?j7uLDHr18jCIme9MpkzUobOJJilk4n8YVQ0E5TRGCsYYVlMxd7q2Rq3NcI3c?=
 =?us-ascii?Q?KyhAoTe4eJXMow+qLX6rSzKXLZceAOafAEotaXcs9sx8+KEVgSazIK3AhUSK?=
 =?us-ascii?Q?0dHVDDeC4wrkk0tV6uFujJGQZ6Qar5F4rVwCwmstPYTzh3DPeQLYG9CukBR4?=
 =?us-ascii?Q?JpQLAXUrZ6To5Erd9Bzkpjkk3A9cPw4MjWQzfu0HB5yhNDO8D785k/XVa5bs?=
 =?us-ascii?Q?KxanGHSjF7LczAqJFOITfJk/xhQAHqkoZUcekBs4jGluW7AxF5CbDekvq3OB?=
 =?us-ascii?Q?3e1ufiVKwgne/VDMhztTBE3cu5zXtzwvDTUwMPaz6lrGM6nCwDz8TmfhSAfY?=
 =?us-ascii?Q?TsZ5DBlqT0vsFy92siTR6qMqitfLlm7NFlIqiPlQCbTF0T2nkMeVvCnyNq1X?=
 =?us-ascii?Q?2uTkBcfCX+gfI527jAQUt0D5DgnkcQnkkH1KIkqI44Bpi/Ox3Oeu8Oxl6PRa?=
 =?us-ascii?Q?DZm5gNx5qv6UzX5KHFeYXr3G7zZjotmKncjpqZdQcFlY0KuSARocc2Y4Eyc7?=
 =?us-ascii?Q?+a5sw8fQyWsbGpR+bGPHJJfHD6I+zgT5VTjmWuVid4obm7qj2cSS/fh63ET5?=
 =?us-ascii?Q?e+x4ffPSzar6PN6AKjNT1SCUUJXw8ZvzGZymW/DJPWP1DVARXh9GJQV9FsLw?=
 =?us-ascii?Q?YshoiuXjAYE5miC5Pn0Wklym7ygMtveyN/bqcivZ3q8G4bglJiHv98AphnD4?=
 =?us-ascii?Q?QtLQRAXShWzceUYi9lOmU0mkqwSmkkfWTi0oSGLSKVpdpfidMh/1oHuewEHi?=
 =?us-ascii?Q?XiqVTfIcp38sNSQYcNF0RwqDh2ds7BYtwQ5l2BQ0KwsL1IfSltqwJVoplv68?=
 =?us-ascii?Q?Rt4Kjtf3GTyhK/sVLEKZzC71HxMcmc/hCTmlqDML?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6325d751-9c29-44e2-37f4-08de28d6c81e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8254.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 08:20:08.3815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OpDd/0ZIOrjfSuZYeNv3t7nwKDyfDUYfIceQMJ/xFEaNcJOQjS6nfoUZW0vxpyUautVdmc6Fl8M+I0CQFtX28w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8036

From: Ming Qian <ming.qian@oss.nxp.com>

The ADB in the VPUMIX domain has no separate reset and clock
enable bits, but is ungated and reset together with the VPUs.
So we can't reset G1 or G2 separately, it may led to the system hang.
Remove rst_mask and clk_mask of imx8mq_vpu_blk_ctl_domain_data.
Let imx8mq_vpu_power_notifier() do really vpu reset.

Fixes: 608d7c325e85 ("soc: imx: imx8m-blk-ctrl: add i.MX8MQ VPU blk-ctrl")
Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
---
 drivers/pmdomain/imx/imx8m-blk-ctrl.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
index 5c83e5599f1e..1f07ff041295 100644
--- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
@@ -852,16 +852,12 @@ static const struct imx8m_blk_ctrl_domain_data imx8mq_vpu_blk_ctl_domain_data[]
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
2.34.1


