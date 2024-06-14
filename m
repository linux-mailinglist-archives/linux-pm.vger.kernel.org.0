Return-Path: <linux-pm+bounces-9199-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD2D908EB0
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 17:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDB3D281C7A
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 15:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AED216D339;
	Fri, 14 Jun 2024 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Peoyu2Ei"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FBAF9D9;
	Fri, 14 Jun 2024 15:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718378802; cv=none; b=t0nsfj4uz5/H5wI4Al4zYrWheOs/iQDC0Qg7OJAbZEM7ivnQHla+zthm32R2kNPXzn03vJ+rYAT56xD2BumhDa8AyQHeidv62ZClxIB1Z+/z8wgzj9qP4ALtmApwl0lpGcBZVtqQU6RQ2cqDc1ziYa04Sl84Se/vQ+pOXBbOnuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718378802; c=relaxed/simple;
	bh=48UjPWTNXZzkXecEqeMbmgt02fHt9UfpMcTHgiKpMqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rdB5+/ZtcPVew1k62mTpSFFJPZ1suC9yL+617vDQGJwXp5ZfBaWRSTRD1dnUvSWBRcB8eHIZB7Jnsxm1Y6OwPxZfjhcFwNvExs00JO9OTSe3qOiNcDDvvrykObAjs0HbMwBa6LqzlTgnr9VxSFWG50rYiyXBcU2f+IdwbBdRUHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Peoyu2Ei reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id c4c5bc8300185fbc; Fri, 14 Jun 2024 17:26:37 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 0E1E96A7417;
	Fri, 14 Jun 2024 17:26:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1718378797;
	bh=48UjPWTNXZzkXecEqeMbmgt02fHt9UfpMcTHgiKpMqA=;
	h=From:To:Cc:Subject:Date;
	b=Peoyu2Ei8EuvhGittu8N1N6Po2ZhU5XK4tOihcv43NPFlqDY6lJ+AnmXS10VKYJmV
	 17/gqR53BWY3YwtW3OfPZbNsLAZ9TvIzWf/9EqiwyqAUydOZilzfiq5J296w/9jnnu
	 siQ9CmatT0ycdI8DeLcq5q82NTKRXFaARpQZFUkE9lrBDixU4XNqu8FdpCvE+fmAB0
	 ygm+FLCl1Ox7cboCLeCshKilXBbvwx0eAvquaWx4viw1eK3jku1m6CqrhvmkXlCL6H
	 nls1YiydeoCRyz/pn+NyfrTRvdLhLhZro2NUR4aBoS+VTNz0tI649/EG8R+Gqwjt3u
	 icuoC3uYwhvhQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v1 0/2] thermal: core: Fix two issues related to thermal zone resume
Date: Fri, 14 Jun 2024 17:17:35 +0200
Message-ID: <6070114.lOV4Wx5bFT@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrfeduledgkeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepffffffekgfehheffleetieevfeefvefhleetjedvvdeijeejledvieehueevueffnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehsrhhinhhi
 vhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

Hi Everyone,

There are two issues resulting from asynchronous suspend of thermal zones.

One of them is platform-specific and related to some firmware issue (I think)
causing battery readings to become invalid after a system resume due to
interference between ACPI battery resume and a thermal zone update.  This
can be addressed by running the thermal PM notifier after all of the other
PM notifiers (including the ACPI battery one) which is done by patch [2/2].

The other one is mostly theoretical, but I couldn't convince myself that it
cannot happen.  Namely, a leftover thermal zone resume running during the
next system suspend (if it is carried out back-to-back with the previous
suspend-resume cycle) can accidentally reset tz->suspended set for a thermal
zone by the thermal pre-suspend PM notifier.  This is addressed by patch
[1/2] (which goes before the second one because the latter increases the
likelihood of the issue slightly).

Thanks!




