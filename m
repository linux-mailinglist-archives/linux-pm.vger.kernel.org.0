Return-Path: <linux-pm+bounces-9284-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D74CE90A64F
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 09:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDA6F1C25EE3
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 07:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0E918FDA1;
	Mon, 17 Jun 2024 07:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EHgbCSw1"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EEC1862AC;
	Mon, 17 Jun 2024 07:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718607637; cv=fail; b=lrvT4H1kfknMQ+sOxAfReiQH+bNeXk3T8HRsj/StXFr9FSOHVy5mx4xJAdpyVYaMwRDIdoMwVfFfPCz41PiuDAY361nhpVZBOz80TZVOCCU7MaBxqA0CLtplXk5itrbG1XNNfGozPsEYL4KzSy28ct5G1g7b55JAbFtogvKEKEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718607637; c=relaxed/simple;
	bh=zNufLEi/XPV9sbcweJAk4qjsYK2eAagDZqRL+IHYhp8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oZJ6oEaCJTDybG3B/gbAUmlYbiJndlfUwvtTprf0Fhwkr0mOUW2vmUa8jJ9ACYpcxA/mQ2xu1EP98x/u+5o5F03cIk4TPHYb00ye3+GxC6J1Ic5v1i2pK5PX7Tdo4V1aZfDjFHJqyS6gKQ19O40MMLueGymFyWU9wQpPxA9SYFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EHgbCSw1; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQcO4fGd/ay45aHtWfviY7UKId9ltcgUUfv9k5+cKtAXNMmNmIcq7aM/sMoho4rE69eBI+2nNx8ALWPoCg6XEr04KmRYRehauspHN/JBSGd76q/oUjLvqfRbJtl70f+M/rNIhIPBmyBloCIZ7DT5v9VUbOqf3iNvMrXgxHHv73KINMr28IUKSGV//IhCcgILfvjfWh3vJ6sDBDg5UOFXx4ue2jUQIjgq8kQAUt6Ah4jbDVWKflumGcmtx4cRV7h7gt4yH2Ji7zdWA94LiDuksl9AZXKbX8IwPIDwOfQUavPmSr/7Di4v81emu8upqBWLd91zGOBfhh2xlemb8I/tcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iacGDM4InEKvnbWzHxYOTdseMG8RWhIduvrQMmoSV6o=;
 b=Oh4oEDzMmX9vQaNrpG1CCCy9LTFht9xFdW1rSE04EbA8lpRR0z1lz36tzlFmxfjLRrnbJHdo/utifG2a6fz4VBA/Gsnua1F1Cl3fJIb+GMcjw6CDLoY3hUTUdSP1RzKEV+bqJdlQHClJfLoT9sB6nNcNfXa/LMsoxITjCzUaDK4So5GPG/EkV8yX4YMpqxAq5MRzsFFOfTumeUlAwgUQZJfbtt8pgSwWq9mRDww0NnetF2YiDu33ZyOAX0DNXlc3ib6vtsss5Vg8reNVGA/cvTuk8rM9LaGCq/vVkKBtlyDsd67UAbEIfi2P22wUK/9Ka9tI9qiGrR1a9td9Jn6I2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iacGDM4InEKvnbWzHxYOTdseMG8RWhIduvrQMmoSV6o=;
 b=EHgbCSw1OLF15THRe3qdTzYbfq4v486NGDnlCFQVnN5pMFBayKU6mN4j7itNadtiRZ4U2a7bqajL8jBMSXOpRAqJRQQ5bkIWaiApTVm8AunKya09z3IxsW0lN8lrxwzryg5Wify3EWD+krBHwirSQeP88Rw9OOCKYzUouu6QpGs=
Received: from DS7PR03CA0142.namprd03.prod.outlook.com (2603:10b6:5:3b4::27)
 by CY5PR12MB6527.namprd12.prod.outlook.com (2603:10b6:930:30::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 17 Jun
 2024 07:00:31 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:5:3b4:cafe::5c) by DS7PR03CA0142.outlook.office365.com
 (2603:10b6:5:3b4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Mon, 17 Jun 2024 07:00:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 07:00:31 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 02:00:27 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 05/11] Documentation: PM: amd-pstate: add debugging section for driver loading failure
