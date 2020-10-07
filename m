Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC2F286374
	for <lists+linux-pm@lfdr.de>; Wed,  7 Oct 2020 18:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbgJGQRC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Oct 2020 12:17:02 -0400
Received: from mail-co1nam11on2064.outbound.protection.outlook.com ([40.107.220.64]:61856
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727152AbgJGQRC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Oct 2020 12:17:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIkzDK/3xB5pIdWh01Q3SPeEV+WMNd6v0sw0xd7BVI+SyitjJtBXzMDx46WW6V6ZJyv2Rs1PobjCEHzEUVXV4klhFKzCJmuckDo5huODXewGGDrQ3nHJfQn4pfzIZ6h7Ur1VFvLYviVdsL0qoupf1pXNOWO7twWDOL+l4ZAG7tYCNIO0pQu8trE1hr4OZQKq8FfT79lJsB9/VLQEx8HdCJmBrm18c/DNYT9mgHsL//b8bkrPqBj+eSOn8WbJWLUkToiT3y0JnHYkc8AF+COWzqQea8UMmlycvVfY8ZmDPI68k57nLuwbNIo9AXbxDpcg3eT7zCOLlM/XHDHTRAldGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkTwbv/DDDxRuCnLAMSgOwJo6omE51WScq9zVlw0cmU=;
 b=FcPWKnnBiYSaFFfskcr+HboL/TaNEnqZKuglvyL8dPgPdQsIP5E8oJVWTPD1d7aoaOMwcm8IB+zqWeLKexTJdc1zT6w8drg6r89SJ7thkCR9mhUVGnl2aa0DGvta7niudONYuzWUkRngDgto2e0fxhYYLZPliVceYijHSE5/sTlQlC3at078yU0GuL+JnnxY/r9KeqSxRZ/E/o1tF/GIP8DlIJxlG59+aSVp07xlrhViwIGwQu0Sr70d0Uf7yZlGNW/MTNtzUQExQyg5fyk/f1A6IST5/++d8GFRghy9huu+UgZsVi3QsHcPsnRF3Sb+suq99wiiQG8KqRgPI/1rDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkTwbv/DDDxRuCnLAMSgOwJo6omE51WScq9zVlw0cmU=;
 b=fjqeXc3oElrx4emlchTVCZ5nFbLxtu0Y1FcX1qrXFa4SHpoJFMZHxUaEyA3PNjsp4XlPp+rsTKZI67kxIkqGkJrqGNw3gZx4VlyGkRcCuNufbmq24NFL9/AuKv2F3zNSZp+JUYprpiuAWm9vNj/cJD942957taldrELDgs35Pw0=
Authentication-Results: rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB2946.namprd12.prod.outlook.com (2603:10b6:408:9d::13)
 by BN6PR12MB1315.namprd12.prod.outlook.com (2603:10b6:404:1f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Wed, 7 Oct
 2020 16:16:58 +0000
Received: from BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::3054:612a:b2d7:f46d]) by BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::3054:612a:b2d7:f46d%6]) with mapi id 15.20.3433.046; Wed, 7 Oct 2020
 16:16:58 +0000
