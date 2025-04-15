Return-Path: <linux-pm+bounces-25462-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EC2A899DC
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 12:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF362189E383
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 10:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3920E28B4EF;
	Tue, 15 Apr 2025 10:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JyVbp251"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F65A1DE3A8;
	Tue, 15 Apr 2025 10:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744712605; cv=fail; b=YKeO9XDC03cMwU0VtHjdoJ0LHXZ2U0rMlQ8BaO9g+Gz40VAMmQK7iFgSKfWtbiNECRgRWtjtVkxGf5R56Af/n5H+qzVEbdriAsmjwvItPjOYLRYzDJDkE5yY9EwOliMwZgwhsWhQNn69oOJnobXlMhRhuVBbmFqCD3zucS/aQjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744712605; c=relaxed/simple;
	bh=CiUigKLUR5dA28HmAW8KDVskfOhnsBKcOq5nPDSTpqo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cj/eeWTIphTODR/trAiIV/k39t9/2ljExO0PGZwtL7fhpYX5ZIeVnGT6FGFXM/tbq+j2ln/nIo4VGgJ1ZKUY3G2a3ZfYGXW3gQsfNhcNWSkPlcTkhHeUL8I7dooESPpdcjwDVPMdwFxoSf6I4SM5rG93srCNifEDnPr3UaQ+G0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JyVbp251; arc=fail smtp.client-ip=40.107.220.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nPKW3qQygH+XyVP71Tg2i4VgwpMVbh2WN0HAAklAXX5bWZiBh4QBYgGepzyV8Mez8An52O9ydo3+FxmnfO2H7eDdo1eS+n53Nv6qKyFnrYZkXo+0goCEoEaF/5hG/QjptFOa914qrr0RFX2FjmsTFsbmD0kJGI+5cOvhLH2aI9/i0J1kwyXLwJ3esGcQ/Sz7xS74HLwg0joQ3IW9M2G6r/qSxipDebvfEU1oYhuoHpaWRxfvG2aGY2i8dMPoieEgrY6zRCdGceZRDohQSKhwHJAgD4fgPIHk+U4nAW2f1nL8S/XFpLCQva7d9K9KElic0TqWm0AG3Lp+0QFApjs8Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+78M8Az/CtQlyiYQ2REetk2Z7HYJLbwdXuB8REv6LE=;
 b=PRzFHkbtU9NV0ZReZknA4onann1SvnfJuTvIHroQEbfr7ROujnZNbbQBlnzzRuYHt3Su7aE9MBqR6GCLduC5oa0tC9tMk5z1J4FR/4WOYAxK/MYliCbJ4Czn3M6yz03npaXjDB2y4FJDY+Sc5BdIdqV26pBiRGZSAwzu0DusRiMdnZA9mLwlNQ+mvekGg6YRaMWYxPMnOTjuw5opAisLTJ5aQQxG5QACfnU25tkBoudZapbKTOjit1UY2/J9/QQDyllGLk4BYFQtcG/ON4K52cIW61bRQsfZuI4SsFDZkD9IP2glB6oqO/shsIYNb3Qc8+BDGyvaq1QjzTPNf+s9SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+78M8Az/CtQlyiYQ2REetk2Z7HYJLbwdXuB8REv6LE=;
 b=JyVbp251S18sYmM4FLNGgKV4KwUP9Tags+RMRugRyV5vxCuHxUuyptlnUpv2yErRDrw3hwRiU8sKH6xeqVn1p54SU4L5aVNt9sKpUGSzdPnW834EE8566u+o7J3yAxeBHlU4lJLnxoIb1+jH+35mxWuOEbnbGJ0ZAxRXA4eJ7TY=
