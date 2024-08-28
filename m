Return-Path: <linux-pm+bounces-13022-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E910496245E
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 12:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18DFE1C20D8A
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 10:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E58915D5CE;
	Wed, 28 Aug 2024 10:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ooBgkWYF"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A291E32C8E;
	Wed, 28 Aug 2024 10:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724839862; cv=fail; b=piTze88oCqb3265LqQ18xb/aA07q1+lhQakt5dQ7uv12Ggm3zs2RhesFLa4Eeqz9BaInu2d3JimDCrpSzuj0Kn4ZjGjiUFmcGAeuUQUKXDmCSqydlhoRh/DZEI48qN0khTrym1XSRqSdshGQChZ/91lT2Uainsqk+mfvN0pehPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724839862; c=relaxed/simple;
	bh=wD7lfzto2CBj53meBb0n3GLFFRmqexN+zEjsMremeqA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z3xrRms6NAHyYx016MCpImwGprd05QqAPhkeFNJNex6DxbEzODtbvMXOFvUCan/OenoIA+UaG4BzrEGlCAbV0PvWuFLj58p87isg27swm5sWCAAD3EwtTvLlRNj/Ky0OsQCptd83rkVYz/ierHw73X8dUo+HK9mCS38wnFQGMXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ooBgkWYF; arc=fail smtp.client-ip=40.107.237.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hgp5nj7UZlBZ6saPlKQKIRoPNm9HrUhQctPZGA+3AgU3h2qtP1vRHS6k59XicOQ+R4Esof1FQq4Adyy5IEF8m7QgM5WBVjq04lTrCNLGt1imEPRvsr7J8MQhphDeoMt4i68W/qaVtIcus+Ac73nYLIH8bPI0ETLrDURGCKBKJTNLDwnAWc3LOBSrZxLlU6RuDrx0AHTLXQCAoo6LbFJgJZ6aJfJqSEpNSdERP5TFwQTbCYB+wfYNlvNhqwPU1Il97DAd2y4Xqd47LmiB7+NBgc49fmFAY0c9QEW6YV3fROj0zTpRUnnzz7o04KxOJpmGU7QeUYCU2AdB0czJqmKjBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfec9QP3yVwaigL2L/UIgvyLoE0fkZapSKCOdlYuFa8=;
 b=iZWfuLjbr4JZGFBngv1eqJ6GQ5mcHoUQVLve4Z1ZF28d8YpwTRJe2DGU1RylczQX6hZStd3Ae5cqTab+OtOyktJvOpc1ZuPd82ImxDTcj82DrVSyWyPGaY2zs56sG/OJLVZz48C/KO7OIpZIpMOIcvz6h+rUnsu/Oa8HGozy0px/HTSFIoGF+qk7L7/p1bVW0NtTHSLA7aCspVoMrtax5Mll+iaulcWT+sq22QCukGJgi/8/e41f2t72ax7kkx4O1YJGEuCcrels6XQ8E2KoM8yNN7/yCsR7pGnHUoyvQV1yIDbzxsTA2doAGDxx+7QxGrcBWyN5d6m2bRR/nMX8GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfec9QP3yVwaigL2L/UIgvyLoE0fkZapSKCOdlYuFa8=;
 b=ooBgkWYFzy3eXBhzwSqm1hu0uSG0Tn57QJKmQh7bUHorpM+ezjb7c35eHrzoRT1xkc64DVZkyqvgRp+bFxGilRodATXMlN1GPMZRH+s66eVEuAG/VZjmNWSPVjU4OwzOhXwwhIAS0xHqBkv34CwpImYsBfSRaoze9ZGvupVLHxI=
