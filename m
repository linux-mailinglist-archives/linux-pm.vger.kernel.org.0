Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510D2284D20
	for <lists+linux-pm@lfdr.de>; Tue,  6 Oct 2020 16:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgJFOFz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Oct 2020 10:05:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:33308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbgJFOD4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Oct 2020 10:03:56 -0400
Received: from mail.kernel.org (ip5f5ad5bd.dynamic.kabel-deutschland.de [95.90.213.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E8FD217BA;
        Tue,  6 Oct 2020 14:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601993034;
        bh=uDMrTXZvCi3GqbsSk6IY/HaOXXwfMR0GCoAdcBK7a+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=18wpBe5djH8EJumjqT3LUFE94OWwgaSTBerABYaeKjL5l2pPvZSalU72VsVotl/Qc
         ZTSbQI6AkwowML/IFAkbFTO5QMMG4v4dMIlR5PYrpdbhC0vT+btj2NbM5Lz39eArX+
         LyaXrG/loFQjv3YAOOY2gEw2EXaLFach4csVBJSc=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kPnZI-0019FR-1F; Tue, 06 Oct 2020 16:03:52 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v5 21/52] docs: remove some replace macros like |struct foo|
Date:   Tue,  6 Oct 2020 16:03:18 +0200
Message-Id: <4d4614f02f71ca7ee21eb611b56868bb616d122a.1601992016.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601992016.git.mchehab+huawei@kernel.org>
References: <cover.1601992016.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There are three files with replace macros for structs,
mapping them into Sphinx 2.x C domain references.

Well, this is broken on Sphinx 3.x. Also, for Sphinx 2.x,
the automarkup macro should be able to take care of them.

So, let's just drop those.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/admin-guide/pm/cpufreq.rst | 11 ++--
 Documentation/driver-api/device_link.rst | 10 ++--
 Documentation/driver-api/pm/cpuidle.rst  | 65 +++++++++++-------------
 3 files changed, 38 insertions(+), 48 deletions(-)

diff --git a/Documentation/admin-guide/pm/cpufreq.rst b/Documentation/admin-guide/pm/cpufreq.rst
index 368e612145d2..6adb7988e0eb 100644
--- a/Documentation/admin-guide/pm/cpufreq.rst
+++ b/Documentation/admin-guide/pm/cpufreq.rst
@@ -1,7 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0
 .. include:: <isonum.txt>
 
-.. |struct cpufreq_policy| replace:: :c:type:`struct cpufreq_policy <cpufreq_policy>`
 .. |intel_pstate| replace:: :doc:`intel_pstate <intel_pstate>`
 
 =======================
@@ -92,16 +91,16 @@ control the P-state of multiple CPUs at the same time and writing to it affects
 all of those CPUs simultaneously.
 
 Sets of CPUs sharing hardware P-state control interfaces are represented by
-``CPUFreq`` as |struct cpufreq_policy| objects.  For consistency,
-|struct cpufreq_policy| is also used when there is only one CPU in the given
+``CPUFreq`` as struct cpufreq_policy objects.  For consistency,
+struct cpufreq_policy is also used when there is only one CPU in the given
 set.
 
-The ``CPUFreq`` core maintains a pointer to a |struct cpufreq_policy| object for
+The ``CPUFreq`` core maintains a pointer to a struct cpufreq_policy object for
 every CPU in the system, including CPUs that are currently offline.  If multiple
 CPUs share the same hardware P-state control interface, all of the pointers
-corresponding to them point to the same |struct cpufreq_policy| object.
+corresponding to them point to the same struct cpufreq_policy object.
 
-``CPUFreq`` uses |struct cpufreq_policy| as its basic data type and the design
+``CPUFreq`` uses struct cpufreq_policy as its basic data type and the design
 of its user space interface is based on the policy concept.
 
 
diff --git a/Documentation/driver-api/device_link.rst b/Documentation/driver-api/device_link.rst
index bc2d89af88ce..76950d061632 100644
--- a/Documentation/driver-api/device_link.rst
+++ b/Documentation/driver-api/device_link.rst
@@ -1,7 +1,3 @@
-.. |struct dev_pm_domain| replace:: :c:type:`struct dev_pm_domain <dev_pm_domain>`
-.. |struct generic_pm_domain| replace:: :c:type:`struct generic_pm_domain <generic_pm_domain>`
-
-
 .. _device_link:
 
 ============
@@ -166,7 +162,7 @@ Examples
   is the same as if the MMU was the parent of the master device.
 
   The fact that both devices share the same power domain would normally
-  suggest usage of a |struct dev_pm_domain| or |struct generic_pm_domain|,
+  suggest usage of a struct dev_pm_domain or struct generic_pm_domain,
   however these are not independent devices that happen to share a power
   switch, but rather the MMU device serves the busmaster device and is
   useless without it.  A device link creates a synthetic hierarchical
@@ -202,7 +198,7 @@ Examples
 Alternatives
 ============
 
-* A |struct dev_pm_domain| can be used to override the bus,
+* A struct dev_pm_domain can be used to override the bus,
   class or device type callbacks.  It is intended for devices sharing
   a single on/off switch, however it does not guarantee a specific
   suspend/resume ordering, this needs to be implemented separately.
@@ -211,7 +207,7 @@ Alternatives
   suspended.  Furthermore it cannot be used to enforce a specific shutdown
   ordering or a driver presence dependency.
 
-* A |struct generic_pm_domain| is a lot more heavyweight than a
+* A struct generic_pm_domain is a lot more heavyweight than a
   device link and does not allow for shutdown ordering or driver presence
   dependencies.  It also cannot be used on ACPI systems.
 
diff --git a/Documentation/driver-api/pm/cpuidle.rst b/Documentation/driver-api/pm/cpuidle.rst
index 3588bf078566..d477208604b8 100644
--- a/Documentation/driver-api/pm/cpuidle.rst
+++ b/Documentation/driver-api/pm/cpuidle.rst
@@ -1,11 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0
 .. include:: <isonum.txt>
 
-.. |struct cpuidle_governor| replace:: :c:type:`struct cpuidle_governor <cpuidle_governor>`
-.. |struct cpuidle_device| replace:: :c:type:`struct cpuidle_device <cpuidle_device>`
-.. |struct cpuidle_driver| replace:: :c:type:`struct cpuidle_driver <cpuidle_driver>`
-.. |struct cpuidle_state| replace:: :c:type:`struct cpuidle_state <cpuidle_state>`
-
 ========================
 CPU Idle Time Management
 ========================
@@ -54,7 +49,7 @@ platform that the Linux kernel can run on.  For this reason, data structures
 operated on by them cannot depend on any hardware architecture or platform
 design details as well.
 
-The governor itself is represented by a |struct cpuidle_governor| object
+The governor itself is represented by a struct cpuidle_governor object
 containing four callback pointers, :c:member:`enable`, :c:member:`disable`,
 :c:member:`select`, :c:member:`reflect`, a :c:member:`rating` field described
 below, and a name (string) used for identifying it.
@@ -83,11 +78,11 @@ callbacks:
 	  int (*enable) (struct cpuidle_driver *drv, struct cpuidle_device *dev);
 
 	The role of this callback is to prepare the governor for handling the
-	(logical) CPU represented by the |struct cpuidle_device| object	pointed
-	to by the ``dev`` argument.  The |struct cpuidle_driver| object pointed
+	(logical) CPU represented by the struct cpuidle_device object	pointed
+	to by the ``dev`` argument.  The struct cpuidle_driver object pointed
 	to by the ``drv`` argument represents the ``CPUIdle`` driver to be used
 	with that CPU (among other things, it should contain the list of
-	|struct cpuidle_state| objects representing idle states that the
+	struct cpuidle_state objects representing idle states that the
 	processor holding the given CPU can be asked to enter).
 
 	It may fail, in which case it is expected to return a negative error
@@ -102,7 +97,7 @@ callbacks:
 	  void (*disable) (struct cpuidle_driver *drv, struct cpuidle_device *dev);
 
 	Called to make the governor stop handling the (logical) CPU represented
-	by the |struct cpuidle_device| object pointed to by the ``dev``
+	by the struct cpuidle_device object pointed to by the ``dev``
 	argument.
 
 	It is expected to reverse any changes made by the ``->enable()``
@@ -116,12 +111,12 @@ callbacks:
 	                 bool *stop_tick);
 
 	Called to select an idle state for the processor holding the (logical)
