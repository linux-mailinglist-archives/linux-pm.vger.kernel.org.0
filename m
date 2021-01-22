Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB3B300A10
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 18:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbhAVRnV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 12:43:21 -0500
Received: from mail-eopbgr750077.outbound.protection.outlook.com ([40.107.75.77]:62028
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729966AbhAVRk0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 22 Jan 2021 12:40:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wwl5uUsj3UUuUhmUoUvdZOEs1hfXMr78i6NpCXWEQEExaXSFTTQRR7PkiJy6wbAM7ldjSXn/sTyJ+/yiGEh8aH3wHuQOCTrWjqjO6IehGBQpe8722ARnR/OfsHNqq+hQ0KQaRYhL5WNf6LxEw9J3CeQqXQ/Ug3GVZgOGT4wCzM/GQlUSrhhNwVsqOK7/lMyyQ62xTcPdBLIvqUOUFIO6j5szY1S1IYp/YCKUDXsvp+eFTw2icWQr8HO8dl1fRv6LDyIYiivkJor3uC37oIK6YCJsoNGU/AI8EU+CBZGXqhHzFHC76+mWBrVV/8hMNMgWgK+G0ekZtqrT7uHYgbZiEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cn0bBx0QSOwdowiDo83k/VfMBKecf7j2Obn72M1zODU=;
 b=ajpZvV10PZiMwVYrIZ1r8LjWgZ8oCIgU6Eh1MpIYdcVUHnyIe0Xi9/ru/MiV3i7bYCbsFDoqEJBuF3uuAkCIMkkNlI0VU9EmCuBqPXw4pzYiYParZO1S27dAxw8sbl++IlNOt0i0Nw+84nn/qcfWf50JfVXedZdVzLyCtdGgaQjeiYNL/6z/6nFRNyb8U4dPiSyKM9mxiKuLjodFEmoExJn79FXeixhUii+XCpv8Mv2VGe2cGWFsI75e9AUILL3IHVhGw8UJ5eQQjhqep1enQsLTi7HhUARY8XD0sWhbBymC9uXg2RpKdthY+WFubpe9mkKtub89rdH/mZLnREslog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cn0bBx0QSOwdowiDo83k/VfMBKecf7j2Obn72M1zODU=;
 b=LE+WaROeB/MFaroUhJMpvEo3WuMAL3GN1hE3JuYvHVQrTjWGwOIZzRHnTnYPWhMTBTP2CPVCFbgMH8J65eQR9uM+ng0lbeML+ksDEzJnezk7r60WeT+B676f15N5pvktYDVbmG6PBNR8TslXlya/L3iYzGE2SChCHkMq1R9O5cE=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4720.namprd12.prod.outlook.com (2603:10b6:805:e6::31)
 by SN6PR12MB2846.namprd12.prod.outlook.com (2603:10b6:805:70::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Fri, 22 Jan
 2021 17:38:45 +0000
Received: from SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::71a3:7df5:647c:1665]) by SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::71a3:7df5:647c:1665%6]) with mapi id 15.20.3784.013; Fri, 22 Jan 2021
 17:38:45 +0000
Subject: [PATCH 2/8] cpupower: Correct macro name for CPB caps flag
From:   Nathan Fontenot <nathan.fontenot@amd.com>
To:     rrichter@amd.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
        trenn@suse.com, linux-pm@vger.kernel.org
