Return-Path: <linux-pm+bounces-9117-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 460F8907B1F
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 20:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3252A1C237CE
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 18:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A5414B961;
	Thu, 13 Jun 2024 18:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WF5ve2zU"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C01214AD0C;
	Thu, 13 Jun 2024 18:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718302867; cv=fail; b=BvlXANusw+GZDrpIoTy9fOe80RxoFRwbj7Vmq9fsDeT4Ea6NVKAw/RIGaUYigI869X4fTDpZmpOrFb68cKulsOfnHAj7VDy4EX8wLj6Ork6ZUckRwIKlGnb6S8EhnPibd2JZ9nq+V7mVL1oRjBbJ/T9sRfk8PxWtVP37kPEX8LI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718302867; c=relaxed/simple;
	bh=mLM0JJ5J+DlRoRzgAwtESJl1A7QxGuEycZmwSQx6fy0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rXTRvCnAWkop3+AgYzXGzyS3kfS6y2w++WpQ+fPXYnWehtT2f3zJniXPICyEihlWwnauVJyZCJe5aET22Afw83xgwqvD3GY7zUlFmaYcOFyuJ70JGC9tsIxn7Xwt7JIP3z1PSskGHok7lTUu5pUyFBL6uctwRR3OsOe94FKSKgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WF5ve2zU; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIxW/xYntALr7MEqGTx9U0LV9b1ULXIpD4JYjcR6UFIzOW0yIGPBG4oYWs5b20J6YJkXl6KI4NUWr79aSnxYNGEO9NVN7nqIhVikTz5VycWOgwWIqTRXDVHowOMCapzqwm7xO/MRXNCzl7yHtFKQoJ9cRZVAQiZzhDPGvtHxu+a0+ZqQQfs5pfYkL3TCS2nCOGbEeaECVpEhWK0c7+HJZsPCdLDjW6Ildw07iWJuLze7qf71w3sTECwu2HDjNnFLKke0/g7pK/I9HEV8w01j0653txWgfqH+LQRpoRdIBpHorydrA+EuF2i42aqjdvVHbZ4ZhoVZ4Oar9f5QYqYhhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9rvNrb1dw6niVdiyuZ+02P3rAdH4uSssIVn0bFt6ME=;
 b=Yzte+4wYJG6YqOGUbBTwuE8hGCcekmfhcVX/HKqjwljuOsLq26/DfPsAtAnkXMW0gvvF4waFHMrFi9KC4rQ+bwcaKBfqzBWDjY1wy5jTpDQyhKStKWLDP8gtpCQY7maUuEpcQ9wMWw92gVQEI83ys0E84GwTQceFABkYbwiMXSUpuyhk4VgzEyGw1NeJfSXptkSast4jjQnjNVJ+SF1sApfF/3Wqij9txmVjhk6sIRiGIXle55LGv+0D35IM/jG1KylJSPylk2WUzG/iWC9v9PB2p/2J/VBO7rVvG0m8Z/4I7G+FJcgpx1+Z2rRvRCct/IaaCe62OWIGDoruoKmlgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9rvNrb1dw6niVdiyuZ+02P3rAdH4uSssIVn0bFt6ME=;
 b=WF5ve2zUEDfeg2mUcMbhe9w4UlXOGZYMl0rgHdnHem7a28T0cN9FD2dIzBWUUmprNOVkVMPcKYGaFIeOpvr0BwOQGyosgMCJkHUdPOnNJrvVuhCS+QQB8BYtyjAmVWdUTqgabV4nLWaHYPG2r5njHk80tAZesXnEkHmTeqkdTKA=
Received: from BLAP220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::7)
 by MN2PR12MB4237.namprd12.prod.outlook.com (2603:10b6:208:1d6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21; Thu, 13 Jun
 2024 18:21:03 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::9e) by BLAP220CA0002.outlook.office365.com
 (2603:10b6:208:32c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24 via Frontend
 Transport; Thu, 13 Jun 2024 18:21:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 18:21:03 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Jun
 2024 13:20:54 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: "Gautham R. Shenoy" <gautham.shenoy@amd.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, "Rich
 Felker" <dalias@libc.org>, John Paul Adrian Glaubitz
	<glaubitz@physik.fu-berlin.de>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, "Daniel Bristot de
 Oliveira" <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
	<linux-sh@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v2 09/14] sh/thread_info: Introduce TIF_NOTIFY_IPI flag
