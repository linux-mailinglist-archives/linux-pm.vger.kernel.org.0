Return-Path: <linux-pm+bounces-7790-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D41418C4B70
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 05:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57D381F22822
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 03:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21CEAD5A;
	Tue, 14 May 2024 03:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pHWZJKqy"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2015.outbound.protection.outlook.com [40.92.53.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD0517F7;
	Tue, 14 May 2024 03:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715656689; cv=fail; b=orEyaiJonFF3JiljvtlFXroWuufHPjqRL34cCiet7pT7Q6ec9IQdh12s1KG/mjzdl5XpvPOqXgPfyqjmAD+cAu8TZ9dG1DPRGQoxoYYIakOfJSdY8FCqiocGj76cqjUIQqjNe1J1LtIixUxM0LiXqLB69N8IVVN+z/3DTfNZumk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715656689; c=relaxed/simple;
	bh=gW4Yr4EBnRquWbSysYg2jKtSO6LU/pUdbjElvV43mmI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FLJTlP/AAPv0AVFRFN5q6I+Z5Np9MeClt1T5UDq+FDwJAglAYinAOJMsJpaHCvsXB3awuHTLAIrk1Ha8jaUqXaLtQ4DOrOF6XG3zDkURo7cETEqZ78Lx+YgsSVwjSc92ns+r8OQIvijasZYtFWQ1jUdKo6UJq7rdHaWjVDxfRNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pHWZJKqy; arc=fail smtp.client-ip=40.92.53.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENpPMx9sqthdBgmCFkCIdZjGJ0tMe7pxTyV9627KZ0NShPOVOebwLu5jJVLsv7ZpzKSNRVp1FT1xi2bW94f4m4JhrTizzrZ5j8bod7nxnhX+uvi9ZwajbdnK1Z5bfDPQWevka+1MYNi6MDwgTufv8gRcJcLqJwv+LIGFL8rzaWA22krSbonXcX6qJWjxi31Xrg6mfv1HgzTHytwgTz2vJLrh/3DHq4nIWfGtrtEpdpU+GFf8aHX/0fRynvKnyKsOoB0PKh9WoIVLJnocVoEe8wQIWTu1XrYewtbdKNw/BZ5+sVdoMZo2sOobNFncJtIUqyLP6R7GdIidE/rDHoBohw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3NxDdcRa2Jghi40xxKzyretP6fBnW7Yvq8bu5Z4D6k=;
 b=aXe6W5W4spU5w8X+Q3KlfPcnSv6Ejy+yZbylDOpWjnxznKmnIQVu/9x7t6dzc0sSA3MVdYD2F/d3Sf+QfQkTXviFFasHq6SI9aADX2dbYM4GIbD6VicqAF8FehFZh15RyGc0erT/UgjMKrOrp+64WDesfdnUUSbYro8GrJls8gWU4jLkqwYjoZnerV6q9MGY0R9lFzRnNQ/GoaNgiHqtTuOB2eskZqrXV+vlGcv+gDrwwcaNqcfUHxa4AWgUKyu+0xJp1NDpGs3FN0eNUwYNEoMaCLW9Mut4S0jG7hebMTLFD6tKyTH3bHEWToD6AY+98qQ5T2xBfUBUB2hvupLUnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3NxDdcRa2Jghi40xxKzyretP6fBnW7Yvq8bu5Z4D6k=;
 b=pHWZJKqy97zVroBRwYR6nziiPXZdUiCue9BkGjDQWBbmVPuCuUg6mKU1AbyH78EQCwDBxIj+tOqeQYDBu4jmpS3glQ8nKJogd6wXA22vg2eudQjaC9TEwfmLP9kCdPrtGFa6LNpclJDvKWBItx37qFkG4cTxH/5ojq/00WbxOM5gW/G2UpYtK2YlY9BanprBGZzz6JjIEwg14tF69BI0Hcw3UtUmyM3TdF3wOUhah/qu9D6c5+UA6V8xtV5Ko06ZD8x7xzhaPFCxBHSBX9VfCowSAATzA+Ois00PVKmMUPCSypvy0hST3nmpRzX0d/PE+F+bvX0pCPInrr4yAOAH8Q==
