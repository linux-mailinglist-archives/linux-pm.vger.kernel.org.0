Return-Path: <linux-pm+bounces-18285-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 873789DF177
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 16:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C9BB28176E
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 15:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C76C1A01BD;
	Sat, 30 Nov 2024 15:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aOxM3EU9"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D285C15539F;
	Sat, 30 Nov 2024 15:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732980054; cv=fail; b=YNhZPl25FbtauGsGKDwmYQu+9UckDW4TWaIRTom08gXonxdT+P/O3zM+GSKM99NRXUMEMAzMzMlV/3SB7gkFNbq1DFI31WBbEX7Pdg0Z1S05wX8+jmE76jTPgR6IQnTGq+LEFJfED/Qh0qJnbsJoNLu0Z+rLDFgnBDOo/2XPdy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732980054; c=relaxed/simple;
	bh=Ym4yT35wGMMQbxcWlPxkIQTjx8JE5uBWKCiNtRMfpzo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PMkyi9SfOI1bzzpR6+GbNG6wLgu00+SHAUB89u+kBUg1QcAo3ykoTzp7zB4pWNcn5B2g1+jJeN3nAV4TK/wUaorQlcH0buBx7pfEMJ5bZ7kGG2XargQ5YwXfxruo5btO2GuPzaVLhnjFa37TogNur+jN0SDivtR5gVjfgrLteiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aOxM3EU9; arc=fail smtp.client-ip=40.107.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YULwknrUvuH5wq2tt0eIvFCbfU9ZXIb/0cp3tYmfwKV8cHOz0BMOuVuoHRzVAhfyptYSemyvvmQhGhwIW0m/X2ANuW7Y8tIajoo815FnkNoI3EdL3oJ5HD64hGat7YxOlE1IkfZMvXbfganraKv6Z5DrIM02fvZORv6LVdwRxaHcX5kL8PL3XF2p4LYo5J1pr3BHW3n+wq+/YQih6Y+WOYvFriYJ+Csvf9ddxJpvt1XCd/lfk+bqYpWMfFijtDXQ6XDf3XmboSRAqEKQxUiJkIA6o/iHiNSALcD5vkeq3fH/YrrkxcmLeTfBdYfWkPxd41iJvemMcQR3asItQ1zP/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2IfDqWf+Mkd3RsyQnyNtAVKMN0tvP5deMjCf8zrT6EY=;
 b=pN2hN73eGa5T3DmC005GPaD4MXty6Rw4GPqtbNd7s8YUm6C8YAEiFqLxe3hP/eRHyb6jCgrYSV3a0zDJYE5vPtfA2i4/ftSOABhQ8qPZrL+KHqbpoJ96PuZspEpk9oJ9RFjg4fYDGKhWGtVqOb0hB+TKnGeb2QveEBVXPR7FIaZPsjaTLTMI4Vx7Y6z03FTWBlux04N3bTEPyL3bDsTNCBuYMSzxtacL9AB2an2uWonQy4lFB9rW2nltkpzsCltNSOtwg4RELh7c76tTOkhtj1cw80RBdLPzTOniBPihnUFLnlCf/o2CyQaPmakY+OJJ7PqxlWt2/IRoD9WVjqp6zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IfDqWf+Mkd3RsyQnyNtAVKMN0tvP5deMjCf8zrT6EY=;
 b=aOxM3EU9S0a2T9MmUCR4S596sVoipn6MVdtUK/uj04sgQhBYwvYasrh5D//C84FnD9vhnO3Sr3tEpjICpc0Y4RxIYEq+RA3llGZwEPmw+7kgQYUGFEyYoN2WY2AuWyBgSvJ2MHVY9rszuDkOojByvk7BsCya3jqjhuxK085kgC8=
Received: from CH0PR03CA0324.namprd03.prod.outlook.com (2603:10b6:610:118::18)
 by PH7PR12MB5855.namprd12.prod.outlook.com (2603:10b6:510:1d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Sat, 30 Nov
 2024 15:20:46 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::59) by CH0PR03CA0324.outlook.office365.com
 (2603:10b6:610:118::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.15 via Frontend Transport; Sat,
 30 Nov 2024 15:20:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 15:20:45 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 09:20:43 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v7 00/12] Add support for AMD hardware feedback interface
