Return-Path: <linux-pm+bounces-7718-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7998C269E
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 16:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30B8A1F21A54
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 14:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D8712DD93;
	Fri, 10 May 2024 14:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="VBq0zP5v"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C978A12C47F;
	Fri, 10 May 2024 14:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715350842; cv=none; b=qYtkf3Ad5ZYHcrtJDATpQ1dAnOZOxGL7LVDTPQ6zoBlvo0m3wdGPPZu/PVWg16fYxe+khfYfL8kyjqnxSsJGplBXxn7PLzw3gn0AoX0pMGSQDGkRWj9vSt3UmE7SnW/cu8Fppd8ezM3aOjwqCamkmFY8hnJ13v9kq1yz9p/OsFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715350842; c=relaxed/simple;
	bh=MNyvpEHau6tG2fMo/BWUIa2kNh/gvrjnkt3+CERqIOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HOtviy2RGgmvp1JGms+xDF2hitjxDYHjGY0osHKA2sDiF6iY+dQ2GjIG+gVNI6AzLOmgvyLc/zyTuv8dKXJy3NSnk0d1C4PUhNMtC0iqg9ZZGb6j5i/bkGIIMlLaSadO/8YSYZQ8tRLV1rDH0lj3Pn72Dm1SkA5wZhXY8ufb7Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=VBq0zP5v reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id c1ac3eeb1b32e183; Fri, 10 May 2024 16:20:38 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 2B8BA2102F3F;
	Fri, 10 May 2024 16:20:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1715350838;
	bh=MNyvpEHau6tG2fMo/BWUIa2kNh/gvrjnkt3+CERqIOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VBq0zP5vMlqwfQqOGc48PQGKksnCEZgqZ8YkMJvZZ4T9x1Y0Y6peuWGRbdJ+Oc0hi
	 /NykKDy/SIn7THGL5urvqHZjiTWO6msUMhZGAvSSkU9SuXkO7s7c1H/IQUm3O4pzOR
	 7dnjitmJHkjwzem3Ppd8n0xB/K1TAtuDXQXEvrp7htkE1MFZnkm+vwuJFTdQvCUkjG
	 Zavujo5yZgpCoaawN+Atdl0MxzGeVqFQyM//2/QANR+M68x5M1NYaDUhkq7J+HMo1Y
	 8WrsarcWPVp8uUjcTcUHmcj4vTBBGTUeNyksJFYNmATo/SSr7oQx13mVi/Mq8aP4CE
	 KzTHUwPo6eAdA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v1 6/6] thermal: core: Avoid calling .trip_crossed() for critical and
 hot trips
Date: Fri, 10 May 2024 16:20:25 +0200
Message-ID: <3229987.5fSG56mABF@kreacher>
In-Reply-To: <13518388.uLZWGnKmhe@kreacher>
References: <13518388.uLZWGnKmhe@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgjeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigt
 rghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Invoking the governor .trip_crossed() callback for critical and hot
trips is pointless because they are handled directly by the core,
so make thermal_governor_trip_crossed() avoid doing that.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -463,6 +463,9 @@ static void thermal_governor_trip_crosse
 					  const struct thermal_trip *trip,
 					  bool crossed_up)
 {
+	if (trip->type == THERMAL_TRIP_HOT || trip->type == THERMAL_TRIP_CRITICAL)
+		return;
+
 	if (governor->trip_crossed)
 		governor->trip_crossed(tz, trip, crossed_up);
 }




