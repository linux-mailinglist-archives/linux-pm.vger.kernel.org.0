Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F001E99DA
	for <lists+linux-pm@lfdr.de>; Sun, 31 May 2020 20:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgEaS0T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 31 May 2020 14:26:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:52404 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728282AbgEaS0Q (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 31 May 2020 14:26:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 615D2AD60;
        Sun, 31 May 2020 18:26:15 +0000 (UTC)
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
Subject: [PATCH v2 2/3] x86, sched: Bail out of frequency invariance if turbo frequency is unknown
Date:   Sun, 31 May 2020 20:24:52 +0200
Message-Id: <20200531182453.15254-3-ggherdovich@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200531182453.15254-1-ggherdovich@suse.cz>
References: <20200531182453.15254-1-ggherdovich@suse.cz>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There may be CPUs that support turbo boost but don't declare any turbo
ratio, i.e. their MSR_TURBO_RATIO_LIMIT is all zeroes. In that condition
scale-invariant calculations can't be performed.

Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
Suggested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Fixes: 1567c3e3467c ("x86, sched: Add support for frequency invariance")
---
 arch/x86/kernel/smpboot.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index d660966d7de7..fe154c8226ba 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -2001,9 +2001,11 @@ static bool intel_set_max_freq_ratio(void)
 	/*
 	 * Some hypervisors advertise X86_FEATURE_APERFMPERF
 	 * but then fill all MSR's with zeroes.
+	 * Some CPUs have turbo boost but don't declare any turbo ratio
+	 * in MSR_TURBO_RATIO_LIMIT.
 	 */
-	if (!base_freq) {
-		pr_debug("Couldn't determine cpu base frequency, necessary for scale-invariant accounting.\n");
+	if (!base_freq || !turbo_freq) {
+		pr_debug("Couldn't determine cpu base or turbo frequency, necessary for scale-invariant accounting.\n");
 		return false;
 	}
 
-- 
2.16.4

