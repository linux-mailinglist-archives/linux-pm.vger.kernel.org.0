Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E124A1BBF3E
	for <lists+linux-pm@lfdr.de>; Tue, 28 Apr 2020 15:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgD1NZL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Apr 2020 09:25:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:41782 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726827AbgD1NZL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 28 Apr 2020 09:25:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1897AAD4D;
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
Subject: [PATCH 0/2] More frequency invariance fixes for x86
Date:   Tue, 28 Apr 2020 15:24:48 +0200
Message-Id: <20200428132450.24901-1-ggherdovich@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Patch 1/2 prevents a division by zero in case the product
"delta_MPERF * arch_max_freq_ratio" overflows u64, as suggested by Linus at [1].
This patch supersedes the version at [2], as it also disables frequency
invariance when that overflow happens.

Patch 2/2 implements the recommendation by Ricardo Neri to check for an all
zero MSR_TURBO_RATIO_LIMIT and disable freq invariance in that case too.

[1] https://lore.kernel.org/lkml/CAHk-=wiX+NT2yxtdPszH9U_S96MCNQA56GJFXY45mZc47yG5KQ@mail.gmail.com/
[2] https://lore.kernel.org/lkml/20200422144055.18171-1-ggherdovich@suse.cz/
[3] https://lore.kernel.org/lkml/20200424013222.GA26355@ranerica-svr.sc.intel.com/

Giovanni Gherdovich (2):
  x86, sched: Prevent divisions by zero in frequency invariant
    accounting
  x86, sched: Bail out of frequency invariance if turbo frequency is
    unknown

 arch/x86/kernel/smpboot.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

-- 
2.16.4

