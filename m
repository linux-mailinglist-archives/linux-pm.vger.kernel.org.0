Return-Path: <linux-pm+bounces-34192-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D45B49EF4
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 04:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8F961B243FB
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 02:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E05523BD1B;
	Tue,  9 Sep 2025 02:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="jmtataFC"
X-Original-To: linux-pm@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013024.outbound.protection.outlook.com [40.107.44.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732FD2222B7;
	Tue,  9 Sep 2025 02:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757383784; cv=fail; b=EjGLEXBTLzB+AMf118V/JgsFH0RikLStKAofCVaaPVDC+qglQWQw0q+urM5e/S1AolmkW8lNo46T2rIHEvMrdLqyY5EroOROZUX6W+//EuuAuFlNf++RcrXmwz2ZtUuMF1TD7APVsl0H1CDGImmlYu5eysVfOtWSAWjKg1glh0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757383784; c=relaxed/simple;
	bh=ImxDRemNLAR61M+FM4hGXhj3uCU95KW/mNhHJJHaHRw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=QuhN1hWsQaGmRYwSE8Vzg7OVKrnzVCPRBxhmTySh/3zOmSEBOZlqsIsgl7RTzzTamJKeXab7WHXm15Ptx7zdSJLpluBBoVU3Cclek+rXlieH2Xb+dLqXqcajitaeSTtekUBo6jA1tC/mNxtluCSu5HwXxrFl7jJvxxUJdZFVVio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=jmtataFC; arc=fail smtp.client-ip=40.107.44.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l769NqO3qN7eWeiW41O5KVOJnb/I+Cc+agzpU8w0Bj8rbR0P0JgR8FjrEdUFari+e8CSIKHt2lri+/RInH10dHLWYHViE2n98lxwUMkxzWmqZNVfr0tjhks+D5t6Lz+b2aRYT3m92+SUJG25M4fEhgUd10LOJ6yGxbm4KcD6iMVemh9/rtvSDhEC9Nu0KfanpY5rGY5Lu7MrpEHreWX/aH4hm0BZ6YP7BbqzCP3zZCNgcXu9olUG9RkOx90kzjYHc8rP1eB42IinI7WfEiTe75SDZlEAHhwiWhUdBt4N3QHhzV60x3Lm9+PG+nNZETfLVxnOROEO3tGMy3bCJgztIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Vzg6kIO+UoBIbWuxnZInIiulpUG9dQFp0Fou9p3PVs=;
 b=dxq0XdrTfT5kCpGj9aGhwhTdTWp5ojJDbpzhe6nzc5+kCtpvoFZt5JIZAYBvZ1Gv0xwxgwwkwL1LM9seLGTX8hsz0uAlvZlwPdF0vG6mMCWYIl7DkSrtBCaAZ6Js1vmBRWIK7Nu+PHVKydw1MaruYyU9KrBgeg5TpUbmHvru5crFr2Ky7z4Vvf1VtZfW/gSS5EDk4WezlUQE02MP5++Pa7NgeeRhLkiasAe6WdVAJotiPu+OQ2/DQWyTvZivjLk8A7t1IoUBVJzmD4T5L8kYrxdWdarM4ZiUO7L4ZegpjcR1PrdK2SE1RgFYMVgNi2YK1qLaXRKK/lD3YF5lbNk1UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Vzg6kIO+UoBIbWuxnZInIiulpUG9dQFp0Fou9p3PVs=;
 b=jmtataFCIt8vjf0F0i3n/3Bnl5gHFnDt3WBzJseB0KNRQM85SaPUrsc3mdnJDwbF9Jy5fT+70t9l0nspUSmyzVM5C14LM7brubTt/lS4CfwslQXZrqapfRdugT3Bsn2vIl1lgxErjhcmg57J5uDzDeA2p2AjCF7B7HE0n0bcWR932kzEDj9cNvLLTYCmPIAHVjc+JjIMwffr/g8vWnjy/aK9c1bMiy7CtPMCM4RudHBVgf6rfJzTm0NSZiH7JdWq7FrjAnWuRc1UaV1SLls1Q5Rx8OHmOETY+OW4K/R8eK9cwB+lAkz/g+w9/W4fvIQall600yYQrjoscOIY1AYsbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7330.apcprd06.prod.outlook.com (2603:1096:820:146::7)
 by PS1PPFEFCBCC15E.apcprd06.prod.outlook.com (2603:1096:308::26d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 02:09:35 +0000
Received: from KL1PR06MB7330.apcprd06.prod.outlook.com
 ([fe80::d1d3:916:af43:55f5]) by KL1PR06MB7330.apcprd06.prod.outlook.com
 ([fe80::d1d3:916:af43:55f5%4]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 02:09:35 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: sre@kernel.org
Cc: pali@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] power: supply: rx51: remove redundant condition checks
Date: Tue,  9 Sep 2025 10:09:25 +0800
Message-Id: <20250909020925.382261-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::10) To KL1PR06MB7330.apcprd06.prod.outlook.com
 (2603:1096:820:146::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7330:EE_|PS1PPFEFCBCC15E:EE_
X-MS-Office365-Filtering-Correlation-Id: 0faed892-05f6-4dc9-7d42-08ddef45ec2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0OmJkU3uXZ1qcGYYxpjOkZwcV5p0LCoYiqpRQo1ERVfgjxrcMmoU9UTWroMf?=
 =?us-ascii?Q?SRxUI1tsZIpWHqkqIDd1S9M0ooJcFRBxHzhgrV/fH4O4+mwVDyiBYRhBc76U?=
 =?us-ascii?Q?SANMBkkVJqIBbE8pmdY9FhEdSd7umSX8RzY4y9JYAYv06rLP7+SMkGk6tXh9?=
 =?us-ascii?Q?6m5Q8wEdSVAwBWdfpqvOMdME0LexKUvgEu8TY4Utf0Ng7bJwobcCsWsIb2iC?=
 =?us-ascii?Q?+Qh+6KG2Q0dnvHxXmfCbLwaSbuu4P3qponVa2aXCcI4/59KPxXIEgExwHp0t?=
 =?us-ascii?Q?UkLWc/IsevzQjuw2fGUvHvsYX7kp1+ss9fUDwicJwEcNwVkUSOnnNs79dk1W?=
 =?us-ascii?Q?nfJsd51AWofl5kR3qu7A5ZPv6TI12fn05aauFxsGMMR7NU0NdurYt6OlUtwp?=
 =?us-ascii?Q?MC447QCc4n3IuRhWhGi7X8ahOGhGUiozOuO8O84nGfW91BJ1cJVTyttoeaAM?=
 =?us-ascii?Q?a1cN0tWK4/mMSM1ToA+c+IKUMStSkScUG3e66563uLHTiY+JD3CzexpA/5X3?=
 =?us-ascii?Q?5nMRJ+CFZcg+a59MRuhiJUOt3TxVtDjTX4vsBCpuu3nhPCNlqXaC0E/Jtv86?=
 =?us-ascii?Q?/OZxkWsvULyRf3Ww90jm842mViTaO29A2eZHA64d0Yu8KMnWwEsI0w4V9qNN?=
 =?us-ascii?Q?WidFj2Zf9Uw+yQbMC97b8tE7tdQL8X6BB9rFL4ycpmZmWfK2ZnzjCrgTZVBU?=
 =?us-ascii?Q?6JaSXYSO6fE8pIRt4jy8I6chtAEF7VgygaUX4TE5XMk5ugsN+QjUn2ROVlPf?=
 =?us-ascii?Q?YU9JjkXTyD3csjE4VuF2JtOYJfyERMTQljB6CEfTdKZ5erUA11QaFv0V3BiS?=
 =?us-ascii?Q?aI6ckTiw0cRpqoqCaarYhAowzkxV2c2oMX5c+6ZZtCzEf8vAFEwiQvMGRthx?=
 =?us-ascii?Q?MpgDEtuYWvXfQqXazIvf3ulmzDz7LTid2xhF6PsyaMPO+2WkkqFVc0yHpsBD?=
 =?us-ascii?Q?K7brzFtZBtNBWboNUvhBHD7doKnj5HRjeZLPRefJzHz5WoKWPspBtQMzMpsN?=
 =?us-ascii?Q?yJgPd6sUhnB+bNGnTpLHkqVeqimd0/rNa9HL/qc1IIfC7JgFTI5n+50UrQMs?=
 =?us-ascii?Q?FPMhcpuaxqijCh4gsI1YLekfzErNdFDJolJGNsBDS+sry0O3Kfjy+unnbgWT?=
 =?us-ascii?Q?3b2d3sFaUvTiBP5PlgN3ZALz3G2Kh6LzL/pgoLJovRiqT6KbkQt6CUAuhuAj?=
 =?us-ascii?Q?jspXEiIS3o/Y3mTzB/qvw8wqpUnzO8ygc1QpvChWcnPJIfI+1pTMkntx0lts?=
 =?us-ascii?Q?ZHenK2PM5/K19DJh1VXNqLb5tTzkACiSLr5Mc4BtOEo4uAfJ4ohBe+Xseit2?=
 =?us-ascii?Q?+Ha5n670nHI+Du80GaTX6dFFBXQF7/pAsiWCSCr//UyvlJe2HbXi5qRjO+sZ?=
 =?us-ascii?Q?12PQQsjL70o+niuPPEzfifiWreNtWwL/5RzJSI4i9JjrfLM5LWSW4olDEYuj?=
 =?us-ascii?Q?dIsICIPrOJBAmXBWVhqwWxRNi8OX7aBN3l2JKiC5LtNw32p0fI/ZmBoZSxdV?=
 =?us-ascii?Q?ZPDKw1XGvA0MWtk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7330.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CXjAq5cYOYHzNA+7BlTCeYf2LESThcySVZsB3/FwLx74HAN3r4e5WphQ+uo3?=
 =?us-ascii?Q?pkH56dhAydWh2hms4Ij7V19YkLv/nSG3l5O5atPieMEKIZCLTiGn6JdPIlnZ?=
 =?us-ascii?Q?71vpE1FD85wIQbB2CqcF5EIhNk5C3NPROdYt/lSox06zqlF9Mf4UlRB8PH88?=
 =?us-ascii?Q?QyhCW0nQ8zABag/O2p4wLUfJo7S+gewaPmfd8PTx1mMorUbPV0X1075tWttl?=
 =?us-ascii?Q?Uy5vOp/NMkbPUara7z0NmENfeJ+eYafx4JETSuVN2EeiX+u4TNLqNVp9W3zr?=
 =?us-ascii?Q?EBO8r0l8/ckcAxNukC6uNt2uP9COK6bXDGUF9FElO44VpbSsZxql4YfPe4sB?=
 =?us-ascii?Q?YRZsll/vgxbX4sCyu1OB2VtDYv0h+ecA7Ps8pdGDt19hhXOCoDcZ4hHrW3N/?=
 =?us-ascii?Q?YhUhDvkTwEeMtVBjtR1r+HpAS5zfsPBlJgjnyRoVk2t/zQ18qqXLL+NTreUi?=
 =?us-ascii?Q?gqw3UoV4JgNEtQbNoRBylq06DneXDosKOqp8WYKUi4KueCKUpTN3OehjRwng?=
 =?us-ascii?Q?iZtLMYHRRXJaplpOHAvLSMfl4UgJ0Z4dEOYnCCI8flurag6NGR5vjRT6lCls?=
 =?us-ascii?Q?o2unpQuiQtcIiV0ll+TX5f+FhzL34ZS6rvZBky4E8EFc3WFpk9yW2Ny+HViG?=
 =?us-ascii?Q?AbXxU2QvRWjZDAFEiNy2dz+ZYMAXITk6BBVjGtoS1JdQwr9541JU3D2MyLLZ?=
 =?us-ascii?Q?ZdeFy1p9l44bwe2ytAZ5piwaDba9h1Pzz7Q8rt3+KtGLoZTBrFYNdb6y0zIi?=
 =?us-ascii?Q?cEoT+tk7+72a6aFWZtR/X0CojGTPPtVSO4v3L8x7adk14d8OU04xH/lUeugG?=
 =?us-ascii?Q?bUiTKsHXUsmAjBhTHrHNXJmCMUCC8wS7mRvp9n279shXH4zf/Rgoyq/6Ji0s?=
 =?us-ascii?Q?eJ9nbKEeCUvL14pQxkulBMYhtl8Y+XiH+mhxXpwazdBoMXOm/a9YXfAzKPJf?=
 =?us-ascii?Q?Y+HUgZ+Z9SVSRTvm1fTwk1efx1/FyZqOuF+cY478SgBZuYBPUXfAb58cvE/+?=
 =?us-ascii?Q?rvun92150FjHPvKJL4IB8vO7x3iNc4xliqzNSgyQi6njm29mI0nAyUH3hKzH?=
 =?us-ascii?Q?ZmqzWvDwwmkzJIDHwpMtgQeUIud3KSTe4Palk5tsH04cJPJqrWwG3aBa8ycE?=
 =?us-ascii?Q?8E50dUGLbA/M0UGNHzHz3qCbHOrpi5ZzuisC7hvQy1Ior/M3O1ylohdKzr8z?=
 =?us-ascii?Q?KgbYQ5Zby9ooZHIQEUT8EmZfpwbbNkw+nZhyrVwE6XMdqu8c+PsTpLYmO2P2?=
 =?us-ascii?Q?VTUSMeCde9eRpOdRJMu6U47LIolM6oRAvk7Lgb1lTy3zXcIKo8eK5NG/PFsL?=
 =?us-ascii?Q?LZdzYFWbvQL+kDpREM06mq5gXOh2B1KLeAn2gqYXt3exMsE7lMObNdAMbf7M?=
 =?us-ascii?Q?k1sEQyXWNhNjHrw4tpaiKSpE/j6sbsEgos9woQP3x+VABCs46FQodrDqjwaG?=
 =?us-ascii?Q?JNcmKUrnEp4xrylxrxnEk8itNQPWSHRdXi8GNv97rTQZ+29ufyDk0L2tTgqY?=
 =?us-ascii?Q?ORLUIxm69dc5Fgm6n6olQArfbj6JCEVaw4S2hKWp4msbI5ALZzh2x7UKUIBB?=
 =?us-ascii?Q?EuFBwpiuOZFRp8vOvjl3M8oDh9j400U9NbIgjfFh?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0faed892-05f6-4dc9-7d42-08ddef45ec2e
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7330.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 02:09:35.3246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ADvMjN0WIBMr2mejDrjrg3Lm9+MQth/JEnKi7uxBtvEpq1jhXDVwBl8D0l5LmucCkZ5T0ID0Qfkd4PkIGsgO8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPFEFCBCC15E

Remove redundant condition checks and replace else if with else.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/power/supply/rx51_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/rx51_battery.c b/drivers/power/supply/rx51_battery.c
index 7cdcd415e868..b0220ec2d926 100644
--- a/drivers/power/supply/rx51_battery.c
+++ b/drivers/power/supply/rx51_battery.c
@@ -116,7 +116,7 @@ static int rx51_battery_read_temperature(struct rx51_device_info *di)
 		int mid = (max + min) / 2;
 		if (rx51_temp_table2[mid] <= raw)
 			min = mid;
-		else if (rx51_temp_table2[mid] > raw)
+		else
 			max = mid;
 		if (rx51_temp_table2[mid] == raw)
 			break;
-- 
2.34.1


