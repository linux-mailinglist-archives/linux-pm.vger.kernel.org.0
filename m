Return-Path: <linux-pm+bounces-15696-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA3899FA2E
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 23:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 707441F23DD5
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 21:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AE51D63D3;
	Tue, 15 Oct 2024 21:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iO5tl2w5"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8F91B6D15;
	Tue, 15 Oct 2024 21:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729028248; cv=fail; b=q+J6dLZ57iEbBk7sX8qJxS5eVqsK5+QCGWY9XHWqdRchtClBtWvVY0+WcowGbmbXBk8UQKc1WeIMlsYEn8GwE+U80OQUZNu7i5Kl6HsN2qw5To0WJ6VnNy5G76ZvtKf9nOnAf4g1jL8cnOIrJ8af3iNbWOfuJ+po4ik5siKnCNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729028248; c=relaxed/simple;
	bh=3jQ5tjAANnR0+z6/r+/7tRw0uY8N+EOaXjldJC6Gpyo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m6ShcX68VlrBEiMUs9OkiiZvS6ZDwGt+0CxXtoqTiDFoUKkfnm0mHsjFRLyMhB0uWqrjRJGaszJXDW4KbGLWMRAlKjzfMKgLaJGmaCnXWxf3wRvgIm2xVRZuIYM23UIC/QiSeBt7fmpGj6oBON6ZIFlQmjkNY9V6rmKUKwbsLAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iO5tl2w5; arc=fail smtp.client-ip=40.107.220.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cpruxjKvCYlek1Ry9VrbUIIlRzDBVs0P8EmuXIeGWj3vRUixWpO6LY+aag4nAdzQd1vGmz0twyCXob6MYc77h+ei9nJ7qY/mdLussZ7pd3D+/ontsiB2EFAPZNj9dopqJc+RMgCZVTjwSikDHpB3Oq4ZIDf1c1/5xY9SWUmjY7tN67NR6J5rxdZ6OV5lLRDHDIdao/ohWb1GZ4SYDeJIMOYfDlV10YGbzFe2VHkiQerelQR3UxjyrtwaCwz6ad/HqUF72v5dYhM9/3ySNYXLssEceasa22KBMUrKoKJib9VdNsVcernPSHHTvjvM18qnaEPlEO9/nF8DAZSiAmkWQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1gImpYuSpsUe2VpFxSFVt73UO2wHE82fIPMEf/ZzFs=;
 b=OsV5V6K5dC7tKdvZ0ll5TuR7gxfUc7abdggblGU6+Oa6JkBxjpgn0RSqBbtHP2p5SFdtCKnLIy628pyq5ZCQ5lYPPeesgSbJ/BqX8CVOouQ1H3kmwxx5G+kDxGudiuO6r3/R1DM7cPlTsz9JqkM4No2qoHRZWiKpWn6Il1I2Wh/wAfjZmxf+ZyN9P2IRw4J2o+iFfubwA0mROqZc8O7QPLn/6HjnxnBZenrqhtJCkCHYr53b/+pRXoEcwIDClnpULmMi3ROjJ68M26rUKQ226ops3oeWaJo3HSQ3T2cWJte/y8wGUI4CQpJbvny6cIpu2avkmqotGvh/z5VGi8/OUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1gImpYuSpsUe2VpFxSFVt73UO2wHE82fIPMEf/ZzFs=;
 b=iO5tl2w5bwZ3fOaGnq2bk6VIvn4ujfS0aNroAloCmsMuKifelWNTgRSgC+GAUQArDpWBPis8oqynZQzexkvA1PTvvPHVrqqrs/HitngVMUEOC+J8kIm1+7GwusYzs0c3Uc7R023tDKjoxKlBgyGirBarZqUiZEePRFNYyXXcq1w=
