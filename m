Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05E0E170A97
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2020 22:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbgBZVja (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Feb 2020 16:39:30 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:52181 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbgBZVja (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Feb 2020 16:39:30 -0500
Received: from 79.184.237.30.ipv4.supernova.orange.pl (79.184.237.30) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 533bfd923ca1b9ab; Wed, 26 Feb 2020 22:39:27 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Artem Bityutskiy <dedekind1@gmail.com>
Subject: [PATCH] cpufreq: Fix policy initialization for internal governor drivers
Date:   Wed, 26 Feb 2020 22:39:27 +0100
Message-ID: <3873122.F9s1CIEcb3@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Before commit 1e4f63aecb53 ("cpufreq: Avoid creating excessively
large stack frames") the initial value of the policy field in struct
cpufreq_policy set by the driver's ->init() callback was implicitly
passed from cpufreq_init_policy() to cpufreq_set_policy() if the
default governor was neither "performance" nor "powersave".  After
that commit, however, cpufreq_init_policy() must take that case into
consideration explicitly and handle it as appropriate, so make that
happen.

Fixes: 1e4f63aecb53 ("cpufreq: Avoid creating excessively large stack frames")
Link: https://lore.kernel.org/linux-pm/39fb762880c27da110086741315ca8b111d781cd.camel@gmail.com/
Reported-by: Artem Bityutskiy <dedekind1@gmail.com>
Cc: 5.4+ <stable@vger.kernel.org> # 5.4+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Note that I'm going to fast-track this patch for 5.6-rc4 which means that
it will go into my linux-next branch as soon as it shows up in the lists.

Thanks and sorry for the breakage!

---
 drivers/cpufreq/cpufreq.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -1076,9 +1076,17 @@ static int cpufreq_init_policy(struct cp
 			pol = policy->last_policy;
 		} else if (def_gov) {
 			pol = cpufreq_parse_policy(def_gov->name);
-		} else {
-			return -ENODATA;
+			/*
+			 * In case the default governor is neiter "performance"
+			 * nor "powersave", fall back to the initial policy
+			 * value set by the driver.
+			 */
+			if (pol == CPUFREQ_POLICY_UNKNOWN)
+				pol = policy->policy;
 		}
+		if (pol != CPUFREQ_POLICY_PERFORMANCE &&
+		    pol != CPUFREQ_POLICY_POWERSAVE)
+			return -ENODATA;
 	}
 
 	return cpufreq_set_policy(policy, gov, pol);



