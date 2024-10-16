Return-Path: <linux-pm+bounces-15766-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D145A9A0889
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 13:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 501EBB261F3
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 11:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71990208D65;
	Wed, 16 Oct 2024 11:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="LpEyiM3+"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4399F207A14;
	Wed, 16 Oct 2024 11:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729078633; cv=none; b=g9HScqyKPDwiiSrrj+LAwDxB0Y3ZqTZBWnIeyUhMPwa0z4vHKcE3DDhVP4mLvlMvuOHj+76OXlUJbWnTsI1+ojJwb0wM8VzKIp9fuibY0YVYNVMhCzPoOId39LkwYJ3c5d8rmRRdbgGk9Y7rr0lmHtNDedSnrQPfZbIrJA27gic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729078633; c=relaxed/simple;
	bh=76QKndxDA+IaFaY9k410sARjtdgxvy3vRJMgnHMKRd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Xv7Q11pkkYg24qVA8NhfMTc7pdGa+qEn+iA3DJKHG2PV3SWtmqjRD6xvtC73PIrLPaFM+ohezTODI9f9GOM0B8DXlAcs0KL/5lnF9US0R0ks69DCUZN6TG0/7HrHa01qULIJnXxaV8s+QS3rUBWxChkv+ItXykHTrZ10BeXp7I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=LpEyiM3+ reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id e62a46e88c026e50; Wed, 16 Oct 2024 13:37:03 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 6B135A9396A;
	Wed, 16 Oct 2024 13:37:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1729078623;
	bh=76QKndxDA+IaFaY9k410sARjtdgxvy3vRJMgnHMKRd4=;
	h=From:Subject:Date;
	b=LpEyiM3+2b3hvbA44WXXfMnYSQibpNa8Yr79xjn79iQl0zpcxeLuieyOfJuweH6Sx
	 syyqOosXy3YhtVTTjltkj84KSbXF+BZwe0sFTlVBQmt5/t8d5JzUBaSdwgv3Q/TKfD
	 3hCB77LRVKYOqwLjwnEoW9FiJ44fZa+UJGI1+b71cVn6p8w60QQPSfXgjn9siRLMQL
	 ryOuijVZb6AlsB/vPDPbmawmn0XAgWUTRYCb6keJpl1ohyHh1lPjlWR6REG+SuakZs
	 jukyLFwMCENEglG6r3Xg1Iv0TN7AI6N7R/WB53O1v12dwOGHPUvt0XYn7Gr8j64Tah
	 uFpNmgit0qtzg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1 00/10] thermal: core: Use lists of trips for trip crossing
 detection and handling
Date: Wed, 16 Oct 2024 13:18:00 +0200
Message-ID: <4958885.31r3eYUQgx@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegledggeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheprhhuihdriihhrgh
X-DCC--Metrics: v370.home.net.pl 0; Body=6 Fuz1=6 Fuz2=6

Hi Everyone,

This is a continuation of

https://lore.kernel.org/linux-pm/4985597.31r3eYUQgx@rjwysocki.net/

derived from patches [3-7/8] in the following patch series:

https://lore.kernel.org/linux-pm/4920970.GXAFRqVoOG@rjwysocki.net/

but mostly rewritten.

It is based on the observation that putting trip points on sorted lists
allows to reduce overhead related to the handling of them in some cases.
Namely, it avoids the need to walk all trips in a thermal zone every
time the zone temperature is updated (including invalid ones) and
generally leads to cleaner code.

Patches [01-08/10] are preliminary, patch [09/10] makes the key changes,
and patch [10/10] is a super-cosmetic cleanup on top of the rest.

Please refer to the individual patch changelogs for details.

Thanks!