-	CPU represented by the |struct cpuidle_device| object pointed to by the
+	CPU represented by the struct cpuidle_device object pointed to by the
 	``dev`` argument.
 
 	The list of idle states to take into consideration is represented by the
-	:c:member:`states` array of |struct cpuidle_state| objects held by the
-	|struct cpuidle_driver| object pointed to by the ``drv`` argument (which
+	:c:member:`states` array of struct cpuidle_state objects held by the
+	struct cpuidle_driver object pointed to by the ``drv`` argument (which
 	represents the ``CPUIdle`` driver to be used with the CPU at hand).  The
 	value returned by this callback is interpreted as an index into that
 	array (unless it is a negative error code).
@@ -136,7 +131,7 @@ callbacks:
 	asking the processor to enter the idle state).
 
 	This callback is mandatory (i.e. the :c:member:`select` callback pointer
-	in |struct cpuidle_governor| must not be ``NULL`` for the registration
+	in struct cpuidle_governor must not be ``NULL`` for the registration
 	of the governor to succeed).
 
 :c:member:`reflect`
@@ -167,21 +162,21 @@ CPU idle time management (``CPUIdle``) drivers provide an interface between the
 other parts of ``CPUIdle`` and the hardware.
 
 First of all, a ``CPUIdle`` driver has to populate the :c:member:`states` array
