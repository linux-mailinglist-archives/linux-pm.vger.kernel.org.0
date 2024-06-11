Return-Path: <linux-pm+bounces-8922-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B383903728
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 10:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 449E52872B6
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 08:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC8D17995E;
	Tue, 11 Jun 2024 08:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UEpYQgRl"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF1D176247;
	Tue, 11 Jun 2024 08:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718095988; cv=fail; b=SlxAcV5Hi+dwnBsoR5LZQ+Wvj0azY5SKdw5n610r41ipbekafohsf4lLRcnKDCCe75EozUdza1ZfzYlLxpql0YEmuQvjkqPZ94ms2WSt3E9lgMHPugTSqkzDMkZR6wMj/O/JWAOyK3RrdlQH6DYmWkgoQHnz9sLybQlJRKPKZ84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718095988; c=relaxed/simple;
	bh=Iu2aHbPVK8RZOypYFtPNDVV0ZJvURXShuUm3UYraMjw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TCLXl+9R4gOym1ix53c0/MzWsFV8u/0vbyPzhwtdQ8Rr0/9rj1kMWFME5cEujZDHKf+EQ7F1aXGVaZ65a1RPeLgEprBuNpXCBm8pItw9aCIjrF2a/oFV3Ct91uA7V/6ZdHnZL+ZYvvpcT1a5MrVIXYh6Kg9LgMeHLmiuLtlE9wU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UEpYQgRl; arc=fail smtp.client-ip=40.107.223.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ok9h261/DNSpA9/XCXleX9iazDxyPg3C8mEVo9ORDQmF+vQhxNTE47/eSp96ELwpyiJG+j/5hVuaEAq4rDMa4cBwXYPRSVRzVhm9mOChY6fSjD/eH79rDYphOEZU7IAGkupBEq4Lyt6xpgEeGEJ35DpCD9Mt2XWqsXUsnIaKSfKohGbp8ZDoRKx3kUaqzU5wPLdZNDZkwY5fYBSY8BeSGdB2dRQVYYgo5Ag3hO/TlBlvPVXw8Dwx5dcMzzZAcif8KfW+YJkir9RtT+U2nacZ/CnG825aQyK9dq5BZHMCQPXBVRGP6wEzsI6OvYetkfV790NYaXaUvblVEofn3ofrtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vrcY8j2MM3yB5PQpMNIyq8UzZcb4H4sVlIytplIX4Q=;
 b=Bd3ycNw5nIFbZ+ORyQYNol01HyFHOKBRj/Ge5DhsvAfLaWhLf0op6pEOAEKH5lkVRK+csAi8ZqXnoBRICFckJBajCfnEK9s+0vt20OrMIhpfp0IXK/3JgB4VBhV7uvw7G/Sm7BkZ3rMHY7qInMloUdU4mOt1rQaY5CfB02V9Xcqior8MlR98uQPN27cKjDuiFpVC4CAk+Mn+UG/Cr1p9bAtqWn4nJDjR2yyIDdb7uz3fR4qfl31fLzguQTPUx+62eFajAAmFOVinbtKtdrZIywwXh7bluVA1VC+y+hrtlNNQa6oK4I1FvCPz+IFYWfIn/x/FfLgk3Aodb25S+P4UHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vrcY8j2MM3yB5PQpMNIyq8UzZcb4H4sVlIytplIX4Q=;
 b=UEpYQgRlQZrIA0w/yIPG83Gjs7zMwsdIgJ7cTE3v7HmMxj0CNT3qpq3wpJqrOefzfzVPJXjC4NdITf4E5jjOmHDTLl1Xtb0dytnnWYITcOMi0z92aNuK8aiMs0tzKZvxDcHH07fBbUTDoHiLtu+zRD7CUBh23j30HWSepOuwibU=
Received: from PH7P220CA0043.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::12)
 by SJ0PR12MB6829.namprd12.prod.outlook.com (2603:10b6:a03:47b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 08:53:04 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:510:32b:cafe::5c) by PH7P220CA0043.outlook.office365.com
 (2603:10b6:510:32b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.19 via Frontend
 Transport; Tue, 11 Jun 2024 08:53:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 08:53:03 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 03:52:59 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Mario.Limonciello@amd.com>, <gautham.shenoy@amd.com>
CC: <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
	<Ray.Huang@amd.com>, <Borislav.Petkov@amd.com>, <Alexander.Deucher@amd.com>,
	<Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 06/10] Documentation: PM: amd-pstate: add guided mode to the Operation mode