Date: Sat, 30 Nov 2024 09:20:11 -0600
Message-ID: <20241130152023.684-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|PH7PR12MB5855:EE_
X-MS-Office365-Filtering-Correlation-Id: 54b526bf-a020-4172-3465-08dd11528fa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2RseXNKakdRYmdhWmJlYjRSRktYZDFla1FoQ05NTS90YzErTmxzclFmQkZE?=
 =?utf-8?B?dG1hejVMb1U2eTRpMExrbFRQV1crdk81ZmlSem51NTU3R0hqdU1FTkNtMUE0?=
 =?utf-8?B?UEZXN3VZOHJEdTFGR3I4d3FKR1B1dThUWFJEZlFsQzRwZTBWeGdCUis0d1hn?=
 =?utf-8?B?NjFzSmVPdStMbm0vTzlyRUxRSXZFMFQ3TVREd3NrNlBVeVdOKzVuY0pjVXlO?=
 =?utf-8?B?MzAwN1ZhLzVUMnRCdElWS28xZm5UNHVDY0RMcFU2VFNpdUdJcEYzNXpRSWJu?=
 =?utf-8?B?aEd2Rk1ZRTFtRkFxQnZtUDBacTk5VHZ4YnBoM2lMNlRQalRsQWhRRmFPa3d1?=
 =?utf-8?B?WkNDODl0SjNvanhLcXpkV1ZOVTFWZTJoTDZOVUxYcWwvZHFhWjRYRDE3eUw2?=
 =?utf-8?B?ZUJwQmFrTVljRmVlRWtodS9ZR3ZPamRUVEZDdU5Fb0xCZjhoYnpCeXd4bHVR?=
 =?utf-8?B?cmtVUnBtRXBIOHpaY2F6RDh1TkVza1cvd1RhTWdtSkFXRUVTYkhaYzlnQnM5?=
 =?utf-8?B?TzJYSlVXMWlXai9CVU5NbU0yR3R0WFA3blFLajNPakZhY05MN1Z2RGJ2WjVp?=
 =?utf-8?B?L3cyOWVPUTZMS3dmWHl3WXVOQUhqYW5XYTFYRlUrWFBsZ2tWOThpMWdXQTY1?=
 =?utf-8?B?b1NVbHF2TjVYSDl0cTRodGUvYytlT1c1L25DQWZRbWgveFIyVm4vVGFHeEtI?=
 =?utf-8?B?WGlJQ0htT0NYcGdDdmVCOHFhcXBJTzYyYjhPcklIR1ZtUlcwUU1TOURqWTBl?=
 =?utf-8?B?amh1Tm4yYWsrWW1CM3JQcU1sK01ZSG1aQXJ0VGNWVnpYTzIzVjF4VFBjd3hp?=
 =?utf-8?B?WWdaNDhoY0d0M0hUVjBIWVFIeVNQQzF5ODgzNjNib2FKamtKVUxQanpESytp?=
 =?utf-8?B?TnlzVXVnYmc5QzY3SHl3anRzQXVzbmdMMjZxeXc3OE82VXJJaHVKdGJMUnVk?=
 =?utf-8?B?cG5Ydi8rYUpPMG9ONjVXdHpQYjJyc20rcWtZVHNDaXlIbXgxbUdiTDRmVWVZ?=
 =?utf-8?B?WStINDBPdzJhekhaOEFhQWRFSGNzMllSQWY3L1BjWWpPTk9vMVQ3aE1xRjFh?=
 =?utf-8?B?RThZK042VUp2V1B4NnhXQWhhUUdsazdHaVlKcGtJdTdXV3JsaEJlbXpCc01X?=
 =?utf-8?B?TnlYUVU0R3p6NmZpd1RDbE5BYm5FQnB6TDA4bG1KcmVaR3ZQQ2FKL1BKWnRV?=
 =?utf-8?B?cVFyZHF2WVZXRFpWWitRU0oyNUtPVGQvSnljMWlQWEdUMlF2eTJYTHlUVmUz?=
 =?utf-8?B?MUpSQUZsaEFiUU5mM1Z5L0greENsdjcwQ0J3S2l6N1ppOVpTalBvMHo3aVFI?=
 =?utf-8?B?cW8wY2xlREJsd2I0blQ4cTBQTWVvMEgzT1hoTmlsd0ZsMHRhSmJOVDlMbWUv?=
 =?utf-8?B?a2RXcG5wdlYwV2VocElySGk3RlBiVUViQXF5U0ozQXFQYkxlODVvb0tjYm5C?=
 =?utf-8?B?RlFybkRQNTdmNjZXU1hHMStCczR5OU1VUUZITk8rZWx6Q1l2NHpsUG05aTRj?=
 =?utf-8?B?aWdianc1TSt0b25adWtCdzhTT3d2cnBDK3p5d1VYQUo1VzVmRkNRQXBuY3NY?=
 =?utf-8?B?NjFJSHROc1NUelMxZ2c2NEdORDByWlo2UGdNM0tSc1VLSEJrOTdZY1dhYms0?=
 =?utf-8?B?SnBGOU9pQndVUXBaWlc3ejczY3AyRHJ4TEpvUkN3WjZuSEFsOWdFUVVsNGZT?=
 =?utf-8?B?anQ1VGlnVUVuL0NDaEtybkxPdjBNSVJpdTk3NGsxLzNVNElCN2FSZjltbVBS?=
 =?utf-8?B?eDhLVDYzU0VMMkMvVnZhVkd2UEd4QmhYMDZxYVhQSmtGM0xHdktrSmFRV2l3?=
 =?utf-8?B?OGU1Y0VqbFhFYzB3S29NZ2hQRXlic0ZCbmxWc0ZJd21SYjNPbGVwYklYZ3BK?=
 =?utf-8?B?emlBOGNpMFQrVzU3Yi9OdTEzL28wRElqRTQ3aFJYZE5UbW5pY2VOeHQ3WlA5?=
 =?utf-8?Q?nVh2jJYqK72FxLLtgZ5wOpFO/BExAaKs?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 15:20:45.0369
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b526bf-a020-4172-3465-08dd11528fa3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5855

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
---
Sorry for those of you that got this twice. I picked the wrong entry in my gitconfig
and it didn't use platform-x86.

