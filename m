Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAEDD1B4786
	for <lists+linux-pm@lfdr.de>; Wed, 22 Apr 2020 16:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgDVOlQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Apr 2020 10:41:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:47528 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbgDVOlP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Apr 2020 10:41:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 123C3ACF2;
        Wed, 22 Apr 2020 14:41:13 +0000 (UTC)
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     x86@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [PATCH] x86, sched: Prevent divisions by zero in frequency invariant accounting
Date:   Wed, 22 Apr 2020 16:40:55 +0200
Message-Id: <20200422144055.18171-1-ggherdovich@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The product mcnt * arch_max_freq_ratio could be zero if it overflows u64.

For context, a large value for arch_max_freq_ratio would be 5000,
corresponding to a turbo_freq/base_freq ratio of 5 (normally it's more like
1500-2000). A large increment frequency for the MPERF counter would be 5GHz
(the base clock of all CPUs on the market today is less than that). With
these figures, a CPU would need to go without a scheduler tick for around 8
days for the u64 overflow to happen. It is unlikely, but the check is
warranted.

Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
Fixes: 1567c3e3467c ("x86, sched: Add support for frequency invariance")
---
 arch/x86/kernel/smpboot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 8c89e4d9ad28..fb71395cbcad 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -2055,14 +2055,14 @@ void arch_scale_freq_tick(void)
 
 	acnt = aperf - this_cpu_read(arch_prev_aperf);
 	mcnt = mperf - this_cpu_read(arch_prev_mperf);
-	if (!mcnt)
-		return;
 
 	this_cpu_write(arch_prev_aperf, aperf);
 	this_cpu_write(arch_prev_mperf, mperf);
 
 	acnt <<= 2*SCHED_CAPACITY_SHIFT;
 	mcnt *= arch_max_freq_ratio;
+	if (!mcnt)
+		return;
 
 	freq_scale = div64_u64(acnt, mcnt);
 
-- 
2.16.4