Received: from PUZPR01MB5120.apcprd01.prod.exchangelabs.com
 (2603:1096:301:110::8) by TY0PR0101MB4666.apcprd01.prod.exchangelabs.com
 (2603:1096:400:32d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 03:18:02 +0000
Received: from PUZPR01MB5120.apcprd01.prod.exchangelabs.com
 ([fe80::c050:3818:262f:8ddd]) by PUZPR01MB5120.apcprd01.prod.exchangelabs.com
 ([fe80::c050:3818:262f:8ddd%7]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 03:18:02 +0000
From: zhida312@outlook.com
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: Peng Ma <andypma@tencent.com>,
	Huang Rui <ray.huang@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: amd-pstate: fix the memory to free after epp exist
Date: Tue, 14 May 2024 11:17:06 +0800
Message-ID:
 <PUZPR01MB51206E9B32294882EC34B09592E32@PUZPR01MB5120.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [g2ha19vF3Mdu3CPs5bRU0uK8oMtofMZ0]
X-ClientProxiedBy: BYAPR02CA0042.namprd02.prod.outlook.com
 (2603:10b6:a03:54::19) To PUZPR01MB5120.apcprd01.prod.exchangelabs.com
 (2603:1096:301:110::8)
X-Microsoft-Original-Message-ID:
 <20240514031748.428068-1-zhida312@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5120:EE_|TY0PR0101MB4666:EE_
X-MS-Office365-Filtering-Correlation-Id: 1afdb210-4ceb-4e6b-22ec-08dc73c47681
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3420499023|3430499023|3412199016;
X-Microsoft-Antispam-Message-Info:
	H8Cmg+yx078EQJqmpsaabwivN3+ZwWpfDqUh3k98fqaw4a0btXgoBFKmeBNP34sqtU01t5zz0r9ppJsw4oRPUJbjJ8kbUGVdZ2DJ2vFuuG7Z2uYNmrjXG52VcNIxuGGTjFox4Q5XDbKRx/W47uHw/5gpnLmQwhZ9PdMBK+Wj5M+V5/pC3pANqcMATXuA6RPvzdY8DW8CW+GMDZ2OU7qJqminWopSnENqaNDSAI0WEaRMDKQTImEYeD63BmL7D6BVFLlJQiRmt8meHIxoDG8Lm3Ucam0b6ItlJuixeHQVPFX8SZGKsux1OLXrW6X5M0X8fWI6Iu9BjWeKCbNI/G5r6baFnf5WWgTPEu6+lo0mwoM2nyIcuYtH54dTsU3NSORk6HdMhYVEw8ZDs96iproRnTtDqgprytJmchMrbzAwp+unoCgNibXhD9ZIq2cT1mtya7JdIW+V/ICu3GBDCmqgvPQkA5TVwQT7m4VDOwllRAF7FUmNfiAA8tePZr+puC+SUp1sCgL0H8BaGbiN3WjFIFY8xf8Oz2z2VSHHpk7evQkvgpzRT8L9RazihzJP/uCV
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZTRstFSH9s+WcekZjMDdAD+SWfVk16Outyuowon9rF0vTZOm/fpyCosokyy0?=
 =?us-ascii?Q?3N8wO1kMPjVaMij8kyOD3uKDSAIe5pQoozWXY0zeSLpYY3MtgyRm90iETi8f?=
 =?us-ascii?Q?+PuYGsmc5ysIaZx/fvRrsOaBSza6504L37FT7FbzuveZeJk9I0GcRtnTM9FD?=
 =?us-ascii?Q?sYLks+EZKJ4Bxb1krBOlZitVSbUJs2fVz91NO5vG7vS1FoIaFtSVf8EeTD6w?=
 =?us-ascii?Q?PSqMaVsdH9MhGZlAkbHcNtze40qMCeJ8cS61KjuZcTwLKudP2kAl50mpkGHx?=
 =?us-ascii?Q?M9fJgIvTWDbEAcBldvUb+UcejlCqtFIwDTqdr0vq4ufTslIYHw98YQigNg0S?=
 =?us-ascii?Q?sy5OUmhRp/4PkvAeCn2R1oLNKVk38dwXobpszdtYraMtyivNIArUjg2ROELZ?=
 =?us-ascii?Q?04DNJHX2ZbxhiULlbo6GNj8GoNZYC13+jY4DmoBeISiiqX9R7t1C8c5Bhk6t?=
 =?us-ascii?Q?e+uS8tLTBuX3lO0NpQ54eaFczVMjdwfZ2MjIMeboI6HwVRGMMbqBO00p0PPX?=
 =?us-ascii?Q?MefWXGjPE5mcC6i2nXiXfT1wLaUyvkd5InGPx6Z8Lb6P+oUChEXzMQesb3wn?=
 =?us-ascii?Q?DMW6R1Unc8+v7dxBJxqKdjq5AYsyOjZebmu32SS2VjCJIXR/yRSRIgkG2DpK?=
 =?us-ascii?Q?q3OrIgcda1BjdCiXg8FL3DYt5mDN2N1q+76HizpzUKq8LvbP63jGcJYmu0rf?=
 =?us-ascii?Q?qH0C5ePVU+K8gAlbmJ8zN670mRCHLw01p2418C7cLxlcpRj3JVVYH3YIzcxt?=
 =?us-ascii?Q?lHvAwCgKWYnAc8CF5B2QF0KFc/CgLed6cjxGOGOJ1DuP5KIlzWkn0iTsCf5J?=
 =?us-ascii?Q?MdML8cyJDEi+B9l2/tvbDEDXNw7c4xbfotKEyKUcC7k9HBsMoQ1oluKOfK3M?=
 =?us-ascii?Q?KSocAFHDr5HaGV094gUcfLkaeCC+ihKuOpmOyuMqLTnVN2NiwuNFrQSzWRUd?=
 =?us-ascii?Q?Z26a0ZAJfUs2vEdKlm7DwlhLhVTSCLrcgRwUoli0I+E2gBgEhq3SGjCQA2g1?=
 =?us-ascii?Q?ogvseMfqX7OOiq7jCG5hOGJnUulq0NBjjYThiB2lGG3L/jXz1pPbXa/5WaiU?=
 =?us-ascii?Q?cwIWnWQO8STiRlFfalVUh9/WXREhF+mCPexjsmLBggfLzB3GtrGo7gZotsqk?=
 =?us-ascii?Q?1e1dBa694Nv02NNZaRJX4qMJOwXj+tLRhPyewmBh0gah4dMp+Xfq+11f+ZcO?=
 =?us-ascii?Q?u8fKFCfIoNSon5LWCluZYNU9Yq81Zo23e/y1WD1OFlYd0PM3MlIcbFfp5iI?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1afdb210-4ceb-4e6b-22ec-08dc73c47681
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5120.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 03:18:02.5917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR0101MB4666

From: andypma <andypma.tencent.com>

the cpudata memory from kzmalloc in epp init function is
not free after epp exist, so we should free it.

Signed-off-by: Peng Ma <andypma@tencent.com>
---
 drivers/cpufreq/amd-pstate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 2db095867d03..96a323f59a93 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1425,6 +1425,9 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 
 static int amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
 {
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	kfree(cpudata);
 	pr_debug("CPU %d exiting\n", policy->cpu);
 	return 0;
 }
-- 
2.33.0