Date: Mon, 17 Jun 2024 14:59:07 +0800
Message-ID: <ce88d442ba6398853ac63351107e0028ef659660.1718606975.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718606975.git.perry.yuan@amd.com>
References: <cover.1718606975.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|CY5PR12MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: f3121d03-f822-441b-fbe6-08dc8e9b2d9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1AuwBdwDPCH0Z6HZRvLr8GLNq+d7AqvhekpsYJd2crizASxmuBCXmclhR77D?=
 =?us-ascii?Q?E/xvDnVXlbq2LjhvXfCWVu1jcxDD3qOh4Z0B92eA5mYzbxt0Y9CF7ZpptXmo?=
 =?us-ascii?Q?V6XMvyCOTIrTP+UbSOscPp4lIYLq2Ohdt8Aub/W9if3qOlxXQNPcI/DYU1Z/?=
 =?us-ascii?Q?hRF63zMm1dnI3g3CTL6I0/ypdrTW9pcmlhrqZcpvaIWAzw9sXCekQwuknTJ7?=
 =?us-ascii?Q?UerdP/Ad/WT0XyVKN1GapZH8wPtzKy5KtWxW/iRX3bWSwU6xB+YMwjtlH0mC?=
 =?us-ascii?Q?gYboJtqRJoXtTCIqI2F5FZ6hI5+Y+n37CKRvQVR2i+3mfETrH1pYHAR2kQbC?=
 =?us-ascii?Q?WpmL9TeCSpyV581dycatnf2WyF1to+mvy6cWg9pe+JZNdhlDj76CNqwwj/rN?=
 =?us-ascii?Q?6fz0H3SmZVIpfjvwYnHjmqLGvC8LJAQSLxpHoY0pQWbZ1g+Ydfo/odlVzYAz?=
 =?us-ascii?Q?+fHmH5Pkpdy/vD7gWac9AUA4NCKtmCv/93flUXL8NVcfdRLhRiVK28lMdqvv?=
 =?us-ascii?Q?S/lG9haT4svQjb69gZUXpSla9FhgdrFgrXQs8FoPPsH0ZD+nP/qSEZYs95cj?=
 =?us-ascii?Q?xv16/N1BoEeJwxozFMKSw7ej/NE6c6ZEVKJbdP/EFSW3SRuNJ+kgN/bQ1v2S?=
 =?us-ascii?Q?sX0QpGdRBHhzTg+QyOB00BHD/Ao2Jz5XjKzxG8BQ6kSuQf3RqAOievl/2hKs?=
 =?us-ascii?Q?cppak/JISLEObY3792QzJ3ke2k7je7XWJ0SeoXhd8WuL6npMl5F0/oXM03VH?=
 =?us-ascii?Q?NxruYROYR6VklA8o+GoH7UxBi8JyX5vfDJNPGaA2AhcLBrxdxp+ZPH9RNonB?=
 =?us-ascii?Q?cnjYY+QXsCbLFl8taykHlKYRocFi4uqUOemy8Z0s7z1CSkp5/pELlUfmlyd9?=
 =?us-ascii?Q?hBST1xOapGR/QjFkR4QZTe44N0yxW+7HSsuZz4VIjT+fsTEEFZOvHmXAhoUq?=
 =?us-ascii?Q?baL3EktXYUiJ2yq02L4HjrsJFq5wha5DW6J1vcC+XYf6isWDX6MtUWMuHTPa?=
 =?us-ascii?Q?aFbJAokm9EJrX3Susu8EANTx6zyH269MbT7xn2t1xy/z6uizGqpILCulqkbd?=
 =?us-ascii?Q?TgWR6yq6OZe5Rt1eGepWNWDrk1KUzkmVAAcAIbnuAzzhZq4xmTIA70Ww5vTg?=
 =?us-ascii?Q?BNwlYguY4HS+HeX4gJvRi2iESM9kk/9jzXoEB20xA2kZy6ofiNbD8iHlUMA2?=
 =?us-ascii?Q?f6ggxgD/KHmuAO/UyoicWEHGO/QPJFzcS2fZvpXRoOYqitdr8mIQHvjK5LJT?=
 =?us-ascii?Q?tg6LbSQ+8SQZKrFB+OgXvAx/BUuDUH8etnnTJkja03h3Fs9forJWNADPvlna?=
 =?us-ascii?Q?Ul2yLvN8oKQInnf4pGNQLv5XOdF6+D5jB3y7BwQ0xfVDuffZ4O0EzvofNd28?=
 =?us-ascii?Q?ddR+XXvbGb2yu1gA89nkRUZ6FXlcCRV6lQ/3UXX49qtC+wyKPg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 07:00:31.5299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3121d03-f822-441b-fbe6-08dc8e9b2d9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6527

To address issues with the loading of the amd-pstate driver on certain platforms,
It needs to enable dynamic debugging to capture debug messages during the driver
loading process. By adding "amd_pstate.dyndbg=+p cppc_acpi.dyndbg=+p  debug
amd_pstate=active" and loglevel to the kernel command line, then driver debug
logging is enabled.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 1e0d101b020a..ceeb073c9ada 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -472,6 +472,20 @@ operations for the new ``amd-pstate`` module with this tool. ::
 Diagnostics and Tuning
 =======================
 
+Debugging AMD P-State Driver Loading Issues
+------------------------------------------
+
+If the amd-pstate driver fails to load, additional debug information
+may be necessary.
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


