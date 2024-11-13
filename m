Return-Path: <linux-pm+bounces-17463-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 252B09C664D
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 01:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABB081F236EE
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 00:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E6D70818;
	Wed, 13 Nov 2024 00:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="T2fKsS3C"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2095.outbound.protection.outlook.com [40.107.117.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C174CB5B;
	Wed, 13 Nov 2024 00:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731459282; cv=fail; b=DPnO3nmkpDHAzxKSNX23uMx4aDPHgS/EisnaBddVXn2eUIe0pyBtHy+Pkbp8/7CaSSiGThN2Ip/sSeH75JPqnIPh/P2Mr/MCmarDnC6EzPBeN8KDvFRhIj4RC+12dVtEqj2kWF8EtNPwHQDoStFhl7XvZZsdXnmskMjZpxv8Lyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731459282; c=relaxed/simple;
	bh=qjgNZfZGeVLLx/3vmDj3ZQ//X0Ob4WFC+8+wNa1eB7A=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=m+vtLYKrOQYfzTJBXt3v1xvWd6nIysDAT3H3Q0JWgHNHT6qBIz27MUxqJC4uoLiIYk4mGkTOtsDc3AzCwEVlUBLmulQWKYJsnNCXY9/lhTZzS7N2cuoV27IpSdqQPydZD/1k5VqwiNgeSb+1MWZsay9ObLYyxN5c/Ua14zEtei4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=T2fKsS3C; arc=fail smtp.client-ip=40.107.117.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xgKFQcFjeI3lY4NAcayp2umwp7vDQmJrmMxgT6aXBXBAN038A2lSO1tlEwbzVT+TYbpLuJLtpvwqmAxIyU29NNuXrnK66wLF+4kslOSjx9Jkvs08ys8ydBGx8M2mPG/Q3zG/L4QNGZDnOHfhksnbAOPOONbbMX2mSTEGIjr5FTn5MqUQXa3up/09CI8TjDBzAfdCUEULqbCXqa0C4C02gTiX6cwV+8LNFJjpc5AyO74anWB/BqiF/IWaEgPLbbCxIc3BAyWe2Dpn34CbbP5Lkdx1ojf1nvVhE93mu57kn2OsHEg4xIW8Jbon0rCJX5ZnimBemfbVxJMCKZzPizzFDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCkfY/swKBpkfPMDalTuFYwbmzdA8yj0Flnz/+UzkLM=;
 b=Wb5eWRMGnWt5ZHpHjFdoACSXbmGbXfs7iS4YQweKWLc3QWYwa1tecZNzv270zoJXPdIcJazGVdiWzvcL9c9FWzNwVRt1R8D+sXFEJl+dDC364wfxRY12hUE38gkc/Vlp3R6wVYjcSZctlElQu1EL2B56JVfWiIpnXU4JGCpptniqJ9FF8bTXaKKfDxs47Mrr6Or6OzEaN+WyZAaQ3JkwhyDsCDXFJPCWot5cXtzGsYOY7EQ5KD9+B8k9qwH/eQQljjLV/imEgUft7yIyeBTnTqQRZwY4F7jzfuv7xBvizZjkk/RZvdyb8R1v2YgQOcLRjEGK4Bgk95bwUGloEkyXYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCkfY/swKBpkfPMDalTuFYwbmzdA8yj0Flnz/+UzkLM=;
 b=T2fKsS3CJuL0z3GiHnCg1QrSWtf3DjxSL+jBogMpAF/wexwckDIGFK00Pb0v0rYvNQ7gMV4L2bDQYWCC+BjlzsaX9pe1nzMY33G2qa4MS0A8PeL6VmW04+03APF9VFnxiIXtra1B5dqVIy6cvwYdRtqcqeJ85iXeowQGMK5weFIz/gszCxcjZKhFPKHahgMkt/Jk/SGLKi3hd1DBO/jCWcgYmVYBxWoIim8yoP4B6uJagYqPocAvM0hVAekUYjrTzv2RDrHAowerS4w8nkDqo6q3qCeHP9MgrJU3A0bIwxP0kblR2pvVUrJcJQjpOxGh/6sxZK00BL8/6nhuqmeHZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 (2603:1096:820:b1::13) by JH0PR06MB6703.apcprd06.prod.outlook.com
 (2603:1096:990:36::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16; Wed, 13 Nov
 2024 00:54:33 +0000
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::b56a:3ef:aa9d:c82]) by KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::b56a:3ef:aa9d:c82%4]) with mapi id 15.20.8137.018; Wed, 13 Nov 2024
 00:54:32 +0000
