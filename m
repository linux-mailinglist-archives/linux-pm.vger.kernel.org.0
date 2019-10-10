Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFF51D3384
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2019 23:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfJJVhm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Oct 2019 17:37:42 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58988 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJJVhl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Oct 2019 17:37:41 -0400
Received: from 79.184.255.36.ipv4.supernova.orange.pl (79.184.255.36) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id cd4238d3936759af; Thu, 10 Oct 2019 23:37:39 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Doug Smythies <dsmythies@telus.net>
Subject: [PATCH 4/4] cpuidle: teo: Fix "early hits" handling for disabled idle states
Date:   Thu, 10 Oct 2019 23:37:39 +0200
Message-ID: <1746940.X44tFrgt99@kreacher>
In-Reply-To: <60416800.X4hXmAfbqi@kreacher>
References: <60416800.X4hXmAfbqi@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The TEO governor uses idle duration "bins" defined in accordance with
the CPU idle states table provided by the driver, so that each "bin"
covers the idle duration range between the target residency of the
idle state corresponding to it and the target residency of the closest
deeper idle state.  The governor collects statistics for each bin
regardless of whether or not the idle state corresponding to it is
currently enabled.

In particular, the "early hits" metric measures the likelihood of a
situation in which the idle duration measured after wakeup falls into
to given bin, but the time till the next timer (sleep length) falls
into a bin corresponding to one of the deeper idle states.  It is
used when the "hits" and "misses" metrics indicate that the state
"matching" the sleep length should not be selected, so that the state
with the maximum "early hits" value is selected instead of it.

If the idle state corresponding to the given bin is disabled, it
cannot be selected and if it turns out to be the one that should be
selected, a shallower idle state needs to be used instead of it.
Nevertheless, the metrics collected for the bin corresponding to it
are still valid and need to be taken into account as though that
state had not been disabled.

As far as the "early hits" metric is concerned, teo_select() tries to
take disabled states into account, but the state index corresponding
to the maximum "early hits" value computed by it may be incorrect.
Namely, it always uses the index of the previous maximum "early hits"
state then, but there may be enabled idle states closer to the
disabled one in question.  In particular, if the current candidate
state (whose index is the idx value) is closer to the disabled one
and the "early hits" value of the disabled state is greater than the
current maximum, the index of the current candidate state (idx)
should replace the "maximum early hits state" index.

Modify the code to handle that case correctly.

Fixes: b26bf6ab716f ("cpuidle: New timer events oriented governor for tickless systems")
Reported-by: Doug Smythies <dsmythies@telus.net>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/teo.c |   35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/teo.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/teo.c
+++ linux-pm/drivers/cpuidle/governors/teo.c
@@ -277,18 +277,35 @@ static int teo_select(struct cpuidle_dri
 			hits = cpu_data->states[i].hits;
 			misses = cpu_data->states[i].misses;
 
+			if (early_hits >= cpu_data->states[i].early_hits ||
+			    idx < 0)
+				continue;
+
+			/*
+			 * If the current candidate state has been the one with
+			 * the maximum "early hits" metric so far, the "early
+			 * hits" metric of the disabled state replaces the
+			 * current "early hits" count to avoid selecting a
+			 * deeper state with lower "early hits" metric.
+			 */
+			if (max_early_idx == idx) {
+				early_hits = cpu_data->states[i].early_hits;
+				continue;
+			}
+
 			/*
-			 * If the "early hits" metric of a disabled state is
-			 * greater than the current maximum, it should be taken
-			 * into account, because it would be a mistake to select
-			 * a deeper state with lower "early hits" metric.  The
-			 * index cannot be changed to point to it, however, so
-			 * just increase the "early hits" count alone and let
-			 * the index still point to a shallower idle state.
+			 * The current candidate state is closer to the disabled
+			 * one than the current maximum "early hits" state, so
+			 * replace the latter with it, but in case the maximum
+			 * "early hits" state index has not been set so far,
+			 * check if the current candidate state is not too
+			 * shallow for that role.
 			 */
-			if (max_early_idx >= 0 &&
-			    early_hits < cpu_data->states[i].early_hits)
+			if (!(tick_nohz_tick_stopped() &&
+			      drv->states[idx].target_residency < TICK_USEC)) {
 				early_hits = cpu_data->states[i].early_hits;
+				max_early_idx = idx;
+			}
 
 			continue;
 		}



