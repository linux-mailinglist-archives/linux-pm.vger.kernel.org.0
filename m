Return-Path: <linux-pm+bounces-16535-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D63169B225B
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 03:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6645C1F21CC1
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 02:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CC618786C;
	Mon, 28 Oct 2024 02:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lJHOYuDF"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2083.outbound.protection.outlook.com [40.107.102.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9D51684AE;
	Mon, 28 Oct 2024 02:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730080995; cv=fail; b=rMaEB3YcDxb8Ba3ejydDEGliM8xdoeDuddwYszQpERQe9Ji49kLA2051gx6IzkFl+YOg2cLcN1S0N0/3Z2hVCsUfQWUxNiX0J/uEg9CVq+ylvCBgV0qy+rScJS2/NaZBuw8KDa3c0pWJo5mHRwTlXqJoSRB9jp4/aTFVeKmn3co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730080995; c=relaxed/simple;
	bh=WGjN2u3iCoFaur2gU0r1I1LPPpfY7Ipos4p/K4ls2xE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d0egnUoinRzS1YZKXd9JwkhgjRDcxyGvy5RDaTWoD+ln2lnJ8lTxgl84y9Wm+3YOwIXb+JtSWvq1yH60Vbvd6AuYvL5BRDJMk9t0FLZznyaPO+RFVE3P3TZBKOjQUITcDJ0UnyXLgmKLyr3RGLtkARMBN/YjvyckvSHyfAt18JU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lJHOYuDF; arc=fail smtp.client-ip=40.107.102.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vlgbGiHu+vBhhbowhw1nOulbxyD9BeEHuz7aE65eR4O6TL7+U3vyl+aM+7qQZdQi7MJa+W508a6LBIRA8jpbqHZDQw7Zn9Lel78qZ7p2Y580Symqoro2UG3hcsfPVARBpbs8aXKJ5M5ST0bLZzZxaqNrRXPzmQqohBPxmSCGyiqxP/q044MGfpf82uRsWN2vt8oFtBt7ZUwM4zUea2XMtI4xmKpNCgP6miwNkD+nuPDlIFjbmtr7KIySYH+jBWfdn6fzUvk5C9cFMCKi5E28a+IbZsAGFA212ek28LwR7jM9befQL5QZm2IFu0qZ5AskHT0eHU5JtLf7QEJv14I09Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VtR7nD3RkhNehMqgD/FWAyujtGqqRYRa+//G8UIW1WU=;
 b=kbd3I13M2ZH8iA2FUeCJY5O2+1f0+Kv5Nm5IgYrve5HDkNV+ffBugB3CpFUzHzHhwoLgHOuHL/c8frwtNtBkaFXs7JHVBfwxA4xyCYYOuF8r4F/AYNFpGaHRDu9DQ3tRCq1g9EVUXKmRS6uYfh9mBwjdYMSRxgp1o1VyEl3yT5PmL+dGy4iVWrmB/h/r5FIyr8PtDGOByqmG8JmTKb14z5LgNHkCiJI3RKz4ryKBPNKDig868UNYUXYfoXo84hkxSYir5aRPz+Q7o6obz5+NXRSKgdQ+HLAN9YG4JGktVwVcMbJ8GzjxZNAtTAdYlwSWf+Hp0Z2Crua4k50Vh44g1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtR7nD3RkhNehMqgD/FWAyujtGqqRYRa+//G8UIW1WU=;
 b=lJHOYuDFe5CkSkDUi2yGb7HZpPelYMqOyFEjgv8UklUKG9JoK5teqdh8V5MUvadAf0/yHMdE0Ltl3VmhYSuOQ2IbRYTpsQAkY3+U95cetBnzetV47loagUoX/EftKFMJtfmh2MPerTGaYXx1BNzXsKwyAkUfcce5Io4oIxbLkdM=
Received: from MN2PR06CA0006.namprd06.prod.outlook.com (2603:10b6:208:23d::11)
 by CY8PR12MB7635.namprd12.prod.outlook.com (2603:10b6:930:9e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 02:03:10 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::69) by MN2PR06CA0006.outlook.office365.com
 (2603:10b6:208:23d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24 via Frontend
 Transport; Mon, 28 Oct 2024 02:03:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 02:03:09 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 27 Oct
 2024 21:03:08 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v5 00/13] Add support for AMD hardware feedback interface
