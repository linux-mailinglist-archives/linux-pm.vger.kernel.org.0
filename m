Return-Path: <linux-pm+bounces-9114-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E53AE907B0F
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 20:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52052B20C15
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 18:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4609714A623;
	Thu, 13 Jun 2024 18:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w32DuMEQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FF31304AB;
	Thu, 13 Jun 2024 18:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718302800; cv=fail; b=ZYrS31Ljdycnv2fCGyi70wt+kJLGd+dgeF51q6+WEFocNaGfX+9IZvFmIzKO5+LxR48ECAxjlFCRgQRg70zN6JTJte1MmTEQriaUQPdns3e7F+KhPXrIW71jyHsTHS5JyN9TqGdp5R0+OUMsKT7x1tWMhgfl7JQBg9e8rTemiVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718302800; c=relaxed/simple;
	bh=eWXUvT6vKe4xd0Za0lJZERTKDaQICxuWyE147cyZAxM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u5knTWqHhV5WjvsaPPuZR7ktz/VwbITClsrjlXuHfdByuFN90SjjyAEiUk5jeXy5uiMz+Y+WbyDWcozIpIj1WRJdRae2rOiE1jR9FqPpFKBEwEXYeD03KIxZFpzqHJSe+0MPMpvCsogr8zAAMinAs9BhzIDjasJmldAlVYuqbkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w32DuMEQ; arc=fail smtp.client-ip=40.107.236.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyTJQNQQMoGz+Nqmi58OEvVVAHyML6wHWhWhbopx/KkWFjzCA8PUFCt+MDJg5gQ8Rc2GJ8fFlXtRhpRII4ln3VvINLOF+SBAicqc738xRME4uehEVnaQVrt/FYvfAJZQaTu6IljvWgYEy+XynQaO5ulknp9aNpQmXhb3JFlhQDPFeufiLFJFkU7tnb6Kp77C3HAdTQtP9bkzT4JIzV5f7d1zsPx0WeDH+p4J85lwHBvPTKLzH++b2T1E57ZzLbA/ydE6C+6y8DKDqr7zTUo2YemfgTNGn5+2f/2cvQRu8Xjsz7KA2TnIWrzcCPUywf+WEFrlLn0H63WkyF+Kw9aT+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9I9g5gYsnlhoA/IM+nU/HeTT4PLqMTpaOL8h1gEe90=;
 b=KHpbLjGZXvzXHdSir0g8PrHGIGISZ+JE2iIMIlpA2l+MyMyOzkWerK9SCvqA6sFrMdcTVUGysXZmqUOmrJFppPuPDqpWfpI+L/Cc4ku187tuEw1IkdKOVw3hRGaDPiMlvzxxZ20oQ4XFpxXoDE3CGUBriiQvb3Bd+amA7s10lT3Mr6HpnW2ZodZy2giQeS6nmcdMTZSDE0blnZu6GtYuqmgYtGi4DcY2iAuODanrqMjDgjETovytqSg1HvdHv1DzFMMCr6X4OkTMIEKQR4dVzuuQU4SgCV5zfmyqk86tbAauINZwbokPPvPpIUMcdKMdIDR1s7tINr3AMXArWWLgwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9I9g5gYsnlhoA/IM+nU/HeTT4PLqMTpaOL8h1gEe90=;
 b=w32DuMEQQ9H+zGP/JPYHmYlSdv4ncOcOlaai7uTB4VoA128zdFPGPPYtQw3wpCcz7t9MAWDAr62ny+jf+A494lYkaWcnw52JFlwwCdIs0UU25ZcAZrmdrscl90vg9NhKRRnR11zc1NHd0XEWx3NDGCVZC7Fjw7bsXhZzNe5MFhg=