From:   Kim Phillips <kim.phillips@amd.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Victor Ding <victording@google.com>, linux-pm@vger.kernel.org
Cc:     Kim Phillips <kim.phillips@amd.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Vineela Tummalapalli <vineela.tummalapalli@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org
Subject: [PATCH v2 3/4] powercap: Add AMD Fam17h RAPL support
Date:   Wed,  7 Oct 2020 11:14:38 -0500
Message-Id: <20201007161439.312534-4-kim.phillips@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201007161439.312534-1-kim.phillips@amd.com>
References: <20201007161439.312534-1-kim.phillips@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [70.114.200.6]
X-ClientProxiedBy: SN4PR0601CA0016.namprd06.prod.outlook.com
 (2603:10b6:803:2f::26) To BN8PR12MB2946.namprd12.prod.outlook.com
 (2603:10b6:408:9d::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (70.114.200.6) by SN4PR0601CA0016.namprd06.prod.outlook.com (2603:10b6:803:2f::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23 via Frontend Transport; Wed, 7 Oct 2020 16:16:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c0864b21-4635-4d60-096e-08d86adc6a66
X-MS-TrafficTypeDiagnostic: BN6PR12MB1315:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB131575C3AAA41C1D42979420870A0@BN6PR12MB1315.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X+HqpP3MmyMTcGxrpY8Vo3Xy+8XTiUjE5MvCRsn87zBGNyL34rOW7N1E15ChhASPIqnTovLadi4IGrdLQCGTTmx2meWGW1yFQirlY1a+cx8RMGPmhn6WlclCa2V3RIZbaFp0l58rz5KkpDViDZ2ypwL8oNIQdCkfWRFYxPAPB4K/bDuIjfzZuRSaeBdQEToiqU2jAjgeFYEaOOwgLMpoMeZdwIxrWjAzGwgSh+lh0na+4pTKlaeE5UtuY07C2lQP1IxknziYVyIyPFCL2zp6Kit1fst7pEPfxsqc8xuzMLPt+GdLS+9A3ybjPpk0HWXLe9c6nPBjy15C0e2YkWDEpDtKr8bV1iSa+pk+inYBKUn8hDjHjxanmBREM0nIc7MxOagg5miGg/SqGeXAoYOU1HK+6sOWNVu21Z0SyTSWhZOVMAMb8HwUyxYv57L8kJVGAed/+MyXovASlQDyKgxRLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(8936002)(66556008)(66476007)(66946007)(44832011)(52116002)(110136005)(1076003)(6666004)(5660300002)(26005)(6506007)(54906003)(69590400008)(2616005)(36756003)(186003)(16526019)(956004)(316002)(6512007)(2906002)(7416002)(83380400001)(966005)(4326008)(83080400001)(8676002)(478600001)(6486002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: KlzX8i52ImT0nz/9Cy6eEEjkYgPpXWDmfRqARuTyYLyoS32Os2RxyYQHsHAv8lL/3DplR2DmdpqFN9iIoWpQWI5gB3ncjDyVfD5qSU+1R+dnfr8FaimnQ9UTWun3UjJVodpBxmDa6jxNB1bWerfs4VKFxq9Jlq+8OoLEMyxEe7r68V8f7zY5PqZk2Ngel6uENL8GK7FcITmJRCSNtEykZW5ik9XsPzjSd+hIf5gMlFNlX8e4z2jmXYiwMg+rcJVt3TDkbOfgsj54zUzMh+obb/ZZlCQy1yqRm9rct/jI+WStFfCxUGXph3O/5qTAxPwgCx0irYhnVaJnfrd5y0GCLBml6E41VrzUZSnITMkPqcwo0LN8jxx82noWklu84bJxmJeqd/u6ZKLzWv9koFLvzuAEIdrRD+zrA84qG/cjvoggh12nOjR+G3xuq/oLCG9UqVJWWYjJg0Ups/rwJWhYKSk8oEpsaKOaEld89OcJSfxusMkImTMHDplbTbVnUlEHvsFUMRINsgVXMQ1DhZzsmgS/GvoZo6RE7Vpv2Nu9a3jD/nzsNoKC8BEsQnyq2AJlz0robNXwOb9RbYtiMLyAAkttF1nG5R4qychfPV35Bynw/pkQs0loSLz3tfHSmNxckO22GDq21sgkzo9YJdfdCw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0864b21-4635-4d60-096e-08d86adc6a66
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 16:16:58.4575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L+qksoKnpGgtOZmDLARbfDVOpKrA5/wJbCx/X9e+DKMBwBHNh7HLH+DLjvVpxxfRXGTFol2yhcwZeef7Cpp/lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1315
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Victor Ding <victording@google.com>

This patch enables AMD Fam17h RAPL support for the power capping
framework. The support is as per AMD Fam17h Model31h (Zen2) and
model 00-ffh (Zen1) PPR.

Tested by comparing the results of following two sysfs entries and the
values directly read from corresponding MSRs via /dev/cpu/[x]/msr:
  /sys/class/powercap/intel-rapl/intel-rapl:0/energy_uj
  /sys/class/powercap/intel-rapl/intel-rapl:0/intel-rapl:0:0/energy_uj

Signed-off-by: Victor Ding <victording@google.com>
Acked-by: Kim Phillips <kim.phillips@amd.com>
Cc: Victor Ding <victording@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Vineela Tummalapalli <vineela.tummalapalli@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: x86@kernel.org
---
Kim's changes from Victor's original submission:

https://lore.kernel.org/lkml/20200729205144.3.I01b89fb23d7498521c84cfdf417450cbbfca46bb@changeid/

 - Added my Acked-by.
 - Added Daniel Lezcano to Cc.

 arch/x86/include/asm/msr-index.h     |  1 +
 drivers/powercap/intel_rapl_common.c |  2 ++
 drivers/powercap/intel_rapl_msr.c    | 27 ++++++++++++++++++++++++++-
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index f1b24f1b774d..c0646f69d2a5 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -324,6 +324,7 @@
 #define MSR_PP1_POLICY			0x00000642
 
 #define MSR_AMD_RAPL_POWER_UNIT		0xc0010299
+#define MSR_AMD_CORE_ENERGY_STATUS	0xc001029a
 #define MSR_AMD_PKG_ENERGY_STATUS	0xc001029b
 
 /* Config TDP MSRs */
diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 983d75bd5bd1..6905ccffcec3 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1054,6 +1054,8 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 
 	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,	&rapl_defaults_hsw_server),
 	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,	&rapl_defaults_hsw_server),
+
+	X86_MATCH_VENDOR_FAM(AMD, 0x17, &rapl_defaults_core),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, rapl_ids);
diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index c68ef5e4e1c4..dcaef917f79d 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -48,6 +48,21 @@ static struct rapl_if_priv rapl_msr_priv_intel = {
 	.limits[RAPL_DOMAIN_PACKAGE] = 2,
 };
 
