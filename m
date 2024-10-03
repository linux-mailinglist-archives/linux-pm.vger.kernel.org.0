Return-Path: <linux-pm+bounces-15102-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5163E98EF32
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 14:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 017C81F21F00
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 12:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70D41714B9;
	Thu,  3 Oct 2024 12:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="WJXhs2fU"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862F3170853;
	Thu,  3 Oct 2024 12:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727958459; cv=none; b=r/CFJJck1VRfaHEzGAX+djLNE/pS3Gai1tIyN8rgLKSxDA0JzNclv+Bcc6JZhMY7EBUHni+dSuNo6kNpnam029EXd7DHZt6OAAJaHCY7U60/S/JlUwyWZTCyMDlyoGPzwz0zVy2fudNge78sDNR3cMTy5HBxhJYRiZr/aGFbQIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727958459; c=relaxed/simple;
	bh=jEAMNCHRCNFk0XXuAX03IGBLoSOBmVSAyuWjkpZfjNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dpQF48g2oTjfb/ZdGLQVD2v9Gi0kwxihrD04idXwMdpyMLPbA2uj3tKXiGNp38Eo70Xl5qoHyKpBqB3ihCwBlVP/KEw7nnztuPyI87IUKAFUZXqYbehSEoA60LNJdf0cVUKyZbF5u35sEk6r2NvoNaRfGyOHIFUSvmLkMRX5bHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=WJXhs2fU reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id d327056a181fb5b8; Thu, 3 Oct 2024 14:27:33 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id C0AD66A94EF;
	Thu,  3 Oct 2024 14:27:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1727958453;
	bh=jEAMNCHRCNFk0XXuAX03IGBLoSOBmVSAyuWjkpZfjNQ=;
	h=From:Subject:Date;
	b=WJXhs2fUYUk5+hrW1UONh6PVCplKrTtpg2xcylrNZjmUGURLsFWreTtCEEDE2yLMF
	 8gKqqdqEptQRB5g+M4gDuhG6NGda56KKsfPJ2fl86FZYF00vWyr6BCBUt4bD+acojJ
	 EObEZlkKRTAwkZARf/o7wvn5222RPk6h5r+kKgzwg+fKAztJYRuQf2ENn09pBZwvTa
	 hg5f2FwDU4sPA3fj31egO2VXvxU4XA6fhyIH9rlh9KX+0QIJCA1eDxd9jjyjHc44W2
	 +zLFnhVQ0uj9boK6pZL36IzdxmJWQSH9xyJ6lvqSECiNkRzyyFIisrngrfSKxHzfGY
	 qFVAyCpr/80zw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v2 2/2] thermal: core: Free tzp copy along with the thermal zone
Date: Thu, 03 Oct 2024 14:27:28 +0200
Message-ID: <4623516.LvFx2qVVIh@rjwysocki.net>
In-Reply-To: <12549318.O9o76ZdvQC@rjwysocki.net>
References: <12549318.O9o76ZdvQC@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvuddghedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthh
X-DCC--Metrics: v370.home.net.pl 0; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The object pointed to by tz->tzp may still be accessed after being
freed in thermal_zone_device_unregister(), so move the freeing of it
to the point after the removal completion has been completed at which
it cannot be accessed any more.

Fixes: 3d439b1a2ad3 ("thermal/core: Alloc-copy-free the thermal zone parameters structure")
Cc: 6.8+ <stable@vger.kernel.org> # 6.8+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: No changes

---
 drivers/thermal/thermal_core.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -1606,14 +1606,12 @@ void thermal_zone_device_unregister(stru
 	ida_destroy(&tz->ida);
 
 	device_del(&tz->device);
-
-	kfree(tz->tzp);
-
 	put_device(&tz->device);
 
 	thermal_notify_tz_delete(tz);
 
 	wait_for_completion(&tz->removal);
+	kfree(tz->tzp);
 	kfree(tz);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_unregister);




