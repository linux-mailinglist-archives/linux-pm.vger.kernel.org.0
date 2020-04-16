Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F95A1AB787
	for <lists+linux-pm@lfdr.de>; Thu, 16 Apr 2020 07:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407068AbgDPFsO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Apr 2020 01:48:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:38484 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406845AbgDPFsN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Apr 2020 01:48:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6AC73AEF5;
        Thu, 16 Apr 2020 05:48:10 +0000 (UTC)
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     x86@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Doug Smythies <dsmythies@telus.net>,
        Like Xu <like.xu@linux.intel.com>,
        Neil Rickert <nwr10cst-oslnx@yahoo.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [PATCH 4/4] x86, sched: Move check for CPU type to caller function
Date:   Thu, 16 Apr 2020 07:47:45 +0200
Message-Id: <20200416054745.740-5-ggherdovich@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200416054745.740-1-ggherdovich@suse.cz>
References: <20200416054745.740-1-ggherdovich@suse.cz>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Improve readability of the function intel_set_max_freq_ratio() by moving
the check for KNL CPUs there, together with checks for GLM and SKX.

Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
---
 arch/x86/kernel/smpboot.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index dd8e15f648bc..8c89e4d9ad28 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1877,9 +1877,6 @@ static bool knl_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq,
 	int err, i;
 	u64 msr;
 
-	if (!x86_match_cpu(has_knl_turbo_ratio_limits))
-		return false;
-
 	err = rdmsrl_safe(MSR_PLATFORM_INFO, base_freq);
 	if (err)
 		return false;
@@ -1977,7 +1974,8 @@ static bool intel_set_max_freq_ratio(void)
 	    skx_set_max_freq_ratio(&base_freq, &turbo_freq, 1))
 		goto out;
 
-	if (knl_set_max_freq_ratio(&base_freq, &turbo_freq, 1))
+	if (x86_match_cpu(has_knl_turbo_ratio_limits) &&
+	    knl_set_max_freq_ratio(&base_freq, &turbo_freq, 1))
 		goto out;
 
 	if (x86_match_cpu(has_skx_turbo_ratio_limits) &&
-- 
2.16.4

