Return-Path: <linux-pm+bounces-12770-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E9F95BEFC
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 21:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3D03B232B2
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 19:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5851D0DC3;
	Thu, 22 Aug 2024 19:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="r2VM2WSt"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC2628EA;
	Thu, 22 Aug 2024 19:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724355367; cv=none; b=CQZsBW5D0bT8zX64IPInNpBWn3tmvQcH2X3VJf+sH8ZkKy0uPQmyqwAlB3QtWoGE7IHNdm51c3c3XdiryUoNZbYqSpnLG25VPr5FS52QfFc/3jCQSgACTgcv0guyc4EtrOBKh9hfJcsdsV3lJYcoXmu5W19MSCICwA3WBSONn8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724355367; c=relaxed/simple;
	bh=XpNib123fDRdKI1Co7t0LWgsdV+o9o6EjfyXbabzz3I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fsa1zPEKAwoZOEe89hJJyvt+I7gIIqaBvOzCVxZaG1dF6kLVXzrv+jTuSj7le/TpjE3HNYiqwJoHh22J/zVGDUtzo/E1EoWy1ZsqsJZBjz/NHk/0bddOaZwauK3Q+ViKxpFKIPrhk40nFebtOJ45111KNmxXNScQaCzuc8IPrcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=r2VM2WSt; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 63185c1491117b66; Thu, 22 Aug 2024 21:36:02 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 91A106F0E2D;
	Thu, 22 Aug 2024 21:36:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724355362;
	bh=XpNib123fDRdKI1Co7t0LWgsdV+o9o6EjfyXbabzz3I=;
	h=From:Subject:Date;
	b=r2VM2WStjAGmVW3EnhE0scbih4qLs3y6n8J1GEmph3DJ4z3YcsSOpeUXg34N7nTR8
	 +HO3h+hIjoTHA7RaNZKPZQRz5yCnk6h5hT24+NAWW6Jb0yJnH+4oHYbTNnetTM/MWp
	 JfSSNFn402IQtfsD8dmSOdRMoVrRPDy1EcM4VaA6CuS71KVNQzP2wckCp3mKlC5Qm0
	 Hbb0nxOSfd9DMaKrpoWXHaAhwnkLlWrzEo9OLqU831f4V5GOQ+RixuBdh447YcRp9q
	 dkvGNPsa1Os2PWtCtvfPkC74LMLRSsPM8MOnHjUyh+I5VEwfUYXnTBhtz6hIvoJS/j
	 6fNFD0y3AyT0g==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Huisong Li <lihuisong@huawei.com>
Subject: [PATCH v1 0/3] thermal: core: Cleanups after bind/unbind changes
Date: Thu, 22 Aug 2024 21:23:14 +0200
Message-ID: <12516814.O9o76ZdvQC@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddruddvtddgudefjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhprghmkfhpucdlfedttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgv
 iigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhihhhuihhsohhngheshhhurgifvghirdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=18 Fuz1=18 Fuz2=18

Hi Everyone,

These are cleanups that can be done on top of

https://lore.kernel.org/linux-pm/2205737.irdbgypaU6@rjwysocki.net/

as suggested during patch review.

Please refer to the individual patch changelogs for more information.

Thanks!




