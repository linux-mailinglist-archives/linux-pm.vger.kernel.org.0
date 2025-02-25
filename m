Return-Path: <linux-pm+bounces-22905-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A9BA4479F
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 18:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F005B3A8C00
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 17:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DD3198E65;
	Tue, 25 Feb 2025 17:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="k39Lam0r"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C900E197A7A;
	Tue, 25 Feb 2025 17:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503183; cv=none; b=kOjIJmQTBermYGv2qTBNZ4AToPvShTGnGre3YT+f/0slG5si5QSszht19MUn0P33be2FaPQPH3ZBrg0wT/kHI55XVqcgwwp+FSBllywU6vDKvMQch9Nj4+NZcejKw/RgKs7XYtMz6aM4DPfmAvhA7GuTty8bFWNKDuP1mdMorUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503183; c=relaxed/simple;
	bh=et/hYYiFKsZDNd97JleZ75B5fUQEghUreDr7RCcT2Jw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ua6r2DAmnw2MjX726jQCEAdh2EH51D8ayVtdb8cGqfbg3j1n+Kdrg3neWBrp26ENEV0E7lcGizaYm8in9fFXQNV9i9w08G/AH/sMVqUjrzqxKDXmA/EVBR5/VqRhQN+m6eKlKAXPH6Ed377Mv6dqgDZmPGUPJlyfjUnHeL3EGe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=k39Lam0r; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id d66218f4c9878363; Tue, 25 Feb 2025 18:06:19 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 31CC422C28BF;
	Tue, 25 Feb 2025 18:06:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1740503179;
	bh=et/hYYiFKsZDNd97JleZ75B5fUQEghUreDr7RCcT2Jw=;
	h=From:Subject:Date;
	b=k39Lam0rNmbqxbnt1nIb+8I/Fg26wE0UDZGNhYWzjv/tX4vzgLy/eXuRLvawJPaMF
	 tKM5zNsAp5/bKpl5E/QXkeTe48zdntu2NqXgfZELc0xVk68gPrRkFsDfGyOwHeqNaa
	 ocAwFlo1pUsbN0+HSYgLPgYOkBL8lp/isbvMASOnHVmIUpplwiP1jzxXyXRFZ+TbrW
	 QqmqUHzJlUWAPbnxjcQjsvlJe0n02eMiCT5QgBvNXCB4dZuiUMcCnceBGyKXN9ES5P
	 2cvik9G6FTZYfU5RJL+Ynrye1ItkdXV7NR2ADiQszl+X9iG96BqleGi0zqDoZY9p2B
	 Jp2abcFdOAmOg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>,
 Oliver Neukum <oneukum@suse.com>, Ajay Agarwal <ajayagarwal@google.com>,
 Brian Norris <briannorris@google.com>, Raag Jadav <raag.jadav@intel.com>
Subject:
 [PATCH v2] PM: runtime: Unify error handling during suspend and resume
Date: Tue, 25 Feb 2025 18:06:18 +0100
Message-ID: <12620037.O9o76ZdvQC@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekvddviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeffffffkefgheehffelteeiveeffeevhfelteejvddvieejjeelvdeiheeuveeuffenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeekpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvghrnhesrhhofihlrghnugdrhhgrrhhvrghrugdrvgguuhdprhgtphhtthhopehulhhfrdhhrghnshhsohhnsehlihhnrghrohdrohhrghdprhgtphhtthhopehonhgvuhhkuhhmsehsuhhsvgdrtghomhdprhgtphhtthh
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There is a confusing difference in error handling between rpm_suspend()
and rpm_resume() related to the special way in which -EAGAIN and -EBUSY
error values are treated by the former.  Also, converting -EACCES coming
from the callback to I/O error, which it quite likely is not, may
confuse runtime PM users.

To address the above, modify rpm_callback() to convert -EACCES coming
from the driver to -EAGAIN and to set power.runtime_error only if the
return value is not -EAGAIN or -EBUSY.

This will cause the error handling in rpm_resume() and rpm_suspend() to
work consistently, so drop the no longer needed -EAGAIN or -EBUSY
special case from the latter and make it retry autosuspend if
power.runtime_error is unset.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Add comment explaining the -EACCES error code conversion (Raag)

---
 drivers/base/power/runtime.c |   40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -448,8 +448,19 @@
 		retval = __rpm_callback(cb, dev);
 	}
 
-	dev->power.runtime_error = retval;
-	return retval != -EACCES ? retval : -EIO;
+	/*
+	 * Since -EACCES means that runtime PM is disabled for the given device,
+	 * it should not be returned by runtime PM callbacks.  If it is returned
+	 * nevertheless, assume it to be a transient error and convert it to
+	 * -EAGAIN.
+	 */
+	if (retval == -EACCES)
+		retval = -EAGAIN;
+
+	if (retval != -EAGAIN && retval != -EBUSY)
+		dev->power.runtime_error = retval;
+
+	return retval;
 }
 
 /**
@@ -725,21 +736,18 @@
 	dev->power.deferred_resume = false;
 	wake_up_all(&dev->power.wait_queue);
 
-	if (retval == -EAGAIN || retval == -EBUSY) {
-		dev->power.runtime_error = 0;
+	/*
+	 * On transient errors, if the callback routine failed an autosuspend,
+	 * and if the last_busy time has been updated so that there is a new
+	 * autosuspend expiration time, automatically reschedule another
+	 * autosuspend.
+	 */
+	if (!dev->power.runtime_error && (rpmflags & RPM_AUTO) &&
+	    pm_runtime_autosuspend_expiration(dev) != 0)
+		goto repeat;
+
+	pm_runtime_cancel_pending(dev);
 
-		/*
-		 * If the callback routine failed an autosuspend, and
-		 * if the last_busy time has been updated so that there
-		 * is a new autosuspend expiration time, automatically
-		 * reschedule another autosuspend.
-		 */
-		if ((rpmflags & RPM_AUTO) &&
-		    pm_runtime_autosuspend_expiration(dev) != 0)
-			goto repeat;
-	} else {
-		pm_runtime_cancel_pending(dev);
-	}
 	goto out;
 }
 




