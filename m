Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9370EA33BD
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2019 11:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfH3JYO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Aug 2019 05:24:14 -0400
Received: from [110.188.70.11] ([110.188.70.11]:50151 "EHLO spam1.hygon.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726461AbfH3JYO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 30 Aug 2019 05:24:14 -0400
Received: from MK-FE.hygon.cn ([172.23.18.61])
        by spam1.hygon.cn with ESMTP id x7U9NJ98068505;
        Fri, 30 Aug 2019 17:23:19 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from cncheex01.Hygon.cn ([172.23.18.10])
        by MK-FE.hygon.cn with ESMTP id x7U9N8Lh034383;
        Fri, 30 Aug 2019 17:23:09 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from pw-vbox.hygon.cn (172.23.18.44) by cncheex01.Hygon.cn
 (172.23.18.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Fri, 30 Aug
 2019 17:23:14 +0800
From:   Pu Wen <puwen@hygon.cn>
To:     <lenb@kernel.org>, <calvin.walton@kepstin.ca>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, Pu Wen <puwen@hygon.cn>
Subject: [RFC PATCH] tools/power turbostat: Fix caller parameter of get_tdp_amd()
Date:   Fri, 30 Aug 2019 17:22:36 +0800
Message-ID: <1567156956-29634-1-git-send-email-puwen@hygon.cn>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.23.18.44]
X-ClientProxiedBy: cncheex02.Hygon.cn (172.23.18.12) To cncheex01.Hygon.cn
 (172.23.18.10)
X-MAIL: spam1.hygon.cn x7U9NJ98068505
X-DNSRBL: 
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit 9392bd98bba760be96ee ("tools/power turbostat: Add support for AMD
Fam 17h (Zen) RAPL") add a function get_tdp_amd(), the parameter is CPU
family. But the rapl_probe_amd() function use wrong model parameter.
Fix the wrong caller parameter of get_tdp_amd() to use family.

Cc: <stable@vger.kernel.org> # v5.1+
Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 75fc4fb..1cd28eb 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4002,7 +4002,7 @@ void rapl_probe_amd(unsigned int family, unsigned int model)
 	rapl_energy_units = ldexp(1.0, -(msr >> 8 & 0x1f));
 	rapl_power_units = ldexp(1.0, -(msr & 0xf));
 
-	tdp = get_tdp_amd(model);
+	tdp = get_tdp_amd(family);
 
 	rapl_joule_counter_range = 0xFFFFFFFF * rapl_energy_units / tdp;
 	if (!quiet)
-- 
2.7.4

