Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914261E6458
	for <lists+linux-pm@lfdr.de>; Thu, 28 May 2020 16:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbgE1OpT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 May 2020 10:45:19 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:51034 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbgE1OpR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 May 2020 10:45:17 -0400
Received: from 89-64-85-246.dynamic.chello.pl (89.64.85.246) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 1520e6f1e392a6c6; Thu, 28 May 2020 16:45:15 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] PM: runtime: Replace pm_runtime_callbacks_present()
Date:   Thu, 28 May 2020 16:45:14 +0200
Message-ID: <2735489.s4WY8YHBoM@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The name of pm_runtime_callbacks_present() is confusing, because
it suggests that the device has PM-runtime callbacks if 'true' is
returned by that function, but in fact that may not be the case,
so replace it with pm_runtime_has_no_callbacks() which is not
ambiguous.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/sysfs.c |    4 ++--
 include/linux/pm_runtime.h |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

Index: linux-pm/include/linux/pm_runtime.h
===================================================================
--- linux-pm.orig/include/linux/pm_runtime.h
+++ linux-pm/include/linux/pm_runtime.h
@@ -102,9 +102,9 @@ static inline bool pm_runtime_enabled(st
 	return !dev->power.disable_depth;
 }
 
-static inline bool pm_runtime_callbacks_present(struct device *dev)
+static inline bool pm_runtime_has_no_callbacks(struct device *dev)
 {
-	return !dev->power.no_callbacks;
+	return dev->power.no_callbacks;
 }
 
 static inline void pm_runtime_mark_last_busy(struct device *dev)
Index: linux-pm/drivers/base/power/sysfs.c
===================================================================
--- linux-pm.orig/drivers/base/power/sysfs.c
+++ linux-pm/drivers/base/power/sysfs.c
@@ -666,7 +666,7 @@ int dpm_sysfs_add(struct device *dev)
 	if (rc)
 		return rc;
 
-	if (pm_runtime_callbacks_present(dev)) {
+	if (!pm_runtime_has_no_callbacks(dev)) {
 		rc = sysfs_merge_group(&dev->kobj, &pm_runtime_attr_group);
 		if (rc)
 			goto err_out;
@@ -709,7 +709,7 @@ int dpm_sysfs_change_owner(struct device
 	if (rc)
 		return rc;
 
-	if (pm_runtime_callbacks_present(dev)) {
+	if (!pm_runtime_has_no_callbacks(dev)) {
 		rc = sysfs_group_change_owner(
 			&dev->kobj, &pm_runtime_attr_group, kuid, kgid);
 		if (rc)



