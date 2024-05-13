Return-Path: <linux-pm+bounces-7752-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAB68C3A09
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 04:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15A872813FE
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 02:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE47E137932;
	Mon, 13 May 2024 02:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x825lKCO"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A568137915;
	Mon, 13 May 2024 02:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715566092; cv=fail; b=MVLGkEFTnB1iiYi3z0OyW5DhO/YIi04s7xy6k8CkPJrpQ0vyFAn5aREqnDIyIkVyCaLfJXQmvIj4G/Q4oIOCkzW1VOpeJ3VQbIdS21aY3AzDoST7mq1Lx79kqhG45LLlNLruWTYZ2ncplNrDD8YTraSEYdJKY5Pmb/B7w1eMKkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715566092; c=relaxed/simple;
	bh=cOXMENuVdaADztOx21wcB1GoqOtFGByhFz28UNsMN+E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T1flgnPDCIku8vgAmikHP89gjbi9kWQGRyNSxBnj/msmK7YP22gvtoldlPTKDEchtQA6BjmAj3M+qAIS4cM0pvqrUrXSxmSqFWENmLe0ul8LhqsxpZzVvjRWIz3SXUK1esbe02yslfw18bB5QR7yEDM/5+eeRTiDUORI/LCZUGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x825lKCO; arc=fail smtp.client-ip=40.107.237.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OewzRbC9iNcWXtNTp0FV7oUtKMB9/giuU9cCjLLNfhqylX8WGb7jjzml0EKYLQEFqoAGf+7XQWEjAxNoDkxV9BxyfvN7AmcvRgXP4ualqPtCYB0D24vrzJyaB8XQkqlepDA9NjvUjsaCAimDdOGV/0PL09v28FTGACyfAKx8U0lYyFeXFR2ztoh8JPkLumcZP4AH+DDsXiXltf3f3X5rr1+3ZWefWwXCrXtc40V6jG3czAB3KKb8kB/qEtDE4xDH5voto6oxaYUceZrjSCU5rHjL15CBo3/adlEcdNGtO5k1r/p9vhfZvgAfim7IMqFJrOEegoJPLuXAqb4BHh6ryQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOf+kiEqDJ4292Jkplvh6XWxS5iJPzeS85DFnIYQ+ac=;
 b=RtM8WwCQl6Qc2VkcN0rEpmxJL+6Z9/it/8+fClscaQ7Fb5AHmmqrHU/50JyXrfaSOyfu6wbBCRwX19J00x3LswlQpr0zHyZTip0S+I+Z5GkAcIadGSUpbB6jRAo92/TG98ykRmbpYV8LCYvJvCZcFSd2MJMyep54a7fKJhtxhaMSOx0rvMDyrkWVozz0Wt9qzc/Agr89xdYbI0E7ANj62BLAJO8jBbLOUjhMYhjmaNp+jbc1gElyyNTmgo5TtRuURGjsLTANAgEQCLD2S5u77AzpS7pooxsyMMcCIgxZ7Kr4fSXHaumqzJiqk3OiWqDJzZpMeqPSWg86BvXdB+bZrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOf+kiEqDJ4292Jkplvh6XWxS5iJPzeS85DFnIYQ+ac=;
 b=x825lKCOxy2tVHrhO/m3E4gJhN4CckDfIjwT1ODLAmCQ5TnbBCn4SzflyE359ZQmLAEZG7l83+BLAjYotJmAyCEk2XmWUFW3lDUrLCSn8Mis+OgCBH5ALxnqggOp0AylJxmD4QcrP7DbFa6xG6Z0nPR7OzPXN5jljbd+hWImlD4=
Received: from SJ0PR13CA0181.namprd13.prod.outlook.com (2603:10b6:a03:2c3::6)
 by BY5PR12MB4177.namprd12.prod.outlook.com (2603:10b6:a03:201::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 02:08:05 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::fe) by SJ0PR13CA0181.outlook.office365.com
 (2603:10b6:a03:2c3::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.22 via Frontend
 Transport; Mon, 13 May 2024 02:08:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 02:08:05 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 12 May 2024 21:08:00 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Mario.Limonciello@amd.com>, <gautham.shenoy@amd.com>,
	<Ray.Huang@amd.com>, <Borislav.Petkov@amd.com>
CC: <rafael.j.wysocki@intel.com>, <Alexander.Deucher@amd.com>,
	<Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 05/10] Documentation: PM: amd-pstate: add debugging section for driver loading failure
