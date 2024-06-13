Return-Path: <linux-pm+bounces-9119-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1777E907B2A
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 20:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C0B21C23C83
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 18:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F9114BF92;
	Thu, 13 Jun 2024 18:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dz4WsEKa"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2054.outbound.protection.outlook.com [40.107.212.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B801304AB;
	Thu, 13 Jun 2024 18:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718302912; cv=fail; b=bWmtzDKI/Q+SRwlb4o6weU7hV0ONO3JNOa9SfDME115mfM8qqlQHetqF/oSQgJs2f4D+BdfvZGCKIWcWSBBXLpYCKHdF8k2wOkB+QaHx0TFSteqHE5L52DTQ4HCGGoQTRwpPMlyVfwLHOEDEyiGJvDFRfB7fDKogx3s23P56Jc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718302912; c=relaxed/simple;
	bh=INq/ADRZMx7ZFhG4kspI5hg2PitdwiFdBWVwzSPRswE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lnw2BfFRCF3gfE6dsGuxJAjRfkIZ5nC8E23jLUOJPlLFsDyDj4OtcqHuBCZW8VfFxO+iFgNS/+SYhqY03ysIkAlfHu1QQ6CF0nanwK/3NXiy70HIHHCgN5wZMSbI58pScCtHdgAenpzqJ4wnC6n3k5ZZDR3gTT2vGEqXl5GDeTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dz4WsEKa; arc=fail smtp.client-ip=40.107.212.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYdq56m4Zq9OWc8v88n//s3mJhovzM+bmuM9e8ZxO8dFnncrJxWL2DCxoFIRY14JRghbT60PiHqN74DB7/8nhXZp7LiaaEwZXVHbNmq5eI/Fvorpn72vX4fjQMn2+i4KZOCI4S+xv0plLcGaJ8Bbkmot5c+92ukS4EXNvhK8qUFKVPrfwlfNGlzuH+HYHmltQUKklzXExL+ax/vJHuuUnHAc1EGW7wOvYSCVqthcJCXZe4YTEFOgGavxQmMEacSXQXRv+gDQ684oWY2Kft9usCHV7VrkGAoUDWbhZng8i3URMJ58Bpw3f3+xL5D8LqH2Dx79w5svYrCZkr6j4Khl8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/YTwJcAfMt2dMGRNjEcsxe6Vp0c+dVhfzKbaE+0tLg=;
 b=V1GpwX9DlqcdN5RvTzH0CQ3MJPZvbsfo4Fr9I2u8TGDuQ1bnvEScqjselADrb7X8yi8WGQWpjYP34Eo5J2VEJKkcvI/ZjhFEpoQRhvTU8rDa0caMI+K8atwLDgkEcsmSOvYdyNhmbwol6/zGyeeniJ1bVSj9LKR8t46a21zJB24Pww93cE9cH5NMRvKR+XBM9TXUViNo7bqzunXGLaeE1u942W6SXvdH5I+f2ds/a4tovhErAagSeR2/IyUfZGPpxAlqjDComSBMZJ7DAKRXJZxZ/tW83mvlgOSqN0ijvGuRcM+nRwldR6RJLYOLsRbcoQwrc6+5ucoYl7MFbiPyTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/YTwJcAfMt2dMGRNjEcsxe6Vp0c+dVhfzKbaE+0tLg=;
 b=dz4WsEKakVo2xQZ5YLezKbu75GOmr4Et+H2oT8s5CS/Pbd1y97fXCa4xtmCsUre51/l5Xs2dYz7mnSVm0MQA8NDnjqsEQzWvN2NX3s9MJKQuNwjHVgMH5tj9BXMtSWL2mGHgN4oLoJS6Clp7sa6qIVXlv4d85cidAjmzyMa8bU8=
