Return-Path: <linux-pm+bounces-39742-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CB3CD37DB
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 22:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6CEE300F31E
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 21:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D802F691D;
	Sat, 20 Dec 2025 21:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Ba/j1kdI"
X-Original-To: linux-pm@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013064.outbound.protection.outlook.com [40.107.159.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA8022257E;
	Sat, 20 Dec 2025 21:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766267771; cv=fail; b=Qn4cvd/PkqYLrNDbpEh0ehSwGuP1G07Sc788LeGM+6IC4Cg9DVvGap19R62GXzYYeu9wD0xLlyK/k6N8pHoZyzXYXhy9pxKYeHJZ6GIRBkVTXlp8Sy496N4cN+61sDJLdgpnDlYUnsoyvuVQp8Xnz/+29F24EbKzAPj5tP/FbGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766267771; c=relaxed/simple;
	bh=mS94G4gfqIGHyjoVkM1Y2NvP9gmqco73JK2/aLAIN4Y=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tqkoajqLtqu8ER5gpEDTW6tQLwFHmGsbAiarkXyFnLAmidlqDp0bIj1UgVWEEQRM1lf4HEi5TVWffhq9vVF2EDEkoxoKQM02bxEzIpsuhmjnZfhlqCnzo4th8IqLTAIRkCgkWweZBL0kPd5O7FKQSne5tR+nx+ePJkkXhcek1YE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Ba/j1kdI; arc=fail smtp.client-ip=40.107.159.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gX/+pE1xfWciNK6lPjbCTHFTbHNtjmoqJpgFZLjnUVm6NBTs5c//FrIUaGw6uY9OGovacS3Hx/LR25K58VyKLxN5VEpL8Uq9S/YMc2g2v6G6e+EfyZHu48wO54oYSdVS3Riwcq75NJww/XU9+pIVadIUU7vv8u4shSm3Yb+cGG2I6bnz1u1GwuqU9JNXqEZhDXlJ4ZUXSYA7OAVy41bfgbPXP+x8Eo328L2v0MpCdGtRyYB98USWaIZ06RyIuKtqi0EeE8cbfgz0RHN8ePbAdAF2ZzWQQxbtt8ppnQ41PhwLWapgg5n0FM7GJZ8WjUYXl20d8Uhl2IAoiQBXCojtPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5qXyVp1pwk4vPb6nsvcD0qSHzgu2YPihwfagbquUro=;
 b=e2qWwAVb7YrsJeb9AG6/t3ask6yM/1nIji3ZtIfECbdddqiX6fUNgveN2+hKaMlwt4p5TPIkZHaKdcRAEtlaGMr/YOluLGLrF7iEICzvwBi87wEzSlaYVdE4TRzN27G0MVroCTt0ZIKomsdOGT/9rFTMDptWQ/flZd+g/2qRyc11+Fap3bvBlXtI6/Ou/2KgoY70him6ZgTWHQ+hqTrG04mekyP992MGwWB4Du40mjpC0FUtljsHQvePaLThl9t3goXb1XQ8Sq/CYNlmSMEh8JD/mwJy96av4Sl9SVahaxdUoAJsB78Q+vtjI3A2OHvdBYhkv9zntmFj9fKCjjrxMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5qXyVp1pwk4vPb6nsvcD0qSHzgu2YPihwfagbquUro=;
 b=Ba/j1kdIukt2VqSbaLIC0D+HRJFYQGnpQ7SV4N//QHNJyMaEbDC6w4Z/xUTuuKEYmzwgQM29yaVemTxxuG0BRLfixyykxck77Etf5EVCGeoZkrfq66kLEB/SOl/ZIQU9U/miUXAU/PlDbMskbc2wwiPVgMHcchWpXZYOcm+liQg=
Received: from AS4P190CA0046.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:656::29)
 by DB9PR02MB8047.eurprd02.prod.outlook.com (2603:10a6:10:36f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Sat, 20 Dec
 2025 21:56:04 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:20b:656:cafe::40) by AS4P190CA0046.outlook.office365.com
 (2603:10a6:20b:656::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.10 via Frontend Transport; Sat,
 20 Dec 2025 21:55:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Sat, 20 Dec 2025 21:56:04 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Sat, 20 Dec
 2025 22:56:03 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>
CC: Tobias Schrammm <t.schramm@manjaro.org>, Matti Vaittinen
	<mazziesaccount@gmail.com>, <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] power: supply: Remove unused gpio include header
