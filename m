Return-Path: <linux-pm+bounces-28857-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48152ADB968
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 21:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB09E189010D
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 19:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D88D288C09;
	Mon, 16 Jun 2025 19:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Pi5XqV9R"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22DD1E9B29;
	Mon, 16 Jun 2025 19:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750101488; cv=none; b=hi5QvPg5cvpXduqOTU91PdTXvSIXHuQxxMnC80kbChsJgjwYvAWvLeD9zIKh3awHtiZXTmGr3DBQ5036+0TkTmCvs3zwr6V80ExAXGMJsbDy00ZriNq5e+GJWc9Xncack28KxKYnmlc9ejv1tb+5FUe0NaXnxVrq+culoXb2UQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750101488; c=relaxed/simple;
	bh=XGD4MtlMgY10wj/nEJyvE/7E+QKvtOTwmAU3PEog66M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QoxFI7aqj7wAT6gMNCgBeyNVATtLPeTcv+J2PeyyRTl9rvhPEVHnVLYAh28xxVMizNsRyLJePybmdXpSaYUS5wS53GTTiFZ9/Y+MZu44YB8Onta6yRGARbEmIfAZriHChgVpbOxAqMynRdpEJaq5/yCllyC0a/K81xNv8JhmKYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Pi5XqV9R; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 51DE1666F1B;
	Mon, 16 Jun 2025 20:16:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1750097781;
	bh=XGD4MtlMgY10wj/nEJyvE/7E+QKvtOTwmAU3PEog66M=;
	h=From:Subject:Date;
	b=Pi5XqV9RUgm67n4bbaRjbqLKpWZc1gJZ8n0sNdlcFupHwE3ZPWwySSJ3M9fVz5fwS
	 FM4s7chp4IO8xwvqPs1CiWtKjF0kPzzkpsGtfz/y28Hy4EgHu6bicSwA3iINxybopt
	 Kd2hQs5C5svA1R1HJWupwydbVL/IwGEzsWvvWDWNpVPuUaU/FZvRQfZQD9F8TbIW6a
	 k6WwXEglYjLzTU3i294043fLXzmMfRT58N1v9XqGpONbLUCvX7De4m3KhkIGo0QDE9
	 TUg0ZdxIF3AZEax2t5QvQflzzwNflUQGe6sLp3x6/FcN1z+XxMgi5bMnezLsB7lubp
	 5wIj5emQB8lbg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Saravana Kannan <saravanak@google.com>
Subject:
 [PATCH v1] driver core: Add device_link_test() for testing device link flags
Date: Mon, 16 Jun 2025 20:16:21 +0200
Message-ID: <2793309.mvXUDI8C0e@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 5.63.189.50
X-CLIENT-HOSTNAME: 5.63.189.50
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: dmFkZTF/I4x6zZceSr9PpSvCQ9iNejtSEb4amLQZYAOrXMGCwU3OPukZULDXLJRB2Ru/igCon2RjW5s/5tXTxXUbO4u2LLgc7+RQyZFuID53nbnaLXshf7Pa7GSn7fhNSfsecRRfQR9H6mHErZLFTVqaoS6sdnnM8kaYymqvDuhRZnasowwmF/Rnd/HfXRMw8GQG4zUE946pZo1MLH0KQfwO9rAhzoVDoLNDvD5qlqXn+FdCjRcAcD9lZ1EYhHFXyhaXw2MYRV4OXUQwwmf4uDzEcvT1EWQxCzyuh/qXTaAk0v6gHJ0+W6gmwB5Mbo1ayn+BI43KxwcVPBhZWO9lE4ef5c1/euQ4KaRNQHGdVhPX8mDapgqVfveoUpoWLAopU18F9LCEEy6phOZuKEfhBW29Y1nQAThs1vm2F8TcE44ATqSbMbCk0lnGNHMAt32lMaQpprHHGkbz/KuWZlG16cwKS//pLy7mV5/s9Yve+wzMMYYFE2NHYyjBobBn8xlmtds6SZ6ULBNtM0fdg1oolyGnBAyMUAw/YfwbOut0/zLz0EOTrfuPS+K1HxlKP9qtYQerFpUrn1aQLp2GHNBv4PAjtRyy7lE8xCEtE69CD2FEqG4+bI6VYPAZHAHfooHQu0aeqv4jdBQojTGDQpcXTMx6iHgYx9HxpLCODcQOvnCNANgaMw
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

