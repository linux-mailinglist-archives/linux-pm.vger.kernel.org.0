Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D7F1B8962
	for <lists+linux-pm@lfdr.de>; Sat, 25 Apr 2020 22:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgDYUfm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 25 Apr 2020 16:35:42 -0400
Received: from netrider.rowland.org ([192.131.102.5]:59343 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726190AbgDYUfl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 25 Apr 2020 16:35:41 -0400
Received: (qmail 4654 invoked by uid 500); 25 Apr 2020 16:35:40 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Apr 2020 16:35:40 -0400
Date:   Sat, 25 Apr 2020 16:35:40 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
cc:     Linux-pm mailing list <linux-pm@vger.kernel.org>
Subject: [PATCH] PM: Helpful edits for devices.rst documentation
Message-ID: <Pine.LNX.4.44L0.2004251632340.4125-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Here are some minor edits of the devices.rst documentation file,
intended to improve the clarity and add a couple of missing details.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Rafael, here are the edits promised earlier.  Hopefully you will agree 
they are an improvement.

Alan Stern


[as1937]


 Documentation/driver-api/pm/devices.rst |   96 +++++++++++++++++---------------
 1 file changed, 53 insertions(+), 43 deletions(-)

Index: usb-devel/Documentation/driver-api/pm/devices.rst
===================================================================
--- usb-devel.orig/Documentation/driver-api/pm/devices.rst
+++ usb-devel/Documentation/driver-api/pm/devices.rst
@@ -349,7 +349,7 @@ the phases are: ``prepare``, ``suspend``
 	PM core will skip the ``suspend``, ``suspend_late`` and
 	``suspend_noirq`` phases as well as all of the corresponding phases of
 	the subsequent device resume for all of these devices.	In that case,
-	the ``->complete`` callback will be invoked directly after the
+	the ``->complete`` callback will be the next one invoked after the
 	``->prepare`` callback and is entirely responsible for putting the
 	device into a consistent state as appropriate.
 
@@ -383,11 +383,15 @@ the phases are: ``prepare``, ``suspend``
 	``->suspend`` methods provided by subsystems (bus types and PM domains
 	in particular) must follow an additional rule regarding what can be done
 	to the devices before their drivers' ``->suspend`` methods are called.
-	Namely, they can only resume the devices from runtime suspend by
-	calling :c:func:`pm_runtime_resume` for them, if that is necessary, and
+	Namely, they may resume the devices from runtime suspend by
+	calling :c:func:`pm_runtime_resume` for them, if that is necessary, but
 	they must not update the state of the devices in any other way at that
 	time (in case the drivers need to resume the devices from runtime
-	suspend in their ``->suspend`` methods).
+	suspend in their ``->suspend`` methods).  In fact, the PM core prevents
+	subsystems or drivers from putting devices into runtime suspend at
+	these times by calling :c:func:`pm_runtime_get_noresume` before issuing
+	the ``->prepare`` callback (and calling :c:func:`pm_runtime_put` after
+	issuing the ``->complete`` callback).
 
     3.	For a number of devices it is convenient to split suspend into the
 	"quiesce device" and "save device state" phases, in which cases
@@ -459,22 +463,22 @@ When resuming from freeze, standby or me
 
 	Note, however, that new children may be registered below the device as
 	soon as the ``->resume`` callbacks occur; it's not necessary to wait
-	until the ``complete`` phase with that.
+	until the ``complete`` phase runs.
 
 	Moreover, if the preceding ``->prepare`` callback returned a positive
 	number, the device may have been left in runtime suspend throughout the
-	whole system suspend and resume (the ``suspend``, ``suspend_late``,
-	``suspend_noirq`` phases of system suspend and the ``resume_noirq``,
-	``resume_early``, ``resume`` phases of system resume may have been
-	skipped for it).  In that case, the ``->complete`` callback is entirely
+	whole system suspend and resume (its ``->suspend``, ``->suspend_late``,
+	``->suspend_noirq``, ``->resume_noirq``,
+	``->resume_early``, and ``->resume`` callbacks may have been
+	skipped).  In that case, the ``->complete`` callback is entirely
 	responsible for putting the device into a consistent state after system
 	suspend if necessary.  [For example, it may need to queue up a runtime
 	resume request for the device for this purpose.]  To check if that is
 	the case, the ``->complete`` callback can consult the device's
