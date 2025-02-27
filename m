Return-Path: <linux-pm+bounces-23047-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23240A47AE8
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 11:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B9DA16D976
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 10:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA72D22A7F6;
	Thu, 27 Feb 2025 10:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="YQJQHGRD"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941A122A4E1;
	Thu, 27 Feb 2025 10:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740653777; cv=none; b=MNKYMzPu5+Cd1CqwcjdxFFsA9di/lCLP/F7uUEstoO0YW5sdIjrPSNbUZclO3VUQ+y/FzGURVlAkhppSWuBYEzH4fL6zCzjjom5zfHsyF9+QA+4wlEJZKe1nJCq9x1J3chjEAWw7PZ8mKfsFomD6XBc7YCk2YmdoVi41+xUwroo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740653777; c=relaxed/simple;
	bh=oghgkns9Qch9f+79sYUw3v6hcv1uz7UfDQR5O+S6GPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O8kFk+KHIMo68j/C2cbL5aff0P7bqxDJYoG/oQnCII//dZ7MZg3J1oVjrMY++FkuE2u7+xH/ib4LuZTHmGXC2P2s8Noe6u0sIDTtuR703O1YFSZAG9/3Zqq0OsiG+mvDagCFJ35yvyC7rG4Lip6+1im15A+emoz4T+ADw7ZN/ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=YQJQHGRD; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 4f8d2c02f9e3d6cd; Thu, 27 Feb 2025 11:56:13 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id E956FD50215;
	Thu, 27 Feb 2025 11:56:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1740653773;
	bh=oghgkns9Qch9f+79sYUw3v6hcv1uz7UfDQR5O+S6GPo=;
	h=From:Subject:Date;
	b=YQJQHGRDRxhL+McsHC9XRpPBc0wMqrRxirkShJ6MjDe8nD194SvXrGqsSnZL48SWv
	 0rSjrenUr/1KEE/Uuylwb2QsevZOYZ6As1sblKwn/Io9B2quF7vW04+Fkf3MGroOz8
	 RdgQkT6nDRZtDZVXlR+FQJWrbsbC6EBlpEqb2qT34+ktxdLMwkSERpsrKzx32TV2TJ
	 cvbHtRzPDKro+836GNiiQyi2rfQHyB7vRlkGXTDrWC0VtHzpW9BZD+NG/XDYW82qZ+
	 7G7bKqDAfoSIFV/h1gKIbrQEbALK/D9oSLp5ZrcrM0lyc6eOI1JikEymmPclJ5Z2UG
	 ULGFKnGtVEyAQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jon Hunter <jonathanh@nvidia.com>
Subject:
 [PATCH v2] PM: runtime: Drop status check from pm_runtime_force_resume()
Date: Thu, 27 Feb 2025 11:56:12 +0100
Message-ID: <2309120.iZASKD2KPV@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekjedvkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehulhhfrdhhrghnshhsohhnsehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgvrhhnsehrohiflhgrnhgurdhhrghrvhgrrhgurdgvughupdhrtghpthhtohepjhhohhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since pm_runtime_force_resume() requires pm_runtime_force_suspend() to
be called before it on the same device, the runtime PM status of the
device is RPM_SUSPENDED when it is called unless the device's runtime
PM status is changed somewhere else in the meantime.

However, even if that happens, the power.needs_force_resume
check is still required to pass and that flag is only set by
pm_runtime_force_suspend() once and it is cleared at the end of
pm_runtime_force_resume(), so it cannot be taken into account
twice in a row.

According to the above, the pm_runtime_status_suspended(dev) check in
pm_runtime_force_resume() is redundant, so drop it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

The previous version of this patch is here:

https://lore.kernel.org/linux-pm/6038511.MhkbZ0Pkbq@rjwysocki.net/

v1 -> v2: Minor changelog edits.

---
 drivers/base/power/runtime.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1982,7 +1982,7 @@
 	int (*callback)(struct device *);
 	int ret = 0;
 
-	if (!pm_runtime_status_suspended(dev) || !dev->power.needs_force_resume)
+	if (!dev->power.needs_force_resume)
 		goto out;
 
 	/*




