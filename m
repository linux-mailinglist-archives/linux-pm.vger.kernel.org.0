Return-Path: <linux-pm+bounces-7557-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D72E8BDC42
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 09:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6DE81F24E3D
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 07:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B7113C3E6;
	Tue,  7 May 2024 07:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gwIAYCZn"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF37413CA8D;
	Tue,  7 May 2024 07:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715066176; cv=fail; b=d0Sj+DpqVkVZDb1YY0FVISPiL1tOsRT4xChdvQHYT5LAq4+F2pX0boZ5TyESMN041Tp1EmtAd8Wy+nM+6HK+NkdR9Jca9NTsQNfjrFyYPwnKGLQDuW8181pYX6ZxX25uDNbYUtySwcp7LGwzhEi9cS8bBrl516n8hXSTFtM2iL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715066176; c=relaxed/simple;
	bh=IpqQGqYRCFdjLn0Jpevb5aTYFdroCEQ2ny+xxSsMm1w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KSBpV0ceFWAInoYFnrZGI8rpZnCnN5ztoktN50tGh4iPTbczcVm3mplFUUYcLCMp7276iWtw5Ijeaek9OP9hnO23ZgewIz3kYgynZl1Aq3DTRiIIbmmpScfDw7/6SboC/Kf1DRApvY1VC6uuBq1/FE9iw01/nBny49DlnCgl9Iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gwIAYCZn; arc=fail smtp.client-ip=40.107.223.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YdFwF8zex6KCLdO0rjTWl9Ju37CR08DWMuHVUWc2Ov+Wz+XO7b63ZgUPeJTU1qZi2/QmUxbXyKxp21qhmz0eBL6G8XFcee6VIfGp+nsjeFJhQUBgzer7/xuACYBAGWxUleFwHVXQ/QnzQI02oP+kQOayzD1hdlnOnYRuh24cJRg3M8uAqBmXloodjL7x0TBS1tYRBRI9fLO8jdDBlYs6+9+dSeVbT8ARYvxqedPthxV09mP62Yj4mN3ZYJXw9NfuY/2lS8afwhNhjTReV8cU6QG7W39AZkfgJj3aALaBfacFFtqJCBmxi9ZCtlphhxqdaxbR8FNikaUn2HzsljC+eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LULjVeueHakNG+vhlLn8dzsZ2NAv0WwrdyIeDL8auH8=;
 b=U9t+wy/TbDeCukOizGCBL9uCWICY4kQPPOQlvqXy7IpH9HeEhh0HzulhWywtP3NLj9YJGraGUk05sRsFOTlBQnan9Kq1Sf3EjrH5S2rkYgIao0gvfZSjjI7Nn4pqkVHTUi14b1zKmY4us647vedrbKOCH7zosT6yv8AU93OrakCEkfm+zeKvwLk0LYH2sQiO6rt+QiqWoTTSIDc91r456yUZuGzmhHWR16DPYEGAF6/1reS5Au+aYShelErQRJ/x7stN2C6YNYeIeVBGSB44KaGxSurHcBTa4OLOoMHO8nyEMXXvZ4r6rQ1gZ6Pj9IRKU1dv+dFYV7NI9TCZdVyO3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LULjVeueHakNG+vhlLn8dzsZ2NAv0WwrdyIeDL8auH8=;
 b=gwIAYCZn1E++9Nex1qkhIoHxNcCbpxei4MoJ7VMPlO1xYV4fLQnYuYRMOtQnGR/pjxIf/CLCYHc6TtXoZVOYlntqM0whj8LT+gUeDaaR9QL4sOJ46aUuCmXIG7/e30wN0dFqFrlRA9HR0Xef3QNBnwFc3d7HZf8eeqaHtLwevLA=
Received: from DS7PR06CA0025.namprd06.prod.outlook.com (2603:10b6:8:54::31) by
 IA1PR12MB7543.namprd12.prod.outlook.com (2603:10b6:208:42d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 07:16:10 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:8:54:cafe::78) by DS7PR06CA0025.outlook.office365.com
 (2603:10b6:8:54::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41 via Frontend
 Transport; Tue, 7 May 2024 07:16:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 7 May 2024 07:16:09 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 02:16:02 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 05/11] Documentation: PM: amd-pstate: add debugging section for driver loading failure
