Return-Path: <linux-pm+bounces-20372-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE75A0C0CD
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 19:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C99F3A1000
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 18:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665EE1B6D06;
	Mon, 13 Jan 2025 18:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Qh9JVA8M"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4433E1C5499;
	Mon, 13 Jan 2025 18:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736794346; cv=none; b=bUtMTlasJBFvQT0j67OPshibMIcyy+iwzF0y8o93BxlBy/2k8FO5M0tyj47CoLHPoLKt8Fm9Ct3IzWRkzkbDoudsWO5udpqr1XxjwZPmZEEGyurI/G/UH75myy/g1s0QrcQf30qtpSE4+YoK9DhS0WCGVW0HHjmxpV4anXTAOBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736794346; c=relaxed/simple;
	bh=mtLe416Z6djWnbHAw+MPNJngoU8CA1RcdYTbNu+sD+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CLlu6xGzdtuZg2m3URt/ng0/Q39kfPHhn2Ru/J05wdyglyqu/BVGIWpNBqxb/gaYxegcqmAEmIlPGAPfguuy60Lz5P3tQQgp6zbJ9X4mrpb4/Qu7X/cSzbijDtmYvT8mh/6mqBSsy43HzjtKX+CrK/6rWLLQ+XX1FHEa0FsVtYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Qh9JVA8M; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id fc064d26d4154dbc; Mon, 13 Jan 2025 19:52:22 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id A9C668E0A24;
	Mon, 13 Jan 2025 19:52:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1736794342;
	bh=mtLe416Z6djWnbHAw+MPNJngoU8CA1RcdYTbNu+sD+w=;
	h=From:Subject:Date;
	b=Qh9JVA8MAEnFO4dLgEMSJslCjqSBSQxnAHsOSgYinlR6GdT+b+YqKxIIQg+Jv0nla
	 Gos2+KjOnPOb5b2ItcHpsfS37r6IyslaQCCNxSS/kUqUy+Rj6FCJMefVU8ShqyRHae
	 oiQlk29vJCRv5/Hio2SEvpcvXoayGhzm6cx1ky+TGaArR8WigkKGghYf5J9gC8+mWO
	 +x74Bt0ViD1VshUAfv7aZOcfn/kQXB+Wtf3smiA3asDjXCJLmATu1pFq6HmyZwbknz
	 LLPA4Cvdk3VeOtqct7QwaTnXY4DjBALCuku+SJAoH5SBKtRl/9PFEFY7DpiYDTr4Bs
	 FBmQHQ/nIhizA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject:
 [PATCH v1 0/9] cpuidle: teo: Cleanups and very frequent wakeups handling
 update
Date: Mon, 13 Jan 2025 19:32:13 +0100
Message-ID: <6116275.lOV4Wx5bFT@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrudehgedguddujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrlhhovghhlhgvsegrrhhmrdgtohhmpdhrtghpthhtoheprgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

Hi Everyone,

This supersedes

https://lore.kernel.org/linux-pm/4953183.GXAFRqVoOG@rjwysocki.net/

but because the majority of patches in it are new, I've decided to count
version numbers back from 1.

This addresses a relatively recently added inconsistency in behavior of the teo
governor regarding the handling of very frequent wakeups handling (patch [7/9])
and makes some other changes that may be regarded as cleanups.

Please review.

Thanks!




