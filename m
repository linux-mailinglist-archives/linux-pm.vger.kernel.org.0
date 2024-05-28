Return-Path: <linux-pm+bounces-8265-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6916F8D2209
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 18:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0806DB24DD0
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 16:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7B6176FCF;
	Tue, 28 May 2024 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="CLoLv4mz"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2EF174ED4;
	Tue, 28 May 2024 16:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716915268; cv=none; b=cceMInZBa98abGnT0CG2V9CGxrDwRCR97LfX++n00xCBJwK9K6QZO9Dv/Ag4CzcHJcKWr+8VaA1dwOVKCqj3AAv2GfNo2eYauhVoYRXSrxMDDcGNEF4DnlBYyLgDaU4nwlLeyu8BELKkFr1YhAjFa8Kycxs3PaVMdikhONeTP5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716915268; c=relaxed/simple;
	bh=LaJZJ53tpnaODCXD/iK5h1BRpPOOOLaIwgtxYtWn5FI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AuRG4xK0gQEkuJyDDAJnLjIMhUmjKMktezXQov7kQ8QrYm9VROOiM4r3SsZCmrjQHL/d1wr/BUmKgrjRCeV0T0KIPZbHtVqPxzr/zYNAcp+M+4dpk/cOsw6QouDFvzXmgEBwa0M7wOMkfCixL60V/FEGCNSOvPcu9eW6XxHcYDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=CLoLv4mz; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.1.0)
 id 37f692498a4967cc; Tue, 28 May 2024 18:54:24 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 16FCA6A5036;
	Tue, 28 May 2024 18:54:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1716915264;
	bh=LaJZJ53tpnaODCXD/iK5h1BRpPOOOLaIwgtxYtWn5FI=;
	h=From:To:Cc:Subject:Date;
	b=CLoLv4mzDESbf53ZTiz4pb9uAnVTvXFhehWgb+wlPqD9GDkcnkPUCpfqg2u9qi8t/
	 bJhEi9HatozjEmD0sGCuyMeVYtC4Kjx5KR42qXJl8XbpnfOLPLHSCO/1PRjVO6Y/ev
	 u+3vaw425KX6Wp4tXJRTrhbM2alOCjvCLxhDAMUFAdqaua65ccAsOe4xcUqjDH9qAs
	 WETxaY1U3xApgtMoDvIeWPS/FK9spLj4eRpEXzjuPc1OcjpAgKV4qdZfQTl+1OIJ5K
	 Y6c3IJRab0VuQl/TW4/7RteCTizH6uR9lq9Q+ygUgLZEV2EgOgAmri6mLaE7Zh9MK8
	 iYJ1uODIFxfBg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v2 0/5] thermal: core: Assorted improvements for v6.11
Date: Tue, 28 May 2024 18:47:33 +0200
Message-ID: <12458899.O9o76ZdvQC@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdejkedgjeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhr
 tghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

Hi Everyone,

This is an update of

https://lore.kernel.org/linux-pm/13518388.uLZWGnKmhe@kreacher/

which mostly is a rebase on top of the recent fixes:

https://lore.kernel.org/linux-pm/12438941.O9o76ZdvQC@kreacher/

and the first patch from v1 is gone it turned out to be controversial (I will
be sending a new version of it separately).

The patches in the series address some shortcomings in the thermal
core code (including the Bang-Bang governor) and clean it up somewhat.

Please refer to the individual patch changelogs for details.

This series is independent of the thermal debugfs one posted earlier today:

https://lore.kernel.org/linux-pm/5794974.DvuYhMxLoT@kreacher/

At one point I'm going to put this series on a git branch for easier
access/testing.

Thanks!