Received: from BL0PR03CA0033.namprd03.prod.outlook.com (2603:10b6:208:2d::46)
 by DS7PR12MB8370.namprd12.prod.outlook.com (2603:10b6:8:eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Thu, 13 Jun
 2024 18:21:47 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:2d:cafe::f2) by BL0PR03CA0033.outlook.office365.com
 (2603:10b6:208:2d::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25 via Frontend
 Transport; Thu, 13 Jun 2024 18:21:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 18:21:47 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Jun
 2024 13:21:40 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: "Gautham R. Shenoy" <gautham.shenoy@amd.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Guo Ren <guoren@kernel.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, "Valentin
 Schneider" <vschneid@redhat.com>, <linux-csky@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
Subject: [PATCH v2 11/14] csky/thread_info: Introduce TIF_NOTIFY_IPI flag
Date: Thu, 13 Jun 2024 18:16:10 +0000
Message-ID: <20240613181613.4329-12-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|DS7PR12MB8370:EE_
X-MS-Office365-Filtering-Correlation-Id: 60141e5f-76bb-47c6-25c5-08dc8bd5b00f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|376009|7416009|1800799019|36860700008|82310400021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bVFI124eI4nCFp20hPd7YGMl2hHVtCkWXsECoVI656WmLPAFrU11n9uInoNP?=
 =?us-ascii?Q?uhuPWBYgbKa2NNYj5X08rG7xtvGb45xpdCTNoUXuoMq/hT70hycJkWtpe212?=
 =?us-ascii?Q?kexSnB/Q9Pa+F+p0DDXfahRY6QZASghucD5uNFbiTDyOBFWOyFx1oii/UN5I?=
 =?us-ascii?Q?9pHPbfsNGvMrMbJN6B9+5IQLSDACmxiCKGlN4h5pGU77Uc1o639dXIxi0L1h?=
 =?us-ascii?Q?26SQWB5nhxmGmWewXW0qH8Iods2qxm/48XlccdoKaw5yg9Cu/V9f2ZHRl267?=
 =?us-ascii?Q?yYxtIKGdRkoM9K/6QDO3k/cJioRPCMXAYHVMBfcixTe680adv4CmxHjVtH7m?=
 =?us-ascii?Q?R/qC9cD9TCznPQ3p7Sk101Gcwj8XMAhEJ8GuGaeeraowYTPhHt/0egQ3JOJG?=
 =?us-ascii?Q?FsCsQlKJyW+gFennUdnXJsacqNHIxHB3WmmFTfVyhqZTJabfXDJB9uGoxG0P?=
 =?us-ascii?Q?7Q8P4mJGaTZesSqpAgQRPFClSweOIWA5TiafmiWxQAC0ORW6pfAxESBXkanX?=
 =?us-ascii?Q?/AYPaEF63xlxts2oqhehZ2nnNiMA7g55rhO4eezjxKcYXEBFThST85KcR6Jw?=
 =?us-ascii?Q?lqy/eOaanwxyAE79CG+1S5lb5+O+H3YjXYACUXeib3s/jQUxAZ4w2pXb6Qq/?=
 =?us-ascii?Q?+kshV3BGpqvqlCydjyUWhtIb4/UCqcQSseutRP0zfNWfi6ahiX/+vKaWlLyY?=
 =?us-ascii?Q?F1SkgdC6cFRVopI2bDUkwGgurHWAddcepZNeqt/Npe7nr9qNsORjeZmxE67T?=
 =?us-ascii?Q?8Rkp2TUNOA44tTOwDnI3KwYtNni3ykMc1HNKi/BT3HywX6tkpNEg6lmLGDl9?=
 =?us-ascii?Q?J14+7wSaEey1WpZ/wi4bCm2uWYen6ou883fPeuHLdul2k/kQMilCF28PuVcg?=
 =?us-ascii?Q?Sop/06KxIjWLWhYAqxx87Y5EcU2MWz/o8wvI4o90I4bXI698L/5cGu+vz6QZ?=
 =?us-ascii?Q?YxmDvXiOZJZ6vSpfCKvv1vZR29NrvCUHiG56TqfGCsKcvFkYkRHjFDPdQsTe?=
 =?us-ascii?Q?JCtPz5LZesj1v2Te8W6eF61j1cFN8VitadiHjs+Tk3AH06oOIzjygJ3rjnjS?=
 =?us-ascii?Q?j1zzJ5qeBDQHK2EpHmOvq0XlCfQHnoazXDcVUqCG3NmfPFv+LESt3PbuGuUU?=
 =?us-ascii?Q?RmHWLx4y3zS1Eedmr2WZrh3KMeksfm4HoreNtdwHJuSAqpi5fbA7BxBV8EDK?=
 =?us-ascii?Q?JXqZsvNVGGJPIWddP2wQgYJKRwOFs6mmTG0mz3hJFq1QbO8+tRfz8UXAc2WF?=
 =?us-ascii?Q?N2XV0pLzRn+YgzHGJAm+/7mExeq7jzY1TsO2C8fu52AsAk3vrFphHS7usjCc?=
 =?us-ascii?Q?IuGCxeW8fUOpCuaRjRsJS7ZYw23jZHlgRcaKicxHR6Hvkn6Xsjd0Wo+xAXV0?=
 =?us-ascii?Q?fIBHYK/T8D/lhYp/vy0Rcm5nnyAUBpp+WfY6dkzSfzRjBcob5Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230035)(376009)(7416009)(1800799019)(36860700008)(82310400021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 18:21:47.6126
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60141e5f-76bb-47c6-25c5-08dc8bd5b00f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8370

Add support for TIF_NOTIFY_IPI on C-SKY. With TIF_NOTIFY_IPI, a sender
sending an IPI to an idle CPU in TIF_POLLING mode will set the
TIF_NOTIFY_IPI flag in the target's idle tasks's thread_info to pull the
CPU out of idle, as opposed to setting TIF_NEED_RESCHED previously. This
avoids spurious calls to schedule_idle() in cases where an IPI does not
necessarily wake up a task on the idle CPU.

Cc: Guo Ren <guoren@kernel.org>
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
Cc: linux-csky@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Acked-by: Guo Ren <guoren@kernel.org>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
v1..v2:
o Collected the ack. Thank you :)
---
 arch/csky/include/asm/thread_info.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/csky/include/asm/thread_info.h b/arch/csky/include/asm/thread_info.h
index b5ed788f0c68..9bc7a037c476 100644
--- a/arch/csky/include/asm/thread_info.h
+++ b/arch/csky/include/asm/thread_info.h
@@ -61,6 +61,7 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_SYSCALL_TRACEPOINT	5       /* syscall tracepoint instrumentation */
 #define TIF_SYSCALL_AUDIT	6	/* syscall auditing */
 #define TIF_NOTIFY_SIGNAL	7	/* signal notifications exist */
+#define TIF_NOTIFY_IPI		8	/* Pending IPI on TIF_POLLLING idle CPU */
 #define TIF_POLLING_NRFLAG	16	/* poll_idle() is TIF_NEED_RESCHED */
 #define TIF_MEMDIE		18      /* is terminating due to OOM killer */
 #define TIF_RESTORE_SIGMASK	20	/* restore signal mask in do_signal() */
@@ -73,6 +74,7 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
 #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
+#define _TIF_NOTIFY_IPI		(1 << TIF_NOTIFY_IPI)
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 #define _TIF_MEMDIE		(1 << TIF_MEMDIE)
-- 
2.34.1


