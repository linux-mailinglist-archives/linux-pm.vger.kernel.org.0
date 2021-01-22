Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC8C300A3C
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 18:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbhAVRuF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 12:50:05 -0500
Received: from mail-eopbgr750074.outbound.protection.outlook.com ([40.107.75.74]:1797
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730098AbhAVRlD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 22 Jan 2021 12:41:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COplq1XfCN/LWkvniij/Gmi4SihYVPndF99aNSHxvitJ2JeIjcE9d+EwJ+RY0+JmItgZU3lBXcbAjUotGsVA98D7G1hJtzVwdBwO72i0sajj1rEGOC9bS0EQTHoCiXU9JM2jUGVaYcMW/iwrR9SKDOacJ6FX0pT3Zb/3vfnQ3jghK3Sa7He/JxpzyriBurE+AucifaPWeDtCpUe+FrfcB2NLm1dgtqvZRleW4w9veimhZNnF9JhNK1WZBMtNdvYKnaWhnZVvIevf4OS95Ubvo80XAa/wPl7cod2kryrZ3UYlY7uB75xwvmJnC9W3YQFkPlsLUEFpP2ROHXqUZFP2NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCkuxf/L6Zz22ylL2SG+gWNRJlmCcKBQlEIZjyS9Hdg=;
 b=Yfq3PFqhcYn7s9LiQ5CySx2J+/ba+43b4/Yk1nAKNKj6nyvsOt2WJGmI4diw4WlsfAJXuFgRqb/STUzWBqHJe+31s4zeehI1/AM2W06KKzP5a06tBzQRvqj1Bmh5NzJzqBvekANywbfPuxuOmHeShteAW8lwY6R9wN8ObopTTx9CR2QHJuOxaKzBcH/qEIBR6wZj16YMPwugL+6s9FDxUlJKgEip78JFCwVDvcdEZqZNyeZACz1d8WAQlvMh4xiqmIFyUItuHnUYBJxLlLuIcxh084e0nqiXQgYw39E74++qP49H8CesVJ0gt5I8VYFh+eQTXRvNlN3QIPA1vggreg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCkuxf/L6Zz22ylL2SG+gWNRJlmCcKBQlEIZjyS9Hdg=;
 b=IIrfrFDlGCpA958yD5U30jhIqiqAz9HoZQ6wfmu1gecyPDiIW8iC06Ng6cHvoTpbLjl8/kWeIY9QCEjM2pCUoG8gceKxRbAZ32kf4ZyTc+3X4nZDegdodd6yP1165+e9uqcJ8ebSi+0r9FVD/nNlutBkLH98zKBK+C+GNDw7rhc=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4720.namprd12.prod.outlook.com (2603:10b6:805:e6::31)
 by SN6PR12MB2846.namprd12.prod.outlook.com (2603:10b6:805:70::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Fri, 22 Jan
 2021 17:39:01 +0000
Received: from SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::71a3:7df5:647c:1665]) by SN6PR12MB4720.namprd12.prod.outlook.com
 ([fe80::71a3:7df5:647c:1665%6]) with mapi id 15.20.3784.013; Fri, 22 Jan 2021
 17:39:01 +0000
Subject: [PATCH 4/8] cpupower: Remove unused pscur variable.
From:   Nathan Fontenot <nathan.fontenot@amd.com>
To:     rrichter@amd.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
        trenn@suse.com, linux-pm@vger.kernel.org
