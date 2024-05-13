Return-Path: <linux-pm+bounces-7751-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C608C3A08
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 04:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 844571F21D68
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 02:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4A813441E;
	Mon, 13 May 2024 02:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TKF9sss4"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DCD137925;
	Mon, 13 May 2024 02:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715566091; cv=fail; b=a+JScYWhNS8pr1r5gog4M+diVIW2LSbA1bvk8grHZ6u3iPXZ80AluHOFUjg98shZFOLki4B5fznFOvXqu1XsGjX+zJkKFn/HHuwtUyKb9nvqOY8H9NyNwzwtWcNfhcDe1LGXWVG7KMiFbDl3E1XhZDN1XIcC3yCID+qZ9io5yio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715566091; c=relaxed/simple;
	bh=Iu2aHbPVK8RZOypYFtPNDVV0ZJvURXShuUm3UYraMjw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sfo4s5cPNSG/CMm/UikeH80bp1iAhV/kFL7v6eRF3DoTpsXC8VDwXuj3a+ws2ysCzI0GTT2r0lDxdD1KuqW6ezF1f8n0neJVAGWDzdzzFavAkMiOQXM1B99HdbUj0Qa+cH17XmeQM5JR/Q5OD8KIAaZE4AB5wYWD+CQg2ni1mtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TKF9sss4; arc=fail smtp.client-ip=40.107.243.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHl2ozrHspe1VQRXOKGjESMKEyZf93XZ8aJlZ8Qe64KMroVnTMFHL8q87ZaUopHeBCDwGsFQlD8u5T6ESI8jJS16SFxcr24Kt795jmHmQc5qLs9/8Bhd/na78a1O9wNTBmwg20fP8A3lEFCBy4JRrCwkvcflNrp3wxly7U8h0S396jeTbtgQ2+E754KvquP3gTdmL2fAVD6J3qBVKta72M4FcjgrkKdSdB4bl1w7G93fNrxtXhZ+x5Eh2/Bmd1WAI1QBLuFyDOgH31PLiYto0IH9rUwEDl/sTCkGOlsdHLV1Bv923D/ejBFOHo9Uqs1P1Dv+YEA5zJxUf8dHtLPTVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vrcY8j2MM3yB5PQpMNIyq8UzZcb4H4sVlIytplIX4Q=;
 b=mat41avM8tBVy1PWBZZ+bK8Dm6MxcfQ1qcRb31dQO9ZQ/1yIw+IabwbAe3RLudlOt9sDN8pn8aMICxd/dcKEc1sYSv0sk7NaqP+o7/Rek8zn/8WPgCv34E0HnZv5dVMOLzDuBn31vG3JBM4ZUHZY1VaggQU3Oknw0vZiVEMQrZRnVAZ572PHGH/Fog/DF0m17du8ipNq0UmuPM4h68Gv5uWFbKuNTRZxd2BF8PYzc2/VhwEAfqFUzpQ+9mPFZ2BLlILvCyXTQqRXm01kAaWIbDPayoXDFlqfMBghraTkvjt5wSNmfD9dyn7YIkHbdeCpWxv7YI/2+eXSBAklXqazPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vrcY8j2MM3yB5PQpMNIyq8UzZcb4H4sVlIytplIX4Q=;
 b=TKF9sss4lFmDfKif3KCUYfSHsllZH3a0h0xTjEtr3LZs4TmOKAI2nKhhO8AsSkgTkzgQdi6l4pj0JNTiTR9Hklfif+hsd1hR+FYZzS2sZ8VoHkWVQk/DSR167PCvL7HhpROsNLHWgtG53PUTkmLCkD0GQ8Qz5aL/3kThDd1NLZE=
Received: from SJ0PR13CA0189.namprd13.prod.outlook.com (2603:10b6:a03:2c3::14)
 by PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 02:08:08 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::bb) by SJ0PR13CA0189.outlook.office365.com
 (2603:10b6:a03:2c3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.22 via Frontend
 Transport; Mon, 13 May 2024 02:08:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 02:08:07 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 12 May 2024 21:08:04 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Mario.Limonciello@amd.com>, <gautham.shenoy@amd.com>,
	<Ray.Huang@amd.com>, <Borislav.Petkov@amd.com>
CC: <rafael.j.wysocki@intel.com>, <Alexander.Deucher@amd.com>,
	<Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 06/10] Documentation: PM: amd-pstate: add guided mode to the Operation mode