-	``power.direct_complete`` flag.  Namely, if that flag is set when the
-	``->complete`` callback is being run, it has been called directly after
-	the preceding ``->prepare`` and special actions may be required
-	to make the device work correctly afterward.
+	``power.direct_complete`` flag.  If that flag is set when the
+	``->complete`` callback is being run then the direct-complete mechanism
+	was used, and special actions may be required to make the device work
+	correctly afterward.
 
 At the end of these phases, drivers should be as functional as they were before
 suspending: I/O can be performed using DMA and IRQs, and the relevant clocks are
@@ -575,10 +579,12 @@ and the phases are similar.
 
 The ``->poweroff``, ``->poweroff_late`` and ``->poweroff_noirq`` callbacks
 should do essentially the same things as the ``->suspend``, ``->suspend_late``
-and ``->suspend_noirq`` callbacks, respectively.  The only notable difference is
+and ``->suspend_noirq`` callbacks, respectively.  A notable difference is
 that they need not store the device register values, because the registers
 should already have been stored during the ``freeze``, ``freeze_late`` or
-``freeze_noirq`` phases.
+``freeze_noirq`` phases.  Also, on many machines the firmware will power-down
+the entire system, so it is not necessary for the callback to put the device in
+a low-power state.
 
 
 Leaving Hibernation
@@ -764,11 +770,10 @@ device driver in question.
 
 If it is necessary to resume a device from runtime suspend during a system-wide
 transition into a sleep state, that can be done by calling
-:c:func:`pm_runtime_resume` for it from the ``->suspend`` callback (or its
-couterpart for transitions related to hibernation) of either the device's driver
-or a subsystem responsible for it (for example, a bus type or a PM domain).
-That is guaranteed to work by the requirement that subsystems must not change
-the state of devices (possibly except for resuming them from runtime suspend)
+:c:func:`pm_runtime_resume` from the ``->suspend`` callback (or the ``->freeze``
+or ``->poweroff`` callback for transitions related to hibernation) of either the
+device's driver or its subsystem (for example, a bus type or a PM domain).
+However, subsystems must not otherwise change the runtime status of devices
 from their ``->prepare`` and ``->suspend`` callbacks (or equivalent) *before*
 invoking device drivers' ``->suspend`` callbacks (or equivalent).
 
@@ -779,27 +784,29 @@ The ``DPM_FLAG_SMART_SUSPEND`` Driver Fl
 
 Some bus types and PM domains have a policy to resume all devices from runtime
 suspend upfront in their ``->suspend`` callbacks, but that may not be really
-necessary if the driver of the device can cope with runtime-suspended devices.
-The driver can indicate that by setting ``DPM_FLAG_SMART_SUSPEND`` in
-:c:member:`power.driver_flags` at the probe time with the help of the
+necessary if the device's driver can cope with runtime-suspended devices.
+The driver can indicate this by setting ``DPM_FLAG_SMART_SUSPEND`` in
+:c:member:`power.driver_flags` at probe time, with the assistance of the
 :c:func:`dev_pm_set_driver_flags` helper routine.
 
-However, setting that flag also causes the PM core and middle-layer code
+Setting that flag causes the PM core and middle-layer code
 (bus types, PM domains etc.) to skip the ``->suspend_late`` and
 ``->suspend_noirq`` callbacks provided by the driver if the device remains in
