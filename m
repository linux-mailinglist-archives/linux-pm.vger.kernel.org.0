Return-Path: <linux-pm+bounces-26313-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BEAA9E827
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 08:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7BDC1896F2D
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 06:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4025D1B2186;
	Mon, 28 Apr 2025 06:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XcAL/vSe"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD271C5D4E;
	Mon, 28 Apr 2025 06:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745821574; cv=fail; b=G4PPYLTBJ0iCWgUBjxLC0+mZuEovqqDoGa1ftfuBQ/B683SE5Ye0p2Y7+DfCEuvr9J29VdzaAWPKRBRV9kYMM06ZZnPYokaUedGB/iwt+cFMhaVvD1ko7njJEFCyBYFWnwXAZVK8pLCrzCsBTdXz2MipscP2V63KZnv6llxijCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745821574; c=relaxed/simple;
	bh=eiDq/ImKKkQUxD0ouZF+1kP8Ugg/tOjtqzEF36wFokw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nr5ppjISarbhNsMpwmnkR48gqfT0GB55Yhh1m+HwhW1rsxNCl5IosqHf8jX3+xjkNpCrGn8IJiQqazdPPyPmaZwNTw6KVzuSuBULX5oLxiNxkNhp1CWfN2FU+V/V3TeSgsI9MvQIJmzPTN4329RoVQ0YuTxkB+uX6RlEoWBJm4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XcAL/vSe; arc=fail smtp.client-ip=40.107.236.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ky/eDI/EcBtlbOLcs4g/sOPvfb4PNqZbiMglAwrWWeoAdaXE/PURbdj+7PGWTkZJvhN4I3JkMUwZW34PDjLU4YLsaDQkg29tmXadUegqLf73fedzvcZ9D8DarAzHc2BdD8AQqrcwxitcJcv9lmI5KlgXcofgle1vHU19VT2oDc2Y0iDnHEtU5WQ9nQFm2FF8boL7UxsK1tOrg/qTqUybgzFZc3DdDb9u0Th2M2iRvcnlT+/XRO9LoRCTBjLOGwohUVtwz4uUDa2++ZgDFpPyUpVmvMbRHuV5r/OtKqexglD4IVJpL7BgupBtaudTezqXUgY8ROyJdFxJp2tHhE+K3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MsaMfpomG9B/kltif8nVO/CU5dVMcdDx1fPi2S6u6EI=;
 b=BRHXVno3xVwngjRzY0HDo+HFQ324K3MiE6Mb0OdFsauaSr5s7hzM0rowNFJPpivt9Urxb6GEr8C3ePVlGLUpUT/foRWOcRWx36w2Gr4keKB4qeB8DaWKqAv68vPEDuTEs1XbiGcpHNloom8MF7UAjyy6yKlHJbcpgWfNIyaqgtJqqbhmla+GJZg6A9s3/pOicCqbiioSX7T/cDQ63O1vrWX+jbxt7RbAifXdbOU0Dht1CZTZVUmwr2C9GwmiOUrhxIHy3CyKeYMCdquNsUt4ZwkHEC+vdtV3eh3zI6wiQhpE6lezpY2vB4GEI/EDNVfQk5FDYzBCIA5PLSfANMmnrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsaMfpomG9B/kltif8nVO/CU5dVMcdDx1fPi2S6u6EI=;
 b=XcAL/vSeqDxabzdHB1L6Pwp6PdD0ytTYv0bt80UpMMNBkw9axMhtXQXdvva8hGI5crvTWHKDdX5fhlzreEbcVFkzPY13W9/OcpgOSB5bm6BqEkyJYCSh8nFJgKTelYaNhPR9x4rXwpjzfkib9MEKtfXfcihAWXMYTb75tZ3u6F8=
