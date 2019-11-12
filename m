Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1BEF8C38
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2019 10:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbfKLJvT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Nov 2019 04:51:19 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:63657 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfKLJvT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Nov 2019 04:51:19 -0500
Received: from 79.184.253.153.ipv4.supernova.orange.pl (79.184.253.153) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 0465ea6e146b3772; Tue, 12 Nov 2019 10:51:17 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Subject: [PATCH] cpuidle: teo: Exclude cpuidle overhead from computations
Date:   Tue, 12 Nov 2019 10:51:16 +0100
Message-ID: <35783785.QSqy96aQL9@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

One purpose of the computations in teo_update() is to determine
whether or not the (saved) time till the next timer event and the
measured idle duration fall into the same "bin", so avoid using
values that include the cpuidle overhead to obtain the latter.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/teo.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/cpuidle/governors/teo.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/teo.c
+++ linux-pm/drivers/cpuidle/governors/teo.c
@@ -130,7 +130,14 @@ static void teo_update(struct cpuidle_dr
 	} else {
 		u64 lat_ns = drv->states[dev->last_state_idx].exit_latency_ns;
 
-		measured_ns = cpu_data->time_span_ns;
+		/*
+		 * The computations below are to determine whether or not the
+		 * (saved) time till the next timer event and the measured idle
+		 * duration fall into the same "bin", so use last_residency_ns
+		 * for that instead of time_span_ns which includes the cpuidle
+		 * overhead.
+		 */
+		measured_ns = dev->last_residency_ns;
 		/*
 		 * The delay between the wakeup and the first instruction
 		 * executed by the CPU is not likely to be worst-case every



