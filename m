Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6256C1AB77E
	for <lists+linux-pm@lfdr.de>; Thu, 16 Apr 2020 07:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407081AbgDPFsP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Apr 2020 01:48:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:38428 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406790AbgDPFsM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Apr 2020 01:48:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A9744AD66;
        Thu, 16 Apr 2020 05:48:08 +0000 (UTC)
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
Subject: [PATCH 2/4] x86, sched: Account for CPUs with less than 4 cores in freq. invariance
Date:   Thu, 16 Apr 2020 07:47:43 +0200
Message-Id: <20200416054745.740-3-ggherdovich@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200416054745.740-1-ggherdovich@suse.cz>
References: <20200416054745.740-1-ggherdovich@suse.cz>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If a CPU has less than 4 physical cores, MSR_TURBO_RATIO_LIMIT will
rightfully report that the 4C turbo ratio is zero. In such cases, use the
1C turbo ratio instead for frequency invariance calculations.

Reported-by: Neil Rickert <nwr10cst-oslnx@yahoo.com>
Reported-by: Like Xu <like.xu@linux.intel.com>
Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
Fixes: 1567c3e3467c ("x86, sched: Add support for frequency invariance")
---
 arch/x86/kernel/smpboot.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 3a318ec9bc17..5d346b70844b 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1945,18 +1945,23 @@ static bool skx_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq, int size)
 
 static bool core_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
 {
+	u64 msr;
 	int err;
 
 	err = rdmsrl_safe(MSR_PLATFORM_INFO, base_freq);
 	if (err)
 		return false;
 
-	err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT, turbo_freq);
+	err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT, &msr);
 	if (err)
 		return false;
 
-	*base_freq = (*base_freq >> 8) & 0xFF;      /* max P state */
-	*turbo_freq = (*turbo_freq >> 24) & 0xFF;   /* 4C turbo    */
+	*base_freq = (*base_freq >> 8) & 0xFF;    /* max P state */
+	*turbo_freq = (msr >> 24) & 0xFF;         /* 4C turbo    */
+
+	/* The CPU may have less than 4 cores */
+	if (!*turbo_freq)
+		*turbo_freq = msr & 0xFF;         /* 1C turbo    */
 
 	return true;
 }
-- 
2.16.4

