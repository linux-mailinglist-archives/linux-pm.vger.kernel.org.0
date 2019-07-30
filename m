Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 281EF7A5B2
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 12:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfG3KLK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 06:11:10 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:42105 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfG3KLK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 06:11:10 -0400
Received: from 79.184.255.110.ipv4.supernova.orange.pl (79.184.255.110) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id f1d19142855f53dd; Tue, 30 Jul 2019 12:11:08 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpuidle: teo: Get rid of redundant check in teo_update()
Date:   Tue, 30 Jul 2019 12:11:08 +0200
Message-ID: <2331986.krM4XTe0ch@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Notice that setting measured_us to UINT_MAX in teo_update() earlier
doesn't change the behavior of the following code, so do that and
eliminate a redundant check used for setting measured_us to UINT_MAX.

This change is not expected to alter functionality.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/teo.c |   16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/teo.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/teo.c
+++ linux-pm/drivers/cpuidle/governors/teo.c
@@ -125,10 +125,11 @@ static void teo_update(struct cpuidle_dr
 
 	if (cpu_data->time_span_ns >= cpu_data->sleep_length_ns) {
 		/*
-		 * One of the safety nets has triggered or this was a timer
-		 * wakeup (or equivalent).
+		 * One of the safety nets has triggered or the wakeup was close
+		 * enough to the closest timer event expected at the idle state
+		 * selection time to be discarded.
 		 */
-		measured_us = sleep_length_us;
+		measured_us = UINT_MAX;
 	} else {
 		unsigned int lat = drv->states[cpu_data->last_state].exit_latency;
 
@@ -189,15 +190,6 @@ static void teo_update(struct cpuidle_dr
 	}
 
 	/*
-	 * If the total time span between idle state selection and the "reflect"
-	 * callback is greater than or equal to the sleep length determined at
-	 * the idle state selection time, the wakeup is likely to be due to a
-	 * timer event.
-	 */
-	if (cpu_data->time_span_ns >= cpu_data->sleep_length_ns)
-		measured_us = UINT_MAX;
-
-	/*
 	 * Save idle duration values corresponding to non-timer wakeups for
 	 * pattern detection.
 	 */



