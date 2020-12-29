Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024372E728E
	for <lists+linux-pm@lfdr.de>; Tue, 29 Dec 2020 18:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgL2RQH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Dec 2020 12:16:07 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:56434 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgL2RQH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Dec 2020 12:16:07 -0500
Received: from 89-64-79-59.dynamic.chello.pl (89.64.79.59) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.537)
 id 49482a060e45e105; Tue, 29 Dec 2020 18:15:24 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Kenneth R. Crudup" <kenny@panix.com>
Subject: [PATCH] cpufreq: intel_pstate: Fix fast-switch fallback path
Date:   Tue, 29 Dec 2020 18:15:23 +0100
Message-ID: <2586979.mvXUDI8C0e@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

When sugov_update_single_perf() falls back to the "frequency"
path due to the missing scale-invariance, it will call
cpufreq_driver_fast_switch() via sugov_fast_switch()
and the driver's ->fast_switch() callback will be invoked,
so it must not be NULL.

However, after commit a365ab6b9dfb ("cpufreq: intel_pstate: Implement
the ->adjust_perf() callback") intel_pstate sets ->fast_switch() to
NULL when it is going to use intel_cpufreq_adjust_perf(), which is a
mistake, because on x86 the scale-invariance may be turned off
dynamically, so modify it to retain the original ->adjust_perf()
callback pointer.

Fixes: a365ab6b9dfb ("cpufreq: intel_pstate: Implement the ->adjust_perf() callback")
Reported-by: Kenneth R. Crudup <kenny@panix.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    1 -
 1 file changed, 1 deletion(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -3088,7 +3088,6 @@ static int __init intel_pstate_init(void
 			intel_pstate.attr = hwp_cpufreq_attrs;
 			intel_cpufreq.attr = hwp_cpufreq_attrs;
 			intel_cpufreq.flags |= CPUFREQ_NEED_UPDATE_LIMITS;
-			intel_cpufreq.fast_switch = NULL;
 			intel_cpufreq.adjust_perf = intel_cpufreq_adjust_perf;
 			if (!default_driver)
 				default_driver = &intel_pstate;



