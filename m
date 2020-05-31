Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC451E99D6
	for <lists+linux-pm@lfdr.de>; Sun, 31 May 2020 20:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgEaS0O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 31 May 2020 14:26:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:52360 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbgEaS0O (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 31 May 2020 14:26:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E0261AC79;
        Sun, 31 May 2020 18:26:13 +0000 (UTC)
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
Subject: [PATCH v2 0/3] More frequency invariance fixes for x86
Date:   Sun, 31 May 2020 20:24:50 +0200
Message-Id: <20200531182453.15254-1-ggherdovich@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

v1 at https://lore.kernel.org/lkml/20200428132450.24901-1-ggherdovich@suse.cz/

changes wrt v1:

- add Peter Zijlstra's code to check for multiplication overflow, see
  https://lore.kernel.org/lkml/20200501133042.GE3762@hirez.programming.kicks-ass.net/
- put all frequence invariant code behind CONFIG_X86_64, as the overflow
  checks need 64 bits operations, see the build error at
  https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/thread/7GDIBOMNVDG5W2XZD4EICE2TUZR3THBN/
- add additional patch to check for when base_freq > turbo_freq,
  suggested by Peter Zijlstra at
  https://lore.kernel.org/lkml/20200501130427.GD3762@hirez.programming.kicks-ass.net/
  
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Cover Letter from v1:

Patch 1/2 prevents a division by zero in case the product
"delta_MPERF * arch_max_freq_ratio" overflows u64, as suggested by Linus at [1].
This patch supersedes the version at [2], as it also disables frequency
invariance when that overflow happens.

Patch 2/2 implements the recommendation by Ricardo Neri to check for an all
zero MSR_TURBO_RATIO_LIMIT and disable freq invariance in that case too.

[1] https://lore.kernel.org/lkml/CAHk-=wiX+NT2yxtdPszH9U_S96MCNQA56GJFXY45mZc47yG5KQ@mail.gmail.com/
[2] https://lore.kernel.org/lkml/20200422144055.18171-1-ggherdovich@suse.cz/
[3] https://lore.kernel.org/lkml/20200424013222.GA26355@ranerica-svr.sc.intel.com/

Giovanni Gherdovich (3):
  x86, sched: check for counters overflow in frequency invariant
    accounting
  x86, sched: Bail out of frequency invariance if turbo frequency is
    unknown
  x86, sched: Bail out of frequency invariance if turbo_freq/base_freq
    gives 0

 arch/x86/include/asm/topology.h |  2 +-
 arch/x86/kernel/smpboot.c       | 50 +++++++++++++++++++++++++++++++++--------
 2 files changed, 42 insertions(+), 10 deletions(-)

-- 
2.16.4

