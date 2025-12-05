Return-Path: <linux-pm+bounces-39248-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C162CA843B
	for <lists+linux-pm@lfdr.de>; Fri, 05 Dec 2025 16:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 543BE3221747
	for <lists+linux-pm@lfdr.de>; Fri,  5 Dec 2025 15:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07B635F8B1;
	Fri,  5 Dec 2025 15:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4H2N0E5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB747331A6A;
	Fri,  5 Dec 2025 15:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764948250; cv=none; b=WtOna90e4zLRVMwCW7Fw449uwoveAdJQWybRXXwsYrHZf8EUyBTjwLT9AYY4ltcXQ8n0cQ09lxcF/J9gt8sXbrDqEAvJzxB590/xbhbfxaPVeS7ViEi4AyyeGAoQBgKv5cW7+El1UX/4o9kJSPXiUhFf7LE3w4zRlBc9YDkq1Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764948250; c=relaxed/simple;
	bh=VPZBz6gUJ9/Kuvek85aJy2KGAjCQmppoXJ2P9Ttxe4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LtE/osVGFbIxPByi2vlsaAMAbd0020uFDZBxihrtzEhPRHiKEqtyo/0V9CI53WHXombxLchebAK+14N2Wzdi2jTJtlNuNnCrF2PSTjKal/Fhz957KtQ7u317cWbjsubAT+UfcsPSjE8DMkIwGYBGfyjdfjyYr7XBSrbqLHpRW0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4H2N0E5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C475C4CEF1;
	Fri,  5 Dec 2025 15:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764948249;
	bh=VPZBz6gUJ9/Kuvek85aJy2KGAjCQmppoXJ2P9Ttxe4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R4H2N0E5kaXEWyNdz7TW/2aV4hmPW8nwUIsW4TbpTD2SkXyrTxCsCp2+upWEg2s0o
	 MkpDB6yyx3/zGdqp5u6Mpum/zXjXl59bS2HSdWFBwuv/i7J26pYOHsoMHSW31qH/xl
	 Rv9hiB61iuJiNqnOqJDyffq4Unu/QuV27Z2kWeVu/MhMgZbhcaZPkDnLojUqMlZpeb
	 tmPmqY+SvRR+oChWfZKod1a1KA7VIQyFF2QYhAx4Xf4xQKSJdjUXGjIP/aLRAl6dPl
	 0wiFDzbsrHwWIIeiUkvVEtU0SeFTdXXo/Sl6Wki+cCbqGENl8CnreDZXwN+JJVmK44
	 1pNQrfYUBPZ6w==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: linux-pm@vger.kernel.org
Cc: YangYang <yang.yang@vivo.com>, Bart Van Assche <bvanassche@acm.org>,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2] PM: sleep: Do not flag runtime PM workqueue as freezable
Date: Fri, 05 Dec 2025 16:24:05 +0100
Message-ID: <12794222.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To:
 <CAJZ5v0hm=jfSyBXF0qMYnpATJf56JTxQ-+4JBy3YMjS0cMUMHg@mail.gmail.com>
References:
 <20251126101636.205505-1-yang.yang@vivo.com>
 <82bcdf73-54c5-4220-86c0-540a5cb59bb7@vivo.com>
 <CAJZ5v0hm=jfSyBXF0qMYnpATJf56JTxQ-+4JBy3YMjS0cMUMHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Till now, the runtime PM workqueue has been flagged as freezable, so it
does not process work items during system-wide PM transitions like
system suspend and resume.  The original reason to do that was to
reduce the likelihood of runtime PM getting in the way of system-wide
PM processing, but now it is mostly an optimization because (1) runtime
suspend of devices is prevented by bumping up their runtime PM usage
counters in device_prepare() and (2) device drivers are expected to
disable runtime PM for the devices handled by them before they embark
on system-wide PM activities that may change the state of the hardware
or otherwise interfere with runtime PM.  However, it prevents
asynchronous runtime resume of devices from working during system-wide
PM transitions, which is confusing because synchronous runtime resume
is not prevented at the same time, and it also sometimes turns out to
be problematic.

For example, it has been reported that blk_queue_enter() may deadlock
during a system suspend transition because of the pm_request_resume()
usage in it [1].  That happens because the asynchronous runtime resume
of the given device is not processed due to the freezing of the runtime
PM workqueue.  While it may be better to address this particular issue
in the block layer, the very presence of it means that similar problems
may be expected to occur elsewhere.

For this reason, remove the WQ_FREEZABLE flag from the runtime PM
workqueue and make device_suspend_late() use the generic variant of
pm_runtime_disable() that will carry out runtime PM of the device
synchronously if there is pending resume work for it.

Also update the comment before the pm_runtime_disable() call in
device_suspend_late(), to document the fact that the runtime PM
should not be expected to work for the device until the end of
device_resume_early(), and update the related documentation.

This change may, even though it is not expected to, uncover some
latent issues related to queuing up asynchronous runtime resume
work items during system suspend or hibernation.  However, they
should be limited to the interference between runtime resume and
system-wide PM callbacks in the cases when device drivers start
to handle system-wide PM before disabling runtime PM as described
above.

Link: https://lore.kernel.org/linux-pm/20251126101636.205505-2-yang.yang@vivo.com/
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---

v1 -> v2:
   * Update documentation in runtime_pm.rst.
   * Add R-by from Ulf.

---
 Documentation/power/runtime_pm.rst |    7 +++----
 drivers/base/power/main.c          |    7 ++++---
 kernel/power/main.c                |    2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -714,10 +714,9 @@ out the following operations:
   * During system suspend pm_runtime_get_noresume() is called for every device
     right before executing the subsystem-level .prepare() callback for it and
     pm_runtime_barrier() is called for every device right before executing the
-    subsystem-level .suspend() callback for it.  In addition to that the PM core
-    calls __pm_runtime_disable() with 'false' as the second argument for every
-    device right before executing the subsystem-level .suspend_late() callback
-    for it.
+    subsystem-level .suspend() callback for it.  In addition to that, the PM
+    core disables runtime PM for every device right before executing the
+    subsystem-level .suspend_late() callback for it.
 
   * During system resume pm_runtime_enable() and pm_runtime_put() are called for
     every device right after executing the subsystem-level .resume_early()
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1647,10 +1647,11 @@ static void device_suspend_late(struct d
 		goto Complete;
 
 	/*
-	 * Disable runtime PM for the device without checking if there is a
-	 * pending resume request for it.
+	 * After this point, any runtime PM operations targeting the device
+	 * will fail until the corresponding pm_runtime_enable() call in
+	 * device_resume_early().
 	 */
-	__pm_runtime_disable(dev, false);
+	pm_runtime_disable(dev);
 
 	if (dev->power.syscore)
 		goto Skip;
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -1125,7 +1125,7 @@ EXPORT_SYMBOL_GPL(pm_wq);
 
 static int __init pm_start_workqueues(void)
 {
-	pm_wq = alloc_workqueue("pm", WQ_FREEZABLE | WQ_UNBOUND, 0);
+	pm_wq = alloc_workqueue("pm", WQ_UNBOUND, 0);
 	if (!pm_wq)
 		return -ENOMEM;
 




