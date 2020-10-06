Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572C4284B38
	for <lists+linux-pm@lfdr.de>; Tue,  6 Oct 2020 13:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgJFL7N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Oct 2020 07:59:13 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:45494 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbgJFL7N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2020 07:59:13 -0400
Received: from 89-64-87-80.dynamic.chello.pl (89.64.87.80) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.489)
 id 7489302f797d67c0; Tue, 6 Oct 2020 13:59:10 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH] cpufreq: stats: Add memory barrier to store_reset()
Date:   Tue, 06 Oct 2020 13:59:05 +0200
Message-ID: <7155888.fM3j0pV3QS@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There is nothing to prevent the CPU or the compiler from reordering
the writes to stats->reset_time and stats->reset_pending in
store_reset(), in which case the readers of stats->reset_time may see
a stale value.  Moreover, on 32-bit arches the write to reset_time
cannot be completed in one go, so the readers of it may see a
partially updated value in that case.

To prevent that from happening, add a write memory barrier between
the writes to stats->reset_time and stats->reset_pending in
store_reset().

Fixes: 40c3bd4cfa6f ("cpufreq: stats: Defer stats update to cpufreq_stats_record_transition()")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

I couldn't convince myself that it was OK to leave the code as it was.

linux-next material.

---
 drivers/cpufreq/cpufreq_stats.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: linux-pm/drivers/cpufreq/cpufreq_stats.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_stats.c
+++ linux-pm/drivers/cpufreq/cpufreq_stats.c
@@ -99,6 +99,13 @@ static ssize_t store_reset(struct cpufre
 	 * avoid races.
 	 */
 	WRITE_ONCE(stats->reset_time, get_jiffies_64());
+	/*
+	 * The memory barrier below is to prevent the readers of reset_time from
+	 * seeing a stale or partially updated value. Note that they both access
+	 * reset_time only if reset_pending is 1, so corresponding read barriers
+	 * are not needed.
+	 */
+	smp_wmb();
 	WRITE_ONCE(stats->reset_pending, 1);
 
 	return count;



