Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2866AD1FC
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2019 04:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733009AbfIICha (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 8 Sep 2019 22:37:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:54580 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731928AbfIICh3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 8 Sep 2019 22:37:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BCA83AE5E;
        Mon,  9 Sep 2019 02:37:27 +0000 (UTC)
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     srinivas.pandruvada@linux.intel.com, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org, bp@suse.de,
        lenb@kernel.org, rjw@rjwysocki.net
Cc:     x86@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        matt@codeblueprint.co.uk, viresh.kumar@linaro.org,
        juri.lelli@redhat.com, pjt@google.com, vincent.guittot@linaro.org,
        qperret@qperret.net, dietmar.eggemann@arm.com,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [PATCH 0/2] Add support for frequency invariance for (some) x86
Date:   Mon,  9 Sep 2019 04:42:14 +0200
Message-Id: <20190909024216.5942-1-ggherdovich@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is a resend with of Peter Zijlstra's patch to support frequency
scale-invariance on x86 from May 2018 [see 1]. I've added some modifications
and included performance test results. If Peter doesn't mind, I'm slapping my
name on it :)

The changes from Peter's original implementation are:

1) normalizing against the 4-cores turbo level instead or 1-core turbo
2) removing the run-time search for when the above value isn't found in the
   various Intel MSRs -- the base frequency value is taken in that case.

The section "4. KNOWN LIMITATIONS" in the first patch commit message addresses
the reason why this approach was dropped back in 2018, and explains that the
performance gains outweight that issue.

The second patch from Srinivas is taken verbatim from the May 2018 submission
as it still applies.

I apologies for the length of patch #1 commit message; I've made a table of
contents with summaries of each section that should make easier to skim
through the content.

This submission incorporates the feedback and requests for additional tests
received during the presentation made at OSPM 2019 in Pisa three months ago.

[1] https://lore.kernel.org/lkml/20180516044911.28797-2-srinivas.pandruvada@linux.intel.com/

Giovanni Gherdovich (1):
  x86,sched: Add support for frequency invariance

Srinivas Pandruvada (1):
  cpufreq: intel_pstate: Conditional frequency invariant accounting

 arch/x86/include/asm/topology.h |  29 +++++++
 arch/x86/kernel/smpboot.c       | 180 +++++++++++++++++++++++++++++++++++++++-
 drivers/cpufreq/intel_pstate.c  |   5 ++
 kernel/sched/core.c             |   1 +
 kernel/sched/sched.h            |   7 ++
 5 files changed, 221 insertions(+), 1 deletion(-)

-- 
2.16.4

