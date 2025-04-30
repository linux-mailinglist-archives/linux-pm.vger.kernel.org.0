Return-Path: <linux-pm+bounces-26453-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFBCAA4A11
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 13:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CCB616B9F0
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 11:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7842E25B67C;
	Wed, 30 Apr 2025 11:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P4Puiiij"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C144D1E8329;
	Wed, 30 Apr 2025 11:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746012712; cv=fail; b=enmxb+bfR5SxRSGnsPYJCUpHozJ/4/T0y4KpWBXav9Ub3rKztQMmbuWCbvPR4jsFTyMNfvghPvvKKOaMYrCjJiXUeioQoapd7k0yE7wzqcwdaNc+P7X8F2l0cObkxLWVi7PXJgnu+v4VkIGllgQk1SEpp45BBkoq3rpsC7i458Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746012712; c=relaxed/simple;
	bh=CCMf4WsaLhz9e6nnpNse4SCP6G700qLNV0Q/DOzW/m0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iJ2CEQWe+vuF1REWfEwMijHM1Kvc0cBwPO/yOBR52/Q2K5FL3f+7U+AQe3Z0Z8x8Pzs2NgLPeAhPCAbxlqs9JzsjW9IyWbcrByBMwVki67f2QhT2E+W24bbslUSap4C40jlqTnJb599CqQ0oWT0eweAkd+vgujg5ieT9bxokUx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P4Puiiij; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PqOz+Q7E6aK08yo+lCWoJ5TDRrRfuDO674xgNoMEjO7W6AUf032BhKnDu7+fLPHfsHTJMEMkcW1YAdFhpgEybSA3j3MivqDaNZB8q0/3ZqTfNRKCFFrLdDlbAe9dQedHL3XSOPRy6HSy1LNskMXtcpvPhD9fPlsITbmjRxmwwSeh7b4K4oXxxEx49k8ZTlEteDCYxeQ6QWNkEHJLSABccp+k2Duf0HyExbh4GmJ6WTdl1fLMkfq64jCYvvKbO5vqk92zzSHtJ/Rvihh2A6RMW+PXGfKJ4Z5dH1H5cTDCW9f7P8601fSa4JzuvY/RoZnV10Z1YyX1BEwRZrA3VbyyAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9cLAhnGR2pw9ZZ6or1ESe1Y/oAiVS6Dbb/g04RDC78w=;
 b=KGQS2Y3AL4KQlVRGrfWgZE25hAgnED5zxpTnA7ggXUGnsJaLXqjMLulRUEtYk0xfzx4kapArntYRYiqSsprpB2hI9ZiUVgyEJhWzcRLB/0U2wMIsd0g+Y5MU6i4c/4V3zlKL7q/3kDqc/PuqBe9F7LmvIl/7XfV6QFFo+PSt6jp6GmW+nT2qq0Z2entLFJSssDlOG2NJwgmZvU0UYBvWWzs9IA1/PVVfZuPEgJpS4lDwvfolq9Qm9aTAzp/jV0hAHNm00AGZkGEEsuPvl3GH4eRgVANw9ocBHIRV9SUNnu0xaq1P7EUSSwLDL/JALU2UwmeiQjkuL9FuFtDfXNEH4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.d smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cLAhnGR2pw9ZZ6or1ESe1Y/oAiVS6Dbb/g04RDC78w=;
 b=P4PuiiijyRuGBjK4TiEnHqpFf7LMK0OxzCp8IZcuYeBBI+/eYemXD2jAvdWHfHwaCiFNNnhGM6rI8KsGLdc/RmleCJvseZEl0d7NwbR70ZUZlzkcJUtkf8EHaO2I6IFvCfnwvTT5RvJ79wEp9D5JQA9mZalSL/zk+bfcw5Ysg48=