Date:   Fri, 22 Jan 2021 11:38:59 -0600
Message-ID: <161133713953.59625.16161917133620548390.stgit@ethanol01c7-host.amd.com>
In-Reply-To: <161133705833.59625.6935511700675018185.stgit@ethanol01c7-host.amd.com>
References: <161133705833.59625.6935511700675018185.stgit@ethanol01c7-host.amd.com>
User-Agent: StGit/0.17.1-dirty
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: CH2PR17CA0006.namprd17.prod.outlook.com
 (2603:10b6:610:53::16) To SN6PR12MB4720.namprd12.prod.outlook.com
 (2603:10b6:805:e6::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanol01c7-host.amd.com (165.204.78.2) by CH2PR17CA0006.namprd17.prod.outlook.com (2603:10b6:610:53::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend Transport; Fri, 22 Jan 2021 17:39:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 16c85543-edb7-4e63-0096-08d8befc9b1f
X-MS-TrafficTypeDiagnostic: SN6PR12MB2846:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2846549B73A7E1CA408BD366ECA09@SN6PR12MB2846.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 052uk/fbj34yUZjn2g8ztyW/QlzlhHkhoIr+T6f00KZKkcRH8JlSa2tsaUWznD2MZKC1HjJ45wM6HVQmrmGObaSA6zKsGMXgL214lhq20M9w09FvLcD//NJeQNbwqWbb1uzjTp5SMdwVcV3rmg5/KimCGVph1ceMp5OMpJ/6PY1Qqf45VHGGecKIZnZYqBZx2dKOTozWBXS+elUTRTVpRYRt/DBqiY9C3zxX1WwXV3EJL3nvPGfsanv36UZ/Zp3fEwI2VVTbF1IjuS6LAXQr7/exCZw/Lhq1DDiXplnpDnDPpHAtuBL1BHRpcKCozYk2AAALtvM7TJl5IeYiDiKK3YBI0h8dRt1FpGhHqySw0HLXYllIefC9KzvbM9kfFFdmE8W0EO5YFm5nMRev6uLDmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4720.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(103116003)(8936002)(52116002)(86362001)(44832011)(7696005)(66946007)(66556008)(66476007)(956004)(5660300002)(316002)(83380400001)(55016002)(478600001)(186003)(16526019)(26005)(2906002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UU9LS3pVWXpIYW4rRzZRcG9tSjRSVEZDYSs4K1dYaFpOcmVWYU9nRkUyaGNI?=
 =?utf-8?B?dFF2OXBMbFVMcUF4YzVIZDFjcGp6ZS9FaC9qbFc3T2xhMXZsc1ZaNmJsR0Vs?=
 =?utf-8?B?djJzYU93VG1vSUJCYTdtVDRKcU9WQUMwVkFobW9uMHIxUWJQRFlXa3A2VHVY?=
 =?utf-8?B?bzdwRUVoZmZGT3F2Zm9HYzQ3R1crNVBiZGMvZzRZVU5nYVFIb2grWDRmVWd3?=
 =?utf-8?B?MFRNMHVaaFAzWlFwWHRiNFJjUmhIVlNMNTR5ZGE0bGZ0M2JlK2ZKck1FOFdi?=
 =?utf-8?B?aXFqL3h6ZXdJanBhOG9QMklsck1pQVZRSGRvWERUZ2MzYWl5akkwaU1JQmd6?=
 =?utf-8?B?em9OcmkwYWZtU21FaXg3TlRBbHdPcE42QXA5V1NHSTZsSVY1UlJuODRnQm1S?=
 =?utf-8?B?aWtXU1NiWU5CTTlDdGhrQ0NFaXJVaFByWEFjTkdrUElTeGZ0K1dYNmlFVGJU?=
 =?utf-8?B?ZmphdnlRVkdpSmFxRWJVS1JWNWJVVlZuUG4wK1Z6WFZVU2tQdmhoOXMvMFho?=
 =?utf-8?B?TE9rdzR5UTBnRWxTNXpEdjZ0M2tydHl1Qjl4TGk0LzA2TGMwTVVOQ2l4eU5q?=
 =?utf-8?B?OTVkNHJFdnQ1cm41MWtoUXNEcEFzeGo0VXZPV3d4dEtURzhjcUh1VjVhL3Rz?=
 =?utf-8?B?V2c3YjZzRXQ4QS9kcnVnZHgxdmRXdmVZL3BwcHZHei9qZFhaNHVpZk1FOTEz?=
 =?utf-8?B?NUswem5WU29HKytHa1psRUh0OE80aDJub213N1NXbUg1SStoUDU5eUVRRGxE?=
 =?utf-8?B?Sng1cVlwZldXTVBxaUpQWXlpdDBYN0VqK3lFRHZ1VGJ3R0haaHF1b1FBM2Jm?=
 =?utf-8?B?Wm5PSjU5VkgvZkU0cUdGRHhZOTNKT29SR3JzeFIvaXNyM2xxa3hFMlJuUXFj?=
 =?utf-8?B?WFVlcXY4VG1yRHlxSUNMRzhxMjJvaUJwcHBmZ2toQVJIRkhsWlBtV1BuQ0Ju?=
 =?utf-8?B?WWwxc3RGbTduTlkzanNqZVlQOXZjOG1rUkpNWEpQUnJaSU1nTHRzK2xTRjFp?=
 =?utf-8?B?NzdzN2dyMzJBaGNWYklOSXVBVlF6WWgyTjJwTzdJWXlmeFEzOGdRdjZjcG8w?=
 =?utf-8?B?OWthYXU2b1V3TW9xeVJnNUkwMVpSME5yU3VmR0h3U3BDSGt6Tk5sYVo1WGEy?=
 =?utf-8?B?OEJvMkNod0NnTmFkZTUyVTUwK0lKUGhrZ3JXVkJSanczcVZaMWszaEpSOHZR?=
 =?utf-8?B?VkVtRWNKZFdKMlhyS1l4alZkOVVFTlpZMWUxZ2Zvd2lvcVBSdVFKTXlkOVB5?=
 =?utf-8?B?cmw5OFJYc1I0aDhVWTVDUHNrVnlFRmZlR3Y3TFl5L1JoVVVQMVdOL3RiV1NQ?=
 =?utf-8?B?eXRxTElCRW5GaThZTkhFQjV0T2c1ZEc2ZkdhdGlsZWFSSEpVKysxMlpoMzEw?=
 =?utf-8?B?TWtoWjZySDFBSWJ6N21OQ1ByRHpHNlZFcnE4S2F2Z01QS3dsRUhzN1U3c3pn?=
 =?utf-8?Q?YU8E0i+z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c85543-edb7-4e63-0096-08d8befc9b1f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4720.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 17:39:01.7760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z4PTKeu5al1Rx5/Y+U3vTc4nrdk/nV9MSYTd+IJwpjk+uisaahkw6oFymGkrMfFZW0eGs/DIpu10C2Fv+VbPjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2846
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pscur variable is set but not uused, just remove it.

This may have previsously been set to validate the MSR_AMD_PSTATE_STATUS
MSR. With the addition of the CPUPOWER_CAP_AMD_HW_PSTATE cap flag this
is no longer needed since the cpuid bit to enable this cap flag also
validates that the MSR_AMD_PSTATE_STATUS MSR is present.

Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
---
 tools/power/cpupower/utils/helpers/amd.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
index 496844a20fe2..bd4db2e9a8a0 100644
--- a/tools/power/cpupower/utils/helpers/amd.c
+++ b/tools/power/cpupower/utils/helpers/amd.c
@@ -90,7 +90,7 @@ static int get_cof(int family, union core_pstate pstate)
 int decode_pstates(unsigned int cpu, unsigned int cpu_family,
 		   int boost_states, unsigned long *pstates, int *no)
 {
-	int i, psmax, pscur;
+	int i, psmax;
 	union core_pstate pstate;
 	unsigned long long val;
 
@@ -101,13 +101,6 @@ int decode_pstates(unsigned int cpu, unsigned int cpu_family,
 		return -1;
 
 	psmax = (val >> 4) & 0x7;
-
-	if (read_msr(cpu, MSR_AMD_PSTATE_STATUS, &val))
-		return -1;
-
-	pscur = val & 0x7;
-
-	pscur += boost_states;
 	psmax += boost_states;
 	for (i = 0; i <= psmax; i++) {
 		if (i >= MAX_HW_PSTATES) {

