Return-Path: <linux-pm+bounces-7634-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B10088BF6F8
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 09:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 676DE284037
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 07:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE56247A5C;
	Wed,  8 May 2024 07:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pDqkYm2T"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE4745BE3;
	Wed,  8 May 2024 07:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715152917; cv=fail; b=OvohLq1qtsNi0HCYmWAcXKKiFzd7WoWmJN0kIQv6SvvL2NhtivxdGpHJ9V96X41LUbW77UPZmMJm9H4iz52UQ17GxNUOQnU3m8O+6LaVbziEkUgmCBkYcqImkAAHgh9hezDGzTwEN7kLbOYCg/L/KI934HwwUTKYiVMfriBS8pA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715152917; c=relaxed/simple;
	bh=591R1c5qWNY+ywR8H9LuF3YeddORv0F+tC41BSUsTms=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZyJK9i0vRqtbQAtslr0GpfQUk1LqMYDJWALcSHmsqtkhOkotU+dJYBiMq97yd2tK2DM7bo7/6RJgrS4SQTvgPpiOg9qFq65kT/ZUpMjUCuXAs9V2Vg7hkGdys22BtHzVnaluM0Cc++Q+MYxq5GcUcykyfFmXJWtvovFafqoRP0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pDqkYm2T; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHjRHUWXLB/8hJ2uubvH26/gBi9tOHR70zmG3vO+Be/Sfo/Nsf6GeFAIKztDQb+Aq4nb/fIg3NSOEY0QXosfIScJAw94ugKWM39zH6Ar6eq+1E5XqrMAUcWbIzVIL0m399SC7xNuFtm5urCXsLsClBKoLlErCTOXWXDeN4Ckz2Ov5kswYH6qQPDWwDvOSkMi2fG0wAdZTuyx45z2WB4dm/mxoE/09v68zvFWsAXkajxhPW6Pn8oz70/4UsZ/U7blaCvst2O0LlLsSrtUWIYHav7nOwOuHl3hOybV2sxThcVlCiNxX3m8kzC16YzUPcrswx6opH6s7xF589U88rgsiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94xdj5VxKlsKg7KcTOXiwELEZ8njjN5NlNAXdX4qank=;
 b=lqG1EcRzqpMhe/fr2syjB9DanRQTp0oYwxYCJzK/HMJbSvvOvXDQ3wX5TbQUy2pp2enVwYfrZV9kWCsk3is8ktomAzYfG5v2bSgU85hSspPCeSYac937yR1rfuWCcYkYNrRaA65Pb1bX97N10x+JPijYCmj1Ryn3CyLgJX5zq4djV025rYC/td3Cxh1TYmKwcHnjjWGIwWPx6S0szgi21AXKHmb6QAAyFZonIvwUbI/6xWW6qWsa+5mQ0g7vYlvGi8lzQeNm5kBJbytJsdICMLFz4KUxRiD1VSr/vdfJtZWgmYMZhFtaIwIZsqhUmOPgIkbtfnLDRIo4KVlmPWsfmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94xdj5VxKlsKg7KcTOXiwELEZ8njjN5NlNAXdX4qank=;
 b=pDqkYm2TjOKeYfhuDB27Cop4M2z0oR1FDFFjf7N/aHLg6oieGBZI+tQHY5/dFSN5wT1+vRv8A9oBZ1IWT0OWPaaXGVQCauzoQagGIEOlNs55nJHivnmernrtT+QHUuYrY357pVxXn7UyAFhiZTF0hlNl4mqBcSennyHDA3iALEw=
Received: from BL1P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::28)
 by LV8PR12MB9083.namprd12.prod.outlook.com (2603:10b6:408:18c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 07:21:53 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:2c7:cafe::37) by BL1P222CA0023.outlook.office365.com
 (2603:10b6:208:2c7::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43 via Frontend
 Transport; Wed, 8 May 2024 07:21:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 07:21:53 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 02:21:49 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v10 7/7] Documentation: cpufreq: amd-pstate: update doc for Per CPU boost control method
