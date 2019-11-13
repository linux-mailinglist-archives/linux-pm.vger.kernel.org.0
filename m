Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E30FF9F14
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 01:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfKMALi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Nov 2019 19:11:38 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:61985 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfKMALi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Nov 2019 19:11:38 -0500
Received: from 79.184.253.153.ipv4.supernova.orange.pl (79.184.253.153) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 0fe9b4f92c5da7e6; Wed, 13 Nov 2019 01:11:35 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Subject: [PATCH 3/3] cpuidle: teo: Avoid code duplication in conditionals
Date:   Wed, 13 Nov 2019 01:10:13 +0100
Message-ID: <3101916.xHKGgMp4rb@kreacher>
In-Reply-To: <13588000.TfE7eV4KYW@kreacher>
References: <13588000.TfE7eV4KYW@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There are three places in teo_select() where a given amount of time
is compared with TICK_NSEC if tick_nohz_tick_stopped() returns true,
which is a bit of duplicated code.

Avoid that code duplication by defining a helper function to do the
check and using it in all of the places in question.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/teo.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/teo.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/teo.c
+++ linux-pm/drivers/cpuidle/governors/teo.c
@@ -202,6 +202,11 @@ static void teo_update(struct cpuidle_dr
 		cpu_data->interval_idx = 0;
 }
 
+static bool teo_time_ok(u64 interval_ns)
+{
+	return !tick_nohz_tick_stopped() || interval_ns >= TICK_NSEC;
+}
+
 /**
  * teo_find_shallower_state - Find shallower idle state matching given duration.
  * @drv: cpuidle driver containing state data.
@@ -306,8 +311,7 @@ static int teo_select(struct cpuidle_dri
 			 * check if the current candidate state is not too
 			 * shallow for that role.
 			 */
-			if (!(tick_nohz_tick_stopped() &&
-			      drv->states[idx].target_residency_ns < TICK_NSEC)) {
+			if (teo_time_ok(drv->states[idx].target_residency_ns)) {
 				prev_max_early_idx = max_early_idx;
 				early_hits = cpu_data->states[i].early_hits;
 				max_early_idx = idx;
@@ -333,8 +337,7 @@ static int teo_select(struct cpuidle_dri
 		misses = cpu_data->states[i].misses;
 
 		if (early_hits < cpu_data->states[i].early_hits &&
-		    !(tick_nohz_tick_stopped() &&
-		      drv->states[i].target_residency_ns < TICK_NSEC)) {
+		    teo_time_ok(drv->states[i].target_residency_ns)) {
 			prev_max_early_idx = max_early_idx;
 			early_hits = cpu_data->states[i].early_hits;
 			max_early_idx = i;
@@ -409,7 +412,7 @@ static int teo_select(struct cpuidle_dri
 			 * Avoid spending too much time in an idle state that
 			 * would be too shallow.
 			 */
-			if (!(tick_nohz_tick_stopped() && avg_ns < TICK_NSEC)) {
+			if (teo_time_ok(avg_ns)) {
 				duration_ns = avg_ns;
 				if (drv->states[idx].target_residency_ns > avg_ns)
 					idx = teo_find_shallower_state(drv, dev,



