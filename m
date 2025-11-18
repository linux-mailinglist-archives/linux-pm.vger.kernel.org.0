Return-Path: <linux-pm+bounces-38177-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D414C69EDF
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 15:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 90B394FB508
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 14:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBF1355047;
	Tue, 18 Nov 2025 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdPPED9I"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECA02D47EE;
	Tue, 18 Nov 2025 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763475369; cv=none; b=se8H3Y5ws1FJU7jLi2xzDs3o4Lzsur5EJGW+ZIB+frvALMccifRunAETVVhbCXK51GHdqK0DYOjnCJHYnKTm0xK2WDHN/JtQKQz2nSE1rxqwtnCKE/+MhQSUg63T8YZo0fKYB+V6IbypREWYlG9GpHQ1kIejrNdegFnIFY3MyTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763475369; c=relaxed/simple;
	bh=doH4USYe9Q+qpSG9yro8+usxqPz+JrPIod4tnHcThus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qs6OOHjGzqpAXc7erW9+tG0gnCaCY/77bksXqzIuyj6xVzihM83N873TLE3Dv9eBg92zv3AzBCZfXeICmLdb9HFqLYjCP+DPf+XnRuh3UNdd7s9PW5uaM/+idfT0uWBapXNK8s1OhpwIhmjzhllxorb5fTavu1SUFYlWoV/JXBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdPPED9I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF761C2BC86;
	Tue, 18 Nov 2025 14:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763475369;
	bh=doH4USYe9Q+qpSG9yro8+usxqPz+JrPIod4tnHcThus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GdPPED9IVVCrQkvzc3jodIPXLI/7vANiYOAKITb1dQBkATo/wQYg/rz6xYnbhP6X9
	 0tGX//40TjuYWc3y5FKKk8zIOf8jjjRgX2sQ36ERqoUpDFNzaU0OPF/Gtd5v2mm9Bc
	 A945cr/p/j7NL/13Q6DSJ0MhbT2Dd5FBTi3lPxtxn4IPKY77ZTUTe16Y6ROrMM6Rf0
	 EODL9Ec+5c63l6vBjm7JedVYF69aWo2uoLD3Qa2Hj18yw+y/SU7QWHpdZzw5qwpD8v
	 HgCStIzXpoXrpKYsExBTZe93YMkxPy0Pu5Aq82Py7vbyl3hqkcZ0vjPts53jOQqhn6
	 O7JQitX24C0xQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rose Wu <ya-jou.wu@mediatek.com>,
 linux-pm@vger.kernel.org
Cc: rafael.j.wysocki@intel.com, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org, wsd_upstream <wsd_upstream@mediatek.com>,
 linux-mediatek@lists.infradead.org, "artis. chiu" <artis.chiu@mediatek.com>,
 "Johnny-cc. Kao" <Johnny-cc.Kao@mediatek.com>
Subject:
 [PATCH v4] PM: sleep: core: Fix runtime PM enabling in device_resume_early()
Date: Tue, 18 Nov 2025 15:16:04 +0100
Message-ID: <12784270.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5941318.DvuYhMxLoT@rafael.j.wysocki>
References:
 <70b25dca6f8c2756d78f076f4a7dee7edaaffc33.camel@mediatek.com>
 <CAJZ5v0iTMhWoBfbrPabdo7TkNuOwtC=-6acSe9tbDmyzZEoXwg@mail.gmail.com>
 <5941318.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Runtime PM should only be enabled in device_resume_early() if it has
been disabled for the given device by device_suspend_late().  Otherwise,
it may cause runtime PM callbacks to run prematurely in some cases
which leads to further functional issues.

Make two changes to address this problem.

First, reorder device_suspend_late() to only disable runtime PM for a
device when it is going to look for the device's callback or if the
device is a "syscore" one.  In all of the other cases, disabling runtime
PM for the device is not in fact necessary.  However, if the device's
callback returns an error and the power.is_late_suspended flag is not
going to be set, enable runtime PM so it only remains disabled when
power.is_late_suspended is set.

Second, make device_resume_early() only enable runtime PM for the
devices with the power.is_late_suspended flag set.

Fixes: 443046d1ad66 ("PM: sleep: Make suspend of devices more asynchronous")
Reported-by: Rose Wu <ya-jou.wu@mediatek.com>
Closes: https://lore.kernel.org/linux-pm/70b25dca6f8c2756d78f076f4a7dee7edaaffc33.camel@mediatek.com/
Cc: 6.16+ <stable@vger.kernel.org> # 6.16+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v3 -> v4:
   * Reorder the syscore check in device_resume_early() after the
     is_late_suspended check (Ulf)
   * Update the changelog to reflect the above.

v2 -> v3:
   * Also set is_late_suspended for syscore devices to avoid skipping runtime PM
     disabling for them (Ulf).
   * Update the changelog to reflect the above.

v1 -> v2:
   * Add pm_runtime_enable() to device_suspend_late() error path (Rose).
   * Update the changelog to reflect the above.

---
 drivers/base/power/main.c |   25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -903,12 +903,15 @@ static void device_resume_early(struct d
 	TRACE_DEVICE(dev);
 	TRACE_RESUME(0);
 
-	if (dev->power.syscore || dev->power.direct_complete)
+	if (dev->power.direct_complete)
 		goto Out;
 
 	if (!dev->power.is_late_suspended)
 		goto Out;
 
+	if (dev->power.syscore)
+		goto Skip;
+
 	if (!dpm_wait_for_superior(dev, async))
 		goto Out;
 
@@ -941,11 +944,11 @@ Run:
 
 Skip:
 	dev->power.is_late_suspended = false;
+	pm_runtime_enable(dev);
 
 Out:
 	TRACE_RESUME(error);
 
-	pm_runtime_enable(dev);
 	complete_all(&dev->power.completion);
 
 	if (error) {
@@ -1630,12 +1633,6 @@ static void device_suspend_late(struct d
 	TRACE_DEVICE(dev);
 	TRACE_SUSPEND(0);
 
-	/*
-	 * Disable runtime PM for the device without checking if there is a
-	 * pending resume request for it.
-	 */
-	__pm_runtime_disable(dev, false);
-
 	dpm_wait_for_subordinate(dev, async);
 
 	if (READ_ONCE(async_error))
@@ -1646,9 +1643,18 @@ static void device_suspend_late(struct d
 		goto Complete;
 	}
 
-	if (dev->power.syscore || dev->power.direct_complete)
+	if (dev->power.direct_complete)
 		goto Complete;
 
+	/*
+	 * Disable runtime PM for the device without checking if there is a
+	 * pending resume request for it.
+	 */
+	__pm_runtime_disable(dev, false);
+
+	if (dev->power.syscore)
+		goto Skip;
+
 	if (dev->pm_domain) {
 		info = "late power domain ";
 		callback = pm_late_early_op(&dev->pm_domain->ops, state);
@@ -1679,6 +1685,7 @@ Run:
 		WRITE_ONCE(async_error, error);
 		dpm_save_failed_dev(dev_name(dev));
 		pm_dev_err(dev, state, async ? " async late" : " late", error);
+		pm_runtime_enable(dev);
 		goto Complete;
 	}
 	dpm_propagate_wakeup_to_parent(dev);