+static struct rapl_if_priv rapl_msr_priv_amd = {
+	.reg_unit = MSR_AMD_RAPL_POWER_UNIT,
+	.regs[RAPL_DOMAIN_PACKAGE] = {
+		0, MSR_AMD_PKG_ENERGY_STATUS, 0, 0, 0 },
+	.regs[RAPL_DOMAIN_PP0] = {
+		0, MSR_AMD_CORE_ENERGY_STATUS, 0, 0, 0 },
+	.regs[RAPL_DOMAIN_PP1] = {
+		0, 0, 0, 0, 0 },
+	.regs[RAPL_DOMAIN_DRAM] = {
+		0, 0, 0, 0, 0 },
+	.regs[RAPL_DOMAIN_PLATFORM] = {
+		0, 0, 0, 0, 0},
+	.limits[RAPL_DOMAIN_PACKAGE] = 1,
+};
+
 /* Handles CPU hotplug on multi-socket systems.
  * If a CPU goes online as the first CPU of the physical package
  * we add the RAPL package to the system. Similarly, when the last
@@ -137,7 +152,17 @@ static int rapl_msr_probe(struct platform_device *pdev)
 	const struct x86_cpu_id *id = x86_match_cpu(pl4_support_ids);
 	int ret;
 
-	rapl_msr_priv = &rapl_msr_priv_intel;
+	switch (boot_cpu_data.x86_vendor) {
+	case X86_VENDOR_INTEL:
+		rapl_msr_priv = &rapl_msr_priv_intel;
+		break;
+	case X86_VENDOR_AMD:
+		rapl_msr_priv = &rapl_msr_priv_amd;
+		break;
+	default:
+		pr_err("intel-rapl does not support CPU vendor %d\n", boot_cpu_data.x86_vendor);
+		return -ENODEV;
+	}
 	rapl_msr_priv->read_raw = rapl_msr_read_raw;
 	rapl_msr_priv->write_raw = rapl_msr_write_raw;
 
-- 
2.27.0

