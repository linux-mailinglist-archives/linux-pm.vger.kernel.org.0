Return-Path: <linux-pm+bounces-11559-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A637393FB47
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 18:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 508B61F22225
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 16:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDCD189F58;
	Mon, 29 Jul 2024 16:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="fYNcVWsC"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EF4186E46;
	Mon, 29 Jul 2024 16:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722270470; cv=none; b=PV89FMfRGWKvYTdviz/x5/iQhi24Q3WOYeKpxQeOVl4qMSci8TveXPLZyMKwxKpDgf9TttOcwPlB7AOeQkoFiyxeRxHRJI2zFaE+6ASi3NgBZZXCX8G5Ro+3QbYtoUwTyRp5F3LAaa5aT/FcWOFjpjpk+PFh4cCckY9HiHPwyAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722270470; c=relaxed/simple;
	bh=XXKQhSlrPr0msb++fBrVIUxJyyToBAblG0wxzgLhInU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fM6GsJMhg8sHvkhcDGwFLs7UDy3fH4yrR8lVtfijRdWyOWXy5iDEdYG5TL8pGe7IQElddsgQsAOm7403UZtZvUbyzpPKXMf2E1iTScrAbosR2qvUgu4+7le2gV53nchXocy38HjIPdPOGdsaOAQB0Ro1c9JwRbyiqB+gt39PdQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=fYNcVWsC reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 071fa75fd5c660ca; Mon, 29 Jul 2024 18:27:46 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id D270677357F;
	Mon, 29 Jul 2024 18:27:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1722270466;
	bh=XXKQhSlrPr0msb++fBrVIUxJyyToBAblG0wxzgLhInU=;
	h=From:To:Cc:Subject:Date;
	b=fYNcVWsCJDfsN1FR2rokihx1N8gzyvqgRFcuVg8XaxbqnQYyZniwr/v2U3cHEy7hk
	 0FdI8z81YQ67sNU4uIbgaLOOjFp9xltKg7nxRrxbd0mScmstGXO6PqHqXmimblJBYw
	 /hIzoHjGmXm2sY0HbX/76GWr73sQOgSkkyc7T9uCy4B9m81cwWu7WI/jBq2GbBanBU
	 e2+2L/Wp6T6Vb7g/+K3KPL9Cc5LYhGhue4i+AuVL9dcTsjSsPHFeyocav6gNnW92As
	 qv/D2lIZR7kiEMpDA3Nwebb707jW5h4ZdiHK3Sa2gUWRZKzeQGqQb4OAam7Kd7RquB
	 xzehvBnf0ONug==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>
Subject:
 [PATCH v1 0/3] thermal: sysfs: Get to trip attributes via the attribute
 argument of show/store
Date: Mon, 29 Jul 2024 18:24:02 +0200
Message-ID: <1960840.taCxCBeP46@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrjedvgddutddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepffffffekgfehheffleetieevfeefvefhleetjedvvdeijeejledvieehueevueffnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

Hi Everyone,

This series reworks the trip point sysfs interface to get to trips via the
attribute argument of show/store instead of using the attribute name to get
a trip ID and look up a trip using it.

It also adds a small cleanup (the last patch) for a good measure.

Thanks!




