Return-Path: <linux-pm+bounces-23058-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B28A47C8D
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 12:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 572571886A2A
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 11:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09E022A1CF;
	Thu, 27 Feb 2025 11:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Ws/JioKh"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663DA227B9C;
	Thu, 27 Feb 2025 11:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740656964; cv=none; b=ji9fPmcRT5qMPmT8/yjZY7T6W/H/JL6Z2dY/9SNtNPs+uRJAYKF1YakEwIGHJDs1I68iGG8HPyPhPTsrSZ2yImEi1Yz1zUON8+StB175W7lgHgEhIuY0u4y0vNAw9oFnpbEiI0utIMJDNXSLImLxhIKbmMjH3warsbRPU7qhqIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740656964; c=relaxed/simple;
	bh=66uWDs0dEvE/f0XOsqKgWaU0Dwb0vWSA//uid9NL0T8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Co9E/fy1v99yN3mi0TCiLnGANypzrueGhDkjG160zA0Ge2ycRwo4C8yAMvIIMa97k8vSYtguB+4Mh5yrnu+z+b3LGO5esNVaM3P78bwIC5pj2iTXwd2zQgmkVZtuSEMoAUy7kVcB0NhXrIMsfUURyuiDdYgqV3TBDyuw13f/vqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Ws/JioKh; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 1d2a6c11e063f019; Thu, 27 Feb 2025 11:49:20 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 6EC92D517DE;
	Thu, 27 Feb 2025 11:49:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1740653359;
	bh=66uWDs0dEvE/f0XOsqKgWaU0Dwb0vWSA//uid9NL0T8=;
	h=From:Subject:Date;
	b=Ws/JioKhvM/s2MTwIi8v2nBdhIcZhE4wfDV5awt3ruF1DlkCOiFb1DzZSAqsAjp5m
	 Lw8cpjfvKwwTO8amL4YArsdzbnqpKHRLnl1/XbhTycLV8WEKXDn48uX/LfVADAs4tQ
	 pfKhell5sJKxSpkjz9vZyJYJ1ufX0kpZA9TOiZ7b9y78LO88A0uHaQJ6aYzHfmkeA0
	 Akob6goWMy299Hg70mEi67i3bGNV8qnsfGAYpb19zUvP8yN9HAHUeLPJRsHQKfLb77
	 KTwmHlBAiaYSove/FDb6cM6Yu3aade78INgtJwSdluTmqOLTvnmMU+tNpB/C19v9qr
	 SaXvmZVXVdqTA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jon Hunter <jonathanh@nvidia.com>
Subject:
 [PATCH v1 3/3] PM: core: Tweak pm_runtime_block_if_disabled() return value
Date: Thu, 27 Feb 2025 11:49:12 +0100
Message-ID: <13718674.uLZWGnKmhe@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekjedviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvghrnhesrhhofihlrghnugdrhhgrrhhvrghrugdrvgguuhdprhgtphhtthhopehulhhfrdhhrghnshhsohhnsehlihhnrghrohdrohhrghdprhgtphhtthhopehjohhhrghnsehkvghrnhgvlhdrohhrghdprhgtphh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Modify pm_runtime_block_if_disabled() to return true when runtime PM
is disabled for the device, regardless of the power.last_status value.

This effectively prevents "smart suspend" from being enabled for
devices with runtime PM disabled in device_prepare(), even transiently,
so update the related comment in that function accordingly.

If a device has runtime PM disabled in device_prepare(), it is not
actually known whether or not runtime PM will be enabled for that
device going forward, so it is more appropriate to postpone the
"smart suspend" optimization for the device in the given system
suspend-resume cycle than to enable it and get confused going
forward.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c    |    2 +-
 drivers/base/power/runtime.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1891,7 +1891,7 @@
 		pm_runtime_put(dev);
 		return ret;
 	}
-	/* Do not enable "smart suspend" for devices without runtime PM. */
+	/* Do not enable "smart suspend" for devices with disabled runtime PM. */
 	if (smart_suspend)
 		smart_suspend = device_prepare_smart_suspend(dev);
 
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1466,8 +1466,8 @@
 
 	spin_lock_irq(&dev->power.lock);
 
-	ret = dev->power.disable_depth && dev->power.last_status == RPM_INVALID;
-	if (ret)
+	ret = !pm_runtime_enabled(dev);
+	if (ret && dev->power.last_status == RPM_INVALID)
 		dev->power.last_status = RPM_BLOCKED;
 
 	spin_unlock_irq(&dev->power.lock);




