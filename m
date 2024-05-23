Return-Path: <linux-pm+bounces-8081-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 854448CD80C
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2024 18:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 003011F228DA
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2024 16:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EFC17BAA;
	Thu, 23 May 2024 16:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="w3Q//oAL"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA5E179AD;
	Thu, 23 May 2024 16:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716480321; cv=none; b=cRNKiGmuK8koXHiOwwErttnho2zRfrJ97ywXAGUfGtyLt8Tx8tbrgwDd9GVYscHb2ZTrWUWrVgbDGCqDZam8Ldy/6TKmKtc4XoCQQn7Og+NxYD3mo0VLDP1xjaLtrGT67d0bOYN181fZLeaAUJQ5qZ1Yf6STK8EhWpraXGUoK94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716480321; c=relaxed/simple;
	bh=GG5O6F5fwg3hjv086Pbkk7LC/OqlxCvBbLi0uEac3lI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=baG+eQBFOXnGms0FDICEQjGw3azPJVq2VKY4GNjEUTAe7LFsSJFD9J+rrqflyv7voLtzcV42Dbli9ebLWAr1KDOW0Beku5Zq0ecARIpmSXtziBTOOtlS1J0VWJo8Ef6/CxxukIJXEeLBmd+bI2kAzP9wxza5CRtxwwzamREXxF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=w3Q//oAL reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.1.0)
 id 889969608d4a76c0; Thu, 23 May 2024 18:05:12 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id C952F6A4927;
	Thu, 23 May 2024 18:05:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1716480312;
	bh=GG5O6F5fwg3hjv086Pbkk7LC/OqlxCvBbLi0uEac3lI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=w3Q//oALK72cSANyB5siDE3t96MfpSnZt7foty0oCCimGyfIJN7Te6wqC6DRbAAj/
	 S8GgGDKxJFJW/dJAyY/sEiAZkj7wk9AfR7RBdg/mOT8EDN2LOqGPJPOrsKr4WAIKIU
	 kWwg+TdhlJltqOoF4cMmAVZrdWSPFutx3DIdLyTikCA6j5Kh36y2hv3yo7K20GAvIs
	 OYQtcCyKU2oZu9gpKoBEFvs1XIRLQ2bFHWS1lQtQwegW3PawpbokkSU8Du4QdQHEoh
	 3HZ4EWnkVe+ITpAqE5pdLDrCsZ88ilVnjyh6tTzZo1TLpsUn4MXxUk6PHfZNrreYPq
	 sVr+johIRU04w==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v1 2/4] thermal/debugfs: Allow tze_seq_show() to print statistics for
 invalid trips
Date: Thu, 23 May 2024 17:58:42 +0200
Message-ID: <2323389.ElGaqSPkdT@kreacher>
In-Reply-To: <12438941.O9o76ZdvQC@kreacher>
References: <12438941.O9o76ZdvQC@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiiedgleehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigt
 rghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit a6258fde8de3 ("thermal/debugfs: Make tze_seq_show() skip invalid
trips and trips with no stats") modified tze_seq_show() to skip invalid
trips, but it overlooked the fact that a trip may become invalid during
a mitigation eposide involving it, in which case its statistics should
still be reported.

For this reason, remove the invalid trip temperature check from the
main loop in tze_seq_show().

The trips that have never been valid will still be skipped after this
change because there are no statistics to report for them.

Fixes: a6258fde8de3 ("thermal/debugfs: Make tze_seq_show() skip invalid trips and trips with no stats")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_debugfs.c |    4 ----
 1 file changed, 4 deletions(-)

Index: linux-pm/drivers/thermal/thermal_debugfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_debugfs.c
+++ linux-pm/drivers/thermal/thermal_debugfs.c
@@ -802,10 +802,6 @@ static int tze_seq_show(struct seq_file
 		const struct thermal_trip *trip = &td->trip;
 		struct trip_stats *trip_stats;
 
-		/* Skip invalid trips. */
-		if (trip->temperature == THERMAL_TEMP_INVALID)
-			continue;
-
 		/*
 		 * There is no possible mitigation happening at the
 		 * critical trip point, so the stats will be always