From: Rex Nie <rex.nie@jaguarmicro.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	angus.chen@jaguarmicro.com,
	rex.nie@jaguarmicro.com
Subject: [PATCH] thermal/drivers/k3_j72xx_bandgap: Simplify code in k3_bgp_read_temp()
Date: Wed, 13 Nov 2024 08:54:12 +0800
Message-Id: <20241113005412.2254-1-rex.nie@jaguarmicro.com>
X-Mailer: git-send-email 2.39.0.windows.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0159.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::15) To KL1PR0601MB5773.apcprd06.prod.outlook.com
 (2603:1096:820:b1::13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB5773:EE_|JH0PR06MB6703:EE_
X-MS-Office365-Filtering-Correlation-Id: f0b600e6-9a01-4165-d429-08dd037dbc92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B35SCvqp37qfKHsdPVxhWQ6ZuxTsiP3hnWBBLwvQTu+sfsph5tkFP791YQKr?=
 =?us-ascii?Q?OHpRD4PR7O0R50wm1ylRY1BF1nfFQkzi6k6WVgp+KWY/adPVyzFIRgAizvo9?=
 =?us-ascii?Q?MKschn2iE1IBC/u8FvISBG9GMQIaDCl4wTQr9KOUj7uKGjIADV0hrHk9pI6f?=
 =?us-ascii?Q?+oodA68aWoxeylUmOarYeYCxiEfLMZjnjPeQER4nOm4NYBWFxJPI7kjpc/hx?=
 =?us-ascii?Q?qVZ7sYX1a+neLdpcMXvFRPvk+/kVi198xKN/YqctnCEvxWzGLal0+FSPGidF?=
 =?us-ascii?Q?vn96RFqnf61H7dlt8bC2RHJrURKBcPa39jYdr4hZvd7l9W4Y95CGv4KxuCMw?=
 =?us-ascii?Q?S5eyWXzhcJAjC3IQxg5fEtqsG2VqKHyhmfElwPYdvIY9wR/nplUsTPG1zyoq?=
 =?us-ascii?Q?NoqopbYJkF8zsdQV0hR8fy32ZSFHVl31eOEtq235TmDESieO3oWFs9FdSWIE?=
 =?us-ascii?Q?9WZ6md9plJGzN49oVrrdT8VQFgeXB6e0gxThjTZaufKM8cGuTOmefL/H5bLX?=
 =?us-ascii?Q?FuUMMzC5G03YUUOMmk9xkgFzR0IdnU/N0pVVO4mz4PmPCij+EJtydeD6DEYp?=
 =?us-ascii?Q?VE9PkP2FJpF/389f9OVuhsyaQ8fDJlD0iJ6GVbINvdfyaGUJupfWjwwQam0m?=
 =?us-ascii?Q?WkiYjYwHgr2U5PJY6X5aM5aH9P3w4lazQu1wiqqOh7RjhsUxx8dWyY4f1XHB?=
 =?us-ascii?Q?Ihc40E7Em0Yc7cFtPj0CkrXdQxDrYTZMJdPLXzHXGGof7wlCe2Zni4I9djY0?=
 =?us-ascii?Q?z0lX0u4jy56t5pR+XVbs3DtWxPiQaT7nVUFgK7yfXkvzJgV7kQ8p9qWqTT+F?=
 =?us-ascii?Q?5m5WoGNUuX9cLeVY6rfr4m1zHDYavQAm3NYP1OFw/1LytYFi47bvF6iE+jXo?=
 =?us-ascii?Q?53o+Pnj0aZ3x6b8/wx71zLZXKdSIyo2MWjanuyaP1QeWfppWZRcyvyik1VQI?=
 =?us-ascii?Q?4T+BtnqSAGm8+p1x1MY7JeVUEbH4F3gofRySuRYODrMe0bkcO+Wk0Ak4241e?=
 =?us-ascii?Q?oUkU9Lmphv7Fcl6KZDNwky4QNl+Pp9g2YMDijqA7YToJwXcT1K7S87k+Exmm?=
 =?us-ascii?Q?fLZghI9mYRDVZiXXmtmlI0Sb5cfkwIJTOpI9qFRAWhyHPVx+pms6+vtx1Kr6?=
 =?us-ascii?Q?KEVVtaD7IyUNmrGRxbsyhVOYXv6yRxfN0ruMWebIcupNAUBJxEn610Mre4DK?=
 =?us-ascii?Q?4u0UnknEgh1eJFrTAOJj78myCp5TrAvKQZzAo/6G4zv80fowfvGw1YVjDU98?=
 =?us-ascii?Q?uiJRC3zBilUXEg7un/qnQEYNBiE4Z0v7/tGbtDepa+q9VIWu7LU5X2Nz80QC?=
 =?us-ascii?Q?TsARAMYioiLhGeQ0PBaEKRT47eDhDzcbPnGScFQMES1INJ1TbpYUxpYtJ684?=
 =?us-ascii?Q?Ng7A3A8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB5773.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RL9NKrMUxzOHDH0lG5vgqKPJYvX5ZsMdxP9dpW/5+dMVB6Z1yHi0OrfL7tCb?=
 =?us-ascii?Q?6lnenhIsfSU9A00ZwqeBc5do9fXFmoC+1f2LNpWsM/Vpaath9rCkzKEh+fO2?=
 =?us-ascii?Q?7O9AYlawBeUd8DN2LDNFTQYmjqlIAOYsBbAwY06rL9G6ZdHoDVE+2ao1BRhS?=
 =?us-ascii?Q?4nlLLNQH7+YXOxhj3HqYFW9bu2oJKTyAS1VcH7fcXGC4ii062F3z4HT9zkt/?=
 =?us-ascii?Q?2f3iR8KJMQyrA+vEVYpGWl9hevuw8BGEK4Nsze+cm1ckfQ/DK5phzhguKk0B?=
 =?us-ascii?Q?L8Yv5ADxc5nNzOX2Ld5wLtxZ+W8f8BKWI0GvEkxzk6jD2L4Eq65KgbgfJYzr?=
 =?us-ascii?Q?Gf4utUNWBKC//kN2s0b5cbMI4u2bxV905wDx7HCJJE4a+r4Ro1vWKplghl1O?=
 =?us-ascii?Q?VDZFNiOUWVRO73MLS2hG7d/6Uyt6+Gf0D2ntTtT+3yCpvYCQVYc1IDbEmXn+?=
 =?us-ascii?Q?4q5zD0WOF2sNx3u50fZdqRbBVlaiilF+syBQQyu3mJ0aDDNZbLQ3iATHQ8KE?=
 =?us-ascii?Q?QT+PR8OSZbtqtEmqVYv8Ovex/DKoCepH+W9AZo0IiZ6I3lKbQ9rODi2+zwud?=
 =?us-ascii?Q?nbOKuttmjGke2n5rVDlyG9eyyuZWA6rsxOMsnbdr70vP7xoWcIRoUJf0TJrW?=
 =?us-ascii?Q?2sJKO/1n7fesLQnPhKpOQ26vVGhFV6k53MLm4P4ZKGAWfM4Tg/+ddCckkR2N?=
 =?us-ascii?Q?3hI7ENxu6ordQDkA7bl7pJsQKzrttgS+/UwTKtnp1iMDLFIAlyMZ/5zuQhlM?=
 =?us-ascii?Q?WGqBW25OpeDUN86lVAUiAjevoueCCbuBIZZWmoJasGl3qEPr9/sFulUP0E6w?=
 =?us-ascii?Q?SFu3EnqTmaL0twuOorLo03pWcb1XtArsAMgNT7qJs02E+KXa2KQzM7EL4EVt?=
 =?us-ascii?Q?E3mrHWXlOVtA/8gn81MJYiXWgZUbVlTyL1tIc5wUqgv4kPTUJt8ZWa3u3XS3?=
 =?us-ascii?Q?bt2e5SCDRgYw4RvauF+IM8RhV4m6XTExTDiiL1jDY1iJuKBexQDoBJL54+dx?=
 =?us-ascii?Q?fQvwcAcGnVHnu1FuS3p6RMlJJCmC1kt0nNEc4wgS6bwDzKNW1lOYAb61psng?=
 =?us-ascii?Q?9dXJhGsNoeG6soaPPFe6U1Cm3I+PHsGUDbI9ELUmcXMDUoZMQBtskC0Ow5mt?=
 =?us-ascii?Q?BPIX1I6m+83d4plxy0zC8W0rkHzyIlwfOsOWhmiWo8f84hUvQOS3jE2OW1Rq?=
 =?us-ascii?Q?3qmyG01fW6rCflmpOgrFezdeki+7Yr7bq605AcXWZpVapS13l8x01NX+TRKt?=
 =?us-ascii?Q?hXgOOu5yw4DX5Jdu364Qgor3m6lTiVNLgPL5PloXNF5sYSRmpUijFZ+2FiwD?=
 =?us-ascii?Q?L7hzjECms5U1aFwOkhNdBLiJ+ek849TOIQ+7lhGdes4QCSCZCE7eBMUhPJ7s?=
 =?us-ascii?Q?t2sjESQ23A2hMSaXaaKyEcqbvzHOTxJYhiZFbfJoxCg2Yyovj78ptQMBRfdZ?=
 =?us-ascii?Q?l4xxbY3DEg/gTd0ur2gCMI7rkpJViuPv755a4+2VrqTSsItdqk45i9jTkQC7?=
 =?us-ascii?Q?6/yXSWzClOxjNnGdnFcCKaKB1pQTrwWO3p0RzAeUIea02un3QJzBStlMIirn?=
 =?us-ascii?Q?OjE4BbXcPDmg7tZ029kkF5rxSjZKvT8Vll1G1KkS?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b600e6-9a01-4165-d429-08dd037dbc92
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5773.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 00:54:32.8812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ohPHM+qa9mpC0RQQrDOzjzmnUWjv+qZc76yZSJf1MHm+eMi+vKEZlBcHrCHBx0zfdVbvMmLKdF2TCeGIUAzWOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6703

The return value of vtm_get_best_value() always >= 0, remove always
false expression 'dtemp < 0' in if statement.

Signed-off-by: Rex Nie <rex.nie@jaguarmicro.com>
---
 drivers/thermal/k3_j72xx_bandgap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
index 9bc279ac131a..1e66c98f7a61 100644
--- a/drivers/thermal/k3_j72xx_bandgap.c
+++ b/drivers/thermal/k3_j72xx_bandgap.c
@@ -238,7 +238,7 @@ static inline int k3_bgp_read_temp(struct k3_thermal_data *devdata,
 		K3_VTM_TS_STAT_DTEMP_MASK;
 	dtemp = vtm_get_best_value(s0, s1, s2);
 
-	if (dtemp < 0 || dtemp >= TABLE_SIZE)
+	if (dtemp >= TABLE_SIZE)
 		return -EINVAL;
 
 	*temp = derived_table[dtemp];
-- 
2.17.1


