Return-Path: <linux-pm+bounces-7528-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C56268BCBE2
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 12:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E43DFB2343A
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 10:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07951442E3;
	Mon,  6 May 2024 10:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l2hn9EZ+"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B05143C6B;
	Mon,  6 May 2024 10:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714990845; cv=fail; b=DMJvx5bGCEeF7xaNM4OitedFlfnRD15u9QqI9j/fxqzc6tjeQlnBCnsDiPFB1iaI0ZIetE9WMwVvBrxPB1NcFu1Daoat+/eehsTMeAOWZxWma+5gFHPPwNCFzgQCO3iiPss8zpWlgOiCHKBv+JbqmajbNTNdYI91PMSfkY/BzqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714990845; c=relaxed/simple;
	bh=t029aG3VpGM9EDdeDJfxiYyBAOtulunLbZJNHZx11TE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pkuvREN/YCghf5QcB5f1bSbNg17fdA9z1i1tmkOdZiRlLHE54XClgx7KcURTktyDrqVtl3UqWuWp6xllW2vnSi+FI1iAJJ0zEnq5IFcEmlIuO46tL4wu6eLTVYqzjdhZzXfCkgaVc3qxYNhozdhJeXY33rtwQkewxkDCWv0JVSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l2hn9EZ+; arc=fail smtp.client-ip=40.107.243.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CnZfdVWjJrA5Yd9iiKaPbYQqJOdWU+Y7YDsoqlivR4nx81kckDJ6pA1gQ4XXzgCU/L6dZotwH3zTOo3FquHZ6h5nSt8TeIY4kKB+10z/Xi9Es5fGUW3qij5w6s/odlJHR9l2vlyTwyVsYldZGoeqYpFk/I7llbH0Zt6vVjRvavvslU4mCWo/rt4skXM86FFHpyGqXTxDIuZGdLBIz2ISM/FZ9yD5rJWl60lZir2XYbRJlOpfiUTZ877cuCcu6VCojO3inWq1EtEYS9R8PdlZu0E71uRvS6UADuQkfGStvLKNHvHjqw+zO2qAPsT7tRgqu1STqXFg4Ea4yOpOm9BmVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVAEjbK8KM8yi8GYvslYfpne98E+lCZ03mOYSPnzGTA=;
 b=VbpRuhFknBLXys40e/wd8bCF5igewXrokkdRbDsTYacPBSdMi+nKx8RSOGUfIAkrEIjmRDzdhDh1MY5GleHS9yvazLw89Bhdf4W2Tp/zUZYhignrtYsl/qFzYSRPD0NVDwiaWUeX8gP3rEBsoLzkO+bW/iaMFlTY+CB/bQSU1N64xeA5LSHSWuqGvf5A9c9JTmIfOvWY4BMFOTxNASDrN7ifHyfBt+b+zrjaA3d2Ej8pzcUNdzYZBdUalN9OeppnRixU6mNjqdm9cgaUAWqezOoc2kxE/VaPpVV+/leZA62sNqVm0s12izjpQ2ngOmT03p1tU1loC1vcF45ttW3i3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVAEjbK8KM8yi8GYvslYfpne98E+lCZ03mOYSPnzGTA=;
 b=l2hn9EZ+Qm45zSoStAs0VNd6uKOz2J+CqsmswIXBKlIszwLtVj38fPvVA7L0SmnST/VfEsVydKLmbsmQZexFl/DzM2wCaoJinwasSaOHFSToCD+MYpsiYWM0Q0WfiZQhiwSw3fRleCyLccM4JHexqLvuR7JWDZkg1vx55oxmocc=
Received: from BN9PR03CA0125.namprd03.prod.outlook.com (2603:10b6:408:fe::10)
 by CY5PR12MB6599.namprd12.prod.outlook.com (2603:10b6:930:41::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Mon, 6 May
 2024 10:20:39 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:fe:cafe::63) by BN9PR03CA0125.outlook.office365.com
 (2603:10b6:408:fe::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41 via Frontend
 Transport; Mon, 6 May 2024 10:20:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 10:20:39 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 05:20:35 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<Borislav.Petkov@amd.com>, <gautham.shenoy@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Perry.Yuan@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 7/7] Documentation: cpufreq: amd-pstate: update doc for Per CPU  boost control method
