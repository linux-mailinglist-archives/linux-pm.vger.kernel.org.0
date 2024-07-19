Return-Path: <linux-pm+bounces-11247-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E999375AA
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2024 11:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DF481C21016
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2024 09:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2A780623;
	Fri, 19 Jul 2024 09:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JHtrNbrQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD0255769;
	Fri, 19 Jul 2024 09:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721381176; cv=fail; b=enwo1rH0QIlQX2353KL2Ioa/iaACZQsuv1TCWnCx39b/fAy5PnTNJt6DYozhHmHE8i/lDOcJkuwrofHxlZO8pikvlxiuDePDtBwd3eU/dSzEx1cBLrQryxVGWDAoDT6MHdXlz7M21u55KE2J5XOikOzlJRo2l+2Bo9fi0Q6LZsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721381176; c=relaxed/simple;
	bh=hciLWOOpd5RMF/HE67Yp3F3u9jpq3LupezYvVI6eWYo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gpQYG9ugEcr7dLyK5A4aPI6U5GiIHhjIi1Xhjojd/k97g22tYeeIsc9JgMuFEDRqdJ1rt60tQoxv9STlH42hcPbLF8P5LpToC5eE2ZbzQ8085b/H/C7ZFJ90JK1n6BzVjYqAtQUk8zgy3i2glmMQPGmg6x5lo23q7YkUScZU39g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JHtrNbrQ; arc=fail smtp.client-ip=40.107.243.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qd/r6ItOwaerbo3wY95mxyQhBsXFPyXSaqllZr7/RhpFKOwy43XxTpqBNfWTOHgtjT0FeDmb78GJVQUG5m+Ngk3kWyCJ3tfHVOe/KTJRjD9iesOnwc1b22PoF1CLDetJlqRppWINPjqusCHSlxCBm+vmxommqcc1dfUHBnGDJNDt49otXR/2IRCJxv9yaBx8XAOqqEXC6Qn+LKkKslmCrKSvtjD9puhJ/yuwpOHMiZR0ReNnXmoaRs13MvSXYwBjIjf/Hpz1lwSiZKc4nq57j8wMvMw7sMqEOlMtdOaGL2E0HmTXo5cfWk9utkfb1AczTdI/j0mzvH1WaPI4+GaU7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YeKfsERsIjo8vat7suiKIUP+xi5eRNtM6YOkZF7tVOw=;
 b=O3BmJhedelEKFSSFfeLoU9w5PMfHO3XEV6K71M7SbzhtjFZDWWEePYipgGysG7KhZXax+0kBi6FOLCWiejejPy6GmtW+HDEAGALOu5BE0ZjXLBBw/1mERlFH8EhSWQIWABtMhzOrlCLdyXw6guPmRihhnogtvJW5yPcvwSMZkZSO09dbl39CQvHq0Xo6y++TKyew5ijOUExU+AwYpJpWjpzzjpuPJtNSIC9d9FXGF/2hz5CiOUlnBawM9VUqRaqB0UrYGoj1EgwsbqVqa1lvAspsbSJo2wXAunlJXkxB/Pt3YkQaXMPiGtlXPKsuRQsZU3I1UV44CmfAzTLfcXC1bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YeKfsERsIjo8vat7suiKIUP+xi5eRNtM6YOkZF7tVOw=;
 b=JHtrNbrQ6U8sonxpU4dhO9Kuq292u6Eh3gkEdfGiW20bpddQEB/SqsQOHrmq6LGzXZF5XHx436L9147ObY3G19NcRY+Hl8OB6WkQsoS4FwDAQj30dlov21GV5C8Kzo1ulVXrLHTRaBuC1/HuZxWlTet5ub/0dec+mFHHCWBDNUA=
Received: from SN7PR04CA0109.namprd04.prod.outlook.com (2603:10b6:806:122::24)
 by SN7PR12MB6864.namprd12.prod.outlook.com (2603:10b6:806:263::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Fri, 19 Jul
 2024 09:26:12 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:122:cafe::e8) by SN7PR04CA0109.outlook.office365.com
 (2603:10b6:806:122::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16 via Frontend
 Transport; Fri, 19 Jul 2024 09:26:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Fri, 19 Jul 2024 09:26:11 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 19 Jul
 2024 04:26:05 -0500
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
	<sandipan.das@amd.com>, <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH 0/2] RAPL driver fixes for AMD CPUs
