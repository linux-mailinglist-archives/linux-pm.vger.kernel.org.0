Return-Path: <linux-pm+bounces-9120-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DB4907B2E
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 20:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEC851F23B2F
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 18:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AF014B06A;
	Thu, 13 Jun 2024 18:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4wci7Sol"
X-Original-To: linux-pm@vger.kernel.org
Received: from outbound.mail.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD851144D0C;
	Thu, 13 Jun 2024 18:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718302940; cv=fail; b=uiPPlu3imgZynGfJouCARkDC4K+yLL/I1DONKoHnxetzN76pruFh7ISRY0mg60Th0/DvwKjo7+41Yhk0r/90vITi3I3/R7gDSkyydS/mgyfosvJsm1XIYCnweKJ00J7OFPjwiPU8pO40c0rpULtlPzoJdCNjrYHSqXf+pH9nBzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718302940; c=relaxed/simple;
	bh=fQIllobKnQj4N1TQcML1X/+0mkfNnGh92sGbcw/mz1g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rvQdMNuYnp/89r8XSBKSuIcPISEmTlAWNKIuzV5IWasmh/8fdem+UeH6KZtSCNRMVACwblSSgctTpbn38OtkHFrr3fjknkthU6x/b3+nWPOoSktdKM8nIjw0+7MKwo4mrYeep0ijHMFjDZrgv/kB0ypzvJ8Bwd/HQNYInklUpYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4wci7Sol; arc=fail smtp.client-ip=40.107.93.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0BJdGADgnYEz8LzM05F1eyJGT1MEHucXevu8kFdp+ynE08HJhMM9XzskioC49ZeoseL+e6Z6/pv6BMfjk9Cgh69RaN1xDjd+SLqX51xbjqP6AOtZpLLskoNA3O/pol0nBcViGUfhI1CYF6qw2X4tI3OL3UBz16/bDPpKyGJhA4vYUg6nesDDHs9LhVPFxyyoFGL5c+7ocFhGg9NVSAdunsqBC9qrmSSkmRofc3+npBIILyzAWuaRkMNfOrkWylTpMrM66LkmBzXteaTIRYIWW6iEgE8lNWk51CL0FnaCTC1XvFpb2z/s7VqmTaSqeG37JlQxFMJQ2nPzGbHnjLu1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMSZcPJusC+1ZmpvinkMeGGnKivkW5zqNmssukThVJY=;
 b=FXfqBDU1119jwNOP81268Dm/R0q4DXWHx1QfDbOh9VJkK43hcPVVviEqhqXx3lwmX/dN3+BtLu8lENaRYXx9PsHZ+qc9e2v/N2imnwsIUd2LYWhdI6cxG8y69LYH2y08E8cTTBWt9J9FPST91D7nRGxnd5QRCFnzMUonA32S/numEBaAHo6zG2+iB4mK3G9CJhmdR63n5z2l4UvJ862VBXS9iR5talbXVeBwNUs4wuxem8Q1KnpharVsDY121gDwruSc2Hs+6zXDqAmRpA59qoKnohPsOtJ/Zn3P5bSf3hWCO1zUVG1ZiGXUFmbciuQAFgyXJ4daqVkwdXwb3ImRhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMSZcPJusC+1ZmpvinkMeGGnKivkW5zqNmssukThVJY=;
 b=4wci7Sol2F5/Et5YZOexRzXRZ+W3KrSa/zKB3EPIcvPF7i4uE5qVn30PQnwTdzWqt8zHP87dBH/3qN3F5Zeaw4sFddqLRgDiM+yta86DSM0TxRFpuvBBzB55Py+DzrpoBNbvqf4+DbA4SbObU5f5wrOAtxaql1SEsiYcQBGX51w=
