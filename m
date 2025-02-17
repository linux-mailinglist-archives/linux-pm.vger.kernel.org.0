Return-Path: <linux-pm+bounces-22233-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 566A4A38CFC
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 21:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 229A11896C07
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 20:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7685F23642E;
	Mon, 17 Feb 2025 20:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="lbLsLX7M"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE47522B8BC;
	Mon, 17 Feb 2025 20:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739822593; cv=none; b=f37Ah8H6AS3hP7RjetHRcmseGcph76+NQaz6Z8HFlCxaXxBenoRukI9Cvp0lr8PqrnASWDj8mddS36jA/p6hUGUj6YqtREnrBlxhutm2Ih5/DaLecNVK2ol0Auu7DNcR9VekZEXh+8jquHa85RKoc8DbhUYcIxVaPr8rdtWA67E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739822593; c=relaxed/simple;
	bh=Czt6dzLaaJYi0aLl1SqokBZut9L0657qGVnXG8CtbZk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XEq8QyfvZe/fyU60dmFOTylN5PwmKSsjfjnvUfItMBEs/oSe++RjhpjSUjD+8loGzsdVlrQqidE3taqEZxWRLzSZHJnUdTFP35ic/Q/gBrGXvoIPhcaibsoYj+jzsHBcU91yWaLfy5NlpMHeerw9u9N/W3nk7IsPkkir78IWcsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=lbLsLX7M; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 09ce3472b20f4a40; Mon, 17 Feb 2025 21:03:02 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 280BB9100B0;
	Mon, 17 Feb 2025 21:03:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1739822582;
	bh=Czt6dzLaaJYi0aLl1SqokBZut9L0657qGVnXG8CtbZk=;
	h=From:Subject:Date;
	b=lbLsLX7MVn+NzaOcOJjkjHD64cWTdjK0qVqzMQmQ/PlRzT+NqmQmiF9ghU9kjsxf0
	 YzxuK51DdxYF2SPp2NBKHWbK4UjxH+u3CM1f3fhcx4ya5iZAIDum4sAtn+/UEc2C3i
	 lD4zOAagiPPK7rgOZFeQTXJI3nqufg5xeC5aml1vXJ0bFTpO3IprrrthQHutpw/LBa
	 c5V/ht0HaUI42V+krFnakW/mU3HQljHsCMdpVuKMJKQggN/OP52GRqAdwYlMRrXf79
	 Kwgx9OrnYMigNlhymXvTl3fYN6tMrfaDgwG6uzLQapP6c0yFnB1j4PsB09p9+RZbca
	 YRBUUgmMaic8g==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johan Hovold <johan@kernel.org>
Subject:
 [PATCH v1] PM: Rearrange documentation related to __pm_runtime_disable()
Date: Mon, 17 Feb 2025 21:03:01 +0100
Message-ID: <12617588.O9o76ZdvQC@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehleefudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeffffffkefgheehffelteeiveeffeevhfelteejvddvieejjeelvdeiheeuveeuffenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvghrnhesrhhofihlrghnugdrhhgrrhhvrghrugdrvgguuhdprhgtphhtthhopehulhhfrdhhrghnshhsohhnsehlihhnrghrohdrohhrghdprhgtphhtthhopehjohhhrghnsehkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There are only two callers of __pm_runtime_disable(), one of which is
device_suspend_late() and the other is pm_runtime_disable() that has
its own kerneldoc comment and there are no plans to add any more of
them.  Since they use different values of the __pm_runtime_disable()
second parameter, the actual code behavior is different in each case,
but it is all documented in the __pm_runtime_disable() kerneldoc comment
which is not particularly straightforward.

For this reason, move the information from the __pm_runtime_disable()
kerneldoc comment to the pm_runtime_disable() one and into a separate
comment in device_suspend_late() and remove the __pm_runtime_disable()
kerneldoc comment altogether.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c    |    4 ++++
 drivers/base/power/runtime.c |   14 --------------
 include/linux/pm_runtime.h   |   15 +++++++++++----
 3 files changed, 15 insertions(+), 18 deletions(-)

--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1404,6 +1404,10 @@
 	TRACE_DEVICE(dev);
 	TRACE_SUSPEND(0);
 
+	/*
+	 * Disable runtime PM for the device without checking if there is a
+	 * pending resume request for it.
+	 */
 	__pm_runtime_disable(dev, false);
 
 	dpm_wait_for_subordinate(dev, async);
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1460,20 +1460,6 @@
 }
 EXPORT_SYMBOL_GPL(pm_runtime_barrier);
 
-/**
- * __pm_runtime_disable - Disable runtime PM of a device.
- * @dev: Device to handle.
- * @check_resume: If set, check if there's a resume request for the device.
- *
- * Increment power.disable_depth for the device and if it was zero previously,
- * cancel all pending runtime PM requests for the device and wait for all
- * operations in progress to complete.  The device can be either active or
- * suspended after its runtime PM has been disabled.
- *
- * If @check_resume is set and there's a resume request pending when
- * __pm_runtime_disable() is called and power.disable_depth is zero, the
- * function will wake up the device before disabling its runtime PM.
- */
 void __pm_runtime_disable(struct device *dev, bool check_resume)
 {
 	spin_lock_irq(&dev->power.lock);
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -556,11 +556,18 @@
  * pm_runtime_disable - Disable runtime PM for a device.
  * @dev: Target device.
  *
- * Prevent the runtime PM framework from working with @dev (by incrementing its
- * "blocking" counter).
+ * Prevent the runtime PM framework from working with @dev by incrementing its
+ * "disable" counter.
  *
- * For each invocation of this function for @dev there must be a matching
- * pm_runtime_enable() call in order for runtime PM to be enabled for it.
+ * If the counter is zero when this function runs and there is a pending runtime
+ * resume request for @dev, it will be resumed.  If the counter is still zero at
+ * that point, all of the pending runtime PM requests for @dev will be canceled
+ * and all runtime PM operations in progress involving it will be waited for to
+ * complete.
+ *
+ * For each invocation of this function for @dev, there must be a matching
+ * pm_runtime_enable() call, so that runtime PM is eventually enabled for it
+ * again.
  */
 static inline void pm_runtime_disable(struct device *dev)
 {