Date: Mon, 13 May 2024 10:07:24 +0800
Message-ID: <fddc124ee098bbf735c25431a68a2ed4f7c59ce1.1715356532.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|PH7PR12MB6000:EE_
X-MS-Office365-Filtering-Correlation-Id: 7794f2d8-fee2-43c2-0ef0-08dc72f1884e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|36860700004|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L/xtjcQ8aKoTV7QYPK/BkOCOA1CJHcrPOjfkxzJDRNdZX8M/GJjPZ+L34oBL?=
 =?us-ascii?Q?LLQ2d4C9gGyIZatXJC+F2bjvPLE3VshcHdxWT4ipUJEdg4vN6S4/JrmZkYpM?=
 =?us-ascii?Q?DY2DwaTpB4n6MnJ+j7ixWQUig4A4cBcpW2deGnHk1qHvCUWJTboM6V3kzvoB?=
 =?us-ascii?Q?xsKIEUninVhxHJC55EsuiDZtCewdnEeD9ViNxCbQhaseHouQSXmpxaZFHU+9?=
 =?us-ascii?Q?X87a0Smwvn2yJtDXhVMd2+p7AVKLRX3rIhXdD0uYb4o0nGeY7E3QhW2je47G?=
 =?us-ascii?Q?vOPNjksuVzBWFt7huhLMDpkiidWyJeSepVegFvRMDCth0I7YZcgZvZIO/JDU?=
 =?us-ascii?Q?ik9WmA1ZfV9WRlJ9AX8zsdJj4z1b3Q/f9XLeM7isk2WTpuNatje51LtdwoX/?=
 =?us-ascii?Q?5JhnD2U3ttQDteFaRJWUk5RkVe1HJTCrom/4B9/1JJY11AZP6im5NH1HSNE5?=
 =?us-ascii?Q?0DkF2FG8g8BqbCWck7wM+RcfFCX8vm+2QyVDzBOPYuhn7WgaghqXJHB7mLee?=
 =?us-ascii?Q?LTLdQjGZ0OhSeYdRRZWun1cZENNvO/8rvpoXB4M3NJjZEvsvxdbtjYo/r6eU?=
 =?us-ascii?Q?oPZzZ59F4eXWhJjRb1Lepj1TiFMJLaljdqtLT41IhcOfpMXWdJQTTwO1Yxog?=
 =?us-ascii?Q?yMuqRSXFugnklPL0KfRb7aPeh7Y/KGiIoH3e33AXo35EG3vgBkvXO0iypAiL?=
 =?us-ascii?Q?Uy+C7JSI0JeiVbzHuVEHHU0UeRAnlBXS1gJ+9prglMCAnDlhhEDH96tGHKa2?=
 =?us-ascii?Q?H+vkZXxsS9bu/2V+WoEhlU0/G+Ax+plAMryOtxPqvbkDDaXxkot1afKiYzX7?=
 =?us-ascii?Q?nCfxr2tp1Fb/f161wMM3X/7BhUe8HvOxhATiIJ8NvqKk1zgmXnm8t89oorPk?=
 =?us-ascii?Q?+c+kaD7YjCSJ7w+k1cp8u5jp+E38lc46nAAa7+WaR4b8kzFP0ZcFtK3OS64Z?=
 =?us-ascii?Q?yIEHQo/mfcokcd7NAf0cvwZ+JqH1AzDqua34OXhKy2usjPz2lDOQNdFaBq1q?=
 =?us-ascii?Q?jih10Rc8qpHLPgvyEaXpEpFGeohBlQpis5265CmkacQA3KCksXYopBvSMaBb?=
 =?us-ascii?Q?v/ON3QOeuHd55k9uEdQe9MyjjuIgVVOVf7Ei8Nn5qN+Sa4UZatwGxK5Ar+mj?=
 =?us-ascii?Q?0rafCOp1zmK4vqhe9xjYmVqVS6+4Pph70tv7ufdT3hOVsnIPkw8PXI2TLOx/?=
 =?us-ascii?Q?rYSFlG4GucP6v1VgEpdxa2l/o7cBWqm6O2THeILt3DJ8YDe3BocxI6AlpPlw?=
 =?us-ascii?Q?xt4Xzos/LgStBUjo4oYC4KJaXvd1DAeHc/K4wja1ydWCzld7ISfHDWPKiiwH?=
 =?us-ascii?Q?GlS80DF/g67kl1CgOyGa1HIyURy9+arOzW9r2Izh/HQ+W/pdoVw+XSWnlWJS?=
 =?us-ascii?Q?IsQFjBgy65kGFGUSij8iP3RowwYR?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 02:08:07.8019
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7794f2d8-fee2-43c2-0ef0-08dc72f1884e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6000

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