Received: from CH2PR02CA0022.namprd02.prod.outlook.com (2603:10b6:610:4e::32)
 by MN2PR12MB4080.namprd12.prod.outlook.com (2603:10b6:208:1d9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Thu, 13 Jun
 2024 18:22:12 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::1d) by CH2PR02CA0022.outlook.office365.com
 (2603:10b6:610:4e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24 via Frontend
 Transport; Thu, 13 Jun 2024 18:22:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 18:22:11 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Jun
 2024 13:22:02 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: "Gautham R. Shenoy" <gautham.shenoy@amd.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, "James E.J. Bottomley"
	<James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, "Mel
 Gorman" <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>, <linux-parisc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
Subject: [PATCH v2 12/14] parisc/thread_info: Introduce TIF_NOTIFY_IPI flag
Date: Thu, 13 Jun 2024 18:16:11 +0000
Message-ID: <20240613181613.4329-13-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|MN2PR12MB4080:EE_
X-MS-Office365-Filtering-Correlation-Id: 3180faa6-2a7d-48eb-eda0-08dc8bd5be32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|376009|7416009|1800799019|36860700008|82310400021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KwBfury/PvMptdd8knaSeTtWAEtsiMjLmzl2M0MB9UVxT+JkxY6nnm7XGrEJ?=
 =?us-ascii?Q?xUe0hPZCNXabY8V2IoqFhkt2qJ1Y7GtyPG9jQBGY00CerhhnR3Y4By3dlTyr?=
 =?us-ascii?Q?YIefbpoWh6DCzVuP0LtAENO5+HGmErZw/LJDCBl9JtJoxbg8LsNa5CRHt0Xx?=
 =?us-ascii?Q?UdaB8yPc/qIwD8dPYUoUtUT5aQSzgm3UWojWQW1i6lKewB+d/PPmVi3LzlCA?=
 =?us-ascii?Q?NvjeirMBPtfovq2g4OOAfkeVNe2YBGun2wNzunmu7bqA3U/tJVJHzSUsH6HH?=
 =?us-ascii?Q?bV6qgygh78lj1WIv8ksPBxjAZOvbpHUWVAcgXzqGSjD+KyeYvRKC+oHDDHPt?=
 =?us-ascii?Q?mn2CMbmHZ0ZKGfH2T4XUukH8ff0DJwa+ncs5dLTe3yARClr8YEVP8UtC46EK?=
 =?us-ascii?Q?guld+fd3mULXJkuYWJL3BdwsS41yeh2F3/kNjM/brHgFhkURtf6m3G7bPN/W?=
 =?us-ascii?Q?jnp6tAtkWGrifPREsWUg8mx/6xVFl17bYAHkfeLw2pedVe65r1jEgeDRvUXh?=
 =?us-ascii?Q?i49/DHCz2iN9GGUDU508a+GAv024PgpSKQ1XPAa9rIqmba1o6HWpn5BVcMPF?=
 =?us-ascii?Q?+xhOKHJPH11bbtETlzF9PjMGP8jiH8cz54CrqlWJw1FoNz1l6uy9qH4DIVSs?=
 =?us-ascii?Q?Sjt6Rf51DiZuCw3RiE7+nmjPKPqhBm/8hWrV0BwTHAYnIuWFERX3dEVc6u3M?=
 =?us-ascii?Q?JKLXpdyoe+z2qgdb0MBfy52NFO4ruSW1YcVA2HCSq0c7q5LQH5rpcNODLctC?=
 =?us-ascii?Q?9zQ//vAdTIqa2iwYab028Ci+BorXNBSUH/TFo7IZShClGPmP6uSzZqs5akDn?=
 =?us-ascii?Q?o3V8FU6wyYwLlwpaOS/eXj1X8xPj0B3DKf7T5TbzxLN1bx5yV4XjF7Zmsv30?=
 =?us-ascii?Q?S3XnpYmjoR0EuAC+OSOEPgM9Ip5SQZd6fvT+xfOD2mszO0w8Vt3Zl7PRrGlA?=
 =?us-ascii?Q?aEgmvmCTmzRiprDXs8E0xD4FXDDZyHgUD/4HkJSwn890eAcd6RnnlFm8pYDV?=
 =?us-ascii?Q?Orl6ZO/qEfX83ZSLZDH7k6PAtalSYtXsUYsLhoxtnhm6l8vKpgQqkRr4Znrr?=
 =?us-ascii?Q?ZVFhGVNK103g352mH1IBYuyjnt/Qk+RAQCLGtFkOfyLLBLOQ+wBFf7N2uE2z?=
 =?us-ascii?Q?ktxDH3cu6FqtWnr6uMBNsb64hEubYG+17AfY6ktVKkROWmW7B1NGZDKcaqZ1?=
 =?us-ascii?Q?3qWsdkxPAeiJb/1WgVGMD+gii2HwUKD7Bts31SvaIAg5Trq4GKuI2NgYSK52?=
 =?us-ascii?Q?ncTB6MEVE5LlNKkwlu4GfcVROoBIaOvIxnkjkqjL+uDxK1m9OFy8zgakMszx?=
 =?us-ascii?Q?gX+upkf0VPC0xLgxGeBYw81lsm9yfcgkNYPW3I2zdX94je9VGcJy4t86+9GQ?=
 =?us-ascii?Q?csxZlcKa/dxyAqL4zkwIJmsd9a148RkHjzJNjYcob2PHGkeadA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230035)(376009)(7416009)(1800799019)(36860700008)(82310400021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 18:22:11.1321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3180faa6-2a7d-48eb-eda0-08dc8bd5be32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4080

Add support for TIF_NOTIFY_IPI on PA-RISC. With TIF_NOTIFY_IPI, a sender
sending an IPI to an idle CPU in TIF_POLLING mode will set the
TIF_NOTIFY_IPI flag in the target's idle tasks's thread_info to pull the
CPU out of idle, as opposed to setting TIF_NEED_RESCHED previously. This
avoids spurious calls to schedule_idle() in cases where an IPI does not
necessarily wake up a task on the idle CPU.

Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
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
Cc: linux-parisc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
v1..v2:
o No changes.
---
 arch/parisc/include/asm/thread_info.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/parisc/include/asm/thread_info.h b/arch/parisc/include/asm/thread_info.h
index 1a58795f785c..35f1deeb8f36 100644
--- a/arch/parisc/include/asm/thread_info.h
+++ b/arch/parisc/include/asm/thread_info.h
@@ -52,6 +52,7 @@ struct thread_info {
 #define TIF_SECCOMP		11	/* secure computing */
 #define TIF_SYSCALL_TRACEPOINT	12	/* syscall tracepoint instrumentation */
 #define TIF_NONBLOCK_WARNING	13	/* warned about wrong O_NONBLOCK usage */
+#define TIF_NOTIFY_IPI		14	/* Pending IPI on TIF_POLLLING idle CPU */
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
@@ -65,6 +66,7 @@ struct thread_info {
 #define _TIF_BLOCKSTEP		(1 << TIF_BLOCKSTEP)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 #define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
+#define _TIF_NOTIFY_IPI		(1 << TIF_NOTIFY_IPI)
 
 #define _TIF_USER_WORK_MASK     (_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | \
                                  _TIF_NEED_RESCHED | _TIF_NOTIFY_SIGNAL)
-- 
2.34.1


