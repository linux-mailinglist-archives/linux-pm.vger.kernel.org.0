Return-Path: <linux-pm+bounces-21898-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02ABDA31797
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 22:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5EB27A2FA9
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 21:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1382627F6;
	Tue, 11 Feb 2025 21:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="KAmVYPl3"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590B32627E3;
	Tue, 11 Feb 2025 21:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739309154; cv=none; b=pw8QZobIflxXVpeznX4Azn3K3CE8+aMoQBr1oh8sMJSq9lIosvXuW1sUzlFrk9JROHMnDayuqrAxLqmLq0r3QTqMeKqSUyCdrVGfQ49pRCRYeOH6u0K36LuDGPKRlJviO4INP6RyJkQxU1sNUNCzdZk5JlgnvMz+PiG78kKWvbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739309154; c=relaxed/simple;
	bh=cRfV58Kh8+/WrvCJJWhBR/V0oGVgKQc3FHgkhJO9CEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rbd4k5MLGgZfCl3LiR2LOfxbVQvHexpkRo/J9XapRjG0+Q4mdsK1ydHJegHx3mysPJA74hdUrzdnJZ8666LAmoSvGh3ZUMz34UQFebQTI002Z2qhD0B0HPjI0B+Dw6of1/+esGJbX2hq0SCqQGRSxeBUfFH2zutIUooNBLoHj/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=KAmVYPl3; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 31469b2175be8e51; Tue, 11 Feb 2025 22:25:43 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 3E994770175;
	Tue, 11 Feb 2025 22:25:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1739309143;
	bh=cRfV58Kh8+/WrvCJJWhBR/V0oGVgKQc3FHgkhJO9CEE=;
	h=From:Subject:Date;
	b=KAmVYPl3THXVXJPDHj7GSdRgIqGt6gy1+wrnDKKSB0vpQEpPX1ZBWZB7PJTugLHg1
	 Axni2/ZNjmuWWPcWjtPcKgLb7Tqalcj8+pp7WsPsudQ0YTkHgiNeV9qMDelXV1BI+i
	 NlYXkH9KBVtDCgj8yAVpw1hYxA93kAxNqyOCI72eFVKG/KxsqNr+B9RQLUzv0/I++S
	 F4gimHNrsZ7+9ETrZrxmyM2vV75SLCuTxD5g2SKcmFKqw4OUZZhOfG1aWaVEQGVRtf
	 ccbeKgni+wMor+wWQ0mpydz7ru/eRS6NYp2PSOJqPOVUl3hYFlzxzFKiAJL2gR1b9A
	 6u19KVx+2i0uQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH v1 10/10] PM: runtime: Discover the lack of runtime PM support
Date: Tue, 11 Feb 2025 22:25:29 +0100
Message-ID: <2511990.jE0xQCEvom@rjwysocki.net>
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

Previous changes have updated the PM core to special-case devices that
have never had runtime PM enabled in some places, but what if a device
had had runtime PM enabled at one point, but then it was permanently
disabled?  Arguably, there is not much of a difference between such
devices and the devices that have never had runtime PM enabled as far
as system-wide suspend and resume is concerned, so they should be
handled in the same way.

For this reason, add a mechanism for discovering "lost" runtime PM
support in devices with the help of the power.last_status field used
for saving the last runtime PM status of the device known at the time
when runtime PM was disabled for it.

That field is set to RPM_INVALID initially and whenever runtime PM is
enabled for a device (that is, when its power.disable_depth counter
drops down to zero) and it is set to the current runtime PM status of
the device when runtime PM is disabled (that is, the power.disable_depth
counter becomes nonzero).  Therefore, if power.last_status is equal to
RPM_INVALID for a device with runtime PM disabled, it means that
runtime PM has never been enabled for that device.

The PM core will now change the power.last_status value to RPM_UNKNOWN
for devices having runtime PM disabled and power.last_status different
from RPM_INVALID during the "prepare" phase of system suspend.  Then,
__pm_runtime_disable() called subsequently on the device will set
power.last_status to RPM_INVALID unless it changes from RPM_UNKNOWN
to some other value in the meantime which requires enabling runtime PM
for the device.  When power.last_status becomes RPM_INVALID and runtime
PM is still disabled, the device will be handled as a "no runtime PM
support" one from that point on until runtime PM is enabled for it
again.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c    |    6 ++++++
 drivers/base/power/runtime.c |   25 +++++++++++++++++++++++++
 include/linux/pm.h           |    1 +
 include/linux/pm_runtime.h   |    2 ++
 4 files changed, 34 insertions(+)

--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1817,6 +1817,12 @@
 	 * it again during the complete phase.
 	 */
 	pm_runtime_get_noresume(dev);
+	/*
+	 * Devices that have had runtime PM disabled recently may need to be
+	 * handled as though they have never supported it, so arrange for
+	 * detecting that situation.
+	 */
+	pm_runtime_kick_last_status(dev);
 
 	if (dev->power.syscore)
 		return 0;
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1480,6 +1480,9 @@
 
 	if (dev->power.disable_depth > 0) {
 		dev->power.disable_depth++;
+		if (dev->power.last_status == RPM_UNKNOWN)
+			dev->power.last_status = RPM_INVALID;
+
 		goto out;
 	}
 
@@ -1568,6 +1571,28 @@
 EXPORT_SYMBOL_GPL(devm_pm_runtime_enable);
 
 /**
+ * pm_runtime_kick_last_status - Start runtime PM support verification.
+ * @dev: Target device.
+ *
+ * If runtime PM is currently disabled for @dev, but it has been enabled at one
+ * point, change power.last_status for it to RPM_UNKNOWN, and if it is still
+ * RPM_UNKNOWN when __pm_runtime_disabled() is called for @dev next time, it
+ * will be changed to RPM_INVALID indicating no runtime PM support going
+ * forward until pm_runtime_enable() is called for @dev.
+ *
+ * This function is used by the PM core.
+ */
+void pm_runtime_kick_last_status(struct device *dev)
+{
+	spin_lock_irq(&dev->power.lock);
+
+	if (dev->power.disable_depth && dev->power.last_status != RPM_INVALID)
+		dev->power.last_status = RPM_UNKNOWN;
+
+	spin_unlock_irq(&dev->power.lock);
+}
+
+/**
  * pm_runtime_forbid - Block runtime PM of a device.
  * @dev: Device to handle.
  *
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -597,6 +597,7 @@
 	RPM_RESUMING,
 	RPM_SUSPENDED,
 	RPM_SUSPENDING,
+	RPM_UNKNOWN,
 };
 
 /*
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -80,6 +80,7 @@
 extern int pm_runtime_barrier(struct device *dev);
 extern void pm_runtime_enable(struct device *dev);
 extern void __pm_runtime_disable(struct device *dev, bool check_resume);
+extern void pm_runtime_kick_last_status(struct device *dev);
 extern void pm_runtime_allow(struct device *dev);
 extern void pm_runtime_forbid(struct device *dev);
 extern void pm_runtime_no_callbacks(struct device *dev);
@@ -288,6 +289,7 @@
 static inline int pm_runtime_barrier(struct device *dev) { return 0; }
 static inline void pm_runtime_enable(struct device *dev) {}
 static inline void __pm_runtime_disable(struct device *dev, bool c) {}
+static inline void pm_runtime_kick_last_status(struct device *dev) {}
 static inline void pm_runtime_allow(struct device *dev) {}
 static inline void pm_runtime_forbid(struct device *dev) {}
 




