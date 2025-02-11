Return-Path: <linux-pm+bounces-21902-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65564A3179F
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 22:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAFE0166297
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 21:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A97266587;
	Tue, 11 Feb 2025 21:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="oEQueXFV"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CD72627EF;
	Tue, 11 Feb 2025 21:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739309156; cv=none; b=lhvMHxMcwpFnAmFM6l0ttex/i3Q9K9p8UBeAIBduQ/xnuwINskR+9fiEcUavDtuB3provfO8mz3tVGsbrK2W69ZNxGOC+SoraIE1oM9CXFTmol/cHwkiBj/P9lN4ubkmN4fkccSnNZUzX5TmnBAuGd8ctxQpPVuGurR+vOSfQsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739309156; c=relaxed/simple;
	bh=31LpJUNvPXRT8Z6CSlJtIwY15E5H7sluasiMFMoNjTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PvXRYzk4KZLXixzCzYH1y2xDtKF370bSmAMTIKs9IZaPb3JYyoTyu4Hu7onBnPM5+7/OeazLnSoPlCYklAsjpp9Uf+aibw03ZEdws5Kn4wWJsfslVNnDnE0y0BhDuu2h2sLhuWXVtkeSLHIb2m7+U7DnOZiEfRrSDE3fQOokoSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=oEQueXFV; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id d7342e8c6b5ededa; Tue, 11 Feb 2025 22:25:52 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 13B83770175;
	Tue, 11 Feb 2025 22:25:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1739309152;
	bh=31LpJUNvPXRT8Z6CSlJtIwY15E5H7sluasiMFMoNjTc=;
	h=From:Subject:Date;
	b=oEQueXFVNKfKq2izbXI620kezw+FaF8GYJHaUOBsbUxgUi1EGf0idEguf/Obi6DYZ
	 ynAQzD+3QcCZvKJj8o8Oe5x8owdWk/RmpJnqV9OXOal6YSUCyMZQVsf1Gb4qale7go
	 /IYR/SOPQEu/t4J6uiXpBVzsVAdVXzmW0c8/qvu4SrcyC5w+QWHMvb6Tm8Z+KsiY96
	 2owWs5gpefEXn6DPNy7JKJ/0WHzTW8yBxpRpxk/tLZ3xCtCJ/Zz8tvrqMNlACPAsqF
	 YEvbHds10FVw4sSDOyE8OSKD2Vu+Rm7F2EKzTF7g+zhCIW9on17VSnnG+ZT2a7WPTT
	 WsXBrFzoiLV3w==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH v1 01/10] PM: runtime: Introduce pm_runtime_no_support()
Date: Tue, 11 Feb 2025 22:02:52 +0100
Message-ID: <22608556.EfDdHjke4D@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegvddtjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvghrnhesrhhofihlrghnugdrhhgrrhhvrghrugdrvgguuhdprhgtphhtthhopehulhhfrdhhrghnshhsohhnsehlihhnrghrohdrohhrghdprhgtphhtthhopehjohhhrghnsehkvghrnhgvlhdrohhrghdprhgtphh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Introduce a new helper function called pm_runtime_no_support() for
checking the power.last_status value indicating whether or not runtime
PM has ever been enabled for the given device.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/pm_runtime.h |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -182,6 +182,19 @@
 }
 
 /**
+ * pm_runtime_no_support - Check runtime PM support.
+ * @dev: Target device.
+ *
+ * Return %true if runtime PM is currently disabled for @dev and its last
+ * runtime PM status value is %RPM_INVALID, which means that runtime PM has
+ * never been enabled for it, or %false otherwise.
+ */
+static inline bool pm_runtime_no_support(struct device *dev)
+{
+	return dev->power.disable_depth && dev->power.last_status == RPM_INVALID;
+}
+
+/**
  * pm_runtime_enabled - Check if runtime PM is enabled.
  * @dev: Target device.
  *
@@ -284,6 +297,7 @@
 static inline bool pm_runtime_suspended(struct device *dev) { return false; }
 static inline bool pm_runtime_active(struct device *dev) { return true; }
 static inline bool pm_runtime_status_suspended(struct device *dev) { return false; }
+static inline bool pm_runtime_no_support(struct device *dev) { return true; }
 static inline bool pm_runtime_enabled(struct device *dev) { return false; }
 
 static inline void pm_runtime_no_callbacks(struct device *dev) {}




