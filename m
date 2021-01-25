Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45DD2302907
	for <lists+linux-pm@lfdr.de>; Mon, 25 Jan 2021 18:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbhAYRft (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Jan 2021 12:35:49 -0500
Received: from mail-mw2nam12on2075.outbound.protection.outlook.com ([40.107.244.75]:59840
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731117AbhAYRfe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 25 Jan 2021 12:35:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5QQyDmVVIWy9thW/TFW3KFL5EzknSc6kswlPW4VoSeje53gkzoKI/FEvDgzWn4EHOnc/c/Nd00tpgCT6Nah3WuTBwgHSYwQLWYGpa4bYY+k3WOUn6JZqHZcvvZIGwA8n1GiSZuhaUrWkrFCtsL6PWvXzk6MIMbZl7SAOreR1yK2KoDDNw5og9BSCNhS/VEQttk0sVdE4Q5C/O31tGpeNVF7IteCioEGu4FKoxiHJopl5SrM+BloVjMrAHC2CnwOt1YooESi6UJ7h2VBo4P8sJx4ZAfKReBsIU95shRBHJsItiytRsC/dy94O79fsP+4hJDYCTZtc4YjLIUpIjmR0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOAz/qDbYdLMyjuPrK9IBlO9CCw6yGcar5x5CrlswsI=;
 b=a739HRWW3dRGOeMxZY464p10D8RGHSIxIR2/IMixSYcE2lX9X5jmXUzV+2gBMJ7TOc88SHVYfDaeIvINlwm4YvH6hlRm+6oRsqd7hww3X6+Xr1eOhms1Qwyjm3YMpV/I/teyPB9LtviJIKtXvw3xfrEq5iTAYY9psEpLP/CBtvcIsrtNmzP5cKPcjjS5IlA8Nhf4PzSASjccwGtl4zS68kxwRyEg+Kank6JB6tLcS9D755/81ukqzNzIWjQBqo+WyZCTI1qrtcT6MOxmxALoOoGdGTItzspctFRVr3aVTvsio+ED5MCmeiuQlbNCzpdsxOqz9FGxP9ltmC3lVcaIcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOAz/qDbYdLMyjuPrK9IBlO9CCw6yGcar5x5CrlswsI=;
 b=yF9glXqgy0XicJk4a9SWFzjg1ElTBR8d2GoYgGxKnwsSe77CNWpH7DmGHLOXuDn9piuVYBYTJojqwI9WzFAY7iaIovruBnB5E6A1tBOPzdrFj053N/mcyDYcXvKKoZDYo0sdXw4OJ1gxlLIY7h1El7e3QeFuSKuwDMyI9pH6zM0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4720.namprd12.prod.outlook.com (2603:10b6:805:e6::31)
 by SN6PR12MB2765.namprd12.prod.outlook.com (2603:10b6:805:77::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.17; Mon, 25 Jan
 2021 17:34:33 +0000
Received: from SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::71a3:7df5:647c:1665]) by SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::71a3:7df5:647c:1665%6]) with mapi id 15.20.3784.019; Mon, 25 Jan 2021
 17:34:33 +0000
Subject: [PATCH v2 1/8] cpupower: Update msr_pstate union struct naming
From:   Nathan Fontenot <nathan.fontenot@amd.com>
To:     rrichter@amd.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
        trenn@suse.com, linux-pm@vger.kernel.org
Cc:     boris.ostrovsky@oracle.com, joao.m.martins@oracle.com,
        konrad.wilk@oracle.com