Mario Limonciello (4):
  MAINTAINERS: Add maintainer entry for AMD Hardware Feedback Driver
  cpufreq/amd-pstate: Disable preferred cores on designs with workload
    classification
  platform/x86/amd: hfi: Set ITMT priority from ranking data
  platform/x86/amd: hfi: Add debugfs support

Perry Yuan (8):
  Documentation: x86: Add AMD Hardware Feedback Interface documentation
  x86/msr-index: define AMD heterogeneous CPU related MSR
  platform/x86: hfi: Introduce AMD Hardware Feedback Interface Driver
  platform/x86: hfi: parse CPU core ranking data from shared memory
  platform/x86: hfi: init per-cpu scores for each class
  platform/x86: hfi: add online and offline callback support
  platform/x86: hfi: add power management callback
  x86/process: Clear hardware feedback history for AMD processors

 Documentation/arch/x86/amd-hfi.rst    | 127 ++++++
 Documentation/arch/x86/index.rst      |   1 +
 MAINTAINERS                           |   9 +
 arch/x86/include/asm/msr-index.h      |   5 +
 arch/x86/kernel/process_32.c          |   4 +
 arch/x86/kernel/process_64.c          |   4 +
 drivers/cpufreq/amd-pstate.c          |   6 +
 drivers/platform/x86/amd/Kconfig      |   1 +
 drivers/platform/x86/amd/Makefile     |   1 +
 drivers/platform/x86/amd/hfi/Kconfig  |  21 +
 drivers/platform/x86/amd/hfi/Makefile |   7 +
 drivers/platform/x86/amd/hfi/hfi.c    | 546 ++++++++++++++++++++++++++
 12 files changed, 732 insertions(+)
 create mode 100644 Documentation/arch/x86/amd-hfi.rst
 create mode 100644 drivers/platform/x86/amd/hfi/Kconfig
 create mode 100644 drivers/platform/x86/amd/hfi/Makefile
 create mode 100644 drivers/platform/x86/amd/hfi/hfi.c

-- 
2.43.0