In-Reply-To: <pndh5tkzvbo.a.out@axis.com> (Waqar Hameed's message of "Sat, 20
	Dec 2025 22:39:55 +0100")
References: <pndh5tkzvbo.a.out@axis.com>
User-Agent: a.out
Date: Sat, 20 Dec 2025 22:56:03 +0100
Message-ID: <pndfr94vmvg.a.out@axis.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019B:EE_|DB9PR02MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aba2eae-2db4-4766-9899-08de401292ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iCtde7MtjbHod+05L7uTTgXRpIw4BD+KUnqOaLz5aFSH7+DSdX5S0jrasqyp?=
 =?us-ascii?Q?2z765CRAvNC49Dz5PnCDcI2PWBGowPKFEMq3fepXWa9h9Eu6Ihmx3HN48M0v?=
 =?us-ascii?Q?JLgkVmJdSaUR0OsgzXkbYYgPw63DM7uD1Z0YThLmEkn2WwoTmjeQOla6sZHo?=
 =?us-ascii?Q?Zt03Zn92Ftz+v4t1QuMgmDYABoTztJel0AJwHYHbsLc8v9iS4Uy6DpTwOZBy?=
 =?us-ascii?Q?iRzQdlWeGrPHgxqQ+qSv9TuTy7gzAjqRVt42v2BLgt2z8wiD3uKi/VX/bjhi?=
 =?us-ascii?Q?sAYmOOKxGU8en1n3Q6n1ZFnyYMaK/9Eua80Q0ANDZ6ZD0eF9mmY62SkvMBzb?=
 =?us-ascii?Q?oraKmlL6A/P5J7ju7AtiiOUGtTYX5e4O6hKHRG+j34yQv5p5WjPhBxnxG91f?=
 =?us-ascii?Q?eu1hBqd/eCNgjA3OznDux2R4X9Ypk76UO8skeiU/uH7n7floOkQzdpOMtoK8?=
 =?us-ascii?Q?KkVt8xttZFeHay0C45j5OzpVk40x+bQz9VdKf7K8/Rl0WLa4os2L9rm5Wvyp?=
 =?us-ascii?Q?L+vt7KPXwT53QxlqS22yyS2ANL5LifnulrRkgatIn6Q8x9+CGvJ0mjVpe+LU?=
 =?us-ascii?Q?Xb+cGd6z8m7fhmX+1H49kz/4DikLGIASs2LMS0k1tE+sSXfWBNv9XjJZftCg?=
 =?us-ascii?Q?cwc1Qul6aljQNPfEz+NpmVHo/k5aAjdgDDRG2GHNvbY7fgPUXv9+dUaE7iaV?=
 =?us-ascii?Q?1kOs9yySyBZveBmGsW4F2YjFMylmxTDYRk8uN5osOJ5wRVDtrPOBu0D1MpMA?=
 =?us-ascii?Q?5Ri3BCbk1CO70rZOTpTdmFAINwiiGRBdgqfkjQY9sABzJUyURCEvuiavWJOk?=
 =?us-ascii?Q?211yv6DOVTwcyBebxbpLw7w2YwWGBHtmRRrIAAXAE9ML9MKdX6muAEi5Yv5k?=
 =?us-ascii?Q?qeDvtpePZjjCPgh6/rchT2dBMYi85IGMsOB+KQkSGVFoW8F/ozVsrJXOtot0?=
 =?us-ascii?Q?3poRZywLFRrVst/ei+9+/X642Dsw/P8zK/09Tj5qR8z9BJ3L0zSVq1vAY5iB?=
 =?us-ascii?Q?nztKnrgmPmbNVghPNalaEUrwA/pgvz8b8+cMgrKmSHpsGIIanploeifqfacC?=
 =?us-ascii?Q?0DpS3m6O75UadPdqsAQ2hgC/7plaRP8NG50883kGWkuADGaLO0DErZ3ks8dz?=
 =?us-ascii?Q?K4S274gBFxgFTdlQK4mxeVFJsAsfRgPgx8pJ1B/8MUHWp7BoIm2VdSmT7ipJ?=
 =?us-ascii?Q?A49N21qQ0/lV5O1q5DbpmuSIrbzVi9COh9VNQSQb8DiAN3p59co3sH3I5dmF?=
 =?us-ascii?Q?Jntbtbzm6hbA0DQ/aE1VCGr4CV4ebh0orfY2qoqQsQCu3d1Ws/LNgcWD4pOd?=
 =?us-ascii?Q?34NEvSt7+i4jMYcY5LJqIZt3VGs59in1ntzQuOng5XZoftqHYDIfe0B1zJS1?=
 =?us-ascii?Q?Me/FZzH55AD1WrYlQ0IjGO2IMsBJCmKRI2sMu7ozAK0EA25MAYONw5BOAEul?=
 =?us-ascii?Q?JdRCMiUN2qFNaD8jIVIL4S3ky3/yMxkiFvwx78LXGyEaK3iBAMeE/V+zRoF3?=
 =?us-ascii?Q?iwQq0Ii3xCZeMtFrlk5y8H9yUOQQTZ+BTMb+OD36D1A8AcZ0GFVdioicV71n?=
 =?us-ascii?Q?Y1NEt/1DMP4h3R1PT1M=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2025 21:56:04.7123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aba2eae-2db4-4766-9899-08de401292ac
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB8047

On Sat, Dec 20, 2025 at 22:39 +0100 Waqar Hameed <waqar.hameed@axis.com> wrote:

> These drivers include the gpio header but never use it. This patch
> series just removes this unnecessary header.
>
> This issue was found when writing a new driver for the upcoming TI
> BQ25630 [1]. Patch adding support for that one will be sent as soon as
> TI releases the datasheet publicly, which should be anytime soon...
>
> [1] https://www.ti.com/product/BQ25630
>
> Waqar Hameed (5):
>   power: supply: bd99954: Remove unused gpio include header
>   power: supply: bq256xx: Remove unused gpio include header
>   power: supply: bq25980: Remove unused gpio include header
>   power: supply: cw2015: Remove unused gpio include header
>   power: supply: ucs1002: Remove unused gpio include header
>
>  drivers/power/supply/bd99954-charger.c | 1 -
>  drivers/power/supply/bq256xx_charger.c | 1 -
>  drivers/power/supply/bq25980_charger.c | 1 -
>  drivers/power/supply/cw2015_battery.c  | 1 -
>  drivers/power/supply/ucs1002_power.c   | 1 -
>  5 files changed, 5 deletions(-)
>
>
> base-commit: fa084c35afa13ab07a860ef0936cd987f9aa0460

Sorry, somehow the "in-reply-header" got removed so the patches didn't
group with the cover letter... I resent them again and hopefully it
works now!

