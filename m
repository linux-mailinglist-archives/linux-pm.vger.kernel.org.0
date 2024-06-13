Return-Path: <linux-pm+bounces-9121-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42120907B32
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 20:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94254B224BC
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 18:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F134B14AD36;
	Thu, 13 Jun 2024 18:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pUmc6Qwv"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656A014AD19;
	Thu, 13 Jun 2024 18:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718302956; cv=fail; b=n5j3x7jpknxMPugdRR3kP6+4+00IXjfB63XBDMtEEOSEjR6ounxaG8Hl9q3HwEdMJanoAmItVjyocRAUtPfzGJE8HKFuTVpJprsNdAzD30NtjYPNW7HewQeG+Y50w2UBBEpZbm9wt23djdYOyNXNiUOjej4BMVdhi40EWWHGQQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718302956; c=relaxed/simple;
	bh=XXWdspiKC/0UlHHLqD7udf95/J0hP8yCGKcEGv6lnwE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rgcUDGS4wYL67jfxyjG8zcXvp5lQIqqjk52tZ1+IlCwoYWOXL0nzV1UpovpF+F3/Nt3vOKvPP4LJ6n4fHvRk7CBVEaYq1uMbdSQnEaYP/8pkUvdX0WhDhNSfkOYf/N6Z3ulkAkgLizXYAeqSx0u/jR0p4jswrWUOYJuDp0yZB20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pUmc6Qwv; arc=fail smtp.client-ip=40.107.94.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mb+COovBOKqxrRm12kbdi7e19XhOlwEswjjUf9I0KVQXx00QhDPt7svCt73F3gF4JgIzBt8BG8CupYPx0n+Ljg2qvHTQbSVbDGotoWI9g8a6mcLyWfg5vIxnIvoTrkwkiKUH1SDjSp1jFM4bANA6MsOZOy1AtHsMQsPEyguBS9WtD2jgq5lfRCpvMBMo2h6k254ZHEGVSF3EM0doaH1Rzs6a1jAXMsTN88Z+tVwxqI5rnDPwX0tC2tF2rnQjr85ht2PqDwi/xza0lNz5yVwSu8r+S3TFqtSNhPzWyeKaDl4bn5Sp+gxNR0Fr7fPW8Q9z5GkWgHRxPhIJTRDqeoKQbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqRo+oqUsFAbzVJ+rqjyOKw0pKvf3GHUxqpByx6Fh0g=;
 b=f4hicJqkIH9EgiaxOZD64cIACZT9tiDOCpqd9TikfxM3oLe1tn6RaMukmkk1h53AS7ZjXn0bOBkROiQGd2HDzu1zDkuBhiL+UzvNP/mp2cNS4mf7a6lrq5MH7Ar2MhncwkHhHD/ya8dSYSzIDG3/kR44Rp7umfw40Iu0497KraZSPefBbgBIyVmpYPexoKzav1W2wZ6hrwffoVQuRgam8v2ytULbUzo5viM5DC7T5OaBVeV9EQdOMKn9K5MY4vP24lWK1T19Yrb749Ts5fqgn/Qqvkr1mFK1KaqHSsITW0Sf/DUyUX1Ht9EKVjdwM/J6wcZD4zUf19sveT2lVNHykw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqRo+oqUsFAbzVJ+rqjyOKw0pKvf3GHUxqpByx6Fh0g=;
 b=pUmc6QwvVg6bRL2vaHmjLpZxwZVNGBCzfsCujunkFUKMppY6L5ENoDP2RrjZgqOLaMvkIvVDx8vHoqYVmuy6LXbYj+ueYhgYmFPOYW7SOlugG7Chohjx0pCYpPyvcCDupMOmYzhPRt9yJhnP/99BpTTMxPFFGPPmoRDB0G87NSk=
