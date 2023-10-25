Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB63C7D87F3
	for <lists+linux-pm@lfdr.de>; Thu, 26 Oct 2023 20:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjJZSAQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Oct 2023 14:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjJZSAP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Oct 2023 14:00:15 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD5B194;
        Thu, 26 Oct 2023 11:00:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfPGze8CFknUAidbc2UPJuuVpNgiELx/WgMfOoRF/IolpME1SLPcbppdGSwxA/yGCtoTY6oe5vSM/1Sf3B2EL+cGT4ttC++OXC1F4EswY0DhNS61SjTcQveRwbsVB6BOLKGx7vnQx24uBC/ZsZsT8KI8BaheGvBx8B5w2kcLjpBlF5Tkg7atcmdB51oYJfhLwPLOKiJlfY4Pe7dGkHrn35XPZc3of27o0mWP9UhqHZlM1pboQZ5woZw2w84NoK596gIL6J0xFM4lc14Zb/FXTTYZn+cUPKqs3e9PD0VVhDl138+NljlvzK6UoBVbEcPVJnWGxzNg3lsNTju8fN0AEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeMEEDA0o/xz+YB5OAwmFUl9k7FxdNparpTFBxGlRcE=;
 b=gJJUV3NC1WM8zLxOsehXyAYQrS22SbksIARrO+YIe4PJ2w1gGa61VTxnz9lUK5FTGvp/NIidPF/AWAwQh8AR7ZVmLoxtQWbKdGU3SfEJqsJ0/XxPi6oUQeBEGwo6pZTdbHFZHNplyFJt3ji9eNJPB+6/dmKIrpSuHRMy0VIQKJCmKB0jkNHypstdB7wOpL4IrUdJwmX4JWeJ8iLapXfd6kCLybq2A107k9tIaN7H/hHbtueeBOqA4Sts1eZY/CDPq6TU1jt13GO1O9z9BR2BeCuqW3tYIZyk06sHZJC8XBZ6cin1LtuvzHXXT23HSpvPaFLd/UEObSX6NPTo0oS6Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeMEEDA0o/xz+YB5OAwmFUl9k7FxdNparpTFBxGlRcE=;
 b=H4zmO76hEKeEdGHk/bAWcEeA4yLSSF4oY/a1yK+Fo/Wkglerw7s9jgSVVLkylNF9UVkmYYCMO7+6ScOOJp2rXS/XRstBYN6xZnzPslfeDwC602QHzV7CLJTdCO8vkVqPUpOwHdxXooP6QDdAOM/d/VgMRlXQaYmJa8QSkF2jQZE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB9007.namprd12.prod.outlook.com (2603:10b6:a03:541::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Thu, 26 Oct
 2023 18:00:09 +0000
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
        Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 3/4] ACPI: x86: s2idle: Export symbol for fetching constraints for module use