To avoid coding mistakes like the one fixed by commit 3860cbe23963 ("PM:
sleep: Fix bit masking operation"), introduce device_link_test() for
testing device link flags and use it where applicable.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/core.c          |   73 +++++++++++++++++++++----------------------
 drivers/base/power/main.c    |    2 -
 drivers/base/power/runtime.c |    6 +--
 include/linux/device.h       |    5 ++
 4 files changed, 45 insertions(+), 41 deletions(-)

--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -460,9 +460,9 @@
 	struct device_link *link = to_devlink(dev);
 	const char *output;
 
-	if (link->flags & DL_FLAG_AUTOREMOVE_SUPPLIER)
+	if (device_link_test(link, DL_FLAG_AUTOREMOVE_SUPPLIER))
 		output = "supplier unbind";
-	else if (link->flags & DL_FLAG_AUTOREMOVE_CONSUMER)
+	else if (device_link_test(link, DL_FLAG_AUTOREMOVE_CONSUMER))
 		output = "consumer unbind";
 	else
 		output = "never";
@@ -476,7 +476,7 @@
 {
 	struct device_link *link = to_devlink(dev);
 
-	return sysfs_emit(buf, "%d\n", !!(link->flags & DL_FLAG_PM_RUNTIME));
+	return sysfs_emit(buf, "%d\n", device_link_test(link, DL_FLAG_PM_RUNTIME));
 }
 static DEVICE_ATTR_RO(runtime_pm);
 
@@ -485,8 +485,7 @@
 {
 	struct device_link *link = to_devlink(dev);
 
-	return sysfs_emit(buf, "%d\n",
-			  !!(link->flags & DL_FLAG_SYNC_STATE_ONLY));
+	return sysfs_emit(buf, "%d\n", device_link_test(link, DL_FLAG_SYNC_STATE_ONLY));
 }
 static DEVICE_ATTR_RO(sync_state_only);
 
@@ -792,12 +791,12 @@
 		if (link->consumer != consumer)
 			continue;
 
-		if (link->flags & DL_FLAG_INFERRED &&
+		if (device_link_test(link, DL_FLAG_INFERRED) &&
 		    !(flags & DL_FLAG_INFERRED))
 			link->flags &= ~DL_FLAG_INFERRED;
 
 		if (flags & DL_FLAG_PM_RUNTIME) {
-			if (!(link->flags & DL_FLAG_PM_RUNTIME)) {
+			if (!device_link_test(link, DL_FLAG_PM_RUNTIME)) {
 				pm_runtime_new_link(consumer);
 				link->flags |= DL_FLAG_PM_RUNTIME;
 			}
@@ -807,8 +806,8 @@
 
 		if (flags & DL_FLAG_STATELESS) {
 			kref_get(&link->kref);
-			if (link->flags & DL_FLAG_SYNC_STATE_ONLY &&
-			    !(link->flags & DL_FLAG_STATELESS)) {
+			if (device_link_test(link, DL_FLAG_SYNC_STATE_ONLY) &&
+			    !device_link_test(link, DL_FLAG_STATELESS)) {
 				link->flags |= DL_FLAG_STATELESS;
 				goto reorder;
 			} else {
@@ -823,7 +822,7 @@
 		 * update the existing link to stay around longer.
 		 */
 		if (flags & DL_FLAG_AUTOREMOVE_SUPPLIER) {
-			if (link->flags & DL_FLAG_AUTOREMOVE_CONSUMER) {
+			if (device_link_test(link, DL_FLAG_AUTOREMOVE_CONSUMER)) {
 				link->flags &= ~DL_FLAG_AUTOREMOVE_CONSUMER;
 				link->flags |= DL_FLAG_AUTOREMOVE_SUPPLIER;
 			}
@@ -831,12 +830,12 @@
 			link->flags &= ~(DL_FLAG_AUTOREMOVE_CONSUMER |
 					 DL_FLAG_AUTOREMOVE_SUPPLIER);
 		}
-		if (!(link->flags & DL_FLAG_MANAGED)) {
+		if (!device_link_test(link, DL_FLAG_MANAGED)) {
 			kref_get(&link->kref);
 			link->flags |= DL_FLAG_MANAGED;
 			device_link_init_status(link, consumer, supplier);
 		}
-		if (link->flags & DL_FLAG_SYNC_STATE_ONLY &&
+		if (device_link_test(link, DL_FLAG_SYNC_STATE_ONLY) &&
 		    !(flags & DL_FLAG_SYNC_STATE_ONLY)) {
 			link->flags &= ~DL_FLAG_SYNC_STATE_ONLY;
 			goto reorder;
@@ -940,7 +939,7 @@
 
 static void device_link_put_kref(struct device_link *link)
 {
-	if (link->flags & DL_FLAG_STATELESS)
+	if (device_link_test(link, DL_FLAG_STATELESS))
 		kref_put(&link->kref, __device_link_del);
 	else if (!device_is_registered(link->consumer))
 		__device_link_del(&link->kref);
@@ -1004,7 +1003,7 @@
 		if (link->supplier->links.status == DL_DEV_DRIVER_BOUND) {
 			WRITE_ONCE(link->status, DL_STATE_AVAILABLE);
 		} else {
-			WARN_ON(!(link->flags & DL_FLAG_SYNC_STATE_ONLY));
+			WARN_ON(!device_link_test(link, DL_FLAG_SYNC_STATE_ONLY));
 			WRITE_ONCE(link->status, DL_STATE_DORMANT);
 		}
 	}
@@ -1072,14 +1071,14 @@
 	device_links_write_lock();
 
 	list_for_each_entry(link, &dev->links.suppliers, c_node) {
-		if (!(link->flags & DL_FLAG_MANAGED))
+		if (!device_link_test(link, DL_FLAG_MANAGED))
 			continue;
 
 		if (link->status != DL_STATE_AVAILABLE &&
-		    !(link->flags & DL_FLAG_SYNC_STATE_ONLY)) {
+		    !device_link_test(link, DL_FLAG_SYNC_STATE_ONLY)) {
 
 			if (dev_is_best_effort(dev) &&
-			    link->flags & DL_FLAG_INFERRED &&
+			    device_link_test(link, DL_FLAG_INFERRED) &&
 			    !link->supplier->can_match) {
 				ret = -EAGAIN;
 				continue;
@@ -1128,7 +1127,7 @@
 		return;
 
 	list_for_each_entry(link, &dev->links.consumers, s_node) {
-		if (!(link->flags & DL_FLAG_MANAGED))
+		if (!device_link_test(link, DL_FLAG_MANAGED))
 			continue;
 		if (link->status != DL_STATE_ACTIVE)
 			return;
@@ -1268,7 +1267,7 @@
 	device_links_write_lock();
 
 	list_for_each_entry_safe(link, ln, &dev->links.suppliers, c_node) {
-		if (!(link->flags & DL_FLAG_MANAGED))
+		if (!device_link_test(link, DL_FLAG_MANAGED))
 			continue;
 
 		if (link->status != DL_STATE_AVAILABLE) {
@@ -1329,7 +1328,7 @@
 	device_links_write_lock();
 
 	list_for_each_entry(link, &dev->links.consumers, s_node) {
-		if (!(link->flags & DL_FLAG_MANAGED))
+		if (!device_link_test(link, DL_FLAG_MANAGED))
 			continue;
 
 		/*
@@ -1345,7 +1344,7 @@
 		WARN_ON(link->status != DL_STATE_DORMANT);
 		WRITE_ONCE(link->status, DL_STATE_AVAILABLE);
 
-		if (link->flags & DL_FLAG_AUTOPROBE_CONSUMER)
+		if (device_link_test(link, DL_FLAG_AUTOPROBE_CONSUMER))
 			driver_deferred_probe_add(link->consumer);
 	}
 
@@ -1357,11 +1356,11 @@
 	list_for_each_entry_safe(link, ln, &dev->links.suppliers, c_node) {
 		struct device *supplier;
 
-		if (!(link->flags & DL_FLAG_MANAGED))
+		if (!device_link_test(link, DL_FLAG_MANAGED))
 			continue;
 
 		supplier = link->supplier;
-		if (link->flags & DL_FLAG_SYNC_STATE_ONLY) {
+		if (device_link_test(link, DL_FLAG_SYNC_STATE_ONLY)) {
 			/*
 			 * When DL_FLAG_SYNC_STATE_ONLY is set, it means no
 			 * other DL_MANAGED_LINK_FLAGS have been set. So, it's
@@ -1369,7 +1368,7 @@
 			 */
 			device_link_drop_managed(link);
 		} else if (dev_is_best_effort(dev) &&
-			   link->flags & DL_FLAG_INFERRED &&
+			   device_link_test(link, DL_FLAG_INFERRED) &&
 			   link->status != DL_STATE_CONSUMER_PROBE &&
 			   !link->supplier->can_match) {
 			/*
@@ -1421,10 +1420,10 @@
 	struct device_link *link, *ln;
 
 	list_for_each_entry_safe_reverse(link, ln, &dev->links.suppliers, c_node) {
-		if (!(link->flags & DL_FLAG_MANAGED))
+		if (!device_link_test(link, DL_FLAG_MANAGED))
 			continue;
 
-		if (link->flags & DL_FLAG_AUTOREMOVE_CONSUMER) {
+		if (device_link_test(link, DL_FLAG_AUTOREMOVE_CONSUMER)) {
 			device_link_drop_managed(link);
 			continue;
 		}
@@ -1436,7 +1435,7 @@
 		if (link->supplier->links.status == DL_DEV_DRIVER_BOUND) {
 			WRITE_ONCE(link->status, DL_STATE_AVAILABLE);
 		} else {
-			WARN_ON(!(link->flags & DL_FLAG_SYNC_STATE_ONLY));
+			WARN_ON(!device_link_test(link, DL_FLAG_SYNC_STATE_ONLY));
 			WRITE_ONCE(link->status, DL_STATE_DORMANT);
 		}
 	}
@@ -1461,7 +1460,7 @@
 	device_links_write_lock();
 
 	list_for_each_entry(link, &dev->links.consumers, s_node) {
-		if (!(link->flags & DL_FLAG_MANAGED))
+		if (!device_link_test(link, DL_FLAG_MANAGED))
 			continue;
 
 		/*
@@ -1498,10 +1497,10 @@
 	device_links_write_lock();
 
 	list_for_each_entry_safe(link, ln, &dev->links.consumers, s_node) {
-		if (!(link->flags & DL_FLAG_MANAGED))
+		if (!device_link_test(link, DL_FLAG_MANAGED))
 			continue;
 
-		WARN_ON(link->flags & DL_FLAG_AUTOREMOVE_CONSUMER);
+		WARN_ON(device_link_test(link, DL_FLAG_AUTOREMOVE_CONSUMER));
 		WARN_ON(link->status != DL_STATE_SUPPLIER_UNBIND);
 
 		/*
@@ -1510,7 +1509,7 @@
 		 * has moved to DL_STATE_SUPPLIER_UNBIND.
 		 */
 		if (link->status == DL_STATE_SUPPLIER_UNBIND &&
-		    link->flags & DL_FLAG_AUTOREMOVE_SUPPLIER)
+		    device_link_test(link, DL_FLAG_AUTOREMOVE_SUPPLIER))
 			device_link_drop_managed(link);
 
 		WRITE_ONCE(link->status, DL_STATE_DORMANT);
@@ -1544,7 +1543,7 @@
 	device_links_write_lock();
 
 	list_for_each_entry(link, &dev->links.consumers, s_node) {
-		if (!(link->flags & DL_FLAG_MANAGED))
+		if (!device_link_test(link, DL_FLAG_MANAGED))
 			continue;
 
 		if (link->status == DL_STATE_CONSUMER_PROBE
@@ -1586,8 +1585,8 @@
 	list_for_each_entry(link, &dev->links.consumers, s_node) {
 		enum device_link_state status;
 
-		if (!(link->flags & DL_FLAG_MANAGED) ||
-		    link->flags & DL_FLAG_SYNC_STATE_ONLY)
+		if (!device_link_test(link, DL_FLAG_MANAGED) ||
+		    device_link_test(link, DL_FLAG_SYNC_STATE_ONLY))
 			continue;
 
 		status = link->status;
@@ -1743,7 +1742,7 @@
 
 static void fw_devlink_relax_link(struct device_link *link)
 {
-	if (!(link->flags & DL_FLAG_INFERRED))
+	if (!device_link_test(link, DL_FLAG_INFERRED))
 		return;
 
 	if (device_link_flag_is_sync_state_only(link->flags))
@@ -1779,7 +1778,7 @@
 	struct device_link *link = to_devlink(dev);
 	struct device *sup = link->supplier;
 
-	if (!(link->flags & DL_FLAG_MANAGED) ||
+	if (!device_link_test(link, DL_FLAG_MANAGED) ||
 	    link->status == DL_STATE_ACTIVE || sup->state_synced ||
 	    !dev_has_sync_state(sup))
 		return 0;
@@ -2063,7 +2062,7 @@
 		 * such due to a cycle.
 		 */
 		if (device_link_flag_is_sync_state_only(dev_link->flags) &&
-		    !(dev_link->flags & DL_FLAG_CYCLE))
+		    !device_link_test(dev_link, DL_FLAG_CYCLE))
 			continue;
 
 		if (__fw_devlink_relax_cycles(con_handle,
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1998,7 +1998,7 @@
 	idx = device_links_read_lock();
 
 	list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node) {
-		if (!(link->flags & DL_FLAG_PM_RUNTIME))
+		if (!device_link_test(link, DL_FLAG_PM_RUNTIME))
 			continue;
 
 		if (!dev_pm_smart_suspend(link->supplier) &&
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -290,7 +290,7 @@
 				device_links_read_lock_held()) {
 		int retval;
 
-		if (!(link->flags & DL_FLAG_PM_RUNTIME))
+		if (!device_link_test(link, DL_FLAG_PM_RUNTIME))
 			continue;
 
 		retval = pm_runtime_get_sync(link->supplier);
@@ -1879,7 +1879,7 @@
 
 	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
 				device_links_read_lock_held())
-		if (link->flags & DL_FLAG_PM_RUNTIME) {
+		if (device_link_test(link, DL_FLAG_PM_RUNTIME)) {
 			link->supplier_preactivated = true;
 			pm_runtime_get_sync(link->supplier);
 		}
@@ -1933,7 +1933,7 @@
  */
 void pm_runtime_drop_link(struct device_link *link)
 {
-	if (!(link->flags & DL_FLAG_PM_RUNTIME))
+	if (!device_link_test(link, DL_FLAG_PM_RUNTIME))
 		return;
 
 	pm_runtime_drop_link_count(link->consumer);
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1162,6 +1162,11 @@
 void device_links_supplier_sync_state_resume(void);
 void device_link_wait_removal(void);
 
+static inline bool device_link_test(const struct device_link *link, u32 flags)
+{
+	return !!(link->flags & flags);
+}
+
 /* Create alias, so I can be autoloaded. */
 #define MODULE_ALIAS_CHARDEV(major,minor) \
 	MODULE_ALIAS("char-major-" __stringify(major) "-" __stringify(minor))




