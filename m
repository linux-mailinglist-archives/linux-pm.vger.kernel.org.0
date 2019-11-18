Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91339100F48
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2019 00:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfKRXKF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 18:10:05 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:47836 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfKRXKF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 18:10:05 -0500
Received: from 79.184.253.244.ipv4.supernova.orange.pl (79.184.253.244) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 8307bb9ffdb0cd81; Tue, 19 Nov 2019 00:10:01 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Len Brown <lenb@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Doug Smythies <dsmythies@telus.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH 2/2] cpuidle: Allow idle states to be disabled by default
Date:   Tue, 19 Nov 2019 00:09:47 +0100
Message-ID: <5713675.uzLynPL2dK@kreacher>
In-Reply-To: <1688511.GgkECGP1XA@kreacher>
References: <2717750.dCEzHT3DVQ@kreacher> <CAJZ5v0jsQG37VF3-tiSndE0pXX9jEfgucm0UyvpM0bsyoOcpuA@mail.gmail.com> <1688511.GgkECGP1XA@kreacher>
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

For this purpose, introduce a new state flag, CPUIDLE_FLAG_UNCERTAIN,
to mark idle states that should be disabled by default, make the
core set CPUIDLE_STATE_DISABLED_BY_USER for those states at the
initialization time and add a new state attribute in sysfs,
"disable_default", to provide user space with the default value
of the "disable" attribute (1 if CPUIDLE_FLAG_UNCERTAIN is set for
the given state, 0 otherwise) to allow it to restore the initial
configuration of idle states easily if need be.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu |    6 ++++++
 Documentation/admin-guide/pm/cpuidle.rst           |    3 +++
 drivers/cpuidle/cpuidle.c                          |    3 +++
 drivers/cpuidle/sysfs.c                            |    9 +++++++++
 include/linux/cpuidle.h                            |    1 +
 5 files changed, 22 insertions(+)

Index: linux-pm/drivers/cpuidle/sysfs.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/sysfs.c
+++ linux-pm/drivers/cpuidle/sysfs.c
@@ -327,6 +327,13 @@ static ssize_t store_state_disable(struc
 	return size;
 }
 
+static ssize_t show_state_disable_default(struct cpuidle_state *state,
+					  struct cpuidle_state_usage *state_usage,
+					  char *buf)
+{
+	return sprintf(buf, "%u\n", !!(state->flags & CPUIDLE_FLAG_UNCERTAIN));
+}
+
 define_one_state_ro(name, show_state_name);
 define_one_state_ro(desc, show_state_desc);
 define_one_state_ro(latency, show_state_exit_latency);
@@ -337,6 +344,7 @@ define_one_state_ro(time, show_state_tim
 define_one_state_rw(disable, show_state_disable, store_state_disable);
 define_one_state_ro(above, show_state_above);
 define_one_state_ro(below, show_state_below);
+define_one_state_ro(disable_default, show_state_disable_default);
 
 static struct attribute *cpuidle_state_default_attrs[] = {
 	&attr_name.attr,
@@ -347,6 +355,7 @@ static struct attribute *cpuidle_state_d
 	&attr_usage.attr,
 	&attr_time.attr,
 	&attr_disable.attr,
+	&attr_disable_default.attr,
 	&attr_above.attr,
 	&attr_below.attr,
 	NULL
Index: linux-pm/include/linux/cpuidle.h
===================================================================
--- linux-pm.orig/include/linux/cpuidle.h
+++ linux-pm/include/linux/cpuidle.h
@@ -77,6 +77,7 @@ struct cpuidle_state {
 #define CPUIDLE_FLAG_COUPLED	BIT(1) /* state applies to multiple cpus */
 #define CPUIDLE_FLAG_TIMER_STOP BIT(2) /* timer is stopped on this state */
 #define CPUIDLE_FLAG_UNUSABLE	BIT(3) /* avoid using this state */
+#define CPUIDLE_FLAG_UNCERTAIN	BIT(4) /* disable this state by default */
 
 struct cpuidle_device_kobj;
 struct cpuidle_state_kobj;
Index: linux-pm/drivers/cpuidle/cpuidle.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/cpuidle.c
+++ linux-pm/drivers/cpuidle/cpuidle.c
@@ -572,6 +572,9 @@ static int __cpuidle_register_device(str
 	for (i = 0; i < drv->state_count; i++) {
 		if (drv->states[i].flags & CPUIDLE_FLAG_UNUSABLE)
 			dev->states_usage[i].disable |= CPUIDLE_STATE_DISABLED_BY_DRIVER;
+
+		if (drv->states[i].flags & CPUIDLE_FLAG_UNCERTAIN)
+			dev->states_usage[i].disable |= CPUIDLE_STATE_DISABLED_BY_USER;
 	}
 
 	per_cpu(cpuidle_devices, dev->cpu) = dev;
Index: linux-pm/Documentation/ABI/testing/sysfs-devices-system-cpu
===================================================================
--- linux-pm.orig/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ linux-pm/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -196,6 +196,12 @@ Description:
 		does not reflect it. Likewise, if one enables a deep state but a
 		lighter state still is disabled, then this has no effect.
 
+What:		/sys/devices/system/cpu/cpuX/cpuidle/stateN/disable_dafault
+Date:		November 2019
+KernelVersion:	v5.4
+Contact:	Linux power management list <linux-pm@vger.kernel.org>
+Description:
+		(RO) The default value of the disable state attribute (bool).
 
 What:		/sys/devices/system/cpu/cpuX/cpuidle/stateN/residency
 Date:		March 2014
Index: linux-pm/Documentation/admin-guide/pm/cpuidle.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/cpuidle.rst
+++ linux-pm/Documentation/admin-guide/pm/cpuidle.rst
@@ -506,6 +506,9 @@ object corresponding to it, as follows:
 ``disable``
 	Whether or not this idle state is disabled.
 
+``disable_default``
+	The default value of the ``disable`` attribute.
+
 ``latency``
 	Exit latency of the idle state in microseconds.
 