Date:   Tue, 24 Oct 2023 21:05:45 -0500
Message-ID: <20231025020546.504-4-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|BL1PR12MB5705:EE_|MN0PR12MB6101:EE_|SJ2PR12MB9007:EE_
X-MS-Office365-Filtering-Correlation-Id: b6ddfac2-c781-4ab2-5361-08dbd64d6356
X-Microsoft-Antispam: BCL:0;
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(136003)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(41300700001)(4744005)(37630700001)(2906002)(38100700002)(54906003)(316002)(66946007)(6666004)(66476007)(107886003)(66556008)(1076003)(6512007)(110136005)(6486002)(83380400001)(44832011)(86362001)(450100002)(5660300002)(478600001)(2616005)(4326008)(8936002)(36756003)(8676002)(26005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 02:06:12.8102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 818e701a-1c83-4a85-59ca-08dbd4fef6be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SATLEXMB04.amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5705
X-MS-Exchange-Transport-EndToEndLatency: 00:00:04.3176247
X-MS-Exchange-Processed-By-BccFoldering: 15.20.6907.018
X-Microsoft-Antispam-Mailbox-Delivery: ucf:0;jmr:0;auth:0;dest:I;ENG:(910001)(944506478)(944626604)(920097)(425001)(930097)(140003);
X-Microsoft-Antispam-Message-Info: wud2IOl6b0m8wwswfFjeYnuWQhgCn12cj1ESuqPNO5/4g0+MB5jTpTmEG/fj69DGJYBoAuAgbHfj2HJB6wfwWa1FqYIlrwglsz5JnY1CH6cX1KM7mRCGQpwFXmqRrRkIdXEG7ZXsv8J5W+sY3TLNlem5iFZYkICLKzRM52TnFyoUJ6d+Yc4bCjwnB7pFwGi7OPOW3kAxrMZL2Iow98PNtNYsDfZnWcQbt0xYwc7ATxy866FRHZ8ON9gk6u8VV5hAiZ+TiyGtEnO9oF3ZfUbWzX72hUyuWQ1SDJrTZT+Yo5lxpCDzxvwU15/NSaiwF7BxiaZ0e4UlFCYorQ0Pvv9iycEQ2s4mtILL7WPRI4dco1pLPwZ9H1tcYMd+8iLlNCvApuAAqIgbGhMqa3iQ2vcdd5XZrlsT6y8kdtjpFpAPY6AZk42eF946h0qMnADteVkmkDQ0iSrU5gh1TGaKWP19WgnUl0BWr18kp6GwnqCrqLtVyBCb02vst5K8okEdY1lMpGbs7eFbl2Ytbu7UJAC21yevXnutfkoyUXdsyluO/wJuBuQMfSo97Xj0UUaKwpht
X-ClientProxiedBy: DS0PR17CA0021.namprd17.prod.outlook.com
 (2603:10b6:8:191::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 818e701a-1c83-4a85-59ca-08dbd4fef6be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1zkILBmuhyh5nONsirBYJEbv0yHfKWIiGbeMCs9F2pJwWhNx7HRclZh8o3OJ?=
 =?us-ascii?Q?rwFXkr+Pbv5Svy5cgccydq916hvaoRJCr7NRdtqTZjGlfN5YUya3gNOCLHXF?=
 =?us-ascii?Q?lcNAT08e9+yPcJL+8lR2c0TZ9F6ex8xd6s8LV3zfDpBaw9lIGEFS85OntB8i?=
 =?us-ascii?Q?kxkWsgVU5xovPDPfm7IAEjrCwZB0ePGJzgsb3zWn+Xc7t4lgtz+oOi6n5vif?=
 =?us-ascii?Q?i6NM12OnLiXSH+N8EsctuE+Rclzwg7Gl3Ha4sOLhCDVhEZ8Vrk2OJ4/g4jLS?=
 =?us-ascii?Q?wtqmBO4Un9eV9TqZcrAzXVvc36epV31y5SXOXgG+r6xGSVHLlUXkO4ftLBIc?=
 =?us-ascii?Q?RrxM2pw/6bwLGWS8S+aMyC0AINORrEgBtoL2czVe+GQ7SEVacda9cdgnczRG?=
 =?us-ascii?Q?yNi5fTJLCHzGf5zdXfVdUY6tImhoL1V2Kqc1DG4RJHj6/qfeEZRXjr7TnL7a?=
 =?us-ascii?Q?HrNBE3lNvrjtn4D4NRj9roAjES4nB9oVixGo/2KXThWZKGr9UrlGp/Sf6g6H?=
 =?us-ascii?Q?yGxRSF6Np4hXCXiPXBQR/ecTeuPDQN9iZ33JySDDma9aEHUUsOOIqv94jOsr?=
 =?us-ascii?Q?rRQLE68FgHPdeO6nzCdYkcQ59lQq5VbHFzLjGDlGS3EiMuv53h6Mj3hbgVU3?=
 =?us-ascii?Q?1GtQ54crbqg5ky21XUMwUktLc6ivvIeolNnRF/Oz2R+hPRHAU6gBkl6xJVGx?=
 =?us-ascii?Q?F23IXoKMeLf6rfmwYlgGa96tRJ1Iq2UhBSTAgdXotUXch55wbKxLSwIKbEdQ?=
 =?us-ascii?Q?0nT8htzETyjQ3itmWDwwQc3NKbqmc/8NqFuhI1U1gJvoaKYuVMpsU45bT5fn?=
 =?us-ascii?Q?442U2hzvWYXv4lwL3tsnVRNRFQk2kWQwRHXfhlbKagY2L9X7AcbvAVAPr4Je?=
 =?us-ascii?Q?GRTT1FRd6WeQ/T29Fu2g4Gt/v3IUsftRnVkbej54F1Q+BJrIz9LEe+U8b+/K?=
 =?us-ascii?Q?ZOqBRVRZ8LG+J7aEkbWPgIpYB/mMoAVW9n9nkpIuatAa6XhOahnCkszYhq0r?=
 =?us-ascii?Q?w+Q4HfhZqIKRlSV4QhoVDsxY6/PR1sZK1RBuF1lOGZ8NyZGjaWnZOOEYhJte?=
 =?us-ascii?Q?ZsGqJVsjQb4oFYfQAk8ZqVFjQah9TpXYUADcUcdmvKklOQSnuQhUhHD1/JHa?=
 =?us-ascii?Q?I+e4De6wUyE35vcRNbPciEtG+WxL8XFEEKnA9avrFs7dbASNYWrMWdZNWtA8?=
 =?us-ascii?Q?BpYZmvlyLPd1LnXCQQ+dlhZmVRlPTad+pSy4mW0PTrV2/UVG+fW0hPbsaJSz?=
 =?us-ascii?Q?7zVYqwQordFMZb5HbzTe8iI9t/dJIyJUsl0lHmbqum2C4Goh1C4P1tduzhc3?=
 =?us-ascii?Q?aT3I3B/gFqwdMhFS8EbX0HHu8TxCYhEEq7uYbjkmmRAcX9aD4R/D4hKuSF0v?=
 =?us-ascii?Q?3B6GEM8RjRmz3C0cqRQPlKLV1DG9xDLNWXKxStxqpMLXYNKgq7ZAnaaXJJIl?=
 =?us-ascii?Q?BpWcyclCUpZXSRQactS3BtBKml/FksVC0AG1o/8kSncBAH0VSrVIhKp38gMK?=
 =?us-ascii?Q?G3MvRG4fF0Z3iiN2+C2UpR/2M1DP+opqQYUYOUUuQVTO4/mFrw+7IC/B2p2s?=
 =?us-ascii?Q?9JLhA3XoqMIYopfPfOwHnkb2how3bDPZoEk0H/Bt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ddfac2-c781-4ab2-5361-08dbd64d6356
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 18:00:07.1783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: smhK9yM2CkzsNThDupGk+2/dnjgJS4Yupkj1BunlO7BLWa/cN6z4UJLzQaB9RHf7UQR8rQVhJq5M9h5wv3Wf8g==
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

The amd-pmc driver will be fetching constraints to make decisions at
suspend time. This driver can be compiled as a module, so export the
symbol for when it is a module.

Acked-by: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/x86/s2idle.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 08f7c6708206..de9c313c21fa 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -322,6 +322,7 @@ int acpi_get_lps0_constraint(struct acpi_device *adev)
 
 	return ACPI_STATE_UNKNOWN;
 }
+EXPORT_SYMBOL_GPL(acpi_get_lps0_constraint);
 
 static void lpi_check_constraints(void)
 {
-- 
2.34.1

