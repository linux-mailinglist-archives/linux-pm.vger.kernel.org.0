Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F145286373
	for <lists+linux-pm@lfdr.de>; Wed,  7 Oct 2020 18:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbgJGQQy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Oct 2020 12:16:54 -0400
Received: from mail-bn7nam10on2053.outbound.protection.outlook.com ([40.107.92.53]:53761
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727152AbgJGQQx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Oct 2020 12:16:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jk3Gu+I6Czh71qhmpjAjkv8N9xCfXpCVSfCLOvO20ks9mCaerwl2M04wFPYI81grproIaP957gn9gmg2qmJTiIcU2a5ieOO0d6Tw8EBmNNvazXlczPuItPjhDlB7gjvatuvF1iJiZsvnE//9FdT/vrX+fmrtlhV5gS1y48MMiQJCav58oq/gfkgBV4IngjqiI1nVNrzfwA/YdBUdMKTQCMaiYcLyrEK5EU4SetNthgCmgJ25NwfO91IeAB7kBLLpua9vtIoXATH6EpTgnnhZN1GDbqHtXGYkpnMNnWZH3O47LGNJKjk1WOUFhxlMbM15+wBLSHzQGPN0MJpdF1Bi+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmlQG/NA+a+j3TsLHpF6FlD3tj0KaoiiM/QOBD1ckUA=;
 b=PAXZA6BLyBKh7OI9n8gk1b4cTxV2pofhiPI86Bw/8Vtz9YIWYcGXIygkEDFDOzCiAsrXWcQP+p6ZOm/cbqmN4Qf5opx7oNwJcf9t+h7Mum6l7uac3cJzAuv4kTApfVDJUdh+tBLxwG7F6MIZbhki5z1yPlT4taqHIV3D31pcqFx/R5WbgBMzGiY4DdJHVpOnK0ZbTHcGMVF46rZFiFQ6ZXl6x8G1Ezx4FWMH31BFR+YvenVygpDtwwaFputa01Bm6QBdEtzuDlWnq3TZHqUm2QCaNRNtg+NQuh+kh962/bAzFhE8SruK6hrGxk/c6ytODt5YluNmwXee68VZkPWjnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmlQG/NA+a+j3TsLHpF6FlD3tj0KaoiiM/QOBD1ckUA=;
 b=XR8210bqkYoriFBoij+2x5lV10SZBNzX0tuauRZd9p+w133yvZM7VdLkTWfEWDAkCSeEG+/5gTonjeJD5c+oe0AQyQI+MvzUBN1qyWy3mkTaGijBybzUD7tj+TyTMm9CG99B/qh9Eo6OZQAaRGgdUpSg/7Kkta650QDjyOh7XmQ=
Authentication-Results: rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB2946.namprd12.prod.outlook.com (2603:10b6:408:9d::13)
 by BN8PR12MB3106.namprd12.prod.outlook.com (2603:10b6:408:45::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37; Wed, 7 Oct
 2020 16:16:45 +0000
Received: from BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::3054:612a:b2d7:f46d]) by BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::3054:612a:b2d7:f46d%6]) with mapi id 15.20.3433.046; Wed, 7 Oct 2020
 16:16:45 +0000
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
Subject: [PATCH v2 2/4] powercap/intel_rapl_msr: Convert rapl_msr_priv into pointer
Date:   Wed,  7 Oct 2020 11:14:37 -0500
Message-Id: <20201007161439.312534-3-kim.phillips@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201007161439.312534-1-kim.phillips@amd.com>
References: <20201007161439.312534-1-kim.phillips@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [70.114.200.6]
X-ClientProxiedBy: SA9PR11CA0006.namprd11.prod.outlook.com
 (2603:10b6:806:6e::11) To BN8PR12MB2946.namprd12.prod.outlook.com
 (2603:10b6:408:9d::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (70.114.200.6) by SA9PR11CA0006.namprd11.prod.outlook.com (2603:10b6:806:6e::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.39 via Frontend Transport; Wed, 7 Oct 2020 16:16:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1011f38b-9ff3-4cba-06ae-08d86adc62c4
X-MS-TrafficTypeDiagnostic: BN8PR12MB3106:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3106762655BA8C44068F0B86870A0@BN8PR12MB3106.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lRqt88MeMTvhve3ZnUvOr24oLS34n8krlaiOukjVPQXRtjSiEzIQ50/y5svJMsMcdsTf0Fs4js4KGPXqF4+HulxSUW0kQYed0Qw4peVupfeWuYf06wWtEvufHmE4ARsWr6JZzF2jOEd1/xQWUrkzA0UCfM9+d/9x7spqfqM52vfsjdcFdiVWSmm4Xl0PcJfmi6W8JDOCJe/6/tU91oZytSf8r7VV724VMn9XUgnpe+rels6TeeWouQq8jdBD3REda3Km2nIkwCKfuk1Se7SmyI/lP9VVi9CUHjhaX4zwS+YMmYvvTHgWDPjUaIXEb6YWETVsVuqUaGZFimilf8QnMf448SKIjJVVsk/Btxd7McyhrgeNjzpLp4aHHCjApbjnG4P7ruy8hihJy3oHupQ/dGH7aJ2rRfoCJDoGmvj/B9uF81aCab/4vkH40sUYeKlelAqss+xCEEosZc32ti2IXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39850400004)(376002)(346002)(396003)(136003)(26005)(8936002)(83380400001)(16526019)(186003)(83080400001)(86362001)(316002)(8676002)(36756003)(2616005)(956004)(110136005)(54906003)(69590400008)(2906002)(1076003)(6666004)(4326008)(44832011)(52116002)(5660300002)(6486002)(478600001)(966005)(66476007)(7416002)(66556008)(66946007)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: btOZH9xrqg/yhxqupVe79BKIWQW1vIYmnepbQARyBCvSgkHGalz5QJj20IY2VmxtGXJ0Qrb7mrna1bKZSmiGtaby3g+jYyuhbLOxVYX5Unm4SKSbzpXtJ3nQlKgwl+mVABQCyMRKQXDF3lTtcLkGwgAX2R0S2WuH4RmGdGXMDlnkecQNtJJef+FBL9zqXfgC6ouzarqxnMFLaiiwhv6pvkqTq77O7OSLP/awQhtHCFlTs7J4IJxcsdLKStgGOfjJf/zeokkL9qgqy83JfB2cFS4qVJ/93qukkYf+EXi6WMiIAvOlx2Ti/6pSh88gpQBD7gnUhuZyULnl7geohRaJItSi1wOutncZ7QR/hL6Yt3BS1CANDQFDU4Sh9VGjga3QnjBsKSvyqq4vc0kJp7TzsyIQ8SHVJXBKiM4GMbvB0UatA9UMJBTZzh7Up5wc+NKfGcU9+SA7VXnK++FaqtQhBfgbVyBYWQPEH6J3UqbHAXxh/p1ZEIN7uvzRbARD+C9qm79qxZ8hqoID2LNdvNVFpojlx5ApREr9HpZbM903blkuw3sgW+w2MqsLsJ/O4/ngS1vBmOz7bQq8kMnsD8ln8h5vWqPqsVpSxKwRpNnyvkkbaQRvPcUTMySajhrIMY+XgM7BWfeOQlJFRvWMwCGdeA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1011f38b-9ff3-4cba-06ae-08d86adc62c4
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 16:16:45.6877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ChryvCTaqSwGpxSvPVZTzVLDZk3M6lwY+YTXvc0wOWWmWXSRKT+VLR4Rfh+lnfBQV0Cxu9PAJRS/KCzURN+FAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3106
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Victor Ding <victording@google.com>

This patch changes the static struct rapl_msr_priv to a pointer to allow
using a different set of of RAPL MSR interface, preparing for supporting
AMD's RAPL MSR interface.

No functional changes.

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

https://lore.kernel.org/lkml/20200729205144.2.I4cb96a95365506b77761c1416258672a7556b595@changeid/

 - Added my Acked-by.
 - Added Daniel Lezcano to Cc.

 drivers/powercap/intel_rapl_msr.c | 37 +++++++++++++++++--------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index d2a2627507a9..c68ef5e4e1c4 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -31,7 +31,9 @@
 #define MSR_VR_CURRENT_CONFIG		0x00000601
 
 /* private data for RAPL MSR Interface */
-static struct rapl_if_priv rapl_msr_priv = {
+static struct rapl_if_priv *rapl_msr_priv;
+
+static struct rapl_if_priv rapl_msr_priv_intel = {
 	.reg_unit = MSR_RAPL_POWER_UNIT,
 	.regs[RAPL_DOMAIN_PACKAGE] = {
 		MSR_PKG_POWER_LIMIT, MSR_PKG_ENERGY_STATUS, MSR_PKG_PERF_STATUS, 0, MSR_PKG_POWER_INFO },
@@ -57,9 +59,9 @@ static int rapl_cpu_online(unsigned int cpu)
 {
 	struct rapl_package *rp;
 
-	rp = rapl_find_package_domain(cpu, &rapl_msr_priv);
+	rp = rapl_find_package_domain(cpu, rapl_msr_priv);
 	if (!rp) {
-		rp = rapl_add_package(cpu, &rapl_msr_priv);
+		rp = rapl_add_package(cpu, rapl_msr_priv);
 		if (IS_ERR(rp))
 			return PTR_ERR(rp);
 	}
@@ -72,7 +74,7 @@ static int rapl_cpu_down_prep(unsigned int cpu)
 	struct rapl_package *rp;
 	int lead_cpu;
 
-	rp = rapl_find_package_domain(cpu, &rapl_msr_priv);
+	rp = rapl_find_package_domain(cpu, rapl_msr_priv);
 	if (!rp)
 		return 0;
 
@@ -135,44 +137,45 @@ static int rapl_msr_probe(struct platform_device *pdev)
 	const struct x86_cpu_id *id = x86_match_cpu(pl4_support_ids);
 	int ret;
 
-	rapl_msr_priv.read_raw = rapl_msr_read_raw;
-	rapl_msr_priv.write_raw = rapl_msr_write_raw;
+	rapl_msr_priv = &rapl_msr_priv_intel;
+	rapl_msr_priv->read_raw = rapl_msr_read_raw;
+	rapl_msr_priv->write_raw = rapl_msr_write_raw;
 
 	if (id) {
-		rapl_msr_priv.limits[RAPL_DOMAIN_PACKAGE] = 3;
-		rapl_msr_priv.regs[RAPL_DOMAIN_PACKAGE][RAPL_DOMAIN_REG_PL4] =
+		rapl_msr_priv->limits[RAPL_DOMAIN_PACKAGE] = 3;
+		rapl_msr_priv->regs[RAPL_DOMAIN_PACKAGE][RAPL_DOMAIN_REG_PL4] =
 			MSR_VR_CURRENT_CONFIG;
 		pr_info("PL4 support detected.\n");
 	}
 
-	rapl_msr_priv.control_type = powercap_register_control_type(NULL, "intel-rapl", NULL);
-	if (IS_ERR(rapl_msr_priv.control_type)) {
+	rapl_msr_priv->control_type = powercap_register_control_type(NULL, "intel-rapl", NULL);
+	if (IS_ERR(rapl_msr_priv->control_type)) {
 		pr_debug("failed to register powercap control_type.\n");
-		return PTR_ERR(rapl_msr_priv.control_type);
+		return PTR_ERR(rapl_msr_priv->control_type);
 	}
 
 	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "powercap/rapl:online",
 				rapl_cpu_online, rapl_cpu_down_prep);
 	if (ret < 0)
 		goto out;
-	rapl_msr_priv.pcap_rapl_online = ret;
+	rapl_msr_priv->pcap_rapl_online = ret;
 
 	/* Don't bail out if PSys is not supported */
-	rapl_add_platform_domain(&rapl_msr_priv);
+	rapl_add_platform_domain(rapl_msr_priv);
 
 	return 0;
 
 out:
 	if (ret)
-		powercap_unregister_control_type(rapl_msr_priv.control_type);
+		powercap_unregister_control_type(rapl_msr_priv->control_type);
 	return ret;
 }
 
 static int rapl_msr_remove(struct platform_device *pdev)
 {
-	cpuhp_remove_state(rapl_msr_priv.pcap_rapl_online);
-	rapl_remove_platform_domain(&rapl_msr_priv);
-	powercap_unregister_control_type(rapl_msr_priv.control_type);
+	cpuhp_remove_state(rapl_msr_priv->pcap_rapl_online);
+	rapl_remove_platform_domain(rapl_msr_priv);
+	powercap_unregister_control_type(rapl_msr_priv->control_type);
 	return 0;
 }
 
-- 
2.27.0

