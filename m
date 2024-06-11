Return-Path: <linux-pm+bounces-8921-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 643ED903723
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 10:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0646281B2C
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 08:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9335178CC3;
	Tue, 11 Jun 2024 08:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oVMDevH9"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D28178394;
	Tue, 11 Jun 2024 08:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718095985; cv=fail; b=S0NyKmdcv/Hd7M1ha3jHrezzCKy2khwcF2YLGSUqLMNg0OhjXDnhCE/qWvMFgkS6WNuEHvDBx731dBtiHx7TXmaM1o9Kq0gJL9WeyjbghKpcZTvc7giO1AeLtJerWd4LZ7lnhEa016+LBmsABQvQgjKrx63eNUtokURez/xRk00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718095985; c=relaxed/simple;
	bh=cOXMENuVdaADztOx21wcB1GoqOtFGByhFz28UNsMN+E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S/5gD+qz0JzJ12wPRJfPC8q8ggIzeVLqz7pJVPPIk6gnMvFAwK3FVevyKBsGZLe4dN67qW9eTQh0B45+w0hNeT3F10gS8t1NtmmtqD5F2QvWApULXtHyUsMqoeIy+9T1VtYkC1OAuOqlI1TPVQk6RWpafJvdvCb2s5uLNMKZSFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oVMDevH9; arc=fail smtp.client-ip=40.107.92.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KVwhVnRYYYtdJkSNhRnUEwR5sFH9Q7XfzKgSWOKmP4XILXDH7JLkyIbef4DLneSQGIleXHgMf3p/d2HknHZJwKUAJjTzT8qaWFoX9BUuKp8LvqRBscof8l4VWmOloF9gAYJU5MrhA53+tKmfpESL2DpT46Z6EYgEOn/ZDEqjqEi600UsR2brAGLZxggqw+hBn/R/6Q0JETQm0jljYZz9Z+MXFoWvk2bVKBo2yToOtpexdfaI/Gu90uB2ba9IDhwEELaYzaCJaXsZHzXG8rv9CueCW2RclQI2WDZo+burhfLyoHogX2QlztfxgjcryxSOGbl/FL5VqPhAh8yEKFuRnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOf+kiEqDJ4292Jkplvh6XWxS5iJPzeS85DFnIYQ+ac=;
 b=KG1kSSk2mt4vdaobj+ERQsQJL3/C8lZLbYntcge3u5Ic4dWDpJ/W2X19vDntJauLrtOmTOTL/Pp3/62ceycXgHX5FjSYEXoPfS+nYuU6eZ7N6jkCY8REQmOkDBZJlXajFM84IwmtSJ2n7LukoxAH4GFPeihRBPkF3n03lRDkH19fZ7RKit8IoK2h6y9XZ4fYVdJPTSQG5jul/ard6PaqxDSKFDSRIs3/tAdmNvCSeoKv+pj9OxnGP6huzPHOVjSs/5LbdllMwM6+Pt7FGrk/EaNhCW1oI+4yiRnkHAqPOrJJZXgQtuGvzjtuwoP9wEeYQLLUfAI/NSDl2J87xa0uqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOf+kiEqDJ4292Jkplvh6XWxS5iJPzeS85DFnIYQ+ac=;
 b=oVMDevH9Z/HomUgkyY1jO5JpyFlZLsBjsy0ESvz4qkR3+Cqh8k+k9WnKQ/TTiaLvTNFQ4BmDU+QEoJcZr9jcVHeHTKDPmWrVJAKzMB/cSsvQ1eHXGhyUGfeTOdXkhzWbqp5qsJ5TS3jQY38t77q7nsCnx+YBSmOiN309yC+LEF4=
Received: from SA1P222CA0172.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::28)
 by DM6PR12MB4402.namprd12.prod.outlook.com (2603:10b6:5:2a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 08:53:00 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:3c3:cafe::12) by SA1P222CA0172.outlook.office365.com
 (2603:10b6:806:3c3::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.25 via Frontend
 Transport; Tue, 11 Jun 2024 08:53:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 08:53:00 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 03:52:56 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Mario.Limonciello@amd.com>, <gautham.shenoy@amd.com>
CC: <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
	<Ray.Huang@amd.com>, <Borislav.Petkov@amd.com>, <Alexander.Deucher@amd.com>,
	<Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 05/10] Documentation: PM: amd-pstate: add debugging section for driver loading failure
