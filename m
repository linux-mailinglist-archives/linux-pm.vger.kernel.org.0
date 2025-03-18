Return-Path: <linux-pm+bounces-24227-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08674A66A3C
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 07:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23A3F189AA0D
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 06:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229F519B3EE;
	Tue, 18 Mar 2025 06:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="LTABCSSN"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2055.outbound.protection.outlook.com [40.107.215.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ECD28EB;
	Tue, 18 Mar 2025 06:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742278717; cv=fail; b=sUXI8E4TQzjBrS4EnDXGejBbZKoJ/hzCO1nNFFzCZahBxx/zOCJJZ+77acdxQk4WbRWaYiAn97KdFo8D/OsYcef/blhzfmbN7RJmBBHB8WSuWJAYOb1QqZYRzMqoSusAYL3R0uAMc1TjAioESTl2mu9LVB3azh1gyCmcgyrl/Vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742278717; c=relaxed/simple;
	bh=Mh68epzCKQkoJkvr0F8JbHrGjxTeieuYgZvyudZJrqc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=OrZRELavprESCDfQS7VwW1LlEmCD13jBjrZ8+/HXcCRY6RMkOkQg1Ze4Ah5U5e82mERNKs+2flHn64KnsYoGRMrwtgM0rk0kNzjW6FTVIID97kTntjLTytyNRuuJXQdOv9MFug8YYJGihLkqb/Lo66nbPnYek9ejGgpU8RTZ9Cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=LTABCSSN; arc=fail smtp.client-ip=40.107.215.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yi3Jojh2jMgRqz6QQ9mGUhldmupjZogzAFMwZTQlmJkKNLwArbKWNSR4H1zd1ihk6hSLcsApwIATjC0eVT1/rLLxm9fMjbil6MNCrHzaDOK7GKMKDI+ROfCRZn8JjtRlmtBQYXvPUrJWI8MzWy6WA2kBviWnJXOiEvuSE6S1ngCgYUDuh0wjykbsIkhEC43R6Znlav6HfLl4oReOQKPap6wPhDtm+b+Aks+5AK4n32vWoZDZjNtJiLVFSQ2X9c8EqoyZ3xLXs8qEw97J/5Go3dqhVkxOUsGHnuHu07rLVyVOT8CXIXUWy20a+ULbna8E1rkCUVY5gwdveCtp345sig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoQveE5qTKL3Vp30OS1b+qXmYqIYMxZyy8LUTCbzckU=;
 b=K9AEF6X2xbc0KemNyLHTnEHL/55W/1LUxE0GABmciPuEHGGqWs4f9XLbHkZ1rt3qYoL7lE1xQuTzLpsLwriGFxegqRecBLmmsrlV3hXrzoXHLhtjyilaxmMbLD2fETs90emO9ZEMlziNrGYiPc8kmxGPMFvJdRuxNzPWRzbvNFh2/iVnjW5uJs8NAt8ipTI+hl4E/LgZ/4TJ9qooGYndOrIS4M03/ewXfrg0hxcZ/PLm/JOFC0zH2WBcEIHDCARGbUsfxJQlsdjhnNsEd68QWV8nJNO9bL9SYr+v5ZnZ7MEMFxDks8XH/7fFtJUtg2uUD1kp7/Gm5m/7+nAJmhud9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yoQveE5qTKL3Vp30OS1b+qXmYqIYMxZyy8LUTCbzckU=;
 b=LTABCSSNMH7prUfyLib1EPYV+DME33uyE9hgz9cQJbUqYH4THMlpjnSTrhdYuqNHF1SHjZombhx1svjchEAkkCTwU6TncupI8V8kMkjlVgaTLEgjKOYGrPZrV2CNd/Kpb+wBiDjLEh3vgbyNp5zPySsOxMbsbmTG2YJcUjPRbrI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from PSAPR02MB4837.apcprd02.prod.outlook.com (2603:1096:301:68::7)
 by TY1PPFD77543932.apcprd02.prod.outlook.com (2603:1096:408::968) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 06:18:30 +0000
Received: from PSAPR02MB4837.apcprd02.prod.outlook.com
 ([fe80::7882:9dc8:208f:31d]) by PSAPR02MB4837.apcprd02.prod.outlook.com
 ([fe80::7882:9dc8:208f:31d%5]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 06:18:29 +0000
From: liuyuan1 <liuyuan1@oppo.com>
To: rafael@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenzhengding@oppo.com,
	liuyuan1 <liuyuan1@oppo.com>
Subject: [PATCH] PM / Wakeup / freezer: Check pm_wakeup_pending() before freeze_task()
Date: Tue, 18 Mar 2025 14:17:44 +0800
Message-Id: <1742278664-398536-1-git-send-email-liuyuan1@oppo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0085.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::7) To PSAPR02MB4837.apcprd02.prod.outlook.com
 (2603:1096:301:68::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR02MB4837:EE_|TY1PPFD77543932:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a5e6065-cd7c-4e24-0f3a-08dd65e4b35d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P/qjDFNiaVlADwgrWWHqtXzEZOzAN1SceRBODxNAVtGiwJYF9dvMvIyM9Cg8?=
 =?us-ascii?Q?P6W/D3b3CelWR8NvwMKjhHQcGxp2n/75ltzpkOM8V7OTEfqFirToMGRwSo99?=
 =?us-ascii?Q?UZEKDu/Hz0o3ndWUQmXaIMue9RTdr5uE4dMEClh2OJQAPHDKiI9aH3je1LCx?=
 =?us-ascii?Q?3IRT3Es8GkV0CXM9q/Ubt0gBtErfVyciMKPKB5oMr/nG4rT3IAB0BowqqqjI?=
 =?us-ascii?Q?ldV7JUU1xJU2m6s/iWme9nOqUG7DkmPlytNaH9u8kx10J2YEjtNBt8dPkpqM?=
 =?us-ascii?Q?7s4nJfoDOWdbKPDYAejIJ7zsdjWCjOi2b01YK47suYDPWbGPCsvcdywXDQ3v?=
 =?us-ascii?Q?v6PKM9oxzVEAEmbN/PaiuT60frvI4Do2i/J/xaVLU502YfQYCo3Drb3O0RMK?=
 =?us-ascii?Q?Bs1Fl90ri8qpYqvOFxDDqBa0MI16QNwqq+CJWkennM44fNKwgtLe3betXk0P?=
 =?us-ascii?Q?7aVEHyeeamjc5aGSNHsyxhY2bxiVTxSL/nS6OoFMs8NZ5DVRIZhW3g18fU+U?=
 =?us-ascii?Q?51kX+yG0WOQ49jeYxQ4+T0UVjWt37jI4rvj9denUhg9kNL9ffxjTGSZMLstg?=
 =?us-ascii?Q?kCYv3H4p7MaRcd4ni+E927Cu0byu5xwoshDG/3kcRyXR36jvZuc74VTtPOiF?=
 =?us-ascii?Q?z4+WWqVkJ5FXfaGk7RG52YpVnxA+ibuPvr6+LhYo91b0QLl7R4iGyuHVfqY1?=
 =?us-ascii?Q?gmhOtzIQ64VClWMlvQfoTnpQJ31TK/lxZoX+0eBkgIc2BQonk3/m+3On8okI?=
 =?us-ascii?Q?Z+SQ5OSDHNv5ECeEtZIsAd1I4AjCrgECGTXvFEV/FlRBF8WJkAJsNiRbMYfK?=
 =?us-ascii?Q?IqbZGlXmolP0epAbvHvm430oug0JaPgPplUwlf0trAcqy1aodVE/u1Gq+hBZ?=
 =?us-ascii?Q?tXL0cHXZ0j7l/olbK90S+YLJIdtT0fBfn5UNb2JDt60X1ATrs5W0ZrfutiSV?=
 =?us-ascii?Q?Zw5GhZ/xUSKFst0m/yGsdtZ4PtOe+T07zIduQpo/mlNG3e5BLaTa4iJf1h9J?=
 =?us-ascii?Q?R3M3MAAr5G6L+u3Xd5bA+8PTbn+uQ5gDyoBMix2n6GwQwKekC+uC4EjHroC4?=
 =?us-ascii?Q?8lYxEF7Z56yfHnAFtNcRYtdI8xepe9QO1e55hxiW5ItCUSVxzO3OPGzOZKOd?=
 =?us-ascii?Q?VhCaWEygYRHdmTzrK3F2IdVV60uWfSNF/haXZn/NbjelNw+vELW81aslkRwX?=
 =?us-ascii?Q?ObA8ANd5Ex9n4TWozGp89ybgKCltWJ3fQmyLJ23795x9mmNHaupRB5EuvIQH?=
 =?us-ascii?Q?oB72hRypyGxPot0VCYj3Q9EsSmizA+TI7gbfLspP0PmlEoK5RKOuXQiL5VQK?=
 =?us-ascii?Q?WNTKSiXeeGutC/UMu128MdT5UtPboKTBiTiz540BFkhwraapdqU+Hvffdmw6?=
 =?us-ascii?Q?6/7Bl8NBsXHKQp2w1jxh1UWwoXDa7FrSiP9gp9QPuSGhB6HAEHGc02FQmq4Q?=
 =?us-ascii?Q?61LAfvQr27lkqvx7gcLI31nMe6sTxckZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR02MB4837.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QroKKYX9iE5r949P55U0rrnVRIQac7Un3w2gvIOOPN8IUKCmCREeZQ+TQIfF?=
 =?us-ascii?Q?QXgeFxf+kW6ZXsXdh12jE2YVi7hHTLuKkLCTpCmYxOVkFgE8U1j+qCEMGyWW?=
 =?us-ascii?Q?ERXTHHi1MCqYEmOxSXj1ZDF79yrH7Q1e7jS5myefnVXYJ0+qVKShCkhlQ9xX?=
 =?us-ascii?Q?wfiPeO4u5sAaFoQErEuhyDBuMpTCV6CfeFLM5mMt823wEhXdiZ4IAjlhLn76?=
 =?us-ascii?Q?P6Wp9n/bCfuYplN2HMoSZhgs4ilEBDGkWhgiV3TlI7BDUpduEiSu02B9Q+vb?=
 =?us-ascii?Q?sX0AauWf4a6EZYh+sGSEfuQlDzG9mmWQXn6BtxcPTDKHU9VNgX7PL7X7EJ3E?=
 =?us-ascii?Q?fKWTHOTR2JkgiOE+QiEixh+NadbiwToJipu1cP/UQfBP1frLEHSON8jEGp3w?=
 =?us-ascii?Q?whsC1mN6xRowV7bjj8EVZcpIysjZeCc/iExPR6lwjRAahkGit8u9Icq1K/D/?=
 =?us-ascii?Q?JUXpi/7DowNlhpi+WiH8sg20Yt8abasZSh+qjL7vpmuONZNQImLXpZdJ5/Wq?=
 =?us-ascii?Q?uQ/S8I4xgbEX647P8mkB4ip2YY7Sk3/cA7rl34JOAbaBn1iy3nOJSh7ZztyK?=
 =?us-ascii?Q?38wC4tUdoqch2K3QCt0xyxErkDByJqR034X6OkN7PtRVjIIGWjyhudnV26XY?=
 =?us-ascii?Q?5KnNa/Qa3yKYpBNMDhhR/3qCW/klSpiPtZdAGEoiDWrTqMe3M4nG4Wo+jvEJ?=
 =?us-ascii?Q?kYkDsXbzhF5V5tG2q6xhQ2MuaCQ2cOoMeTkqtTKuudbNW9CNgnVglW0RisgH?=
 =?us-ascii?Q?dLlqG236BkrF9apwSWqwtLr44D3EnMA2T7paOD5lFtDvGb6ObB1Tb9cAPO8H?=
 =?us-ascii?Q?WFN9Tec1vHwOoZuxSQlvCr942UPaC4czD3CcdwI+C9kUEQHYc53PNlgikdeo?=
 =?us-ascii?Q?7jcz6EgLi0FQ8MFDJrZDSLabYQETB5RR3J3cpDb6eGx9yUOPFFszlceKU9TO?=
 =?us-ascii?Q?pEZZW710faPdumAEMmxMndPgu/f1iyPlMXwratVtew8v9al6N49xxYiXobff?=
 =?us-ascii?Q?XVCE6tJfQ6Fy5Nc62Ggo+zZm/DwIBcubR7AhY1EWhv+od71QJOFUA9rwqcxI?=
 =?us-ascii?Q?94tD/ckX2VYk1ny7f3PpgsWBw6sQ4iV9JlwPdSI3QYZGXYA5bEHjZlpf9I0n?=
 =?us-ascii?Q?GqNTT9imW30n+xTQHR1m5eVSaSBzwfDP/ep+OGa370Dd9SU6nUXf4n9Mc8XB?=
 =?us-ascii?Q?S7Lkj4cqHp57DrUW33wY1ax/vikXK9GzslhIJKyqzlPMhnkPl64FMXonoGhJ?=
 =?us-ascii?Q?i0TznKDsbO9oDLx5Cm3UNzLyMZyyJBAxv2NN59I0jfPd3nuDYTLl2Vt1h1r4?=
 =?us-ascii?Q?dgugnV1v22UYtc6fDdQje8A2ycnXZI2kGCMDF1DE81+aCP67O/xjcd1gzoL/?=
 =?us-ascii?Q?FBgzee7St1jinKeqtczj8J0NOUTwwWRde73q4taEjxt+x69YRtEC5iwePdoc?=
 =?us-ascii?Q?xINN/D7IfxRlCZMMdtVL6VDde1Ku8rMTIx+R95zydtVZagt27BfPBHkR3u+K?=
 =?us-ascii?Q?Uyc8niIb1oTC2Cv5d2W5O8O+F/Q3+twHkuqRZeK54Q06gOHteybiSKGsCjE3?=
 =?us-ascii?Q?dOs9OV+YQB9pLW9Swu/B1HfVlkNyJNMjThyrD05g?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a5e6065-cd7c-4e24-0f3a-08dd65e4b35d
X-MS-Exchange-CrossTenant-AuthSource: PSAPR02MB4837.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 06:18:29.9420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7T3NHS/tNjVopGh991NMLB63fsw9STKMB23w1XrZP1LSPY6lpIYqx9+jfS2GmxB6M+d3KfpQzjesED5aB2vkaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPFD77543932

Check pm_wakeup_pending() before freeze_task() can reduce
overhead by not freeze tasks in aborted case. freeze_task()
will cause high cpu loading especially when system has a large
number of tasks need to be freeze.

Signed-off-by: liuyuan1 <liuyuan1@oppo.com>
---
 kernel/power/process.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/power/process.c b/kernel/power/process.c
index 66ac067..84704b3 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -49,6 +49,12 @@ static int try_to_freeze_tasks(bool user_only)
 
 	while (true) {
 		todo = 0;
+		if (pm_wakeup_pending()) {
+			wakeup = true;
+			todo++;
+			break;
+		}
+
 		read_lock(&tasklist_lock);
 		for_each_process_thread(g, p) {
 			if (p == current || !freeze_task(p))
@@ -66,11 +72,6 @@ static int try_to_freeze_tasks(bool user_only)
 		if (!todo || time_after(jiffies, end_time))
 			break;
 
-		if (pm_wakeup_pending()) {
-			wakeup = true;
-			break;
-		}
-
 		/*
 		 * We need to retry, but first give the freezing tasks some
 		 * time to enter the refrigerator.  Start with an initial
-- 
2.7.4


