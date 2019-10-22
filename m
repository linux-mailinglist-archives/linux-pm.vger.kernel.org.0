Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75E21E0AB6
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2019 19:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfJVRco (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Oct 2019 13:32:44 -0400
Received: from [217.140.110.172] ([217.140.110.172]:58550 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbfJVRcn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 22 Oct 2019 13:32:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1DD331F;
        Tue, 22 Oct 2019 10:32:22 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0FBE43F71A;
        Tue, 22 Oct 2019 10:32:21 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] cpufreq: mark duplicate frequencies as invalid and continue as normal
Date:   Tue, 22 Oct 2019 18:32:15 +0100
Message-Id: <20191022173215.13350-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently if we encounter duplicate frequency table entries, we abort
the validation and return error immediately. Instead of failing, we
can mark the entry as invalid and continue to function normal.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/cpufreq/freq_table.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Hi Viresh,

Since commit da0c6dc00c69 ("cpufreq: Handle sorted frequency tables more
efficiently"), I seem to have modified the firmware entry on my TC2 to
drop 500MHz and had not seen the issue with duplicate entries and had
totally forgotten about it.

Recently I reverted back to original setting as I corrupted it and
started seeing this issues. I don't know the background for raising
duplicates as fatal error but we did allow it when we add arm_big_little.c
and hence this RFC. If there are known issues with this approach, I can
continue with changed firmware config.

With switcher, we have:
(little cluster)
Virt: 175 MHz, 200 MHz, 250 MHz, 300 MHz, 350 MHz, 400 MHz, 450 MHz, 500 MHz
Actu: 350 MHz, 400 MHz, 500 MHz, 600 MHz, 700 MHz, 800 MHz, 900 MHz, 1000 MHz
(big cluster)
500 MHz, 600 MHz, 700 MHz, 800 MHz, 900 MHz, 1000 MHz, 1.10 GHz, 1.20 GHz

with 500 MHz duplicate in merged table.

Regards,
Sudeep

diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index ded427e0a488..e9bf287846d6 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -305,9 +305,10 @@ static int set_freq_table_sorted(struct cpufreq_policy *policy)
 		}
 
 		if (pos->frequency == prev->frequency) {
-			pr_warn("Duplicate freq-table entries: %u\n",
+			pr_warn("Duplicate freq-table entries: %u marking it invalid\n,",
 				pos->frequency);
-			return -EINVAL;
+			pos->frequency = CPUFREQ_ENTRY_INVALID;
+			continue;
 		}
 
 		/* Frequency increased from prev to pos */
-- 
2.17.1