Date:   Fri, 22 Jan 2021 11:38:42 -0600
Message-ID: <161133712259.59625.5128921373130739940.stgit@ethanol01c7-host.amd.com>
In-Reply-To: <161133705833.59625.6935511700675018185.stgit@ethanol01c7-host.amd.com>
References: <161133705833.59625.6935511700675018185.stgit@ethanol01c7-host.amd.com>
User-Agent: StGit/0.17.1-dirty
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: CH2PR17CA0029.namprd17.prod.outlook.com
 (2603:10b6:610:53::39) To SN6PR12MB4720.namprd12.prod.outlook.com
 (2603:10b6:805:e6::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanol01c7-host.amd.com (165.204.78.2) by CH2PR17CA0029.namprd17.prod.outlook.com (2603:10b6:610:53::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Fri, 22 Jan 2021 17:38:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 65faa609-94b1-4003-d939-08d8befc9123
X-MS-TrafficTypeDiagnostic: SN6PR12MB2846:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB284674F32B20E061565361ADECA09@SN6PR12MB2846.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JjPKqJ5DvNNBIQuKpOr9FaaDH31m5pAwwxp9iSoyyzUbqJI7NTpCUnPSRN15KJvze6Rde5tEbaEP5Df+97G1nnFyVH0gDaO6aYT7C18PiK7gQ76kFCza10bCgcSjS7253v8YhBN42NSRTUzs6YxGrp19iW4O5ZjkHzrwjk41w8dpqUsIbc82RHpR+UjaixH+NR1vnWfzY2m5uEBrXWq7u5+PYBAoSfi6g0mp6uJQ+PZpU1ba9y4FBaw6WeZHWA0+A1e5bCQB61h50yEoYh0NFHPEsR/ASAGlf6oha0DMpsOW0tE0QjXpehNkkfhJKms0qijiqofbiRW3awKDT0cYE+7YG8lwFFlraGKOKh6rh5mc4bW//OX4iA8Orr0EN/zpzTwxySo/tXphgldkYw1V9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4720.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(103116003)(8936002)(52116002)(86362001)(44832011)(7696005)(66946007)(66556008)(66476007)(956004)(5660300002)(316002)(83380400001)(55016002)(478600001)(186003)(16526019)(26005)(2906002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dzlUSXZEZ001VTJVTEI4Ylp0NEJ6aFNad3BYY3ZWcFNLM3BUVDcyaCtpNFNa?=
 =?utf-8?B?bFA2YWgybWRxcUFQN2pHRDZBbzU5OHhCTFZ5VUNiWm5ndWErVlVIcUMwTUsw?=
 =?utf-8?B?b3RzRStoK0JQZE1vcmhuVXZXT3c4KzIvQVZxRHBteFJxRUN3QWFYRHJNZVV5?=
 =?utf-8?B?cCt1NnczTkFUWDVJeVVjdGZRcXRNbFgxSXZCMkJpSU02WnE1Q1EyV0wxTU9F?=
 =?utf-8?B?RGNxV2N3S3FFZ1VKeHR6L1RkclNaZ056VFNvVXRLMlNQTml2T0ljdERPWnBv?=
 =?utf-8?B?VDhqamlOTHk3M1ZrWHRPRXdJODllSTlUTmhWbG4xVzNiR2FXQXlncC9HYkRt?=
 =?utf-8?B?L05YdU1NbkowYzBQalJUOXR6VFlqWk1iZFFoaEFBczlpUEgwT1VMNU5rUWU4?=
 =?utf-8?B?K2lONDhnQ3l0d1E3d3hYT2t0SjFIUTBsTlpqTEdaVFp3VFg1RW85Mmpic3hB?=
 =?utf-8?B?LzRsdWZJS2c2Y0VZWktaMTMyYVUxRXdtY3RURFl6WHJHd3YvVEQ5a3JqMHd3?=
 =?utf-8?B?NWdJYlFhVmx6dWpHbWNTTHEyaFgxNHpSYkhJQlp0V0FDbUc2NGFrZnRYL1lO?=
 =?utf-8?B?TlkyR0dzeW1rRmVPZ3pMWTV4dW1JbjFaM2J0cHhYME1tNjIzWTlLWGorYVAv?=
 =?utf-8?B?S1Y3Y3ZCcCt5eXNCeVlGc0REaFVEVVBGaHY3YjNNVEY4NVNIK2R2bUUxWjNR?=
 =?utf-8?B?YW02N25sUk94TTZ4aE1GaFpTek9lODJmeW1RdC9WZWg0aGJTMlVYblVsbmdy?=
 =?utf-8?B?bk5VQUY1eUhnLzcrRVE2VW1VNStKNFpWdjVmRm9RWVBVYnkycWJpVXVROXh6?=
 =?utf-8?B?cjhNVUxXMFpsc2d3Sm9scE1BWGVBbThoSElRZ0JmcHdieWxTUFE5S05SaUJM?=
 =?utf-8?B?NEpkTHNBb2V4enBwS2NKSi9qSENhZCs0WE1DNWxqbFBRdzVmRmduMHhMQVdQ?=
 =?utf-8?B?SkdHL05zZGFTZFJLeENJRmpOc1BBV1ZOMUdRenRaa0pDSzJOVFBCcTUycTFj?=
 =?utf-8?B?a1ZkWmV0SkN5K2N3WTI5NlZSK21Za3dZcCtjSTdCOVM2Y3drSGlvcFVrK3Nm?=
 =?utf-8?B?RUNkVXBEUE9FUE5PSGdhMWRhQUUxcmdxUTc3WTlpV3gwL3dENlcya1c5dDNM?=
 =?utf-8?B?dnJxb0xyOEt0em9tdnQyais2SklVSlF1YWdaU1BGWURmb0I4YnBXczIvaWRs?=
 =?utf-8?B?RGxySUpod2xjdi9hL3FkUTNidFhBN2dndlNobU9rZEtIQUFPa2VqTVBSV0Mw?=
 =?utf-8?B?NDBQU0Yyc1oyM05QRWxxNDNBWkxHSTYrWEdla2lnYjZkWjc5NHRDVjJIZnpG?=
 =?utf-8?B?c3JmdW1iNUJ5RS9VOEY1N2RYckc0RWIzYzRwcWpTUjVkRUhuRWorSXVUMDc0?=
 =?utf-8?B?ZHpPZnJ1WHBnTXVUS3dYVi9ZRnFsYTRXbEhvVGVQSXBxL0ZZMVkrSHMzcHI1?=
 =?utf-8?Q?6DZoxt71?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65faa609-94b1-4003-d939-08d8befc9123
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4720.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 17:38:45.0216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLYGZ1/k7+SarJPd7+rXZ51xtvbSMDaumjNSn01/D5ddbaxjWefNPDH0wIoq5Cmej13Ja7PkcqooD63J6l0+lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2846
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Robert Richter <rrichter@amd.com>

The name is Core Performance Boost (CPB) for the cpuid flag. Correct
cpuid caps flag to use this name (instead of CBP).

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
---
 tools/power/cpupower/utils/helpers/cpuid.c   |    2 +-
 tools/power/cpupower/utils/helpers/helpers.h |    2 +-
 tools/power/cpupower/utils/helpers/misc.c    |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/power/cpupower/utils/helpers/cpuid.c b/tools/power/cpupower/utils/helpers/cpuid.c
index 73bfafc60e9b..f9a66a430b72 100644
--- a/tools/power/cpupower/utils/helpers/cpuid.c
+++ b/tools/power/cpupower/utils/helpers/cpuid.c
@@ -130,7 +130,7 @@ int get_cpu_info(struct cpupower_cpu_info *cpu_info)
 	    cpu_info->vendor == X86_VENDOR_HYGON) {
 		if (ext_cpuid_level >= 0x80000007 &&
 		    (cpuid_edx(0x80000007) & (1 << 9)))
-			cpu_info->caps |= CPUPOWER_CAP_AMD_CBP;
+			cpu_info->caps |= CPUPOWER_CAP_AMD_CPB;
 
 		if (ext_cpuid_level >= 0x80000008 &&
 		    cpuid_ebx(0x80000008) & (1 << 4))
diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
index 0642e60a6ce1..a84f85a9dbd2 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -64,7 +64,7 @@ enum cpupower_cpu_vendor {X86_VENDOR_UNKNOWN = 0, X86_VENDOR_INTEL,
 
 #define CPUPOWER_CAP_INV_TSC		0x00000001
 #define CPUPOWER_CAP_APERF		0x00000002
-#define CPUPOWER_CAP_AMD_CBP		0x00000004
+#define CPUPOWER_CAP_AMD_CPB		0x00000004
 #define CPUPOWER_CAP_PERF_BIAS		0x00000008
 #define CPUPOWER_CAP_HAS_TURBO_RATIO	0x00000010
 #define CPUPOWER_CAP_IS_SNB		0x00000020
diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
index 650b9a9a6584..f9bcce9c72d5 100644
--- a/tools/power/cpupower/utils/helpers/misc.c
+++ b/tools/power/cpupower/utils/helpers/misc.c
@@ -26,7 +26,7 @@ int cpufreq_has_boost_support(unsigned int cpu, int *support, int *active,
 	if (ret)
 		return ret;
 
-	if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_CBP) {
+	if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_CPB) {
 		*support = 1;
 
 		/* AMD Family 0x17 does not utilize PCI D18F4 like prior

