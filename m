Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9C1247A98
	for <lists+linux-pm@lfdr.de>; Tue, 18 Aug 2020 00:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbgHQWme (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Aug 2020 18:42:34 -0400
Received: from mail-eopbgr690042.outbound.protection.outlook.com ([40.107.69.42]:16103
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729893AbgHQWmc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 17 Aug 2020 18:42:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MslIEWtIdQS9PSQ0IO636yR5BCPItgoD/yhCuuvDGkfd6PfCXlG51zJsivty8TgyJiulzJPHw1Hgb4JUeW8kuxH5TZYQyzA3KpYFgV1bKk0owmsYrhjkLFgErVGCKsaKE96GHfAA9P6LWfyhpOS87cUoZ/2SbYSmePewBYWzopdiijeWow7zRFZeVQf+4skByGGIk8LB3ufe5HXHbN7kpb9KMlDTZXKOHRwRYG2h8X7Lc7p9UdusIW1VpounYwpT8X3GL+Byn1MYPYhb4N0PCpzg/c33HfFRxu9t6ul7u6Fit2haT6oC4GNfgYnQB20PUUpdOf7CU0mAqd0NhpYKhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6G6Cd5WWa/VTIfa/5kzo1CZkC8amv7UT0p2HUiZCgY=;
 b=JXG5rr27VavbO93xKgTsP+lzKkMhFusOq+X90hITnAM3UGsQzZWzOuQ6jAsOIkcJ6K9aGeYhtpp5Sd7ComzHMfov3t3lGK4JFvLawbP7f6PKgSVRq3wM6jztm3ouhpAU8JCQWIg4K/O17Ckja4gJUNQXhOMTMo7vGvu48Fvu3t2MX2FRXgNTGOR8qVa1UDZHfjaxaAjKJBs8/K5hNYpjltiLQYhCno6B2PlSntK8Ur4jGSUcSCdfJwrAshN81793hJ7L+I1e2lPAytbksiE9c83Z+51ceJlwpMjdi23gaBLhExPZFIRPdQijTlC6mffOUsdswJU6rnOmQ9GVsKZmhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6G6Cd5WWa/VTIfa/5kzo1CZkC8amv7UT0p2HUiZCgY=;
 b=yc6r/Vcf1TKAgNfjJtNdjSg1Rm6mN3W6VEbkBSprTTPyKocAOauZ0w3Jc9yCbe2V5Ky51Ss+ZccWyG24pGLT1M/J9eYKArKpXQwQ5sM1hm3Q+ohdi6FdE8DNcdmi9v+moBHY+I2Ylgiar5mfcZuQuTzkGjXoW5gGnFmwlTN2z+A=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB2946.namprd12.prod.outlook.com (2603:10b6:408:9d::13)
 by BN6PR1201MB0017.namprd12.prod.outlook.com (2603:10b6:405:53::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Mon, 17 Aug
 2020 22:42:30 +0000
Received: from BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::ac22:9457:4d25:5ff0]) by BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::ac22:9457:4d25:5ff0%5]) with mapi id 15.20.3283.024; Mon, 17 Aug 2020
 22:42:30 +0000
