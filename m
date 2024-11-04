Return-Path: <linux-pm+bounces-16990-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 759299BBC9F
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 18:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBB01B22952
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 17:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9191D150C;
	Mon,  4 Nov 2024 17:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gXTK84te"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2A91D0BA0;
	Mon,  4 Nov 2024 17:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730742894; cv=fail; b=PAtnGvcszk5ljFjbAsQZ98XojJVtJtnSAKnPpZVP3pdRhHSb4UDljt9iRCtSDxnhQK168FGvVFh3DGA4DhzIGHHfTJkahd9NVC4fLI54PuZoi17j/b6K0sBCi43wEg3p+cMqEmbGLzs6+Nx5eeEljWqbaXLh/ok39EEW4RPnsa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730742894; c=relaxed/simple;
	bh=5QgUYLv++5zqWsxvn/X9o+oB/2GdwFu097Mfhex4vh8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZeQNooEDHgLnNjKbJJ/p9mJ1kD3HKVaw0YKFJ+xH/MdbEYACtUYtGkXBqH2orZBjQiICEHJBFt4/R136C5LAlzH/mhz/LynRyUVhTCGIk9+COa1IeNI3qqCsPI4INgdzSakpDgZIfXAUitBRy2iC/9RHDsWWp/KGXO6b1OvHntc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gXTK84te; arc=fail smtp.client-ip=40.107.212.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HyfVe/wUYiTYCSSRpVuGHec45O/oLIFqMwpqtRlkXY997//aRlPGBX4oijD2jgUMj87Lybt/JzHxTgcN7L58rrr+p8xsx06zL1ll01AAiAHiaB/0AXu39+AIs5E65zfTrHt+xwXG/TJHwRh9ioJ+kwQqe627qOzw2RBZ451sofkiLgf39RBX5qvTUJNL5/tOfkMif0T6eJMaxETynJ8cUf/0pwtwG5F28cRDJ1uvOcwKKQ5ZWWGpuFj/CfCS27w+H7rizKj/j7nXzKTgal3D1rVrxrngay25tAOPc5HwcK7UIrRCQNnkmBdmqeZ1BcBkTIVtHr4QHUiPg2m9geAzYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/ZtqGfcR+U/0WNCwGtvpXPNgpS7lRuljENyAtOv9is=;
 b=I1W/vM//iKIVz6lj4F9se6/w1566WeL+MOrWGwSRQxR65Qd/IsKE8uR0M6f0PS/Ptso+oJVzaqhOTHernbC8u2g1us5d8RYANBncUZOlJ7qlGs6kvAUbKZl+zIqXSbKCIPzUnRMo4mme7k/9e7LZY9HLqRzFgG9qUPo/rfqRxVB+6Ls7MShHQmD5xJ/gYn57P6nBcZKj6qW0zdAYmDIgqSShUGjBRIJKqCxWOnaGNe41b4aldOeApJz6eYiH3dGn7T+czsc7ekMP77Eng/JQdYXbNu0bSEVtiHiyWj5J58F3TA2+NFRqRig6Lxsz22IjxHJlYKOj0H64wRFGIV5oAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/ZtqGfcR+U/0WNCwGtvpXPNgpS7lRuljENyAtOv9is=;
 b=gXTK84teordFnRJhRWFVOMUIZBm2Bg+iIgBVG+utdxui+GNgXmMXTkK2LoSImcy3B8j0xtnIosEiLteP0X1T2rmx2cQZWnjbiYPPbc6Rumi33VeXNyd2ZXVr7RiFUiGm2V3MIQt1T8T5GzszDLafzycoXfVnbflXXqHzFyfvD/s=
Received: from BY3PR03CA0013.namprd03.prod.outlook.com (2603:10b6:a03:39a::18)
 by SA0PR12MB7464.namprd12.prod.outlook.com (2603:10b6:806:24b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 17:54:49 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::b) by BY3PR03CA0013.outlook.office365.com
 (2603:10b6:a03:39a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30 via Frontend
 Transport; Mon, 4 Nov 2024 17:54:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Mon, 4 Nov 2024 17:54:48 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Nov
 2024 11:54:43 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v6 09/12] x86/process: Clear hardware feedback history for AMD processors
