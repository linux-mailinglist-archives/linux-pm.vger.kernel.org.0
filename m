Return-Path: <linux-pm+bounces-21899-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BE1A3179A
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 22:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D525167A79
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 21:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C493B26280A;
	Tue, 11 Feb 2025 21:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="je/cD9aK"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC82E2627ED;
	Tue, 11 Feb 2025 21:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739309155; cv=none; b=NgDgPumUDT8zAir8JJxXB1rTHYcnjt2ueN6kpHjvAsm2mKkqc0RTGyyi1OFdeO3LMWkS3D3JRvDcXHhRbpFgCw1p9NR7fjbojN6lBZcjbiZin6Xss3/gbzpEBII34jKxtxcNjOZfP90KiRWQ1GUAYe9YxaZN0wyCyqlB1RWIjC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739309155; c=relaxed/simple;
	bh=r47D1nHsFRyaXb3tGPZo++1XHzRRqEr4SbHWAOD9FZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VHZ6QtP5NLDdsIOcaCItBTDklPB9SsU65wEINXOtaSzSmtQf56mUAo1pIdMk5gwjxdJZVEhF8/6U7VJT9ygslD5rHaKY988f+IuRuk7ptx2T9rI64Log4Hm+2AtMK24xfPAV+srIBIP/sV9KN9qtmdsnE2kxa1uzTYnP2dUs4DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=je/cD9aK; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 7fa35b1fd5a3c8fe; Tue, 11 Feb 2025 22:25:51 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 1A7BE770175;
	Tue, 11 Feb 2025 22:25:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1739309151;
	bh=r47D1nHsFRyaXb3tGPZo++1XHzRRqEr4SbHWAOD9FZM=;
	h=From:Subject:Date;
	b=je/cD9aKEfVAqAHV8ssEnV+YNzP3llrt5nl6HCqVbRKb8LECxcXdI4pknPxPHvNFI
	 sj2UKOTgUge/kiPgnHdg9orE2UFsDKZ4xchH7KvdCN1WFpiW3ydvEs10SLIqQBp1Xl
	 AL+Ed6d19xsY2dmWdqgeb6PSBMtUBz1AhauQNlZRoiygqDxxqqORPwZN/rZr5kpqw6
	 hP539J6dIiZWR9TCOpUWfSlFvOfwJZ0DeE75T+dmnBow/4XDCaGIKXk5z7RZ7rgWYl
	 YW/3yyAIFgufnSY+8f+I8c13XpDYWi2Yy/kvA7axI+Yu7S7138k75wVu24ZPp9KKfx
	 lcOAZc0XIOTQQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jon Hunter <jonathanh@nvidia.com>
Subject:
 [PATCH v1 02/10] PM: sleep: core: Use pm_runtime_no_support() during
 set_active updates
Date: Tue, 11 Feb 2025 22:03:56 +0100
Message-ID: <3876702.kQq0lBPeGt@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegvddtkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvghrnhesrhhofihlrghnugdrhhgrrhhvrghrugdrvgguuhdprhgtphhtthhopehulhhfrdhhrghnshhsohhnsehlihhnrghrohdrohhrghdprhgtphhtthhopehjohhhrghnsehkvghrnhgvlhdrohhrghdprhgtphh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is pointless to set power.set_active for devices that have never had
runtime PM enabled, so don't do that.

Fixes: 7585946243d6 ("PM: sleep: core: Restrict power.set_active propagation")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1281,9 +1281,11 @@
 		dev->power.must_resume = true;
 
 	if (dev->power.must_resume) {
-		if (dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND)) {
+		if (dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) &&
+		    !pm_runtime_no_support(dev)) {
 			dev->power.set_active = true;
-			if (dev->parent && !dev->parent->power.ignore_children)
+			if (dev->parent && !dev->parent->power.ignore_children &&
+			    !pm_runtime_no_support(dev->parent))
 				dev->parent->power.set_active = true;
 		}
 		dpm_superior_set_must_resume(dev);