Received: from SJ0PR03CA0218.namprd03.prod.outlook.com (2603:10b6:a03:39f::13)
 by MN2PR12MB4061.namprd12.prod.outlook.com (2603:10b6:208:19a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Wed, 28 Aug
 2024 10:10:56 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::95) by SJ0PR03CA0218.outlook.office365.com
 (2603:10b6:a03:39f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26 via Frontend
 Transport; Wed, 28 Aug 2024 10:10:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 28 Aug 2024 10:10:56 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 Aug
 2024 05:10:52 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Mario Limonciello <mario.limonciello@amd.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Huang Rui
	<ray.huang@amd.com>, Perry Yuan <perry.yuan@amd.com>, Dhananjay Ugwekar
	<Dhananjay.Ugwekar@amd.com>, David Wang <00107082@163.com>, "Gautham R .
 Shenoy" <gautham.shenoy@amd.com>, Xiaojian Du <xiaojian.du@amd.com>
Subject: [PATCH v2 0/1] cpufreq/amd-pstate: Fix warnings for X86_FEATURE_CPPC
Date: Wed, 28 Aug 2024 15:40:34 +0530
Message-ID: <20240828101035.2099-1-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|MN2PR12MB4061:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dab7b40-14cd-4735-3f65-08dcc749b53a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GRAZ488JW4S1qpqjqu/Q6c8szi3436kgiy4IGyCWosKygNpFYucc39OZCtvt?=
 =?us-ascii?Q?npshMN3ioWFAJq39oB/a0WvXUW3b+tl3flOpsTTZJAVKvh6uizD7jIUrnuoy?=
 =?us-ascii?Q?5A0nz9GFq7Anb9rzN6sA14ad2TN+BlT26E/iuO14wiB4jSZ9bMm6cIF1bL35?=
 =?us-ascii?Q?ZmIRA1G+dBQv0Zt2qzjOcWIPmGz0jdX/hX6tY3ir1n8TK6DHaCaiaTfpL8l8?=
 =?us-ascii?Q?W0rGEz0eL10S2dWsmPnUTjp3nkysy4NIB5XIdurZco3DoYeRfcb57sf6MqkK?=
 =?us-ascii?Q?lJ4AE/wbwWC2/efe55IfcbmQ4SRYNn7FpVO4vs5XOfTU/pqMHkEWe3h2fpbV?=
 =?us-ascii?Q?1yMBQa55K/UWGnxxiCEMHvF/jFacw0GMiJhK1Sb5rB/OVXIG/0NUNsfQc76b?=
 =?us-ascii?Q?qoJde8fwCqX9jN8yKTPqcQbN8b/CWyPB/CAz5Ufrqkah/RymablbtTQqFVZH?=
 =?us-ascii?Q?Cr0w8Lm/MoXGwOOcHV7HyMMgirYY3ZN8FoyXnmhzDGJi2znMpeRP5lyAnu5p?=
 =?us-ascii?Q?njE/U7fGwmzwsQkn0gU4z2It0OjZXmgsxey3BTpYGGdugGYtgfm5LdVyuW/P?=
 =?us-ascii?Q?R6qTPQQaZkCa+jRtGtiy2ohXiiZJB4IbDRVXcaeqBFpJ8VRghCnlLSrCMPvg?=
 =?us-ascii?Q?c7r9DVCgIWVGR61ZHiXLD20nMFOAJ6QRbzV2m64AFeuLXbCYx66j54vEB//G?=
 =?us-ascii?Q?wBy/mDtskbORg7XAFEygwDYPQz9FASP+I3jwVKDCFXLargsIKPf3TRpTpWpm?=
 =?us-ascii?Q?xnXBqp9SE623Q1Xtl/FKXz45ra8VDr/8ZufvaVtLoC3qw1a+cny8rlf4CPoI?=
 =?us-ascii?Q?mqw2pslift2O3bYgfGpzCNGF0NW0unX7/XM3lFhST1PMxOH2MHhBqN4BcMj2?=
 =?us-ascii?Q?LKMLrS0+d8JJKKnl18am+byAZlFT8/tOxM7A296CQwW6M5r4ly6m7imgLdnK?=
 =?us-ascii?Q?1aAox53E63VGbm3VnuUmH0qta9ynYIgs4ACpBfiOXExPO4iLjOLET58MNBxk?=
 =?us-ascii?Q?kbOCt0il1XtUMfd/z/yuC+TwZDTPcMeXra57MkQmlnhJUBJXknQ2ASsRK+vV?=
 =?us-ascii?Q?93VTDu/4xUTAHT+lXftMNVT9Q/xilBacvJN2v9OA/Y1f6XKbCF7dEDw/MGHw?=
 =?us-ascii?Q?qOElqmHV2GkZLcvYEP3dWPcRas82WgGV5SMbIoJxzyvX9OQ+qlUnXsXi/+Pi?=
 =?us-ascii?Q?5bb+4kdjEkgEMU556Rp6SPbanz30O9oGJJE+1UqB9lD3Ir524pxRVwAMHqco?=
 =?us-ascii?Q?Qarkn81+0Z195byl5C1p1Y80pHTBMhPlX+6xcDr+Z2zffMfKlMy6P7+96rYr?=
 =?us-ascii?Q?MrSg7m5Ow5lsiQ6fXSY1x3tmOe5qm1UWP4MFLDqPw1d0G4QxPNztUPLBZkwU?=
 =?us-ascii?Q?ap9x6RoDjeO55zCEPv2d4/R+t80KFIRBC3kR/YZ0GaxGDYCl8ndfn4bbSY35?=
 =?us-ascii?Q?Uts0xcsjddoAOa+8ePk6KO/s0Zi7fUOX?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 10:10:56.5238
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dab7b40-14cd-4735-3f65-08dcc749b53a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4061

Hello,

This is the 2nd version of the patch to remove the warnings for
X86_FEATURE_CPPC on certain Zen Models.

The v1 was posted here:
https://lore.kernel.org/lkml/20240813095459.2122-1-gautham.shenoy@amd.com/

Changes from v1:

* Removed the warnings only for Zen1 and Zen2 Models 0x70-0x7F after
  feedback from Xioajian.

* Modified some of the comments, and introduced the switch-case
  statement for model range checking to improve readability

The patch is applied on the "amd-pstate-fixes" of
https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git


Gautham R. Shenoy (1):
  cpufreq/amd-pstate: Remove warning for X86_FEATURE_CPPC on certain Zen
    models

 drivers/cpufreq/amd-pstate.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

-- 
Thanks and Regards
gautham.


