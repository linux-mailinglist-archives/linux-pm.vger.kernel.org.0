Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5361E99DB
	for <lists+linux-pm@lfdr.de>; Sun, 31 May 2020 20:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgEaS0U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 31 May 2020 14:26:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:52428 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbgEaS0Q (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 31 May 2020 14:26:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 07973AD5B;
        Sun, 31 May 2020 18:26:16 +0000 (UTC)
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     x86@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [PATCH v2 3/3] x86, sched: Bail out of frequency invariance if turbo_freq/base_freq gives 0
Date:   Sun, 31 May 2020 20:24:53 +0200
Message-Id: <20200531182453.15254-4-ggherdovich@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200531182453.15254-1-ggherdovich@suse.cz>
References: <20200531182453.15254-1-ggherdovich@suse.cz>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Be defensive against the case where the processor reports a base_freq
larger than turbo_freq (the ratio would be zero).

Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Fixes: 1567c3e3467c ("x86, sched: Add support for frequency invariance")
---
 arch/x86/kernel/smpboot.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index fe154c8226ba..f619007f46cf 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1976,6 +1976,7 @@ static bool core_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
 static bool intel_set_max_freq_ratio(void)
 {
 	u64 base_freq, turbo_freq;
+	u64 turbo_ratio;
 
 	if (slv_set_max_freq_ratio(&base_freq, &turbo_freq))
 		goto out;
@@ -2009,9 +2010,15 @@ static bool intel_set_max_freq_ratio(void)
 		return false;
 	}
 
-	arch_turbo_freq_ratio = div_u64(turbo_freq * SCHED_CAPACITY_SCALE,
-					base_freq);
+	turbo_ratio = div_u64(turbo_freq * SCHED_CAPACITY_SCALE, base_freq);
+	if (!turbo_ratio) {
+		pr_debug("Non-zero turbo and base frequencies led to a 0 ratio.\n");
+		return false;
+	}
+
+	arch_turbo_freq_ratio = turbo_ratio;
 	arch_set_max_freq_ratio(turbo_disabled());
+
 	return true;
 }
 
-- 
2.16.4

