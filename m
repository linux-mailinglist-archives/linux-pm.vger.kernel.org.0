Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FB57D87F4
	for <lists+linux-pm@lfdr.de>; Thu, 26 Oct 2023 20:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjJZSAS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Oct 2023 14:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjJZSAR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Oct 2023 14:00:17 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0457AC;
        Thu, 26 Oct 2023 11:00:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FVkyrgovUGxajXJwX9hgWrO6Qa/R6CD/H9xjbwXDMw6tTG/wp2rGVb9uIt68JNoFwnAH8niblsW4yTx5jKQOhLk8HNE2cKM9fHKyOoxxY96kkBVAYrbREL57TTU7aHf4LCKo8ckGJHBsHMcX/60kBOpHGesbavqnxijDr/gu8M6GbiWyWhNwSBJnRLBsV+6x76KQOSGjXSxcFpJ97/cGGmjL3v+AeZ7UGj27SwHLyQxnto/sreC494Q5RTdIGSGUN5ly/eixxtTwBJA2+Mg8IJMO+q3M9RcMNOv7EXPgxOML2Ues2ObX53PwmXM/c4EXylw47G5MEAQh6RTIoC1BXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+F3uO+5IWBcf7q6yTe2ZhI9rXKBglfqAeJ41mJytnzo=;
 b=OGnkPX2fjxgeAmFyvYAJ6JUnrX2h0B99HRYxeZd5jDZAUivcWq++dgbukf1QU8LiR5/+3OXQl9NEw/+JZYk47+tgnIOpR3ErlYs9EJAlUWonqtQ+l5sEfNWuT4l/kPQICGJhjPuKAZ/FGKKy1weinxS6FXz3J0kVkPDDcssdaT47SzEmzWdIHlayalHEoFsPFLMy8cpi6ub12YdMu/QP3T7gQFe9rkXr2owKaKF/Shhe8+CnisrOCNNlugsCuOk6rte8ZAaLfxLo/e0ALOilLrabd0J+Zid1OGkdIEG4jezFFru8yK0RKwEgikKsxXpD0jwPk8zXGuE1GQM5WXTPFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+F3uO+5IWBcf7q6yTe2ZhI9rXKBglfqAeJ41mJytnzo=;
 b=Re41GFkRETwo0vzHdyHGBzWRaOafIBR6pIxj9vCP2pX9TePkW9hrtFrRivCSY5s36VaeFsuAd1OIlR/1j1UpWJexyIiHKFH47CZzvIGcwqntVHJojoG1fsrovDccUVOBR0NH1rRflTetkABbxzXi2vbye+JyBpECQMbEd8CZrJI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB9007.namprd12.prod.outlook.com (2603:10b6:a03:541::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Thu, 26 Oct
 2023 18:00:11 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%4]) with mapi id 15.20.6907.022; Thu, 26 Oct 2023
 18:00:11 +0000
Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=amd.com; pr=C
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 4/4] platform/x86/amd: pmc: Add support for using constraints to decide D3 policy
Date:   Tue, 24 Oct 2023 21:05:46 -0500
Message-ID: <20231025020546.504-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025020546.504-1-mario.limonciello@amd.com>
References: <20231025020546.504-1-mario.limonciello@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-OrganizationHeadersPreserved: SATLEXMB04.amd.com
X-EOPAttributedMessage: 0
X-CrossPremisesHeadersPromoted: CO1PEPF000044F3.namprd05.prod.outlook.com
X-CrossPremisesHeadersFiltered: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|MN6PR12MB8591:EE_|MN0PR12MB6101:EE_|SJ2PR12MB9007:EE_
X-MS-Office365-Filtering-Correlation-Id: b86bee8d-d6c4-4faf-1802-08dbd64d635b
X-Microsoft-Antispam: BCL:0;
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(136003)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(41300700001)(37630700001)(2906002)(38100700002)(54906003)(316002)(66946007)(6666004)(66476007)(66556008)(1076003)(6512007)(110136005)(966005)(6486002)(83380400001)(44832011)(86362001)(450100002)(5660300002)(478600001)(2616005)(4326008)(8936002)(36756003)(8676002)(26005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 02:06:13.5871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c80f106-9892-460a-46fc-08dbd4fef737
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SATLEXMB04.amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8591
X-MS-Exchange-Transport-EndToEndLatency: 00:00:02.8219603
X-MS-Exchange-Processed-By-BccFoldering: 15.20.6907.018
X-Microsoft-Antispam-Mailbox-Delivery: ucf:0;jmr:0;auth:0;dest:I;ENG:(910001)(944506478)(944626604)(920097)(425001)(930097)(140003);
X-Microsoft-Antispam-Message-Info: u0FuDfbf3+q3qVRWb5DQaGMUPfIWYR8bqBV7B5VT/Elg8OVtiI/dBv9nhqamnQBAQF5HlEL55ijonWhyRgyurHAnSNZuoXrARzeURSoOGxXDiaaa0X0F+jtokrgwDPUbvMfs+Rsz2z3EJC80dQS0pYG7G1r7wc2RzklyUJmgfzBSZ+LuTVmETmOx2jfsSepasoZ6JKBFaXzTqsTG3xO8J10Hzwui3wtIXGVc1A7fUwGmhhTawP6wbq9EP6keB020P99vRNQBevg/U/4LL5+6xyY+ycPpnsEtg2FB+mIkzpfj9EjoGpzqQ+m/bBxpdQVqsz50kVFhv/dU0x6VxmnyfDvMO4Q6pNBypFChXlW3HgNmILgdNcMFfwAM7z45X8P4KPHUQs0ea/zCX1Z+sSEDjUVaALbE7SsNR6z88UooMA7H5ltRv/U+fN4X1Wt0+cGgbQTLXtPHbFLhLknE5qgVklDo3BzEwcVwPTdADyavjWAxOrnXNsjuimJUbgtl4ZKArGTyC9/l540MQh8yehjEGmSlq09x1HqO89ErHBukP64=
X-ClientProxiedBy: DS0PR17CA0021.namprd17.prod.outlook.com
 (2603:10b6:8:191::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9c80f106-9892-460a-46fc-08dbd4fef737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dKok4RR3TdJFbBph57zmDUr7zXQBV4aco3ADH0XbTATi/Phz8sLiJfLdd9ab?=
 =?us-ascii?Q?98hJ59VA+HRLHPFYmY0Qf2Ti5IUNVERQffHu6S3uYTkiFgS9D0BbsBiuXKYT?=
 =?us-ascii?Q?FAauIYiHqynXYT6ehC5YXGTkOaBn9WsIuBGTSkT52vPQTf6uGHjpLrwXoqwj?=
 =?us-ascii?Q?LIGAiss/KjZrJbkCM4ZyxgVsUj/70AYa82sPwvYUjjEvmf7ueCNr/bXyrALh?=
 =?us-ascii?Q?tO9zg+Lac2czOJru7d2zBk6ykrcp47ZlVaDGAeqzOfEOiPikLBssvky4Laj3?=
 =?us-ascii?Q?OytWxTIGFdkYY8J0q09ovDNFwmH9Rjy+u/j4L/5/zFSHwmNFRLLajZXMsBRP?=
 =?us-ascii?Q?N7oVoGyYiYfOzMU9rL5NxfzTw5mkBys/dIRwuc047R7YvrW7I/mQLpsB+AHI?=
 =?us-ascii?Q?JRX40BFMxKSt0kNB/SyFPdA3AiYFtI4loiWbeBLmB4KKKnbv7hn3fq8c6vxT?=
 =?us-ascii?Q?cyPn2ExIV5y7UV++g7pZf4HmPXfDHXLFRRwDg9QDv4dVNH9MYwBOK5yCApUp?=
 =?us-ascii?Q?KZZ2Z5pwLnMi8WElVV8v3HeBezMKQaZuEMAkxZfvMlujLtXPjew6xqpA9R6L?=
 =?us-ascii?Q?EQqOv+WfeeSf7BitPqQ48cWECEcjA7/AxjNjo267ewxDa8T/evbHvebN4oX9?=
 =?us-ascii?Q?w1JZK9nNF6+7MkZwJmqFRMAj3E34zqkLlIzjqckmePAwRu9uhv8ogz7rdzdi?=
 =?us-ascii?Q?Ec+16dl1/YiPiPfMdRhaFhXOXmfctyOEngbRsT6w0qbT0H4rjZkLoyKUcFv8?=
 =?us-ascii?Q?EIJnnIH9W+dSLMQddoI8tIX771GrhLd9TdNQC7LFt7wfL+R40RMx7SRSxSaz?=
 =?us-ascii?Q?MwOv8+K5nsyX/9bT9xf/wbn69Dvd/uZattFkZmYdy0IcdUaZUE0vuc3tKCa+?=
 =?us-ascii?Q?YwaAdPSUESBzw7uH3OiKZXC8p3Y8eKv6LlymXOovK0IP86i8Z08c1k2dVJjq?=
 =?us-ascii?Q?bztbn2di9CDbH6eTo1L4gDk8GbA5jG5tTqe8vH2pFtHnXBmCfk2PGKWO/VCy?=
 =?us-ascii?Q?AQtwvukozZwu/CxNKobziUHuk/VXsWp9R6hkEiNLeXCKfMVZ3Amsh2CSvU6E?=
 =?us-ascii?Q?TeDW/WgpcrGXKZPxvIID47mQ11olYq53911VRGPmxZso+vduy4kaIDyHs3hV?=
 =?us-ascii?Q?GM7vLG0WhpqiRt1m4T5W/dlbWmOiCvDhIXZKZnMJbGYvNn4oI8rVmDw1MQUM?=
 =?us-ascii?Q?EnkvQvw8piZaMPHCHmIiSdLaHGQ4U1ZIsgncyGC/qMUakkY1esoS23uqRr8H?=
 =?us-ascii?Q?Iu9QdjHhTqvLUZWIhoQg5/DrxjPqPabMRoZt5RX6yaUd+Ntyc70jRUbJzbfS?=
 =?us-ascii?Q?Pgiza6Hx6kchzRF7YrdRbB63EOvaqTYLPXBiJrvCrQnH6fX8qP37gb28UUxn?=
 =?us-ascii?Q?N8JLUMExYyPTASJO25PATk1zMdrQskrfVs6TB746nSHaCCJdV+BzzWcB2NFE?=
 =?us-ascii?Q?jSimmK/uXGnxh/EXvfPaa084Gx+aX2PvH+OqN7V8jj+uC0PqfaYJ1EH506gU?=
 =?us-ascii?Q?ideLwjE03LHMXpHf8+UsvwN8sl/ER4LJmcLB6lEFpiO0eRbOS1RN5GDezt+Z?=
 =?us-ascii?Q?33925qZoHQkloCBOFUaRKRpgFpGYxfiXYsns6Z60?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b86bee8d-d6c4-4faf-1802-08dbd64d635b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 18:00:07.2272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dm1E6FpJCDlP8mUG3EKJkFOEE28CWLbx8uisfxsaMNDkjFQP7seW7YSlvxZa2H1LrlQvmgtyFiQ/NvU5FKXo5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9007
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The default kernel policy will allow modern machines to effectively put
all PCIe bridges into PCI D3. This policy doesn't match what Windows uses.

In Windows the driver stack includes a "Power Engine Plugin" (uPEP driver)
to decide the policy for integrated devices using PEP device constraints.

Device constraints are expressed as a number in the _DSM of the PNP0D80
device and exported by the kernel in acpi_get_lps0_constraint().

Add support for SoCs to use constraints on Linux as well for deciding
target state for integrated PCI bridges.

Disable existing production SoCs by default with this change.

Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/platform-design-for-modern-standby#low-power-core-silicon-cpu-soc-dram
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Changes from RFC v1:
 * Use pci_d3cold_*able() instead
---
 drivers/platform/x86/amd/pmc/pmc.c | 57 ++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
index c1e788b67a74..346564517667 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -741,6 +741,61 @@ static int amd_pmc_czn_wa_irq1(struct amd_pmc_dev *pdev)
 	return 0;
 }
 
+static inline void amd_pmc_apply_constraint(struct pci_dev *pci_dev, bool apply)
+{
+	if (apply)
+		pci_d3cold_disable(pci_dev);
+	else
+		pci_d3cold_enable(pci_dev);
+}
+
+/*
+ * Constraints are specified in the ACPI LPS0 device and specify what the
+ * platform intended for devices that are internal to the SoC.
+ *
+ * If a constraint is present and >= to ACPI_STATE_D3, then enable D3.
+ * If a constraint is not present or < ACPI_STATE_D3, then disable D3.
+ */
+static void amd_pmc_check_constraints(struct amd_pmc_dev *pdev, bool apply)
+{
+	struct pci_dev *pci_dev = NULL;
+	struct acpi_device *adev;
+	int constraint;
+
+	switch (pdev->cpu_id) {
+	case AMD_CPU_ID_RV:
+	case AMD_CPU_ID_RN:
+	case AMD_CPU_ID_YC:
+	case AMD_CPU_ID_CB:
+	case AMD_CPU_ID_PS:
+	case AMD_CPU_ID_SP:
+		return;
+	default:
+		break;
+	}
+
+	while ((pci_dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pci_dev))) {
+		adev = ACPI_COMPANION(&pci_dev->dev);
+		if (!adev)
+			continue;
+		constraint = acpi_get_lps0_constraint(adev);
+		dev_dbg(&pci_dev->dev, "constraint is %d\n", constraint);
+
+		switch (constraint) {
+		case ACPI_STATE_UNKNOWN:
+		case ACPI_STATE_D0:
+		case ACPI_STATE_D1:
+		case ACPI_STATE_D2:
+			amd_pmc_apply_constraint(pci_dev, apply);
+			continue;
+		/* use the logic pci_bridge_d3_possible() to decide */
+		case ACPI_STATE_D3:
+		default:
+			continue;
+		}
+	}
+}
+
 static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev *pdev, u32 *arg)
 {
 	struct rtc_device *rtc_device;
@@ -1074,6 +1129,7 @@ static int amd_pmc_probe(struct platform_device *pdev)
 			amd_pmc_quirks_init(dev);
 	}
 
+	amd_pmc_check_constraints(dev, TRUE);
 	amd_pmc_dbgfs_register(dev);
 	pm_report_max_hw_sleep(U64_MAX);
 	return 0;
@@ -1089,6 +1145,7 @@ static void amd_pmc_remove(struct platform_device *pdev)
 
 	if (IS_ENABLED(CONFIG_SUSPEND))
 		acpi_unregister_lps0_dev(&amd_pmc_s2idle_dev_ops);
+	amd_pmc_check_constraints(dev, FALSE);
 	amd_pmc_dbgfs_unregister(dev);
 	pci_dev_put(dev->rdev);
 	mutex_destroy(&dev->lock);
-- 
2.34.1

