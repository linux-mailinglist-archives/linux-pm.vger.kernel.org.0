Return-Path: <linux-pm+bounces-21897-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0095AA31796
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 22:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DAB7188B12F
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 21:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9F22627F5;
	Tue, 11 Feb 2025 21:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="bdKNXmgU"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08532627EA;
	Tue, 11 Feb 2025 21:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739309154; cv=none; b=R8ZFdr5LccDKwEz4dSQgODYnvBQUntGTHaubNVWUbO5tH794lRE/MB1D/lESg1FKPo2rSJcF8LtURthoFPtkVr7vacSZvPpRhIDHnf5x3GJWwn73K1G7Wht76Kvv21KKgRV3CfygKiSZAEOAPnWskKmlLcP9stwH4zSOi79ebZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739309154; c=relaxed/simple;
	bh=WUgixIg1Hz0Tw6UK59IVDtHX0+D4hc/h0rTo1M2QpDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KLtMeR8Eef3adLAhE0QmZqQ5agJdKk4clwUcJZfGWUGMGs6rXN2pZk9Y7z9vD8dzNG3rvsVPPDzWOsw9rd711y/tDJeSLeuDA8iNjHU/+qLySF21oCDLOxN/KzBO2kF7H+XXEO1hvjKKT6X2fhQvtuWaRZFxKb8qffWriOhmb0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=bdKNXmgU; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 6556dbb6edc9b342; Tue, 11 Feb 2025 22:25:50 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 396E9770175;
	Tue, 11 Feb 2025 22:25:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1739309150;
	bh=WUgixIg1Hz0Tw6UK59IVDtHX0+D4hc/h0rTo1M2QpDQ=;
	h=From:Subject:Date;
	b=bdKNXmgUkySpZ7z0hio5ZirV7nfer+XGbF9ZJ3nrPigc2I79ZL1t6n2Lwky1V8Wyi
	 bm90w2UKninmlYn5dLE4ir89eICXhw5grsXUFs0bv3qDbCF6aw3Fb+DJBPcRwzSLeJ
	 7i9fzb0GMFOoLURLkoD1fHx35KJc1TJ5P6dF6hWeMLJHBUKkBA7mdjo/Jdhr8dLE4U
	 Pc/mFolpvts0Pg0qDFxp/qrcOUny2qPV5hWePIMAORv51W1/foJKGAwlXihIFPf6y1
	 Os2tows2e6XrbNua7/TpW75pu8h3O2oC32FlJxoyZ8jetQAYaxwIhaGt1mHdALSC2c
	 GGixInuEtj08w==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jon Hunter <jonathanh@nvidia.com>
Subject:
 [PATCH v1 03/10] PM: runtime: Use pm_runtime_no_support() in
 pm_runtime_force_suspend()
Date: Tue, 11 Feb 2025 22:05:51 +0100
Message-ID: <9421808.CDJkKcVGEf@rjwysocki.net>
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

Currently, pm_runtime_force_suspend() does not distinguish devices
without runtime PM enabled and it may be called for such devices
incidentally.  In that case, it works inconsistently depending on
the device runtime PM status value which generally is not expected
to be meaningful for devices with runtime PM permanently disabled.

Namely, if the runtime PM status of the device is RPM_SUSPENDED, it
will be ignored as though it had been runtime-suspended, but if its
runtime PM status is RPM_ACTIVE, pm_runtime_force_suspend() will
attempt to suspend it which may not work.

Make pm_runtime_force_suspend() more consistent by adding a
pm_runtime_no_support() check to it that will cause it to skip
devices with no runtime PM support.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/runtime.c |    6 +++++-
 include/linux/pm_runtime.h   |   14 ++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1908,7 +1908,11 @@
 	int ret;
 
 	pm_runtime_disable(dev);
-	if (pm_runtime_status_suspended(dev))
+	/*
+	 * Do not attempt to suspend devices that have been suspended already or
+	 * that have never had runtime PM enabled.
+	 */
+	if (pm_runtime_status_suspended(dev) || pm_runtime_no_support(dev))
 		return 0;
 
 	callback = RPM_GET_CALLBACK(dev, runtime_suspend);