Date: Tue, 7 May 2024 15:15:21 +0800
Message-ID: <ecc1c5a061859f9b9532e54f2b64d1cb5fd593c4.1715065568.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715065568.git.perry.yuan@amd.com>
References: <cover.1715065568.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|IA1PR12MB7543:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eb1dbcb-1ffc-4a10-dc5a-08dc6e6591db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|82310400017|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?esM3+HrTmjlLzKyT0TpwLgAh1bc61Uv6lnOOlHRQ6g4LGyc1Wzi/19b6AkdL?=
 =?us-ascii?Q?5gIlLFxfITby6A3DUnTZJ2suh7XRsHOq3AGKJI/HJn2GJ2ubcX8oRSYHM4R5?=
 =?us-ascii?Q?qPKI9es6d2sRIsG8w8wygWoy6WsRzypBPoM+rvMeZqWQPKfhvrxVYDAwBdu6?=
 =?us-ascii?Q?r1cRW0AospM/2xfhGjcSQz3bTi1VmZLcSKfHDSqB1CsPwxv6Rlpt1SkTyMDx?=
 =?us-ascii?Q?fRmZaBj3QeWkf/BiBEDqh1Rd/gpuvol7cIVQmsfHF41kGS2RnA92p5ZVcH7s?=
 =?us-ascii?Q?i5cS2PuJewhVpSeN9SqLJHVTKTLQTFM7W5sgmu65jzvoBjLzv+/2ei9mhIRh?=
 =?us-ascii?Q?eZqdt4ZNmW4ixT5c0tl0r8Vky74UGKz+FlCMSJxWf1Z8Tv1erkY1kO9dGDqe?=
 =?us-ascii?Q?q4MBYqpMEQ/3v4hGT9hOZ5z1THtdK4+S7HR65id0xJfzycqukbxnruvnmg2V?=
 =?us-ascii?Q?N0OfXcs3DHGsasqsyfdBFSPG031y76/Fv7jHg2g7xAP+fj9FSg6uU/pojvB3?=
 =?us-ascii?Q?6jYh+n4NKroSVEgQyj/eZxf3YaJgHYraWzJZjvqrr1YdvcgCbv4NRvtj/Bif?=
 =?us-ascii?Q?TVFGIRLExPxh26pA9gYsOhKzP8/AFGiBcIArPcu/BaTzr+50jxJLFo0vFwKZ?=
 =?us-ascii?Q?ylTsXbbKL/ANhSCn5WSD1xnvpHat7Hs1+Zd1GSs55mZKx15yKrg/6cDUh33d?=
 =?us-ascii?Q?xvF9KAc/CP9TJ1mLTqM0MAwk00oos3sun9M7uKZzhJ5CtrRZj7yMN3f3KEYE?=
 =?us-ascii?Q?VYUAiaKIJ+RFXINlga0+cyxEHBvuVyAIk3jcGnJxwAFdSzudzSZXyWqECTI5?=
 =?us-ascii?Q?lvvuIBXB/qKtpsCIjNgXAu1sUcY2ltGMrXUm+4aBk4glq82OO1o1aeyq0BF1?=
 =?us-ascii?Q?hwnLQCaTVpYUcZ41YzUg822jeK96+Ozl9wQerQtRwYJkk8H8OVqIHt8jdCiZ?=
 =?us-ascii?Q?xC4DGAJAYw6aZI17MYq1okaMwvpKN1YN+uGZNhhc1NZp9mke2pPK21tPmLCO?=
 =?us-ascii?Q?47BK/ZixhmGUSHHiGK3Sl/AlL558Sn1K01BQv4Xpddyj9tTc8bSlHWTRnwdl?=
 =?us-ascii?Q?ibtlXyhqC1QECy2t/0swwbNc3aMhxvCkzjndjU8s9Zrv+db+RkFjU2SLD02Z?=
 =?us-ascii?Q?vEo+Tq840HAh0QYuoU/3XD3ancjqzX8r1lUGiWaa0mDD6YzkHvL6Sd9v9TK7?=
 =?us-ascii?Q?jfZL/oqtvlCFIPd1alD+JWVgrOFL3rMPHxqDjzn8Eo7ip/owdUGY7zLucJ3h?=
 =?us-ascii?Q?cZFkoft0zNfefZ3lTEa3R1E+H62JFoSDAHwpTrjJFv4VZpV2QHq6uYnb6437?=
 =?us-ascii?Q?1dH8EgrQ4h1GjrkGJeWA6ZgghSk1AIpmXWa5xxdG7EM1iMia/oMf3DUqUbEN?=
 =?us-ascii?Q?j5ddLLFJYLnnZt+aHFOcEh45aUGS?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400017)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 07:16:09.6843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb1dbcb-1ffc-4a10-dc5a-08dc6e6591db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7543

To address issues with the loading of the amd-pstate driver on certain platforms,
It needs to enable dynamic debugging to capture debug messages during the driver
loading process. By adding "amd_pstate.dyndbg=+p cppc_acpi.dyndbg=+p  loglevel=4 debug
amd_pstate=active" to the kernel command line, driver debug logging is enabled.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 2695feec1baa..230e236796f7 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -476,6 +476,19 @@ operations for the new ``amd-pstate`` module with this tool. ::
 Diagnostics and Tuning
 =======================
 
+Debugging AMD P-State Driver Loading Issues
+------------------------------------------
+
+On some platforms, there may be issues with the loading of the amd-pstate driver.
+To capture debug messages for issue analysis, users can add below parameter,
+"amd_pstate.dyndbg=+p cppc_acpi.dyndbg=+p  loglevel=4 debug amd_pstate=active"
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


