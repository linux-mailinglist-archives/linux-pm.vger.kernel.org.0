Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EF67D87F0
	for <lists+linux-pm@lfdr.de>; Thu, 26 Oct 2023 20:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjJZSAN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Oct 2023 14:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjJZSAM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Oct 2023 14:00:12 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C91AC;
        Thu, 26 Oct 2023 11:00:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYewMX5DCDZABdG2LbV0caRWDoigrloNFHVDPXzfwKneFfdnIgxE8jxTIYL0essUCe9axXQlX/pQz7V8nfMGfwke2DT4+HKxmMc++jkP0M5gNzC7F31C/Wp9vI0/XwyDAeeHjG4T/va+iraTnkuZ72CkPyotsTJSWFEqe4vSYlBgC4HYJrAiANhR1DUtKs2OZrtZMYD6uCrIlf4aZgxLcqHqS+gQwToP3XHI0kpEOhyTY0IEty2kDfj5CnhcCIocnACk0P86V9SiBqfvv06WkLVXntU1hQdirFMZEUtiRFLCnWCh0SCexXMylZ2OJ3HtNpwPO6U9Knn16XIWN7A17g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFiX9EXXuC5AphQlOCTSzBjRFt7sYTmuPaVEd26TXvc=;
 b=E9s7YEXf/QSW9Yt3xtNniHiTWEa9gGNtyqliZyk2woB+3vNCIXcF40hG/r2VmS7E8JJXnNVXleuHCGfzW9ucqeXr+OFnRZDrORC465hk+CLh4RVWvR28o+LTkut77eiAEHY4vud3dvsM7k7WWD1N2ISDi2Co1YemBMsk7uE1zrLc33kN0lkhQEcGlNBcPsQjGBpZNjNqtwhD3b3xxFg3lDxssU44ZXHWfWe8i/roQFE8Yx2/8zhPswMULGx4iQuW5MCECu/ztoEglhvxYKzcDTlX7EONNSOz0uzMHMOy+cyqaHv7i22MaDfriXoKMsS5PqlcFdbmtpZonOVhqguiLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFiX9EXXuC5AphQlOCTSzBjRFt7sYTmuPaVEd26TXvc=;
 b=gpKGP4L8NWADkgnTH5HuCytkDb6jK2OGWl90iV0vo6BEVvbd0nq90DC/ZzndUnYwyWqWAXcpVWE5iU3lJWDjkT/HHX/uJzzfmDWgtBQbvAfp3yNSVsmv+UERIOrXvqL18VNrqPrPebNEUcu4ZcwgCLms75WcQByihvxkvFcTrXk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB9007.namprd12.prod.outlook.com (2603:10b6:a03:541::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Thu, 26 Oct
 2023 18:00:06 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%4]) with mapi id 15.20.6907.022; Thu, 26 Oct 2023
 18:00:06 +0000
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
Subject: [PATCH 1/4] PCI: Make d3cold_allowed sysfs attribute read only
Date:   Tue, 24 Oct 2023 21:05:43 -0500
Message-ID: <20231025020546.504-2-mario.limonciello@amd.com>
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
X-CrossPremisesHeadersPromoted: CO1PEPF000044EE.namprd05.prod.outlook.com
X-CrossPremisesHeadersFiltered: CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|BL1PR12MB5174:EE_|MN0PR12MB6101:EE_|SJ2PR12MB9007:EE_
X-MS-Office365-Filtering-Correlation-Id: aef36bd4-f8ba-4c9c-a556-08dbd64d6307
X-Microsoft-Antispam: BCL:0;
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(136003)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(41300700001)(37630700001)(2906002)(38100700002)(54906003)(316002)(66946007)(6666004)(66476007)(66556008)(1076003)(6512007)(110136005)(966005)(6486002)(83380400001)(44832011)(86362001)(450100002)(5660300002)(478600001)(2616005)(4326008)(8936002)(36756003)(8676002)(26005)(6506007)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 02:06:12.7733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a90780-d9e9-41ca-ba41-08dbd4fef6b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SATLEXMB04.amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5174
X-MS-Exchange-Transport-EndToEndLatency: 00:00:03.9170161
X-MS-Exchange-Processed-By-BccFoldering: 15.20.6907.018
X-Microsoft-Antispam-Mailbox-Delivery: ucf:0;jmr:0;auth:0;dest:I;ENG:(910001)(944506478)(944626604)(920097)(425001)(930097)(140003);
X-Microsoft-Antispam-Message-Info: RVwnzEo+KQrpk6RkgQvF8ivpP9Gpc7GgtDD5/1KQ4LpvPmwXTzx72Gp5VGnOqPISlqUxJtR42Kw+ih4zVfmYlm/ust5iIv7fBfXTa3rtVa29WQn3XwnhrgMuPs1ujgAosDzjsoN17uyFYIU2zSQCXa+5OUuu9NPXQ72yUi4V2NaRioaP5aVdygMNqt/xjVCSdKSXVS78rFWY90x1axWg6DLI9SFwefc5Mh8F3FK+cPzm/1iX13SJ88uYC5DT4cn+30V1Y2lqQXD4Y50j15TCcidNdxh7rRLC87+T8ADS9j6hLSJTUrZuXoESMPb7RwkgLv8FaKsOYYI6+HSXQVDATqKa+FotjJYX8njT0VtmBnhxXXlJhoWBvU0W274BLtwwLqBbCnbHtRM2o7NuIX7YK6u0CTqsUtq7p1SaM+TXnfGt3YbrKSr+zjyQadzzsRtU4A89Ryx3EYcX39+ehRH7oAXfv4PFQ9vyF53U1hcS1B83Qc++wmoeQSME0c11JoXU6p8ycXhZSsTMHmFd5cTkGxPKJjA6gUDk42zP27qOloOoLjrZ4KIc0wqsZvgm/OAQB+ANb6JReXxENo0I6U8ArN5dGKa7LLwPIx4QrZt4HXY=
X-ClientProxiedBy: DS0PR17CA0021.namprd17.prod.outlook.com
 (2603:10b6:8:191::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 21a90780-d9e9-41ca-ba41-08dbd4fef6b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XDbrUgeOfvvZd2P4UOwjtmE1SYL1+CpiUdcIqyTkdHW8/pVBKjdW6Cr5mirC?=
 =?us-ascii?Q?2GmGKNvCQ6Y06b0iR1ImkuVhkBPqEXYQASwe7msSWTkEDEzYyZ9FvwdXNI2+?=
 =?us-ascii?Q?roSXxIW5TJeB5CDj583ia579y2pWLelBxb9dgE+VHkMoRBDJ9KhXtNmTD42F?=
 =?us-ascii?Q?qcZSYUYFvHVQRNi7xCxL5EUlVhBRUisusYK/3nKlJzF+wc/cov7kqkfEy2Pi?=
 =?us-ascii?Q?b3mUm057h9cvg/mBEiIYDuStngfgnBalnvdvPU5Xarwi4QCphW7/XjIFfEGM?=
 =?us-ascii?Q?iBhkdwzg7TXTzw5gxRa+hxzBO+L3KqNyngE+MLluQ6ubsfKqmybBiNhg3IY4?=
 =?us-ascii?Q?r8zZ+upYUeDSMJzTsA2DXE7ZCU6fXY24pebgAgM8+q3c+T5KpYLqpZLvCNU7?=
 =?us-ascii?Q?I0ZA7PU2nsp8uGQut5k5S8vg8/KJ4D3x6oZEqdNCzM/Mw5HDJ565cgBDp720?=
 =?us-ascii?Q?lgGAnpYZmXpe9dEcVHWPO+sxV+Mi044A/wmsAAKWCY5jHqWw9/+bUchz1b9D?=
 =?us-ascii?Q?hk7Z5l/YzVWxEkIikBTFtuB+rDjZwn0hYhaN8fFLWiuxK/xgLRfCDaUuQIkx?=
 =?us-ascii?Q?EJTQDI7IL48cjUacx1Wftu8wIkyQkZ0DujaTpx6N6g4GvlEd3iMsgvTslmYn?=
 =?us-ascii?Q?T8nNG0knCmabg7Cbif0/EGtOVfpqwehU3hJkYLOwLawmgNiRyifrfjxTSHlL?=
 =?us-ascii?Q?ReAvxmqjrw096oFczGxEoY3+GEeD+Jrkyi5tblJ/p1cVMACrSvzfPUuxcwfv?=
 =?us-ascii?Q?c94Bnv1adLLE9ka/S9vWbzxdPY2E0UyFz5KPgYnTCq5c5Nj9eJHtdH+zqwIH?=
 =?us-ascii?Q?VFj7K5o0nMC2ARSdjDnXPASkPEfu/77vzvHzT0Al1EQEzvt9FxLaTM7+jn0c?=
 =?us-ascii?Q?Gil2EYpMs7T60NjvVGB9C11jNh01902qKeUx+iif1a5Eq/Wr9Jhg/DCJN+5I?=
 =?us-ascii?Q?my9hmU2tKq0/gIQ1oHnuPLbOOIuAIEL6y3322MWGx+vVePNe426v9ghNpqiG?=
 =?us-ascii?Q?dQOuAUmP4urSRWXPr+BUOpDdSyQLvprxwDvNB2x0xr4OoqrS6dqHYq7abx9M?=
 =?us-ascii?Q?bj00anggvz0FFhppAKTK4fToSsnJOmqqmnhgEtQRsyQEMSAtW0D/3IBm2V/A?=
 =?us-ascii?Q?WLv3UPTQFvdrzoST6uAhq3IxGj0sF7W1jRRC48D2ZkFMtd0os8zKWeUuEOG2?=
 =?us-ascii?Q?mPFRZ5pHQ7duxOR9Xf3l0TIDn0Mj+1ifoW/6Z//3uIYTSRgj3bGgP1rIFlyj?=
 =?us-ascii?Q?snYizyQ0Yucwolg3cPRaBZz/BNUlNT4H+WHrcMZo470A3KDvCO8PFBV9aBen?=
 =?us-ascii?Q?Kdx6jKxD0IgagwOE3gIPtysowvTCJszGjWYgLcKBOD2Ggnru6PeWoJV2zVuY?=
 =?us-ascii?Q?BkCFL0xRIx0TUKFEO2FfDFVzx18SqNIosdd4CixLI+3jFDvLKDkGSrWHqyZv?=
 =?us-ascii?Q?kraYuvyQdW86OsK+/LpSXACAdMrLo3f5NbGRGhYEOMZQ9wBgnh7Bj6bujIBg?=
 =?us-ascii?Q?qVZuueDVTatFtQIzPnEd69I2dHRmrHl41ezmDX7coM2xVkunAwYrhrF/G1XG?=
 =?us-ascii?Q?ia9bZpNQSS61JzwwFGiHQU3Im5weNg9FEq6RrSMY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aef36bd4-f8ba-4c9c-a556-08dbd64d6307
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 18:00:06.6636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zxlVsxadLuv4+BWFlX22VieTqm+yX3c7CjwwzqyXAqUHwRxgOpgFooSUvmOtRkYiN3b/qnunuhrr8Kq0fXxoCg==
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

Before kernel 3.6 D3cold was considered "opt-in" for PCIe devices.
Userspace was able to opt PCIe devices into d3cold support by using
the `d3cold_allowed` sysfs attribute. The policy changed to default
to enabled with commit 4f9c1397e2e8 ("PCI/PM: Enable D3/D3cold by
default for most devices").  The sysfs file remains however and
can potentially allow userspace to prevent the SoC from getting into
the deepest sleep state on modern systems.

For debugging purposes `pcie_port_pm=` can be used to control whether
a PCI port will go into D3cold and runtime PM can be turned off by
`/sys/bus/pci/devices/*/power/control` on PCI end points.

Change the sysfs attribute to a noop that ignores the input when written
and shows a warning. Simplify the internal kernel logic to drop
`d3cold_allowed`.

Link: https://lore.kernel.org/linux-pci/20230918132424.GA11357@wunner.de/
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Changes from previous submission:
 * Update commit message
 * Roll into series for D3 related handling
---
 Documentation/ABI/testing/sysfs-bus-pci |  4 ++--
 drivers/pci/pci-acpi.c                  |  2 +-
 drivers/pci/pci-sysfs.c                 | 14 ++------------
 drivers/pci/pci.c                       |  3 +--
 include/linux/pci.h                     |  1 -
 5 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index ecf47559f495..b5db141dfee6 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -283,8 +283,8 @@ Description:
 		device will never be put into D3Cold state.  If it is set, the
 		device may be put into D3Cold state if other requirements are
 		satisfied too.  Reading this attribute will show the current
-		value of d3cold_allowed bit.  Writing this attribute will set
-		the value of d3cold_allowed bit.
+		value of no_d3cold bit.
+		Writing to this attribute is deprecated and will do nothing.
 
 What:		/sys/bus/pci/devices/.../sriov_totalvfs
 Date:		November 2012
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 05b7357bd258..a05350a4e49c 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -911,7 +911,7 @@ pci_power_t acpi_pci_choose_state(struct pci_dev *pdev)
 {
 	int acpi_state, d_max;
 
-	if (pdev->no_d3cold || !pdev->d3cold_allowed)
+	if (pdev->no_d3cold)
 		d_max = ACPI_STATE_D3_HOT;
 	else
 		d_max = ACPI_STATE_D3_COLD;
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 5e741a05cf2c..52ed5a55a371 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -523,17 +523,7 @@ static ssize_t d3cold_allowed_store(struct device *dev,
 				    struct device_attribute *attr,
 				    const char *buf, size_t count)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	unsigned long val;
-
-	if (kstrtoul(buf, 0, &val) < 0)
-		return -EINVAL;
-
-	pdev->d3cold_allowed = !!val;
-	pci_bridge_d3_update(pdev);
-
-	pm_runtime_resume(dev);
-
+	dev_warn_once(dev, "pci: writing to d3cold_allowed is deprecated\n");
 	return count;
 }
 
@@ -541,7 +531,7 @@ static ssize_t d3cold_allowed_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	return sysfs_emit(buf, "%u\n", pdev->d3cold_allowed);
+	return sysfs_emit(buf, "%u\n", !pdev->no_d3cold);
 }
 static DEVICE_ATTR_RW(d3cold_allowed);
 #endif
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 59c01d68c6d5..8c5a6f68f63d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3067,7 +3067,7 @@ static int pci_dev_check_d3cold(struct pci_dev *dev, void *data)
 	bool *d3cold_ok = data;
 
 	if (/* The device needs to be allowed to go D3cold ... */
-	    dev->no_d3cold || !dev->d3cold_allowed ||
+	    dev->no_d3cold ||
 
 	    /* ... and if it is wakeup capable to do so from D3cold. */
 	    (device_may_wakeup(&dev->dev) &&
@@ -3204,7 +3204,6 @@ void pci_pm_init(struct pci_dev *dev)
 	dev->d3hot_delay = PCI_PM_D3HOT_WAIT;
 	dev->d3cold_delay = PCI_PM_D3COLD_WAIT;
 	dev->bridge_d3 = pci_bridge_d3_possible(dev);
-	dev->d3cold_allowed = true;
 
 	dev->d1_support = false;
 	dev->d2_support = false;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8c7c2c3c6c65..5f4ed71d31f5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -376,7 +376,6 @@ struct pci_dev {
 	unsigned int	no_d1d2:1;	/* D1 and D2 are forbidden */
 	unsigned int	no_d3cold:1;	/* D3cold is forbidden */
 	unsigned int	bridge_d3:1;	/* Allow D3 for bridge */
-	unsigned int	d3cold_allowed:1;	/* D3cold is allowed by user */
 	unsigned int	mmio_always_on:1;	/* Disallow turning off io/mem
 						   decoding during BAR sizing */
 	unsigned int	wakeup_prepared:1;
-- 
2.34.1

