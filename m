Return-Path: <linux-pm+bounces-24059-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5A4A61289
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 14:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74D2F1886D69
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 13:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF311EE00A;
	Fri, 14 Mar 2025 13:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="rvdawaI4"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEC2D51C;
	Fri, 14 Mar 2025 13:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741958664; cv=none; b=rw38FoJN8ztbCoUqBBQs1pMbr3jjkISeXG35LOuOwaL6MhbV8T4Kr+eLT50ZGdusPlsb0sWuse/pT9ToGvMFkxOw+PzvJN7D4UJT7MOqexNHLjd2dg+Vr1jFZY9xJD0us/VR3HvB5YLqQkvgxVVQleMfEZCCPFgVA6VRvEMD7y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741958664; c=relaxed/simple;
	bh=IJZOrH14Gv7J87ZBvruGqnZzR0ux19/e4YrU9nV0ePU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z+C0S4dec23ag3FjrBwkx6loP7KJy8ydvvz9q/C/MLdAZr0guwOJtr4X4nlyGfqH8G+/fBfTkW3BB5NhEH/ZyH4CnbipoeBBe3uqeyTGsvbDJxRA2ezTlR2joYQTO3ydsGiw4DjKaUVRNb2AvkjbQVlJ2yk7j8x5gm4MCm9zqBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=rvdawaI4; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.3.1)
 id 3e2503f7a1427452; Fri, 14 Mar 2025 14:24:20 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 22C6F912CFB;
	Fri, 14 Mar 2025 14:24:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1741958660;
	bh=IJZOrH14Gv7J87ZBvruGqnZzR0ux19/e4YrU9nV0ePU=;
	h=From:Subject:Date;
	b=rvdawaI4TH8bLGvzNXdZWmyPb307L6b+UCUF4hBNhDdYKwKfnN31ATHOCcdca6Uvc
	 igE2SslaSjftGK46uHAK2z/ixxSmat4VQA0Nva1vWrMph7bb6+Lr0PGRtVMm2Ql2CZ
	 DLQYmuY1vOIJU3u4rV97d2454aoE0sKI6VQ76T8Zx8qpPRaDUOXZaYORzY2ydr5i3m
	 R6mtQejOKUBb0KLK7+tPGQYQ8RQhvytHk0hQmkybr0kjnMqLnIulRZQZTdX0HfsDG+
	 5WYJsUhtFq5gZyO8V1qI6kxq2kwKSjFI4w/4EaL0oZpdwib6Eu5s2hak/1nzEOHhRG
	 QWUConOjd4Zaw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jon Hunter <jonathanh@nvidia.com>, Saravana Kannan <saravanak@google.com>
Subject:
 [PATCH v3 0/5] PM: sleep: Improvements of async suspend and resume of devices
Date: Fri, 14 Mar 2025 13:46:59 +0100
Message-ID: <10629535.nUPlyArG6x@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedtleehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucfuphgrmhfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeekpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvghrnhesrhhofihlrghnugdrhhgrrhhvrghrugdrvgguuhdprhgtphh
X-DCC--Metrics: v370.home.net.pl 1024; Body=40 Fuz1=40 Fuz2=40

Hi Everyone,

This is a new iteration of the async suspend/resume improvements work:

https://lore.kernel.org/linux-pm/1915694.tdWV9SEqCh@rjwysocki.net/

which includes some rework and fixes of the patches in the series linked
above.  The most significant differences are splitting the second patch
into two patches and adding a change to treat consumers like children
during resume.

This new iteration is based on linux-pm.git/linux-next and on the recent
fix related to direct-complete:

https://lore.kernel.org/linux-pm/12627587.O9o76ZdvQC@rjwysocki.net/

The overall idea is still to start async processing for devices that have
at least some dependencies met, but not necessarily all of them, to avoid
overhead related to queuing too many async work items that will have to
wait for the processing of other devices before they can make progress.

Patch [1/5] does this in all resume phases, but it just takes children
into account (that is, async processing is started upfront for devices
without parents and then, after resuming each device, it is started for
the device's children).

Patches [2/5] does this in the suspend phase of system suspend and only
takes parents into account (that is, async processing is started upfront
for devices without any children and then, after suspending each device,
it is started for the device's parent).

Patch [3/5] extends it to the "late" and "noirq" suspend phases.

Patch [4/5] adds changes to treat suppliers like parents during suspend.
That is, async processing is started upfront for devices without any
children or consumers and then, after suspending each device, it is
started for the device's parent and suppliers.

Patch [5/5] adds changes to treat consumers like children during resume.
That is, async processing is started upfront for devices without a parent
or any suppliers and then, after resuming each device, it is started for
the device's children and consumers.

Preliminary test results from one sample system are below.

"Baseline" is the linux-pm.git/testing branch, "Parent/child"
is that branch with patches [1-3/5] applied and "Device links"
is that branch with patches [1-5/5] applied.

"s/r" means "regular" suspend/resume, noRPM is "late" suspend
and "early" resume, and noIRQ means the "noirq" phases of
suspend and resume, respectively.  The numbers are suspend
and resume times for each phase, in milliseconds.

         Baseline       Parent/child    Device links

       Suspend Resume  Suspend Resume  Suspend Resume

s/r    427     449     298     450     294     442
noRPM  13      1       13      1       13      1
noIRQ  31      25      28      24      28      26

s/r    408     442     298     443     301     447
noRPM  13      1       13      1       13      1
noIRQ  32      25      30      25      28      25

s/r    408     444     310     450     298     439
noRPM  13      1       13      1       13      1
noIRQ  31      24      31      26      31      24

It clearly shows an improvement in the suspend path after
applying patches [1-3/5], easily attributable to patch [2/5],
and clear difference after updating the async processing of
suppliers and consumers.

Note that there are systems where resume times are shorter after
patches [1-3/5] too, but more testing is necessary.

I do realize that this code can be optimized further, but it is not
particularly clear to me that any further optimizations would make
a significant difference and the changes in this series are deep
enough to do in one go.

Thanks!




