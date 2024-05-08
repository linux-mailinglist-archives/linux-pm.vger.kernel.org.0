Return-Path: <linux-pm+bounces-7632-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B40B88BF6F4
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 09:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434EB1F214A1
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 07:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A7C3F9C3;
	Wed,  8 May 2024 07:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0FQJONlh"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B773EA9C;
	Wed,  8 May 2024 07:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715152910; cv=fail; b=Sb1IZD4BX+2SptNjhdquORKmHG7x4xLAALA/EB8IZPoZaUpx1PROe7aA/G9l4gl7ILlZwwh4yI3UDsH4jG36GB0vGQyN04Gy/ew2k0GQh4nGg16eHy+cjAUFvNtLzCdY1nqu8lncd6RpP72CwC3yHQznj4VLcbu1PwLjHYMqsOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715152910; c=relaxed/simple;
	bh=C4p2sKZdGRylYCgyqAJR+AyPOjBO2/pXljtXbG+zUuE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c53lmylxCmjC8eeCkL427tBm12gchFzilquFczTzuB0Y8sIKcAImjQbLb26a70ddOB4X9il/k23Wbg8eYl3L12MsdsgWXFI6oNE435IDtVbrK2VrpnwPr6ci5QzVDvZpG2NxU8uZ73BQcsP4go+cYpTZrYZAzR6E52gJX1ceEmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0FQJONlh; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDQKRWfxBg6iFQhGny1t/o25JF1M+ldlEK53rqIl4OZZRIOkLhKY+aLs3opKSqhDhGvueOORFZzd3AEsSbdjUk7nhLCltt0xA4pmoLU5Na8vIyyyYqmUgBidd1WNDQThlKxNhEQ6Sn2tIuc0QfP+nllQ3bJq5T+7QzBFJ7fdurvhXo+c8HPy0iTqCaIZPP0CUMAQZfhvfoCc3ejX/UYhi2yVpXTLwfhx88PFRICFLPbigmHq/QoaASb9zrehNpIIyhJrRhsyf11KSwwAZ0YXyz5lKnRGijHSHybxFZaFIEUAQIBI3iy/rJSlLA+flQ+yobIJ/WtDMA/TZG0ygs4FjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqzLW2F6MFLyBn7JQVf8j5zr1FG2UBh8bVqCrKBuyes=;
 b=B6kM0giNWH9MFHvQn+6Ul1Tf+lZEonlfBZxBYy0NeaaJGM0BDENMxa8BIr3aYILxeniB48YUOIXKmM2ZH5SdODIaOwzDqbhxJc46P6AIb4jYMBiGeMaragJEkpQ9hv9wRUnnwePeQ/LQzwfbKE3T0rPLQcKs99oGjpgmEM59A4uFA/SOy8RJv2JUXrE1rNYTf/ZpIl/4rjkXmpE/2nxpZ+MIPkGReWoJgfdnjqaazukbc48lQY7HNohBpldiOZC+yzvX7RVZrPSxjhNB33AQIHJGcoqN+kbpMKnk4hNJa9aEGwY44/cqwaMVuqAkfHGysL3NMwS6brtlYLPmeRcEAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqzLW2F6MFLyBn7JQVf8j5zr1FG2UBh8bVqCrKBuyes=;
 b=0FQJONlhXo4W3Fvr4sAwjplRBpO47rCfDc5WmaiqR7bALPnjcOTn9fo7VpCgPJjGW7q91G7n5tzIxxfbN+qOjbW+xaE0a4v2JvBFb8x9Uo5rBMTW4dom+8RS6d6bwE/SlYN51zkfkpCck288JST2YYOVxGcxg38RvqU1C+zDHCQ=
Received: from BLAPR03CA0088.namprd03.prod.outlook.com (2603:10b6:208:329::33)
 by DM4PR12MB5867.namprd12.prod.outlook.com (2603:10b6:8:66::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Wed, 8 May
 2024 07:21:46 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:329:cafe::c5) by BLAPR03CA0088.outlook.office365.com
 (2603:10b6:208:329::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46 via Frontend
 Transport; Wed, 8 May 2024 07:21:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 07:21:46 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 02:21:42 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v10 5/7] Documentation: cpufreq: amd-pstate: introduce the new cpu boost control method
