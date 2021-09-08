Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF54403C2B
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 17:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352063AbhIHPCw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 11:02:52 -0400
Received: from mail-dm6nam12on2087.outbound.protection.outlook.com ([40.107.243.87]:23649
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1351927AbhIHPCu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Sep 2021 11:02:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4Q0fv58RfnDb87PDSBRl8hDR7bn+6a8lPkfa3C0Q/KWknxRPSNwFa3flGEChk2pig2qEdzwmaXyDFLRcdQu9x8M2Xn1lygExpwD6s3/CkP1r8BvZzAEIORhsmTvNVk9kPka9Gn7eliKdtII7vJIePV0r8btPlHY4C0lToAEmcsutkVPjVBenG8PHF/KgmTpJn5zpp3HZvKIhWoY6+nqi2elz5Im0I71LKA8sppYAgiwRRlkF0ApY9V4MIC7uuUbX7ruJCtuItLi7NYJyM2bKMxMXZTJaAUAZmkY3sr2de7UwtvquQ6v2eHpujr9vfIc270fHR6yZI4cKG/SB1XjZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ps07KAkkEcOIick636gTJ37A8LHbpf86ddMPvpS07Ec=;
 b=mM8r0L/klMJma5EeFOeY4Efg0lpHomFiT8lBxXscHgHBFqKBT/j5Nx+1bQd/Oit03UbOrMGzPvenQHdqt5vNFtPM4S52CtT6we3qwYE3d/lahlyCKmxobQ4X3cDP+rvc1uAvKefAkP15T5txq/a552mQwOtxRvmDkOEoL63cR1qpr8Y4Fz6LwOd0pqKjeXa4mem3RIZ0Usidq/u18267lHcELBNeLudcHM0MI2PJaFDZK+5slZKrk5mu5X09MxkmdUimcic0iUwT7aD8L1LyiFLDolOjwxL47r6CHrjWPiX5S6/rm15/WdZDmW0bNE5rFVJAPd8KsO2++WLGlLh6Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ps07KAkkEcOIick636gTJ37A8LHbpf86ddMPvpS07Ec=;
 b=l5F/gbRrOY/Cuvk04VUMfHTE3GqAiZhAjYv460HPP56wSLlBh889rrwnslYugCamUYaKkuIL0FLNB11mSlTguxxZj4QEimLdW2iHu+SG4XqJidpN03rgDOOSdLCxaAui/fhN8RE579jV83j6UHRCi/Zsl2UNTSvWvVNiz2Mm+0g=
Received: from MWHPR10CA0004.namprd10.prod.outlook.com (2603:10b6:301::14) by
 BN6PR1201MB2464.namprd12.prod.outlook.com (2603:10b6:404:ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.25; Wed, 8 Sep
 2021 15:01:40 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:0:cafe::1c) by MWHPR10CA0004.outlook.office365.com
 (2603:10b6:301::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 15:01:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 15:01:39 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 8 Sep 2021
 10:01:31 -0500
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Borislav Petkov" <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        <linux-pm@vger.kernel.org>
CC:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Huang Rui <ray.huang@amd.com>
Subject: [PATCH 12/19] cpupower: add AMD P-state capability flag
Date:   Wed, 8 Sep 2021 22:59:54 +0800
Message-ID: <20210908150001.3702552-13-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210908150001.3702552-1-ray.huang@amd.com>
References: <20210908150001.3702552-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 923acf10-1857-4dea-a615-08d972d98fea
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2464:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB2464656535EC8DC22A40A04DECD49@BN6PR1201MB2464.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pW3DuM9Xxis40mIBQn4MyR+e114fqIrIgAyJEJRAFXRyG7qOvd4B9bgj+WLEwFPMYgXtUVgDVso1XNfsBLa/G0bsHLiqs0UWP8m2qRBiPIcvfEN044mYYVJwWTcCJ7zneyHQO2vzqZ+9wwgP9cVCzKJ/AiaDuQB02PctQQkLFC/3tGiyyxPNqQuMxDoBgxfLFgfoo8oLyrfuQQ7zysiEZAtd62Y2RGDj7ypnvIyysJkZ7A2szK5aYKV6BegSALSY3s/HzazfvfeZOyxCYB3uFaOxHV0f7Zb7kIuyCAuLko1lmyS45GMVwSORmuNiWyFhCNGPqRPFe9bm/QSv/1mp/spK6i8NVK2HjIcMnLKuwQeA/vTngWO4bqJK2C0hxSwi1+Pdkf+dD7wBGAD6k1yK7r8G3ut//cDv2NwKotXo7VX4jmIoL/Och4fYxtw3A6PtsFKC5ZZ+3SXdKV0/cm6AVaA4fMImLcaF3QX/WbBSbR+WAzgPPgLIGGkbMKAcLVXbSVAE/TrmUpA10zZ4H4JpAvi68IbIIMF+TArZetB5y0gWvcdfNrFgspsckWqXnV6O6mGbhpblEVc8vP0vKvIT7JCsEhyhIkuZs/VZn0h29Qjy7cV70f80e4kCKV+IfYMr/ENimbu4zpEc4P3XCp8ITbEu3ylJml36s50mv9hvdJ6O0o1y4HBA6Vav1Q113QPl33t2sc/DRWMXbQHvWBXJOh/fIlYJYY9IWYdSqDblJTU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(36840700001)(46966006)(4744005)(8676002)(110136005)(54906003)(2906002)(186003)(82740400003)(426003)(2616005)(316002)(5660300002)(70586007)(36860700001)(7696005)(336012)(86362001)(82310400003)(1076003)(8936002)(36756003)(478600001)(6666004)(26005)(356005)(81166007)(4326008)(70206006)(16526019)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 15:01:39.6076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 923acf10-1857-4dea-a615-08d972d98fea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2464
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add AMD P-state capability flag in cpupower to indicate AMD new P-state
kernel module support on Ryzen processors.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 tools/power/cpupower/utils/helpers/helpers.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
index 33ffacee7fcb..b4813efdfb00 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -73,6 +73,7 @@ enum cpupower_cpu_vendor {X86_VENDOR_UNKNOWN = 0, X86_VENDOR_INTEL,
 #define CPUPOWER_CAP_AMD_HW_PSTATE	0x00000100
 #define CPUPOWER_CAP_AMD_PSTATEDEF	0x00000200
 #define CPUPOWER_CAP_AMD_CPB_MSR	0x00000400
+#define CPUPOWER_CAP_AMD_PSTATE		0x00000800
 
 #define CPUPOWER_AMD_CPBDIS		0x02000000
 
-- 
2.25.1

