Return-Path: <linux-pm+bounces-21900-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4DCA3179B
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 22:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A58E167A00
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 21:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC6A262810;
	Tue, 11 Feb 2025 21:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="FSG2BFPQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7F32627EC;
	Tue, 11 Feb 2025 21:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739309155; cv=none; b=e00qaohZjYwzPEvtbNmdeLhtzxhLaxHaAcDYP0dnRXko+gCBJJyl2Y5JLgafgoDCm2373m48qQG7v0V9UL+TlP5XsiyK009DbJG+p+aIdVKbyagIebcHcFbp27YEi9n8zk4ZbyT4AZn7m1emkeG9wcPhY2sUzNKILl2Jo8HO95Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739309155; c=relaxed/simple;
	bh=OrkfWzk4rOwXdbaA05EwAtgqA26NxnytAlDoPhIdPEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lQKewzB4C7EJp0tEmLWWCVx6tV68dGKmoIdL5NkoGtfKpr1emFeU6eFGmhNclUlpHOaFs20EXEctVy+cJjlvdyt7EPsfcLw8Bv6T9PTc0zSIpMHSGtVytJzp0GCRZXTyVSRghI46hfCU7gvPbQOi2qfuFwGJf78CN9B4ZdXNCUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=FSG2BFPQ; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 78dce38ef4c9466c; Tue, 11 Feb 2025 22:25:45 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 22772770175;
	Tue, 11 Feb 2025 22:25:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1739309145;
	bh=OrkfWzk4rOwXdbaA05EwAtgqA26NxnytAlDoPhIdPEY=;
	h=From:Subject:Date;
	b=FSG2BFPQjhriNkTqRtnzq0OrBIgfgx2ep5iuEt2gejMEWnyM3l7hdoidJh4/mVduH
	 tHgLmva6h7hJsvRaWPH7gfLygILxQPVnhCT6e2eaoc64tgXrbCiLrowIkW13BciI6v
	 Bpvmon0Finl0+tAos4MAjLvkoM6kbf8IA4rSYGG9qqGZDP9NM4wcrGPUtKWZ/z0bGe
	 1TKWnHWTtRHK92ZzPWFCmysMQTAARoTVaus92G1QrNhTwfQZrrZHkxuwAE7Jp1TYH2
	 KS+4vbUhUzLArViUz2yDTQadJc7maDOA0huMny1rj7rwlxvyoH9+l2sQZgXZhjA+Jl
	 6GtkSLiexCrlQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jon Hunter <jonathanh@nvidia.com>,
 Tony Lindgren <tony.lindgren@linux.intel.com>
Subject:
 [PATCH v1 08/10] PM: sleep: Make pm_runtime_force_resume() look at
 power.set_active
Date: Tue, 11 Feb 2025 22:19:13 +0100
Message-ID: <3817761.MHq7AAxBmi@rjwysocki.net>
In-Reply-To: <2314745.iZASKD2KPV@rjwysocki.net>
References: <2314745.iZASKD2KPV@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegvddtjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeekpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuhhlfhdrhhgrnhhsshhonheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvghrnhesrhhofihlrghnugdrhhgrrhhvrghrugdrvgguuhdprhgtphhtthhopehjohhhrghnsehkvghrnhgvlhdrohhrghdprhgtphh
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In theory (and also in practice after a change to come),
pm_runtime_force_resume() can be called on a device with power.set_active
set, in which case the core has already called pm_runtime_set_active()
on it, and power.needs_force_resume may be clear.  This happens when the
core decides to resume a device because new information on it has become
available during the "noirq" phase of system-wide suspend.

In order to handle that case properly, make pm_runtime_force_resume()
look at power.set_active in addition to power.needs_force_resume, so it
does not skip the device when the former is set.  Namely, make it invoke
the callback for the device then, but without disabling the wake IRQ if
pm_runtime_force_resume() has not enabled it.  Also clear power.set_active
in pm_runtime_force_resume() to prevent it from being taken into account
twice in a row.

Additionally, adjust the pm_runtime_force_resume() kerneldoc comment
and the code comments inside it.  Moreover, remove a remark regarding
DPM_FLAG_SMART_SUSPEND from the pm_runtime_force_suspend() kerneldoc
comment because it is not valid any more after this change.

