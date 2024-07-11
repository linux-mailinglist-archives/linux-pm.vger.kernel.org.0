Return-Path: <linux-pm+bounces-10993-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5494492E865
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 14:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EE091C22016
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 12:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C80815B13A;
	Thu, 11 Jul 2024 12:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="xVLMbgGS"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938E214F9DA;
	Thu, 11 Jul 2024 12:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720701548; cv=none; b=C/J56d8Oil4CdyIy7Q1z0+8VnEO4tFBHqhwonTPrVKZaMueC8ADHuLIfLi5SA+jWFDI9+J8du33l6yhUM0YkQuLPmntlsxlAb49EBAno3JcAgYbjUBL+bY4pyw6/X/CVDyomcPGwAh2foLWpk4NB+vTJbc2PUQjAdPA7mS+AJnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720701548; c=relaxed/simple;
	bh=I/o1l6qvwXUbNEK4rsgFm0M1JrYLAhwSlyVUEfpyT/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QhSoK09w4NyJd1XauzrGwwUyppwnJOgIUOfvX7y+UDj/xkB1AvSvsCkjtTAjnDIkbLmlGMuvemxh/+dNXDBp4yjlfAHUZjTlf7qaoG3AGwhgEQ8Aqmrl19vT1NpKIHTq67hWPc3HYHbdPlBvLUhHNc4I1xNm9o4J7K62SN7WN7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=xVLMbgGS reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 6849db892b77d304; Thu, 11 Jul 2024 14:39:03 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id B5172A035E7;
	Thu, 11 Jul 2024 14:39:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1720701543;
	bh=I/o1l6qvwXUbNEK4rsgFm0M1JrYLAhwSlyVUEfpyT/0=;
	h=From:To:Cc:Subject:Date;
	b=xVLMbgGSMSTEsvROmhkucOXPheRx8dCDqEiijG/TKr1ufG/rSGSzafcsHuZGfVucz
	 1lCNbbYcYwdJSyx5lmGfOc2cUFxBDGKsX406hk+mmHAImiPdLVfGatYXCdaN2USjJa
	 ofDSMYVF+cGhJdfaOuCauw3grG9jq3j7B78vxYTML0ZM2zJb53QxoC07qx7w70JzSP
	 5aDqwiCAlc8b+h1UJZ/Kba9ojsXqcsRWOMjapNVTng+ktCrgxRNWc1/1xG/ek7sXQZ
	 CkuGsgAkwzOGk8ZYIgrgDrawVFaG08+9th7gWi7CmFxm/yifHMYFoA5v2x3hYLzZxm
	 DrX16h8Hgad3w==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
Subject:
 [PATCH v3] thermal: core: Add sanity checks for polling_delay and
 passive_delay
Date: Thu, 11 Jul 2024 14:39:02 +0200
Message-ID: <5802156.DvuYhMxLoT@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrfeeggdehhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghr
 mhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If polling_delay is nonzero and passive_delay is greater than
polling_delay, the thermal zone temperature will be updated less
often when tz->passive is nonzero, which is not as expected.  Make
the thermal zone registration fail with -EINVAL in that case as
this is a clear thermal zone configuration mistake.

If polling_delay is nonzero and passive_delay is 0, which is regarded
as a valid thermal zone configuration, the thermal zone will use polling
except when tz->passive is nonzero.  However, the expected behavior in
that case is to continue temperature polling with the same delay value
regardless of tz->passive, so set passive_delay to the polling_delay
value then.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This supersedes

https://lore.kernel.org/linux-pm/4940808.31r3eYUQgx@rjwysocki.net/

---
 drivers/thermal/thermal_core.c |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -1391,6 +1391,14 @@ thermal_zone_device_register_with_trips(
 	if (num_trips > 0 && !trips)
 		return ERR_PTR(-EINVAL);
 
+	if (polling_delay) {
+		if (passive_delay > polling_delay)
+			return ERR_PTR(-EINVAL);
+
+		if (!passive_delay)
+			passive_delay = polling_delay;
+	}
+
 	if (!thermal_class)
 		return ERR_PTR(-ENODEV);
 




