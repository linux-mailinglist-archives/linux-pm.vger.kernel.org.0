Return-Path: <linux-pm+bounces-12894-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 563A395F6F6
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 18:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88A661C21B75
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 16:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2E4198825;
	Mon, 26 Aug 2024 16:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="dp/aA7nc"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60C8194A42;
	Mon, 26 Aug 2024 16:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724690564; cv=none; b=bN5d7A8l9EyXOSSoulYyKjmBUvGGwnTiK60RV1LUzgEDbea6vDUKP1IzY2gXaacGjbByqnk/lCHTXpaaE0VilmE6QdDaD11RxdJxnfk0KM1BWH3cIuo44c5sm7ql+bZTNd9+mqaIG+AgDO3IPuLh0BeYy+7+DxS8pnWR5I9lN2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724690564; c=relaxed/simple;
	bh=WcuaJ2b4fvGticrZdHKumtPlzZ6cefldpCf3zbcD6HQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OyaZ964ZVlyxVAUT7A+3PC+basU+dAQhZJUcquAU5qlEpYRjurcydX+v4I+7sLXQxCAdMYAedxVcOgFW5GjAui8lECiz0ToFMKoIXeo0O4KrJAav3LH9BYcssciYcgU0PTUGHEdlTp4XxTfaQmMULFpxiV3UMegPS0r08mFfecg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=dp/aA7nc; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 5eabc14a0ac6440d; Mon, 26 Aug 2024 18:42:39 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 46B9A921951;
	Mon, 26 Aug 2024 18:42:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724690559;
	bh=WcuaJ2b4fvGticrZdHKumtPlzZ6cefldpCf3zbcD6HQ=;
	h=From:Subject:Date;
	b=dp/aA7ncFJtAEFEz3JgwpGpEQpLa8FwW/4uUgBy2/pTrVTRar4KmcqtfIbW8gT4c3
	 xBATgo+efLGT5WQrRM1gAfGwrn1n+o94HDcgSGUS63VqImdiOQiRwDTE+fc+F35Uh9
	 SRLqkMpPymPhUfY5eWUmnZbggcpGqLtL/ba3qiJS6amWXDMtEUpxkrSAEYHsfGe8VS
	 BMux0DnglT67S/C0Hma5YrrVvCIAy61jk2RWJ+G1wIptUW3j3Y8ZuM2grVT5Ljoxjb
	 v9W9Sh1+VS/TesQf603PbLQ+aXkqacpChnM5+pDOhGTdUiYY1/hMcucITF/i+wzqs5
	 gYrT5f08GYNxg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Huisong Li <lihuisong@huawei.com>
Subject: [PATCH v1 0/4] thermal: core: More cleanups after bind/unbind changes
Date: Mon, 26 Aug 2024 18:29:41 +0200
Message-ID: <2979211.e9J7NaK4W3@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddruddvkedguddtvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhprghmkfhpucdlfedttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgv
 iigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhihhhuihhsohhngheshhhurgifvghirdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=18 Fuz1=18 Fuz2=18

Hi Everyone,

These are additional cleanups that can be done on top of

https://lore.kernel.org/linux-pm/2205737.irdbgypaU6@rjwysocki.net/

and

https://lore.kernel.org/linux-pm/12516814.O9o76ZdvQC@rjwysocki.net/

Thanks!