Date: Mon, 4 Nov 2024 11:54:04 -0600
Message-ID: <20241104175407.19546-10-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104175407.19546-1-mario.limonciello@amd.com>
References: <20241104175407.19546-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|SA0PR12MB7464:EE_
X-MS-Office365-Filtering-Correlation-Id: 426026ec-ba40-43c0-adeb-08dcfcf9c690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ydc6xCSzCHICID9q0XXgAgkWFhfr7bqpuwECWq3TghETtVW2DhPs5ZoOYuDM?=
 =?us-ascii?Q?cNrqM/h8hwaWbQ0lhJ2RlpF6nRvSNMCB44nBF0rGs+o1Kik714Qwsk5J0DPs?=
 =?us-ascii?Q?SGnt7fT905lVXFfA3kRA4c3n3Zw4hHLdUfikTEwoTdSsUDzyWTN3q1AJ51Hh?=
 =?us-ascii?Q?tJAOk/N9OvszqbSyCX2tjG1IJhgKY+ZCafDELdVm2L7R23Eu03d+jZmFVJIT?=
 =?us-ascii?Q?t3v07j5zCsLKP3KtzYMwC9BgMj+oNIZx9IhE5WOufwwWkYEQotUhJ1YRXdVY?=
 =?us-ascii?Q?Fd9lcE7XfROUSPNMpsArWfUE4CeTr20K9qfzZfMV1RCqVtDt6xueXFb3xVdc?=
 =?us-ascii?Q?EC4+OZX1RgWDEEnxUwQYqtrEv075AJIvlugeYk+KTzhte7mZzcudtgzkVsgg?=
 =?us-ascii?Q?/dDPklQcidxLidTKV/fXgX5k6gPKB9tjTE7bMQSwyb5SPKzwqM1YqOpjTbwv?=
 =?us-ascii?Q?mfSxmznl8W4vGo3zevvw9Chz2uzxHaG26085mBj49zsXwL9ZkbYhYMS5DaAV?=
 =?us-ascii?Q?EJ3glyCkhfQ6mEQ+OAUFgQpWXBwJ7HbpmlRe88+PWUOTRj/WL12ZUltPm0Px?=
 =?us-ascii?Q?tUMTMII1T4dD6go2l37nemNmgyeu4+mMbd4eZIm50JEDccjPsRNGE+Ubx3Vk?=
 =?us-ascii?Q?9jDi2O2qU/2+Z8DITiYWbST6EjqlEchS+jiI4AI6uW0FiyEjqhIbjcoy3UK0?=
 =?us-ascii?Q?sj7qNStRSMDIv0psQiWZWokv2tpbMxcWGHAX+OAps43aPUwciwkbsq0S2bCj?=
 =?us-ascii?Q?3RFWdvny2Lt45UMYXFrZj++QZT5+539hfw4gCLXt9fF3gp8+x3Rz6jc4qKBI?=
 =?us-ascii?Q?pBnTgQ0E+2JCTvJjOcEiIix82StewAU0UjhnC7pW5+WsmJIi2snL2izfPJck?=
 =?us-ascii?Q?Aphlfc1XDDd4nXb7Stb/cc4/Cgx8f4czOIluF+bU/mSwZj3Gu65gZUY7elQb?=
 =?us-ascii?Q?aK+6hr8H055IwoYSi2FTXRpn05f7e8UWn38TwxNBg/flyC25evAowDA0OPjj?=
 =?us-ascii?Q?4Bq7p2eCsC20l31Jf52rMcCk6x/VylmUJSK5/r/FkoN55rHG3dv7vFZa9YHx?=
 =?us-ascii?Q?QgywDbYn1rYvljS68Tg+dwr6V6snqIRvr4ePmaxECSNkw4Kydu0Be4ifXrkG?=
 =?us-ascii?Q?Eyu7wZr+9QwfC6T2Vl8X6lWTXSF+YGk6yd0lpIUB+0JkJ8qiST+szkfcPNPj?=
 =?us-ascii?Q?Jx2XIpwnZsNFNh4uAy4hM+vhhXBcPVvKpwgf639evWNfm7ZhtedJgdsYbilS?=
 =?us-ascii?Q?fdkMPiPZNjs6bbpQadJvEkaq5cUp/20SQqQ+DU7RKDHDykXrjkm1lMUys+dV?=
 =?us-ascii?Q?ol6JugVfHpixKoMHKgGug1Pb0IDPfN7eU2gPPJyqEB5jFINNvgeF4gW3IJHq?=
 =?us-ascii?Q?eX1UJoBTxNa+EoMzblS8YL5hiIxISm41cDvx/AlK0aDl3TBHnA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 17:54:48.6631
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 426026ec-ba40-43c0-adeb-08dcfcf9c690
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7464

From: Perry Yuan <perry.yuan@amd.com>

Incorporate a mechanism within the context switching code to reset
the hardware history for AMD processors. Specifically, when a task
is switched in, the class ID was read and reset the hardware workload
classification history of CPU firmware and then it start to trigger
workload classification for the next running thread.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v6:
 * Drop all static key stuff and just call in __switch_to when
   cpu feature enabled (Boris)
---
 arch/x86/kernel/process_32.c | 4 ++++
 arch/x86/kernel/process_64.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 0917c7f25720b..0bb6391b9089b 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -213,6 +213,10 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	/* Load the Intel cache allocation PQR MSR. */
 	resctrl_sched_in(next_p);
 
+	/* Reset hw history on AMD CPUs */
+	if (cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS))
+		wrmsrl(AMD_WORKLOAD_HRST, 0x1);
+
 	return prev_p;
 }
 
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 226472332a70d..371e0e8f987fa 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -709,6 +709,10 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	/* Load the Intel cache allocation PQR MSR. */
 	resctrl_sched_in(next_p);
 
+	/* Reset hw history on AMD CPUs */
+	if (cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS))
+		wrmsrl(AMD_WORKLOAD_HRST, 0x1);
+
 	return prev_p;
 }
 
-- 
2.43.0


