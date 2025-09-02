Return-Path: <linux-pm+bounces-33646-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 534FDB4057C
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 15:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 193AA3AC3CA
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 13:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D751931B13A;
	Tue,  2 Sep 2025 13:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fytxUB97"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD33430496B;
	Tue,  2 Sep 2025 13:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756820734; cv=none; b=e9+lcxHXCwbErWf0P1MvNPdULQ9GzWko3i6J1DXUx+dGtqNlXuStlnZMeyZMxFE0LzKx+yfPA71UU4rzlRJbdqZdQrXtfBsWySDVAaVOPWk+MPnLpbCWd5C9JbFasJ09O1x0nd0GqmWgsrif1mqGome3h5VKWuQN4kXL9WBmNOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756820734; c=relaxed/simple;
	bh=WhUCck38woFRSX+t14QPpBmFmTWLoKWxKgmD29RbU2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cdF5+WxQCnUR7B5P4Qjp6IWiso0AQo7c19WYbbekaYV1FexOXxyioBh9+5Ncm6jfSs7rzsQPCa/tpTl/FKKOrmlqQWOmwezL2b4QQgpKr5DIvpXv0VeTgKgXAtxwEcbyQxz6FmbxEcCP1JftsteYuHf45+edquuo1GvOuwXe4Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fytxUB97; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C816C4CEF4;
	Tue,  2 Sep 2025 13:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756820734;
	bh=WhUCck38woFRSX+t14QPpBmFmTWLoKWxKgmD29RbU2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fytxUB97SJZVHYz23yFigJ5IZXcddMgJS70zYUwHnAIesVwl4UhfVvMbUy5NF+lQH
	 UdQIAIr9FXRsFK8cc8BttQoSN9SjjAk05DcEoLaWPLqEHMcf4dsWWZtn0C+a1Ihj67
	 OtAslUnk4a+7CcBvomEDmBbJ1OD6w4stx0/uYyZjcEz/zF1kNXBR8O4hQ3WkSxs/Ps
	 xuJ9Ak7RAAYG3gq1m9B0g5UcFrxtzEv/aUK+M9ejpCkBghJnI3iFg1wnkeztwCPLhE
	 FEMRY+vYx/LjjjdrsKNeaHjrfCUBKAqyfKecCyig4gtJYbXOUFl7vMxnKWz/v6Kg7q
	 bp0WjyeUJviwA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Saravana Kannan <saravanak@google.com>,
 Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v1 2/2] PM: core: Add two macros for walking device links
Date: Tue, 02 Sep 2025 15:45:14 +0200
Message-ID: <1944671.tdWV9SEqCh@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6202205.lOV4Wx5bFT@rafael.j.wysocki>
References: <6202205.lOV4Wx5bFT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add separate macros for walking links to suppliers and consumers of a
device to help device links users to avoid exposing the internals of
struct dev_links_info in their code and possible coding mistakes related
to that.

Accordingly, use the new macros to replace open-coded device links list
walks in the core power management code.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/base.h          |    8 ++++++++
 drivers/base/power/main.c    |   18 +++++++-----------
 drivers/base/power/runtime.c |    3 +--
 3 files changed, 16 insertions(+), 13 deletions(-)

--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -251,6 +251,14 @@
 void fw_devlink_drivers_done(void);
 void fw_devlink_probing_done(void);
 
+#define dev_for_each_link_to_supplier(__link, __dev)	\
+	list_for_each_entry_srcu(__link, &(__dev)->links.suppliers, c_node, \
+				 device_links_read_lock_held())
+
+#define dev_for_each_link_to_consumer(__link, __dev)	\
+	list_for_each_entry_srcu(__link, &(__dev)->links.consumers, s_node, \
+				 device_links_read_lock_held())
+
 /* device pm support */
 void device_pm_move_to_tail(struct device *dev);
 
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -40,10 +40,6 @@
 
 typedef int (*pm_callback_t)(struct device *);
 
-#define list_for_each_entry_srcu_locked(pos, head, member) \
-	list_for_each_entry_srcu(pos, head, member, \
-			device_links_read_lock_held())
-
 /*
  * The entries in the dpm_list list are in a depth first order, simply
  * because children are guaranteed to be discovered after parents, and
@@ -281,7 +277,7 @@
 	 * callbacks freeing the link objects for the links in the list we're
 	 * walking.
 	 */
-	list_for_each_entry_srcu_locked(link, &dev->links.suppliers, c_node)
+	dev_for_each_link_to_supplier(link, dev)
 		if (READ_ONCE(link->status) != DL_STATE_DORMANT)
 			dpm_wait(link->supplier, async);
 
@@ -338,7 +334,7 @@
 	 * continue instead of trying to continue in parallel with its
 	 * unregistration).
 	 */
-	list_for_each_entry_srcu_locked(link, &dev->links.consumers, s_node)
+	dev_for_each_link_to_consumer(link, dev)
 		if (READ_ONCE(link->status) != DL_STATE_DORMANT)
 			dpm_wait(link->consumer, async);
 
@@ -675,7 +671,7 @@
 	idx = device_links_read_lock();
 
 	/* Start processing the device's "async" consumers. */
-	list_for_each_entry_srcu_locked(link, &dev->links.consumers, s_node)
+	dev_for_each_link_to_consumer(link, dev)
 		if (READ_ONCE(link->status) != DL_STATE_DORMANT)
 			dpm_async_with_cleanup(link->consumer, func);
 
@@ -1330,7 +1326,7 @@
 	idx = device_links_read_lock();
 
 	/* Start processing the device's "async" suppliers. */
-	list_for_each_entry_srcu_locked(link, &dev->links.suppliers, c_node)
+	dev_for_each_link_to_supplier(link, dev)
 		if (READ_ONCE(link->status) != DL_STATE_DORMANT)
 			dpm_async_with_cleanup(link->supplier, func);
 
@@ -1384,7 +1380,7 @@
 
 	idx = device_links_read_lock();
 
-	list_for_each_entry_srcu_locked(link, &dev->links.suppliers, c_node)
+	dev_for_each_link_to_supplier(link, dev)
 		link->supplier->power.must_resume = true;
 
 	device_links_read_unlock(idx);
@@ -1813,7 +1809,7 @@
 
 	idx = device_links_read_lock();
 
-	list_for_each_entry_srcu_locked(link, &dev->links.suppliers, c_node) {
+	dev_for_each_link_to_supplier(link, dev) {
 		spin_lock_irq(&link->supplier->power.lock);
 		link->supplier->power.direct_complete = false;
 		spin_unlock_irq(&link->supplier->power.lock);
@@ -2065,7 +2061,7 @@
 
 	idx = device_links_read_lock();
 
-	list_for_each_entry_srcu_locked(link, &dev->links.suppliers, c_node) {
+	dev_for_each_link_to_supplier(link, dev) {
 		if (!device_link_test(link, DL_FLAG_PM_RUNTIME))
 			continue;
 
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1903,8 +1903,7 @@
 
 	idx = device_links_read_lock();
 
-	list_for_each_entry_srcu(link, &dev->links.suppliers, c_node,
-				 device_links_read_lock_held())
+	dev_for_each_link_to_supplier(link, dev)
 		if (device_link_test(link, DL_FLAG_PM_RUNTIME)) {
 			link->supplier_preactivated = true;
 			pm_runtime_get_sync(link->supplier);




