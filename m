Return-Path: <linux-pm+bounces-7526-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 878DC8BCBDC
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 12:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A95341C20FCB
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 10:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27291428EC;
	Mon,  6 May 2024 10:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dKiWnhFW"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D8A14387B;
	Mon,  6 May 2024 10:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714990840; cv=fail; b=fj+zXcOKlyqXM8oivQ5vQC72J//VGEGi03QF7BlHdnOkvthT5iUaL6P6O+pe+q+LetwV/Rx8nD8Uk/n5bo/Gdnt1C6uAQd6GhX3xENOywTHbzbmeCBeALUSBWNee1z57UuD8VK6eUoIHjl67IBYT6y4uUkODxp30gc+7QQvNmC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714990840; c=relaxed/simple;
	bh=C4p2sKZdGRylYCgyqAJR+AyPOjBO2/pXljtXbG+zUuE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MFaHwECoxK14ZlYmUT13Ytr2ljLpZN1qn+7jTf2AKm4K4hYUkzg72bG1JGy0GAqKxozM7LhygPnPPSN2b7Fx6PlZYOPwDLtafhJ5gszOBZiR6Qo/fx8VRbs8L+e4V+rKnb0TpPxAUiFGuqUbGuqWAoQ0YwSDy4J1mnAbkWUwAmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dKiWnhFW; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hd3wWt+N2fvqW6tucFBoobHD7iKwWvskACEODDC+D2p+Yucash2bBGElhTx1LNheG+TPhKANvhDTp3iY71hU7bD2A4MhhBge9Qm1VCnUD3zl70v5nxplJlXK+fJbhh2vZNETPhO9dcIkT4/VXl8VoRctd276GW26q4Vg1p2VD8sHZ+McqWTLi3+83aatbZzUZqNK9yAYcr46y6sUt3RthNkuslutGzMMEjZ02D+0/QWO/PvovSSlbj+qP3H+hdhcq6eB/5fkYKHTPFl4+GRKvN4tvBy5WMD0mftLVriZ8+TFXKp/n0NMQ9TwjhqflXpVBA/LIuancgi2kEVHhO/LRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqzLW2F6MFLyBn7JQVf8j5zr1FG2UBh8bVqCrKBuyes=;
 b=UFU7T7bys7tyg/YhQan7GMVFkOMa7eSmMNXofxeRuWTVG2xvQJEMYq6J9m/5p44hKHzV9NZMbXcEzwC0/yC3W2kqILjKVDGh2N702mbYpba/gMfCktVzfA5QfCJAwWbjWZCch6GldaC1OA1ePh3JsIl56IZio0BAlkrTzckplSUsl0hBkgbD0mGx++BQ2Z1I3gXz/6nL4HzrjDRhTTi7v1JjO5Hu0G2Hzc5Zja1hQ8askVGBiKrIlks9m9u4L4A6XY1DVeMICHVsUULbkGQw2mNADXNxAGUmmUn+bfhTadbtw+Db5KtRKVYurU14wXlTckNCqgmv0GCOQddu0crAFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqzLW2F6MFLyBn7JQVf8j5zr1FG2UBh8bVqCrKBuyes=;
 b=dKiWnhFWExCDFcbQRaUxyrQOEoyY9XZSyfycem68IBhRSA+9XWmhHl7hbClOMxvjLH/IjyLmPK5LuTxvDZGByJRzDWAhLlPusvTCqa7fgcidCKS1xot5krxrUvxibrP0cuYiLyNxKHQXQ1qOd87PFIPTV7UFMNOFC35stVEkLic=
Received: from BL1P222CA0018.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::23)
 by DS0PR12MB8563.namprd12.prod.outlook.com (2603:10b6:8:165::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Mon, 6 May
 2024 10:20:33 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:208:2c7:cafe::be) by BL1P222CA0018.outlook.office365.com
 (2603:10b6:208:2c7::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41 via Frontend
 Transport; Mon, 6 May 2024 10:20:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 10:20:32 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 05:20:28 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<Borislav.Petkov@amd.com>, <gautham.shenoy@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Perry.Yuan@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 5/7] Documentation: cpufreq: amd-pstate: introduce the new cpu boost control method
