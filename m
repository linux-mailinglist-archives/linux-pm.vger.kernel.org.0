Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08615655DA8
	for <lists+linux-pm@lfdr.de>; Sun, 25 Dec 2022 17:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiLYQfO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Dec 2022 11:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiLYQfN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Dec 2022 11:35:13 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7960360CD;
        Sun, 25 Dec 2022 08:35:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wy+bLYjd+dLEUnQS4hsbQCdKP4ccOBPvZcBRoBAm7IMOe39RSJpghC/MdGjr4c1PyUuzmu2hqGvkPfBTQsc8pmSQ0CwXm5kfqDq+hJnRS3ZLb+PZG05CAFDD7PZoAiorYm4QOY2alfu2CdfxnCqvG2NNYu+JR8nmqdvy3P0Q8PYjj9TPEV6o/8kobhKANYm4iadypmjZO7x1h3nKPFlNUlgJz8klaldbKJXmrHER6JtK8pbDDddaen0eqAd/341+sd0WIv5xmfcDlHW4YBvV2CvXqSpmj9/otelZHjTH0kbdXm1TB55rzWANn3dm8J/wWWKshGe5I+nGWoG2OCVb1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h267RDvz9Tsmg3si31fV5d06ETOHd1pgo0C/8fYd4V4=;
 b=H2lh6KF319wn3T3hrTS0H1E2xqaI2IgvRrKaqZ2kIaOpR+Ol3qCGC+GpMxVRFR9pV4dFN+au2GVJxEwE/AzPXCfTz44QNVKnzKlygGzTZ28hQBjW0gCdRRKKDJz31BxWFp9ZZVMHrujSWtEI75OkY+GanMVBd07y22eEzHN6QQAQaQAJwNbvqlyT7uztzs7S0KxrQ4p6TQQuRvkcPmcLYW/dWtkltu3i5dHwtfO5VcxAb24wiGP2PssfdVpiZQel8Icjph8CCgoaoRnRGaCT/EIaITy8DKjlGpvjI4qMfq7e1ggplXakoLUx+nI2W37P40K93bFxyQX1svA0HgLq4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h267RDvz9Tsmg3si31fV5d06ETOHd1pgo0C/8fYd4V4=;
 b=Ua8HiQX+tgbaCsSDGExJjDvg4jumainbNdfhvMMhkE8+eIIlWqjSaHoKgqA2sVukD0/j2k7+8yYkTZIMgl977iQ0aAbfrueohbcJEFcEcge7vRvnzabNxx2wsjHHzpWrPG9sUiPTpdglrlbhKyuEobeqB05S0y7pg26cgVFoFhg=
Received: from MW4PR03CA0070.namprd03.prod.outlook.com (2603:10b6:303:b6::15)
 by BL1PR12MB5948.namprd12.prod.outlook.com (2603:10b6:208:39b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.12; Sun, 25 Dec
 2022 16:35:08 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::bc) by MW4PR03CA0070.outlook.office365.com
 (2603:10b6:303:b6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16 via Frontend
 Transport; Sun, 25 Dec 2022 16:35:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.14 via Frontend Transport; Sun, 25 Dec 2022 16:35:07 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 25 Dec 2022 10:35:03 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 02/13] Documentation: amd-pstate: add EPP profiles introduction
Date:   Mon, 26 Dec 2022 00:34:31 +0800
Message-ID: <20221225163442.2205660-3-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221225163442.2205660-1-perry.yuan@amd.com>
References: <20221225163442.2205660-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT051:EE_|BL1PR12MB5948:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c19b861-278f-42a4-7b1d-08dae695fbe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5a++Yg4I3ZOlPBF/ZJEELVFpiqEovEmqjyAikTEgDnOBY8cSK91Ja8EleJIGhnnvKWM4CzekDDrWgB8S/trQe/Ej0s9Fl+F70u5+KwAY8Hxr3YZC+2JOIFtMDkeaRj0ndIzUhfE6BpQHwL54H/fTC0NjgNQZLzWqbaJaCMBeNSU1awyo52U6W2z9zCF15v1/n2l2Aot48IySHpXy5etHmEJ6NKKEdVvd33qpthhgxIvrPoGp6BqHGyjgE8OPtOtdCu5n5f7GJDni/75SheVfNsRXZU/WcMCy/FvLStB8FMEGiE148SBC0W+bPdiUldXuoWQFvAx5pDH734tCA6VWUXNDAwIAeNG0v5VpU2p7u5VY3uGDlARzi9LOLuLTrEOPdltjw2rnDvwxu9frhPdSssOe/5VHe5zfpO7qu/BEbGDEQcf+BCsB4gJQpnoGLmqdrhXVTGHThywgv3FgbEGEYGuv8gVaLYQF5YjuR3dTpwGTAuAC9Jo8+G8Gp7Cv3X4YHbaT86qEQSK/Gt9zygpyLV564qtuOlx4DVpQ/msjVFWImqGwj6fMgXyGAHwycgmwxBqC3IVFgqpq5Wkpi2RoSfXLLw1zvCMjjJKYxt9mPQ110+UZeOqqbeJML3RVqEtAOYz5CugTQBv0KYnpjGnRoYYKUeb9KbnKB7/1rqqWMWYv5WCM3cF+caQGA744ac/sIdAC7Ay3z5Qr3TMwMdqIRmI6D/1I0El1/DQdmPsTFpo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199015)(46966006)(36840700001)(40470700004)(478600001)(44832011)(70206006)(70586007)(1076003)(8676002)(2906002)(8936002)(4326008)(5660300002)(54906003)(316002)(110136005)(7696005)(6666004)(2616005)(336012)(47076005)(426003)(40480700001)(82310400005)(83380400001)(16526019)(186003)(26005)(40460700003)(82740400003)(86362001)(356005)(41300700001)(81166007)(36860700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2022 16:35:07.5526
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c19b861-278f-42a4-7b1d-08dae695fbe9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5948
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Perry Yuan <Perry.Yuan@amd.com>

The amd-pstate driver supports a feature called energy performance
preference (EPP). Add information to the documentation to explain
how users can interact with the sysfs files for this feature.

1) See all EPP profiles
$ sudo cat /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_available_preferences
default performance balance_performance balance_power power

2) Check current EPP profile
$ sudo cat /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_preference
performance

3) Set new EPP profile
$ sudo bash -c "echo power > /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_preference"

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 06e23538f79c..33ab8ec8fc2f 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -262,6 +262,25 @@ lowest non-linear performance in `AMD CPPC Performance Capability
 <perf_cap_>`_.)
 This attribute is read-only.
 
+``energy_performance_available_preferences``
+
+A list of all the supported EPP preferences that could be used for
+``energy_performance_preference`` on this system.
+These profiles represent different hints that are provided
+to the low-level firmware about the user's desired energy vs efficiency
+tradeoff.  ``default`` represents the epp value is set by platform
+firmware. This attribute is read-only.
+
+``energy_performance_preference``
+
+The current energy performance preference can be read from this attribute.
+and user can change current preference according to energy or performance needs
+Please get all support profiles list from
+``energy_performance_available_preferences`` attribute, all the profiles are
+integer values defined between 0 to 255 when EPP feature is enabled by platform
+firmware, if EPP feature is disabled, driver will ignore the written value
+This attribute is read-write.
+
 Other performance and frequency values can be read back from
 ``/sys/devices/system/cpu/cpuX/acpi_cppc/``, see :ref:`cppc_sysfs`.
 
-- 
2.34.1

