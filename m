Return-Path: <linux-pm+bounces-33647-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5855AB40594
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 15:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A39956323D
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 13:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E78C31DDBF;
	Tue,  2 Sep 2025 13:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfS4hiN5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2682331E0FE;
	Tue,  2 Sep 2025 13:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756820740; cv=none; b=gdZF+Zm7fA83bppN3dZgSu7kxMu0S4I7I2TGFh8HnKnsP9+XLSiYrIkBg9xcgGv3X8dqZ6fm66DXvoCbCVgoHV1jRgU2RueD3GB7rog9/0jqsOUsaH50Eb4AimrMAwhlCJ4z0DjxxQQFDnunprlVjd1nBTgupEc0Gxnh+gatWxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756820740; c=relaxed/simple;
	bh=Ly46gaveC5fscZEchx1gdYGmcbsQ3rPXP0SznPjl8Qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mm5O3tOOI6IpqIy3zjg8jMedW7dFBBIIHxzL9jPAzTxrT/cLTctLVoRIZNobFksE+X/jlvLQOe2TREOBBI1B4q9xWKha7Ee9rUJ9dl77Hlzl17xpH4GoGGPAH6efWMIk0HeKgEvCKo7+O94fJ8S80jlkY77HUV2KZery8QPFBwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WfS4hiN5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9ADC4CEED;
	Tue,  2 Sep 2025 13:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756820738;
	bh=Ly46gaveC5fscZEchx1gdYGmcbsQ3rPXP0SznPjl8Qs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WfS4hiN5Ue/ZpP3kGfKAMbbzJvQtGN+Jsl7t4BQaRX7V3hatUy9erVHWfchE3dwTf
	 ossbXDKyLird//XSNPABf9ZuccN9pH6Ydens0/pXGdDYB+v5SICyalZVWlKl/bEi+x
	 qEsKONUzyKI/EPoMrIg+DD9hmOvPq+3yaVbY4tF7s0ZBamaH/rUEP23cfVDTwXQf1l
	 jkrkBnrr2R9u7JBlwPudNPh7jwfStNBP6VapS22SN3jVcgmpHkRM47jCCKaV0Rw2mJ
	 wlx4T1OV+VCCvZjmrMLPChhI5Rr1fsPA8Jhr8l+DloJzg6hl21cshnMuqCzYrbeDzE
	 NF/nGf4uoVGJQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Saravana Kannan <saravanak@google.com>,
 Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v1 1/2] PM: core: Annotate loops walking device links as _srcu
Date: Tue, 02 Sep 2025 15:43:50 +0200
Message-ID: <2393512.ElGaqSPkdT@rafael.j.wysocki>
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

Since SRCU is used for the protection of device link lists, the loops
over device link lists in multiple places in drivers/base/power/main.c
and in pm_runtime_get_suppliers() should be annotated as _srcu rather
than as _rcu which is the case currently.

Change the annotations accordingly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c    |   18 +++++++++---------
 drivers/base/power/runtime.c |    4 ++--
 2 files changed, 11 insertions(+), 11 deletions(-)

--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -40,8 +40,8 @@
 
 typedef int (*pm_callback_t)(struct device *);
 
-#define list_for_each_entry_rcu_locked(pos, head, member) \
-	list_for_each_entry_rcu(pos, head, member, \
+#define list_for_each_entry_srcu_locked(pos, head, member) \
+	list_for_each_entry_srcu(pos, head, member, \
 			device_links_read_lock_held())
 
 /*
@@ -281,7 +281,7 @@
 	 * callbacks freeing the link objects for the links in the list we're
 	 * walking.
 	 */
-	list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node)
+	list_for_each_entry_srcu_locked(link, &dev->links.suppliers, c_node)
 		if (READ_ONCE(link->status) != DL_STATE_DORMANT)
 			dpm_wait(link->supplier, async);
 
@@ -338,7 +338,7 @@
 	 * continue instead of trying to continue in parallel with its
 	 * unregistration).
 	 */
-	list_for_each_entry_rcu_locked(link, &dev->links.consumers, s_node)
+	list_for_each_entry_srcu_locked(link, &dev->links.consumers, s_node)
 		if (READ_ONCE(link->status) != DL_STATE_DORMANT)
 			dpm_wait(link->consumer, async);
 
@@ -675,7 +675,7 @@
 	idx = device_links_read_lock();
 
 	/* Start processing the device's "async" consumers. */
-	list_for_each_entry_rcu_locked(link, &dev->links.consumers, s_node)
+	list_for_each_entry_srcu_locked(link, &dev->links.consumers, s_node)
 		if (READ_ONCE(link->status) != DL_STATE_DORMANT)
 			dpm_async_with_cleanup(link->consumer, func);
 
@@ -1330,7 +1330,7 @@
 	idx = device_links_read_lock();
 
 	/* Start processing the device's "async" suppliers. */
-	list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node)
+	list_for_each_entry_srcu_locked(link, &dev->links.suppliers, c_node)
 		if (READ_ONCE(link->status) != DL_STATE_DORMANT)
 			dpm_async_with_cleanup(link->supplier, func);
 
@@ -1384,7 +1384,7 @@
 
 	idx = device_links_read_lock();
 
-	list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node)
+	list_for_each_entry_srcu_locked(link, &dev->links.suppliers, c_node)
 		link->supplier->power.must_resume = true;
 
 	device_links_read_unlock(idx);
@@ -1813,7 +1813,7 @@
 
 	idx = device_links_read_lock();
 
-	list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node) {
+	list_for_each_entry_srcu_locked(link, &dev->links.suppliers, c_node) {
 		spin_lock_irq(&link->supplier->power.lock);
 		link->supplier->power.direct_complete = false;
 		spin_unlock_irq(&link->supplier->power.lock);
@@ -2065,7 +2065,7 @@
 
 	idx = device_links_read_lock();
 
-	list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node) {
+	list_for_each_entry_srcu_locked(link, &dev->links.suppliers, c_node) {
 		if (!device_link_test(link, DL_FLAG_PM_RUNTIME))
 			continue;
 
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1903,8 +1903,8 @@
 
 	idx = device_links_read_lock();
 
-	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
-				device_links_read_lock_held())
+	list_for_each_entry_srcu(link, &dev->links.suppliers, c_node,
+				 device_links_read_lock_held())
 		if (device_link_test(link, DL_FLAG_PM_RUNTIME)) {
 			link->supplier_preactivated = true;
 			pm_runtime_get_sync(link->supplier);




