Return-Path: <linux-pm+bounces-22903-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38194A446E0
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 17:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C7A61888D11
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 16:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E4619EED3;
	Tue, 25 Feb 2025 16:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="XfYg5Twy"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B064619ABD8;
	Tue, 25 Feb 2025 16:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501989; cv=none; b=tO+gamNLjXOHzWGZjsbptI40DCIrKkeYIzpgsEhHI45TthItBTGkZqQ/5O3+ntc+a0brDFYQImBedXxqcJzv+XFmnEMZ3p6nDx4yVJzvyf9nk5ek8b0ZdWbwFV26DteGV5yZH8VKF3PW+182ocDFbh/6gNoeKIeUBfSgbim01FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501989; c=relaxed/simple;
	bh=x5965uTvLwEkxn6TGr0SnrfvJHVrwkwk9tx8/ZMADy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nNCv7bHqZKNN/9XqrjqYrpmoskEr2wZWWNx918zih0qei4fiyHud56aMCpyE8fgeDSEEgiZuUG631F33Pa6bE0N1w4YGIK6t0Qss9kmqKVLPYzEvBNf8vZQk1/wP2l8ERq478JaE5bO8uSJGSCTT5vbjspOEWKKSvo8TWkBx3Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=XfYg5Twy; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 8710ec574f47ab3a; Tue, 25 Feb 2025 17:46:19 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id A945322C28BF;
	Tue, 25 Feb 2025 17:46:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1740501979;
	bh=x5965uTvLwEkxn6TGr0SnrfvJHVrwkwk9tx8/ZMADy8=;
	h=From:Subject:Date;
	b=XfYg5Twy8jTZ1dk/m0qcpD4B9/jPzUcDZt4bm8WwVPhXlBcas4n7pW/RP2i6lnv6s
	 J86yBP4npYsFbUScElvJzuq+Y0p/Sk7dvrFiQHcfO4cw3zi8pRLbpGR7gPswm/wYoH
	 TYT/qbLRO+6zXnqy1pKceCQHceQx6YpecnsuMR384o5mASUteF5cvle5fHkKYSB0Oo
	 1rOq9DKOiVilkQC9b/KLg47TV2ylBuer6G61N/1jaf5cdsXmU/4E1Xl+QVghW70lh7
	 DMqK/acUNMdchtvMJbuP+o5Onj+tcBK32/tHHlD6uPfPA+n2VVbwwKPeQjBQMCWzlt
	 naXMIEy4OAbDg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Saravana Kannan <saravanak@google.com>
Subject:
 [PATCH v1 1/5] PM: sleep: Rename power.async_in_progress to
 power.work_in_progress
Date: Tue, 25 Feb 2025 17:38:58 +0100
Message-ID: <3338693.aeNJFYEL58@rjwysocki.net>
In-Reply-To: <13709135.uLZWGnKmhe@rjwysocki.net>
References: <13709135.uLZWGnKmhe@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekvddvvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvghrnhesrhhofihlrghnugdrhhgrrhhvrghrugdrvgguuhdprhgtphhtthhopehulhhfrdhhrghnshhsohhnsehlihhnrghrohdrohhrghdprhgtphhtthhopehjohhhrghnsehkvghrnhgvlhdrohhrghdprhgtphh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Rename the async_in_progress field in struct dev_pm_info to
work_in_progress as after subsequent changes it will mean work in
general rather than just async work.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c |   12 ++++++------
 include/linux/pm.h        |    2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -602,7 +602,7 @@
 	reinit_completion(&dev->power.completion);
 
 	if (is_async(dev)) {
-		dev->power.async_in_progress = true;
+		dev->power.work_in_progress = true;
 
 		get_device(dev);
 
@@ -614,9 +614,9 @@
 	/*
 	 * Because async_schedule_dev_nocall() above has returned false or it
 	 * has not been called at all, func() is not running and it is safe to
-	 * update the async_in_progress flag without extra synchronization.
+	 * update the work_in_progress flag without extra synchronization.
 	 */
-	dev->power.async_in_progress = false;
+	dev->power.work_in_progress = false;
 	return false;
 }
 
@@ -736,7 +736,7 @@
 		dev = to_device(dpm_noirq_list.next);
 		list_move_tail(&dev->power.entry, &dpm_late_early_list);
 
-		if (!dev->power.async_in_progress) {
+		if (!dev->power.work_in_progress) {
 			get_device(dev);
 
 			mutex_unlock(&dpm_list_mtx);
@@ -876,7 +876,7 @@
 		dev = to_device(dpm_late_early_list.next);
 		list_move_tail(&dev->power.entry, &dpm_suspended_list);
 
-		if (!dev->power.async_in_progress) {
+		if (!dev->power.work_in_progress) {
 			get_device(dev);
 
 			mutex_unlock(&dpm_list_mtx);
@@ -1042,7 +1042,7 @@
 		dev = to_device(dpm_suspended_list.next);
 		list_move_tail(&dev->power.entry, &dpm_prepared_list);
 
-		if (!dev->power.async_in_progress) {
+		if (!dev->power.work_in_progress) {
 			get_device(dev);
 
 			mutex_unlock(&dpm_list_mtx);
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -679,7 +679,7 @@
 	bool			wakeup_path:1;
 	bool			syscore:1;
 	bool			no_pm_callbacks:1;	/* Owned by the PM core */
-	bool			async_in_progress:1;	/* Owned by the PM core */
+	bool			work_in_progress:1;	/* Owned by the PM core */
 	bool			smart_suspend:1;	/* Owned by the PM core */
 	bool			must_resume:1;		/* Owned by the PM core */
 	bool			may_skip_resume:1;	/* Set by subsystems */