Received: from SA9PR10CA0029.namprd10.prod.outlook.com (2603:10b6:806:a7::34)
 by DM6PR12MB4452.namprd12.prod.outlook.com (2603:10b6:5:2a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 11:31:16 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:806:a7:cafe::b2) by SA9PR10CA0029.outlook.office365.com
 (2603:10b6:806:a7::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Wed,
 30 Apr 2025 11:31:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025 11:31:16 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Apr
 2025 06:31:12 -0500
From: Shivank Garg <shivankg@amd.com>
To: <tglx@linutronix.d>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<luto@kernel.org>, <peterz@infradead.org>, <rafael@kernel.org>,
	<pavel@kernel.org>, <akpm@linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<shivankg@amd.com>
Subject: [PATCH 4/4] x86/apic: Fix W=1 build kernel-doc warning
Date: Wed, 30 Apr 2025 11:30:02 +0000
Message-ID: <20250430113001.546066-4-shivankg@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430113001.546066-1-shivankg@amd.com>
References: <20250430113001.546066-1-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|DM6PR12MB4452:EE_
X-MS-Office365-Filtering-Correlation-Id: 223e3b6f-6bcb-43c2-f59a-08dd87da8543
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gb3Ins+HRkWurwvYelkf38BypaQgbOnwuGvmIa1LQyV0/sC1mPvbIUkMKCC1?=
 =?us-ascii?Q?8ygVrQoZsuxY5PS+17aVPZ39xP45glSmE0K9XV203zEQezewL03ijHClB60i?=
 =?us-ascii?Q?Eh6CYrD4CLi0KWHVNkEqb/xb6nfU2D8cbh7eR8NKciYH2QL3fkK6U79dk21+?=
 =?us-ascii?Q?6y5DktJe7n7gDFO7CcUpoC+3dNbJC4ZU4rd31ejZc6DL05Chv0KfKph8VuYI?=
 =?us-ascii?Q?CwucCRQp1TE5+i2IhY+TWh5768RZpaqhN9b5iJn1S9E1vyY2jOqW1/8hyjqa?=
 =?us-ascii?Q?pMFnXAh12sH8Ptkj6dDXGOWHXHfqa0PeNDnGaSdJZ1DvidsdLbPcWEBKCjyt?=
 =?us-ascii?Q?RqKgArixWnVAye1nI8+9fi852GD9l717qj+n7YfzsyC2o6FwQd6gTKgPIzUn?=
 =?us-ascii?Q?74Pg1GDkLdkSslO0130T5YqFeoC8ES21M9B/PfiEy4GynHOZdIEz4hjtxrib?=
 =?us-ascii?Q?oq/G50qq2Fg9r8J0fKmA7h8rdknkpvooWl8R0IstSInnnAWFTpTtNk1Pq+zg?=
 =?us-ascii?Q?iorQ0+t4KB2mhDoPMgm9TDiz+M9ls48/9k65pVSWt1u+eHUxRyNf4II/TUsV?=
 =?us-ascii?Q?Crgq8darvwveAI1jpCn/dcj+zlRc94lP63WrBAeb/NUzLau+k+CHwAaKmM2x?=
 =?us-ascii?Q?tGhkw5nwO++kgnu3ugrYd48mw9FaOf6R/qTYhb2nc9wxI3vAe55IoQk7LzpT?=
 =?us-ascii?Q?7y2P/0MJ1yUBoGct3fil5Ly30VojgOeyXb6WDAJ1fUypBJayjDYsKMuVKYXm?=
 =?us-ascii?Q?fmdrW+ApTWmrfgMLxEzDZR640qdi8sbVJY2CmHMojXYeodqbRExrp4FM23bu?=
 =?us-ascii?Q?TLPTkFc8/PpnnU/DYM9ORbGQ2bNDnrMkJlywzHknohplaMfbQ0RZCdph95uv?=
 =?us-ascii?Q?xAPw8fzjI3o8bJ2+GhjUCnKiEa3wJ6doLfOZDUNBYNZpzcZ25621GMxzOcON?=
 =?us-ascii?Q?6FvKEpZT657k+qMu4cWMom6o4DrMdrxIwhkIJf5JSAJLMCRparQAmeuVqa+T?=
 =?us-ascii?Q?YAmNJbIFkJnJFophbL6u943iZhSHnrW9sl2lCsH+m8EuuT2nuJGGoNbvLRWT?=
 =?us-ascii?Q?dbrABaAS7pqqVj+nlHFrZaot0qDUufqYLo31i7o6SpZcYH6z0shRqB6vBbMf?=
 =?us-ascii?Q?8zBOW41KcDbuwdKNcpAx6akT3WTpVIVV21NbuVdIXRifadHgPGet2AwZPd4D?=
 =?us-ascii?Q?aa3BwPrlpR4x2G6fwBDxyilKOiCAklY248tVUV7DqMUIsiuTuL42BJLIbVQM?=
 =?us-ascii?Q?F+SN6rQnduBG8pd9Ab3QYA1+BUk+bycPN8ZSG32JbLizECtutaEX+OSHfqtI?=
 =?us-ascii?Q?vVgks9aMljlYqsZOzia9wEejd8Y1dGye3W45GFx+7FxWuSvEy6UxW785bEff?=
 =?us-ascii?Q?WPkIrMloyumQZFtwR4aI+aCnbqKnoKmF5sRxX9cUu/2EWo92r1w0dL0aAtjU?=
 =?us-ascii?Q?ISUFi6/Xm9hF2tnc0bbzssHzcrxc+3Vcx54WfuFzjhHP5M5F0UcurPXng4xZ?=
 =?us-ascii?Q?ghTyzrq6v8/qT9fzxep6M0uScQpwtIT3tyZR08bwoLjWh75LzhZWb40jvQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 11:31:16.4288
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 223e3b6f-6bcb-43c2-f59a-08dd87da8543
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4452

Building the kernel with W=1 generates the following warning:

arch/x86/kernel/apic/apic.c:2140: warning: Function parameter or struct member 'spurious_interrupt' not described in 'DEFINE_IDTENTRY_IRQ'
arch/x86/kernel/apic/apic.c:2140: warning: expecting prototype for spurious_interrupt(). Prototype was for DEFINE_IDTENTRY_IRQ() instead

Fix the description format to fix the warning.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 arch/x86/kernel/apic/apic.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 62584a347931..f888a28d400f 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2128,9 +2128,10 @@ static noinline void handle_spurious_interrupt(u8 vector)
 }
 
 /**
- * spurious_interrupt - Catch all for interrupts raised on unused vectors
- * @regs:	Pointer to pt_regs on stack
- * @vector:	The vector number
+ * DEFINE_IDTENTRY_IRQ - Handler for spurious interrupts
+ * @spurious_interrupt: Catch all for interrupts raised on unused vectors
+ * regs:	Pointer to pt_regs on stack
+ * vector:	The vector number
  *
  * This is invoked from ASM entry code to catch all interrupts which
  * trigger on an entry which is routed to the common_spurious idtentry
-- 
2.34.1