This change is not expected to alter the behavior in the case when
power.needs_force_resume is set.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Unfortunately, I have not found a way to do this without adding
a new device PM flag and now there are 2 flags specifically for
pm_runtime_force_suspend/resume() which is a bit sad.

Questions for Ulf:

(1) How is the enabling of wakeirqs handled for devices that are runtime-
    suspended before system suspend, so pm_runtime_force_suspend() skips
    them?

(2) What is supposed to happen to wakeirqs during system resume after
    pm_runtime_force_suspend() has enabled them, but hasn't set
    power.needs_force_resume at the same time?

---
 drivers/base/power/runtime.c |   41 ++++++++++++++++++++++++++---------------
 include/linux/pm.h           |    1 +
 2 files changed, 27 insertions(+), 15 deletions(-)

--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1897,10 +1897,6 @@
  * sure the device is put into low power state and it should only be used during
  * system-wide PM transitions to sleep states.  It assumes that the analogous
  * pm_runtime_force_resume() will be used to resume the device.
- *
- * Do not use with DPM_FLAG_SMART_SUSPEND as this can lead to an inconsistent
- * state where this function has called the ->runtime_suspend callback but the
- * PM core marks the driver as runtime active.
  */
 int pm_runtime_force_suspend(struct device *dev)
 {
@@ -1923,6 +1919,7 @@
 		goto err;
 
 	dev_pm_enable_wake_irq_complete(dev);
+	dev->power.wake_irq_enabled = true;
 
 	/*
 	 * If the device can stay in suspend after the system-wide transition
@@ -1950,31 +1947,39 @@
  * pm_runtime_force_resume - Force a device into resume state if needed.
  * @dev: Device to resume.
  *
- * Prior invoking this function we expect the user to have brought the device
- * into low power state by a call to pm_runtime_force_suspend(). Here we reverse
- * those actions and bring the device into full power, if it is expected to be
- * used on system resume.  In the other case, we defer the resume to be managed
- * via runtime PM.
+ * The primary role of this function is to reverse the actions carried out by
+ * pm_runtime_force_suspend() for @dev, so it must always be balanced with a
+ * matching invocation of the latter.  Accordingly, it is only valid to call
+ * this function during system-wide resume transitions.
+ *
+ * Typically, it is used as a system resume callback of a device driver.
  *
- * Typically this function may be invoked from a system resume callback.
+ * However, if @dev had been runtime-suspended before pm_runtime_force_suspend()
+ * was called for it and that function did nothing, but power.set_active has
+ * been set for it by the core, it still needs to be resumed.  That special case
+ * is also handled by this function.
  */
 int pm_runtime_force_resume(struct device *dev)
 {
 	int (*callback)(struct device *);
 	int ret = 0;
 
-	if (!dev->power.needs_force_resume)
+	if (!dev->power.needs_force_resume && !dev->power.set_active)
 		goto out;
 
 	/*
-	 * The value of the parent's children counter is correct already, so
-	 * just update the status of the device.
+	 * The parent's active children counter an the suppliers' usage counters
+	 * are correct already, so just update the status (even though it is
+	 * already RPM_ACTIVE if power.set_active is set).
 	 */
 	__update_runtime_status(dev, RPM_ACTIVE);
 
-	callback = RPM_GET_CALLBACK(dev, runtime_resume);
+	if (dev->power.wake_irq_enabled) {
+		dev_pm_disable_wake_irq_check(dev, false);
+		dev->power.wake_irq_enabled = false;
+	}
 
-	dev_pm_disable_wake_irq_check(dev, false);
+	callback = RPM_GET_CALLBACK(dev, runtime_resume);
 	ret = callback ? callback(dev) : 0;
 	if (ret) {
 		pm_runtime_set_suspended(dev);
@@ -1982,6 +1987,12 @@
 	}
 
 	pm_runtime_mark_last_busy(dev);
+	/*
+	 * Clear power.set_active in case this function runs for the same
+	 * device again.
+	 */
+	dev->power.set_active = false;
+
 out:
 	dev->power.needs_force_resume = 0;
 	pm_runtime_enable(dev);
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -698,6 +698,7 @@
 	bool			request_pending:1;
 	bool			deferred_resume:1;
 	bool			needs_force_resume:1;
+	bool			wake_irq_enabled:1;
 	bool			runtime_auto:1;
 	bool			ignore_children:1;
 	bool			no_callbacks:1;