Date:   Mon, 25 Jan 2021 11:34:36 -0600
Message-ID: <161159607626.68367.14656572319107224636.stgit@ethanol01c7-host.amd.com>
In-Reply-To: <161159600371.68367.14890273216040482793.stgit@ethanol01c7-host.amd.com>
References: <161159600371.68367.14890273216040482793.stgit@ethanol01c7-host.amd.com>
User-Agent: StGit/0.17.1-dirty
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN4PR0601CA0023.namprd06.prod.outlook.com
 (2603:10b6:803:2f::33) To SN6PR12MB4720.namprd12.prod.outlook.com
 (2603:10b6:805:e6::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanol01c7-host.amd.com (165.204.78.2) by SN4PR0601CA0023.namprd06.prod.outlook.com (2603:10b6:803:2f::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend Transport; Mon, 25 Jan 2021 17:34:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 03d4efe0-8362-4d95-eeeb-08d8c1577a43
X-MS-TrafficTypeDiagnostic: SN6PR12MB2765:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2765CE35A603F3C83288C4A0ECBD9@SN6PR12MB2765.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uauxnX7W4TUOBO5eFVGpSY7PymnbrgcT7Vs4x1up50JVPt8jAqPVURd/iTWR8Nf3mOiDxEMAPz9a41mN0ZTOLvqcSIXxu0iRh3KeiSqNsGRih6Olzc77KBn5REd0WNnRlUD22L6RTjydiYOuMW/pkq3N4ZPkpJgc+i1PV/eLqPSqzRswBsfHnfTK3Ml91LnwSCG7+TgrBeA95qzQJaIcyHHwIV7ELgrC9d6bVUdZPxnJtUItjyq0whvCMfM7oxOc6v5NGvHLSfUcUtVDpk9UHRHJzJy5DL3kF/sGatB0TYA9+7GdIm8dm6I569ZYsqoJC7074RyUtyIDlujtMc6GarBik6yH+rG69iuIu41s7oKKi0NLUKHiVBpSa0VVKAeyP6PeLOYoe+47I3LXvMbv0lZHexCtXJil2fHe1qntjfnHfWKS8Qh9qTRzLjUQ08iwqnKAeL6ugesHPuLQOKj+dw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4720.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(316002)(186003)(26005)(103116003)(2906002)(15650500001)(16526019)(8676002)(44832011)(52116002)(7696005)(956004)(8936002)(83380400001)(55016002)(966005)(86362001)(4326008)(478600001)(5660300002)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NzhPQnlsSktaQ1VldS84WkN2dDdjOXBVWUtiMnVmRXJIY0VWb0I5aEdpUkhL?=
 =?utf-8?B?TC9wbWxHZUNpWEtTNlJrYmF4VmswRTBwbkk2OUJFV2J2dTY2NzdOZ2lJR1o0?=
 =?utf-8?B?TERHS1JuWkQ2ZUM0WVlkTDBZK2kvekRIQmRkUmtYVEIwV1JrOE9DVjAzV2ZB?=
 =?utf-8?B?cmQrOW1LVER3emMrTHdlRWhpaWlPNVVsRjduMkdTR1VLUFI1OVpqSkhvckVv?=
 =?utf-8?B?QzloeFErbVhnQ3l5RDYvNzZSUEpncll6Unc1R1B5L09EL1JlM3g2YkpUcDNT?=
 =?utf-8?B?UUxuK0VkbWQ1Ti9GUGlBUUNQVTQxQ2FaQTdyTDlEYUVFM3k3NXVrRmJLc0lx?=
 =?utf-8?B?aStvSktYbXN2alJremQ3N0F1MlN2dFRMK3dwNmRNMk4yaUNkMGFRbEFJeVdD?=
 =?utf-8?B?dWlVSTh2QXRSemxka010QTVHdGdIL2c5U0QxTVNyeDJnOWtVYmEvcFN3a2FS?=
 =?utf-8?B?dFR3alo3V2MxY3F0MnRlekNOQkV5TkxXZTdHdHVHV1NmRDdVcU1lT1ZIUStn?=
 =?utf-8?B?a0RSWDRROUF5cDZwaHZtbGw1dXNBRVYzdHZ3KzJQQVM5QW4rK283Rk9ucDMw?=
 =?utf-8?B?VVdwTGk1dTlQQ3lZcmxYQS8zUS9hNE5TeHVUdEx4Sjk0cnlHZDRLZDlWWUJC?=
 =?utf-8?B?NHlYODNyZElTZmVheWltK2xZajFHMVZ0NWZBZUlybXgrbGwyRzc2V2ZtZlcy?=
 =?utf-8?B?cVlrNGE2MnB0ajZWSzNRZEtWelhOK3ZueTcyem1hUG1VSUk2SHZpcnVvSkJj?=
 =?utf-8?B?ZWNEUGRrRi9hNFp4TWNmWXBCQk91ZmUzWTQzY3pqclVOOFhMZVE3S1I3bTVN?=
 =?utf-8?B?eEJQcXRLbXk3dVIwSXdjRzlrb0RxQTRjVVBpd2dBS0QreGFtS1ZsRlptM1Bq?=
 =?utf-8?B?eTE0MGdLajJZYjZQR2dxTDdSRlZPQkJXVmwxeE45VUpHaWtkYTZwVkUzb3Vt?=
 =?utf-8?B?VDRNdEdJa0dVVjUxVS9nbXJIUVMrNlV1S3VnZGU4cHhUV3B6d3AvVmI1NkRq?=
 =?utf-8?B?WjRJeXRad2VLaCt1OXdQVkpLUGQ4NSt0NS9sSEhQSHdnM0hIVVIwamF1WElu?=
 =?utf-8?B?T1R3RUlLV2w0aENmR2REb25EUmJJSURQV28vREQvdnhSeUhtdUZXNU15Mm5l?=
 =?utf-8?B?b3VvTEg2OWZPYnp0YWswTnJET3o5NmxwcG1EL2dFbU9JUU5BdWRRUWJSd0I0?=
 =?utf-8?B?SkhENW9jUEZUWnBlQTlTUmkyZHQzR3lXakZtV25Nb2UxUHUxcldabVFoY3BM?=
 =?utf-8?B?VW05R1Q5bVpoMVdxTVpYdWxsKzRDWGlrYnJ3bWZYSXdWVUVzeEZ6K3c4M2kr?=
 =?utf-8?B?MUM1bTRzQ2Y0K1B5WjZHYlR0T0ZKUTRMOVgyYTJJNHhaNFdDWTVCWTJ3Q3dj?=
 =?utf-8?B?blFINFJKMlpxcHRVK3QrK1VOSDVFT2RvOTZBdzQ4ZnNyeDNRUlRnOXpVaCtV?=
 =?utf-8?Q?HF/1gViL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d4efe0-8362-4d95-eeeb-08d8c1577a43
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4720.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 17:34:33.2042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nG7MyG7Gs+5si3AH+ZHi8yut+Wue5YFMtI0n+E0oG58Tq3NQsbm5kxqUE4gE1Pb2yf86YumUcEMY8xk1dZIGpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2765
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The msr_pstate union struct named fam17h_bits is misleading since
this is the struct to use for all families >= 0x17, not just
for family 0x17. Rename the bits structs to be 'pstate' (for pre
family 17h CPUs) and 'pstatedef' (for CPUs since fam 17h) to align
closer with PPR/BDKG (1) naming.

There are no functional changes as part of this update.

1: AMD Processor Programming Reference (PPR) and BIOS and
Kernel Developer's Guide (BKDG) available at:
http://developer.amd.com/resources/developer-guides-manuals

Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
---

Updates for v2: Add links to PPR/BKDG in commit message
---
 tools/power/cpupower/utils/helpers/amd.c |   26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
index 7c4f83a8c973..34368436bbd6 100644
--- a/tools/power/cpupower/utils/helpers/amd.c
+++ b/tools/power/cpupower/utils/helpers/amd.c
@@ -13,7 +13,8 @@
 #define MSR_AMD_PSTATE		0xc0010064
 #define MSR_AMD_PSTATE_LIMIT	0xc0010061
 
-union msr_pstate {
+union core_pstate {
+	/* pre fam 17h: */
 	struct {
 		unsigned fid:6;
 		unsigned did:3;
@@ -26,7 +27,8 @@ union msr_pstate {
 		unsigned idddiv:2;
 		unsigned res3:21;
 		unsigned en:1;
-	} bits;
+	} pstate;
+	/* since fam 17h: */
 	struct {
 		unsigned fid:8;
 		unsigned did:6;
@@ -35,36 +37,36 @@ union msr_pstate {
 		unsigned idddiv:2;
 		unsigned res1:31;
 		unsigned en:1;
-	} fam17h_bits;
+	} pstatedef;
 	unsigned long long val;
 };
 
-static int get_did(int family, union msr_pstate pstate)
+static int get_did(int family, union core_pstate pstate)
 {
 	int t;
 
 	if (family == 0x12)
 		t = pstate.val & 0xf;
 	else if (family == 0x17 || family == 0x18)
-		t = pstate.fam17h_bits.did;
+		t = pstate.pstatedef.did;
 	else
-		t = pstate.bits.did;
+		t = pstate.pstate.did;
 
 	return t;
 }
 
-static int get_cof(int family, union msr_pstate pstate)
+static int get_cof(int family, union core_pstate pstate)
 {
 	int t;
 	int fid, did, cof;
 
 	did = get_did(family, pstate);
 	if (family == 0x17 || family == 0x18) {
-		fid = pstate.fam17h_bits.fid;
+		fid = pstate.pstatedef.fid;
 		cof = 200 * fid / did;
 	} else {
 		t = 0x10;
-		fid = pstate.bits.fid;
+		fid = pstate.pstate.fid;
 		if (family == 0x11)
 			t = 0x8;
 		cof = (100 * (fid + t)) >> did;
@@ -89,7 +91,7 @@ int decode_pstates(unsigned int cpu, unsigned int cpu_family,
 		   int boost_states, unsigned long *pstates, int *no)
 {
 	int i, psmax, pscur;
-	union msr_pstate pstate;
+	union core_pstate pstate;
 	unsigned long long val;
 
 	/* Only read out frequencies from HW when CPU might be boostable
@@ -119,9 +121,9 @@ int decode_pstates(unsigned int cpu, unsigned int cpu_family,
 		}
 		if (read_msr(cpu, MSR_AMD_PSTATE + i, &pstate.val))
 			return -1;
-		if ((cpu_family == 0x17) && (!pstate.fam17h_bits.en))
+		if ((cpu_family == 0x17) && (!pstate.pstatedef.en))
 			continue;
-		else if (!pstate.bits.en)
+		else if (!pstate.pstate.en)
 			continue;
 
 		pstates[i] = get_cof(cpu_family, pstate);