Date: Wed, 8 May 2024 15:21:10 +0800
Message-ID: <7b7b95877cd49b1aa271c7d1661abc0864577f41.1715152592.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715152592.git.perry.yuan@amd.com>
References: <cover.1715152592.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|DM4PR12MB5867:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c281e2f-fdbe-4fc6-3e60-08dc6f2f84d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mz958ZOL7Uz+H9GiJ8ELkYi3nOe+cR6R4PmrEtmbX3od0p5qGWOlq62US5dt?=
 =?us-ascii?Q?0VY37nPiW3wYbsDr5ffYVdSgCvJJ8tzZoduEn5R7HWu1AO66TmTf1btT5nuH?=
 =?us-ascii?Q?GfQZAduAXv3qyWqI/446tKsWlLQP39rdYDFQ0mhD50lQDTbhjL+oMkV73TnK?=
 =?us-ascii?Q?/PxaGeetdqVoNFz21OjlqdumRJNgZsQJRljq4lk3Lj6y1Goj4ejC5wYAuUji?=
 =?us-ascii?Q?4a7SAySqfX1dbLpH28QbB3aJBBAVnCYN6aVs3HalG6hnTgOjZOblnZFdlKJ3?=
 =?us-ascii?Q?ZVWkwlKm9J65Drnrup/bCMB3tCVYRBEmRs6m1m2zFUIXeseUO1tEv53LYlsG?=
 =?us-ascii?Q?PiTxdo+u94CTNDpKbEUDOQCLqMMDt13tfjlDjgf8XT9Saw2J7cJT8U1hu2n+?=
 =?us-ascii?Q?0Gkr/emz6BjixtYA20JbUDs5+yofyYnYAh9PcmL3UnUX8NvTmWHj6qnN9AnQ?=
 =?us-ascii?Q?V0jKXvehMpltZei4Q5WVaLBkaSnZYGuHTEMf4D98zHk+KZwqhGbsQMEkxQfv?=
 =?us-ascii?Q?xk9cepEHljt13+4Mojqon5X7jljmkGVJNRN/Qjb7YHcYpy4DeX48Ko7FewAP?=
 =?us-ascii?Q?j19iJo32So7wd9zr2Zz39O3vszxmr8BM6iWHHZ+mjld30qCWTvJEoYdtir16?=
 =?us-ascii?Q?xIao+qcArfEjstMO4Nw6LrnbfEzt5OtTf3ULMT8edvA27Tss3nLrXOjp/hwp?=
 =?us-ascii?Q?J4YSRF/7dWnw36aEXSZUB2rvYkFb5uWh1b9YVgFJ9zBGTe/RaQvJpv9I3JeP?=
 =?us-ascii?Q?HKa/9LvYT8S0ajfh7lTVoBPYi4qPJEF4lcRPlQ7r9HPe8w/732IkpUlYUn3O?=
 =?us-ascii?Q?FikfUN/5AkhDc09NatIfMXRC1Hno8n+JxePsC6BRzsLyMUWJPvQDI4HrtAA5?=
 =?us-ascii?Q?CZjipFjAHqfWdBlUTeVjPGxvQO5pdtH68pbFF787JDXL0bvWobVWN2QdWUE0?=
 =?us-ascii?Q?1laGSFVM9chTjIvCQYHwYRaKsIT9Td0lqZ25cpIQJBXViGdvFK55q1cp6CJ8?=
 =?us-ascii?Q?V3UOnGH8cDiYwzhejavBdfeEoCWqZ7MX52SxGL46QMDtIA5e3Fjqim/kzcjf?=
 =?us-ascii?Q?7JpS35WIEBc0TlFoODnRxeJ76g3PIc/n5iyAqHyMwxOz1nrfm9ZIqx1EYYL2?=
 =?us-ascii?Q?aXd/1PIyHSFysmq0b32wrrdohM3E4qaquLp19UVsws10Qdk/Q/NOAYAAf3r/?=
 =?us-ascii?Q?LcMZxjI3PdCTUajJ/Xr72aubQOAsIpvOv41h9aVuvhX/46WdYWsngKxrV7lO?=
 =?us-ascii?Q?G3b8vbmWAe8tajynLbz/bCxcKunK90dByOgaNYsdYzccaAdGMchSqifpwNB9?=
 =?us-ascii?Q?VPygQfHnGgmDnfKulLPctkICN0xvmmdjdCApwSN9pjypNEYJlFMTnqmJ2Cs3?=
 =?us-ascii?Q?k4jaTv0xV1/b7G+wb6JwmQ07v0LV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 07:21:46.1841
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c281e2f-fdbe-4fc6-3e60-08dc6f2f84d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5867

From: Perry Yuan <Perry.Yuan@amd.com>

Introduce AMD CPU frequency boosting control sysfs entry which used for
switching boost on and boost off.

If core performance boost is disabled while a core is in a boosted P-state,
the core automatically transitions to the highest performance non-boosted P-state
The highest perf and frequency will be limited by the setting value.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 1e0d101b020a..bcc0d9404c18 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -440,6 +440,16 @@ control its functionality at the system level.  They are located in the
         This attribute is read-only to check the state of preferred core set
         by the kernel parameter.
 
+``cpb_boost``
+        Specifies whether core performance boost is requested to be enabled or disabled
+        If core performance boost is disabled while a core is in a boosted P-state, the
+        core automatically transitions to the highest performance non-boosted P-state.
+        AMD Core Performance Boost(CPB) is controlled by this attribute file which allows
+        user to change all cores frequency boosting state. It supports all amd-pstate modes.
+
+        "0" Disable Core Performance Boosting
+        "1" Enable  Core Performance Boosting
+
 ``cpupower`` tool support for ``amd-pstate``
 ===============================================
 
-- 
2.34.1


