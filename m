Return-Path: <linux-pm+bounces-30813-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F14B046D2
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 19:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80B501895C68
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 17:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0211E9B2F;
	Mon, 14 Jul 2025 17:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHyyfqKm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C430479FE;
	Mon, 14 Jul 2025 17:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752515141; cv=none; b=QeOWafghHlBx5ySj+ra80R5qscC/jcGoSUIynh4GMGrW2RlNhUI9vxgFuGcvP0CWHKrdnZfej89nE939ZhVTzeiKjwm+PrpO5WHjQUHnBhs3DAWuZyH8g/VY8+RZrcGySKCsq1riu1T+6geXE7FoQRjW1oaoxmbolGnChS0fqJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752515141; c=relaxed/simple;
	bh=rDd07Zz1dnLrg9iR8x0BIfFEN8OmbMJIdDXqCwNr7AY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EPZx+ATLPBnzcqoyAWFLOVxa1+cwkEVDiW7ukdOxe2MQHM3ay/sap806uCfFrwMdIarTHuhQtIhVg9+9MB3brRARW0cAP2aWZ3/C7HX4LlMQQaezyqMTrIm3mwJLKPypvOiUvogE0AQT8ff0q7KSHujwIvczcdlZuWCboE5mBAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pHyyfqKm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21983C4CEED;
	Mon, 14 Jul 2025 17:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752515141;
	bh=rDd07Zz1dnLrg9iR8x0BIfFEN8OmbMJIdDXqCwNr7AY=;
	h=From:To:Cc:Subject:Date:From;
	b=pHyyfqKmlPDVuyO3zDHTgbDfyKEKUpikW/jsMkuRiAilG/FHdRSyUe+uSrlWe74gZ
	 RVl94Vo+u8cJwnYolf5PnlrBZw212johZug15NhUDirk6sle8THpLrRzzx7rvIax6j
	 eB2YfSnNgH4rjYwD237G9DtHznkzVk3lHkJI0bVqywBieSwXmum6EW3cQfkmsYRcXE
	 V4MAdgSrjSlVr/l2NVHp3Zaby5pyrQ0N81m1qq9J/IhLIn99cYHvHL2TuM4EtIVlEz
	 5MMUxAXjG1F9J/hog8/wNjsSe5PFW80k2/LB4C9L5CCLULVuC9LHptrHXJKjIIyAR8
	 4Uhyvr1hk4+yQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Saravana Kannan <saravanak@google.com>
Subject:
 [PATCH v1] PM: sleep: Update power.completion for all devices on errors
Date: Mon, 14 Jul 2025 19:45:31 +0200
Message-ID: <6191258.lOV4Wx5bFT@rjwysocki.net>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit aa7a9275ab81 ("PM: sleep: Suspend async parents after
suspending children"), the following scenario is possible:

 1. Device A is async and it depends on device B that is sync.
 2. Async suspend is scheduled for A before the processing of B is
    started.
 3. A is waiting for B.
 4. In the meantime, an unrelated device fails to suspend and returns
    an error.
 5. The processing of B doesn't start at all and its power.completion is
    not updated.
 6. A is still waiting for B when async_synchronize_full() is called.
 7. Deadlock ensues.

To prevent this from happening, update power.completion for all devices
on errors in all suspend phases, but do not do it directly for devices
that are already being processed or are waiting for the processing to
start because in those cases it may be necessary to wait for the
processing to actually complete before updating power.completion for
the device.

Fixes: aa7a9275ab81 ("PM: sleep: Suspend async parents after suspending children")
Fixes: 443046d1ad66 ("PM: sleep: Make suspend of devices more asynchronous")
Closes: https://lore.kernel.org/linux-pm/e13740a0-88f3-4a6f-920f-15805071a7d6@linaro.org/
Reported-and-tested-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1323,6 +1323,22 @@
 	device_links_read_unlock(idx);
 }
 
+static void dpm_async_suspend_complete_all(struct list_head *device_list)
+{
+	struct device *dev;
+
+	guard(mutex)(&async_wip_mtx);
+
+	list_for_each_entry_reverse(dev, device_list, power.entry) {
+		/*
+		 * In case the device is being waited for and async processing
+		 * has not started for it yet, let the waiters make progress.
+		 */
+		if (!dev->power.work_in_progress)
+			complete_all(&dev->power.completion);
+	}
+}
+
 /**
  * resume_event - Return a "resume" message for given "suspend" sleep state.
  * @sleep_state: PM message representing a sleep state.
@@ -1499,6 +1515,7 @@
 		mutex_lock(&dpm_list_mtx);
 
 		if (error || async_error) {
+			dpm_async_suspend_complete_all(&dpm_late_early_list);
 			/*
 			 * Move all devices to the target list to resume them
 			 * properly.
@@ -1701,6 +1718,7 @@
 		mutex_lock(&dpm_list_mtx);
 
 		if (error || async_error) {
+			dpm_async_suspend_complete_all(&dpm_suspended_list);
 			/*
 			 * Move all devices to the target list to resume them
 			 * properly.
@@ -1994,6 +2012,7 @@
 		mutex_lock(&dpm_list_mtx);
 
 		if (error || async_error) {
+			dpm_async_suspend_complete_all(&dpm_prepared_list);
 			/*
 			 * Move all devices to the target list to resume them
 			 * properly.