-of |struct cpuidle_state| objects included in the |struct cpuidle_driver| object
+of struct cpuidle_state objects included in the struct cpuidle_driver object
 representing it.  Going forward this array will represent the list of available
 idle states that the processor hardware can be asked to enter shared by all of
 the logical CPUs handled by the given driver.
 
 The entries in the :c:member:`states` array are expected to be sorted by the
-value of the :c:member:`target_residency` field in |struct cpuidle_state| in
+value of the :c:member:`target_residency` field in struct cpuidle_state in
 the ascending order (that is, index 0 should correspond to the idle state with
 the minimum value of :c:member:`target_residency`).  [Since the
 :c:member:`target_residency` value is expected to reflect the "depth" of the
-idle state represented by the |struct cpuidle_state| object holding it, this
+idle state represented by the struct cpuidle_state object holding it, this
 sorting order should be the same as the ascending sorting order by the idle
 state "depth".]
 
-Three fields in |struct cpuidle_state| are used by the existing ``CPUIdle``
+Three fields in struct cpuidle_state are used by the existing ``CPUIdle``
 governors for computations related to idle state selection:
 
 :c:member:`target_residency`
@@ -203,7 +198,7 @@ governors for computations related to idle state selection:
 	any idle state at all.  [There are other flags used by the ``CPUIdle``
 	core in special situations.]
 
-The :c:member:`enter` callback pointer in |struct cpuidle_state|, which must not
+The :c:member:`enter` callback pointer in struct cpuidle_state, which must not
 be ``NULL``, points to the routine to execute in order to ask the processor to
 enter this particular idle state:
 
@@ -212,14 +207,14 @@ enter this particular idle state:
   void (*enter) (struct cpuidle_device *dev, struct cpuidle_driver *drv,
                  int index);
 
-The first two arguments of it point to the |struct cpuidle_device| object
+The first two arguments of it point to the struct cpuidle_device object
 representing the logical CPU running this callback and the
-|struct cpuidle_driver| object representing the driver itself, respectively,
-and the last one is an index of the |struct cpuidle_state| entry in the driver's
+struct cpuidle_driver object representing the driver itself, respectively,
+and the last one is an index of the struct cpuidle_state entry in the driver's
 :c:member:`states` array representing the idle state to ask the processor to
 enter.
 
-The analogous ``->enter_s2idle()`` callback in |struct cpuidle_state| is used
+The analogous ``->enter_s2idle()`` callback in struct cpuidle_state is used
 only for implementing the suspend-to-idle system-wide power management feature.
 The difference between in and ``->enter()`` is that it must not re-enable
 interrupts at any point (even temporarily) or attempt to change the states of
@@ -227,48 +222,48 @@ clock event devices, which the ``->enter()`` callback may do sometimes.
 
 Once the :c:member:`states` array has been populated, the number of valid
 entries in it has to be stored in the :c:member:`state_count` field of the
