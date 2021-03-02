Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC48632A299
	for <lists+linux-pm@lfdr.de>; Tue,  2 Mar 2021 15:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376818AbhCBIMA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Mar 2021 03:12:00 -0500
Received: from spam01.hygon.cn ([110.188.70.11]:29918 "EHLO spam1.hygon.cn"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S234624AbhCBCCw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 1 Mar 2021 21:02:52 -0500
Received: from MK-FE.hygon.cn ([172.23.18.61])
        by spam1.hygon.cn with ESMTP id 12221h9q081973;
        Tue, 2 Mar 2021 10:01:43 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from cncheex01.Hygon.cn ([172.23.18.10])
        by MK-FE.hygon.cn with ESMTP id 12221gOb080418;
        Tue, 2 Mar 2021 10:01:42 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from ubuntu1604-2.higon.com (172.23.18.44) by cncheex01.Hygon.cn
 (172.23.18.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Tue, 2 Mar 2021
 10:01:27 +0800
From:   Pu Wen <puwen@hygon.cn>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-pm@vger.kernel.org>, <rjw@rjwysocki.net>,
        <rafael@kernel.org>, <bp@alien8.de>, <victording@google.com>,
        <kim.phillips@amd.com>, <rui.zhang@intel.com>,
        <srinivas.pandruvada@linux.intel.com>, Pu Wen <puwen@hygon.cn>
Subject: [PATCH] powercap: Add Hygon Fam18h RAPL support
Date:   Tue, 2 Mar 2021 10:01:08 +0800
Message-ID: <20210302020108.1777-1-puwen@hygon.cn>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.23.18.44]
X-ClientProxiedBy: cncheex01.Hygon.cn (172.23.18.10) To cncheex01.Hygon.cn
 (172.23.18.10)
X-MAIL: spam1.hygon.cn 12221h9q081973
X-DNSRBL: 
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable Hygon Fam18h RAPL support for the power capping framework.

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 drivers/powercap/intel_rapl_common.c | 1 +
 drivers/powercap/intel_rapl_msr.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index fdda2a737186..73cf68af9770 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1069,6 +1069,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 
 	X86_MATCH_VENDOR_FAM(AMD, 0x17, &rapl_defaults_amd),
 	X86_MATCH_VENDOR_FAM(AMD, 0x19, &rapl_defaults_amd),
+	X86_MATCH_VENDOR_FAM(HYGON, 0x18, &rapl_defaults_amd),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, rapl_ids);
diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index 78213d4b5b16..cc3b22881bfe 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -150,6 +150,7 @@ static int rapl_msr_probe(struct platform_device *pdev)
 	case X86_VENDOR_INTEL:
 		rapl_msr_priv = &rapl_msr_priv_intel;
 		break;
+	case X86_VENDOR_HYGON:
 	case X86_VENDOR_AMD:
 		rapl_msr_priv = &rapl_msr_priv_amd;
 		break;
-- 
2.23.0

