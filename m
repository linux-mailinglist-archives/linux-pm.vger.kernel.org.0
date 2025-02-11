Return-Path: <linux-pm+bounces-21903-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C7FA317A1
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 22:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0BE2188C2AC
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 21:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51B026658A;
	Tue, 11 Feb 2025 21:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="A1sBXudh"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C9D2627EE;
	Tue, 11 Feb 2025 21:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739309156; cv=none; b=JHoHTP2HVdzINxP6PatIVMwyanKHQe+mXxtr/3Ih7pnN2lTHiTetFnvKLeP6ncjaP5r91NwSwHG0QzHObZqvtZ4QsNV66FFvSXRA6LuQi+Z0vMvMbXE7uTI8MQ8pAy4IwmISYUB/hbjRWOBSj5lsVdpe40/LCkp+0Q8DleWVdmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739309156; c=relaxed/simple;
	bh=RWDhH8aBvtwB31yfyrq93XAA2QMV2NPAWaWlvDad8Aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WiJijbkBzMN1/X701PBKHnpnU0vQCkaFWMZdsq1/ncia+T2NymDcuMndsGAd/POl/ZftDUA+vS7as7PJ3rF84pfNpHRFclv3H7S+nrrygxlbKhqIyqNIBcMWsJ2N5B8JZGTjCHUH+ttXVLlAkia6brmC51pnXFtaYqAyWE4FQ8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=A1sBXudh; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 90ab42b8ac642b3b; Tue, 11 Feb 2025 22:25:46 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 3A65E770175;
	Tue, 11 Feb 2025 22:25:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1739309146;
	bh=RWDhH8aBvtwB31yfyrq93XAA2QMV2NPAWaWlvDad8Aw=;
	h=From:Subject:Date;
	b=A1sBXudh+cnMY8vi+n5HqzMXOTfHp4+QmTeQiUprmfQG7OzrY0YPq8Ox01fcwHLgT
	 89/2QnVyQfHJybxRStV+ssH4Yqy5kc2ceMl3UhG+id0FUfeA3VMY7fMG9ms8XALyB6
	 P3DNheGK9zlxmHXlyK/IuDcAfYQ0j1DoOsA9eh2BM68WZzAVq/z6MBw4JUMNUZH5hd
	 5AaKV6kUPyZ85I+I2KvKjhslBpPhzfRZywP23xs744MmITUDfoJ3gZHUyxbcd9O4Cy
	 JJt73UJQ8/n5QdKfVbFVDeMhgy7ZXm9Ow800M/9uCsDBUpT5f38+Q8KWMGZDI2uxTU
	 2upvCl6JwmG1g==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH v1 07/10] PM: sleep: Clear the power.set_active upfront
Date: Tue, 11 Feb 2025 22:11:42 +0100
Message-ID: <23846285.6Emhk5qWAg@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegvddtkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvghrnhesrhhofihlrghnugdrhhgrrhhvrghrugdrvgguuhdprhgtphhtthhopehulhhfrdhhrghnshhsohhnsehlihhnrghrohdrohhrghdprhgtphhtthhopehjohhhrghnsehkvghrnhgvlhdrohhrghdprhgtphh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Instead of clearing power.set_active right after it has been used,
clear it when the other related flags (power.may_skip_resume and
power.must_resume) are initialized, so it remains set throughout
system-wide resume transitions and can be checked at any time while
they are still in progress.

This is done in preparation for subsequent changes and it should not
alter the kernel behavior.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -659,12 +659,10 @@
 	 * status to "active" unless its power.set_active flag is clear, in
 	 * which case it is not necessary to update its PM-runtime status.
 	 */
-	if (skip_resume) {
+	if (skip_resume)
 		pm_runtime_set_suspended(dev);
-	} else if (dev->power.set_active) {
+	else if (dev->power.set_active)
 		pm_runtime_set_active(dev);
-		dev->power.set_active = false;
-	}
 
 	if (dev->pm_domain) {
 		info = "noirq power domain ";
@@ -1662,6 +1660,7 @@
 
 	dev->power.may_skip_resume = true;
 	dev->power.must_resume = !dev_pm_test_driver_flags(dev, DPM_FLAG_MAY_SKIP_RESUME);
+	dev->power.set_active = false;
 
 	dpm_watchdog_set(&wd, dev);
 	device_lock(dev);




