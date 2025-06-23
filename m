Return-Path: <linux-pm+bounces-29326-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF83AE413B
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 14:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB989165F1D
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 12:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AFB24C060;
	Mon, 23 Jun 2025 12:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="ZYFNfqii"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF52B246BAC;
	Mon, 23 Jun 2025 12:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750683361; cv=none; b=NFSI+6W/X3yOJRA5hKejKGT2927c09nevk8KkiDlLC+0l+/mtZ4QvobHlkw5lJxF44VSI1TuCLdnW0CeTPfAnPx0zO7GE/UigfATdfVHMZXaR7sWYIC6jaNnNJR9zojyx+HeysxhVtmapGzHuifEFY19t853awtQbLRSQD5MC2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750683361; c=relaxed/simple;
	bh=V4Q+QmBN8f/u1avjxFazjPy4gpKWukS/z0vO/9apM/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t7384Uzq1vUByV6/8bQry2wfcmB4tVU86myt/yCRYEvIocFrUJQGhQrWClvFshx+LZJ4tm6k6NSvlct2VzZRleRmn6RPwsXhZfYVGwUK+SyOJ4kOpkUwzXG98BXA5O6sSxpTDqfJTX8PIdd7gzM0P+iH1ZZ7dccGIBd23HULnec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=ZYFNfqii; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 4E41B66E251;
	Mon, 23 Jun 2025 14:55:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1750683350;
	bh=V4Q+QmBN8f/u1avjxFazjPy4gpKWukS/z0vO/9apM/0=;
	h=From:Subject:Date;
	b=ZYFNfqiihwniBQS/NP4CR2kJjxTAndH5aWuQNy1u0gYkFpKhoMNnMtOvWxz/MX1gn
	 JDsIey/tTn8gUztai0pcS9jTfCzCocr4/NByvUROUMNHjVJIvPR+GxQuZNMXHRlTUZ
	 csU47/kdDFyM/F2hTuuqInxd490095Z+/pmp1DoiawaUikb5ZL9OXOevjA6WYpQHeC
	 KlgZMec/fHuAHvEGwLkybs94QgYtWtJ1dCXn1OQCYMxjOnPInSRZBblCCoE6wKUHmo
	 LwSAedliNdBYUCMV0Tonlk58tx32ZuUQ9aOvLN2qYShxtwqtuXk6ICdylD9qbsq8EN
	 MNErQUq5aT/Mg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Chris Bainbridge <chris.bainbridge@gmail.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Saravana Kannan <saravanak@google.com>,
 Sudeep Holla <sudeep.holla@arm.com>
Subject:
 [RFT][PATCH v4 2/2] PM: sleep: Make async suspend handle suppliers like
 parents
Date: Mon, 23 Jun 2025 14:55:05 +0200
Message-ID: <3384525.44csPzL39Z@rjwysocki.net>
In-Reply-To: <5011988.GXAFRqVoOG@rjwysocki.net>
References: <5011988.GXAFRqVoOG@rjwysocki.net>
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
X-VADE-SPAMCAUSE: dmFkZTGbsflNZg5WlL1okd/rknFH3L9TOvw1i1+BFVQgEjWPACFv7scvKhz9Lxr8KFtFY1/6oLlmNLGKeOm6MiwNWEiDb2QqV30VfAg39R9JTe6j4le2ApJYOuj7glc2VGRiXJjVqORc7lqRIRGBoDDSMffnRX6Jo05mAodd6PSkis+iuUYcebzak/RQKaE9dZC9q5Joz9Z5qFETF/XfZ/sg1H3WtrMe+sDRi0dujNVP0mv8kRxi9pi5Avrg5/T2dhxFe8BzwTug8heoDwNIJ012V85iKjqq7snsgqEfidxfEif7MuFGW3WvnrhmGnKSJsgAZS38L9g4Roltro/4goJ5Gd/bTuAR2gStEFlbODicBv1Pz0GRpzGq3G3uZZSUv/ScqTcOP/jFu4mO+FKxS98t9kunPZsHQxV1yj5K28jo0WzezbuHQikvWfLgEQHPKq4K3xETU3iXp8nGsFSzH3jt9UG1Fdixq45nGTqemuek7dWOeBXLfaXFPSgkrn1UdL3rI9NnUcg+OBq2p+HdoLjH+5qRfHIoING9nT4Kg34tqyWkm5IlnV//aYVmB1wTJLmiXMjgLvhJXgRTDguVV3VR4m5/G2aDL9LZfrB/SABIOxhsm6i/7z3O2i8krNRUgzMgfZBN1kiOJEDdA5RkFHl2FRcxmYIyKF0k316GB5+UgrDUgg
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Avoid starting "async" suspend processing upfront for devices that have
consumers and start "async" suspend processing for a device's suppliers
right after suspending the device itself.

Suggested-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v3 -> v4: Rebase and update the changelog.

---
 drivers/base/power/main.c |   37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1257,10 +1257,15 @@
 		return false;
 	}
 
-	return true;
+	/*
+	 * Since this function is required to run under dpm_list_mtx, the
+	 * list_empty() below will only return true if the device's list of
+	 * consumers is actually empty before calling it.
+	 */
+	return list_empty(&dev->links.consumers);
 }
 
-static void dpm_async_suspend_parent(struct device *dev, async_func_t func)
+static bool dpm_async_suspend_parent(struct device *dev, async_func_t func)
 {
 	guard(mutex)(&dpm_list_mtx);
 
@@ -1272,11 +1277,31 @@
 	 * deleted before it.
 	 */
 	if (!device_pm_initialized(dev))
-		return;
+		return false;
 
 	/* Start processing the device's parent if it is "async". */
 	if (dev->parent)
 		dpm_async_with_cleanup(dev->parent, func);
+
+	return true;
+}
+
+static void dpm_async_suspend_superior(struct device *dev, async_func_t func)
+{
+	struct device_link *link;
+	int idx;
+
+	if (!dpm_async_suspend_parent(dev, func))
+		return;
+
+	idx = device_links_read_lock();
+
+	/* Start processing the device's "async" suppliers. */
+	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
+		if (READ_ONCE(link->status) != DL_STATE_DORMANT)
+			dpm_async_with_cleanup(link->supplier, func);
+
+	device_links_read_unlock(idx);
 }
 
 /**
@@ -1400,7 +1425,7 @@
 	if (error || async_error)
 		return error;
 
-	dpm_async_suspend_parent(dev, async_suspend_noirq);
+	dpm_async_suspend_superior(dev, async_suspend_noirq);
 
 	return 0;
 }
@@ -1596,7 +1621,7 @@
 	if (error || async_error)
 		return error;
 
-	dpm_async_suspend_parent(dev, async_suspend_late);
+	dpm_async_suspend_superior(dev, async_suspend_late);
 
 	return 0;
 }
@@ -1887,7 +1912,7 @@
 	if (error || async_error)
 		return error;
 
-	dpm_async_suspend_parent(dev, async_suspend);
+	dpm_async_suspend_superior(dev, async_suspend);
 
 	return 0;
 }




