Return-Path: <linux-pm+bounces-8255-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 236238D1F86
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 17:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 828C2B237C4
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 15:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A831D172BDE;
	Tue, 28 May 2024 15:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="nwiK7dkC"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17D1171E59;
	Tue, 28 May 2024 15:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716908476; cv=none; b=V7MzXZtjg7bCOuv973SAMkrB/jNlZDZUu9rQ9frX9SsU9sSAwrulcL+Jh1xnoiVeJ9G0cMaSxtVpB2ITly2i+g3gtdgP3mBX+UyY5uKjI2l9jfBfIqCRocNWjhem0pL7YU8y/xJFvCElySp5Hkq+Zrw6I3mHAge6MUeuHMos62s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716908476; c=relaxed/simple;
	bh=N748M5iSZSS97nVSnYySGTHnW84LP/wuTwcaAWQck1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pp9j95El/r72vYm6eY/a2MX251RYmeOsjAm7NOD8D9arQhFbxnqYjv8u9DQhibGGtQwC3hSff1+ghZAUIpi090GPEe/GcHt3Qc3hKHqOs3vYFc14jjuX0h2EPf5YIGxq9FPaq0PGVMAXBIEaCv91Vw31AFtoFVsg89R82Xbt970=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=nwiK7dkC reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.1.0)
 id 76ede143058c3e2a; Tue, 28 May 2024 17:01:07 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id F23D36A5015;
	Tue, 28 May 2024 17:01:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1716908467;
	bh=N748M5iSZSS97nVSnYySGTHnW84LP/wuTwcaAWQck1w=;
	h=From:To:Cc:Subject:Date;
	b=nwiK7dkCIUSAVzZdY9YOAbQX9mIcl/4GnjanAtpNAsTObFzujXeHZ1nr2eEzEAk6v
	 Hh4m/EzWLXMEDLR0hBGCMlvTS/yTauQEtAoQrGw8isB2zZew0ij2c532dc50GhGnG2
	 as7Vd38zJlUs4NsorYxWanL13wI27oK1c7/oJme+ncrX82Cn2i6ZBqSsYEk/p7OH/z
	 JtMg4IN3fOgTXJ2BS3DDAbhHDTv+o18pKO4APIMjW91teZ7nkmrOjVXNqxjGzt716N
	 7IHJBpxJzY4C0zE7oL+L8KuV7WCzlAH0rguhgCBUPeQ5YGIunRGtt00jyaxqvv0n4H
	 /VhDdccpT0Idg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject:
 [PATCH v2 0/8] thermal/debugfs: Assorted improvements for the 6.11 cycle
Date: Tue, 28 May 2024 16:51:09 +0200
Message-ID: <5794974.DvuYhMxLoT@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdejkedgheeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhr
 tghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

Hi Everyone,

This is an update of

https://lore.kernel.org/linux-pm/12438864.O9o76ZdvQC@kreacher/

which mostly is a rebase on top of the new fixes:

https://lore.kernel.org/linux-pm/12438941.O9o76ZdvQC@kreacher/

but one new patch has been added to the series (patch [5/8]).

The patches in the series address some minor issues in the thermal
debugfs code and clean it up somewhat.

Please refer to the individual patch changelogs for details.

At one point I'm going to put this series on a separate git branch
for easier access/testing.

Thanks!




