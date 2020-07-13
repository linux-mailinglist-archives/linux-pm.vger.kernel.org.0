Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED82021D7A7
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 15:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729492AbgGMN6l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 09:58:41 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:64980 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729457AbgGMN6l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 09:58:41 -0400
Received: from 89-64-85-181.dynamic.chello.pl (89.64.85.181) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 68383a73e20a7f42; Mon, 13 Jul 2020 15:58:39 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Doug Smythies <dsmythies@telus.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Fix active mode setting from command line
Date:   Mon, 13 Jul 2020 15:58:38 +0200
Message-ID: <2265724.DSYBgs0BIW@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If intel_pstate starts in the passive mode by default (that happens
when the processor in the system doesn't support HWP), passing
intel_pstate=active in the kernel command line doesn't work, so
fix that.

Fixes: 33aa46f252c7 ("cpufreq: intel_pstate: Use passive mode by default without HWP")
Reported-by: Doug Smythies <dsmythies@telus.net>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -2534,7 +2534,7 @@ static struct cpufreq_driver intel_cpufr
 	.name		= "intel_cpufreq",
 };
 
-static struct cpufreq_driver *default_driver = &intel_pstate;
+static struct cpufreq_driver *default_driver;
 
 static void intel_pstate_driver_cleanup(void)
 {
@@ -2828,6 +2828,7 @@ static int __init intel_pstate_init(void
 			hwp_active++;
 			hwp_mode_bdw = id->driver_data;
 			intel_pstate.attr = hwp_cpufreq_attrs;
+			default_driver = &intel_pstate;
 			goto hwp_cpu_matched;
 		}
 	} else {
@@ -2845,7 +2846,8 @@ static int __init intel_pstate_init(void
 		return -ENODEV;
 	}
 	/* Without HWP start in the passive mode. */
-	default_driver = &intel_cpufreq;
+	if (!default_driver)
+		default_driver = &intel_cpufreq;
 
 hwp_cpu_matched:
 	/*
@@ -2899,6 +2901,8 @@ static int __init intel_pstate_setup(cha
 
 	if (!strcmp(str, "disable")) {
 		no_load = 1;
+	} else if (!strcmp(str, "active")) {
+		default_driver = &intel_pstate;
 	} else if (!strcmp(str, "passive")) {
 		default_driver = &intel_cpufreq;
 		no_hwp = 1;