-|struct cpuidle_driver| object representing the driver.  Moreover, if any
+struct cpuidle_driver object representing the driver.  Moreover, if any
 entries in the :c:member:`states` array represent "coupled" idle states (that
 is, idle states that can only be asked for if multiple related logical CPUs are
-idle), the :c:member:`safe_state_index` field in |struct cpuidle_driver| needs
+idle), the :c:member:`safe_state_index` field in struct cpuidle_driver needs
 to be the index of an idle state that is not "coupled" (that is, one that can be
 asked for if only one logical CPU is idle).
 
 In addition to that, if the given ``CPUIdle`` driver is only going to handle a
 subset of logical CPUs in the system, the :c:member:`cpumask` field in its
-|struct cpuidle_driver| object must point to the set (mask) of CPUs that will be
+struct cpuidle_driver object must point to the set (mask) of CPUs that will be
 handled by it.
 
 A ``CPUIdle`` driver can only be used after it has been registered.  If there
 are no "coupled" idle state entries in the driver's :c:member:`states` array,
-that can be accomplished by passing the driver's |struct cpuidle_driver| object
+that can be accomplished by passing the driver's struct cpuidle_driver object
 to :c:func:`cpuidle_register_driver()`.  Otherwise, :c:func:`cpuidle_register()`
 should be used for this purpose.
 
-However, it also is necessary to register |struct cpuidle_device| objects for
+However, it also is necessary to register struct cpuidle_device objects for
 all of the logical CPUs to be handled by the given ``CPUIdle`` driver with the
 help of :c:func:`cpuidle_register_device()` after the driver has been registered
 and :c:func:`cpuidle_register_driver()`, unlike :c:func:`cpuidle_register()`,
 does not do that automatically.  For this reason, the drivers that use
 :c:func:`cpuidle_register_driver()` to register themselves must also take care
-of registering the |struct cpuidle_device| objects as needed, so it is generally
+of registering the struct cpuidle_device objects as needed, so it is generally
 recommended to use :c:func:`cpuidle_register()` for ``CPUIdle`` driver
 registration in all cases.
 
-The registration of a |struct cpuidle_device| object causes the ``CPUIdle``
+The registration of a struct cpuidle_device object causes the ``CPUIdle``
 ``sysfs`` interface to be created and the governor's ``->enable()`` callback to
 be invoked for the logical CPU represented by it, so it must take place after
 registering the driver that will handle the CPU in question.
 
-``CPUIdle`` drivers and |struct cpuidle_device| objects can be unregistered
+``CPUIdle`` drivers and struct cpuidle_device objects can be unregistered
 when they are not necessary any more which allows some resources associated with
 them to be released.  Due to dependencies between them, all of the
-|struct cpuidle_device| objects representing CPUs handled by the given
+struct cpuidle_device objects representing CPUs handled by the given
 ``CPUIdle`` driver must be unregistered, with the help of
 :c:func:`cpuidle_unregister_device()`, before calling
 :c:func:`cpuidle_unregister_driver()` to unregister the driver.  Alternatively,
 :c:func:`cpuidle_unregister()` can be called to unregister a ``CPUIdle`` driver
-along with all of the |struct cpuidle_device| objects representing CPUs handled
+along with all of the struct cpuidle_device objects representing CPUs handled
 by it.
 
 ``CPUIdle`` drivers can respond to runtime system configuration changes that
@@ -277,8 +272,8 @@ happen, for example, when the system's power source is switched from AC to
 battery or the other way around).  Upon a notification of such a change,
 a ``CPUIdle`` driver is expected to call :c:func:`cpuidle_pause_and_lock()` to
 turn ``CPUIdle`` off temporarily and then :c:func:`cpuidle_disable_device()` for
-all of the |struct cpuidle_device| objects representing CPUs affected by that
+all of the struct cpuidle_device objects representing CPUs affected by that
 change.  Next, it can update its :c:member:`states` array in accordance with
 the new configuration of the system, call :c:func:`cpuidle_enable_device()` for
-all of the relevant |struct cpuidle_device| objects and invoke
+all of the relevant struct cpuidle_device objects and invoke
 :c:func:`cpuidle_resume_and_unlock()` to allow ``CPUIdle`` to be used again.
-- 
2.26.2

