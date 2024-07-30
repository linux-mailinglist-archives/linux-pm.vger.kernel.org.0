Return-Path: <linux-pm+bounces-11618-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8789406A2
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 06:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A9741F231CD
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 04:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3017F15699D;
	Tue, 30 Jul 2024 04:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="alzJ4JEs"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3010D13B780;
	Tue, 30 Jul 2024 04:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722314993; cv=fail; b=CltWFQkxbUcfiwRZ62+lAKewpUE4F3iiZ2HwZlozm4/yKctq6Rq40BS+Vno5u4r9JiSAdeHxMfg6UWMsy6q/721yoreZFK7QaGG9l88qmYMRmjlgPi9uwYYadkKokebhw8goAaJAmqBma8lVOhTmjxcbp53Q6J6ZCt0g7r2TlN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722314993; c=relaxed/simple;
	bh=7RkuOCDkHF5CzBCpBigLFwDHfCNsccb3Yc1Ahi2g6Bc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SGAMycM2NHwHnCFk8hA3Eu+z4BcxE+CfAJwSkL7A3S04xB4RTH9fJPvWEJAZt0VQC7s68xQ/tN6iE1zgkV56J18PTLVO9jKhiDuBEu0VEMXuY1yLCEyrypx1S2/gOAmX8mXRz1nmS/T/kYJdBatf/WruzI5jscmoVm4mtegWV50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=alzJ4JEs; arc=fail smtp.client-ip=40.107.92.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tXbAC7+3FpEVdV+Dg1feHHgFCN4vJXQA7rzoDrN09rvy4qa5XgHZyZmZegT4Kb6cn1JOedAmldynb9UxcT+cByDIJva2Qkjx1VI+RjKMkIQN4YghFIwAJ+1HiDL5TUzmcdpqyu4msIBd07WQZF0yrol7HAIpqXqdViJ1sbeecTUWG3s7mMqGz+IXhjmpEFjdK3GrRSNT9DPzPInxDYFu8O+6BMt25L5Jo4Y4BCQ+XMJ8WF5hONBkmx1iyugOkDF9qr+1e4T/HlFLOK1ND9Fp3FEZ1Cvmyda1tSSMMBK+gxZ3r/8P15buL4qDKBHehjYspjtA6YT0PQpyKkyGj5siRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ceyso0uN0yb7gyCwrWxYG6jfEZdqMPIuKb1h5km+VX0=;
 b=Fg8wRd7ciMau3RkoD32B3vgRUue+WsvZialUgG+OZKG6DbQWuE48MVug0ojVf5O7ihElgbnEkq1QqsTu+xuGkm93t9f3YZlXjftgTfi382tQCYlpQef2Ogia/jzZ7i02h2eowGxd8QrJSiz46Z4mvMiifoHgFfJLf1GChaa/Xj3GZJ43E6zJefiO0Kqs1MPFeXuStMay0+BILEW15rvPwAT4KxOlHIUGUJsoCxBr1HUBu4jAzIkCrDFUz11PlOuXk1LBGK7S+gVhPXsoXHZbpnx3o72ZFWsDnKRWyFw31NRZu3vOdtznV4ot2sSERPKBIGnAPDNgNoGg9VOX8GTgTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ceyso0uN0yb7gyCwrWxYG6jfEZdqMPIuKb1h5km+VX0=;
 b=alzJ4JEs2U6tZ4nG2Sn9LkvdBx+VVMHPmpRz+GDzMFbKh0U6vT0sSRNSbU7fUVlKFvHZ6+74BhgahW9ZevCE8QgVLHhn6G025s5aNDOZws1AT60YZQo9FgpFE7SvxxJ3YfILund0fMizxNBw3WMAWYNDa8i/OtW8dYsNrzQhpPs=
