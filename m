Return-Path: <linux-pm+bounces-23059-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 850D8A47C8E
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 12:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25B8316B337
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 11:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EA922ACFB;
	Thu, 27 Feb 2025 11:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="mrLFJyru"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F143F18C34B;
	Thu, 27 Feb 2025 11:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740656965; cv=none; b=VW57nczMWArlD47liOdMZm2efJwgpiRtbI756dOnCkcorv7N8Facx9Ce9uqwkZXNvGoqnX9GiO9jklRS01Jq0jY2JpqXjijtVUAy4M01Q3hL4j381eT0JISzn3ZcE12/8rLrEXHbyBUdIJxuUJA4p4HK2lPSjds5T3siKaEAy2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740656965; c=relaxed/simple;
	bh=3JjXQcjruxl7T2U/j9rlu8qhbi1Eqvuizv3BLuPaZFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TDRA/9fru8B9/HfW+cdqD1QdOxP0cSV3chmw+2qcFdd04BWOy1cTW/jcpRVPk7Li8PLLaN8tDvsPb/VSP0hG1eGWK4TQe2smfNbOJmtuurj2WMBaxPrEWrbJp6xOzWByQCb5gDG+mDA5ovhyUqbSQ8lvTqRVYQ85IzLRviFxNRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=mrLFJyru; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id e14e882bf36c814f; Thu, 27 Feb 2025 11:49:21 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 29621D50215;
	Thu, 27 Feb 2025 11:49:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1740653361;
	bh=3JjXQcjruxl7T2U/j9rlu8qhbi1Eqvuizv3BLuPaZFk=;
	h=From:Subject:Date;
	b=mrLFJyruDmtEPUX+lvIUGVtR9mgDGwextLdf0lBwN99mOClGjRB4AOC2L7ElRnnF2
	 eyVV8dXBTW13EoHoFFMp53T1BMsVxpmOba8MnnRW1SiI/QYRf4kJmjSascGRXjNMTY
	 Qd76tLPOUVUOowpSiLVNOTG3X2ryggYPVPTGyMAESAqDgQFMhKuUW4ibW2Nu1DHv8r
	 Y8VVSEsjGWB7Gw0gDZoHXORogIRN1qqCIa5XmBmD8Ad6VaARkGdnCsmbMYvF4z8gYr
	 KK668M2SjTW1lUS+2d8o+AGd2q5qTCmSgf1JFQEjqtAK6ilsXRPICy9s+bjJm+M5Oo
	 RetfA6tJ2kLFQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jon Hunter <jonathanh@nvidia.com>
Subject:
 [PATCH v1 1/3] PM: sleep: Update power.smart_suspend under PM spinlock
Date: Thu, 27 Feb 2025 11:45:52 +0100
Message-ID: <2368159.ElGaqSPkdT@rjwysocki.net>
In-Reply-To: <5000287.31r3eYUQgx@rjwysocki.net>
References: <5000287.31r3eYUQgx@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekjedvjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvghrnhesrhhofihlrghnugdrhhgrrhhvrghrugdrvgguuhdprhgtphhtthhopehulhhfrdhhrghnshhsohhnsehlihhnrghrohdrohhrghdprhgtphhtthhopehjohhhrghnsehkvghrnhgvlhdrohhrghdprhgtphh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Put the update of the power.smart_suspend device flag under the PM
spinlock of the device in case multiple bit fields in struct dev_pm_info
occupy one memory location which needs to be updated via RMW every time
any of these bit fields is updated.

The lock in question is already held around the power.direct_complete
flag update in device_prepare() for the same reason, so this change does
not add locking-related overhead to the code.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c |   35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1789,9 +1789,10 @@
 	return error;
 }
 
-static void device_prepare_smart_suspend(struct device *dev)
+static bool device_prepare_smart_suspend(struct device *dev)
 {
 	struct device_link *link;
+	bool ret = true;
 	int idx;
 
 	/*
@@ -1802,17 +1803,13 @@
 	 * or any of its suppliers that take runtime PM into account, it cannot
 	 * be enabled for the device either.
 	 */
-	dev->power.smart_suspend = dev->power.no_pm_callbacks ||
-		dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND);
-
-	if (!dev_pm_smart_suspend(dev))
-		return;
+	if (!dev->power.no_pm_callbacks &&
+	    !dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND))
+		return false;
 
 	if (dev->parent && !dev_pm_smart_suspend(dev->parent) &&
-	    !dev->parent->power.ignore_children && !pm_runtime_blocked(dev->parent)) {
-		dev->power.smart_suspend = false;
-		return;
-	}
+	    !dev->parent->power.ignore_children && !pm_runtime_blocked(dev->parent))
+		return false;
 
 	idx = device_links_read_lock();
 
@@ -1822,12 +1819,14 @@
 
 		if (!dev_pm_smart_suspend(link->supplier) &&
 		    !pm_runtime_blocked(link->supplier)) {
-			dev->power.smart_suspend = false;
+			ret = false;
 			break;
 		}
 	}
 
 	device_links_read_unlock(idx);
+
+	return ret;
 }
 
 /**
@@ -1841,7 +1840,7 @@
 static int device_prepare(struct device *dev, pm_message_t state)
 {
 	int (*callback)(struct device *) = NULL;
-	bool no_runtime_pm;
+	bool smart_suspend;
 	int ret = 0;
 
 	/*
@@ -1857,7 +1856,7 @@
 	 * suspend-resume cycle is complete, so prepare to trigger a warning on
 	 * subsequent attempts to enable it.
 	 */
-	no_runtime_pm = pm_runtime_block_if_disabled(dev);
+	smart_suspend = !pm_runtime_block_if_disabled(dev);
 
 	if (dev->power.syscore)
 		return 0;
@@ -1893,9 +1892,12 @@
 		return ret;
 	}
 	/* Do not enable "smart suspend" for devices without runtime PM. */
-	if (!no_runtime_pm)
-		device_prepare_smart_suspend(dev);
+	if (smart_suspend)
+		smart_suspend = device_prepare_smart_suspend(dev);
+
+	spin_lock_irq(&dev->power.lock);
 
+	dev->power.smart_suspend = smart_suspend;
 	/*
 	 * A positive return value from ->prepare() means "this device appears
 	 * to be runtime-suspended and its state is fine, so if it really is
@@ -1903,11 +1905,12 @@
 	 * will do the same thing with all of its descendants".  This only
 	 * applies to suspend transitions, however.
 	 */
-	spin_lock_irq(&dev->power.lock);
 	dev->power.direct_complete = state.event == PM_EVENT_SUSPEND &&
 		(ret > 0 || dev->power.no_pm_callbacks) &&
 		!dev_pm_test_driver_flags(dev, DPM_FLAG_NO_DIRECT_COMPLETE);
+
 	spin_unlock_irq(&dev->power.lock);
+
 	return 0;
 }
 