Received: from MN2PR05CA0056.namprd05.prod.outlook.com (2603:10b6:208:236::25)
 by DS0PR12MB9040.namprd12.prod.outlook.com (2603:10b6:8:f5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 10:23:20 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:208:236:cafe::d0) by MN2PR05CA0056.outlook.office365.com
 (2603:10b6:208:236::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.8 via Frontend Transport; Tue,
 15 Apr 2025 10:23:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 10:23:20 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 05:23:17 -0500
From: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <dhananjay.ugwekar@amd.com>
Subject: [PATCH 0/2] Add support for "Requested CPU Min Frequency" BIOS option
Date: Tue, 15 Apr 2025 10:21:17 +0000
Message-ID: <20250415102118.694999-1-dhananjay.ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|DS0PR12MB9040:EE_
X-MS-Office365-Filtering-Correlation-Id: 741c843c-67ea-4c25-d9b7-08dd7c078b91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D9FP/SzlIes9hu0MIulIDnawk/GxjXX/1mYJNXLmUK2HOgCjBhT9lckEmn+c?=
 =?us-ascii?Q?mzE0I/PZv0fplrfE1knzzs2WjRYcWZyIZddNUccLHFX2NlXdnU/gplE1uvuy?=
 =?us-ascii?Q?I1uAEOZmy98haRjEkcQKMe/vMlbGP3um9MC10P/5gfbmClicIHcTlF13UvpJ?=
 =?us-ascii?Q?hMo61bofV5Lqwo4GjUhT9S/wLLlf+SdRiuLkdGDlGsyqlvzrsE44oa4UwUtW?=
 =?us-ascii?Q?XqF/E51JElYNzwwUsm3OsnYaPWuD+Q16EMNXf/tJpGwfw0lvDrDmsF/hCZtd?=
 =?us-ascii?Q?110gEAt0UIwENVKNcoYlDTydVvPvJ5cjoBGw21NjPAu8psy6RJNCbDaXmEHf?=
 =?us-ascii?Q?9bIe8mP+hAOrWhBCJwFue/DSAP8a66FB8OgPOwkTCzOmAVxGK9LFZhNjMVLZ?=
 =?us-ascii?Q?cyVcIOxvQSRlb7x2jgxWjHnzqjCD70Shi/v44nkxPvekQrlTR5mzwiwMnYIq?=
 =?us-ascii?Q?5qHWq0u4+6iPE3cwmDqhvEUVPzk8i1Og2vKhEnnjap1Ebc9Aq+s/yGcG8TkG?=
 =?us-ascii?Q?P/t/8UxB2sw+KYUKhowhLdYDDuMDaWZ10qMJfyiCEcOMPk9CsDC9+jDCHe8h?=
 =?us-ascii?Q?gQ5eA4aZSxZXHpLFj5cv8p9i82r5d2I4dODA8iDr+v06MiyPCZufMUe6ogBj?=
 =?us-ascii?Q?TEl3/WEwwnFDp7yu/3ekSfuyscM8MxQLwsraEjpZxAmA8DAlt1E4x4LhaeSi?=
 =?us-ascii?Q?nEbBjvewTNOntMVtIAsodE0MkzJVNtDCoa4mZqG7HYtZrfpXKqiO6DWC5Rwc?=
 =?us-ascii?Q?NkvmJxFulrUIpg3Bqh2BGXIPf4Myzhgc/270OQasOhNA0pAliM/reFxz6u+r?=
 =?us-ascii?Q?jxEKPTeHTb3k25oWnoMeelh14g6xo/3Mjmh4upKHX4j2AmsGRLPmm3qKOrgU?=
 =?us-ascii?Q?e5iJk+gwJn41bdWYbjwddIjLT/DIwcmZjNEo1tbfb2oS37yBwvNBKTi2d8bt?=
 =?us-ascii?Q?Aaf0YW81CijX1xa5lUTTmxYy25vpZfB6oAB/eRRj8VockaOCTiMHxP7HPifC?=
 =?us-ascii?Q?9lTKrFlh67J7Y/xr4c7l/BOKWYDYak/r+nEh6UBeFWjg4YAfoyOmLJ3VT/xo?=
 =?us-ascii?Q?y0DgzAuRarVrG3DulVTk36H26BtnzZKT6XawRIo5IHlvUAR/sd4hRlQQ3qbR?=
 =?us-ascii?Q?O8PWRDZZWi9daDuVWTw2NcfUVO0wPD2YYh71vciPl0pPXkNDwSDD45ViVEwa?=
 =?us-ascii?Q?R0nXzorGfCaJ911VxquzIL/RyERQTy1UD2I0acbR7TgamonV5s8eZG5tJPea?=
 =?us-ascii?Q?U0M1c3CBRk/iMSrenuwV6J7mq+ruR9IYsKhSjV27T5yw4UE1P/iZJvzcRV7g?=
 =?us-ascii?Q?Y3faQAQPP4kGA6aMMSC12rZ3JyXJnmSWFtbJCgYCEiwl8EFEwFPjDiQpalo/?=
 =?us-ascii?Q?0V6GxM1ZEx8feNazhKQlcFLgbocyKJX/uIA9OS7ugtx5g6qhg8yOc57sqSGR?=
 =?us-ascii?Q?xOwYfZ0tgqufBGwPi8qjah26XC5fKIQqcXsQlUSQ8hgUg7GGNOOqn+S3rtD6?=
 =?us-ascii?Q?zc9aOMWH4V2fSgn1dxoLHkizxgz7XjmoOy9Y?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 10:23:20.4262
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 741c843c-67ea-4c25-d9b7-08dd7c078b91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9040

Zen 4 AMD EPYC systems and above have a "Requested CPU Min Frequency" 
BIOS option which allows the user to set an initial lower frequency 
limit. This limit can later be overridden by the user by writing to the
sysfs file "scaling_min_freq".

Initialize lower frequency limit to the "Requested CPU Min frequency" 
BIOS option (if it is set) value as part of the driver->init() 
callback. The BIOS specified value is passed as min_perf in the CPPC_REQ 
MSR. To ensure that we don't mistake a stale min_perf value in CPPC_REQ 
value as the "Requested CPU Min frequency" during a kexec wakeup, reset 
the CPPC_REQ.min_perf value back to the BIOS specified one in the offline,
exit and suspend callbacks. 

amd_pstate_target() and amd_pstate_epp_update_limit() which are invoked 
as part of the resume() and online() callbacks will take care of restoring
the CPPC_REQ back to the last sane values.

Dhananjay Ugwekar (2):
  cpufreq/amd-pstate: Add offline, online and suspend callbacks for
    amd_pstate_driver
  cpufreq/amd-pstate: Add support for the "Requested CPU Min frequency"
    BIOS option

 drivers/cpufreq/amd-pstate.c | 79 ++++++++++++++++++++++++++----------
 drivers/cpufreq/amd-pstate.h |  2 +
 2 files changed, 60 insertions(+), 21 deletions(-)

-- 
2.34.1


