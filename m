Return-Path: <linux-pm+bounces-21906-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED830A317A3
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 22:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 857DC169293
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 21:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A8D2686A1;
	Tue, 11 Feb 2025 21:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="UdE3VJlu"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EC726280D;
	Tue, 11 Feb 2025 21:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739309158; cv=none; b=Yr5XR9OM/XHQhFe8R6sLzbqQ5vmJ5Tx2mu/RqflV3R4x7fT1N8g83oW/mC3VAS7YvTl41fg+4JB1tKOvdP6vwm+iYf3YYoOIWAD7HE+ySitP4gqav+aztIv8Sy5EgvatBVksJYCnKxKJsKkL+kV7j7EKwvw3crXDSV4uyMhD5Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739309158; c=relaxed/simple;
	bh=zmNhGZJdY16x0lBsxEUPSi9daEXT4yca9scHTcNRzzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=klVxPIRLK4P/POJSMgcINUJk/DRbHur+jSCXJEXaf9jpBcOnKBxlbt4WMhAAgS0sC/Htw/NJrtCkEH00tCxE3qKSWsnX1IK2X/o6k1vl0t93HsitjHEx5FI1YfwKj4bMTlRNGg/PXMOho7hX/205RHCu65BjysRu6Ke+yyRl0K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=UdE3VJlu; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 9daabc391473d490; Tue, 11 Feb 2025 22:25:48 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 0B026770175;
	Tue, 11 Feb 2025 22:25:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1739309148;
	bh=zmNhGZJdY16x0lBsxEUPSi9daEXT4yca9scHTcNRzzU=;
	h=From:Subject:Date;
	b=UdE3VJluhfkRx/T9oWQ97SBw5OQ80FdN/4yRVlBX5ep0aPRdpHYTj55d0Wt+ye4IK
	 5KcRI1zAz3TCSoZznKPcyL/LgqGmOJBC0nwwtzjCsAYRYT9oMhgd6ebeL06hYOX5An
	 k7+hXmuPoGrp72XSfqHzpMipnluGlaWRNw2w9EjIe3/C8EZSwao12JIljnFAL7cTvB
	 uXeJUqp40lGJ2i1srQgAfQBFP8aDDemicGhLVqL4mjiorhNDgICsTKenyKwMCTcCpP
	 wvPyt2YG+senpQEP7z4Kqx8KxKmEFPreQ5oAUCDNZkJPrzdJT0f2/oAi9Do1EwCGmt
	 KGXHAAOp+L5tg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jon Hunter <jonathanh@nvidia.com>
Subject:
 [PATCH v1 05/10] PM: runtime: Do not enable wakeup IRQs during system resume
Date: Tue, 11 Feb 2025 22:09:11 +0100
Message-ID: <8546164.NyiUUSuA9g@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegvddtjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvghrnhesrhhofihlrghnugdrhhgrrhhvrghrugdrvgguuhdprhgtphhtthhopehulhhfrdhhrghnshhsohhnsehlihhnrghrohdrohhrghdprhgtphhtthhopehjohhhrghnsehkvghrnhgvlhdrohhrghdprhgtphh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Enabling system wakeup IRQs during system resume transitions is
not particularly useful, even on errors, so don't do it in the
pm_runtime_force_resume() error path.

Fixes: c46a0d5ae4f9 ("PM: runtime: Extend support for wakeirq for force_suspend|resume")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/runtime.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1978,7 +1978,6 @@
 	ret = callback ? callback(dev) : 0;
 	if (ret) {
 		pm_runtime_set_suspended(dev);
-		dev_pm_enable_wake_irq_check(dev, false);
 		goto out;
 	}
 