Date: Mon, 13 May 2024 10:07:23 +0800
Message-ID: <d18eb3b0574de5c93fde348bf14b6548282989c3.1715356532.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715356532.git.perry.yuan@amd.com>
References: <cover.1715356532.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|BY5PR12MB4177:EE_
X-MS-Office365-Filtering-Correlation-Id: 6840d32f-ac07-461a-0e9c-08dc72f186a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CHw3pZd6G7NMu8gvH5b8HXw3+AcyaUaq4/GC3+uUPv1iEHPDikgEPcWbjuKy?=
 =?us-ascii?Q?nkwsa13I9/lhThek8FRUIz2YrOquHEc0bQoYKTr9yRXKizt4AGRTir0UQf8y?=
 =?us-ascii?Q?qtoIicw0dYKVaOJGVGKh3oZJc3P4DhCl43sljdl5cnrjHgNGXk8GcHAiONU7?=
 =?us-ascii?Q?YGNRSGw975bY8SZwTC8NJ/wOFtyXAidi2YvctukBOw/4+C+OhtbRGLgZDqel?=
 =?us-ascii?Q?1YgFdewWVKiWbHZwUwBI38qD2fvi5LOfZN35YQdCCSPq+sbPoYL5juITRcte?=
 =?us-ascii?Q?7xvLwuGaGZ6DmuqScFyEZAN8IqMkReUK/B+J7VJz103goTtWx37jvYyPQBfT?=
 =?us-ascii?Q?inZUpLvVa20ZXVvSIFaxgdlnS1kP0aH8wmGvFk3WTA26FOZS8V6fNRdHABTP?=
 =?us-ascii?Q?Rr9bGby6bcRzT15YAThkEjWC63dVhgW0wgzueuQAHGIURAC0weD7A+l87eZG?=
 =?us-ascii?Q?I8CkX+7IrtaZrLZw71az6ROlaHuppfwZzNWPXrVUsqhVQYRwV47dt9j8iWB6?=
 =?us-ascii?Q?dyXTON6kUppwu6fcukaINyvJQal2q175sDJoEHkiP6bGtMGFFmpOEi1ABymD?=
 =?us-ascii?Q?CDJo01zlNnMD02+o4TM5F+uT+x7OFtjdi1IalHMSqfeDAtmWZKqjxtF2jAB+?=
 =?us-ascii?Q?tHBHpUmqWu+EMMUI5IBuAPt2nQUX8a5MFltJXoVI+OHIZGb6FwsdZMgBMYaw?=
 =?us-ascii?Q?ouTjv7XvbLObZ83mRvWGXBT1J43H+gPVkruXztsWXspK7ooCLoUFYGpxFoPn?=
 =?us-ascii?Q?OAgY+ct/nJVT0n2mUi+TQI4Au3gDUtOAleESaa8BmL9pHt9Jlv8ejzoRtA6B?=
 =?us-ascii?Q?x30TD6Hvl6y5cI7mdEIFtwUj+vTBSlmUbxp5g+Gs77ffM3RzUEkZ2I48mB9z?=
 =?us-ascii?Q?dXjn4ifYKfIrLQxE4hhjktn2mB7B8nbH4K7hPhsDtlPmYvRrLfznzMUdYcak?=
 =?us-ascii?Q?EXTmPFESE3cZA2kZWF6qDqwDsUA1S0IDDCWITa6rNNYuTfzlS5mMaySEPG04?=
 =?us-ascii?Q?VWxijrEI569DDG3U2h/LkXCnYOFUTuOx+bXPowoLX0yDJseWFreGLttUv90q?=
 =?us-ascii?Q?Z0lkocbPbhkCdGDJ5eIfdiGoASZXYjfHrexv39bAxLUymV2QCDeZ8XxAwcM/?=
 =?us-ascii?Q?knrhIRo4Ku/TrRSS/PwLqFZZPGcxZ3oWH8SRuxVa3BJA/Ps5aDJkpcTB0UB7?=
 =?us-ascii?Q?KuKomLwwBfSkDyzD7YqN37Og6gxX+pqcGfML1U4qy5H0w+i1RNG9ZvgiZ8wt?=
 =?us-ascii?Q?1XHMpehxAnNJeoBmGqj0LW1vT/wLEeNtgzRGU42J58D2jA+LshDq8dl8Uk63?=
 =?us-ascii?Q?jrrd6yglCgEiapEkWaFEVDEM99dlO5DEgPtSbaDt5kSalKlTLu6jQJ62KJ+j?=
 =?us-ascii?Q?aORecKqZZ1XekkT8dNTCQ0oFONEo?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 02:08:05.0519
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6840d32f-ac07-461a-0e9c-08dc72f186a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4177

To address issues with the loading of the amd-pstate driver on certain platforms,
It needs to enable dynamic debugging to capture debug messages during the driver
loading process. By adding "amd_pstate.dyndbg=+p cppc_acpi.dyndbg=+p  loglevel=4 debug
amd_pstate=active" to the kernel command line, driver debug logging is enabled.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 1e0d101b020a..de83e742738e 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -472,6 +472,19 @@ operations for the new ``amd-pstate`` module with this tool. ::
 Diagnostics and Tuning
 =======================
 
+Debugging AMD P-State Driver Loading Issues
+------------------------------------------
+
+On some platforms, there may be issues with the loading of the amd-pstate driver.
+To capture debug messages for issue analysis, users can add below parameter,
+"amd_pstate.dyndbg=+p cppc_acpi.dyndbg=+p debug"
+to the kernel command line. This will enable dynamic debugging and allow better
+analysis and troubleshooting of the driver loading process.
+
+Please note that adding this parameter will only enable debug logging during the
+driver loading phase and may affect system behavior. Use this option with caution
+and only for debugging purposes.
+
 Trace Events
 --------------
 
-- 
2.34.1


