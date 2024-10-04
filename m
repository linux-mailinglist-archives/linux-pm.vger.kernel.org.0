Return-Path: <linux-pm+bounces-15161-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDCB990FE5
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 22:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CE4D1C2260C
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 20:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0636F1E04BF;
	Fri,  4 Oct 2024 19:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="vBL47Fg+"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE501E04AF;
	Fri,  4 Oct 2024 19:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728070992; cv=none; b=SPIlPNLSar8U2B11/CliNl10yd1Bjl6gWqBlDdoC9UURbZkYaSCantj9YcW9K5M26rlhw8c+HQqlQRdbJpPF8+MDTer4A4jq57aSRl15HmVI+UQF/upCqJrE7mgd2ECgV53alD6WXoRLKcIUyKP1CSlbFvIEJXWrjot4ffzmty8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728070992; c=relaxed/simple;
	bh=cy+WwnoBRC6rdTFM1PR8NdUhf8lZXn2Da1cPNppT9P8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RMKmZRgBTRzY5tEK71kdF+xXom965oyoM8abV4/+2/3Nlh3sxbJJVFMBjxc2nWt3VbNlwo915C6Cm7INEnwn+ZnmVMHkMoOwsr0GPHjVfajUF3YCaXVQ8F2d0X+cYiFPgEpmKCu63vLC2v0ylqqKVKU0bkKrx5rqtPgn6k7EtRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=vBL47Fg+; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id cef8527249cd07f2; Fri, 4 Oct 2024 21:43:09 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id CC1DC6A9505;
	Fri,  4 Oct 2024 21:43:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1728070988;
	bh=cy+WwnoBRC6rdTFM1PR8NdUhf8lZXn2Da1cPNppT9P8=;
	h=From:Subject:Date;
	b=vBL47Fg+IAWLfp/gXX1j57XJRUlzqO5q2WuYNjwI1Ywzk/xLbQ7pOuR+Cw1JRpk/w
	 qmEYEDR8cL30IPUa7X3PmtvDZrGhlLlP8RpvGGYmHz7PoF1kyU5AA8B/Bg4VnqbxeQ
	 3TFeWRqHjyr2mNcsO6GcEaOWXfvzQzEijf0H0TnoUYN/xUARe2gtBe5lJl9eHBwlCp
	 Ts/EVkrSsTMczHARfYmHSJ3lMBfDtzHIHhPxSSehC7Vda5ciRSLeM25xiJ4ZWeSYx4
	 fvmXRmryXDvQGPv6fPNJ3UT7MJ6rNq+RPTRHvkaVZnhaLcFOrdIxOD5niSAAx7qcrh
	 9QnUg/vCYqGfw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 00/12] thermal: core: Fixes and cleanups,
 mostly related to thermal zone init and exit
Date: Fri, 04 Oct 2024 21:01:34 +0200
Message-ID: <2215082.irdbgypaU6@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvfedgudegtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhg
X-DCC--Metrics: v370.home.net.pl 0; Body=6 Fuz1=6 Fuz2=6

Hi Everyone,

After posting the two series of thermal core patches for 6.13:

https://lore.kernel.org/linux-pm/4920970.GXAFRqVoOG@rjwysocki.net/

and

https://lore.kernel.org/linux-pm/6100907.lOV4Wx5bFT@rjwysocki.net/

before the 6.12 merge window, I have decided to reorder the changes included in
these series, so that fixes and more significant cleanups (for example, changing
they layout of data structures) go first, followed by the changes related to
using guards for locking, and the optimization involving sorted lists becomes
the last piece.

This series is the first part and the majority of patches in it come from the
second (RFC) series mentioned above.  Of course, they needed to be rebased to
be applied in the new order.  It is on top of 6.12-rc1 with

https://lore.kernel.org/linux-pm/12549318.O9o76ZdvQC@rjwysocki.net/

applied and it will be added to my thermal-core-testing branch.  It is in v2
to start with because all of the patches in it have already been posted in
some form.

The first 10 patches fix some potential issues related to thermal zone
initialization and exit (for example, user space may start to interact with
a thermal zone during its initialization before it's ready and system suspend
taking place at a wrong time may skip a new thermal zone so it is not suspended)
and do some cleanups related to that.  This concludes with the removal of the
need_update field from struct thermal_zone_device.

The last two patches move lists of thermal instances from thermal zones to
trip point descriptors and clean up some code on top of that.

Please refer to the individual patch changelogs for details.

Thanks!