-runtime suspend during the ``suspend_late`` phase of system-wide suspend (or
-during the ``poweroff_late`` or ``freeze_late`` phase of hibernation),
-after runtime PM was disabled for it.  [Without doing that, the same driver
+runtime suspend throughout those phases of the system-wide suspend (and
+similarly for the "freeze" and "poweroff" parts of system hibernation).
+[Otherwise the same driver
 callback might be executed twice in a row for the same device, which would not
 be valid in general.]  If the middle-layer system-wide PM callbacks are present
-for the device, they are responsible for doing the above, and the PM core takes
-care of it otherwise.
-
-In addition, with ``DPM_FLAG_SMART_SUSPEND`` set, the driver's ``->thaw_late``
-and ``->thaw_noirq`` callbacks are skipped if the device remained in runtime
-suspend during the preceding "freeze" transition related to hibernation.
-Again, if the middle-layer callbacks are present for the device, they are
-responsible for doing that, or the PM core takes care of it otherwise.
+for the device then they are responsible for skipping these driver callbacks;
+if not then the PM core skips them.  The subsystem callback routines can
+determine whether they need to skip the driver callbacks by testing the return
+value from the :c:func:`dev_pm_skip_suspend` helper function.
+
+In addition, with ``DPM_FLAG_SMART_SUSPEND`` set, the driver's ``->thaw_noirq``
+and ``->thaw_early`` callbacks are skipped in hibernation if the device remained
+in runtime suspend throughout the preceding "freeze" transition.  Again, if the
+middle-layer callbacks are present for the device, they are responsible for
+doing this, otherwise the PM core takes care of it.
 
 
 The ``DPM_FLAG_MAY_SKIP_RESUME`` Driver Flag
@@ -820,17 +827,20 @@ indicate to the PM core and middle-layer
 after system-wide PM transitions to the working state.  Whether or not that is
 the case generally depends on the state of the device before the given system
 suspend-resume cycle and on the type of the system transition under way.
-In particular, the "restore" and "thaw" transitions related to hibernation are
-not affected by ``DPM_FLAG_MAY_SKIP_RESUME`` at all.  [All devices are always
-resumed during the "restore" transition and whether or not any driver callbacks
-are skipped during the "freeze" transition depends whether or not the
-``DPM_FLAG_SMART_SUSPEND`` flag is set (see `above <smart_suspend_flag_>`_).]
+In particular, the "thaw" and "restore" transitions related to hibernation are
+not affected by ``DPM_FLAG_MAY_SKIP_RESUME`` at all.  [All callbacks are
+issued during the "restore" transition regardless of the flag settings,
+and whether or not any driver callbacks
+are skipped during the "thaw" transition depends whether or not the
+``DPM_FLAG_SMART_SUSPEND`` flag is set (see `above <smart_suspend_flag_>`_).
+In addition, a device is not allowed to remain in runtime suspend if any of its
+children will be returned to full power.]
 
 The ``DPM_FLAG_MAY_SKIP_RESUME`` flag is taken into account in combination with
 the :c:member:`power.may_skip_resume` status bit set by the PM core during the
 "suspend" phase of suspend-type transitions.  If the driver or the middle layer
 has a reason to prevent the driver's "noirq" and "early" resume callbacks from
-being skipped during the subsequent resume transition of the system, it should
+being skipped during the subsequent system resume transition, it should
 clear :c:member:`power.may_skip_resume` in its ``->suspend``, ``->suspend_late``
 or ``->suspend_noirq`` callback.  [Note that the drivers setting
 ``DPM_FLAG_SMART_SUSPEND`` need to clear :c:member:`power.may_skip_resume` in
@@ -845,8 +855,8 @@ not they should be skipped can be determ
 If that function returns ``true``, the driver's "noirq" and "early" resume
 callbacks should be skipped and the device's runtime PM status will be set to
 "suspended" by the PM core.  Otherwise, if the device was runtime-suspended
-during the preceding system-wide suspend transition and
-``DPM_FLAG_SMART_SUSPEND`` is set for it, its runtime PM status will be set to
+during the preceding system-wide suspend transition and its
+``DPM_FLAG_SMART_SUSPEND`` is set, its runtime PM status will be set to
 "active" by the PM core.  [Hence, the drivers that do not set
 ``DPM_FLAG_SMART_SUSPEND`` should not expect the runtime PM status of their
 devices to be changed from "suspended" to "active" by the PM core during