Date: Tue, 11 Jun 2024 16:52:21 +0800
Message-ID: <18032dece7cb9089bf82f2b37c7ab781148d70be.1718095377.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|DM6PR12MB4402:EE_
X-MS-Office365-Filtering-Correlation-Id: e0b88511-06f9-4297-97ee-08dc89f3e58d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|82310400017|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5RmWTZucnSnWeoF+EUZa87wtjBv6MW0M8CqJw3UBCq4HOJzu6IzV8xek0zrf?=
 =?us-ascii?Q?/gDViOICeYKNM+I0E3F9FGFAppHKZUOKVabbcBbeCZlq0aDGcWTqvbXzU/Bs?=
 =?us-ascii?Q?/Mx/S3+GrLlsKA7OZCahCHNeJX62brSDkELM6QGB5jiG4DlueFBFZalPJTiB?=
 =?us-ascii?Q?coMbksIfPB/TWGDop/zO6hVbHDqZbAHJS9oBHOfkuL5vHNOG76rsvyu/3O/3?=
 =?us-ascii?Q?25Jad+EL4w36CY5Q/nkN2qLzcQ87iaeBrQVbn+0Zf/t8dXk220BG/bdrW3/p?=
 =?us-ascii?Q?yNL+VWYV+SP3ATB1q9SZ2dVAT9/Li1uI+WF0X+BsDRZV3tvnAbS+YbkDRn9/?=
 =?us-ascii?Q?zJ6JDfvuyeHYBYPwpY+F8XwYdat8GImNjcdxohm9NJektVDywHCiQ2ovJo0h?=
 =?us-ascii?Q?3yZGQnMvMDAGkDc7Ym2OZUjOTaM+wPxIwr195cbZthCQsDME5OlyvxNQlVwq?=
 =?us-ascii?Q?hzowqC+9chktt+/KFU2FA9btQW+gSoJOTRHJGAhGpKw3vehsi9SWnbwR9Q65?=
 =?us-ascii?Q?5EQgDwDNtOJKuA+m4t2PLr49k7IlnpF4hcrGiZnqw5MywzRHoQ0DPQsRL8xx?=
 =?us-ascii?Q?UtPZb2YtOZY/+l6tjaRzNTeWpAW9Yhe9McX1D5UkJ+QKOcdl7XaB4MZWHdsi?=
 =?us-ascii?Q?UZN+VqSLQ8HJrAjhSQWxTuVPTJ6uszONFLHIE9SxpZYkCWaqDM3pcG751W2q?=
 =?us-ascii?Q?3f2Z6LkObZnzuHThDKKT1bkZD51fPuuTX8uJz1wv3oMAUX4bSnsFk5xVr/ui?=
 =?us-ascii?Q?LAkg8Lt3Wk80NPWXNmJYoXQVFavvttR/JUjnSxrorsSWp3cm3PF+5gLnGJk1?=
 =?us-ascii?Q?eldyPC0bKLVpLzneeMfNttrvvt7A85u8jRpFUSi5mYWDQ5LQ2bW9KVOZ3TEH?=
 =?us-ascii?Q?Szh4RV/DfubWiD3S6uimFj+bEmGLuZ5Emkpo+IjtUn8LskCOoxsUzqzpTv+v?=
 =?us-ascii?Q?J+4RHoS3cgXjzB00EteVNXcwzQyfYtIrU9TN8hCitV4Vy9mvlAXISZiaTKp6?=
 =?us-ascii?Q?vmOzKI0N++JP1Tb0NyPwp9797MDD0/Ld3LUtCd1Lx51d2yJvWOKpMoLL+uXX?=
 =?us-ascii?Q?6UmSLm2uGRoAeIb/9ECyovpqyD0vKcOy4cl2+JlmjolKxc6oZlvaRHj8+Agf?=
 =?us-ascii?Q?DgODObhLEoC/3T9zh17puk5uruftwsbwQrQoZVpa/wjpT0cg2NJ5mHYHbZBJ?=
 =?us-ascii?Q?/HzH54Sz1gLKRf9crGWZOimkTJdcxmipZKYdt91KO88q8TyAgpDMr9RLXE5/?=
 =?us-ascii?Q?+0V9a8Q3KUkhivqojTPPBWjTh9vCa0ZH4x0sd2qvW1wUP3QHir7iMJF2YcZs?=
 =?us-ascii?Q?3COHbTUxb12Khb6cm4u8WaNsbQv0yLSnYzGO6IjXjKjlUYl/4XMTvws+SvSH?=
 =?us-ascii?Q?w2qZrAQSjA8oWbfznjtrIJ6l/ZsES6qnyfLoK3TIlZijV8HnwA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400017)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 08:53:00.0306
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b88511-06f9-4297-97ee-08dc89f3e58d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4402

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


