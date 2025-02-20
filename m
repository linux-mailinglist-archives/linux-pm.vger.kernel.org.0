Return-Path: <linux-pm+bounces-22582-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DCBA3E5AA
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 21:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC99819C070C
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 20:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471791DDC14;
	Thu, 20 Feb 2025 20:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Cn7tH178"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A749A1D5160;
	Thu, 20 Feb 2025 20:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740082709; cv=none; b=CVYYx55o5oMeI0f5ZkitjeJ3lhHVNnUgLYZ8fREaHl+zfY6bDvjBYaJkGPAtWCChfb6OYF40rb7WN7LJ5cCEKfB7vYL4OV0q1hnhXCXJQFY/HNJY8mrs92sAD3tD78ONzCTnY0+fOk9gueXFOzm9grJnUNeU/Z0trMCchd3r398=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740082709; c=relaxed/simple;
	bh=RGu2UJ08Eyqj9Wi1lI7c3NjV4xWV2edp9RUBNb4QkLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K2ZqURxKGGEhi0/OToUAn9PnyKsWklCSvkrgoe6YVDJ3o8VNR6zxgqF/RNx/UFXJJxHcTr4gEqPtnDcLvsCbAnucoDJ/os4r8q9MWp5B5Y5nPMCOqbXxtdWH/OXpod0QMzDhfHlPW0iDnZU5aT7YfYhg6Lna+k75ZlfYl87lf/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Cn7tH178; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 4acc653eaf24059d; Thu, 20 Feb 2025 21:18:24 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 1B7537F624E;
	Thu, 20 Feb 2025 21:18:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1740082704;
	bh=RGu2UJ08Eyqj9Wi1lI7c3NjV4xWV2edp9RUBNb4QkLQ=;
	h=From:Subject:Date;
	b=Cn7tH178og5FkmbDXYvIi0fFavYK9YbbHA5RISx+VbBB5Qa7YI9hFE109tccx8EAK
	 giikqjr4fXvvvSzcNDqSiKbbY92sRdk4ZognyxUzrm+sRMNdDYS2Ak2ShafZU5Nx32
	 qDZTeeFwHp8FH7CnoXqx0DpVevASzIr8uv2eVv28Y8reIhEXBPGIrot6HQd00Li14N
	 Todh20mxyCfa+MZI/HaU48o8tVpO7WTE3WtXfi43jpJ7RHM/MlKW6pymJim7SHD9iz
	 oP8es9Z//JIfHJvxJeHgjiE8iOomytDiX+DguyYNQugDoO+CLd9nSkAJsxZ6Um/NUa
	 Q8VfhiTyC20CA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>,
 Oliver Neukum <oneukum@suse.com>, Ajay Agarwal <ajayagarwal@google.com>,
 Brian Norris <briannorris@google.com>
Subject:
 [PATCH v1] PM: runtime: Unify error handling during suspend and resume
Date: Thu, 20 Feb 2025 21:18:23 +0100
Message-ID: <1922654.tdWV9SEqCh@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeikedtiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgvrhhnsehrohiflhgrnhgurdhhrghrvhgrrhgurdgvughupdhrtghpthhtohepuhhlfhdrhhgrnhhsshhonheslhhinhgrrhhordhorhhgpdhrtghpthhtohepohhnvgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There is a confusing difference in error handling between rpm_suspend()
and rpm_resume() related to the special way in which the -EAGAIN and
-EBUSY error values are treated by the former.  Also, converting
-EACCES coming from the callback to an I/O error, which it quite likely
is not, may confuse runtime PM users a bit.

To address the above, modify rpm_callback() to convert -EACCES coming
from the driver to -EAGAIN and to set power.runtime_error only if the
return value is not -EAGAIN or -EBUSY.

This will cause the error handling in rpm_resume() and rpm_suspend() to
work consistently, so drop the no longer needed -EAGAIN or -EBUSY
special case from the latter and make it retry autosuspend if
power.runtime_error is unset.

Link: https://lore.kernel.org/linux-pm/20220620144231.GA23345@axis.com/
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/runtime.c |   34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -448,8 +448,13 @@
 		retval = __rpm_callback(cb, dev);
 	}
 
-	dev->power.runtime_error = retval;
-	return retval != -EACCES ? retval : -EIO;
+	if (retval == -EACCES)
+		retval = -EAGAIN;
+
+	if (retval != -EAGAIN && retval != -EBUSY)
+		dev->power.runtime_error = retval;
+
+	return retval;
 }
 
 /**
@@ -725,21 +730,18 @@
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
 




