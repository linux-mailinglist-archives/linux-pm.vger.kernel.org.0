Return-Path: <linux-pm+bounces-28545-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C55EAD7056
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 14:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 869B6188BF85
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 12:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1512288C6;
	Thu, 12 Jun 2025 12:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SDh9u8c2"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27A6221DB1;
	Thu, 12 Jun 2025 12:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749731113; cv=fail; b=OHaqT3B8d58dgAZSO7EavgB7mONo4RKm5lilgTTIDxIcMpQ3loVOtupkpM01nmMELnDrECDbW6XeFMCyUW90EgcwEYX14oK476+UR2DrQJltg0z36DPbJjCfC1J5KN8AqQaZc/opYVZWdRlJuyOMI0EtNpJzQROV4EiYqrLb4RA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749731113; c=relaxed/simple;
	bh=QLm25SepmMaOWPf+sLfz/7Jx1QozHDMPFBxpZixIQ/E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aj+OGs9tq3xmvS6fbbcwqiCUq6sq+CsS4kzBiA41NzvTzoRUCBltIHCT46kA4dx5KGsx7W+aaAuQq7rkfZPl/c1M7W/NyhwKuntE8yY/MBQL3yrkNB+Cgog4KIXEzKjZLnOCvawPm8mug5yIg36vnIFwvTeSCBnICns8zCz6CME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SDh9u8c2; arc=fail smtp.client-ip=40.107.223.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=raAPf9Aqm5aHV1tsJbXVtzBnVK0IokmVhvMD23XYjEkN/RJkjYkZVMXV+MnHdaMJ8gQpAtv0ql6iTB6lmdTs0Wbu/ZLo0t6iY+MxbO/UcelmVtra6uyHrvr19O0DDSAERQBvpkH8JQu7bq0nDACpFRolHipNusqD2cNxVaTseD03S/ZUcWpHv+glMEEhUwoAluadpQ/qWqvM7IyyBYLcS96VGbz7VXbozGB9hjJ4Gt3XV4LQjW0JHcxFGDpBVoG1H5rkw18q20rAtE77jXULa9xeXur31TgBni3BW2zftw8ElAxT1BOvUMp2QveYUvN/Zrg0QEr2zGL677VGhk3ZUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MO39YjZMtJbf3zBv2fPndOnsAHJbd+KBZWcxSWISUiw=;
 b=brZ7kNT8uCf+g7drByJgIAABIc20ZEeubfvZp3cX/aUw99cwiMn3H2S097V12TkCzOu6HQ0W47CneGrUD70k+PoH4bL9VVyXyveFps+kwRnTZFOuWaZ2ar+riYMNiOky0gTmePdcxqlwyww090WSWN8svLTljfmjS/1ZuxnNzz1TQ5J6pSzpC+sulpr0PlsjCg2umwBJJYvRfcdaC8LNEYBmomIwKj/cympIxzr3hjdmBO8aFZOXz91MIs6FNDFydxjscjSEWbwfZyhySjCmFtzGTFaBNW4mhjcrZPGXJEVizdfkZbLkmbCI4pb+tzYlgc/7FVOXD/qS8919rhMQ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MO39YjZMtJbf3zBv2fPndOnsAHJbd+KBZWcxSWISUiw=;
 b=SDh9u8c2JNQ7dc7yEVpyK0SVtMAPW/VkqfYktVuGf06fWpD6stulv/wwra1uRDEJpf7YC3XOe7BS/IdgPPPYmaQp0VxiEk+/a0Ma+zX6U6Xa1kcl0OAOy8hvt/oSVb+m8z4Qr54o4HmKV/xRBtZH/WcHgzjL4iDtGoTlwyGf4Dw=
