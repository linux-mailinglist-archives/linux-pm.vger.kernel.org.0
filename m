Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48AB76A9C2
	for <lists+linux-pm@lfdr.de>; Tue,  1 Aug 2023 09:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjHAHIu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Aug 2023 03:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjHAHIu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Aug 2023 03:08:50 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23ABB1716
        for <linux-pm@vger.kernel.org>; Tue,  1 Aug 2023 00:08:48 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RFR4R2JSszVjqg;
        Tue,  1 Aug 2023 15:07:03 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 1 Aug
 2023 15:08:45 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <lenb@kernel.org>, <linux-pm@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next] tools/power turbostat: replace FALLTHRU comment by fallthrough pseudo-keyword
Date:   Tue, 1 Aug 2023 15:08:10 +0800
Message-ID: <20230801070810.3700584-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Replace the existing /* FALLTHRU */ comments with the
new pseudo-keyword macro fallthrough[1].

[1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 tools/power/x86/turbostat/turbostat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 8a36ba5df9f9..8a7483caeb76 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3742,7 +3742,7 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
 		break;
 	case INTEL_FAM6_ATOM_SILVERMONT:	/* BYT */
 		no_MSR_MISC_PWR_MGMT = 1;
-		/* FALLTHRU */
+		fallthrough;
 	case INTEL_FAM6_ATOM_SILVERMONT_D:	/* AVN */
 		pkg_cstate_limits = slv_pkg_cstate_limits;
 		break;
@@ -4808,7 +4808,7 @@ void perf_limit_reasons_probe(unsigned int family, unsigned int model)
 	case INTEL_FAM6_HASWELL_L:	/* HSW */
 	case INTEL_FAM6_HASWELL_G:	/* HSW */
 		do_gfx_perf_limit_reasons = 1;
-		/* FALLTHRU */
+		fallthrough;
 	case INTEL_FAM6_HASWELL_X:	/* HSX */
 		do_core_perf_limit_reasons = 1;
 		do_ring_perf_limit_reasons = 1;
-- 
2.34.1

