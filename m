Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54407A8077
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2019 12:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfIDKl1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Sep 2019 06:41:27 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:55333 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfIDKl1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Sep 2019 06:41:27 -0400
Received: from 79.184.255.97.ipv4.supernova.orange.pl (79.184.255.97) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 9116fb2f2bcf1c8b; Wed, 4 Sep 2019 12:41:23 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [RFC][PATCH] cpuidle: Consolidate disabled state checks
Date:   Wed, 04 Sep 2019 12:41:23 +0200
Message-ID: <2136682.Ujdk25Y4fk@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There are two reasons why CPU idle states may be disabled: either
because the driver has disabled them or because they have been
disabled by user space via sysfs.

In the former case, the state's "disabled" flag is set once during
the initialization of the driver and it is never cleared later (it
is read-only effectively).  In the latter case, the "disable" field
of the given state's cpuidle_state_usage struct is set and it may be
changed via sysfs.  Thus checking whether or not an idle state has
been disabled involves reading these two flags every time.

In order to avoid the additional check of the state's "disabled" flag
(which is effectively read-only anyway), use the value of it at the
init time to set a (new) flag in the "disable" field of that state's
cpuidle_state_usage structure and use the sysfs interface to
manipulate another (new) flag in it.  This way the state is disabled
whenever the "disable" field of its cpuidle_state_usage structure is
nonzero, whatever the reason, and it is the only place to look into
to check whether or not the state has been disabled.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

I have not tested this yet, hence RFC, so it is mainly for feedback.

---
 drivers/cpuidle/cpuidle-powernv.c  |    7 +-----
 drivers/cpuidle/cpuidle.c          |   24 +++++++++++----------
 drivers/cpuidle/governors/ladder.c |    4 ---
 drivers/cpuidle/governors/menu.c   |    8 ++-----
 drivers/cpuidle/governors/teo.c    |    5 +---
 drivers/cpuidle/sysfs.c            |   42 +++++++++++++++++++------------------
 include/linux/cpuidle.h            |    3 ++
 7 files changed, 46 insertions(+), 47 deletions(-)