Received: from BL0PR01CA0017.prod.exchangelabs.com (2603:10b6:208:71::30) by
 SA3PR12MB7952.namprd12.prod.outlook.com (2603:10b6:806:316::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17; Tue, 15 Oct 2024 21:37:22 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:71:cafe::5) by BL0PR01CA0017.outlook.office365.com
 (2603:10b6:208:71::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.34 via Frontend
 Transport; Tue, 15 Oct 2024 21:37:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 21:37:21 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 16:37:20 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v3 00/14] Add support for AMD hardware feedback interface
Date: Tue, 15 Oct 2024 16:36:31 -0500
Message-ID: <20241015213645.1476-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|SA3PR12MB7952:EE_
X-MS-Office365-Filtering-Correlation-Id: 136d0a05-0fd2-4bd9-7a24-08dced618d6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0V9p1bY950KR5+QfuFKHAW+mi0PWXvASVjiJxBuubfcUN7wyxLAIR2qaEeS+?=
 =?us-ascii?Q?eCzkjAqjeaVMmKAjW+upnZobmQn2wkHfbFyPQw9bmrAb35jFqkiCkZdLsRuu?=
 =?us-ascii?Q?dC/JjNHKIy+tVYgZwmF2DDqK8RqGPN/trK6UDqnGyUrO23bRIpatcDM+g3Fn?=
 =?us-ascii?Q?RUHylK5PKZbNkX3QEOMHWzA5pM41p5IzIo+9w5vh0Wrl6dHge8UwCNEWeS0v?=
 =?us-ascii?Q?g3YXorxxGP1/fh7Z6lBbkB+Tfcbj82nUISNjntZLhj1cXlfJIK77+CZdTg/0?=
 =?us-ascii?Q?yMsLjK4xEe8EUB87ELxtR/JAT9jHJn1LJwCWDwdF5QfFElCQiWakcKSxa4DO?=
 =?us-ascii?Q?rBnlE+x/Pqm1xjUasVKJkGzCwj+ELxBpf9NAr4TnD6Q/Fy4tpChSsssNS+y0?=
 =?us-ascii?Q?4b/AwE+3xDWy1BfXY1Wi8F3yL2Z6NavAfUNQ0XqfUlNZXdExZdWW8WY6YW75?=
 =?us-ascii?Q?62gXcS2fDFNyVaWP4EyIaET31S01HYFE0rxj04KtxaBjjrGOGdH/JC9hUw8H?=
 =?us-ascii?Q?CtXVpI8dGqZWNk8d7VjBHTdVwqYz1P75yAzay+rJza3lWWlkyrzRCk33sJ/4?=
 =?us-ascii?Q?ctvJa4zNZ1Ecbcr5zGFbduX6XTlpoFPTlPNZiJsoDgkYZMfblx2nO0N+fUWV?=
 =?us-ascii?Q?XT3cUoFHw4dl9RVp4fyqrFVlvccutG55G3R+0Wt3CKPungdlx3z4kdvQi74a?=
 =?us-ascii?Q?N+oiNFvG8/2ah9YM9+xIa6xM0zk2GQpKD1o6LMBKcZ+d10Ybbk5lo9GV07Zm?=
 =?us-ascii?Q?alLgpS2D/jtMiyJSMdEBFJKJXsx7kvX0gZl79RJ+/qBl9AzwdfBqd1/e057/?=
 =?us-ascii?Q?/U9hw6I4xaHeYK/sEzMnJ5bt9+9vWtSLv4n35JEN8EsEooTDSGKBPDPP3KgD?=
 =?us-ascii?Q?h6To4/JpMm3SWl0KPEu3KAMU9tNRLAfsFPyatycjNhZiONF36i5Uv+YeWBg9?=
 =?us-ascii?Q?Ufc9oQE2ZOILcbqlris1MI8nnS7z1B6Aui0ua35QbthUzjThAssQ1W6FuLnp?=
 =?us-ascii?Q?eK3Ff4BfPor13kR4zL7DN4UVUUVUTPXC5600Q9vbSlQizjBCNhDkda7TbC0N?=
 =?us-ascii?Q?swkImzIcA8RLUcBzScs7VPliMvjjcPUqdd/l19fTX2Mlvqrww4FuP6sL7f1L?=
 =?us-ascii?Q?62LNqp0fbN5z8IllhWFDhKSzO8GBrNYcWEdJ1VCkB559Goy9x+JmSNIus/mm?=
 =?us-ascii?Q?7TEN3+KtStjn8P44fnZyCvvDWTo4RDPz5hXrSkvB75JRNmMSEE7yJwkuf6p/?=
 =?us-ascii?Q?EjTygeNOvjZC5ShwkKy05wtcN6a/8J/F3xvTBTDEKyZ0qNxfWOVUpgrAjjBs?=
 =?us-ascii?Q?ID8cw9/RzxP6lhqcjJ7hm5i6erNZdD0bvz+YltcntuhiUn2msTgnEO4K/nQ3?=
 =?us-ascii?Q?IOHQZwr3PkwaSoqK62bvv57KRVVi?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 21:37:21.9581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 136d0a05-0fd2-4bd9-7a24-08dced618d6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7952

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
off of https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/log/?h=linux-next
due to changes queued up for 6.13-rc1 that are dependencies.

