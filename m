Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E830D2349CF
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jul 2020 19:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730924AbgGaRDa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Jul 2020 13:03:30 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:61504 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728958AbgGaRDa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jul 2020 13:03:30 -0400
Received: from 89-64-88-186.dynamic.chello.pl (89.64.88.186) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 665493960af42882; Fri, 31 Jul 2020 19:03:26 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wolfram Sang <wsa@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH] PM: runtime: Add kerneldoc comments to multiple helpers
Date:   Fri, 31 Jul 2020 19:03:26 +0200
Message-ID: <2672940.cHDmkauF2A@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add kerneldoc comments to multiple PM-runtime helper functions
defined as static inline wrappers around lower-level routines to
provide quick reference decumentation of their behavior.

Some of them are similar to each other with subtle differences only
and the behavior of some of them may appear as counter-intuitive, so
clarify all that to avoid confusion.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/pm_runtime.h |  246 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 246 insertions(+)

Index: linux-pm/include/linux/pm_runtime.h
===================================================================
--- linux-pm.orig/include/linux/pm_runtime.h
+++ linux-pm/include/linux/pm_runtime.h
@@ -60,58 +60,151 @@ extern void pm_runtime_put_suppliers(str
 extern void pm_runtime_new_link(struct device *dev);
 extern void pm_runtime_drop_link(struct device *dev);
 
+/**
+ * pm_runtime_get_if_in_use - Conditionally bump up runtime PM usage counter.
+ * @dev: Target device.
+ *
+ * Increment the runtime PM usage counter of @dev if its runtime PM status is
+ * %RPM_ACTIVE and its runtime PM usage counter is greater than 0.
+ */
 static inline int pm_runtime_get_if_in_use(struct device *dev)
 {
 	return pm_runtime_get_if_active(dev, false);
 }
 
+/**
+ * pm_suspend_ignore_children - Set runtime PM behavior regarding children.
+ * @dev: Target device.
+ * @enable: Whether or not to ignore possible dependencies on children.
+ *
+ * The dependencies of @dev on its children will not be taken into account by
+ * the runtime PM framework going forward if @enable is %true, or they will
+ * be taken into account otherwise.
+ */
 static inline void pm_suspend_ignore_children(struct device *dev, bool enable)
 {
 	dev->power.ignore_children = enable;
 }
 
+/**
+ * pm_runtime_get_noresume - Bump up runtime PM usage counter of a device.
+ * @dev: Target device.
+ */
 static inline void pm_runtime_get_noresume(struct device *dev)
 {
 	atomic_inc(&dev->power.usage_count);
 }
 
+/**
+ * pm_runtime_put_noidle - Drop runtime PM usage counter of a device.
+ * @dev: Target device.
+ *
+ * Decrement the runtime PM usage counter of @dev unless it is 0 already.
+ */
 static inline void pm_runtime_put_noidle(struct device *dev)
 {
 	atomic_add_unless(&dev->power.usage_count, -1, 0);
 }
 
+/**
+ * pm_runtime_suspended - Check whether or not a device is runtime-suspended.
+ * @dev: Target device.
+ *
+ * Return %true if runtime PM is enabled for @dev and its runtime PM status is
+ * %RPM_SUSPENDED, or %false otherwise.
+ *
+ * Note that the return value of this function can only be trusted if it is
+ * called under the runtime PM lock of @dev or under conditions in which
+ * runtime PM cannot be either disabled or enabled for @dev and its runtime PM
+ * status cannot change.
+ */
 static inline bool pm_runtime_suspended(struct device *dev)
 {
 	return dev->power.runtime_status == RPM_SUSPENDED
 		&& !dev->power.disable_depth;
 }
 
+/**
+ * pm_runtime_active - Check whether or not a device is runtime-active.
+ * @dev: Target device.
+ *
+ * Return %true if runtime PM is enabled for @dev and its runtime PM status is
+ * %RPM_ACTIVE, or %false otherwise.
+ *
+ * Note that the return value of this function can only be trusted if it is
+ * called under the runtime PM lock of @dev or under conditions in which
+ * runtime PM cannot be either disabled or enabled for @dev and its runtime PM
+ * status cannot change.
+ */
 static inline bool pm_runtime_active(struct device *dev)
 {
 	return dev->power.runtime_status == RPM_ACTIVE
 		|| dev->power.disable_depth;
 }
 
+/**
+ * pm_runtime_status_suspended - Check if runtime PM status is "suspended".
+ * @dev: Target device.
+ *
+ * Return %true if the runtime PM status of @dev is %RPM_SUSPENDED, or %false
+ * otherwise, regardless of whether or not runtime PM has been enabled for @dev.
+ *
+ * Note that the return value of this function can only be trusted if it is
+ * called under the runtime PM lock of @dev or under conditions in which the
+ * runtime PM status of @dev cannot change.
+ */
 static inline bool pm_runtime_status_suspended(struct device *dev)
 {
 	return dev->power.runtime_status == RPM_SUSPENDED;
 }
 
+/**
+ * pm_runtime_enabled - Check if runtime PM is enabled.
+ * @dev: Target device.
+ *
+ * Return %true if runtime PM is enabled for @dev or %false otherwise.
+ *
+ * Note that the return value of this function can only be trusted if it is
+ * called under the runtime PM lock of @dev or under conditions in which
+ * runtime PM cannot be either disabled or enabled for @dev.
+ */
 static inline bool pm_runtime_enabled(struct device *dev)
 {
 	return !dev->power.disable_depth;
 }
 
+/**
+ * pm_runtime_has_no_callbacks - Check if runtime PM callbacks may be present.
+ * @dev: Target device.
+ *
+ * Return %true if @dev is a special device without runtime PM callbacks or
+ * %false otherwise.
+ */
 static inline bool pm_runtime_has_no_callbacks(struct device *dev)
 {
 	return dev->power.no_callbacks;
 }
 
+/**
+ * pm_runtime_mark_last_busy - Update the last access time of a device.
+ * @dev: Target device.
+ *
+ * Update the last access time of @dev used by the runtime PM autosuspend
+ * mechanism to the current time as returned by ktime_get_mono_fast_ns().
+ */
 static inline void pm_runtime_mark_last_busy(struct device *dev)
 {
 	WRITE_ONCE(dev->power.last_busy, ktime_get_mono_fast_ns());
 }
 
+/**
+ * pm_runtime_is_irq_safe - Check if runtime PM can work in interrupt context.
+ * @dev: Target device.
+ *
+ * Return %true if @dev has been marked as an "IRQ-safe" device (with respect
+ * to runtime PM), in which case its runtime PM callabcks can be expected to
+ * work correctly when invoked from interrupt handlers.
+ */
 static inline bool pm_runtime_is_irq_safe(struct device *dev)
 {
 	return dev->power.irq_safe;
@@ -191,97 +284,250 @@ static inline void pm_runtime_drop_link(
 
 #endif /* !CONFIG_PM */
 
+/**
+ * pm_runtime_idle - Conditionally set up autosuspend of a device or suspend it.
+ * @dev: Target device.
+ *
+ * Invoke the "idle check" callback of @dev and, depending on its return value,
+ * set up autosuspend of @dev or suspend it (depending on whether or not
+ * autosuspend has been enabled for it).
+ */
 static inline int pm_runtime_idle(struct device *dev)
 {
 	return __pm_runtime_idle(dev, 0);
 }
 
+/**
+ * pm_runtime_suspend - Suspend a device synchronously.
+ * @dev: Target device.
+ */
 static inline int pm_runtime_suspend(struct device *dev)
 {
 	return __pm_runtime_suspend(dev, 0);
 }
 
+/**
+ * pm_runtime_autosuspend - Set up autosuspend of a device or suspend it.
+ * @dev: Target device.
+ *
+ * Set up autosuspend of @dev or suspend it (depending on whether or not
+ * autosuspend is enabled for it) without engaging its "idle check" callback.
+ */
 static inline int pm_runtime_autosuspend(struct device *dev)
 {
 	return __pm_runtime_suspend(dev, RPM_AUTO);
 }
 
+/**
+ * pm_runtime_resume - Resume a device synchronously.
+ * @dev: Target device.
+ */
 static inline int pm_runtime_resume(struct device *dev)
 {
 	return __pm_runtime_resume(dev, 0);
 }
 
+/**
+ * pm_request_idle - Queue up "idle check" execution for a device.
+ * @dev: Target device.
+ *
+ * Queue up a work item to run an equivalent of pm_runtime_idle() for @dev
+ * asynchronously.
+ */
 static inline int pm_request_idle(struct device *dev)
 {
 	return __pm_runtime_idle(dev, RPM_ASYNC);
 }
 
+/**
+ * pm_request_resume - Queue up runtime-resume of a device.
+ * @dev: Target device.
+ */
 static inline int pm_request_resume(struct device *dev)
 {
 	return __pm_runtime_resume(dev, RPM_ASYNC);
 }
 
+/**
+ * pm_request_autosuspend - Queue up autosuspend of a device.
+ * @dev: Target device.
+ *
+ * Queue up a work item to run an equivalent pm_runtime_autosuspend() for @dev
+ * asynchronously.
+ */
 static inline int pm_request_autosuspend(struct device *dev)
 {
 	return __pm_runtime_suspend(dev, RPM_ASYNC | RPM_AUTO);
 }
 
+/**
+ * pm_runtime_get - Bump up usage counter and queue up resume of a device.
+ * @dev: Target device.
+ *
+ * Bump up the runtime PM usage counter of @dev and queue up a work item to
+ * carry out runtime-resume of it.
+ */
 static inline int pm_runtime_get(struct device *dev)
 {
 	return __pm_runtime_resume(dev, RPM_GET_PUT | RPM_ASYNC);
 }
 
+/**
+ * pm_runtime_get_sync - Bump up usage counter of a device and resume it.
+ * @dev: Target device.
+ *
+ * Bump up the runtime PM usage counter of @dev and carry out runtime-resume of
+ * it synchronously.
+ *
+ * The possible return values of this function are the same as for
+ * pm_runtime_resume() and the runtime PM usage counter of @dev remains
+ * incremented in all cases, even if it returns an error code.
+ */
 static inline int pm_runtime_get_sync(struct device *dev)
 {
 	return __pm_runtime_resume(dev, RPM_GET_PUT);
 }
 
+/**
+ * pm_runtime_put - Drop device usage counter and queue up "idle check" if 0.
+ * @dev: Target device.
+ *
+ * Decrement the runtime PM usage counter of @dev and if it turns out to be
+ * equal to 0, queue up a work item for @dev like in pm_request_idle().
+ */
 static inline int pm_runtime_put(struct device *dev)
 {
 	return __pm_runtime_idle(dev, RPM_GET_PUT | RPM_ASYNC);
 }
 
+/**
+ * pm_runtime_put_autosuspend - Drop device usage counter and queue autosuspend if 0.
+ * @dev: Target device.
+ *
+ * Decrement the runtime PM usage counter of @dev and if it turns out to be
+ * equal to 0, queue up a work item for @dev like in pm_request_autosuspend().
+ */
 static inline int pm_runtime_put_autosuspend(struct device *dev)
 {
 	return __pm_runtime_suspend(dev,
 	    RPM_GET_PUT | RPM_ASYNC | RPM_AUTO);
 }
 
+/**
+ * pm_runtime_put_sync - Drop device usage counter and run "idle check" if 0.
+ * @dev: Target device.
+ *
+ * Decrement the runtime PM usage counter of @dev and if it turns out to be
+ * equal to 0, invoke the "idle check" callback of @dev and, depending on its
+ * return value, set up autosuspend of @dev or suspend it (depending on whether
+ * or not autosuspend has been enabled for it).
+ *
+ * The possible return values of this function are the same as for
+ * pm_runtime_idle() and the runtime PM usage counter of @dev remains
+ * decremented in all cases, even if it returns an error code.
+ */
 static inline int pm_runtime_put_sync(struct device *dev)
 {
 	return __pm_runtime_idle(dev, RPM_GET_PUT);
 }
 
+/**
+ * pm_runtime_put_sync_suspend - Drop device usage counter and suspend if 0.
+ * @dev: Target device.
+ *
+ * Decrement the runtime PM usage counter of @dev and if it turns out to be
+ * equal to 0, carry out runtime-suspend of @dev synchronously.
+ *
+ * The possible return values of this function are the same as for
+ * pm_runtime_suspend() and the runtime PM usage counter of @dev remains
+ * decremented in all cases, even if it returns an error code.
+ */
 static inline int pm_runtime_put_sync_suspend(struct device *dev)
 {
 	return __pm_runtime_suspend(dev, RPM_GET_PUT);
 }
 
+/**
+ * pm_runtime_put_sync_autosuspend - Drop device usage counter and autosuspend if 0.
+ * @dev: Target device.
+ *
+ * Decrement the runtime PM usage counter of @dev and if it turns out to be
+ * equal to 0, set up autosuspend of @dev or suspend it synchronously (depending
+ * on whether or not autosuspend has been enabled for it).
+ *
+ * The possible return values of this function are the same as for
+ * pm_runtime_autosuspend() and the runtime PM usage counter of @dev remains
+ * decremented in all cases, even if it returns an error code.
+ */
 static inline int pm_runtime_put_sync_autosuspend(struct device *dev)
 {
 	return __pm_runtime_suspend(dev, RPM_GET_PUT | RPM_AUTO);
 }
 
+/**
+ * pm_runtime_set_active - Set runtime PM status to "active".
+ * @dev: Target device.
+ *
+ * Set the runtime PM status of @dev to %RPM_ACTIVE and ensure that dependencies
+ * of it will be taken into account.
+ *
+ * It is not valid to call this function for devices with runtime PM enabled.
+ */
 static inline int pm_runtime_set_active(struct device *dev)
 {
 	return __pm_runtime_set_status(dev, RPM_ACTIVE);
 }
 
+/**
+ * pm_runtime_set_suspended - Set runtime PM status to "active".
+ * @dev: Target device.
+ *
+ * Set the runtime PM status of @dev to %RPM_SUSPENDED and ensure that
+ * dependencies of it will be taken into account.
+ *
+ * It is not valid to call this function for devices with runtime PM enabled.
+ */
 static inline int pm_runtime_set_suspended(struct device *dev)
 {
 	return __pm_runtime_set_status(dev, RPM_SUSPENDED);
 }
 
+/**
+ * pm_runtime_disable - Disable runtime PM for a device.
+ * @dev: Target device.
+ *
+ * Prevent the runtime PM framework from working with @dev (by incrementing its
+ * "blocking" counter).
+ *
+ * For each invocation of this function for @dev there must be a matching
+ * pm_runtime_enable() call in order for runtime PM to be enabled for it.
+ */
 static inline void pm_runtime_disable(struct device *dev)
 {
 	__pm_runtime_disable(dev, true);
 }
 
+/**
+ * pm_runtime_use_autosuspend - Allow autosuspend to be used for a device.
+ * @dev: Target device.
+ *
+ * Allow the runtime PM autosuspend mechanism to be used for @dev whenever
+ * requested (or "autosuspend" will be handled as direct runtime-suspend for
+ * it).
+ */
 static inline void pm_runtime_use_autosuspend(struct device *dev)
 {
 	__pm_runtime_use_autosuspend(dev, true);
 }
 
+/**
+ * pm_runtime_dont_use_autosuspend - Prevent autosuspend from being used.
+ * @dev: Target device.
+ *
+ * Prevent the runtime PM autosuspend mechanism from being used for @dev which
+ * means that "autosuspend" will be handled as direct runtime-suspend for it
+ * going forward.
+ */
 static inline void pm_runtime_dont_use_autosuspend(struct device *dev)
 {
 	__pm_runtime_use_autosuspend(dev, false);



