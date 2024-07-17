Return-Path: <linux-pm+bounces-11200-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBB5933728
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2024 08:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA882B21DFF
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2024 06:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3825125DE;
	Wed, 17 Jul 2024 06:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="oW2ER1gc"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2056.outbound.protection.outlook.com [40.107.255.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCE013ACC;
	Wed, 17 Jul 2024 06:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721198018; cv=fail; b=E9GENnkIAxZGTCS6JbtKirUEnsN3jj8gJiDluyG49loA6WNmkli5MUtWZQpQUFotMRM9F6J6/Xs7yMYmP7fpXJ9iVGgQVOdvJ68SPmHOo+O789g6AXaGnvPgP2L0Coqc836pkEdOqytQJjOnxv2G1ezbT0tCrASwxYUq/nArtx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721198018; c=relaxed/simple;
	bh=765OpcBKuMHUf3wAF87WQVSvxVNX1zGmsLwg64jnOUA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=iH5/OmUnO5oNbINCWuqmBUqA0uuoAkXKiRju+x4XgXDJ+yeDc29wVNc1JgQSTdHoh7cz7S67MNbFZctPn2TjtjLeK68JKIuXt1umpARHB6PH3f9geleq6qJmlqi5ABf5EGFn2w1kMjOhroL9Vh7ppcodCzAojd3Vw799/P3a4fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=oW2ER1gc; arc=fail smtp.client-ip=40.107.255.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rpWof34FGU5sJOrHGlRx/aYK4vJblDqOr3y1A68aUhtrBg/zRri3gBX21StlDJHcWwADmz1vZ9yIBzT8pwBfL/ickbvDNngd64DAhx/CwMaMUQBj5FU5ogQq1sQgzrhDhmz0G/fkvxhpW2qC0gENSD4Xb3wL0SIhr0K9y1f3Cp5bjvYnn//xrCE57ct0IMvhDXFaoP61CWjQSgs5TDITjAxCeptj2Zr9iR6HRHQU0MnZPFJeK8yqI82oFvbgAJDeihoWnj71CeA1qrF/cM7yr6o272P3Ux9D5O9J51sVyxo6LYElz/RWRMl48iE9WePtYvq7aHzrUbfUXX/bjFjEBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnqwCsUlYNUICfXfBAYhv3o9jxzb/xg0/Zu00y+Wtrw=;
 b=IrcTWqIv3XWXZ/VdctwzsY+/jaOe4yV86LQnPevHYZQ50XUD2oa2QKW4nD+qTlR7vDtOBo+3NgCdlZusORLUDrIxVPrDUX942u/L3l6oK+MUV8JHKPQjER4k1fG5tKPqUAGRDFMET72fLzHrtThY4rUOczuJfxGJasDH9wHXl72E4/FifB/ie313DDE1Isvjav1BnWYbwUOjBJ9QVK4bq5XtlrcwZKWCfjJTFV8EvuzUy23TY1oTnyQedVK9Opogw/K0Ngd2uExOomSLSq85FGsmJfqyER/VkZw25TJk7qOgCzqifr7P7CaOoudn5nkRH1AiOzB88J7h3jmK+8eZbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnqwCsUlYNUICfXfBAYhv3o9jxzb/xg0/Zu00y+Wtrw=;
 b=oW2ER1gcbYaNFfKHIhejyDaqIg7CW9i6Dl9vRYthylGbBZcEDaD/g4+49TJHNrtJZ75U++6w4rTBcMM6M/7P1JmyCodoIZZh9+JP8j0xa0R80svEHpyhPNkZge1OeJD0RBFAiFffPQwOQ+0VeSUgFMr+nw+ocZBLL6TreCHBDPs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SEYPR02MB8152.apcprd02.prod.outlook.com (2603:1096:101:206::6)
 by TYSPR02MB7218.apcprd02.prod.outlook.com (2603:1096:400:46e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Wed, 17 Jul
 2024 06:33:33 +0000
Received: from SEYPR02MB8152.apcprd02.prod.outlook.com
 ([fe80::6bae:c194:2032:70d7]) by SEYPR02MB8152.apcprd02.prod.outlook.com
 ([fe80::6bae:c194:2032:70d7%4]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 06:33:33 +0000
From: Gaowei Pu <pugaowei@oppo.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gaowei Pu <pugaowei@oppo.com>
Subject: [PATCH] cpufreq: queue policy->update work to rt thread to reduce  its schedule latency
Date: Wed, 17 Jul 2024 14:33:21 +0800
Message-Id: <20240717063321.629-1-pugaowei@oppo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0128.apcprd03.prod.outlook.com
 (2603:1096:4:91::32) To SEYPR02MB8152.apcprd02.prod.outlook.com
 (2603:1096:101:206::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR02MB8152:EE_|TYSPR02MB7218:EE_
X-MS-Office365-Filtering-Correlation-Id: 59978cba-884e-418f-296e-08dca62a6184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5XHZKsKCeaWrNWoWL6VS9RWdFhj97gHDSx+USuwrTOkYSTh/CnzAsroSXxL2?=
 =?us-ascii?Q?JKbdx+/BQh8QwmDmBxiicsX+QkHxh64h0U8CppLHsG5e9SsqgH+IJMRrxvXx?=
 =?us-ascii?Q?I63Fjvb1FeWj93C9YoPk9X/C4Hk0ceSRTS/9/J8uEi9+x0QZdzU6KczuZ0Dr?=
 =?us-ascii?Q?DIsho2HXmDQ9zRCb2rCqtsKRJyWvdP+f4CZldP8VCk79a9CBelD9l3X5cZwk?=
 =?us-ascii?Q?B/Ur50sZDuHtFpZxwUHdfirNso8uIGw3ECHmq6g5lvdWyRraVmVRsz+9q5ol?=
 =?us-ascii?Q?oiJqLdfySkcHt0obxDEDeSg+xcVOtSqYzYI4umW9OHU0XUiQ8EKJdIc+QmD8?=
 =?us-ascii?Q?OzgXryo4Oh9R1lpn8wtZFC11zFtCM4frjkWSW62D0o2Z6QUJuVz12QjFvwou?=
 =?us-ascii?Q?PKtiVpCankqv6CcH7zIMHcaNkIseHT54uqPC5hBD7M5wX95EkoFXygLYvh3l?=
 =?us-ascii?Q?2i8JQrPZV7cdQekOu1hjkLHqrcDMGslrF1a/9YDCdrSIaZh4h3QKtyhwv/FT?=
 =?us-ascii?Q?t4JZ0n0u05QDfl+oWQy+osrFyh0A8RArdcJS678o/Jci9PVBUzUxl6wv5EF6?=
 =?us-ascii?Q?do08DtA8sBHjmvKL30Fjs1+b9+/AylTEmLEnJ84TKAWLIji2zA/FFazHcb+c?=
 =?us-ascii?Q?xEXBQjRUwEFTZZlJB4GJsVcQw6TR5Tt6dYe9+qU+YNJM+B861+gZsj7wuHRB?=
 =?us-ascii?Q?esfMRTisTJY1r1Q0XVOT9bAEJjUmcjuDukfsAJa1GS7EtHiKpA23hIp9AXUB?=
 =?us-ascii?Q?6HKBZrF0x6ENmaiGU2aJeovx/2QcYSNVrY/h8e35l6Fgjje1PvFj0RUKFT6Q?=
 =?us-ascii?Q?sOEO5MeIFYhXR9b62yoH6bwXn5Td27yoCUdIXmvntIJ83dmJU9O2Gd+hotI6?=
 =?us-ascii?Q?icHgEqJA2EgFRvSg/zKF1aFDQ+CR/gCnHUKjISZB0SaF8J6ou6eIm8zEbH/2?=
 =?us-ascii?Q?qUdyMju1fMNdDKsdjyiKNrJ+gZj42pSIDwBSITlbdlYvZyH47R8ewjNX6oOG?=
 =?us-ascii?Q?USVX5BV9kAIu/EkpFI7vV/FxNU6ZZMh7aT2DCeWjIPQA1lZPWqZ7HgLlLO0y?=
 =?us-ascii?Q?///r+EguVfInflOMF1NkGRXcmTmLqkk8YyDuh05yEpCBfyFE4VGOOMvoI6U5?=
 =?us-ascii?Q?4L6vCTqd+nf23+YySUus0YB6pdoEBHxSSKyVrB6hPBs/9aBIfv6Tk5e/+N8h?=
 =?us-ascii?Q?XV40liEeBm4B8UtLh84KIchwZIqbOJLhsUXxKIVaoNb/Cb+9UPWSwELJOy1G?=
 =?us-ascii?Q?m+24mEFl0AGEICjxMlTlSu5Bjnl0d9pnsbzi4ogY9Q7qf9Dn2pHcYqGxqFPq?=
 =?us-ascii?Q?ixzMzUj5QoXuhPw50SxI323PpHymTDgGO40EuPvwl/sEmfzQlLbJ+BgFgGRV?=
 =?us-ascii?Q?kJn344L/hZJ2RaGZdAWZ4qw7WamvM4rSmxhu0rqiEnO17P4EHA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR02MB8152.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bek2uXo5kEeqasBj9T20u8xJx2/JXNzdXmrxcF+ZiGkESNBkcdNawJeidoM5?=
 =?us-ascii?Q?8RqgpyJP5+I7FazUTUzKLNFAXrrx8CDeVMk0hl4O4+7oVt5PvehhVJvRxbUO?=
 =?us-ascii?Q?al7ylTIsctf8fmwhBxTCEtJfUx7+9Eir44KSkvtf9xLyB1kHPFpXYlHUNbME?=
 =?us-ascii?Q?QwYyDbf/rWf64+Q1KQtR9V2K6cfj18uvt1B151zyKTJPadBZxslGUS1eEhGM?=
 =?us-ascii?Q?7Wu/r9EZkyi7yNRaz9sb4JLyJ1sCDn+g/gZ0FfOMrO2DlfUNuPxWD2Ey685D?=
 =?us-ascii?Q?cH079gCv3Y3pIRVmwTDTFJ7EptLtbyDG7LC7GN8xk+9xlEcIDNskT5RUYzap?=
 =?us-ascii?Q?ApsOnHRResadmcUx1+XAC6zAXse3ZENpWff1xyEN2kT2NIrrPWmdB2FGzfeI?=
 =?us-ascii?Q?65VGVPuDjL3RVNS62yaoEdu87ZdCYuH7FfAhe0wRLkdVgMO1+HXHrmqFSlKu?=
 =?us-ascii?Q?HOwnA9KMon/fqFChJMXkN6gISMcvnNyTRRUwMsMfHRfxxkaPHXLDn2zCAnxI?=
 =?us-ascii?Q?uJIDoaEW2jhGrHyD4w5FPDBvyV1k0tKoY5O1s2XWwUdFkxveWXQHUCyaGezw?=
 =?us-ascii?Q?z7W1qE4fBHC7ISlyvpqpcDaQ78hFpJNqkqTqAIbR0NyxoURZcrBgLJ/qzb5h?=
 =?us-ascii?Q?UZdGqZx5NX5MQIWgbhxDUIqK0iXY9yJriKb0bZfP1WwUeYQ35g0xSgNpcdXV?=
 =?us-ascii?Q?ei1Rqaj1TmSlLkCBlUfDFYthO4Av4EB7az2uYJal4HvxIDdPmImIFOxDfH4r?=
 =?us-ascii?Q?hlzvb0IL5Ykcd/BBR5lWLH88SxpuV2ynrZy1OJYYrON7pp84Y1prK1oEbox8?=
 =?us-ascii?Q?3M0hdoA+W0SYVe9CG4yM3DZTcyZ1/N90pOcziqaEd1Og605SmjI3r7VHCbu9?=
 =?us-ascii?Q?RAwhA4mazJiyRd1y2tka/mRslTEH0jV7yrnqhh4eA2udM9UpQcL2AW9jNSQZ?=
 =?us-ascii?Q?26kz6IqLocQzZMTkJXDWdbcvOYFMlB0psHfuKlYVNp6KU8YLaByOibx9kewb?=
 =?us-ascii?Q?JfXTXUlxypgyVl6xROS2Lr+FSXtbc5h7li7d1hBDhW7FSGDFPiczJRxw32iX?=
 =?us-ascii?Q?PjzNnPQ48RsYDwlt7Vvks8SavSiFzXj9zI4VQEHqQL8sFbMUCUZsJll6VPe4?=
 =?us-ascii?Q?DznyuaMbcHBkJkfTAXlsJV+m81FDLXuuQOXSe4BVCNAlrlwz3gbOnzm6LpdV?=
 =?us-ascii?Q?hPNXxK7FkUM+ie/MzXpuUnPsMXIfw5etq69fZ1lFF0JrckNpvHQ0+UpSx5K0?=
 =?us-ascii?Q?Iw4LFBUR3/7lygCSLFt2ik3g5t4BEpwxfLVgZ6jom0BmYVIjK3HrQSjAGdSF?=
 =?us-ascii?Q?oBFTBJm+jy3WDlm/akhji0wHnF4U5pDSHEFBFBg4e5gwmP8bjJBH8jhuhQkm?=
 =?us-ascii?Q?Qj6yLN7YK3724ZhcKZM5UhBzv24ErG0u4iSG8C5blm5IR2imrP26iC9gPIYi?=
 =?us-ascii?Q?5LAq/nhEMhWJo4LKVKBtAwOWi9uBkuqQi7dl+egke1mkmfV6aui7PgrCQX4N?=
 =?us-ascii?Q?hgys4X5bc7xO2tKbm2uHGQSaZoyEME4ejrBl1pyw4GBvKIKXhXXOVUZCR7WF?=
 =?us-ascii?Q?JTfCGh8fWh/EAAE1GKyUq2nVjVkrT5uwEnRGKpXo?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59978cba-884e-418f-296e-08dca62a6184
X-MS-Exchange-CrossTenant-AuthSource: SEYPR02MB8152.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 06:33:33.7437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1h5DKnri/Z1+tMtmEuVCc40n11g0JL774JWQ1JL1iObiTbPXADTbZ3hs2bRe6VK0vybjrfUWU/7fG2yE1jauPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR02MB7218

Currently we encountered a problem that the cpufreq boost latency
is about 10 milliseconds or worse when we boost through cpufreq QOS request
under high workload scenarios, while the boost latency mainly consumed by
schedule latency of policy->update work.

We should ensure the low schedule latency of cpu frequency limits work
to meet performance and power demands. so queue the policy->update work
to rt thread to reduce its schedule latency.

Signed-off-by: Gaowei Pu <pugaowei@oppo.com>
---
 drivers/cpufreq/cpufreq.c | 24 ++++++++++++++++++------
 include/linux/cpufreq.h   |  4 +++-
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index a45aac17c20f..e6e42a3ba9ab 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1193,7 +1193,7 @@ void refresh_frequency_limits(struct cpufreq_policy *policy)
 }
 EXPORT_SYMBOL(refresh_frequency_limits);
 
-static void handle_update(struct work_struct *work)
+static void handle_update(struct kthread_work *work)
 {
 	struct cpufreq_policy *policy =
 		container_of(work, struct cpufreq_policy, update);
@@ -1209,7 +1209,7 @@ static int cpufreq_notifier_min(struct notifier_block *nb, unsigned long freq,
 {
 	struct cpufreq_policy *policy = container_of(nb, struct cpufreq_policy, nb_min);
 
-	schedule_work(&policy->update);
+	kthread_queue_work(policy->worker, &policy->update);
 	return 0;
 }
 
@@ -1218,7 +1218,7 @@ static int cpufreq_notifier_max(struct notifier_block *nb, unsigned long freq,
 {
 	struct cpufreq_policy *policy = container_of(nb, struct cpufreq_policy, nb_max);
 
-	schedule_work(&policy->update);
+	kthread_queue_work(policy->worker, &policy->update);
 	return 0;
 }
 
@@ -1301,15 +1301,25 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 		goto err_min_qos_notifier;
 	}
 
+	policy->worker = kthread_create_worker_on_cpu(cpu, 0, "policy_worker%d", cpu);
+	if (IS_ERR(policy->worker)) {
+		dev_err(dev, "Failed to create policy_worker%d\n", cpu);
+		goto err_max_qos_notifier;
+	}
+
+	sched_set_fifo_low(policy->worker->task);
 	INIT_LIST_HEAD(&policy->policy_list);
 	init_rwsem(&policy->rwsem);
 	spin_lock_init(&policy->transition_lock);
 	init_waitqueue_head(&policy->transition_wait);
-	INIT_WORK(&policy->update, handle_update);
+	kthread_init_work(&policy->update, handle_update);
 
 	policy->cpu = cpu;
 	return policy;
 
+err_max_qos_notifier:
+	freq_qos_remove_notifier(&policy->constraints, FREQ_QOS_MAX,
+				 &policy->nb_max);
 err_min_qos_notifier:
 	freq_qos_remove_notifier(&policy->constraints, FREQ_QOS_MIN,
 				 &policy->nb_min);
@@ -1353,7 +1363,9 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 				 &policy->nb_min);
 
 	/* Cancel any pending policy->update work before freeing the policy. */
-	cancel_work_sync(&policy->update);
+	kthread_cancel_work_sync(&policy->update);
+	if (policy->worker)
+		kthread_destroy_worker(policy->worker);
 
 	if (policy->max_freq_req) {
 		/*
@@ -1802,7 +1814,7 @@ static unsigned int cpufreq_verify_current_freq(struct cpufreq_policy *policy, b
 
 		cpufreq_out_of_sync(policy, new_freq);
 		if (update)
-			schedule_work(&policy->update);
+			kthread_queue_work(policy->worker, &policy->update);
 	}
 
 	return new_freq;
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 20f7e98ee8af..73029daddfc5 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -20,6 +20,7 @@
 #include <linux/spinlock.h>
 #include <linux/sysfs.h>
 #include <linux/minmax.h>
+#include <linux/kthread.h>
 
 /*********************************************************************
  *                        CPUFREQ INTERFACE                          *
@@ -77,8 +78,9 @@ struct cpufreq_policy {
 	void			*governor_data;
 	char			last_governor[CPUFREQ_NAME_LEN]; /* last governor used */
 
-	struct work_struct	update; /* if update_policy() needs to be
+	struct kthread_work	update; /* if update_policy() needs to be
 					 * called, but you're in IRQ context */
+	struct kthread_worker *worker;
 
 	struct freq_constraints	constraints;
 	struct freq_qos_request	*min_freq_req;
-- 
2.17.1


