Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B9E364ADE
	for <lists+linux-pm@lfdr.de>; Mon, 19 Apr 2021 21:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241933AbhDST7M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Apr 2021 15:59:12 -0400
Received: from mail-eopbgr690061.outbound.protection.outlook.com ([40.107.69.61]:63716
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235788AbhDST7L (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 19 Apr 2021 15:59:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zz8aRlXRKbAG6FHh58EI82k9I6QE3l4NwXOsYjodOT8jSeNmSqY4RUwg/yaSh4NEz0h6I3GPx6mxTUC2N8PtPTYxkDIqhNesUpH1IU1pQZBCXumub0ydaqp7kJcJuDYhMuzRwQX/YpZsg6AVptZ6p2GfhR89NR0XuF25PGoLhUJWE8OIhDk+m4bt+SQ6rJt9/XHRFPd75eayByY1YDvi0AsvY6WjLjVy6JMXZG9WtCCsxkuH2nyv135sDOC7+Eg4nZCS914cBdySW0Eu73W0hrBJg8NbUihHtdsTykQIeILl7657Eo0DEH9ckLMUo22H831tHcPF4YGUoLqlC+U8RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgh+u4qhqyKbARsjq620OgPq2weqJ9XpKOAStuxI3QY=;
 b=IKtI/befJrdTIfjhP5dye0wEaORwvg71S7JeTYg6jazfnfc0jjHHPTt/p/VnMohtGFByjP6JzoM7iUTKYxf+Wm+dtK29Fi6Pcsk//GwsUU/kQIIwORl7SYQfT2puDHxwWxWjrzFOfNSuSDuW1Bvq6o5k343VvcXaz5EH9hFsRpHRlFWm2yWhslA44xV1JPL/ekA0oDWu4rtegiVgvxDULNAkk7iD6V5mXRq6ORzSgGoxBbiT4zhmzMeVTM0jNH489EXoZru7BwEJ9bNk9/3Qmm5o5+1UiPbF2UY3P/QQ1ZGkB+g7Z5mooAWBuSfXuRyfGBTQ26BqYD9VZK8UXffmcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgh+u4qhqyKbARsjq620OgPq2weqJ9XpKOAStuxI3QY=;
 b=fnLwzCvbm0M8n8Z1Go7zVEIyZXROWpNO+KOQcI+lrKw6+SbUGQ+R6FuvLrNh91Ph9FmEogKokMPck1KuuLx+Ql/QvyLRHrGBgtj+eCqsYEnN4q2eXESvglcfew85C4ALg7z5dg90vFT1z7qSphIf8o7eviUD82VboPz7TLiIME8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4512.namprd12.prod.outlook.com (2603:10b6:806:71::9)
 by SN6PR12MB4669.namprd12.prod.outlook.com (2603:10b6:805:7::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Mon, 19 Apr
 2021 19:58:37 +0000
Received: from SA0PR12MB4512.namprd12.prod.outlook.com
 ([fe80::3e:b8e1:a378:413b]) by SA0PR12MB4512.namprd12.prod.outlook.com
 ([fe80::3e:b8e1:a378:413b%8]) with mapi id 15.20.4042.019; Mon, 19 Apr 2021
 19:58:37 +0000
From:   Terry Bowman <terry.bowman@amd.com>
To:     lenb@kernel.org, yu.c.chen@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, bp@suse.de, calvin.walton@kepstin.ca
Cc:     terry.bowman@amd.com, wei.huang2@amd.com
Subject: [PATCH v2] tools/power turbostat: Fix RAPL summary collection on AMD processors
Date:   Mon, 19 Apr 2021 14:58:12 -0500
Message-Id: <20210419195812.147710-1-terry.bowman@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN7PR04CA0045.namprd04.prod.outlook.com
 (2603:10b6:806:120::20) To SA0PR12MB4512.namprd12.prod.outlook.com
 (2603:10b6:806:71::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolxb27ehost.amd.com (165.204.78.2) by SN7PR04CA0045.namprd04.prod.outlook.com (2603:10b6:806:120::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Mon, 19 Apr 2021 19:58:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8074249e-321f-4e13-9a57-08d9036d8540
X-MS-TrafficTypeDiagnostic: SN6PR12MB4669:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB4669C3D7F7FC7F197546744783499@SN6PR12MB4669.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mJWMUj1buHzDICuccao9Y0bjP9Rn1DzqZWSeDIhD2Ihph6MzTBhdkaZPLGq7Cs/hfw1fRXpUjpM+4hEX7mJsSdmww5/VZziC5G83SiXBcvVdBCGEURgfjJnA1qoaQ0DyMo+dTyYEkfR8bNTf30fdsvQj0F42edgulAaXFzruf3tdJG1THvXCKoRPxGrk93/YYBAR83gtrvPxzIkmYyVnU1OBUPp1Bi274KUCXMtz4J0Y5WkkF/dos7UeZVPfKNZHE/vfK0kmC+qjXbLj3X3vA8pVjpbDOMIvXhqMg/OP3iaFfofk6OLmAthjYbBjaZDNFMpiHy/2Kw9OabArGByPqDBsZsGKLRUu6LPtshtP3cLdw4EnR8JjxdEYam+p403YnDtQAwHFbs4OAkgPnZCvRRYjFSX2W9TPh3cMJS3GCCPF6Q+RHI3kN7VOZ8nw51u/kfsS7J9by7KbqQ8yyR1lyuhWk6VP450L+giw+PiywpqybNUanJvWtSm7J5kLL2vFcdlYl6s3Y+q8XGusExPHka+uPFwHaTvM/bm2Zgm40tFWZhkKqoxyXjd4HwFCap3JD9741pBLWpheGusstT0zXI04xVYq7fMt+/YGjrPsgIw8w8sfgDYzkUnXJS81Oat+byJ5f4RTT2grdpxsyglW9pfo/IqTtpFAGdiEjSH5cUI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4512.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(83380400001)(66476007)(66556008)(66946007)(6486002)(44832011)(8676002)(6666004)(186003)(2906002)(38100700002)(2616005)(38350700002)(956004)(8936002)(16526019)(316002)(478600001)(36756003)(4326008)(7696005)(1076003)(52116002)(26005)(86362001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?VlAua45F0zXhMR+i3rNZjR2CvRZAuHHJEzEW++7LtQ4Omnjtbso4GC/gho46?=
 =?us-ascii?Q?nY5ElZ1032GoXoAh3znYCKOsTRD++B90Q8BOyFjU0lfk2EEYzb7jBuSzhj3c?=
 =?us-ascii?Q?UauWhC1EILlMULxhw3/qkDZFE9TyLDF6K92cESbQW6fmVqOFa7q1OdhtfEHC?=
 =?us-ascii?Q?IsmSngn4g/SVOD8vpBH61y7x21dMm5Zytn0NdPNw2zdVZyjZ9Fz8atdFhkTS?=
 =?us-ascii?Q?xOPz6z9q9+hMfD7oeM5sywnAzEzVozhEUzVWgg4dAmqwcu8Mx2Sej75LYNT0?=
 =?us-ascii?Q?SUrGDoXzSdNiqWYhaHYBaoXPBzxMTyqm5OPtff73RfYUWx5bBwEHdRuLKyOX?=
 =?us-ascii?Q?dQsSjQM+tVHnVVcxHocpB3FfpaWyrXZsTQ81IwNLl1rn5oslHZrbnsv4DlxH?=
 =?us-ascii?Q?nUEnYJmm2I4k2WRNEGttj5M5SeT0lcISoIMjq3pr7AL7OsNbbe4IcKdH75tZ?=
 =?us-ascii?Q?NS80LVYsXVh1LtwvSal843OL87QdNqDCOSXaCWHAMiMDXH+vbWfAtBvYU/qy?=
 =?us-ascii?Q?WHEDXvtYBXNUxOuozWMUqyr037SMcll6/Xhp0qVbe9TtHXUVmqir1Ny1SXku?=
 =?us-ascii?Q?SoDoCN/a1DPAJywSxO8SFt/hrpLrJtb5G2INutKK1b0rBInUPVaijxvvtwyG?=
 =?us-ascii?Q?G1AIzV74L0aPk3fy5t61DbL9JCaJZAcg913D/Lp3LgHcgrIdseOBqE52J0ZY?=
 =?us-ascii?Q?IjfeGR7r+N1d0Qnkm5HbnheX5SYBz4+lF/fI1X2X2HM3Kx2F8A2NpnQcCOwg?=
 =?us-ascii?Q?KOYTfVcP+5H+9G3Fr9FxJiybgn7KZ2JuI/k+sl90sGxKQfAI9jN4iQwfIZF8?=
 =?us-ascii?Q?gvQZoChC1BW4X3ASotFGASFm5mQrxhr9lWOJ9bYY+TMsQAD17PkAOd7Im7Y2?=
 =?us-ascii?Q?YNDDM5m9MslJZeCm4OKWdnVs8TaG2X9eaVwjbeDRNnSOFt/+gERqAbgTPH11?=
 =?us-ascii?Q?5jHiLv+ieg1WW13LbmAFKS+VlAfLx/iZZdx5cMkimF/+9P5V0AcHg9r2HvBd?=
 =?us-ascii?Q?gdzDjb1w/vdSBgadN2cuO+v9VSTxZjUdHn0E1MB/+c7LHMweMuStwTUCuG08?=
 =?us-ascii?Q?L7IVhIk4T1zn7nvGRRU0c2fO4wu4MV9b1LcBImg911A/traihIVydQE4X38v?=
 =?us-ascii?Q?3mhk9QMdjOXXOVxqT+6Q0cdQ92rgkwR+aIFKxzYBou7EF+3elL81D5/9L+VR?=
 =?us-ascii?Q?B5bxhPgkTmEnYgzDaFFqeG8i/HqHAnppupt7dq/WeIwpORUe28bFMOWU9XQQ?=
 =?us-ascii?Q?pPlzH/wcroTnszDXjIjQFehpOS9Nlll65c4tw4bS5du0KeVhmD6BORqBhn/O?=
 =?us-ascii?Q?fPu6XyuavIpu0wDWmma+VBJ/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8074249e-321f-4e13-9a57-08d9036d8540
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4512.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 19:58:37.3041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y6eHf5bbZ8ntzNIrIhToE4jgNxjqZcE2ZgqxTNrcioGVEcGrsT/cVUG7Jc/EXMncwBtg+6W9IqCItWtrIYxYjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4669
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Turbostat fails to correctly collect and display RAPL summary information
on Family 17h and 19h AMD processors. Running turbostat on these processors
returns immediately. If turbostat is working correctly then RAPL summary
data is displayed until the user provided command completes. If a command
is not provided by the user then turbostat is designed to continuously
display RAPL information until interrupted.

The issue is due to offset_to_idx() and idx_to_offset() missing support for
AMD MSR addresses/offsets. offset_to_idx()'s switch statement is missing
cases for AMD MSRs and idx_to_offset() does not include a path to return
AMD MSR(s) for any idx.

The solution is add AMD MSR support to offset_to_idx() and idx_to_offset().
These functions are split-out and renamed along architecture vendor lines
for supporting both AMD and Intel MSRs.

Fixes: 9972d5d84d76 ("tools/power turbostat: Enable accumulate RAPL display")
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
Changes in V2:
  - Set patch title to v2. The first patch submission was mistakenly titled as
  v4 when it should have been v1.
  - Change offset variables from 'int' to 'off_t' type. Change is needed
  to prevent sign extension in code casting int->off_t. This is currently a
  problem with AMD MSRs using base of 0xC000_0000
  - Update idx_valid_amd() capability masking to use RAPL_AMD_F17H

 tools/power/x86/turbostat/turbostat.c | 63 ++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 6 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index a7c4f0772e53..5aacdbd28fa8 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -291,9 +291,9 @@ struct msr_sum_array {
 /* The percpu MSR sum array.*/
 struct msr_sum_array *per_cpu_msr_sum;
 
-int idx_to_offset(int idx)
+off_t idx_to_offset_intel(int idx)
 {
-	int offset;
+	off_t offset;
 
 	switch (idx) {
 	case IDX_PKG_ENERGY:
@@ -320,7 +320,7 @@ int idx_to_offset(int idx)
 	return offset;
 }
 
-int offset_to_idx(int offset)
+int offset_to_idx_intel(off_t offset)
 {
 	int idx;
 
@@ -349,7 +349,7 @@ int offset_to_idx(int offset)
 	return idx;
 }
 
-int idx_valid(int idx)
+int idx_valid_intel(int idx)
 {
 	switch (idx) {
 	case IDX_PKG_ENERGY:
@@ -368,6 +368,51 @@ int idx_valid(int idx)
 		return 0;
 	}
 }
+
+off_t (*idx_to_offset)(int idx) = idx_to_offset_intel;
+int (*offset_to_idx)(off_t offset) = offset_to_idx_intel;
+int (*idx_valid)(int idx) = idx_valid_intel;
+
+off_t idx_to_offset_amd(int idx)
+{
+	off_t offset;
+
+	switch (idx) {
+	case IDX_PKG_ENERGY:
+		offset = MSR_PKG_ENERGY_STAT;
+		break;
+	default:
+		offset = -1;
+	}
+
+	return offset;
+}
+
+int offset_to_idx_amd(off_t offset)
+{
+	int idx;
+
+	switch (offset) {
+	case MSR_PKG_ENERGY_STAT:
+		idx = IDX_PKG_ENERGY;
+		break;
+	default:
+		idx = -1;
+	}
+
+	return idx;
+}
+
+int idx_valid_amd(int idx)
+{
+	switch (idx) {
+	case IDX_PKG_ENERGY:
+		return do_rapl & RAPL_AMD_F17H;
+	default:
+		return 0;
+	}
+}
+
 struct sys_counters {
 	unsigned int added_thread_counters;
 	unsigned int added_core_counters;
@@ -3272,7 +3317,7 @@ static int update_msr_sum(struct thread_data *t, struct core_data *c, struct pkg
 
 	for (i = IDX_PKG_ENERGY; i < IDX_COUNT; i++) {
 		unsigned long long msr_cur, msr_last;
-		int offset;
+		off_t offset;
 
 		if (!idx_valid(i))
 			continue;
@@ -3281,7 +3326,7 @@ static int update_msr_sum(struct thread_data *t, struct core_data *c, struct pkg
 			continue;
 		ret = get_msr(cpu, offset, &msr_cur);
 		if (ret) {
-			fprintf(outf, "Can not update msr(0x%x)\n", offset);
+			fprintf(outf, "Can not update msr(0x%lx)\n", offset);
 			continue;
 		}
 
@@ -5348,6 +5393,12 @@ void process_cpuid()
 	if (!quiet)
 		decode_misc_feature_control();
 
+	if (authentic_amd || hygon_genuine) {
+		idx_to_offset = idx_to_offset_amd;
+		offset_to_idx = offset_to_idx_amd;
+		idx_valid = idx_valid_amd;
+	}
+
 	return;
 }
 
-- 
2.25.1

