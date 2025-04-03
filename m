Return-Path: <linux-pm+bounces-24769-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF091A7AF6E
	for <lists+linux-pm@lfdr.de>; Thu,  3 Apr 2025 22:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 022CD7A14CD
	for <lists+linux-pm@lfdr.de>; Thu,  3 Apr 2025 20:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B982B21E0BC;
	Thu,  3 Apr 2025 19:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="kEh6zNO3"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765F7240608;
	Thu,  3 Apr 2025 19:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743708610; cv=none; b=NGGW67dZPp+Pmiu/oMUzEtTqxD8KBppLNjSk/FcGZ1zG9z+hoOXVdmF5neWnNG0mQ1BhaOMPCnatJU55r8JBT7rEBZjZ6i20eRkp+bn57XS4WvLumbmcg7Efo/L/MnNn9bayos5GbC4evUWsDBMTYbsgE6r8kCmb8uONagYoUDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743708610; c=relaxed/simple;
	bh=jc8qMlt1c1eQw+W1a0Rxp/TfA3rYdyvQzVG4iXwMJeM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pd7nwDFr0tQaoBFwc3TkRP0kkOHz8oS9wr2gqUv/CfoqeAlDTofo6Bj5/UnWfayK1A1UQm+BRNwaaEpER3moLCV4EsxcuSkcqRKqkvh2AG7uFJWjeL8dwpEWixN3wU3ztrDOHWfFeJln7bZImJ/3ojwRTFomuc5m6CSVGjHLavA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=kEh6zNO3; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.3.1)
 id 4e8db405cd3e6ab8; Thu, 3 Apr 2025 21:30:06 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id E856590158A;
	Thu,  3 Apr 2025 21:30:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1743708606;
	bh=jc8qMlt1c1eQw+W1a0Rxp/TfA3rYdyvQzVG4iXwMJeM=;
	h=From:Subject:Date;
	b=kEh6zNO3/Jg+/JjB/6QYatWF6Q2dII0Ql9R3mFaP58J7ODyLjYpTjOPI2QG8xA0we
	 UwSVUzhkFPHBoxOlxFgaWUSY2b3t6NjpIzEuZMqczTLwhQbZy1G1FvG3XvHXxLqQgc
	 Eo9AsnweEdjBH/QYPhdtP4su3Nl9NIQ7FJ9PeKb9cUT/cXvnxJWsglrcHDKUSDNznw
	 Hl1SORZc/pHSPFzlpr/9hZpplNNZtgUQAvUYpbDsQYhhp6Gl/ZyignHOp/MzEaMd4T
	 loO6zgXX5G4qc8r2LaDUyB1zWbwr11H4CnC7GGMLpH0RaTBQ4wlp3eluwJEuGjp/Zi
	 ecT4AbFt5IYDw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Doug Smythies <dsmythies@telus.net>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>
Subject: [PATCH v1 0/2] cpuidle: teo: Refine handling of short idle intervals
Date: Thu, 03 Apr 2025 21:16:08 +0200
Message-ID: <4661520.LvFx2qVVIh@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeelgedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepffffffekgfehheffleetieevfeefvefhleetjedvvdeijeejledvieehueevueffnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrlhhovghhlhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=21 Fuz1=21 Fuz2=21

Hi Everyone,

This series is intended to address an issue with overly aggressive selection
of idle state 0 (the polling state) in teo on x86 in some cases when timer
wakeups dominate the CPU wakeup pattern.

In those cases, timer wakeups are not taken into account when they are
within the LATENCY_THRESHOLD_NS range and the idle state selection may
be based entirely on non-timer wakeups which may be rare.  This causes
the prediction accuracy to be low and too much energy may be used as
a result.

The first patch is preparatory and it is not expected to make any
functional difference.

The second patch causes teo to take timer wakeups into account if it
is about to skip the tick_nohz_get_sleep_length() invocation, so they
get a chance to influence the idle state selection.

I have been using this series on my systems for several weeks and observed
a significant reduction of the polling state selection rate in multiple
workloads.

Thanks!




