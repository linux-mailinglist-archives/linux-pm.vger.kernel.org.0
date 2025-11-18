Return-Path: <linux-pm+bounces-38162-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EF7C69362
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 12:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CB2A2343A24
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 11:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8002133B6D3;
	Tue, 18 Nov 2025 11:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0uCf6H0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D02286A7;
	Tue, 18 Nov 2025 11:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763466519; cv=none; b=tX9EI5uEslf5fGprttcxsATIqdNDedqVSM/hPHh7Etu9TsvtG47niWZq/kDvbWoPQ3zQUJm+uJAHfrCNBFxuRH+xAsnmizCTMQ83JRlvADXQbpf0KmB4JVAGnvHipt3jF13WXs1yxKhsCRmi4OBRT+7iROmNDvK/mqFDqu716aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763466519; c=relaxed/simple;
	bh=mqdgX7lJfVqbFxnFMo4tSkPbeZ0S9+QjGLI2020JtGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qxyBmEim0cJiFJdgJdNtSm/vAtIfVNoIMd0svFnfgufPCOl7P74xEQ8LQ+kWuhPziSDWxjBS3Buq8MHVW1XOjrY55sn6uSKJmoufnDxV/qoc/Qooy0pOrrScUts0rFTtcpgdu6PXwYdBJc+FRpHVfZNnCsEnj4uiTZu5GAp9chk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0uCf6H0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFEC4C2BCB1;
	Tue, 18 Nov 2025 11:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763466518;
	bh=mqdgX7lJfVqbFxnFMo4tSkPbeZ0S9+QjGLI2020JtGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g0uCf6H0TkgvTCbn+sCpssaxRcAwWCtWpPQvaPGG31bLussleIBhUUMrXvBHqERU+
	 jm1WbRTZeC0qfJjrmej20BbSLTktdTk5Y3vfGtM0TKtNeiYb3tSkB48hbPeMagbKxP
	 o2t+DUaAGHvP+gKetTjZkBVWoUt3sI1LLspD1mEWWwMVUo7gOorOgnVLdfLBoW5SLM
	 bJetwa6EpJ/Ce/rbtoZFTVDUCYkSq63o8EKgUlyyyW7VwFBUb9qzMx4xWQUr1k4YCg
	 ulmMtT85F6xakLnl7Dp0q365X52GxHpSSJrqrmQvYMwKRbiw4EpUimR3VUomI0WttH
	 aIgDQW5nhkcgA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: linux-pm@vger.kernel.org, Rose Wu <ya-jou.wu@mediatek.com>
Cc: rafael.j.wysocki@intel.com, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org, wsd_upstream <wsd_upstream@mediatek.com>,
 linux-mediatek@lists.infradead.org, "artis. chiu" <artis.chiu@mediatek.com>,
 "Johnny-cc. Kao" <Johnny-cc.Kao@mediatek.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
Subject:
 [PATCH v2] PM: sleep: core: Fix runtime PM enabling in device_resume_early()
Date: Tue, 18 Nov 2025 12:48:32 +0100
Message-ID: <12782716.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <119e2410ca32a0d55fa6febf93c7a3164b391db0.camel@mediatek.com>
References:
 <70b25dca6f8c2756d78f076f4a7dee7edaaffc33.camel@mediatek.com>
 <5940388.DvuYhMxLoT@rafael.j.wysocki>
 <119e2410ca32a0d55fa6febf93c7a3164b391db0.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

On Tuesday, November 18, 2025 9:31:08 AM CET Rose Wu wrote:
> Hi,
> 
> On Mon, 2025-11-17 at 19:57 +0100, Rafael J. Wysocki wrote:
> > 
> > Make two changes to address this problem.
> > 
> > First, reorder device_suspend_late() to only disable runtime PM for a
> > device if the power.is_late_suspended flag is going to be set for it.
> > In all of the other cases, disabling runtime PM for the device is not
> > in fact necessary.
> > 
> > Second, make device_resume_early() only enable runtime PM for the
> > devices with the power.is_late_suspended flag set.
> > 
> 
> My concern is with the error path in device_suspend_late().
> If a device fails its dpm_run_callback(), it appears that its
> power.is_late_suspended flag is not set, potentially leaving its runtime
> PM disabled during the resume sequence.

Right, pm_runtime_enable() is missing in the error path after calling
dpm_run_callback().

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Runtime PM should only be enabled in device_resume_early() if it has
been disabled for the given device by device_suspend_late().  Otherwise,
it may cause runtime PM callbacks to run prematurely in some cases
which leads to further functional issues.

Make two changes to address this problem.

First, reorder device_suspend_late() to only disable runtime PM for a
device when it is going to look for the device's callback.  In all of
the other cases, disabling runtime PM for the device is not in fact
necessary.  However, if the device's callback returns an error and the
power.is_late_suspended flag is not going to be set, enable runtime
PM so it only remains disabled when power.is_late_suspended is set.

Second, make device_resume_early() only enable runtime PM for the
devices with the power.is_late_suspended flag set.

Fixes: 443046d1ad66 ("PM: sleep: Make suspend of devices more asynchronous")
Reported-by: Rose Wu <ya-jou.wu@mediatek.com>
Closes: https://lore.kernel.org/linux-pm/70b25dca6f8c2756d78f076f4a7dee7edaaffc33.camel@mediatek.com/
Cc: 6.16+ <stable@vger.kernel.org> # 6.16+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Add pm_runtime_enable() to device_suspend_late() error path (Rose).

---
 drivers/base/power/main.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -941,11 +941,11 @@ Run:
 
 Skip:
 	dev->power.is_late_suspended = false;
+	pm_runtime_enable(dev);
 
 Out:
 	TRACE_RESUME(error);
 
-	pm_runtime_enable(dev);
 	complete_all(&dev->power.completion);
 
 	if (error) {
@@ -1630,12 +1630,6 @@ static void device_suspend_late(struct d
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
@@ -1649,6 +1643,12 @@ static void device_suspend_late(struct d
 	if (dev->power.syscore || dev->power.direct_complete)
 		goto Complete;
 
+	/*
+	 * Disable runtime PM for the device without checking if there is a
+	 * pending resume request for it.
+	 */
+	__pm_runtime_disable(dev, false);
+
 	if (dev->pm_domain) {
 		info = "late power domain ";
 		callback = pm_late_early_op(&dev->pm_domain->ops, state);
@@ -1679,6 +1679,7 @@ Run:
 		WRITE_ONCE(async_error, error);
 		dpm_save_failed_dev(dev_name(dev));
 		pm_dev_err(dev, state, async ? " async late" : " late", error);
+		pm_runtime_enable(dev);
 		goto Complete;
 	}
 	dpm_propagate_wakeup_to_parent(dev);




