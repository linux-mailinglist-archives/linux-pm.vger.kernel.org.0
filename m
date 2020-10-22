Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9EE2961C1
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 17:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368660AbgJVPi2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Oct 2020 11:38:28 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:60762 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S368664AbgJVPiZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Oct 2020 11:38:25 -0400
Received: from 89-64-87-167.dynamic.chello.pl (89.64.87.167) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.491)
 id 407eec497ad3e201; Thu, 22 Oct 2020 17:38:23 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Saravana Kannan <saravanak@google.com>,
        Xiang Chen <chenxiang66@hisilicon.com>
Subject: [PATCH update 3/3] PM: runtime: Resume the device earlier in __device_release_driver()
Date:   Thu, 22 Oct 2020 17:38:22 +0200
Message-ID: <7787143.pm0zn309lf@kreacher>
In-Reply-To: <1708806.S9fAqql2gf@kreacher>
References: <6543936.FbWAdBN1tG@kreacher> <1708806.S9fAqql2gf@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since the device is resumed from runtime-suspend in
__device_release_driver() anyway, it is better to do that before
looking for busy managed device links from it to consumers, because
if there are any, device_links_unbind_consumers() will be called
and it will cause the consumer devices' drivers to unbind, so the
consumer devices will be runtime-resumed.  In turn, resuming each
consumer device will cause the supplier to be resumed and when the
runtime PM references from the given consumer to it are dropped, it
may be suspended.  Then, the runtime-resume of the next consumer
will cause the supplier to resume again and so on.

Update the code accordingly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Fixes: 9ed9895370ae ("driver core: Functional dependencies tracking support")
Cc: All applicable <stable@vger.kernel.org> # All applicable
---

This update adds a missing pm_runtime_put() before a return statement.

Thanks!

---
 drivers/base/dd.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/base/dd.c
===================================================================
--- linux-pm.orig/drivers/base/dd.c
+++ linux-pm/drivers/base/dd.c
@@ -1117,6 +1117,8 @@ static void __device_release_driver(stru
 
 	drv = dev->driver;
 	if (drv) {
+		pm_runtime_get_sync(dev);
+
 		while (device_links_busy(dev)) {
 			__device_driver_unlock(dev, parent);
 
@@ -1128,12 +1130,12 @@ static void __device_release_driver(stru
 			 * have released the driver successfully while this one
 			 * was waiting, so check for that.
 			 */
-			if (dev->driver != drv)
+			if (dev->driver != drv) {
+				pm_runtime_put(dev);
 				return;
+			}
 		}
 
-		pm_runtime_get_sync(dev);
-
 		driver_sysfs_remove(dev);
 
 		if (dev->bus)



