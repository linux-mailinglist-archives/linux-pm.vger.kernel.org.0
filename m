Return-Path: <linux-pm+bounces-11232-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F4C9351FB
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2024 21:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF74A1C21215
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2024 19:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBC31459FD;
	Thu, 18 Jul 2024 19:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="H+90Uuoh"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9995A64A8F;
	Thu, 18 Jul 2024 19:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721329321; cv=none; b=sonGz+9lSNWincTG+Ip9gkgxdVe4D9IG/HlYrD8P0VcIer2bGq/yr0jbrYE28dlUQ9SLu6NXxvWAEGq6i84IHXaYPKzUyjMMnv9sI067J++nyu/eGKIcoBUuRludRab1nXWZ2Lur3ZcOX5ltGiOA9YvX/GWvhW5rh0Wkkn5tnbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721329321; c=relaxed/simple;
	bh=rBrqNlGHoyqxTj5lItqIEBVy+ITa0UoIHmj5CeHTN2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U2TiaUrw6hvdiDru+GjaWeYhGPp42mZ1gHrh8SeiBJBPsmbaS83mp0ckZUc9i5lPQy/YbM3aGbicEGMTsIkRaafABEnv67iZiLH1VTrPWi6HbG6aXII0gMZc4EObBn96qa8zJbsUU5dqfvOPDSlCBJFubcDVn1l/xwwVqfCKpZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=H+90Uuoh reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id eb960682e024e54f; Thu, 18 Jul 2024 21:01:57 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 03E176A1D1C;
	Thu, 18 Jul 2024 21:01:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1721329317;
	bh=rBrqNlGHoyqxTj5lItqIEBVy+ITa0UoIHmj5CeHTN2k=;
	h=From:To:Cc:Subject:Date;
	b=H+90UuohrdZ777vYD8zVF2BFoFMQtxsNPhqfQDuq4AtmE6e2AEKjKM+lQtHS1tZdd
	 y+jH5uM4/K/MwVlJ+XWRzyTbB+v1m8tKdZEhFCiN0JohzfMv3x2OuXC69U7ZM+lI3N
	 1kY/sPVWHnpDm2aBwileWxA3wpGkVwagy7KCsQwmA8RjHniZ+4dlxj+jpJLzE6BgI/
	 fX7ByXfJt4AI/CWf0cUj4NKwcJPTL6pLnfE+60r969EctuOb27F/fQaNdPAzErVciB
	 Lomm0gSu2N1+0PmMpRhn3x51PtzUqw9C2pBRMmKp+PWfa0/wlmNW5eO8yts187TP7N
	 CadHUKeFpIi5Q==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject:
 [PATCH v1 0/2] thermal: core: Handle failed temperature checks more carefully
Date: Thu, 18 Jul 2024 20:57:28 +0200
Message-ID: <2348857.ElGaqSPkdT@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrgeelgddufeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgr
 rhhordhorhhgpdhrtghpthhtohepnhgvihhlrdgrrhhmshhtrhhonhhgsehlihhnrghrohdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

Hi Everyone,

This series kind of augments

https://lore.kernel.org/linux-pm/4950004.31r3eYUQgx@rjwysocki.net/

so I'm considering adding it to 6.11.

The problem with handing temperature check errors in __thermal_zone_device_update()
after the above is that if someone has a dead thermal zone returning such errors
continuously lurking somewhere in their system, they will get a flood of
"temperature check failed" messages in the log which will be reported as a
regression.  Rightfully, because these messages render the kernel log
practically unusable and the continuous and useless polling of such a thermal
zone may even prevent the system from entering deep idle states.  Clearly,
something needs to be done about this.

One possible approach might be to simply disable the thermal zone in question
after the first error (that is not -EAGAIN) returned by its .get_temp()
callback, but that cannot be done because there are thermal zones in which
.get_temp() returns errors to start with, but they recover later, and they
need to be taken into account.

So the only other alternative that is not overly complicated is to add a
back-off mechanism to the polling, so the thermal zone has a chance to recover,
but the core will not wait for that forever.  At one point it will just disable
the thermal zone and let user space re-enable it if that's regarded as a good
idea.  This is done in the second patch and the first patch is preparatory.

Thanks!