Date: Thu, 13 Jun 2024 18:16:08 +0000
Message-ID: <20240613181613.4329-10-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|MN2PR12MB4237:EE_
X-MS-Office365-Filtering-Correlation-Id: 721f758b-4425-48ad-2763-08dc8bd595a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|376009|7416009|1800799019|36860700008|82310400021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+L626wHwRik02EUbWohq9XxhqFdstdozYU7zDUTaacGIbS221mhxzkR8JYC2?=
 =?us-ascii?Q?4EoTLfBcPSG1Er+Xc0LxME1b9XrxZ7APKMgd9I45o1kl5vSn7uIPPZ6JqX/Q?=
 =?us-ascii?Q?bL3iJJZldiOUZb35Qf7gXGZejtFgfYpJb2teaZdmlR8to6WMHA95y9DO6KIF?=
 =?us-ascii?Q?4vJMqY9KDo6xNiXUWS1cNOy6zHcD38KYatPTABrsPEX9wgHx0tk0pES1Daze?=
 =?us-ascii?Q?rmC4VShoDRgah61IohO0pTZoDOIEbE5VxiSiGe5YmF6qvtTtsiY+IVFb0F1i?=
 =?us-ascii?Q?vORrQYG9LESthFlI0xb5X+cLCPsq+7Va8u6L9Ms2dlHcQZiTHYSehTe8gAcD?=
 =?us-ascii?Q?8LLcHqEru+75icKLAQZKQgXvOrYE+nMZccuBnI6ub9qJsBKONlpTKRQFCQOf?=
 =?us-ascii?Q?vvy0lETNVocOrhAp1/wEFc/p3wTOLzBhL9TEQ6vGFR0mwfEHKbFilvoH0D/U?=
 =?us-ascii?Q?/hIUs+YC0KoLwW8btu4n8HR2QYj7+RONKr5V7w8CTvlZGn2i5J8ZVcLZ8I83?=
 =?us-ascii?Q?7z0BNC9v4ypZWyOAG0Q0rMrd+UP5snzpJ6ttCNV9mB8DMM5NcyY4q6rS2+4b?=
 =?us-ascii?Q?Nl67jbCNgaI0jmk8sipfFDRs/0IU+s8Cx6gUGpm56DfkoKum+pgz9OCtIvyh?=
 =?us-ascii?Q?+244LLJfKF0cVPMuEIZ/D1wFVF6s+ZUUYr8djM1GV7M1DHjvt0PWYbJPWtT4?=
 =?us-ascii?Q?DjJf2I9dBC8xeLZ5VDyt5xIwe0lZobTkDuL3m5Uy/D7VlE+72voOZbjOi+Oa?=
 =?us-ascii?Q?cw4fJsO0XSruu4gHOq491ceSAXKkfxrAPM2CHdB2vSF1+At77MXn54WBUXy+?=
 =?us-ascii?Q?4boCO54p9hMmb8g4eJZ+rLQJqYnvA5SwgRUW7reUIjnZ7G2PtmJSS8WmPBWd?=
 =?us-ascii?Q?k1ezaaBR60at+QNLzuS8GNeaJxLQ1DNqbSamkdUwDu35XJXYmVlre57p3Dez?=
 =?us-ascii?Q?acN60vKoG01Gm6e8VnLcuCxlLv1Hdzu5Ruc9+4tCQlEmQNwJWeidh38+56oY?=
 =?us-ascii?Q?GnmKurbyWWGTo6fYYFApKqq4vWCLRr6TCvRo7CazfqkGgzu4cAxzcfodzDNK?=
 =?us-ascii?Q?dwJW6baBUO2Wu5q9gdVZfzj8X70oqJdD7bRzLuxzhGaD0r8j4Otex9LtCkK+?=
 =?us-ascii?Q?CA8DC7Jb47XX08ojc5q9/fElqSFot+Ox4mhlauA1kcw1uy9e2avnte61LHwH?=
 =?us-ascii?Q?uc13c2PswD8nBFrCz7kxJOYsZU6iI+bXiW1l8zaGCC58wu86VYQq4hIR7uRg?=
 =?us-ascii?Q?Qj+a1sdvXQUsRCto1PSm8hylTV+Xa/nCdx2pQmjgyLBGL6DByp3+PoXNkObf?=
 =?us-ascii?Q?l30KixZ42pJWeVaSnMA5Qv9nJIi3dxmgBWNxXeNLyiVzV4ZAkpmuSZ529H5m?=
 =?us-ascii?Q?IxOsP2Ygtgwh7pNlVDAqbLYLO3MQvv/FmdrazCk5E0xkWxaqGQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230035)(376009)(7416009)(1800799019)(36860700008)(82310400021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 18:21:03.2231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 721f758b-4425-48ad-2763-08dc8bd595a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4237

Add support for TIF_NOTIFY_IPI on SuperH. With TIF_NOTIFY_IPI, a sender
sending an IPI to an idle CPU in TIF_POLLING mode will set the
TIF_NOTIFY_IPI flag in the target's idle tasks's thread_info to pull the
CPU out of idle, as opposed to setting TIF_NEED_RESCHED previously. This
avoids spurious calls to schedule_idle() in cases where an IPI does not
necessarily wake up a task on the idle CPU.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
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
Cc: linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
v1..v2:
o No changes.
---
 arch/sh/include/asm/thread_info.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sh/include/asm/thread_info.h b/arch/sh/include/asm/thread_info.h
index 9f19a682d315..8cd9d2a5361b 100644
--- a/arch/sh/include/asm/thread_info.h
+++ b/arch/sh/include/asm/thread_info.h
@@ -106,6 +106,7 @@ extern void init_thread_xstate(void);
 #define TIF_SECCOMP		6	/* secure computing */
 #define TIF_NOTIFY_RESUME	7	/* callback before returning to user */
 #define TIF_SYSCALL_TRACEPOINT	8	/* for ftrace syscall instrumentation */
+#define TIF_NOTIFY_IPI		9	/* Pending IPI on TIF_POLLLING idle CPU */
 #define TIF_POLLING_NRFLAG	17	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
 
@@ -118,6 +119,7 @@ extern void init_thread_xstate(void);
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
+#define _TIF_NOTIFY_IPI		(1 << TIF_NOTIFY_IPI)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 
 /* work to do in syscall trace */
-- 
2.34.1