Date: Wed, 8 May 2024 15:21:12 +0800
Message-ID: <8661e4fb9a0473bbe74fd9ad008e19380743b46d.1715152592.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|LV8PR12MB9083:EE_
X-MS-Office365-Filtering-Correlation-Id: 8faaa045-d2f5-4aab-619f-08dc6f2f88ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HnB/L8eGNBYaJluCpFdAlGpDfZo+UVhh6ovq2B4pfSDBwTNmU6c4aTVXDgij?=
 =?us-ascii?Q?nnlo8coqJk6okib8IapT8Xp+6pMedbNOFPVDUr1+Fqzs8yt4KYzJVqkfkxCr?=
 =?us-ascii?Q?pvRcEElr8vKhqBuKKkTGlWRtQ/meBm516Cu5dg69Ria2tS69iSk2Y42O9WFv?=
 =?us-ascii?Q?KTSqIPEMqvX29k2+bEJQCBAlRSZicQ1NaeOmSvwNyIG9scvxss8Na1a7JtGE?=
 =?us-ascii?Q?MtWZRG4SJcUNMZ/99G5htw8En/GWzyeLPtz2sgmwmS2KnX7yMnK98t/Y1WDh?=
 =?us-ascii?Q?WoX1JfrLjBT2Q1vmPLiRy/XoCkGc7ujsZm2diZJvimNvKq9SHWvchOdpn+Zh?=
 =?us-ascii?Q?iitV4m4gJ0lCtALLDG+UlCorvJ0OLO6T5Q2RRPeQC8tjpH1BJLNZsTVfpdK+?=
 =?us-ascii?Q?lwWdGtg17tPgym/FVOwhmlX69zgd1WSI3mhKaxZtW9AKq/fBBo5yXrNlGYIv?=
 =?us-ascii?Q?d8K07uUj7Qp61l9+SCAQeynrFZaduP6btV4O32Je/58YVnmRe1R1+Oqgj/x9?=
 =?us-ascii?Q?7RhfkbLygP89gcKRZbp1c8FbRlEb3tae3AzWlX2flo/lwPX24ABRSz6prL49?=
 =?us-ascii?Q?5XhRcz/1yzLINWyPYrn2rOc7ueLtCr0EBQysvtEE8j4AWx5foJZfSObG4SC6?=
 =?us-ascii?Q?5pjxiv+DNnQQp0wUGFkSNZPdK97jiFJ5/oe4T1VvogABKBEsgW2rYKEknkaq?=
 =?us-ascii?Q?T6hK27qk0LYCCSHiyDUWYYVZ1qMineqKFoZnsoWsT8zp+giJ6ThezgqqrGF2?=
 =?us-ascii?Q?ouS1qvpo1ts6BcHctfFt3Yo9R2s8w4d7cnMqAx4jznWKsOV9wk6Q3zjcYjSQ?=
 =?us-ascii?Q?7+myLZxUkz9iw4cMH5AZTXzmNGH0uPIqVBmUtAdVhRKYn0RHQWACEYkjhd9R?=
 =?us-ascii?Q?WKullb8fYWM1LEeoL77c6goGag5jlMD6hoQM4W0l331XSkrxzgqJ0D1h4Hvt?=
 =?us-ascii?Q?hBCxVX1qz4Zlb0I/V9/cSkxCVFz4CdFaYHVpCbcWoLB2Y+RB6USsjquxERvE?=
 =?us-ascii?Q?OOfCVZ9a7ZCojiLju0ieZKiVdtRze1sbJl0/BElAmYr3QFQjeGrh1HPD5AP8?=
 =?us-ascii?Q?BkytbKOA+3U5k2oRmQABRG2GDAHCzaTT1f4jc3cWNSeyjBeVrZjE+ecxi8tz?=
 =?us-ascii?Q?o8n6bAOSD4YEr19sCMTVt1ZfG46znfoedF3km65oreAL5PfKaww6akYUllRi?=
 =?us-ascii?Q?sdiiM6X7PAZoCZD1zkO9sns8l1MHkYMzU5X4OlXw4+asFmaBByOca14iJAbD?=
 =?us-ascii?Q?5F3nttPhk9qsFOFl+Qc0CL0hxx3NsqMgqarVyr7flkWrNOBAeVP6eHS2PCgc?=
 =?us-ascii?Q?09cw193LjfvWUwAZsTJAzifiSBMdfEGCDG3ybsaKQjdCYYXpXwptEXSpDvYx?=
 =?us-ascii?Q?dSklzKND7bMTPpeOoFni+8J+CI0S?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 07:21:53.1883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8faaa045-d2f5-4aab-619f-08dc6f2f88ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9083

Updates the documentation in `amd-pstate.rst` to include information about the
per CPU boost control feature. Users can now enable or disable the Core Performance
Boost (CPB) feature on individual CPUs using the `boost` sysfs attribute.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index bcc0d9404c18..98e43c53c387 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -281,6 +281,26 @@ integer values defined between 0 to 255 when EPP feature is enabled by platform
 firmware, if EPP feature is disabled, driver will ignore the written value
 This attribute is read-write.
 
+``boost``
+The `boost` sysfs attribute provides control over the CPU core
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
+To manipulate the `boost` attribute, users can write a value of `0` to disable the
+boost or `1` to enable it, for the respective CPU using the sysfs path
+`/sys/devices/system/cpu/cpuX/cpufreq/boost`, where `X` represents the CPU number.
+
+It is important to note that modifying the global variable
+`amd_pstate_global_params.cpb_boost` will override the individual CPU settings.
+
+
 Other performance and frequency values can be read back from
 ``/sys/devices/system/cpu/cpuX/acpi_cppc/``, see :ref:`cppc_sysfs`.
 
-- 
2.34.1