Date: Sun, 27 Oct 2024 21:02:38 -0500
Message-ID: <20241028020251.8085-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|CY8PR12MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e58c06a-1e62-449d-5af0-08dcf6f4ac27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p+HFRP8/ZhZYzCJXFRflISU9KxVjNnwxBOZCimIjaVkihymLXO0N6dJZUx/5?=
 =?us-ascii?Q?nfIgil9cvr4wWCLkvqb6zY9z09J7U/KLy/NXGfI9VOx1sjEVfrWWCytawV84?=
 =?us-ascii?Q?pjpVNygksfCW6nAUOCMEhwnW5vtufvFiJ/dIFrLbSedj8GfiQ/f5wG9gG7eo?=
 =?us-ascii?Q?1VJVwPaZZG3D+v+/3/saudgt6BaaniuoDwdt8vyGbR5GYa6zQsNdD6g2GwxK?=
 =?us-ascii?Q?qSW1fMRzRizk+x5pE6o+HrGC64f/0U98FnyZyK1k2GWi7a9kgrMMo7QHZsvm?=
 =?us-ascii?Q?damZl30Ql8ZYF2IT5cESruPijw/4uO2dx3GUbLGFmbAsUksUqIQYCpc2UJLf?=
 =?us-ascii?Q?wz+cPu/RY9S4SVPAVq30BFzBjIGrON+fDQEmy/AGTu2qkeF/DjsnlmF8QrVc?=
 =?us-ascii?Q?bJBUdnHHl09Xoa0sUpXQv8mbyyraNg5scEkynPqTIn0gTDqIUBJfUKuDxa/T?=
 =?us-ascii?Q?6vVTyTVzc1EYTDTZY+AU3vlDiFMGC8JZzpALHW0BFWfg1rm6iAngnSgrbw3a?=
 =?us-ascii?Q?SP0oX5vFNZdDvo9JAdgc2tBq9gYx/PRq08dWhiLXqP6SrP0GRQU8MRti+VaU?=
 =?us-ascii?Q?/lDXJVZMwZQsPpjbYFm6tdhIAM7YdPuJ2Hx9e+gX1gkS7ti35M8v+XX6Kr2/?=
 =?us-ascii?Q?kurdrmqyPTsxJU4Bs8KY3ZDruBoeHpr8Sa5NN+02oXIkfeWx6IGZHFgXbQB6?=
 =?us-ascii?Q?mhHZ8P4g1Zx8rZyRTBKv3HWauYbR9aHIbRJAfUloqa9v0JqMIa3PRS6C+sOS?=
 =?us-ascii?Q?P/pzrNEp4g63e3i01h3DotiE6cEYA11YtLfnyYAep6PBSQtB8vkDsj+SJxpP?=
 =?us-ascii?Q?n77/K7/j4dMZ2xi/lyeGgLmhEDrlLJSPb2dxCnU/oQHaP45xQAD4YCsTMfgE?=
 =?us-ascii?Q?UkoKT/hR28zQA0zMXZWNtjPy9lAPud8WkPmAQeghMxJLVCAJFaoh3aE2vzAU?=
 =?us-ascii?Q?PIc6Asz58KpGGqU1/McuNCyh+QSuWwBCReuZ2oX4DgYjplyg2jFJG8r9cPKr?=
 =?us-ascii?Q?oUylON9ZZYqZECOFxihRO0/RBxsCYIgwdAIhKeJMZi4JLlbPNKeh+4FaxGlX?=
 =?us-ascii?Q?54gHYkQokHLbXonlBMUbyEr5N1AF7p/Hx1GEWOCQA1XBb8m3vBm1MznMdlyU?=
 =?us-ascii?Q?vQR8gAwJCFQLQO/twBJFYnM+l+hkdsF6j8ASm0h2Ne+fACtnQ8Kbs67EB29Z?=
 =?us-ascii?Q?qrczw1Cz/ia6LqxJY+FlaejE7WtYM/mWpkLUoKoJNGSOO99OtWrMfNVRS0HY?=
 =?us-ascii?Q?CLtW8XmAwTO8tbP0qCrfx/4faVXVTkeqYi5zHRS0JB0M3+BJw2v2cHequVl0?=
 =?us-ascii?Q?2T5/666t7kYu9ztalNbaIbsF1yrbWfpn5kkDIK/N+vouW2xg5Ndp1FECLVnf?=
 =?us-ascii?Q?saMxKTxapCpbStw6Au/tPv99eoXd8o9WPky751Rr2fcKFwJvMQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 02:03:09.9699
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e58c06a-1e62-449d-5af0-08dcf6f4ac27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7635

