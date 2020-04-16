Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDEDE1AB788
	for <lists+linux-pm@lfdr.de>; Thu, 16 Apr 2020 07:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407044AbgDPFsO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Apr 2020 01:48:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:38402 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406744AbgDPFsM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Apr 2020 01:48:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BBEA6AD6C;
        Thu, 16 Apr 2020 05:48:07 +0000 (UTC)
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
Subject: [PATCH 1/4] x86, sched: Bail out of frequency invariance if base frequency is unknown
Date:   Thu, 16 Apr 2020 07:47:42 +0200
Message-Id: <20200416054745.740-2-ggherdovich@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200416054745.740-1-ggherdovich@suse.cz>
References: <20200416054745.740-1-ggherdovich@suse.cz>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some hypervisors such as VMWare ESXi 5.5 advertise support for
X86_FEATURE_APERFMPERF but then fill all MSR's with zeroes. In particular,
MSR_PLATFORM_INFO set to zero tricks the code that wants to know the base
clock frequency of the CPU (highest non-turbo frequency), producing a
division by zero when computing the ratio turbo_freq/base_freq necessary
for frequency invariant accounting.

It is to be noted that even if MSR_PLATFORM_INFO contained the appropriate
data, APERF and MPERF are constantly zero on ESXi 5.5, thus freq-invariance
couldn't be done in principle (not that it would make a lot of sense in a
VM anyway). The real problem is advertising X86_FEATURE_APERFMPERF. This
appears to be fixed in more recent versions: ESXi 6.7 doesn't advertise
that feature.

Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
Fixes: 1567c3e3467c ("x86, sched: Add support for frequency invariance")
---
 arch/x86/kernel/smpboot.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index fe3ab9632f3b..3a318ec9bc17 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1985,6 +1985,15 @@ static bool intel_set_max_freq_ratio(void)
 	return false;
 
 out:
+	/*
+	 * Some hypervisors advertise X86_FEATURE_APERFMPERF
+	 * but then fill all MSR's with zeroes.
+	 */
+	if (!base_freq) {
+		pr_debug("Couldn't determine cpu base frequency, necessary for scale-invariant accounting.\n");
+		return false;
+	}
+
 	arch_turbo_freq_ratio = div_u64(turbo_freq * SCHED_CAPACITY_SCALE,
 					base_freq);
 	arch_set_max_freq_ratio(turbo_disabled());
-- 
2.16.4