Received: from BYAPR08CA0037.namprd08.prod.outlook.com (2603:10b6:a03:117::14)
 by SJ2PR12MB9006.namprd12.prod.outlook.com (2603:10b6:a03:540::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 04:49:47 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::50) by BYAPR08CA0037.outlook.office365.com
 (2603:10b6:a03:117::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Tue, 30 Jul 2024 04:49:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 04:49:45 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 29 Jul
 2024 23:49:37 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<tglx@linutronix.de>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <rui.zhang@intel.com>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <ananth.narayan@amd.com>,
	<gautham.shenoy@amd.com>, <kprateek.nayak@amd.com>, <ravi.bangoria@amd.com>,
	<Dhananjay.Ugwekar@amd.com>
Subject: [PATCH v2 0/2] RAPL driver fixes for AMD CPUs
Date: Tue, 30 Jul 2024 04:49:16 +0000
Message-ID: <20240730044917.4680-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|SJ2PR12MB9006:EE_
X-MS-Office365-Filtering-Correlation-Id: 298dc401-25cb-4478-f062-08dcb05308e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mKm+zaabIyh7Yf7YIeLTru1vsSHpcciJHVvizogexQ9IBnbIVP2G/FR1rh4Q?=
 =?us-ascii?Q?YO3CSZxrXha61/+J7Fj1zg/Ikl6aAcRuo7XlQeyebhQ9IIqEMjO7Rb3YljcC?=
 =?us-ascii?Q?HGI+0zrMhw70svGk34G9PV2ppakDiPUVM+iPsOvqdGndefUB1CJ6d1vDT9RB?=
 =?us-ascii?Q?4HDsv5zXPnk86KDLygMbKFevRhXuDGjkAG32LSJVntPnpby76Xyya1CL5gb9?=
 =?us-ascii?Q?QWeE3g5Hwu1TZE5apPfevtKCcIADJiXi00aooar5YAC2HmwMSdSjY3ywI+R4?=
 =?us-ascii?Q?UWCovAmmUHlYxn49kCynXUoMIEWRDyC3oU35nFBiQHb3ORWKIY3uKXMQ/H8W?=
 =?us-ascii?Q?lT0xhJBY6y5EOVkMHtAzAEWQvEdQNP2XgAgh/PAbAjqHkdE5wA3PDvj5qi7B?=
 =?us-ascii?Q?Tc5qdMaxzk+7ZJ7I7F80/PI205gC7pB1/kYoyoPmRVT1JP5hswlEr+TznJxe?=
 =?us-ascii?Q?toO/lDLuE1meEr8WtJIg1A+A02dr+toC4/YWw7E5WNMVUbz8e8rH6cSfgJw7?=
 =?us-ascii?Q?lgkHVzxhefA3PxVHjc1IdiIXi+mJV5xmuQQ5BNppebNJqIL7uuu2Pvkcl/o8?=
 =?us-ascii?Q?5WSm0ay6poLv/2I9gDFhJIoWubVfiPSCDOKAxAlHNPVwRHW9Ef/hR5MzKXCF?=
 =?us-ascii?Q?pD6aEBWOE4r93/KA90B6YxZwmDaStFlN1sMWi+8zo52KAyy+BlpBfvyY4Lcu?=
 =?us-ascii?Q?fasDrNVnsVQvgm1wHmKRP81IApydxeJOSdo3fLkuh85sYPGwxltv1Jx6Rp47?=
 =?us-ascii?Q?4FUefm6NQYZOJY4WXcgKGqzgX/pIVGNlVGLGPJFKNNhgur96YO+MnqT7+/Eo?=
 =?us-ascii?Q?r1d/BPntZwlBJ3j0AHXNxLeUgKELNFjJ6rcYZ2CskRLzwXCqWJdDHcDYlG9C?=
 =?us-ascii?Q?Jj3kX+Ay067nApMLKUvUEvXRuI3K1RdsekGq8oOcg0plJG0fu8sLT7ocY641?=
 =?us-ascii?Q?XNWqFckNjMYw1HY308nsyGXJq8vTRzlBAc4NFgYX3QB70lZgsCxwhbmUEsTZ?=
 =?us-ascii?Q?l62vhMsID/qapUtVMMOzUQOD3EQ8iS8UZAxXMqhF7Kyi74g2aEkQB9AKweVM?=
 =?us-ascii?Q?6NdzwtIpu5WB+dfnlkBW1ChjDa5A6f+EfuFvaBHUFX3i2xBEuqOJgf3h985V?=
 =?us-ascii?Q?hMIvdksnDnTXZqQC+QuFuUt6pAYZtCQ7/mwe9vdcIkTpHE2J0muU0/LFfBPz?=
 =?us-ascii?Q?KsOQwPDuAVn5BQkmgStU0JHJc7z7gtoU7FPeXR+JeCx5LCikbY4oT5fBvW/Y?=
 =?us-ascii?Q?zOrDYhVjfjofT21zTt1bK9lgqc+ClVvePscPxLq+kVviLStM9cHmlyJ/IFrl?=
 =?us-ascii?Q?ohjGtaJF3FhF4aTMf++kbPc0rcCoznVW0qFRSk+ziP4RWCunKVVD+relcFhj?=
 =?us-ascii?Q?6x8aVOcikY6Sb6xsslMwGuvudkvnP4CAdh6erWjOJURNVHa2PlKOSOloJxmo?=
 =?us-ascii?Q?v9/y1dYGjK8pH0LinGyceS2esEhgISXzHvgl/II7avoH5QMDKFwdOw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 04:49:45.5938
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 298dc401-25cb-4478-f062-08dcb05308e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9006

After commit ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf"),
AMD CPUs with 0x80000026 leaf have become CCD(Core Complex Die)-aware and 
this CCD info is reported by the _die_ macros, which earlier used to return
package info.

e.g: Earlier topology_logical_die_id() and topology_logical_package_id()
used to return the same value for all the CPUs even on a multi-die/
multi-CCD system. But after the above mentioned commit, 
topology_logical_die_id() returns the CCD id and 
topology_logical_package_id() returns the package/socket id.

Hence, the RAPL energy-pkg event which uses _die_ macros has to be
fixed, in light of above change.

Dhananjay Ugwekar (2):
  perf/x86/rapl: Fix the energy-pkg event for AMD CPUs
  powercap/intel_rapl: Fix the energy-pkg event for AMD CPUs

 arch/x86/events/rapl.c               | 47 +++++++++++++++++++++++++---
 drivers/powercap/intel_rapl_common.c | 34 +++++++++++++++++---
 2 files changed, 72 insertions(+), 9 deletions(-)

-- 
2.43.0


