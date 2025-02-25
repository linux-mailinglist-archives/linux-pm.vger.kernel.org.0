Return-Path: <linux-pm+bounces-22904-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2C0A44719
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 17:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7368F7B09B5
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 16:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27E81A2547;
	Tue, 25 Feb 2025 16:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="AMpBHNJa"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF62319CC34;
	Tue, 25 Feb 2025 16:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501989; cv=none; b=fA9yDbQ4Vkg41faJJArfclh/Oi1lOFdhNKryw2G6CGY3llPxXov7b8XaLN42F5F88+OwdTdGGVErwgJqzi+jImrbolC95EvSXXkfG0DUdfp51nstg+DSZukfStI+6rKNpnYh6fGlBX3kKuAJ6Jjc17OGgc8onGJ9i0qJXtroQF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501989; c=relaxed/simple;
	bh=rUhGtkeEKO5bgIAnZW0g4xICaX1zD95BWrXoltsZvcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cLZe4MjNbqlIKS9MGb3vYeKZ7ESdqw8F9jOIgkMv7TN1axHgiIxsvc906QlbD+WOMOJgHUOQi7qtX9N+KSHtiQnGU26qsISIsJX5DH5zvugSyyJsOuuGAGC+9IeW3cgQM32KvgOdqNQk87lco7Jne+4dnQDO60VgTDt8jxmH53Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=AMpBHNJa; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 25b314a4524873c0; Tue, 25 Feb 2025 17:46:20 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 943EC22C28BF;
	Tue, 25 Feb 2025 17:46:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1740501980;
	bh=rUhGtkeEKO5bgIAnZW0g4xICaX1zD95BWrXoltsZvcQ=;
	h=From:Subject:Date;
	b=AMpBHNJaC6riQO5RLvDgwyK/IRNpNgzCCdUYJYTbF8ee79t1G0ZTDm2ixoJa+50PS
	 Nblp9kB93bYuzFBzXtED611EuWCeYCAXlgfYkC9rsAM7QEyH2Q+eyb0xsS9WvK/+DQ
	 DgOXj1/H5RQjBrj0Bz6Q6g+20dXpzy78TBFbUIbqwCGWdpZevXZTDHA2MCibhmzFP9
	 Hzt32Z5QbPvWrMNSfw9gBgBowBs/thQ1XBWT13gtfhFDBhu48oKI1uOR6ZWkYEUUL3
	 QUA9KLnDa7n2brdDMI4OheoL64lMrxxHAFC652oOr0bfgU8l4CkZufYvAYYO4uTK5U
	 tSquc+5pl4E0g==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Saravana Kannan <saravanak@google.com>
Subject:
 [PATCH v1 0/5] PM: sleep: Improvements of async suspend and resume of devices
Date: Tue, 25 Feb 2025 17:38:01 +0100
Message-ID: <13709135.uLZWGnKmhe@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekvddvvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgvrhhnsehrohiflhgrnhgurdhhrghrvhgrrhgurdgvughupdhrtghpthhtohepuhhlfhdrhhgrnhhsshhonheslhhinhgrrhhordhorhhgpdhrtghpthhtohepjhhohhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

Hi Everyone,

Initially, this was an attempt to address the problems described by
Saravana related to spawning async work for any async device upfront
in the resume path:

https://lore.kernel.org/linux-pm/20241114220921.2529905-1-saravanak@google.com/

but then I realized that it could be extended to the suspend path and
used for speeding it up, which it really does.

Overall, the idea is that instead of starting an async work item for every
async device upfront, which is not very efficient because the majority of
those devices will not be able to make progress due to dependencies anyway,
the async handling is only started upfront for the devices that are likely
to be able to make progress.  That is, devices without parents in the resume
path and leaf devices (ie. devices without children or consumers) in the
suspend path (the underlying observation here is that devices without parents
are likely to have no suppliers too whereas devices without children that
have consumers are not unheard of).  This allows to reduce the amount of
processing that needs to be done to start with.

Then, after processing every device ("async" or "sync"), "async" processing
is started for some devices that have been "unblocked" by it, which are its
children in the resume path or its parent and its suppliers in the suspend
path.  This allows asynchronous handling to start as soon as it makes sense
without delaying the "async" devices unnecessarily.

Fortunately, the additional plumbing needed to implement this is not
particularly complicated.

The first two patches in the series are preparatory.

Patch [3/5] deals with the resume path for all device resume phases.

Patch [4/5] optimizes the "suspend" phase which has the most visible effect (on
the systems in my office the speedup is in the 100 ms range which is around 20%
of the total device resume time).

Patch [5/5] extend this to the "suspend late" and "suspend noirq" phases.

Thanks!