Index: linux-pm/drivers/cpuidle/cpuidle.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/cpuidle.c
+++ linux-pm/drivers/cpuidle/cpuidle.c
@@ -84,12 +84,12 @@ static int find_deepest_state(struct cpu
 
 	for (i = 1; i < drv->state_count; i++) {
 		struct cpuidle_state *s = &drv->states[i];
-		struct cpuidle_state_usage *su = &dev->states_usage[i];
 
-		if (s->disabled || su->disable || s->exit_latency <= latency_req
-		    || s->exit_latency > max_latency
-		    || (s->flags & forbidden_flags)
-		    || (s2idle && !s->enter_s2idle))
+		if (dev->states_usage[i].disable ||
+		    s->exit_latency <= latency_req ||
+		    s->exit_latency > max_latency ||
+		    (s->flags & forbidden_flags) ||
+		    (s2idle && !s->enter_s2idle))
 			continue;
 
 		latency_req = s->exit_latency;
@@ -265,8 +265,7 @@ int cpuidle_enter_state(struct cpuidle_d
 
 		if (diff < drv->states[entered_state].target_residency) {
 			for (i = entered_state - 1; i >= 0; i--) {
-				if (drv->states[i].disabled ||
-				    dev->states_usage[i].disable)
+				if (dev->states_usage[i].disable)
 					continue;
 
 				/* Shallower states are enabled, so update. */
@@ -275,8 +274,7 @@ int cpuidle_enter_state(struct cpuidle_d
 			}
 		} else if (diff > delay) {
 			for (i = entered_state + 1; i < drv->state_count; i++) {
-				if (drv->states[i].disabled ||
-				    dev->states_usage[i].disable)
+				if (dev->states_usage[i].disable)
 					continue;
 
 				/*
@@ -380,7 +378,7 @@ u64 cpuidle_poll_time(struct cpuidle_dri
 
 	limit_ns = TICK_NSEC;
 	for (i = 1; i < drv->state_count; i++) {
-		if (drv->states[i].disabled || dev->states_usage[i].disable)
+		if (dev->states_usage[i].disable)
 			continue;
 
 		limit_ns = (u64)drv->states[i].target_residency * NSEC_PER_USEC;
@@ -567,12 +565,16 @@ static void __cpuidle_device_init(struct
  */
 static int __cpuidle_register_device(struct cpuidle_device *dev)
 {
-	int ret;
 	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
+	int i, ret;
 
 	if (!try_module_get(drv->owner))
 		return -EINVAL;
 
+	for (i = 0; i < drv->state_count; i++)
+		if (drv->states[i].disabled)
+			dev->states_usage[i].disable |= CPUIDLE_STATE_DISABLED_BY_DRIVER;
+
 	per_cpu(cpuidle_devices, dev->cpu) = dev;
 	list_add(&dev->device_list, &cpuidle_detected_devices);
 
Index: linux-pm/drivers/cpuidle/sysfs.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/sysfs.c
+++ linux-pm/drivers/cpuidle/sysfs.c
@@ -255,25 +255,6 @@ static ssize_t show_state_##_name(struct
 	return sprintf(buf, "%u\n", state->_name);\
 }
 
-#define define_store_state_ull_function(_name) \
-static ssize_t store_state_##_name(struct cpuidle_state *state, \
-				   struct cpuidle_state_usage *state_usage, \
-				   const char *buf, size_t size)	\
-{ \
-	unsigned long long value; \
-	int err; \
-	if (!capable(CAP_SYS_ADMIN)) \
-		return -EPERM; \
-	err = kstrtoull(buf, 0, &value); \
-	if (err) \
-		return err; \
-	if (value) \
-		state_usage->_name = 1; \
-	else \
-		state_usage->_name = 0; \
-	return size; \
-}
-
 #define define_show_state_ull_function(_name) \
 static ssize_t show_state_##_name(struct cpuidle_state *state, \
 				  struct cpuidle_state_usage *state_usage, \
@@ -300,10 +281,31 @@ define_show_state_ull_function(time)
 define_show_state_str_function(name)
 define_show_state_str_function(desc)
 define_show_state_ull_function(disable)
-define_store_state_ull_function(disable)
 define_show_state_ull_function(above)
 define_show_state_ull_function(below)
 
+static ssize_t store_state_disable(struct cpuidle_state *state,
+				   struct cpuidle_state_usage *state_usage,
+				   const char *buf, size_t size)
+{
+	unsigned int value;
+	int err;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	err = kstrtouint(buf, 0, &value);
+	if (err)
+		return err;
+
+	if (value)
+		state_usage->disable |= CPUIDLE_STATE_DISABLED_BY_USER;
+	else
+		state_usage->disable &= ~CPUIDLE_STATE_DISABLED_BY_USER;
+
+	return size;
+}
+
 define_one_state_ro(name, show_state_name);
 define_one_state_ro(desc, show_state_desc);
 define_one_state_ro(latency, show_state_exit_latency);
Index: linux-pm/include/linux/cpuidle.h
===================================================================
--- linux-pm.orig/include/linux/cpuidle.h
+++ linux-pm/include/linux/cpuidle.h
@@ -29,6 +29,9 @@ struct cpuidle_driver;
  * CPUIDLE DEVICE INTERFACE *
  ****************************/
 
+#define CPUIDLE_STATE_DISABLED_BY_USER		BIT(0)
+#define CPUIDLE_STATE_DISABLED_BY_DRIVER	BIT(1)
+
 struct cpuidle_state_usage {
 	unsigned long long	disable;
 	unsigned long long	usage;
Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -298,7 +298,7 @@ static int menu_select(struct cpuidle_dr
 	if (unlikely(drv->state_count <= 1 || latency_req == 0) ||
 	    ((data->next_timer_us < drv->states[1].target_residency ||
 	      latency_req < drv->states[1].exit_latency) &&
-	     !drv->states[0].disabled && !dev->states_usage[0].disable)) {
+	     !dev->states_usage[0].disable)) {
 		/*
 		 * In this case state[0] will be used no matter what, so return
 		 * it right away and keep the tick running if state[0] is a
@@ -349,9 +349,8 @@ static int menu_select(struct cpuidle_dr
 	idx = -1;
 	for (i = 0; i < drv->state_count; i++) {
 		struct cpuidle_state *s = &drv->states[i];
-		struct cpuidle_state_usage *su = &dev->states_usage[i];
 
-		if (s->disabled || su->disable)
+		if (dev->states_usage[i]->disable)
 			continue;
 
 		if (idx == -1)
@@ -422,8 +421,7 @@ static int menu_select(struct cpuidle_dr
 			 * tick, so try to correct that.
 			 */
 			for (i = idx - 1; i >= 0; i--) {
-				if (drv->states[i].disabled ||
-				    dev->states_usage[i].disable)
+				if (dev->states_usage[i].disable)
 					continue;
 
 				idx = i;
Index: linux-pm/drivers/cpuidle/governors/teo.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/teo.c
+++ linux-pm/drivers/cpuidle/governors/teo.c
@@ -212,7 +212,7 @@ static int teo_find_shallower_state(stru
 	int i;
 
 	for (i = state_idx - 1; i >= 0; i--) {
-		if (drv->states[i].disabled || dev->states_usage[i].disable)
+		if (dev->states_usage[i].disable)
 			continue;
 
 		state_idx = i;
@@ -254,9 +254,8 @@ static int teo_select(struct cpuidle_dri
 
 	for (i = 0; i < drv->state_count; i++) {
 		struct cpuidle_state *s = &drv->states[i];
-		struct cpuidle_state_usage *su = &dev->states_usage[i];
 
-		if (s->disabled || su->disable) {
+		if (dev->states_usage[i].disable) {
 			/*
 			 * If the "early hits" metric of a disabled state is
 			 * greater than the current maximum, it should be taken
Index: linux-pm/drivers/cpuidle/governors/ladder.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/ladder.c
+++ linux-pm/drivers/cpuidle/governors/ladder.c
@@ -84,7 +84,6 @@ static int ladder_select_state(struct cp
 
 	/* consider promotion */
 	if (last_idx < drv->state_count - 1 &&
-	    !drv->states[last_idx + 1].disabled &&
 	    !dev->states_usage[last_idx + 1].disable &&
 	    last_residency > last_state->threshold.promotion_time &&
 	    drv->states[last_idx + 1].exit_latency <= latency_req) {
@@ -98,8 +97,7 @@ static int ladder_select_state(struct cp
 
 	/* consider demotion */
 	if (last_idx > first_idx &&
-	    (drv->states[last_idx].disabled ||
-	    dev->states_usage[last_idx].disable ||
+	    (dev->states_usage[last_idx].disable ||
 	    drv->states[last_idx].exit_latency > latency_req)) {
 		int i;
 
Index: linux-pm/drivers/cpuidle/cpuidle-powernv.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/cpuidle-powernv.c
+++ linux-pm/drivers/cpuidle/cpuidle-powernv.c
@@ -56,13 +56,10 @@ static u64 get_snooze_timeout(struct cpu
 		return default_snooze_timeout;
 
 	for (i = index + 1; i < drv->state_count; i++) {
-		struct cpuidle_state *s = &drv->states[i];
-		struct cpuidle_state_usage *su = &dev->states_usage[i];
-
-		if (s->disabled || su->disable)
+		if (dev->states_usage[i].disable)
 			continue;
 
-		return s->target_residency * tb_ticks_per_usec;
+		return drv->states[i].target_residency * tb_ticks_per_usec;
 	}
 
 	return default_snooze_timeout;