Received: from BN0PR04CA0088.namprd04.prod.outlook.com (2603:10b6:408:ea::33)
 by SJ0PR12MB6965.namprd12.prod.outlook.com (2603:10b6:a03:448::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 18:19:52 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:408:ea:cafe::e2) by BN0PR04CA0088.outlook.office365.com
 (2603:10b6:408:ea::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25 via Frontend
 Transport; Thu, 13 Jun 2024 18:19:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 18:19:52 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Jun
 2024 13:19:44 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: "Gautham R. Shenoy" <gautham.shenoy@amd.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, "Mel
 Gorman" <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>, <linux-alpha@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
Subject: [PATCH v2 06/14] alpha/thread_info: Introduce TIF_NOTIFY_IPI flag
Date: Thu, 13 Jun 2024 18:16:05 +0000
Message-ID: <20240613181613.4329-7-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|SJ0PR12MB6965:EE_
X-MS-Office365-Filtering-Correlation-Id: 619af86d-7f85-4719-0d5f-08dc8bd56b3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|376009|7416009|1800799019|36860700008|82310400021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z7jO8jP9Km2kAlC1/djKj9w4myZY0Ytn6OJ0na6rGWw0QmwkzFY3UrquI7j0?=
 =?us-ascii?Q?78+fMrAVhm9c5S/FSB5K+DcdsHeCa71aHfk1ndFDJvjAdD1MjkAozH0IEgXY?=
 =?us-ascii?Q?73e6zSvEHkgYNg0ZZ3iug5JMpe6vATa0cakQ7/kE+HcDRgLms6FUg0jnQECT?=
 =?us-ascii?Q?w1m3bsbP3Sh+KIdnXx/2ANTc/0um41TNHsHTPeFNVhMfCeH7Qhq5RnJ0Q/iK?=
 =?us-ascii?Q?prDxtSqnYwO8FSc2pLDLLxaCtS3lo9/mmfu2MxDk+UeM00vsLKbw4qDwgQaN?=
 =?us-ascii?Q?qgTgrb9IQ2Cvv1ciVPBh/pCogzVzoFIaPwvFNw2GiCS2lNFnnkxkmLu76Ad+?=
 =?us-ascii?Q?nfaG/W/n7WpF9Ef7sfe3tI6j17HiyGbxr++laYkc0FaOeNgJt1bl3QyKk7pS?=
 =?us-ascii?Q?RLtzYZpWbP1wmIRTBsnvJztPNqacy7+Nl+543osgCsiAxpHaFrSFdRXdmezJ?=
 =?us-ascii?Q?y58IfcShLopzh6b2XfuWTKmfZv52HXtBJHA930I4wliXNw2m2rCMHCk3AbkR?=
 =?us-ascii?Q?y6jne80miu6mev2QjcmPYPMxoSfn58/7rq3mHKQTsTgD4y6bNtVpLzIS37Oi?=
 =?us-ascii?Q?powQsiQRuyDiMChLeaCLDJmcUk+m+YOoGFI7EmRCIJHnsx4rIjB+0XBw/3rs?=
 =?us-ascii?Q?QuREvIRsqExvY169EuPIzZBVgUgkDlIDLc6jY9h0mnZVqlV5aZAbtXsgCbJJ?=
 =?us-ascii?Q?VXqljgw8OGq5zVYUnnEsD1tfL02AlMjbCasaUEoSO52Cd5snbSzOMQGrilC8?=
 =?us-ascii?Q?KQJFJXxBz7uQ5B7jroBvPHAYsZQAOds+oGO5TpWoYkl86Wr30dpv4FZT5UQi?=
 =?us-ascii?Q?3LPgYq2msJ7hHK6YlmcxjInZDLwjZVZbI+Cw1yL40PiLSawaYjDUUcHd3R5E?=
 =?us-ascii?Q?kiXEGGwJMt8D7D/Vm8Ic8kXgx/HYRHiD3L3kZQvtlXcQNNgkjL7LBIzZ6gPT?=
 =?us-ascii?Q?+8sgM3K6sIXmCgwuULASEppH9VfrhQ5ovJvZVK97P2oP4AcURjlKV3+1oX94?=
 =?us-ascii?Q?M1JGsmjNa9wyEbD2gZJ1jgxnU1azrym9UEyJjBJoO9xuyZEQQXys4e4c5s0s?=
 =?us-ascii?Q?4IFzfHG3+r6FOoG6xVkeDQ9MvO38vhgRYHCxxT2wslI5DxHlDkgYlojh98Ns?=
 =?us-ascii?Q?qA1RF6QYelVUtJuS3RvljlsOLZW/1y6o+0U9muUkmaXwWxhkfuk2asOMFlbi?=
 =?us-ascii?Q?DDMdenqYcbY95drJWdSl4z/8mrfqIdoJlimNdT+4v+EmfNU9C2Hgf5oxthmF?=
 =?us-ascii?Q?e08twHeXVadJnwzNgWBzSW/DihQYlB4sgWht0GGq4ryyksW3t/GGfOF83nWj?=
 =?us-ascii?Q?5hZPLMort01BrjQN9JnpoREJA1dL3ieRRhjP4YRwvdqqQL3xn2MW9tk93TTa?=
 =?us-ascii?Q?FFZF6ybTp+l1cjrQlfm3fE03YZlqqQ+v/WyTaa0O2hAVdMKEGg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230035)(376009)(7416009)(1800799019)(36860700008)(82310400021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 18:19:52.0504
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 619af86d-7f85-4719-0d5f-08dc8bd56b3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6965

Add support for TIF_NOTIFY_IPI on Alpha. With TIF_NOTIFY_IPI, a sender
sending an IPI to an idle CPU in TIF_POLLING mode will set the
TIF_NOTIFY_IPI flag in the target's idle tasks's thread_info to pull the
CPU out of idle, as opposed to setting TIF_NEED_RESCHED previously. This
avoids spurious calls to schedule_idle() in cases where an IPI does not
necessarily wake up a task on the idle CPU.

Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
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
Cc: linux-alpha@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
v1..v2:
o No changes.
---
 arch/alpha/include/asm/thread_info.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/alpha/include/asm/thread_info.h b/arch/alpha/include/asm/thread_info.h
index 4a4d00b37986..8c17855c85c7 100644
--- a/arch/alpha/include/asm/thread_info.h
+++ b/arch/alpha/include/asm/thread_info.h
@@ -64,6 +64,7 @@ register unsigned long *current_stack_pointer __asm__ ("$30");
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_SYSCALL_AUDIT	4	/* syscall audit active */
 #define TIF_NOTIFY_SIGNAL	5	/* signal notifications exist */
+#define TIF_NOTIFY_IPI		6	/* Pending IPI on TIF_POLLLING idle CPU */
 #define TIF_DIE_IF_KERNEL	9	/* dik recursion lock */
 #define TIF_MEMDIE		13	/* is terminating due to OOM killer */
 #define TIF_POLLING_NRFLAG	14	/* idle is polling for TIF_NEED_RESCHED */
@@ -74,6 +75,7 @@ register unsigned long *current_stack_pointer __asm__ ("$30");
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
 #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
 #define _TIF_NOTIFY_SIGNAL	(1<<TIF_NOTIFY_SIGNAL)
+#define _TIF_NOTIFY_IPI		(1<<TIF_NOTIFY_IPI)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 
 /* Work to do on interrupt/exception return.  */
-- 
2.34.1


