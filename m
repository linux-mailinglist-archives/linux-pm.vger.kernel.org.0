Return-Path: <linux-pm+bounces-12162-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6589507FC
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 16:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497071C22372
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 14:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B628C19D062;
	Tue, 13 Aug 2024 14:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="L8PNQBb+"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC19125AC;
	Tue, 13 Aug 2024 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723560027; cv=none; b=aokd6zmYekn18/I0QaSeZYqtFZW6sXWpcsLGnx47nWgC9T8WINrq7aAkTX4ZHJmaqcIuCZyYU9Q8uULQEDmvqjYhG+cGGD59EKJMR4jhFaOWhGywVzB2v9ZjC1UOuSlkjE2HEg/WiYI72HSeXpmUQtp5gsze/q6eeRXXVDpw5Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723560027; c=relaxed/simple;
	bh=VfTachFUIsrZaw4U7xS4CrKA4r4zOSHY9SuORRnXawo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U/SMg5fq3AlSWDjudJ9j8Gh/U5WmfQRwQLVS9syUc350oV7oCmy7WtlybAJups5K2wNGHx1ppGqe8j00P7h95bD52Y5ko9Mb9XQ+kfV4jVSDoiGC9D0V/7O60uaEmteXK7MdiR1j0CnySnQ6o8MLAnSYNpJu6tP8wxbj8uyrVlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=L8PNQBb+ reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id b30a72e207a3cc2c; Tue, 13 Aug 2024 16:40:22 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 5502E6A89A1;
	Tue, 13 Aug 2024 16:40:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1723560022;
	bh=VfTachFUIsrZaw4U7xS4CrKA4r4zOSHY9SuORRnXawo=;
	h=From:Subject:Date;
	b=L8PNQBb+M4Mk4FQEJHMthV9jLRRqp+Su1xfDmjgnAdzXmodSyQR0iQBlVcUagwm3e
	 lDbhNL44i8CGhCdy3r/O6S2AlPPrmzu0qJvdhwBy5WUfIt87/ftPgrUK1o3NP7AN50
	 2hmkX8qSQpW/E7NjU6e1M7jMfGc4Jblqqzb749uKnUMDgJRspvdnOdpWRTPPw4RGLm
	 naFbp1JbDY0zJd1DxO806PwOH/OQxxKJxJrLMF02XvWl0Ci784PoCfgWjWqe3ienb8
	 MW/Udf6v7L/4t43Ul3C8BAQYjRzwsLCHOz8jDONLsL4C+uOa/7XZ768kWtMlCnlgw9
	 m7Be4XdvQpvXg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Peter =?ISO-8859-1?Q?K=E4stle?= <peter@piie.net>
Subject:
 [PATCH v1 0/4] thermal: gov_bang_bang: Prevent cooling devices from getting
 stuck in the "on" state
Date: Tue, 13 Aug 2024 16:23:35 +0200
Message-ID: <1903691.tdWV9SEqCh@rjwysocki.net>
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
X-VADE-SPAMSTATE: spam:low
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgjeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucfuphgrmhfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgs
 rgesrghrmhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehpvghtvghrsehpihhivgdrnhgvth
X-DCC--Metrics: v370.home.net.pl 1024; Body=24 Fuz1=24 Fuz2=24

Hi Everyone,

After changes made in 6.10, the Bang-bang governor has an initialization problem
on systems where cooling devices start in the "on" state, but the thermal zone
temperature stays below the corresponding trip points.

Namely, the Bang-bang governor only implements a .trip_crossed() callback which
only runs when a trip point is crossed.  If the zone temperature is always below
the trip point, that callback will never be invoked.  Now, if a cooling device
bound to that trip point starts in the "on" state, the governor has no chance
to change its state to "off".

This currently happens in the acerhdf driver, but it may as well happen elsewhere,
so I think that it needs to be addressed in the thermal subsystem.

It can be addressed by adding a .manage() callback to the Bang-bang governor,
which is done in patch [3/4].  That callback will be invoked every time
__thermal_zone_device_update() runs, not just when a trip is crossed, so it
can adjust the states of the cooling devices to the thermal zone temperature.
However, after running once, it becomes a pure needless overhead because the
states of cooling devices only need to be fixed up once (modulo some special
situations like system resume).

That's addressed in patch [4/4] which uses governor_data to store the information
on whether or not the states of the cooling devices will need to be adjusted.

Patches [1-2/4] are preliminary, but IMV it is better to make these changes
separately for clarity, but also in case they turn out to have a functional
effect which is not expected.

Overall, this series is a fix candidate for 6.11-rc because the change in
behavior addressed by it can be regarded as a regression with respect to 6.9.

Unfortunately, it affects this series:

https://lore.kernel.org/linux-pm/114901234.nniJfEyVGO@rjwysocki.net/

which will need to be reordered and rebased (slightly), but because I've dropped
one broken patch from it already, it will need to be changed anyway.

Thanks!