Received: from DM6PR08CA0052.namprd08.prod.outlook.com (2603:10b6:5:1e0::26)
 by DS7PR12MB8275.namprd12.prod.outlook.com (2603:10b6:8:ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 06:26:07 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:1e0:cafe::18) by DM6PR08CA0052.outlook.office365.com
 (2603:10b6:5:1e0::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Mon,
 28 Apr 2025 06:26:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 06:26:07 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 01:26:03 -0500
From: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <dhananjay.ugwekar@amd.com>
Subject: [PATCH v3 0/2] Add support for "Requested CPU Min Frequency" BIOS option
Date: Mon, 28 Apr 2025 06:25:19 +0000
Message-ID: <20250428062520.4997-1-dhananjay.ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|DS7PR12MB8275:EE_
X-MS-Office365-Filtering-Correlation-Id: 11c47da9-24c4-47a0-65a5-08dd861d8f7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?usyfFyZ3A1jqPS4WJoT1foA1gwYF8T4ZHldNmuLg9ZR/jkT4Wf6RW66dOnY8?=
 =?us-ascii?Q?vzmjoJ4YRxonH3/8FENu6rg1aMcAoB8jX8GLIeQpk1/CbYXOy+cBfH0fwa+1?=
 =?us-ascii?Q?D//ObOs+A+DVSk3YpsTzLUnF5BPpO8CbpPw8gHoa1C5lhrdTa9QsWZqXAMKm?=
 =?us-ascii?Q?JLdy/LzpOzbu4Mh9Lo/BWKihK8Kfo6xXB5RI4fF8JH3lSwyfRzM5uGf10VZe?=
 =?us-ascii?Q?43mD63TCollHpL00bY+3cxTKKiROJj97R9amUvlcfuyMic4oVRdR4YJmLyKW?=
 =?us-ascii?Q?I4D7nw39aSWvjGOFXVteLcWBE7Zk+LMSLCgHfYgnRlIuzlJQb/bzPy3HdvkM?=
 =?us-ascii?Q?vX/PzsQQ82Y7wY/wVwW3AOdRTkK1uETBSFmdngO0KuWRRq0qdRDakgRnL0tn?=
 =?us-ascii?Q?xFycQGKiqHwZPbfEYN/py0bRn43LzpE4SFANlwwH5sPWAug3PwZqQLJXE0hX?=
 =?us-ascii?Q?7z9uO67dikgiyU65eqq33rJQAchkAiB3+gJzqpdwZCHeBHrYI9aO1ya9ZemZ?=
 =?us-ascii?Q?2hQeAckVG2FK8pqEco5e6ZnbJWR5AigicAjOivOEcMVBvgJPTTao4LPvd8C/?=
 =?us-ascii?Q?RjWJDKA2cq5LPyn0X0jI7vk5AyrdgTL/xXBJxsHE+Ctd/rGcgP6hlJ3zec9L?=
 =?us-ascii?Q?qzfTkDuiDoiWA3+EVlOn6MOfmt6rHNDxgF0RZ0zJ3C5lqvtG5fzFVQcTDJ7J?=
 =?us-ascii?Q?B9j4tDt6zYEuWec5gNM3lk8/SZpD9ZQe8ReL0Pl0DF+a1PDwZfqEqnIEor6m?=
 =?us-ascii?Q?0xs1CnNMfl5o043DgZswZwjhtidgpXKOm+T4KsNIYywf6ChQWPjKzA1Eyxq2?=
 =?us-ascii?Q?Gmuyw7LzOpqPDrd/xkPLKtj7BIhvcIRpzzsMSuXqQOkxVE3fQlKR+j66gPiO?=
 =?us-ascii?Q?+ZM+fimRtH5hC6tHdVXvqY98LBMUkwDgvTBc9MLmHn1LrL76TykvYlRQ5aYp?=
 =?us-ascii?Q?256ypuN6pHkJiep4qCDcAzOhulBILFqOnX/hN8gW9eDpfRTOomtAALT78+CN?=
 =?us-ascii?Q?yvVyZTThjRRN+qV3SkfLrZFIakz2vUu5V/cxX2M3TkAj8hAQSZzgZRhUObbs?=
 =?us-ascii?Q?x3vegTYkB44Yp4l4EiqasrHEW/Sb+1t9oqz9C3Qm8qXM2BY6VheyQ8Y3WunQ?=
 =?us-ascii?Q?D5xFMamdHMS7emGoD47czHV7hs7AMiuIZSWRc4tVen+r5K9rD9zVns/op8Nm?=
 =?us-ascii?Q?PFA+urA6aIy+3jqjY4UXTpLPqczjLAC8q+lo279SaPsq0pGHDcyYGhPMIKpW?=
 =?us-ascii?Q?+Nb1XA8NdO96/fsHEw1gKYroRG5fh+T4M0/DlZcTQ4CjTCtO04XuOrJUIWVM?=
 =?us-ascii?Q?EQk1UyIZoMk6yBCR9LdvhcQJ30Fff9dSsmmBkeR0yxpUIjNALDfQSjrGAC1E?=
 =?us-ascii?Q?yoSImxrerN79E+42xhLrFSViwGxLMnAwc283Ggylk/cBq6uhgnXZSgGur/ng?=
 =?us-ascii?Q?GxBfTRtlTzCU1I2ckbJeWEDc1eUubxm80KJNPT53v9eXwQPqhHTn8COXmHOW?=
 =?us-ascii?Q?0NXOWh6HvwZIA0mNy0FpYGRfEUVIewY75vPH?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 06:26:07.5178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c47da9-24c4-47a0-65a5-08dd861d8f7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8275

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
the CPPC_REQ back to the correct values.

Dhananjay Ugwekar (2):
  cpufreq/amd-pstate: Add offline, online and suspend callbacks for
    amd_pstate_driver
  cpufreq/amd-pstate: Add support for the "Requested CPU Min frequency"
    BIOS option

 drivers/cpufreq/amd-pstate.c | 99 ++++++++++++++++++++++++++++--------
 drivers/cpufreq/amd-pstate.h |  2 +
 2 files changed, 80 insertions(+), 21 deletions(-)

-- 
2.34.1


