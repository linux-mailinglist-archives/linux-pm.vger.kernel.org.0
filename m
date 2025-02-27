Return-Path: <linux-pm+bounces-23060-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DB4A47C91
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 12:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8E643AB48E
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 11:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4B622B8DB;
	Thu, 27 Feb 2025 11:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="RrOTAOhk"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6637A22759D;
	Thu, 27 Feb 2025 11:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740656965; cv=none; b=ays3Q/cPyA/GemQGZM+0tm4tcBDPXJ0IDkxpDcqiksoDz8t236yp7UXnYDyawOkzW3uzpBjoURfWjDpgNW68D4TcxCW0qaZwLWaQlXHKIiHBoYiOmAeAlUEY9pPrSE5Xox07mIyKogEpeI75+wQlPIS3RX301X0O+iA6Wju5O04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740656965; c=relaxed/simple;
	bh=A+L+Y8toLgeC3/OqnS6lL9MtQ6YRNh0Wen5Cc4klwqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qkFPxFkjOG9CwbPDeDpq5NgZTZQ1HiBk17o+iOXd/TKkCj46tt0VAexD128eKfwybbcrAwRFxMaRHTC/hcn/csT3Dl+MrOjJlt3h58JpGgBjVK7v47PE4MKy6O0LvyWhTl3a6EBeHxo51i9oODAVBlft9yBHTt9031uGj3p/vKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=RrOTAOhk; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 2a02072cc88c4d42; Thu, 27 Feb 2025 11:49:20 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 5A13CD50215;
	Thu, 27 Feb 2025 11:49:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1740653360;
	bh=A+L+Y8toLgeC3/OqnS6lL9MtQ6YRNh0Wen5Cc4klwqQ=;
	h=From:Subject:Date;
	b=RrOTAOhkpDDx8YElBP2DmsQTQ7bK1ulQhDZ5wY8Xx0yvZXYdnmdpW5WG+8jHb/v9k
	 z9nah6m43TP3WOC8sCtMVX4MlICpJUQytK0j5t7zKl1qmsPmS3Oqkuk7tboiZMaYEp
	 obzPKgCB1AGTBiHfTPkkqPp6/y96LQBTmXZ+Me+DTi+VJq0MxM3SkRNU+C0ntH7EJ0
	 6b25ttVrjHbo0A8tHTb/05Z931UZYXl5sFkemkqq6PZZfZkKFzFd77IlXWH/12jobj
	 eIKUVSBtY6NRZwz/3XTyFkMVCyMyEiE5sidaiukaF+zT4z3LQMyY2HI22HEhmw0fh8
	 mZ9l6Xeyjl8AQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jon Hunter <jonathanh@nvidia.com>
Subject:
 [PATCH v1 2/3] PM: runtime: Convert pm_runtime_blocked() to static inline
Date: Thu, 27 Feb 2025 11:47:33 +0100
Message-ID: <1923449.tdWV9SEqCh@rjwysocki.net>
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

The comment in pm_runtime_blocked() is acutally wrong: power.last_status
is not a bit field.  Its data type is an enum and so one can reasonably
assume that partial updates of it will not be observed.

Accordingly, pm_runtime_blocked() can be converted to a static inline
function and the related locking overhead can be eliminated, so long
as it is only used in system suspend/resume code paths because
power.last_status is not expected to be updated concurrently while
that code is running.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/runtime.c |   17 -----------------
 include/linux/pm_runtime.h   |   12 +++++++++++-
 2 files changed, 11 insertions(+), 18 deletions(-)

--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1560,23 +1560,6 @@
 }
 EXPORT_SYMBOL_GPL(pm_runtime_enable);
 
-bool pm_runtime_blocked(struct device *dev)
-{
-	bool ret;
-
-	/*
-	 * dev->power.last_status is a bit field, so in case it is updated via
-	 * RMW, read it under the spin lock.
-	 */
-	spin_lock_irq(&dev->power.lock);
-
-	ret = dev->power.last_status == RPM_BLOCKED;
-
-	spin_unlock_irq(&dev->power.lock);
-
-	return ret;
-}
-
 static void pm_runtime_disable_action(void *data)
 {
 	pm_runtime_dont_use_autosuspend(data);
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -81,7 +81,6 @@
 extern void pm_runtime_unblock(struct device *dev);
 extern void pm_runtime_enable(struct device *dev);
 extern void __pm_runtime_disable(struct device *dev, bool check_resume);
-extern bool pm_runtime_blocked(struct device *dev);
 extern void pm_runtime_allow(struct device *dev);
 extern void pm_runtime_forbid(struct device *dev);
 extern void pm_runtime_no_callbacks(struct device *dev);
@@ -200,6 +199,17 @@
 }
 
 /**
+ * pm_runtime_blocked - Check if runtime PM enabling is blocked.
+ * @dev: Target device.
+ *
+ * Do not call this function outside system suspend/resume code paths.
+ */
+static inline bool pm_runtime_blocked(struct device *dev)
+{
+	return dev->power.last_status == RPM_BLOCKED;
+}
+
+/**
  * pm_runtime_has_no_callbacks - Check if runtime PM callbacks may be present.
  * @dev: Target device.
  *




