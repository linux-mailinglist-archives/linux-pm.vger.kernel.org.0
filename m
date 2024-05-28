Return-Path: <linux-pm+bounces-8261-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B86F8D2201
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 18:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97EBA1F23AA3
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 16:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E6817333F;
	Tue, 28 May 2024 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="nMLigcU7"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ECB172BCE;
	Tue, 28 May 2024 16:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716915265; cv=none; b=IejxRGSyF6yGhBKw9OkS0tWk59iZlVWQL0xUIVTceMAnm94UweK6QfRrMmQ3ke0DfPcF0FAUbQDbFgau3xoW13lW8F7r8GwOSa5DmZxGK8NxC8fKzjRIMA9r6P6e1E2TyFZ8S+0K7rYHlzX45HUZ3SDQ+8MYvPjrqqpkJG06ej8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716915265; c=relaxed/simple;
	bh=ZFY3hO8BREpKs43Exr0jP3HTgfME6rUtFCseLnYt4NY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J/717L455Pufuzg8tcPfsHNWJdJl3RkXRT6j4KlfC7oLVhtfzDbgnigFu/Eph1qYk4KkwkRrVs0NYD0d9p0CtzAhAlQHUGJ6KiuimlcX5X6mtBjmyEsh4sXwGSrgVjPv65zDFKCu6RFzSkLx8ODzjq2Yd+84Q0ubjJPdSAMOYRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=nMLigcU7 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.1.0)
 id b21576a730ce3ccd; Tue, 28 May 2024 18:54:21 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 51A176A5036;
	Tue, 28 May 2024 18:54:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1716915260;
	bh=ZFY3hO8BREpKs43Exr0jP3HTgfME6rUtFCseLnYt4NY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nMLigcU7ug2y+P4XHklGwrB02zjHc+cTZW2HD4J+X7V44Uj9uojou4dOT2f+/i5f8
	 HD/x6BE0SCBMyJ9mLvE/JhS79NHz8HKh29psC0Vw30/7hiHU4M/PdKLC24rdTNWusD
	 vtPU6MTLjq/yf4yUAQssDb0dziD6VE33wdpjosM4jIv01AEpyZoFylQ5K7FuEO8Vqc
	 Dits19LIHwSO3RJzhLEAtbgjJV8DXLuIffhEYH+o0BtuU52ELzvvQgW8Pc4izdbL4n
	 /qYR6yMqTU3fUqPmE1CGtUF6N9R9siAorey2SRuXAiyWt9/Bq5Vub0FPGpTzs1Y0l1
	 f9vqN6dNbiwBQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v2 4/5] thermal: gov_bang_bang: Drop unnecessary cooling device target
 state checks
Date: Tue, 28 May 2024 18:54:01 +0200
Message-ID: <3312910.44csPzL39Z@kreacher>
In-Reply-To: <12458899.O9o76ZdvQC@kreacher>
References: <12458899.O9o76ZdvQC@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdejkedgjeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigt
 rghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Some cooling device target state checks in bang_bang_control()
done before setting the new target state are not necessary after
recent changes, so drop them.

Also avoid updating the target state before checking it for
unexpected values.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Rebase.

---
 drivers/thermal/gov_bang_bang.c |   14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

Index: linux-pm/drivers/thermal/gov_bang_bang.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_bang_bang.c
+++ linux-pm/drivers/thermal/gov_bang_bang.c
@@ -57,24 +57,16 @@ static void bang_bang_control(struct the
 		if (instance->trip != trip)
 			continue;
 
-		if (instance->target == THERMAL_NO_TARGET)
-			instance->target = 0;
-
-		if (instance->target != 0 && instance->target != 1) {
+		if (instance->target != 0 && instance->target != 1 &&
+		    instance->target != THERMAL_NO_TARGET)
 			pr_debug("Unexpected state %ld of thermal instance %s in bang-bang\n",
 				 instance->target, instance->name);
 
-			instance->target = 1;
-		}
-
 		/*
 		 * Enable the fan when the trip is crossed on the way up and
 		 * disable it when the trip is crossed on the way down.
 		 */
-		if (instance->target == 0 && crossed_up)
-			instance->target = 1;
-		else if (instance->target == 1 && !crossed_up)
-			instance->target = 0;
+		instance->target = crossed_up;
 
 		dev_dbg(&instance->cdev->device, "target=%ld\n", instance->target);
 




