Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEE741059D3
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2019 19:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfKUSoM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Nov 2019 13:44:12 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:44844 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfKUSoL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Nov 2019 13:44:11 -0500
Received: from 79.184.253.244.ipv4.supernova.orange.pl (79.184.253.244) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 152313deb1676010; Thu, 21 Nov 2019 19:44:09 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <len.brown@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Len Brown <lenb@kernel.org>, Rafael Wysocki <rafael@kernel.org>
Subject: [PATCH 2/2] cpuidle: Allow idle states to be disabled by default
Date:   Thu, 21 Nov 2019 19:44:09 +0100
Message-ID: <2631482.XsRaRaDd0s@kreacher>
In-Reply-To: <5961586.ml7s97geqL@kreacher>
References: <5961586.ml7s97geqL@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In certain situations it may be useful to prevent some idle states
from being used by default while allowing user space to enable them
later on.

For this purpose, introduce a new state flag, CPUIDLE_FLAG_OFF, to
mark idle states that should be disabled by default, make the core
set CPUIDLE_STATE_DISABLED_BY_USER for those states at the
initialization time and add a new state attribute in sysfs,
"initial_status", to inform user space of the initial status of
the given idle state ("disabled" if CPUIDLE_FLAG_OFF is set for it,
"enabled" otherwise).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Changes from RFC:

 - Rename the new flag to CPUIDLE_FLAG_OFF.
 - Rename the new sysfs attribute to initial_status.
 - Fix typos in the documentation.

---
 Documentation/ABI/testing/sysfs-devices-system-cpu |    6 ++++++
 Documentation/admin-guide/pm/cpuidle.rst           |    3 +++
 drivers/cpuidle/cpuidle.c                          |    6 +++++-
 drivers/cpuidle/sysfs.c                            |   10 ++++++++++
 include/linux/cpuidle.h                            |    1 +
 5 files changed, 25 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/cpuidle/sysfs.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/sysfs.c
+++ linux-pm/drivers/cpuidle/sysfs.c
@@ -327,6 +327,14 @@ static ssize_t store_state_disable(struc
 	return size;
 }
 
+static ssize_t show_state_initial_status(struct cpuidle_state *state,
+					  struct cpuidle_state_usage *state_usage,
+					  char *buf)
+{
+	return sprintf(buf, "%s\n",
+		       state->flags & CPUIDLE_FLAG_OFF ? "disabled" : "enabled");
+}
+
 define_one_state_ro(name, show_state_name);
 define_one_state_ro(desc, show_state_desc);
 define_one_state_ro(latency, show_state_exit_latency);
@@ -337,6 +345,7 @@ define_one_state_ro(time, show_state_tim
 define_one_state_rw(disable, show_state_disable, store_state_disable);
 define_one_state_ro(above, show_state_above);
 define_one_state_ro(below, show_state_below);
+define_one_state_ro(initial_status, show_state_initial_status);
 
 static struct attribute *cpuidle_state_default_attrs[] = {
 	&attr_name.attr,
@@ -349,6 +358,7 @@ static struct attribute *cpuidle_state_d
 	&attr_disable.attr,
 	&attr_above.attr,
 	&attr_below.attr,
+	&attr_initial_status.attr,
 	NULL
 };
 
Index: linux-pm/include/linux/cpuidle.h
===================================================================
--- linux-pm.orig/include/linux/cpuidle.h
+++ linux-pm/include/linux/cpuidle.h
@@ -77,6 +77,7 @@ struct cpuidle_state {
 #define CPUIDLE_FLAG_COUPLED	BIT(1) /* state applies to multiple cpus */
 #define CPUIDLE_FLAG_TIMER_STOP BIT(2) /* timer is stopped on this state */
 #define CPUIDLE_FLAG_UNUSABLE	BIT(3) /* avoid using this state */
+#define CPUIDLE_FLAG_OFF	BIT(4) /* disable this state by default */
 
 struct cpuidle_device_kobj;
 struct cpuidle_state_kobj;
Index: linux-pm/drivers/cpuidle/cpuidle.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/cpuidle.c
+++ linux-pm/drivers/cpuidle/cpuidle.c
@@ -569,10 +569,14 @@ static int __cpuidle_register_device(str
 	if (!try_module_get(drv->owner))
 		return -EINVAL;
 
-	for (i = 0; i < drv->state_count; i++)
+	for (i = 0; i < drv->state_count; i++) {
 		if (drv->states[i].flags & CPUIDLE_FLAG_UNUSABLE)
 			dev->states_usage[i].disable |= CPUIDLE_STATE_DISABLED_BY_DRIVER;
 
+		if (drv->states[i].flags & CPUIDLE_FLAG_OFF)
+			dev->states_usage[i].disable |= CPUIDLE_STATE_DISABLED_BY_USER;
+	}
+
 	per_cpu(cpuidle_devices, dev->cpu) = dev;
 	list_add(&dev->device_list, &cpuidle_detected_devices);
 
Index: linux-pm/Documentation/ABI/testing/sysfs-devices-system-cpu
===================================================================
--- linux-pm.orig/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ linux-pm/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -196,6 +196,12 @@ Description:
 		does not reflect it. Likewise, if one enables a deep state but a
 		lighter state still is disabled, then this has no effect.
 
+What:		/sys/devices/system/cpu/cpuX/cpuidle/stateN/initial_status
+Date:		November 2019
+KernelVersion:	v5.6
+Contact:	Linux power management list <linux-pm@vger.kernel.org>
+Description:
+		(RO) The initial status of this state, "enabled" or "disabled".
 
 What:		/sys/devices/system/cpu/cpuX/cpuidle/stateN/residency
 Date:		March 2014
Index: linux-pm/Documentation/admin-guide/pm/cpuidle.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/cpuidle.rst
+++ linux-pm/Documentation/admin-guide/pm/cpuidle.rst
@@ -506,6 +506,9 @@ object corresponding to it, as follows:
 ``disable``
 	Whether or not this idle state is disabled.
 
+``initial_status``
+	The initial status of this state, "enabled" or "disabled".
+
 ``latency``
 	Exit latency of the idle state in microseconds.
 