Date: Mon, 6 May 2024 18:19:57 +0800
Message-ID: <cc1237a30eecc223f6a7603b456486b253d10d3b.1714989803.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|DS0PR12MB8563:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a904711-32b6-482c-d6c3-08dc6db62961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cCU/wv8rUVx3qii4qps/QcLIZJsm+fohpunFnb0l0IIcka3vtEPOCM3Wc4/I?=
 =?us-ascii?Q?eArHp9Smx1ATT+dwE8TMigDwjz+cpbq36SXt0TMGBG52Nnd5wiQPDdV4niAH?=
 =?us-ascii?Q?luTY6sfEupvTyLvxhbTWHBoFwLqCwgJ7tU2MzB1zuovSrZnDzck1DnBkQhq3?=
 =?us-ascii?Q?0BkHpRH7Un99+Pol7fme2rHv864SqAmcoJYpBgg00MBZpi4sxhXuxSVcKSy9?=
 =?us-ascii?Q?7ie1WRSjxM2sRLBuErM08FN36Jk8DnDUIAdTJ2Pv/OgY/z4/WD133DkY9J/l?=
 =?us-ascii?Q?NcVFK38h01c000ZIw+/NBqsApfCU/CsCNz1rTJ0scN1eDo72VdWvqBpKaGEa?=
 =?us-ascii?Q?06XjKpQRFsyord9ZfmOL98PWwVuSOmkbnxewkpKwns+JOyWazIl0+i1uBr6r?=
 =?us-ascii?Q?AMiv217QHVCsdf6r7AmFMP/M8oK/1gaT7nM3oR7OYKaO19ol8c+g+i9v4ID5?=
 =?us-ascii?Q?sdZwQPZ19vdoFiF6P1gEMAT9OUfi/bcdf0pt1U+Nv4hVTVgM6e4DGszBPaH4?=
 =?us-ascii?Q?Mvewg9jqfrH9wv2ae9mGQtwK9LkgotPoCB4vohZO1uAh+HAQGukWVoaxLH4j?=
 =?us-ascii?Q?dyCVamtHDG2q1nWD4lteD3Moh1d9EdvxKb4+b/eI3UGHQ1Vzid6rycU9On99?=
 =?us-ascii?Q?eZ5FvisWSWSP23ij7ZgwqDkt9PvNWpD72zzQRnwjbuGAHa6dmA7NyFG0bFB4?=
 =?us-ascii?Q?PWqd18ZFfR79Yaq7Z1xb/uc5SspY9V9lQGCS4x3vNj7x783Q9qOzDyFyzEJI?=
 =?us-ascii?Q?lcmRhiQjObYYPmw7subsexV7cZ+FPoilJfAR9CVgq4Za3j31MWsbBvdiQp9l?=
 =?us-ascii?Q?uAbGxPI2bUmlWmbP5NQOUjrVFI/P+4qCCgzrQXWLCyWXAW1cxFw1h+CZTvoc?=
 =?us-ascii?Q?toFocnssI8LF5O3Fwa6zj9yJnjdQcn/wg8YvPKHLet+SnCwyyCo+leg1bvPp?=
 =?us-ascii?Q?RC5AsCThkyG/vaSXZXua/9JJJMISwFNtL/QRl06adN15NqOXav7DyQWkQQTt?=
 =?us-ascii?Q?Vb+G/YxuOyVKJr54ROfU0YkqR+m/Gb3SxQ9ICqEH2gwvk7xp6J5VGimmS4rU?=
 =?us-ascii?Q?l0LgvDYfuzwy4maAeEPXSMoKv7ublo2FLnxeLe5197UaH01i1EzXKDMH8oOJ?=
 =?us-ascii?Q?zmrwKVhZVtpsNvAw+9X81VQcoom8ly/G9WCV3S9DwTHphheAMggYGKggJ3Uq?=
 =?us-ascii?Q?K4hMTcQMusgEeMHB4MzfjSIzm8NEb5iaMAwUz0Faf/Qs1NWnBaGVdqoFLZVE?=
 =?us-ascii?Q?jGxVcwbxC1GrcHOZ9Exi2b2ggbr6QZSXW5NhX05oiJvXIj7M0qUvIOgAjDIp?=
 =?us-ascii?Q?jlOMuyfmTew20U5+6IHU5hfA54riXUTXOEBOmkcm85bLZCtF2Vqul+Tpz+sk?=
 =?us-ascii?Q?kF24c0hhnHW4iq1Ht9iaPTDdx565?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 10:20:32.5052
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a904711-32b6-482c-d6c3-08dc6db62961
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8563

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


