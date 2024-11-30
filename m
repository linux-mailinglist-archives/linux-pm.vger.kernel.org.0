Return-Path: <linux-pm+bounces-18293-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 332DE9DF19B
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 16:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ECD6163297
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 15:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F771AB6EF;
	Sat, 30 Nov 2024 15:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U+RNzbTD"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991821AAE34;
	Sat, 30 Nov 2024 15:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732980064; cv=fail; b=McU8mLXvAuqQH6uGvXmRWYELs6M3LLYcv+PvRyKy5miiIoCHQOOMV8APwocfUjKBwUmxvum20oOPrpeHHOkjGsMdtSQfNx5GnSlhbO1oLyvJaCbeMoyXtaIGlnGadeM//WCDPz7q1iUW29sP215Bo0MeBr+6tPFEN07S81wtIq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732980064; c=relaxed/simple;
	bh=BFlPzCKDOQ/lwYLxGzA4h0BVSXB32LqPDTE4h2a/b/w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oHP4GfkXRn8PMANZZNQKGgQMP3dNUGgAb+Yy5gC5q11fBHdbCGlqkfhFh7VFqbwzZT/5z5J9tn+LqaONq9Q0oCKzme9PQOL1tvRTPpLnhL6fiVmbOLRABxFX7d/KSHw8/tX6/yshYCy0vL4MZQ5eAkSdjUN1zlwr8qGsVmPHbu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U+RNzbTD; arc=fail smtp.client-ip=40.107.236.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r+15WxwicGOZHW7qEm3Enfn7pR7SGRRaKHWBA5eGZO+41h3UacFMR0PvobQgCjhnOLbzVBeDnSZCra5WXHKqvXV8e5hRwykCFOHN+fDhYPPrvvy6BA+Hf+gQQHz7xck9RqBDr6ObNL96l4gRYSNuYYvsh3O/HT80qBXraV7n9DItU6M9C5/6x7i7CxhU0pn5bfNDUrKK4ATJL2mjduXVjzS0fYG/A3H+fYJQwpeXo3WDo4kzHS/Z6LceKQuY+S2mizk2wemlsHCxoHtbkK1j4aCJB/F9DbUEeQAQwnpHf5BHTVPoiZB7EWDBTAeLyOyvkD5nAngoHUs3DPIEcryjfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oye4hmxA/QeIDK9bNf843lF0pJB8f8VefTi8+5z/8WI=;
 b=ERkJIQKQcnOTizTB91TPrOjqb+GSq2g1LdZY+jdAJ21UXHv39/DJhHE1bDLI/yaAGBgZ5fWOia0VwbhMPmofgAJttiqqM7e5/mMCPM5qvVSjJ4rRJORd7vdo2e4qPAANuOUbVpSLLzikdstv86LT4Yt004MeMC9foVDwRDo7V95jcvvhcyBzAiwnTe6FHclvQQYpu4inJmZ9qpqNnFcP85Msb+mOvrDg+aX/J41Kzql3DfNUKsOh922pYqpfKjNT5car18oGagnEKX7XNvkzKyZ5w6XwGbH5K4qZD1KyLat1TlVji2mbk3IMjZ3pg6719mA/jrcuy6Z5ArsTM4yyzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oye4hmxA/QeIDK9bNf843lF0pJB8f8VefTi8+5z/8WI=;
 b=U+RNzbTDTcj9pMlcHkxQfc3NtASLwtcQ6iyEmyTGHSjyWLl8tQhF5JnpVhAEjmBTcQGY+EL0BsMx1USsRLSjeSeSgiE0DBRtXX4MOjOZon2vD99ENdb5dvmhvUvw1fW5kkGngSECjUNPqQ9L577qLxKeaVI1wIA/LUVD1uuoSj0=
Received: from CH0PR04CA0012.namprd04.prod.outlook.com (2603:10b6:610:76::17)
 by SA3PR12MB8023.namprd12.prod.outlook.com (2603:10b6:806:320::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Sat, 30 Nov
 2024 15:20:58 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::c5) by CH0PR04CA0012.outlook.office365.com
 (2603:10b6:610:76::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.15 via Frontend Transport; Sat,
 30 Nov 2024 15:20:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 15:20:58 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 09:20:56 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v7 09/12] x86/process: Clear hardware feedback history for AMD processors
