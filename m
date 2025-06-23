Return-Path: <linux-pm+bounces-29327-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AED54AE414D
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 14:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A7103A77AE
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 12:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B75D24E4C3;
	Mon, 23 Jun 2025 12:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="WpukxuGX"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CA5248864;
	Mon, 23 Jun 2025 12:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750683362; cv=none; b=DYWfLc0Rt8z9NpNeOtc17ylad5J1qLH056MBPIbSs3ELzCj9oHPEDhb0q6GURc8+il/T4VNK+jpkbivhS21ldevTzhfOnw91mEa+pXITS59hNwkUDKg5dZBIOjIL+p6u474I2Ls8ihzdrDSiYr87MpGKpPTXsqylZVE0j1ETg3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750683362; c=relaxed/simple;
	bh=Ax8aQ2NjFoOjDcQXfzwTWZgwIji8dQElW+Qucx0Pg5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gDuun/KQ1yOFwuKsg+RhtWYCMOsgp0/mOYO/gZCRirklprgWU/WfRCTEYoyXJSgUZ8Occ32ChLhSSgKOaoDso54fTm1szNCfWbFs0XG4EoDtToeOAvE5c4kuiSeYJFs0fSn311WZy++HY2XIvHCrOqeuA789k4ApadWG3kAZa8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=WpukxuGX; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 50E1F66E274;
	Mon, 23 Jun 2025 14:55:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1750683351;
	bh=Ax8aQ2NjFoOjDcQXfzwTWZgwIji8dQElW+Qucx0Pg5I=;
	h=From:Subject:Date;
	b=WpukxuGXiNn5ikO43ypmn5Dhg878AUNNHgFo4SFYN4kRQqkrlCWXpNHux9S48aLua
	 zIGa2ZtASJBEEA3BMQWFqHtaVNKJ40ugq5P/umjitwbVZrB2cTaLtFtMIKNreWfWxE
	 uOemzog4KCyc1Im5omVlU7cm8z2vpTrKnQdeVkimL90jZ0DvdXiCiATDYhgtR6KcV9
	 oucC4smrB0bWkTD4n5PLqXatf6Nesnz8/HkG2yWxbXkLWGfK7cGH7uykOB4e/N0i4U
	 zmMSK8tnu7gc77YwpHhgXwNkaA22ZXfMHyfs5954zeLR43v24/3mE1dImKNTGCWbOw
	 N/ErhEwTxyyVQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Chris Bainbridge <chris.bainbridge@gmail.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Saravana Kannan <saravanak@google.com>,
 Sudeep Holla <sudeep.holla@arm.com>
Subject:
 [RFT][PATCH v4 1/2] PM: sleep: Make async resume handle consumers like
 children
Date: Mon, 23 Jun 2025 14:54:39 +0200
Message-ID: <3378088.aeNJFYEL58@rjwysocki.net>
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
X-VADE-SPAMCAUSE: dmFkZTGbsflNZg5WlL1okd/rknFH3L9TOvw1i1+BFVQgEjWPACFv7scvKhz9Lxr8KFtFY1/6oLlmNLGKeOm6MiwNWEiDb2QqV30VfAg39R9JTe6j4le2ApJYOuj7glc2VGRiXJjVqORc7lqRIRGBoDDSMffnRX6Jo05mAodd6PSkis+iuUYcebzak/RQKaE9dZC9q5Joz9Z5qFETF/XfZ/sg1H3WtrMe+sDRi0dujNVP0mv8kRxi9pi5Avrg5/T2dhxFe8BzwTug8heoDwNIJ012V85iKjqq7snsgqEfidxfEif7MuFGW3WvnrhmGnKSJsgAZS38L9g4Roltro/4goJ5Gd/bGH78NhaRwPJWefSGY+nyuByiXeUipsOU0LIWlEBPGwJ1Q/bPcBeGNtQkMahjoYHML4Vod74d1dq1+CJhGyR3EyafplNEiHo5JDYtRpbubD7yHfC3EmWLafo49sB5BUQ0jJM86Kl+Ttl9h7zDC7hLm6BEh1k10tSS4SAj30t9F3VaHndMhI21dFesyJ5Y+XIgpFSDtRkVPMUyxnyEUi/BL/B9nikrBnAeEFNe9dk5MaHpZWjFWuNjVOhOAb9f+ksFADTLyOm8xXoZ0jxtedWv4Pv9XE1W1NBDgT0O4jIbdWJkrW1YP6r7jFg7UIxm2uwTv2pN9NpvEqfW1iuDXz4iOA
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Avoid starting "async" resume processing upfront for devices that have
suppliers and start "async" resume processing for a device's consumers
right after resuming the device itself.

Suggested-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v3 -> v4: Rebase and update the changelog.

---
 drivers/base/power/main.c |   36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -647,14 +647,27 @@
 	/*
 	 * Start processing "async" children of the device unless it's been
 	 * started already for them.
-	 *
-	 * This could have been done for the device's "async" consumers too, but
-	 * they either need to wait for their parents or the processing has
-	 * already started for them after their parents were processed.
 	 */
 	device_for_each_child(dev, func, dpm_async_with_cleanup);
 }
 
+static void dpm_async_resume_subordinate(struct device *dev, async_func_t func)
+{
+	struct device_link *link;
+	int idx;
+
+	dpm_async_resume_children(dev, func);
+
+	idx = device_links_read_lock();
+
+	/* Start processing the device's "async" consumers. */
+	list_for_each_entry_rcu(link, &dev->links.consumers, s_node)
+		if (READ_ONCE(link->status) != DL_STATE_DORMANT)
+			dpm_async_with_cleanup(link->consumer, func);
+
+	device_links_read_unlock(idx);
+}
+
 static void dpm_clear_async_state(struct device *dev)
 {
 	reinit_completion(&dev->power.completion);
@@ -663,7 +676,14 @@
 
 static bool dpm_root_device(struct device *dev)
 {
-	return !dev->parent;
+	lockdep_assert_held(&dpm_list_mtx);
+
+	/*
+	 * Since this function is required to run under dpm_list_mtx, the
+	 * list_empty() below will only return true if the device's list of
+	 * consumers is actually empty before calling it.
+	 */
+	return !dev->parent && list_empty(&dev->links.suppliers);
 }
 
 static void async_resume_noirq(void *data, async_cookie_t cookie);
@@ -752,7 +772,7 @@
 		pm_dev_err(dev, state, async ? " async noirq" : " noirq", error);
 	}
 
-	dpm_async_resume_children(dev, async_resume_noirq);
+	dpm_async_resume_subordinate(dev, async_resume_noirq);
 }
 
 static void async_resume_noirq(void *data, async_cookie_t cookie)
@@ -895,7 +915,7 @@
 		pm_dev_err(dev, state, async ? " async early" : " early", error);
 	}
 
-	dpm_async_resume_children(dev, async_resume_early);
+	dpm_async_resume_subordinate(dev, async_resume_early);
 }
 
 static void async_resume_early(void *data, async_cookie_t cookie)
@@ -1071,7 +1091,7 @@
 		pm_dev_err(dev, state, async ? " async" : "", error);
 	}
 
-	dpm_async_resume_children(dev, async_resume);
+	dpm_async_resume_subordinate(dev, async_resume);
 }
 
 static void async_resume(void *data, async_cookie_t cookie)