Received: from CH2PR02CA0023.namprd02.prod.outlook.com (2603:10b6:610:4e::33)
 by DS0PR12MB7582.namprd12.prod.outlook.com (2603:10b6:8:13c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21; Thu, 13 Jun
 2024 18:22:33 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::3c) by CH2PR02CA0023.outlook.office365.com
 (2603:10b6:610:4e::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24 via Frontend
 Transport; Thu, 13 Jun 2024 18:22:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 18:22:33 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Jun
 2024 13:22:25 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: "Gautham R. Shenoy" <gautham.shenoy@amd.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Dinh Nguyen <dinguyen@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Juri
 Lelli" <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, "Valentin
 Schneider" <vschneid@redhat.com>, <linux-pm@vger.kernel.org>
Subject: [PATCH v2 13/14] nios2/thread_info: Introduce TIF_NOTIFY_IPI flag
Date: Thu, 13 Jun 2024 18:16:12 +0000
Message-ID: <20240613181613.4329-14-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240613181613.4329-1-kprateek.nayak@amd.com>
References: <20240613181613.4329-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|DS0PR12MB7582:EE_
X-MS-Office365-Filtering-Correlation-Id: 295db9ce-fe45-4cc8-8629-08dc8bd5cb2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|376009|7416009|1800799019|36860700008|82310400021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7tlOd3jfqjL9pTJtCy4YKNHQZyiuh61Z/ahz1SGJ3Xh3A5Hga5o77PSIh4a/?=
 =?us-ascii?Q?T5ilil04bA6PpXjtO7usxbsbYRCmRvUZ/3W1EnFGoYpaRsX5pNzwxUjB3Uqx?=
 =?us-ascii?Q?yWWaTujaIq2MusIN+xXnN4pkpsDrQD3MzYMjSL7gfcQ1vKxBL8KF+BLdaujN?=
 =?us-ascii?Q?EgiWUGB0hvatlzoEkC7agIk5lNfispu7sCGeES+okZoP6uoR+9Iw1gFowgmE?=
 =?us-ascii?Q?yRlqMVxpySsukMun3V3Vz2iqO1ZlwP2GMmid9PE8gdO9Z74kYGy2+bW1AoVg?=
 =?us-ascii?Q?Y7qrdzwV7w17zpANYYCuqQqEcrCFYDz97J8FhJe5b9YqXaVrpo73NWF2O1Me?=
 =?us-ascii?Q?M2fTo9XtOs+W1T7TZdZKr3HT19RlY1T1IM2NWZSn4xpu6QOXnRkDoVgnBvYY?=
 =?us-ascii?Q?6aYXKsDVPIb9YkYJBgVqUh2nW2oMAcDBz5QhfIrKhRkHKKBE1clJppdM6xgB?=
 =?us-ascii?Q?cKIcQlYFjMpZJpD7DNDlLmJWuwW+MueqxWSgvQ445Fw15AkM4wnS60yVQnoJ?=
 =?us-ascii?Q?lYbsjmu8FqERDg1gI6o1WdVX0FpKibrC5RLYN+WV4DY3l+hyC1cybFAAyzWl?=
 =?us-ascii?Q?MnluIN67TGWyi4LEfWsSVPgw0i43ytqdGtUrboWFDCLbQjRSkjnkeMup345r?=
 =?us-ascii?Q?y7gwlCCLxVJPq9VbzljzFx1OouVKICDgNGbWZeOtfbMNK3k7p5+wLbp8Hl8Q?=
 =?us-ascii?Q?vBz8/yOw4jgNd8lwakQMV8wfo5O+u+7TsprV362puBc532MltzgZ1D7ODiay?=
 =?us-ascii?Q?OwjKhqFoMR00Loow+aLJaPZIC+x0U5eeWq/Sc3XhCvLfIOEf19x5FvPad/TU?=
 =?us-ascii?Q?b9WOnuEvow3ixG2Xtmoxt3gPGBme1/guYTIR9Sp3gHk7MSbCHDLF5oI9AJQo?=
 =?us-ascii?Q?XWunw1Vj5p223447if1dTBgG54Xd8hcVosVC7tYobQucppBMIeXGI5trjMRN?=
 =?us-ascii?Q?T9Mny7AqtG9MYFfQgePASWwYUSViHv4tba5DjPS5Wff88S821sMvYXqAoOrQ?=
 =?us-ascii?Q?nqJmlnBges2bGKqBf1XWBRw7wcoPxPU9jGfouNvHoz1E4MeyhEYFPklL45W5?=
 =?us-ascii?Q?5thXLQNyuj8Mh4oyfHQDlt+oUjAphbWtS4Ew93GzrAWL12e+AkFXzgB5KDru?=
 =?us-ascii?Q?xNKDHLTTAfJj50AMeNZn1Dhi0M4hCLFzrGsDHpo74v7Mk5GnXYC3YZfYrYcc?=
 =?us-ascii?Q?Vp7ZTUPuDgFYzeBjgChKxarrqrUiDohVknDBUoiWisB4IJBnAILmMwcDKLyK?=
 =?us-ascii?Q?Pfrw3UR5YUcynUVmYdeqloEhM5OwSCm5+X73hjGwJGJorLDDHan11/lCRpaA?=
 =?us-ascii?Q?X9DdOZ2AhuipUawYu7npHCb+Oo1x5IjO0Gb5tl4vQHO9756g4ECl7q4svVgi?=
 =?us-ascii?Q?artpzklE9a5K8EdrZse4laCCn+m3/WBGFRwJX32DkrISyeIc9g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230035)(376009)(7416009)(1800799019)(36860700008)(82310400021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 18:22:33.0230
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 295db9ce-fe45-4cc8-8629-08dc8bd5cb2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7582

Add support for TIF_NOTIFY_IPI on Nios II. With TIF_NOTIFY_IPI, a sender
sending an IPI to an idle CPU in TIF_POLLING mode will set the
TIF_NOTIFY_IPI flag in the target's idle tasks's thread_info to pull the
CPU out of idle, as opposed to setting TIF_NEED_RESCHED previously. This
avoids spurious calls to schedule_idle() in cases where an IPI does not
necessarily wake up a task on the idle CPU.

Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
v1..v2:
o No changes.
---
 arch/nios2/include/asm/thread_info.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/nios2/include/asm/thread_info.h b/arch/nios2/include/asm/thread_info.h
index 5abac9893b32..24882fd5ad11 100644
--- a/arch/nios2/include/asm/thread_info.h
+++ b/arch/nios2/include/asm/thread_info.h
@@ -79,6 +79,7 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_SYSCALL_AUDIT	6	/* syscall auditing active */
 #define TIF_NOTIFY_SIGNAL	7	/* signal notifications exist */
 #define TIF_RESTORE_SIGMASK	9	/* restore signal mask in do_signal() */
+#define TIF_NOTIFY_IPI		10	/* Pending IPI on TIF_POLLLING idle CPU */
 
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling
 					   TIF_NEED_RESCHED */
@@ -91,6 +92,7 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
 #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
 #define _TIF_RESTORE_SIGMASK	(1 << TIF_RESTORE_SIGMASK)
+#define _TIF_NOTIFY_IPI		(1 << TIF_NOTIFY_IPI)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 
 /* work to do on interrupt/exception return */
-- 
2.34.1


