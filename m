Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286CC2349D2
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jul 2020 19:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729944AbgGaREO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Jul 2020 13:04:14 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:51998 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728958AbgGaREO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jul 2020 13:04:14 -0400
Received: from 89-64-88-186.dynamic.chello.pl (89.64.88.186) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id ef737f88fc7984ef; Fri, 31 Jul 2020 19:04:12 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH] PM: runtime: Improve kerneldoc of pm_runtime_get_if_active()
Date:   Fri, 31 Jul 2020 19:04:11 +0200
Message-ID: <3777183.7rZhd9hnLu@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The kerneldoc comment of pm_runtime_get_if_active() doesn't list the
second argument of the function properly, so fix that and while at it
clarify that comment somewhat and add some markup to it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/runtime.c |   26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

Index: linux-pm/drivers/base/power/runtime.c
===================================================================
--- linux-pm.orig/drivers/base/power/runtime.c
+++ linux-pm/drivers/base/power/runtime.c
@@ -1085,24 +1085,26 @@ int __pm_runtime_resume(struct device *d
 EXPORT_SYMBOL_GPL(__pm_runtime_resume);
 
 /**
- * pm_runtime_get_if_active - Conditionally bump up the device's usage counter.
+ * pm_runtime_get_if_active - Conditionally bump up device usage counter.
  * @dev: Device to handle.
+ * @ign_usage_count: Whether or not to look at the current usage counter value.
  *
- * Return -EINVAL if runtime PM is disabled for the device.
+ * Return -EINVAL if runtime PM is disabled for @dev.
  *
- * Otherwise, if the device's runtime PM status is RPM_ACTIVE and either
- * ign_usage_count is true or the device's usage_count is non-zero, increment
- * the counter and return 1. Otherwise return 0 without changing the counter.
+ * Otherwise, if the runtime PM status of @dev is %RPM_ACTIVE and either
+ * @ign_usage_count is %true or the runtime PM usage counter of @dev is not
+ * zero, increment the usage counter of @dev and return 1. Otherwise, return 0
+ * without changing the usage counter.
  *
- * If ign_usage_count is true, the function can be used to prevent suspending
- * the device when its runtime PM status is RPM_ACTIVE.
+ * If @ign_usage_count is %true, this function can be used to prevent suspending
+ * the device when its runtime PM status is %RPM_ACTIVE.
  *
- * If ign_usage_count is false, the function can be used to prevent suspending
- * the device when both its runtime PM status is RPM_ACTIVE and its usage_count
- * is non-zero.
+ * If @ign_usage_count is %false, this function can be used to prevent
+ * suspending the device when both its runtime PM status is %RPM_ACTIVE and its
+ * runtime PM usage counter is not zero.
  *
- * The caller is resposible for putting the device's usage count when ther
- * return value is greater than zero.
+ * The caller is resposible for decrementing the runtime PM usage counter of
+ * @dev after this function has returned a positive value for it.
  */
 int pm_runtime_get_if_active(struct device *dev, bool ign_usage_count)
 {