From:   Kim Phillips <kim.phillips@amd.com>
To:     Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>
Cc:     Kim Phillips <kim.phillips@amd.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tools/power turbostat: Support AMD Family 19h
Date:   Mon, 17 Aug 2020 17:42:15 -0500
Message-Id: <20200817224215.11207-1-kim.phillips@amd.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN6PR17CA0021.namprd17.prod.outlook.com
 (2603:10b6:404:65::31) To BN8PR12MB2946.namprd12.prod.outlook.com
 (2603:10b6:408:9d::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.84.11) by BN6PR17CA0021.namprd17.prod.outlook.com (2603:10b6:404:65::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend Transport; Mon, 17 Aug 2020 22:42:29 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 23d07a3b-993b-41be-be82-08d842fed2d4
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0017:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB00179F9FCB85A00D155E3E4A875F0@BN6PR1201MB0017.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mYHk4RSv4v9MHS8k+isHkY/p77iqFkBoPUMLTdDLowLZh5o6tav0dnloka2VN8QTLFLWUZW+BV4BwooS0aqHuhE8c4+W5BmC0TH7FRr23E1WhPbcqZgByy+kHWp0tiJx5V9GoidWhk6gwl7z7kdLVs/z/1dR9rPczJv816nMu8Udj5GKpTyWBTqqpteip8HB5nNIKXkJAwXLQg0eFm+fSoSMBqGb14MZvmrlE68+yRqKk8MrQCG6wmlhNsQqDAAy5lTujotpU05tskeUnZLUDfCaPONWPatkwojGBYnqFEcbt1YT0FwpZQRB3N9BnRve/v5Dnk6ArGCN/9srmig41sAAL43+YAKbnZGy1xUsD0lEub69jdo3R9F5NUaKew1x
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(5660300002)(4326008)(83380400001)(6486002)(1076003)(16526019)(6506007)(186003)(66556008)(44832011)(66476007)(66946007)(2906002)(110136005)(8676002)(8936002)(6666004)(478600001)(316002)(69590400007)(26005)(2616005)(86362001)(36756003)(6512007)(52116002)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 973ouEUN1GkdeACGyS9RWQjlj1rZmLIUw/8zILAS51lReW0Bb6ktTBrQrPme7+iO9+p216klD0EYHeCBCPZM1W/PXGGysdCYOiKNdGExileELS2eiioLprs/yKYnXyrlSQzyIF6GqClvwHkbhH3Jdf4RP4jK42QEnvbFYVKMNuFhd4d4e84OoC2mrz7J4av9z50YlLJQz4Pm4iWO9GjofFI1SYY2TTY9MwqY7LdDwe4hzKsaRVGoMd0B0CrUTSemwIhwxwPXLLFAMLPwuiCBFOXlUBBImCBEKQSkY6V3eAxGHk3Ow+xpRtn3yPsdojEdR5A6vbSCBm4/2q5O3M7zGFV7Raq4s1HBUdNrFhXHQ6whWViXoJORNdVN27AQFEErDaUpuH+WdgrHV3Xct+MJE5j0TaOC9IUDT/GIicBsO+1oxAEsWaK+hzi+Ju2gB4Ntxn02HHjgNAPyUO1i+LNdtpExdUZPfOJ69HhnmFYH+g25ceUHL7FRHzGMBM4FSvExHzeuzERjxJy09+2qhtAmaLWscfZfGwf6/Z+tk3TpuNkg/DdA5ZTERRUfiR0X3oOH0vaxHnKfoRcX//BmWPoxt3vpiGp/kCYRihMTTWroKvIdcKyf9aPYk3IWVpfC+i7Sjiziuq254DyLSVb8v0Z6WA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d07a3b-993b-41be-be82-08d842fed2d4
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 22:42:30.2187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8eWRM1eTCvaASE5KNXMSAmLm0j6wUOjV3QicY1ubybHhUQNmor6G2C1tXHuuqv/v8F1uMSBw1uGMNfxTiwZz/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0017
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Family 19h processors have the same RAPL (Running average power limit)
hardware register interface as Family 17h processors.

Change the family checks to succeed for Family 17h and above to enable
core and package energy measurement on Family 19h machines.

Also update the TDP to the largest found at the bottom of the page at
amd.com->processors->servers->epyc->2nd-gen-epyc, i.e., the EPYC 7H12.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 tools/power/x86/turbostat/turbostat.c | 34 +++++++++------------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 33b370865d16..e38f8a0c688f 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3881,13 +3881,8 @@ double get_tdp_intel(unsigned int model)
 
 double get_tdp_amd(unsigned int family)
 {
-	switch (family) {
-	case 0x17:
-	case 0x18:
-	default:
-		/* This is the max stock TDP of HEDT/Server Fam17h chips */
-		return 250.0;
-	}
+	/* This is the max stock TDP of HEDT/Server Fam17h+ chips */
+	return 280.0;
 }
 
 /*
@@ -4069,27 +4064,20 @@ void rapl_probe_amd(unsigned int family, unsigned int model)
 
 	if (max_extended_level >= 0x80000007) {
 		__cpuid(0x80000007, eax, ebx, ecx, edx);
-		/* RAPL (Fam 17h) */
+		/* RAPL (Fam 17h+) */
 		has_rapl = edx & (1 << 14);
 	}
 
-	if (!has_rapl)
+	if (!has_rapl || family < 0x17)
 		return;
 
-	switch (family) {
-	case 0x17: /* Zen, Zen+ */
-	case 0x18: /* Hygon Dhyana */
-		do_rapl = RAPL_AMD_F17H | RAPL_PER_CORE_ENERGY;
-		if (rapl_joules) {
-			BIC_PRESENT(BIC_Pkg_J);
-			BIC_PRESENT(BIC_Cor_J);
-		} else {
-			BIC_PRESENT(BIC_PkgWatt);
-			BIC_PRESENT(BIC_CorWatt);
-		}
-		break;
-	default:
-		return;
+	do_rapl = RAPL_AMD_F17H | RAPL_PER_CORE_ENERGY;
+	if (rapl_joules) {
+		BIC_PRESENT(BIC_Pkg_J);
+		BIC_PRESENT(BIC_Cor_J);
+	} else {
+		BIC_PRESENT(BIC_PkgWatt);
+		BIC_PRESENT(BIC_CorWatt);
 	}
 
 	if (get_msr(base_cpu, MSR_RAPL_PWR_UNIT, &msr))
-- 
2.27.0

