Return-Path: <linux-pm+bounces-7724-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BB78C26AA
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 16:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D56CB239D0
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 14:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EBD171E45;
	Fri, 10 May 2024 14:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="FE9qX8ZW"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7429B1708A3;
	Fri, 10 May 2024 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715350847; cv=none; b=niRG0sfXhzkxfm5a/1vZY2CfY2KAPDhdXpN8oO5ZBZaI7pEdPdPpJnAKeSpxuqvTn1zNkiWhPgP6fzVWU750aLcHwIxJC+7R8gWpRz9hQjfrftxHNuBoaFC5up1LwbbZzSIZGnjFI4IpV6YdUed9y3YE+QQrnEeVLQzgylyqxPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715350847; c=relaxed/simple;
	bh=lcVUbJpgBRjtlZ1jA0Huac2XwIHQMj0wmWM0G4IfuhE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CS5BOwNnDEO7QkKqFq1Dwx8MbSCp3ZgDdVBashS73T+uoCnnWNFm0aQKXuWusZWWfem1C9w6keVna/EhSczZ3zTenHJlfaZJa4zy/yUMsxmwBT9D30e61yxwcn6WFlvlF+bc0pXt5FHkfLUwi2ZfrUs/6NMtOlvMR7dhc4l8oiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=FE9qX8ZW; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 4851dcd7d8e39ad0; Fri, 10 May 2024 16:20:43 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id DABA52102F3F;
	Fri, 10 May 2024 16:20:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1715350843;
	bh=lcVUbJpgBRjtlZ1jA0Huac2XwIHQMj0wmWM0G4IfuhE=;
	h=From:To:Cc:Subject:Date;
	b=FE9qX8ZWgmcVM4Y6qeFuuKmFtFEg+ZmW9BgP1+HTLkqhYpUBz4cwbFowFHp3gYihm
	 2jQKwm60tgKld0OTtd1lH5JZleigXdZOzC5yZP6lHTODjOI0Z3pNjVXPUVyMqxO5o3
	 gBYGcsWXAgNISTu0Y8EOuMsWllW9hsIoR/Ypd0sZgheowj7daWf8eUkz149Jo7+SHQ
	 l4uYvuS5hQxiGad13s/CKVgivM9o/DfRkJXmzTBMNko+n1Em+keUsWJzIfO4vBu49W
	 CPEGfM4MTynMmCwttxpUob3+79NRI5PqpSW6H7HlwSZ0+Du1mo1zQiJozvRebok3SM
	 mCBbZt0UNlLEQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v1 0/6] thermal: core: Assorted improvements for v6.11
Date: Fri, 10 May 2024 16:11:05 +0200
Message-ID: <13518388.uLZWGnKmhe@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgjeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhr
 tghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

Hi Everyone,

This series is for the 6.11 cycle, but since it is ready from my POV,
here it goes in case people have the time to look at it in the meantime.

The patches in the series address some shortcomings in the thermal
core code (including the Bang-Bang governor) and clean it up somewhat.

Please refer to the individual patch changelogs for details.

This series is independent of the thermal debugfs one posted yesterday:

https://lore.kernel.org/linux-pm/12438864.O9o76ZdvQC@kreacher/

At one point I'm going to put this series on a git branch for easier
access/testing.

Thanks!




