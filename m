Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0941BBF41
	for <lists+linux-pm@lfdr.de>; Tue, 28 Apr 2020 15:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgD1NZM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Apr 2020 09:25:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:41808 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbgD1NZM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 28 Apr 2020 09:25:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 809ECAD26;
        Tue, 28 Apr 2020 13:25:09 +0000 (UTC)
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     x86@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [PATCH 1/2] x86, sched: Prevent divisions by zero in frequency invariant accounting
Date:   Tue, 28 Apr 2020 15:24:49 +0200
Message-Id: <20200428132450.24901-2-ggherdovich@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200428132450.24901-1-ggherdovich@suse.cz>
References: <20200428132450.24901-1-ggherdovich@suse.cz>
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

In that case it's also appropriate to disable frequency invariant
accounting: the feature relies on measures of the clock frequency done at
every scheduler tick, which need to be "fresh" to be at all meaningful.

Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
Fixes: 1567c3e3467c ("x86, sched: Add support for frequency invariance")
---
 arch/x86/kernel/smpboot.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 8c89e4d9ad28..4718f29a3065 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -2039,6 +2039,14 @@ static void init_freq_invariance(bool secondary)
 	}
 }
 
+static void disable_freq_invariance_workfn(struct work_struct *work)
+{
+	static_branch_disable(&arch_scale_freq_key);
+}
+
+static DECLARE_WORK(disable_freq_invariance_work,
+		    disable_freq_invariance_workfn);
+
 DEFINE_PER_CPU(unsigned long, arch_freq_scale) = SCHED_CAPACITY_SCALE;
 
 void arch_scale_freq_tick(void)
@@ -2055,14 +2063,18 @@ void arch_scale_freq_tick(void)
 
 	acnt = aperf - this_cpu_read(arch_prev_aperf);
 	mcnt = mperf - this_cpu_read(arch_prev_mperf);
-	if (!mcnt)
-		return;
 
 	this_cpu_write(arch_prev_aperf, aperf);
 	this_cpu_write(arch_prev_mperf, mperf);
 
 	acnt <<= 2*SCHED_CAPACITY_SHIFT;
 	mcnt *= arch_max_freq_ratio;
+	if (!mcnt) {
+		pr_warn("Scheduler tick missing for long time, disabling scale-invariant accounting.\n");
+		/* static_branch_disable() acquires a lock and may sleep */
+		schedule_work(&disable_freq_invariance_work);
+		return;
+	}
 
 	freq_scale = div64_u64(acnt, mcnt);
 
-- 
2.16.4

