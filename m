Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E736F7D87F2
	for <lists+linux-pm@lfdr.de>; Thu, 26 Oct 2023 20:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjJZSAP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Oct 2023 14:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjJZSAO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Oct 2023 14:00:14 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA62192;
        Thu, 26 Oct 2023 11:00:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frC9wKmDeYD0gF811WJW2ukdAdBOS/gnL7KIHIS2lTFIrO+LrikqKY79fb96rhCtehFTptoLEwFBz7YR8kRzVp6Uck58E5MV+BgxuWz0XYngW9DpfmwrGTGBtx3GdrWhAYUOxVl0c5BZbau6ul61Tx1kyZ8pp92IyeQlnjCDt5KXZtwKl+y4YKtQnZjhku9KV8G4SqTrXaTkZYkr04rvD7v0ifhlgcj7d5GRdILJfakjFVvPJ9ebzBI7OH+CMiB+SkTJLbLpI+d+5+IYCNgZb74+mkL0hBwIHXUgYcmibU7OQvGd0Qskqa/Aep8uLpMM0BFEjclDDaQ6pFFow1R+tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fspsuZ2DJaC7CNRMP6kmYvXQZPiL0tnnUsURqdjXNHg=;
 b=GFbrUAhNJ0FBYOPZfRXO9W4/jXhRl2pGnnU8sxRUnHbWL9NtFpaSsYa2+8IZWw2YUxY/Vph7cQw6pBysTTTp4IQNl/jq7D8wAG9gSb4bXJGGxvFuwNaVCf0MaMmkyy4Jbq2OIWf5/Yjc+fgmo4xsCbNGFMhaks7uPp3r93p9ve9ypNaLacyrm3Txz2LYC+0P1DRpxj21ftZ4ID4IbGe+OWX1J1Hwg0pp17RS8xcGhxBXZ6xBXB6E6WmhLisNS9uwHMpeugoiaqqOnPqGdLVdZApFE62nHAjSLmU/adEA0UoMSIcbRdlWICH8/iw3d1IiKU6FDWNSgD6drbhJ2ZEeiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fspsuZ2DJaC7CNRMP6kmYvXQZPiL0tnnUsURqdjXNHg=;
 b=lvhTll2ldsUqEXfBSSiyJNpTqWE2Vc0l0WS9Vwt6kpGY6QAtWzuMFw54TJlX1AkHRuudbB06Etgw1kYuJZmGTRVxokf1rPsrCCkV546QX302krB99VYULcB6IF7BBlfKS+hvE8ihpo1zkSVOJSFze5BFrQCYJN9pxTyII/Qpmoo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB9007.namprd12.prod.outlook.com (2603:10b6:a03:541::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Thu, 26 Oct
 2023 18:00:08 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%4]) with mapi id 15.20.6907.022; Thu, 26 Oct 2023
 18:00:08 +0000
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
Subject: [PATCH 0/4] Add support for drivers to decide bridge D3 policy
Date:   Tue, 24 Oct 2023 21:05:42 -0500
Message-ID: <20231025020546.504-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-OrganizationHeadersPreserved: SATLEXMB04.amd.com
X-EOPAttributedMessage: 0
X-CrossPremisesHeadersPromoted: CO1PEPF000044EF.namprd05.prod.outlook.com
X-CrossPremisesHeadersFiltered: CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|DM4PR12MB5817:EE_|MN0PR12MB6101:EE_|SJ2PR12MB9007:EE_
X-MS-Office365-Filtering-Correlation-Id: ef6591d0-44fe-4ba3-f0c5-08dbd64d6353
X-Microsoft-Antispam: BCL:0;
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(136003)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(41300700001)(37630700001)(2906002)(38100700002)(54906003)(316002)(66946007)(6666004)(66476007)(66556008)(1076003)(6512007)(110136005)(966005)(6486002)(83380400001)(44832011)(86362001)(450100002)(5660300002)(478600001)(2616005)(4326008)(8936002)(36756003)(8676002)(26005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 02:06:10.4068
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dcb2bb0-f7db-4840-0163-08dbd4fef552
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SATLEXMB04.amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5817
X-MS-Exchange-Transport-EndToEndLatency: 00:00:01.2678077
X-MS-Exchange-Processed-By-BccFoldering: 15.20.6907.018
X-Microsoft-Antispam-Mailbox-Delivery: ucf:0;jmr:0;auth:0;dest:I;ENG:(910001)(944506478)(944626604)(920097)(425001)(930097)(140003);
X-Microsoft-Antispam-Message-Info: QTSj/ouoK1Eds5+0GKNNTugEZBT+6/Fn+T4wkgHOWkSKmLKtm8hhgxJaRwvRGhkUkfN5aoCLWX2xZSs/19KWlW/hhlpXDvWjtgMOh4QZbDGleqfHpjoBPe3HbJSlJ71chDg+HYFtyYrDtMkV0sRZovosFAwMazLg5zJcePC9z0aLwUSPpHMg69mvm5h2j0AeCZrg4HOou1mSDiJEVMeodUctHPmYR0Uotc0Hmeo12xxRK0vvfm4GKOU8X6DbYtpr0ojj/Ub/SnOU7tRNxhVs5UiUU9nJQLhjxI+TMFffBZ3iv1IHPUhNZ5rOkjyvYwS08jST2cDMPG9SAW1Pa+7/F1h5G9ascXNJSzH9Igw1mzBoYTq7UucDfdC9TLUYSOWJlFBQeuiwVoJIQdfYlcwzDwJWVa27qF/pdXjNNtPsz8iP/KzlN1diN/P8TJddZ3jiG84cOzkJA48jPmmasqwhE/DAnCCSv+IyK9h2kxGD1sD2JKnl7wAx/c5uHgq9SuStBlYpxsXNu1W7up4X7HP1K/tIddG3XWuXE4n3ogiFgeHmRl13RXT4q5lUixMUyXGrELvurYcRd3ekzMZWWX76pA==
X-ClientProxiedBy: DS0PR17CA0018.namprd17.prod.outlook.com
 (2603:10b6:8:191::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0dcb2bb0-f7db-4840-0163-08dbd4fef552
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2AOU3B0TWN1Jzt+9MbP73/oruntkRDvuiHl7z7liJmZ5ZNKZPwDKs1yLehbT?=
 =?us-ascii?Q?/x5gU78soAchS2oaADZdN31iUa4lsIwQbxoOweuZfAsKofn2HfgBUt5pl1Uj?=
 =?us-ascii?Q?wmiY48fM4F6Yy2+Chwid90TrLcFPdVwy0Eu7GF4hN5jYMC5fYIyWQSTLPbZX?=
 =?us-ascii?Q?Ui8WExAWjczdnU/UJ6S7nZEIASDmnI14pP7FXHZ2ihDh32X7T/Os5ePe9rDl?=
 =?us-ascii?Q?gT+l0kW1VAKtsHvwpAF98UiysJsdLZC36G2jQra3W00YBrjBwMyxQtuo3mrN?=
 =?us-ascii?Q?VNUT5Cm1sQ4YPrkOdulyGhkfwIYUEx1dRNgTpaZ6dtGEgfiKDxOV85f8+wrf?=
 =?us-ascii?Q?NFy5GNRmbnZ97UvYRDFZwwz3FQi/RNDEO7Ng5EPzO1N8pfTtYtgAsS2ZRwpJ?=
 =?us-ascii?Q?iwF43ZFMnxLUg/uU8gq77SfVrMwwzUIdwh4Uk7bvITKHOKlxdAqi5fs6FY1T?=
 =?us-ascii?Q?zKfugADdImfZkJTLisJRcAoYbAwPLhKayF2QTXnUr/o4rqOPyN8lbbNT1UB8?=
 =?us-ascii?Q?HkNh7OviQDInvp6n4kLazxRF8s1IGj2cZOIHYrrJWERPV0zUQnqDSCIFwGWk?=
 =?us-ascii?Q?J6YPE2AoFyu+2rS9rFqyZPDyDRVoHFaO+usA8gUxymonlvr+ZOLTr0CV6M1S?=
 =?us-ascii?Q?M6urr6iorI3WhYDhLfpBBVNB7yOIHPi73vKU19RnyqePLK4QzCSfG4J3TGdn?=
 =?us-ascii?Q?lq28mw3XPkto1RBB+3SuxX2djgPl5Eel3lTukJkwNgiK7n51GkwbugPuCqVY?=
 =?us-ascii?Q?BDSqMMobw+vS+kDwKlUcbjSEcX/P+uxjzouVOp23hO95nYR7Cc2vmlTJ6y9m?=
 =?us-ascii?Q?b7o/IWGtmT/v7IQVrakfNB5pDCCwDsoVCWnVgPe7WJVTEi3kwicqZ9L/rgWo?=
 =?us-ascii?Q?GJ3mRGgTPclOewCxCfGN5Of8wNl43LSpTgSlw8ORP/eqZ4il29Jv2jOivLBV?=
 =?us-ascii?Q?/bIJS6qOujLRF1VXJhkEHUSQpkQXXcktB5JcdTN6u+Ld1QdMyjO9sBap1BN6?=
 =?us-ascii?Q?5biX6o92ujw6GluFIwI1LEee1JdpWEXKWZ26CzQoNFAOTna6Ry/72g6N2Yxa?=
 =?us-ascii?Q?s7PbqVLF170ozpsTUgboQ66zZsX4FJV7cdPWOziw7sD46nmvWxk30CT45I2i?=
 =?us-ascii?Q?0E5STcSznTmhRq5jrP5avzHT4vR1+2+jkVPOi4qNWyRgmZwHA977MkxPKPB1?=
 =?us-ascii?Q?LgRcfD32+JNHYtJi5o0JxrdL8j5C7jrFjLy/9VuwoN+tnYL6Src4ds2bprH6?=
 =?us-ascii?Q?d1ZRJe1q6N3bT15F+hajfCz3hH4xojZo8w19yJCTpdFuGOgPWL1IqeXIb11K?=
 =?us-ascii?Q?dxk4Kmc36hMp4BCkDVO4/fly3CALwk7wm+giZpRg4p1XsfstS1XQdf/2Lera?=
 =?us-ascii?Q?BTJjqEdPde0Yg6c7RXVW9iFI/sTw+i+f/5WMsIpNjmITvKKa300rbRxcZ6Dr?=
 =?us-ascii?Q?Gz+13IS/eCyJBcEjDwoK9SoqjTZCF8Hsojl/2KMQz5E3bQLcQSzBhq5r6ZLB?=
 =?us-ascii?Q?dC/d4JhDMX6NG31DHYlXsh2uXNeYlhmZuye3NgVU3L8gxuySHvZbDpF/Ic16?=
 =?us-ascii?Q?L7buayAh2QL6BRUkAgpqWAAPJJDGxvufC6irCMnE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef6591d0-44fe-4ba3-f0c5-08dbd64d6353
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 18:00:07.1292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5wDxWzibmFTQZWrQst9LcWB7m1aqM4YdkLI5qlQvIrJsTkg/oN97a4ClGaP9uMlDDIpn3OTGfUaL38GDMGwkCQ==
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

The policy for whether PCI bridges are allowed to select D3 is dictated
by empirical results that are enumerated into pci_bridge_d3_possible().

In Windows this behaves differently in that Windows internal policy is
not used for devices when a power engine plugin driver provided by the
SOC vendor is installed.  This driver is used to decide the policy in
those cases.

This series implements a system that lets drivers register such a policy
control as well. It isn't activated for any SOCs by default.

This is heavily leveraged from the work in [1]

[1] https://lore.kernel.org/platform-driver-x86/20230906184354.45846-1-mario.limonciello@amd.com/

RFC v1->PATCH v1
 * Simplify the logic, use pci_d3cold_enable()/pci_d3cold_disable() functions
 * Roll https://lore.kernel.org/linux-pci/20231004144731.158342-1-mario.limonciello@amd.com/ into series
 * Updates for some typos
 * Re-order series.  Patches 1 and 2 can potentially apply to PCI tree, 3 and 4 to platform-x86 tree.

Mario Limonciello (4):
  PCI: Make d3cold_allowed sysfs attribute read only
  PCI: Refresh root ports in pci_bridge_d3_update()
  ACPI: x86: s2idle: Export symbol for fetching constraints for module
    use
  platform/x86/amd: pmc: Add support for using constraints to decide D3
    policy

 Documentation/ABI/testing/sysfs-bus-pci |  4 +-
 drivers/acpi/x86/s2idle.c               |  1 +
 drivers/pci/pci-acpi.c                  |  2 +-
 drivers/pci/pci-sysfs.c                 | 14 +-----
 drivers/pci/pci.c                       | 12 ++++--
 drivers/platform/x86/amd/pmc/pmc.c      | 57 +++++++++++++++++++++++++
 include/linux/pci.h                     |  1 -
 7 files changed, 72 insertions(+), 19 deletions(-)

-- 
2.34.1