Date: Fri, 19 Jul 2024 09:25:44 +0000
Message-ID: <20240719092545.50441-1-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|SN7PR12MB6864:EE_
X-MS-Office365-Filtering-Correlation-Id: dcbc4f79-cddf-4196-44a4-08dca7d4d485
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hKQcbCW6TxXSVRiXlZTRMNV/w5d7MZoxa7ETIVKu+CuhLtQ5ShIYgun6raqI?=
 =?us-ascii?Q?rmswSGXLrPb0xsibqsgGXv3pgCjHUUiZgdzd+mbzsZNlKItt2RxdabwnCSZx?=
 =?us-ascii?Q?8bj8vewxUp2vqa96qZSpONSgToxOw3gZGFiw6w9uFs+0SzZchw4RII1zkYd2?=
 =?us-ascii?Q?5XmqPlRjlXfwbLgojE4xQ5DWRX9OWgURhGXuKwwJqA/pT1hCK7I9D3iS/Ygd?=
 =?us-ascii?Q?AnMzFINM2gYyzsszJPu/6iy9fDKCYRzHW4JsBOJjGjggblYpW06FeNLuzSj4?=
 =?us-ascii?Q?KTJrX7vem4cOf4jA8jAyc/EnKl875F2zBOBqG4O3QzAbuVh2oX2VNIbOGDxB?=
 =?us-ascii?Q?i/bB2dnwGTl0sHQV7BtyguZjOIN0hKZlSXBG/dVw5JRZHgxAOFykIv+qm07I?=
 =?us-ascii?Q?f2Hw8HbogTpY9vyrbxf2jei4WAYV5WQQgvXucGazcENQR77AxsDrMFvp8Ial?=
 =?us-ascii?Q?9L8wDg0DUeUGe+3zaxiogAFRtBxIZzcVNMeMDmwSqiK77GXL7VZW8ugNFm1h?=
 =?us-ascii?Q?2ozCC2tBh3vUZsqd51gXwQzNjQI62zxJRuQ0870RctoyQUcI9hzPyXNQxlmf?=
 =?us-ascii?Q?hYzBbp1eoyDmeTbJr5MzTedU+thbqolX7OSwaA9Jyqu4K5P4DOoPjrJDrCTw?=
 =?us-ascii?Q?4sYc4AWMqjELxDXu2s9dh3pxw7G39RDGCZ9ISYAzOfr/R+P0m12+DZgjYbRo?=
 =?us-ascii?Q?KPq8Z7tYZrINYAE3CtvHs+zf2bsmnDDgb2smnNXxs2pS5U+tCkev3mdgyDjJ?=
 =?us-ascii?Q?RCSFlxxPCm5TpYG9VniX2alKSCkql8yKxSDT4ORolBtcBdAQJlfBUigEBFlB?=
 =?us-ascii?Q?HNlqABBLjpyPrxBO/SDKzyxugK3ZxTCNjmArSIIngpz7BAbA6IjduHW9JPJw?=
 =?us-ascii?Q?it7/AQ99xXYwpHNhYdhHzltSlnfSkRWRy/YHbeb+xOnttpHXxI47qKUuefaH?=
 =?us-ascii?Q?BeYuMHL471GDGVRZrbx0n8iyiqm7YklPQA+BEzmNYeGs58kSAR1was9A48GN?=
 =?us-ascii?Q?v8nzW3r3xmB4vVXVdmYCzMEcH07HM9lgtpOejfP5ay7mx48dFyZNqpol+pkJ?=
 =?us-ascii?Q?2DrgHBuG0hTtWl85uhnozDIOuRX+5OsL7Dm6eosvG7nhsOb4hDZIv8wsty/6?=
 =?us-ascii?Q?p0zhIsYyozFsA4ZfD9IhkVwBSmRiMaGJBDOKwpJHtfdgVoLGYGAzq0tBVEAT?=
 =?us-ascii?Q?tqlSVlKPmT0TL2pJ9jXXLg1/U8tm0OEcvlD64YPJfSwwb4qx9+aRS0kVLVYS?=
 =?us-ascii?Q?ic5Jx3eqN4FTj+vJjUGweM5KLX1473/xAcavOl6lvahZxxkeVSZCmZ+RBmD2?=
 =?us-ascii?Q?E7HhwlREu9GXAuviw4LVAUScTAp7dvx8diWu7rkyxhnPtoPo/8smDzxY4J9l?=
 =?us-ascii?Q?V43tDpJh4fPwg49l8Rmov2JYieTXIQGZpzvv+f/UFAsMA74wHlwgYl8HvU9v?=
 =?us-ascii?Q?eaaDxsxMWc9hiUznMgCwv4X0mVCtYMR8Yq3SE3sa71Q37rzWxNtS5w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 09:26:11.9239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcbc4f79-cddf-4196-44a4-08dca7d4d485
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6864

After commit ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf"),
AMD CPUs with 0x80000026 leaf have become CCD(Core Complex Die)-aware and 
this CCD info is reported by the _die_ macros, which earlier used to return 
package info.

e.g: Earlier topology_logical_die_id() and topology_logical_package_id()
used to return the same value for all the CPUs even on a multi-die/multi-CCD
system. But after the above mentioned commit, topology_logical_die_id() 
returns the CCD id and topology_logical_package_id() returns the 
package/socket id.

Hence, the RAPL energy-pkg event which uses _die_ macros has to be
fixed, in light of above change.

Dhananjay Ugwekar (2):
  perf/x86/rapl: Fix the energy-pkg event for AMD CPUs
  powercap/intel_rapl: Fix the energy-pkg event for AMD CPUs

 arch/x86/events/rapl.c               | 44 ++++++++++++++++++++++++----
 drivers/powercap/intel_rapl_common.c | 20 +++++++++++--
 2 files changed, 56 insertions(+), 8 deletions(-)

-- 
2.34.1