Date: Sat, 30 Nov 2024 09:20:20 -0600
Message-ID: <20241130152023.684-10-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241130152023.684-1-mario.limonciello@amd.com>
References: <20241130152023.684-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|SA3PR12MB8023:EE_
X-MS-Office365-Filtering-Correlation-Id: ad811b46-f8f9-458b-cd91-08dd1152975e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nxFIelBMHZfSJ23zwsg5zbHBgqxnKSD4Prwf3UamlJHHE5u1a1F/Nkh6QXQQ?=
 =?us-ascii?Q?1ib1/Uv4KnMtjDo+BUDgDMzkItzmS9foD0B9aEUk94xr4gVkCWbZd4SAZHHW?=
 =?us-ascii?Q?91ulNAPhK/jQbvyINIvr5WxuVIjxWqzgFFMtWEJn3Yg0F00PqqaZoT2tteE7?=
 =?us-ascii?Q?Yp+XSnmMya9vRo+OZ7m8JUyRg+R618g1Bad8jgUO87cpNFe8nuDY9AOhYivI?=
 =?us-ascii?Q?HvuxnaDLExdSOJDP0N8DbT2aS6Hjkw6CebKR8uJOX/nbLLX6C92n3Ua8bSFv?=
 =?us-ascii?Q?L5PNJLBXQF8QA1f1L5hqmqLhj2J5a3ouD/s4CVNT4p3woOqVcGgpy3XUnrjS?=
 =?us-ascii?Q?KJvmtkdJgM0+VQIvVdCgLc1UNDGIZfbUlkFMYSdgowjs7aH1HCPS6eEih97t?=
 =?us-ascii?Q?zgCDykPFQpRMEeZt1x1U77lRjG8Ipm09N9RvD8zp5U3iQBlwE8+Mwp73Wq9h?=
 =?us-ascii?Q?9rt4avLtUdXCLk2Okdo/jl84Yl7zL4XEilwnfHrKoB9NSEOi/a6gL7QnQ+vQ?=
 =?us-ascii?Q?NldSG1q+uie5xYDcZUjZiuCaAovpsOGs1KYnZA/Qf1lVowVCyYI6tt5eJ7Qy?=
 =?us-ascii?Q?ZgNBPfQ2/r1FSCKt8TKTKXs79JED7wfuCAuBBTupvHjXw0nPPq18p9gv5vtT?=
 =?us-ascii?Q?l1pgOFCNHx/ifc5S8I2Hq3hP4HmH7zAJiH6HiTbLjN2umQ6RB5JDcxHqI+ZG?=
 =?us-ascii?Q?0RnIZKeQKliLGsbbkoziOdC8DzDBBTvKvWM8O0R01IofIhPjgPFk70u9Q6kf?=
 =?us-ascii?Q?1Pz9W3bpwpiO+qj7UthwVSSUe8kU7meqJpDzYNeybMShzr2MUBQArsyxbtPk?=
 =?us-ascii?Q?Py43SdeTNZM8qwccK4fRLj556yZQ8HrPgKUwb7qCrn3yJ7kuoiO2kU+JtZRZ?=
 =?us-ascii?Q?vdbsadKC+y70aT7MjLoL8hhpGXvxJseKH4gqa/Tfd/LjK0uslz0xKf+0ws+t?=
 =?us-ascii?Q?TVROYcxlQ4SPFYZ9QrXTCxvNjQ2RbYIiFCHNFcttU+N5OjEcQ3L4+k+Eo5Zc?=
 =?us-ascii?Q?2q2AEPFA3YQw8VGqNL9yj8jVYobjR0u/xpY2Wh/LNkoN7kBkJmhTUNCOOoSo?=
 =?us-ascii?Q?0cNPu/aB3FDHt5jWsgbenV+34EepH9gncver5VVbfPO4glt1Fv9z5CMmB9o3?=
 =?us-ascii?Q?bbDSbIO/eN0T4FJuveJVM1t7gzys6lsBNoNq+67orFvfSFQeHxijd8Kwuo1n?=
 =?us-ascii?Q?EucTaJOUFI6vca9fZyQOp6EGFcyK5AInDxktUOrbtNZrWpo4+bLS+PsUawe7?=
 =?us-ascii?Q?qOVjwmATq529mKphGvt0zGkkIspmcsFAwLwFb8upYfFyEVVT7ojR0R7qQUK6?=
 =?us-ascii?Q?uub2sKG+y3pdr+zJw3SS3Z34jQq+SHv1+mD03YIZf0iSpAcrKfybe4oajygx?=
 =?us-ascii?Q?jfQ0hB/wyYlplfNbUeZQ0MMW6wJ8SEHujmZzvN49cdxxnKhiG0yiY/GOVXNw?=
 =?us-ascii?Q?IECb252khbV9pmk1Htsrblbhnvy5rqdo?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 15:20:58.0104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad811b46-f8f9-458b-cd91-08dd1152975e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8023

From: Perry Yuan <perry.yuan@amd.com>

Incorporate a mechanism within the context switching code to reset
the hardware history for AMD processors. Specifically, when a task
is switched in, the class ID was read and reset the hardware workload
classification history of CPU firmware and then it start to trigger
workload classification for the next running thread.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/kernel/process_32.c | 4 ++++
 arch/x86/kernel/process_64.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 0917c7f25720b..0bb6391b9089b 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -213,6 +213,10 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	/* Load the Intel cache allocation PQR MSR. */
 	resctrl_sched_in(next_p);
 
+	/* Reset hw history on AMD CPUs */
+	if (cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS))
+		wrmsrl(AMD_WORKLOAD_HRST, 0x1);
+
 	return prev_p;
 }
 
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 226472332a70d..371e0e8f987fa 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -709,6 +709,10 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	/* Load the Intel cache allocation PQR MSR. */
 	resctrl_sched_in(next_p);
 
+	/* Reset hw history on AMD CPUs */
+	if (cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS))
+		wrmsrl(AMD_WORKLOAD_HRST, 0x1);
+
 	return prev_p;
 }
 
-- 
2.43.0