Date: Mon, 6 May 2024 18:19:59 +0800
Message-ID: <490ec11390350aa5814aa86a4e08cdefb7ce2832.1714989803.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1714989803.git.perry.yuan@amd.com>
References: <cover.1714989803.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|CY5PR12MB6599:EE_
X-MS-Office365-Filtering-Correlation-Id: f0fb38f5-2e42-4ea0-b8df-08dc6db62d58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kpTuH2CufZip4ZL1sgGUdLOYdcqI+ZG1aYkLwax+SuhpdsBTkfpyWSh+1Hdt?=
 =?us-ascii?Q?D/hnkMqDtHQwjQRZaotGlCVLDnMMMB3bebTBm7H9wmC2+5/N0gMkA+ZZUJQm?=
 =?us-ascii?Q?Fnj4IG13P4bC/UIwyYeOzr0N33yDh0CxYornXKBmhGr/wLQukpTkW1UTFLRi?=
 =?us-ascii?Q?xzyqNtmQ3bTWjaqNHRteoO3HyuypGBtrID2WSWAYt/s4Qwoa5yz2ulogveLT?=
 =?us-ascii?Q?O6fNHbIEEq4CWnAwaLx6raD7hat/wFu6bdtdjgdsOl+DmdxZ22qOCxF9rBTF?=
 =?us-ascii?Q?YpcutCfE8EchkzgcTiWPVpL7t7PrYDEprFBIWEKZtEX3s4UAOodf3SjvXL0K?=
 =?us-ascii?Q?dIQRSKQNex2lRF3o06t6Gwm/TuQs91yf7TVpnd988gciqG7XEZNvqUWKoW8J?=
 =?us-ascii?Q?CalWbSkkVwSpBkugu6bCkMtO/hCI9Kx7rOnL6Vbc+PZ9wPyAnUKzJ8gBmLv/?=
 =?us-ascii?Q?sCEF7TGzrAVjWONGrEWWtm90VVkRiBWEaYPB04vCaXmVdTHVqaF8tMUu3kxY?=
 =?us-ascii?Q?PtT30GEwxQUQTNysGHKhjAw/8IoYyiGJAC8WCl6/x3jkM5wKxZc88gjPUfoa?=
 =?us-ascii?Q?moT86GvOMrTLMLcq6dCbiFbZdMQzM8kY1g1ETuHvGAua7XuuUvAyR0qRX9Qg?=
 =?us-ascii?Q?5K5B2YoCSvikG4lNi05EWctZTJ8Nm/p2zoiIsyojwv5qr2W/AhhhXwrgdsAX?=
 =?us-ascii?Q?eGYfdV3FzXIouEw9D74z9pLtmEQhuCBBdqkiVC9Am1O6T/q9AbbHcspGNRKR?=
 =?us-ascii?Q?HzHb9UXQOXF4V/MyVnYdgafKP7RohIW9QzvcnD9kc1BrMBUEihsM1BWBhGV4?=
 =?us-ascii?Q?YZq0u5PtS1aN+dQ0lvM4jR2JnqxceOGnY1K1e7XI9A5nk/BYA32ASGObyH/n?=
 =?us-ascii?Q?WMc80U08q0kbXc6fAf1sNJ5glcG8M0s13scTw6TsEioQuPKR5APfYcrrDA5l?=
 =?us-ascii?Q?HB9m9VfC7v/SKGWKzBZWRDHbjnsWNG3colaS4Ff3+7DVnDS09GPIpa9d9N2l?=
 =?us-ascii?Q?xxYM2H2oK772W/iu9d8Nx9vh+cgYMDIOyNYVhNb3tzvrq2w9NYJyY8W5OPKp?=
 =?us-ascii?Q?QJ23m90UEmIDh1vwD+rMgt/ak9fEZUvYFEOWxYN9PnywouFFY7hRaGRnUZNj?=
 =?us-ascii?Q?sU0UEsHrIk0ElU+qLDGc/MVuWACSKSkBmM4ACTl/+i7PUQkyoN8Id9iV73UT?=
 =?us-ascii?Q?yCKitrIvm+VqVAJAS6AxALlyIaGMPCPfDQbqnUbgUdmsPJ7guIUbEYTNV9MG?=
 =?us-ascii?Q?WWJpNPhO8lYV3H8FyjV1BOnjP9CQEDANxyccObbUx8ItirUvBvMKr/bdYByR?=
 =?us-ascii?Q?GkpP9TUo4GoE6mnqLO4q499YOz3jM+c/pv6p5MzdkMV5gMdG5seix8lamFFr?=
 =?us-ascii?Q?xqfeD29xZE21o/eoLBt6pTWkbevh?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 10:20:39.1563
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0fb38f5-2e42-4ea0-b8df-08dc6db62d58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6599

Updates the documentation in `amd-pstate.rst` to include information about the
per CPU boost control feature. Users can now enable or disable the Core Performance
Boost (CPB) feature on individual CPUs using the `amd_pstate_boost_cpb`
sysfs attribute.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index bcc0d9404c18..8c48b00fc8a3 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -281,6 +281,27 @@ integer values defined between 0 to 255 when EPP feature is enabled by platform
 firmware, if EPP feature is disabled, driver will ignore the written value
 This attribute is read-write.
 
+``amd_pstate_boost_cpb``
+The `amd_pstate_boost_cpb` sysfs attribute provides control over the CPU core
+performance boost, allowing users to manage the maximum frequency limitation
+of the CPU. This attribute can be used to enable or disable the boost feature
+on individual CPUs.
+
+When the boost feature is enabled, the CPU can dynamically increase its frequency
+beyond the base frequency, providing enhanced performance for demanding workloads.
+On the other hand, disabling the boost feature restricts the CPU to operate at the
+base frequency, which may be desirable in certain scenarios to prioritize power
+efficiency or manage temperature.
+
+To manipulate the `amd_pstate_boost_cpb` attribute, users can write a value of `0`
+to disable the boost or `1` to enable it, for the respective CPU using the sysfs path
+`/sys/devices/system/cpu/cpuX/cpufreq/amd_pstate_boost_cpb`, where `X` represents the
+CPU number.
+
+It is important to note that modifying the global variable
+`amd_pstate_global_params.cpb_boost` will override the individual CPU settings.
+
+
 Other performance and frequency values can be read back from
 ``/sys/devices/system/cpu/cpuX/acpi_cppc/``, see :ref:`cppc_sysfs`.
 
-- 
2.34.1


