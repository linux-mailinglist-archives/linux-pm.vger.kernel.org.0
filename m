Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4132F8472
	for <lists+linux-pm@lfdr.de>; Fri, 15 Jan 2021 19:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbhAOSbe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Jan 2021 13:31:34 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:59974 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbhAOSbe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jan 2021 13:31:34 -0500
Received: from 89-64-81-100.dynamic.chello.pl (89.64.81.100) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.537)
 id 3e720a1ca388cf11; Fri, 15 Jan 2021 19:30:51 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH v2] driver core: Extend device_is_dependent()
Date:   Fri, 15 Jan 2021 19:30:51 +0100
Message-ID: <17705994.d592GUb2YH@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If the device passed as the target (second argument) to
device_is_dependent() is not completely registered (that is, it has
been initialized, but not added yet), but the parent pointer of it
is set, it may be missing from the list of the parent's children
and device_for_each_child() called by device_is_dependent() cannot
be relied on to catch that dependency.

For this reason, modify device_is_dependent() to check the ancestors
of the target device by following its parent pointer in addition to
the device_for_each_child() walk.

Fixes: 9ed9895370ae ("driver core: Functional dependencies tracking support")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reported-by: Stephan Gerhold <stephan@gerhold.net>
Tested-by: Stephan Gerhold <stephan@gerhold.net>
---

-> v2:
   * Improve the changelog.
   * Add a comment to explain the reason for the extra check.
   * Add tags.

   No code changes.

---
 drivers/base/core.c |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/base/core.c
===================================================================
--- linux-pm.orig/drivers/base/core.c
+++ linux-pm/drivers/base/core.c
@@ -208,6 +208,16 @@ int device_links_read_lock_held(void)
 #endif
 #endif /* !CONFIG_SRCU */
 
+static bool device_is_ancestor(struct device *dev, struct device *target)
+{
+	while (target->parent) {
+		target = target->parent;
+		if (dev == target)
+			return true;
+	}
+	return false;
+}
+
 /**
  * device_is_dependent - Check if one device depends on another one
  * @dev: Device to check dependencies for.
@@ -221,7 +231,12 @@ int device_is_dependent(struct device *d
 	struct device_link *link;
 	int ret;
 
-	if (dev == target)
+	/*
+	 * The "ancestors" check is needed to catch the case when the target
+	 * device has not been completely initialized yet and it is still
+	 * missing from the list of children of its parent device.
+	 */
+	if (dev == target || device_is_ancestor(dev, target))
 		return 1;
 
 	ret = device_for_each_child(dev, target, device_is_dependent);