The AMD Heterogeneous core design and Hardware Feedback Interface (HFI)
provide behavioral classification and a dynamically updated ranking table
for the scheduler to use when choosing cores for tasks.

Threads are classified during runtime into enumerated classes.
Currently, the driver supports 3 classes (0 through 2). These classes
represent thread performance/power characteristics that may benefit from
special scheduling behaviors. The real-time thread classification is
consumed by the operating system and is used to inform the scheduler of
where the thread should be placed for optimal performance or energy efficiency.

The thread classification helps to select CPU from a ranking table that describes
an efficiency and performance ranking for each classification from two dimensions.

The ranking data provided by the ranking table are numbers ranging from 0 to 255,
where a higher performance value indicates higher performance capability and a higher
efficiency value indicates greater efficiency. All the CPU cores are ranked into
different class IDs. Within each class ranking, the cores may have different ranking
values. Therefore, picking from each classification ID will later allow the scheduler
to select the best core while threads are classified into the specified workload class.

This series was originally submitted by Perry Yuan [1] but he is now doing a different
role and he asked me to take over.

Link: https://lore.kernel.org/all/cover.1724748733.git.perry.yuan@amd.com/

On applicable hardware this series has between a 2% and 5% improvement across various
benchmarks.

There is however a cost associated with clearing history on the process context switch.
On average it increases the delay by 119ns, and also has a wider range in delays
(the standard deviation is 25% greater).

Although this series most prominently has changes to platform-x86 it is based
off of tip x86/cpu due to changes queued up for 6.13-rc1 that are dependencies.

v4->v5:
 * Pick up tags
 * Modify where setup_hreset() is called

Mario Limonciello (4):
  MAINTAINERS: Add maintainer entry for AMD Hardware Feedback Driver
  cpufreq/amd-pstate: Disable preferred cores on designs with workload
    classification
  platform/x86/amd: hfi: Set ITMT priority from ranking data
  platform/x86/amd: hfi: Add debugfs support

Perry Yuan (9):
  Documentation: x86: Add AMD Hardware Feedback Interface documentation
  x86/cpufeatures: add X86_FEATURE_AMD_WORKLOAD_CLASS feature bit
  x86/msr-index: define AMD heterogeneous CPU related MSR
  platform/x86: hfi: Introduce AMD Hardware Feedback Interface Driver
  platform/x86: hfi: parse CPU core ranking data from shared memory
  platform/x86: hfi: init per-cpu scores for each class
  platform/x86: hfi: add online and offline callback support
  platform/x86: hfi: add power management callback
  x86/process: Clear hardware feedback history for AMD processors

 Documentation/arch/x86/amd-hfi.rst    | 129 ++++++
 Documentation/arch/x86/index.rst      |   1 +
 MAINTAINERS                           |   9 +
 arch/x86/include/asm/cpufeatures.h    |   1 +
 arch/x86/include/asm/hreset.h         |   6 +
 arch/x86/include/asm/msr-index.h      |   5 +
 arch/x86/kernel/cpu/common.c          |  15 +
 arch/x86/kernel/cpu/scattered.c       |   1 +
 arch/x86/kernel/process_32.c          |   3 +
 arch/x86/kernel/process_64.c          |   3 +
 drivers/cpufreq/amd-pstate.c          |   6 +
 drivers/platform/x86/amd/Kconfig      |   1 +
 drivers/platform/x86/amd/Makefile     |   1 +
 drivers/platform/x86/amd/hfi/Kconfig  |  21 +
 drivers/platform/x86/amd/hfi/Makefile |   7 +
 drivers/platform/x86/amd/hfi/hfi.c    | 547 ++++++++++++++++++++++++++
 16 files changed, 756 insertions(+)
 create mode 100644 Documentation/arch/x86/amd-hfi.rst
 create mode 100644 arch/x86/include/asm/hreset.h
 create mode 100644 drivers/platform/x86/amd/hfi/Kconfig
 create mode 100644 drivers/platform/x86/amd/hfi/Makefile
 create mode 100644 drivers/platform/x86/amd/hfi/hfi.c

-- 
2.43.0