Received: from CH2PR02CA0006.namprd02.prod.outlook.com (2603:10b6:610:4e::16)
 by MW4PR12MB7014.namprd12.prod.outlook.com (2603:10b6:303:218::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 12:25:09 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::d1) by CH2PR02CA0006.outlook.office365.com
 (2603:10b6:610:4e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Thu,
 12 Jun 2025 12:25:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 12:25:09 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Jun
 2025 07:25:06 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>, "John B
 . Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>
Subject: [PATCH 2/2] pm: cpupower: Fix printing of CORE, CPU fields in cpupower-monitor
Date: Thu, 12 Jun 2025 17:53:55 +0530
Message-ID: <20250612122355.19629-3-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250612122355.19629-1-gautham.shenoy@amd.com>
References: <20250612122355.19629-1-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|MW4PR12MB7014:EE_
X-MS-Office365-Filtering-Correlation-Id: 79d51777-574a-46f4-b138-08dda9ac2be6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VHje7XF1zFFpdhAvAc0ro0YVZOQvBy6FRPfqxoO7Ttjf1iu5xxlgL59YQDZo?=
 =?us-ascii?Q?9F41Z8ufgf/TUbchm+dqAA5OEolWfhlmwnhVMuCxoMVyYuyM1KfhvZ2chi55?=
 =?us-ascii?Q?r0sBhjhXdyqhD47N7GSGXfLakC6kWivtdfBtr8QbX4iz0E2m8P/2/28HXicI?=
 =?us-ascii?Q?hagfnkYArM+EfQtUGLLvLTUQ/uHvKZYj10/QE7zmJXwSxVPXZs0i3SrsqzaA?=
 =?us-ascii?Q?dru6Fk3yJnzpbznBlKQKF7SNQnhOVFmun3j9y5ahZcSWVejy27jiREcqggzA?=
 =?us-ascii?Q?JDTAgPzGgLLh0xZtIy2voFJIHHhsUf/2UbsyhUoGivYDKXGCanx9Iu9bh+Nz?=
 =?us-ascii?Q?qoip6SIip3QKSJbVhjpXl+ZPZRiGw0Rjo6JIbhGzDdBePg15ocFFEmNEmxMa?=
 =?us-ascii?Q?WvSNU13XzLCZTGL8WSxD5KEIil+qkA4emHRGht5vEvpSMtaIsiptdCGVRiOY?=
 =?us-ascii?Q?fcpWt+OHHEsVaqmCKGrGc3Nlyl9kPzMKDZFkkXBCT/raQv+bBc7xSCiISUMx?=
 =?us-ascii?Q?NZsXGechtFGQ0Z1C/lxmaYUcDloxCV+ufS7icwGXAleMvD0A7/RbOc/Ig3or?=
 =?us-ascii?Q?zLbLgAAT6RBVL+fdZiZJJFt5fCL7wJ1ZSU8O7ESdtpxPTvaf2B0nTz837LUH?=
 =?us-ascii?Q?0t0xaxq6OfpFYtNGuKMLJ0C/MIFa0Imscd/fdOlhpIwubO7TZdTqqfG5mdBK?=
 =?us-ascii?Q?rN4OnGvuee4CmqGsP5FpWDTK80WifhBuLx5fmILeBQqQNQMX1UcdfIm89Osn?=
 =?us-ascii?Q?MHb/lcKvZ7bgCHM2O/HW6oQYy8+Il291Pxyg5L7UcjkqBb+QF7+iumI9mCeP?=
 =?us-ascii?Q?r/8vZlJsblJtmi7cdspEzMLaxq/HOUW8w4NiByjPPUA699QAI9dmAnaNIVXW?=
 =?us-ascii?Q?i7PJASedTl/TQagwF56Zme5W9u9FDjTrCQM17VNQkh8Zrw99yDa3Zn7cQzO7?=
 =?us-ascii?Q?s4uftP/733v0axPlFyXYEGDpe8LhpyC/dXfBc7XARJctnAVzuNvxR1RdGn/C?=
 =?us-ascii?Q?QPwlhT5FKesbi4y3r8cS17sVmMZzay41HgWAODH8/mCgYELorSeWJYfQvR+b?=
 =?us-ascii?Q?DGun2BdKEhuu+3ONsKV1o7sbGBDg4gUGghc7coM8QyikZjhZdjAWW3K4oMqB?=
 =?us-ascii?Q?BHVjqnBEBnE1ysQkP/pPY2Zp72/kPuonibuV3zwzHJwvtIA8bhIwNvrOYlf4?=
 =?us-ascii?Q?8pd/6P1WU1GhoC+WmrL4o2AUsCATm5qDOLUvOI2R+wW331lfV8gZ+2PtVrLy?=
 =?us-ascii?Q?CGqi2oFVyTITr60Vuzjbjt9Om0EUnkxWreHDND9oFzVdBDhAQQWdxfI40Xoo?=
 =?us-ascii?Q?rwRFgo82tbVjVPFGpFDS8tnwzPotfKYwd2Z8y+Lz391WlYsyBzXiRzeKJyE1?=
 =?us-ascii?Q?bQ//Tc7KxCQtocb+UA+2JeHYOXpnO4siGK4jLbeBQu6QtMrVjNp2l1U4VRNS?=
 =?us-ascii?Q?VVu2cJtTu5kPQZJyqouRWi8RDl/njTRPM87+l0iAfUrnRCkecOCxLBllL1wc?=
 =?us-ascii?Q?+Djc4KuJ1nNTbOV6FsrI0AtOgBAie4p2UoRN?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 12:25:09.1908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d51777-574a-46f4-b138-08dda9ac2be6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7014

After the commit 0014f65e3df0 ("pm: cpupower: remove hard-coded
topology depth values"), "cpupower monitor" output ceased to print the
CORE and the CPU fields on a multi-socket platform.

The reason for this is that the patch changed the behaviour to break
out of the switch-case after printing the PKG details, while prior to
the patch, the CORE and the CPU details would also get printed since
the "if" condition check would pass for any level whose topology depth
was lesser than that of a package.

Fix this ensuring all the details below a desired topology depth are
printed in the cpupower monitor output.

Fixes: 0014f65e3df0 ("pm: cpupower: remove hard-coded topology depth values")
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
index ad493157f826..e8b3841d5c0f 100644
--- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
@@ -121,10 +121,8 @@ void print_header(int topology_depth)
 	switch (topology_depth) {
 	case TOPOLOGY_DEPTH_PKG:
 		printf(" PKG|");
-		break;
 	case TOPOLOGY_DEPTH_CORE:
 		printf("CORE|");
-		break;
 	case	TOPOLOGY_DEPTH_CPU:
 		printf(" CPU|");
 		break;
@@ -167,10 +165,8 @@ void print_results(int topology_depth, int cpu)
 	switch (topology_depth) {
 	case TOPOLOGY_DEPTH_PKG:
 		printf("%4d|", cpu_top.core_info[cpu].pkg);
-		break;
 	case TOPOLOGY_DEPTH_CORE:
 		printf("%4d|", cpu_top.core_info[cpu].core);
-		break;
 	case TOPOLOGY_DEPTH_CPU:
 		printf("%4d|", cpu_top.core_info[cpu].cpu);
 		break;
-- 
2.34.1


