Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D49443FD00
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 15:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbhJ2NHR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Oct 2021 09:07:17 -0400
Received: from mail-bn7nam10on2063.outbound.protection.outlook.com ([40.107.92.63]:60704
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231822AbhJ2NGy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 29 Oct 2021 09:06:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5vGqs5ZRIdZ3ocG4602bCQ24ja2/WwrM6ELlQ6kBNASR+vmLC5uQ1xxqYLwX5c6IHh1ER6e8ie1OTKOa6Za6vFMVwlMhQwid8lEoehG4HA94kwladwRlRuOf9c0Z/8bg1SV2/QuHtPzS/t6GNiWIvxMtKaqpzUeUwaFZW3fSXb2zCo2egusY3OokyZlu+ES1GZQCcNU1/SbFeIFEsNArd8bR/l8fkaPydTZEqqbbBcKdOMzXERl+FfpbIlodglGbfXQDTOO4rJVp4zcoqBde7/w9yxClIvTcqoIbOE5KO4Y7Hh/8crCVro8YldJ7wEXy6H4jv+H1bY3az+ODDgZ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ps07KAkkEcOIick636gTJ37A8LHbpf86ddMPvpS07Ec=;
 b=GZP6jzV57KSk6XqU5zwUIlwhw+DbcAv/t4uLTYrdaq41a0zOds5fnp8+Fg7Xgjr34DvhOl7Lgd2j222rC5ZG2ly4HoyC7AfJnDGqu5KMeNzr1fCQKQ0aPAAgxPAlUVZJR6NFV8q7n3UsGwuUbhA53DVgT5tLAplb5+fTTXw1fj+33XBsIIopXlEZ6i5T0gO69wqWqmW/oQltikD6b/mg7WEgYCKwq/KFHZa/uxc4HhOsvIBWTMM+aFltH2hGrxzQ5Fsk5Q2Ww5pHctXp/gscgiCIKYaER0XPk/yMG8IH5JU+jR5hPJW13HKj+8anaJoVweu3jqLMjTs9n6ZZXfKfaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ps07KAkkEcOIick636gTJ37A8LHbpf86ddMPvpS07Ec=;
 b=entyuO8IKMlNbGJYjVvApKK1jcF4YnzrsLukK8j6AtbJ6R8/jE9FldjxK4MPnF+3LQZG/RvtZJNKp7qCnbvA2HYxVGdKo3ljhU6X45m/lBIHYroTlbtdPG7KSbNUCNJ7Ei3/nuAsyUZ+4W4sZqSfq55yvrcrJVpsDNMNad3vzsw=
Received: from BN9PR03CA0670.namprd03.prod.outlook.com (2603:10b6:408:10e::15)
 by DM6PR12MB3532.namprd12.prod.outlook.com (2603:10b6:5:182::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Fri, 29 Oct
 2021 13:04:22 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::ca) by BN9PR03CA0670.outlook.office365.com
 (2603:10b6:408:10e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Fri, 29 Oct 2021 13:04:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 13:04:21 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 08:04:16 -0500
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Borislav Petkov" <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        <linux-pm@vger.kernel.org>
CC:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Huang Rui <ray.huang@amd.com>
Subject: [PATCH v3 13/21] cpupower: add AMD P-state capability flag
Date:   Fri, 29 Oct 2021 21:02:33 +0800
Message-ID: <20211029130241.1984459-14-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211029130241.1984459-1-ray.huang@amd.com>
References: <20211029130241.1984459-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42cbbf09-fdc8-481a-ef4b-08d99adc9ff1
X-MS-TrafficTypeDiagnostic: DM6PR12MB3532:
X-Microsoft-Antispam-PRVS: <DM6PR12MB353214113BC46C77335234B2EC879@DM6PR12MB3532.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m6eYd0fTCU3L4AChUkcUdphfeMT2g/nYdkogknPIy6Bu0MuP/4UQSUL3iFjJtSge1HgwCxD5zZ0waTq2CTycLGPy29LSGgapNGGQbBq2BNC9unA7fTDwAL2tLOJBxou5CtbB1Ozpn6KsgZVv+ilG9IJajmqVo7F+EoU58qJPETEaoRHHUEGShGBmJUXAVKXx4F/7cw8BzgcrUa7HbFunU69ru/FVvr3AgXfP7tlEJuqkkiu8HBpv7UN4NUqZQBsV9+Ou9VTiX0tyPFdxQUIQLbGoirhOxOBA7BUBKMHLBSZ7rL9cxVfkM6TXDfZZIpgzLse/NZaH3+QLiPc5BP5Ak7k9aBExEQGN0GLAxP9zLSKXNxEykfctopNh8fVfdxWzuRoSfDKtan6JS1J7zgO0jSKJEJJmnEH4fmzAfTsL6fNe1oy2V3AavsxRrtiZpPih6wE3QxuHlhELdbd/9mvX+GMLhAM6Qn3yBVHgkO3GPEGPUmJfZpgSbl7uvnL/J6H2s1Lt59hR79LpG5XQhGiySb1SJL5Ig5/zZ0YxBkl5Ca4vFWPKGRKmZwI2h75z0q0e6iifcxzIUrOd31zn19sdEzmJ+CDEK05Zgoedtf6jLJefVQUvMh8NCLUk7WKueFZ1WeTHsoGnvHWEApD1eSA94ysc7cWVbPBizkwIqL8utddsIfXa3M6LekvYOa57WGcloVHCPahP+R1uRFyjyyET1Ad1KxnJ40xlxGw+FpazNEc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(110136005)(336012)(426003)(54906003)(8936002)(5660300002)(86362001)(2616005)(82310400003)(7416002)(4326008)(81166007)(70586007)(316002)(70206006)(1076003)(356005)(4744005)(8676002)(36860700001)(7696005)(2906002)(186003)(47076005)(26005)(16526019)(36756003)(508600001)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 13:04:21.6121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42cbbf09-fdc8-481a-ef4b-08d99adc9ff1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3532
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