---
v2->v3:
 * Take into mailing list feedback for various patches (see patches for details)
 * Add a patch to show the performance and efficiency rankings in debugfs

Mario Limonciello (4):
  MAINTAINERS: Add maintainer entry for AMD Hardware Feedback Driver
  cpufreq/amd-pstate: Disable preferred cores on designs with workload
    classification
  platform/x86/amd: hfi: Set ITMT priority from ranking data
  platform/x86: hfi: Add debugfs support

Perry Yuan (10):
  Documentation: x86: Add AMD Hardware Feedback Interface documentation
  x86/cpufeatures: add X86_FEATURE_WORKLOAD_CLASS feature bit
  x86/msr-index: define AMD heterogeneous CPU related MSR
  platform/x86: hfi: Introduce AMD Hardware Feedback Interface Driver
  platform/x86: hfi: parse CPU core ranking data from shared memory
  platform/x86: hfi: init per-cpu scores for each class
  platform/x86: hfi: add online and offline callback support
  platform/x86: hfi: add power management callback
  x86/cpu: Enable SD_ASYM_PACKING for DIE Domain on AMD Processors
  x86/process: Clear hardware feedback history for AMD processors

 Documentation/arch/x86/amd-hfi.rst    | 115 ++++++
 Documentation/arch/x86/index.rst      |   1 +
 MAINTAINERS                           |   9 +
 arch/x86/include/asm/cpufeatures.h    |   1 +
 arch/x86/include/asm/hreset.h         |   6 +
 arch/x86/include/asm/msr-index.h      |   5 +
 arch/x86/kernel/cpu/common.c          |  15 +
 arch/x86/kernel/cpu/scattered.c       |   1 +
 arch/x86/kernel/process_32.c          |   3 +
 arch/x86/kernel/process_64.c          |   3 +
 arch/x86/kernel/smpboot.c             |   5 +-
 drivers/cpufreq/amd-pstate.c          |   6 +
 drivers/platform/x86/amd/Kconfig      |   1 +
 drivers/platform/x86/amd/Makefile     |   1 +
 drivers/platform/x86/amd/hfi/Kconfig  |  21 +
 drivers/platform/x86/amd/hfi/Makefile |   7 +
 drivers/platform/x86/amd/hfi/hfi.c    | 552 ++++++++++++++++++++++++++
 17 files changed, 750 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/arch/x86/amd-hfi.rst
 create mode 100644 arch/x86/include/asm/hreset.h
 create mode 100644 drivers/platform/x86/amd/hfi/Kconfig
 create mode 100644 drivers/platform/x86/amd/hfi/Makefile
 create mode 100644 drivers/platform/x86/amd/hfi/hfi.c

-- 
2.43.0


