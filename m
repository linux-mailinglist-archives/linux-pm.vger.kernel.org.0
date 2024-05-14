Return-Path: <linux-pm+bounces-7832-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8A68C4F74
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 12:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F38331F22FC0
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 10:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC07F13FD7F;
	Tue, 14 May 2024 10:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mCW60ONZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WQ/Swga3"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE7D82488
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 10:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681944; cv=none; b=YIl4FXdzSyvH5eGzid9xCaMtzNsFaHjGbtNVOlbQmp6fDvoMjp6Se4DuHCF7x9QpkH9WERimpkQ4PS0J4S5+kcozX00smlwxcij8OMoMuD2iVWcqpHnuxZpcZk0HxOV73ynLuq/p8kgK6YvQUiSdlwQhNOIHpfCTlyUKR4QHoOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681944; c=relaxed/simple;
	bh=60UCWFzezetFwbVR4kir2ZZ3haOP0xRQqVAw2djnuXI=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=A7mgMeBLTC/OuMncKoW5UcFvePxvvzCGR3+zIMs9xzq/61DCXIg8nAmNBrRprh4CqwEXFfCS+/8k9rMNl3C6ElVZQQFe8qih63bPSPYtqbTRZ+u4hbKZI0gbfgVLn51GvgAweBCMbbQjkoW8v5WkFfEfjD03onzWrGpEywVsGso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mCW60ONZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WQ/Swga3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 May 2024 10:18:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715681936;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=i67PptZsvNfplzxPxD+08VA/pwdhD9x8app5RBlBYVw=;
	b=mCW60ONZv9i8cjGfuS/WTY0vrTouwBo5pKf6g3cQQzVrYjkbHyNYpz/WY9wT1rCLFjUH5/
	fHXaEBUv3aEGZErlJ6dPADJ82e7tzzqyxjv+1ylqGkrqdLVaiNqRiToeh+XDgxAI4k+iCb
	foJjRqWEkc6Rxd5KmDX4o6kxaAFNax4a6CYR49HavAB89QrVrOyc7nrKgBstThjvqcsSTS
	f83SBXZudXoLcuRS3ZgB9D3BcGZJnzi2OejITx3bMxHaU+dW2vIQMrrQqjZZEGordezAOe
	MVEk3nQgNqs4u6FEVZ1JQJiUL3fUZ9Lh+aI4uM0qG0t6QkYiIYNK3j+dAzsLow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715681936;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=i67PptZsvNfplzxPxD+08VA/pwdhD9x8app5RBlBYVw=;
	b=WQ/Swga3Z+5G+uBYh62czSFZvtfxciHJvKbVI+P1tKh0jFKKpNwCJ0zAC8pJuokC5m9KV/
	vTi/xDg9zQktXOBQ==
From: "thermal-bot for Rafael J. Wysocki" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/fixes] thermal: core: Relocate the struct
 thermal_governor definition
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>,
 rui.zhang@intel.com, amitk@kernel.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171568193628.10875.12631442516542422188.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     0444d574fbc3d3af0e426f7c2b72f5830269f096
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//0444d574fbc3d3af0e426f7c2b72f5830269f096
Author:        Rafael J. Wysocki <rafael.j.wysocki@intel.com>
AuthorDate:    Thu, 04 Apr 2024 21:27:07 +02:00
Committer:     Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CommitterDate: Mon, 08 Apr 2024 16:01:50 +02:00

thermal: core: Relocate the struct thermal_governor definition

Notice that struct thermal_governor is only used by the thermal core
and so move its definition to thermal_core.h.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/thermal_core.h | 25 +++++++++++++++++++++++++
 include/linux/thermal.h        | 25 -------------------------
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 9d3ef1e..b461d95 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -23,6 +23,31 @@ struct thermal_trip_desc {
 };
 
 /**
+ * struct thermal_governor - structure that holds thermal governor information
+ * @name:	name of the governor
+ * @bind_to_tz: callback called when binding to a thermal zone.  If it
+ *		returns 0, the governor is bound to the thermal zone,
+ *		otherwise it fails.
+ * @unbind_from_tz:	callback called when a governor is unbound from a
+ *			thermal zone.
+ * @throttle:	callback called for every trip point even if temperature is
+ *		below the trip point temperature
+ * @update_tz:	callback called when thermal zone internals have changed, e.g.
+ *		thermal cooling instance was added/removed
+ * @governor_list:	node in thermal_governor_list (in thermal_core.c)
+ */
+struct thermal_governor {
+	const char *name;
+	int (*bind_to_tz)(struct thermal_zone_device *tz);
+	void (*unbind_from_tz)(struct thermal_zone_device *tz);
+	int (*throttle)(struct thermal_zone_device *tz,
+			const struct thermal_trip *trip);
+	void (*update_tz)(struct thermal_zone_device *tz,
+			  enum thermal_notify_event reason);
+	struct list_head	governor_list;
+};
+
+/**
  * struct thermal_zone_device - structure for a thermal zone
  * @id:		unique id number for each thermal zone
  * @type:	the thermal zone device type
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 62b1745..f1155c0 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -126,31 +126,6 @@ struct thermal_cooling_device {
 #endif
 };
 
-/**
- * struct thermal_governor - structure that holds thermal governor information
- * @name:	name of the governor
- * @bind_to_tz: callback called when binding to a thermal zone.  If it
- *		returns 0, the governor is bound to the thermal zone,
- *		otherwise it fails.
- * @unbind_from_tz:	callback called when a governor is unbound from a
- *			thermal zone.
- * @throttle:	callback called for every trip point even if temperature is
- *		below the trip point temperature
- * @update_tz:	callback called when thermal zone internals have changed, e.g.
- *		thermal cooling instance was added/removed
- * @governor_list:	node in thermal_governor_list (in thermal_core.c)
- */
-struct thermal_governor {
-	const char *name;
-	int (*bind_to_tz)(struct thermal_zone_device *tz);
-	void (*unbind_from_tz)(struct thermal_zone_device *tz);
-	int (*throttle)(struct thermal_zone_device *tz,
-			const struct thermal_trip *trip);
-	void (*update_tz)(struct thermal_zone_device *tz,
-			  enum thermal_notify_event reason);
-	struct list_head	governor_list;
-};
-
 /* Structure to define Thermal Zone parameters */
 struct thermal_zone_params {
 	const char *governor_name;