Date: Tue, 11 Jun 2024 16:52:22 +0800
Message-ID: <6e960ad57d31d379f8b0b631581b078fb9b272ea.1718095377.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718095377.git.perry.yuan@amd.com>
References: <cover.1718095377.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|SJ0PR12MB6829:EE_
X-MS-Office365-Filtering-Correlation-Id: 609545e7-b345-4dfd-4312-08dc89f3e7a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|36860700004|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uavuYq4jaUEth6Z/eeQWX83HuKdTJyTRCTxdHOsXEJEU8xY/7Jm2idZnwAbG?=
 =?us-ascii?Q?QIiNQkPPPawmM/Ybr9GkNSkmKNvBkaKpnB+aiC6m4Ys8NoTRztwydgr/7B/5?=
 =?us-ascii?Q?01B5NyIISV2RLmySuwWIOBNldpGRd43juspPbA63utgWVcdmHVN/Oh3WBzmb?=
 =?us-ascii?Q?TW4Z5aE+H3uBgSjR+tXNZhZn9jj5NCd04Qp819bx5xl6K3DB1R5acVXh+ykT?=
 =?us-ascii?Q?jJc5NTwIbNnk7LJLjs6qoFUtv/N/nxu/6TWGLFhgJtcr99vXGGDI7uzEY1au?=
 =?us-ascii?Q?UI5wd8gCo8O0SYVUcynDbY/AmrbhbLxrdbYq8lLwJkfbgkUSYTzygLAUKylW?=
 =?us-ascii?Q?gP5b0GG/MmY0eZqCIEZWqf0LLtaMsjWm5roRKmADnrYJY7aPpc6rtluWxEx/?=
 =?us-ascii?Q?uayazgWKIVkVv8UN2dlCBcyxVi1ciYFNTRULT5D/L6QdapTwSt9zEGWT75Ev?=
 =?us-ascii?Q?L1Ojq2vy7xQWmLNYrpjruq6672aXQ9c1WBCVIadScHNKI0ae+y9IxF/MCG2R?=
 =?us-ascii?Q?cdwuKRXaWms6q2QvT9wImu55HIlQ43C+ztYVdFL1cAOLiHDlB5Ui91bfgW/h?=
 =?us-ascii?Q?uPELShHI2VvWiv7/LwB3vyKDvOnqbyg9FoXQ2hO6ovzcnG64969z52a/RgP7?=
 =?us-ascii?Q?26Pcgdk80uN6nMuNGlzmjou7kAHUP6HNDuOchN5It7mHrq00v8o2kKmH6qa1?=
 =?us-ascii?Q?Yj+A3p05iZMGQypASXr+/GkceaBzIbXTNkTtWBYuy3EvfG/4vFUZGO1RhO4B?=
 =?us-ascii?Q?T43c+khsVvWuuw91niZxHIASqN2aq8/o+0p+SEjU11nB18x6DUM0WkN3aWwi?=
 =?us-ascii?Q?TVbK+GKW9YQPgrrX/ALlRnqN3VKV2LpDMfwLBWXhhHX/sJUKDxw/mjPovFA5?=
 =?us-ascii?Q?vm9F9ZWjW4jV9UMTlVZp4ZErjdkclK+NmgD4PHn3TMFk2foCywsSbNJEYer9?=
 =?us-ascii?Q?fdet3CZLy3zGohe66PGhIYL0VbOy5yzttvKfBWE4LJnXcriCyMEb+Le/97Tc?=
 =?us-ascii?Q?pyVBySy2dVsPjz0/mJX8S+zfcAVJPItfm8oBAS/so9Y8rou16w6MSyGgnvsn?=
 =?us-ascii?Q?p2yc8XFqDXHRvhUObzUwvsdg1sDH8QfoWDZDiRwKsS1nWHZCPR/SbyJ06e2w?=
 =?us-ascii?Q?kY/0CrF8rv2ydsQDq9s/wpwg5ldUHVhOf4C4OLBgZYKidOnJ6a3RKORWJxF8?=
 =?us-ascii?Q?bOHlYCW518mibUBdKwXkPmzTa2qSKvfiYjpCbVb0XiEo/U4L/7mQEOKQ8MeH?=
 =?us-ascii?Q?XZ+8Uzqnee6o0mU7+q3qkx1q3xtItk1hu8J6HTAe4g1YfvsKtVT/da+BmFWH?=
 =?us-ascii?Q?SyVt1JrIEWAfici/aLjxcBfEaJiliubItXA6yMHTbiAGFSLOSOqQRmH5YsYt?=
 =?us-ascii?Q?EPs3GzG0fMB/XNW+An7MLUuCsUR+IAzwSu5qcT/oOyplTAzrMQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 08:53:03.4993
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 609545e7-b345-4dfd-4312-08dc89f3e7a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6829

the guided mode is also supported, so the operation mode should include
that mode as well.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index de83e742738e..7eb35ad21c7d 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -406,7 +406,7 @@ control its functionality at the system level.  They are located in the
 ``/sys/devices/system/cpu/amd_pstate/`` directory and affect all CPUs.
 
 ``status``
-	Operation mode of the driver: "active", "passive" or "disable".
+	Operation mode of the driver: "active", "passive", "guided" or "disable".
 
 	"active"
 		The driver is functional and in the ``active mode``
-- 
2.34.1


