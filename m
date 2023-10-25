Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE4A7D87F1
	for <lists+linux-pm@lfdr.de>; Thu, 26 Oct 2023 20:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjJZSAP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Oct 2023 14:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjJZSAN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Oct 2023 14:00:13 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80496C2;
        Thu, 26 Oct 2023 11:00:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQ+zditpOj51dF8udv6r/cWMVmlqmNHvP63G5P0Dioi9oMRTpF3IuE39VJW6Is2AZc4aSHEKqUriapjVRVs2TEHSZVx71ZHkgRiyX246IlVZy2Mhb5PQ59bmKfRN3zUIczehE9TrNpKBi+mA8ifU2gNilRnQYndnty247MODgUdRdRDhsrX3EOsxoPKaSC4Dh9cehMwzxcUR3x1uS5u8zyBrXLqOBzRPLEaFrWzU7Z4vvm5xiIBdsFwi9Ql12Va2mqn1zveco2dsdTb2HjfCAXKueAOZJ4MQIvssElZDhL6tR4hXaYxOlmrebNFmUIB9jb0S4U/UlXDGB55RhuRtIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kB/htuh/LmLMsy+Xjs9vdnldu2LPswk2sXkenxKpz/g=;
 b=O7XEKUZrbIiY9JzGUKTiSJrYGS9Z8oTD4Uh0qjzfjLvjRUedN4o5WXjIHTSejZ4VgDeKqtzcP0ZIYXRJtJs5dVtAkJjcSArs5oZP20jjQflUqKtPhA22JQ1kYt1SGqN6bkuFEDiWHi0NDsBdxogTRo2ssfT8gh8QUnGne7eNOFaagQkfl/nXEekWBEt/XCeU97GiSXghIZmai22jz7RsrCQ5E0puY9DuoZSkQHIFXlC8cw7X10T2+QGrGvq7pP25i77O8BZBM0fhb1xXXhDBZb5zsZ3OVm84okdb88h0GfTWfj+YeUkvuK+CIeZ5MN7Nu4aQTNRBi8MkIqkN4nO59Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kB/htuh/LmLMsy+Xjs9vdnldu2LPswk2sXkenxKpz/g=;
 b=rH0GQyVMdlb3m2wjmYtxbgCPqPHCmvIvKS6zD1ZtVPPxeqkAVYjBluavtvNAK8pAl46jMlsV2gnN7uXHLpTmgBdABkNg2Szow74XgPriklXWrHH8TrYemw9Xcuw8R1E9C0pAAhVYkxKSw1yy8tCtG59ZPYC1Mw9TPnS/YMq7S0g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB9007.namprd12.prod.outlook.com (2603:10b6:a03:541::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Thu, 26 Oct
 2023 18:00:07 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%4]) with mapi id 15.20.6907.022; Thu, 26 Oct 2023
 18:00:07 +0000
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
Subject: [PATCH 2/4] PCI: Refresh root ports in pci_bridge_d3_update()
Date:   Tue, 24 Oct 2023 21:05:44 -0500
Message-ID: <20231025020546.504-3-mario.limonciello@amd.com>
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
X-CrossPremisesHeadersPromoted: CO1PEPF000044F2.namprd05.prod.outlook.com
X-CrossPremisesHeadersFiltered: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|DM4PR12MB7695:EE_|MN0PR12MB6101:EE_|SJ2PR12MB9007:EE_
X-MS-Office365-Filtering-Correlation-Id: 788c1f59-8068-4e6b-07c8-08dbd64d630a
X-Microsoft-Antispam: BCL:0;
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(136003)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(41300700001)(37630700001)(2906002)(38100700002)(54906003)(316002)(66946007)(6666004)(66476007)(66556008)(1076003)(6512007)(110136005)(6486002)(83380400001)(44832011)(86362001)(450100002)(5660300002)(478600001)(2616005)(4326008)(8936002)(36756003)(8676002)(26005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 02:06:12.5133
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f255eab-89eb-40ad-0cee-08dbd4fef691
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SATLEXMB04.amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7695
X-MS-Exchange-Transport-EndToEndLatency: 00:00:02.8019935
X-MS-Exchange-Processed-By-BccFoldering: 15.20.6907.018
X-Microsoft-Antispam-Mailbox-Delivery: ucf:0;jmr:0;auth:0;dest:I;ENG:(910001)(944506478)(944626604)(920097)(425001)(930097)(140003);
X-Microsoft-Antispam-Message-Info: kGbGfyxLbkTZevPC/tRfV5jrdvPwcjcr7DflpoYAJL1hkc9rsAFpGrPyUZLtRnNNSNU9EkZ8BeraKurR3m6orIGbp4F5+bkgxZkUh2FYhYM1w60eFwxw2nstdBWnV3occTAf1R2edy0R6U5lRwUas/xYm5o0IuIGaRzTx3ROd48pya2j69SFdBxCCpgNwk5jfGTRGFTXc7z10SZ4VPDHd4oD5Q5gyGAySl4TxAl76bn2YSg13ymgZx7Wkgc5uSGwbrnV0GzJ8k2rXcItCpmv1uxkeEmXMWOMEtmCMa6dSUvXGUFbGroDdMNCg8uw2Bx0QBhKd9O5Hqvrsuw8o7/CBY7g1eiSUThkNkL0frgHc1ASJ29z7m0nc8s4OY3nokxFoRDi0LXm6PiIJNGOitqNXQHkp5twolq/eU297ZVwnssnfHiTicHZCLP9UTrNSYDRFpPFrFFN3VVCR47nKUNsbDFxcryVHAk7fr6oi5ShS5WKtCm4n710Y6qoMa5zmhQH5V2NKdsK91ZVmVK4krbjPrM5NqKKwYXmSM7+3AOJoWouFTk5AO7fSSnsi+tW42uX
X-ClientProxiedBy: DS0PR17CA0021.namprd17.prod.outlook.com
 (2603:10b6:8:191::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3f255eab-89eb-40ad-0cee-08dbd4fef691
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mtV/pIEU5lpj32W3NxZlO5j3HmeL8mg2TGw9fEm+mqjHuDz9W2oHpYnM4lBj?=
 =?us-ascii?Q?cK94MPKSrpcH+VeOM7dn00SvWx66W56Iy5E7l8hWnz6XCEV9W023CVZu/Lsl?=
 =?us-ascii?Q?l77SufNO7Z4pXVaIKbj5tnr3w0JU9Yg5jBWevVvtDiRXhTSrWMbkI6eMT7ei?=
 =?us-ascii?Q?DsGuC/9DCfpBH4B+37fZeoQe0OHry/umAViANAVHdvXloZIsD0kSbjDV1/fz?=
 =?us-ascii?Q?1ce9PKh64Rka+41heLFZAlT7FuoQNxzcqjVwgRkoB81gEA7ALDH2XiHm1a71?=
 =?us-ascii?Q?SUKO301xwP44U/mC6HliW47XP3S4/9V2qc89vxLoV8FMhAYl3hOlIKHhXY0J?=
 =?us-ascii?Q?XbM0iv8yfxlLfES1aOwY6s0BA7zARU1EC1N59BpnjURO/XSWctyLhNBqv0Sw?=
 =?us-ascii?Q?7tWIDZOhhfHOjT8CBthvdewdkLDpiDGmPtzMD9qDlAvAYXeC5CpmUXwbhuQ8?=
 =?us-ascii?Q?Qyi89jJzeOX6t5x5C9nOeN39vXH5ZPOxfeLArmqtlYYsRY8emsdswRKTIgUW?=
 =?us-ascii?Q?Q+qVHYxAhmgQOZzpAZrWbVCRW+MCdJl1/Fm07sF+0PhDaS1KdOuzE8ZvGrWI?=
 =?us-ascii?Q?DMQb6ygwRGU5llunOFgCkvHENWhDUSyk6mehW+dtSxqBjHw0e+cFBCv3NLfP?=
 =?us-ascii?Q?//82wJihzIfpy/NvfPjgHNKI6io/GnFUgdhspGROuAxVDB/W3ONWCU9MdPgT?=
 =?us-ascii?Q?cv4A5fuS/4i7/NnfkVCFz48LW+uZ62014PQ8QMXkw1vEHKk6ZyTLcR1ysJdS?=
 =?us-ascii?Q?rSsvJbP9Tloj/54jdiuuaTI1oWMv/Z2ybzcdygMK5LpfntTTEStLnwPKi/UX?=
 =?us-ascii?Q?fHeEzoyrmVSp/q7LdmbWZCMgOlb1/Vie135KHw/OSgEQ8EN97N0ZhpkxTmIf?=
 =?us-ascii?Q?3UO9D6MME78PzrBeyx1CASC4OvVoh4BAUD1OKv1ixXxeii5kk9B44wFJRdB7?=
 =?us-ascii?Q?6Q87VUghODv4u/LrVmJlbMGyb5XQegGCWzD+hepaXo7lkw6dqsyVNIhNpEVe?=
 =?us-ascii?Q?g4fPQShPu8CHXFfTFATBxR6W3FLRXBRQue6tOGCDvwpb37T6P0+vGAYsfVZu?=
 =?us-ascii?Q?YBHNk1FSV7BMPExCD22jmcOQ1wonuek6CSWwcjRn91y9SM5LkGH4Y0GDRKrA?=
 =?us-ascii?Q?/PeDS7SxcXvPJLh1KSyxs0WPqGQ3hY285Os8/O40otOlHka9kZ/AA1uvy0ow?=
 =?us-ascii?Q?13nHrhqzsOMWSX1CX9kdBxOU83YbCcV9V9winonoF8HZ7jkJEs0oT4vxrxof?=
 =?us-ascii?Q?t6hTYSuIydEKe7WSTFMPhRqmd/KtdXTFPg0RyCQQen4KBX/T9pixqVJy7QKk?=
 =?us-ascii?Q?GI1A0IZ/jDWotHaSasSHLAJHXErbhNAO88UCShoIah/g0r/gGXOpXqiLEuYs?=
 =?us-ascii?Q?6ylP9K2GH2C+lqMnhfVjj/IEJT6g5IVSDFICFxZo2M4hJjc2+j4mRxsFBXwL?=
 =?us-ascii?Q?9d/6xs3HR1wwgj1oPaQRh7wyqCROW7jV7vQ/TUPAcWDv/bOb7vWIf/G7mvhF?=
 =?us-ascii?Q?c4AXEfgtUS4PbzfSRKsezpsl6HjNkfXebgCYLSmdiMiWl9luiIZdt5ERid/W?=
 =?us-ascii?Q?hdmOJiv+ws5h7JPEe+ks6O2rxxyuTT+0WB6CmLOP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 788c1f59-8068-4e6b-07c8-08dbd64d630a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 18:00:06.7052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wZQcPEJIJOQoeFfBnej0NEP9sVPwbZQWmD4B3to1Hiuq+FOk91NH44Sc10XhUgMW71/o2hLb6KEfGBX690jEcg==
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

If pci_d3cold_enable() or pci_d3cold_disable() is called on a root
port it is ignored because there is no upstream bridge.

If called on a root port, use `no_d3cold` variable to decide policy
and also immediately refresh whether D3 is possible.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Changes from RFC v1:
 * New patch
---
 drivers/pci/pci.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8c5a6f68f63d..28f70e8ea478 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3021,6 +3021,9 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 		if (pci_bridge_d3_disable)
 			return false;
 
+		if (bridge->no_d3cold)
+			return false;
+
 		/*
 		 * Hotplug ports handled by firmware in System Management Mode
 		 * may not be put into D3 by the OS (Thunderbolt on non-Macs).
@@ -3096,7 +3099,11 @@ void pci_bridge_d3_update(struct pci_dev *dev)
 	bool d3cold_ok = true;
 
 	bridge = pci_upstream_bridge(dev);
-	if (!bridge || !pci_bridge_d3_possible(bridge))
+	if (!bridge) {
+		dev->bridge_d3 = pci_bridge_d3_possible(dev);
+		return;
+	}
+	if (!pci_bridge_d3_possible(bridge))
 		return;
 
 	/*
-- 
2.34.1

