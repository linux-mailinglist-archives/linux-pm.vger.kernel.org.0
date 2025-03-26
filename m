Return-Path: <linux-pm+bounces-24536-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F07E9A71E47
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 19:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A3591715DB
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 18:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D8424C08F;
	Wed, 26 Mar 2025 18:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="O+SDvGO3"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DCF24C676;
	Wed, 26 Mar 2025 18:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743013590; cv=none; b=hObOMQPLagzjoh5cYq5BsD5bokLAP3xv7taTJoEXW5N5QSPjb50b2uL9io8Ah670Og6HQg47cNGif5Vz1NQqUgvSQcFU+LaAU5ZJVqz7reyfHBrtX/NoYabc3Lhxou2zL9sRyDreW+fTfIr9SE5Ly7udXNFCKo7xA6iQH89YsF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743013590; c=relaxed/simple;
	bh=cXiZhnXHaQK9fCDQbtwo7JXZu3LnVl0tUtL+xZ/MnSw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KzJt546iZ3HUHqhJXKQIJoZ+e38orIr7v1X8AFHK82jEXS8S/PFYQfIvddqe4HLROalGO5hr0K6vfZ5OOjCo6gP9fiW4KgSJlgfvRb4Q3COMip0snX6LdiainfxhGrDYVlvpW0fUEqjJt2qIN6L1ZFv94PPBR17gRWhTJ6Axx8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=O+SDvGO3; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E19FC4443C;
	Wed, 26 Mar 2025 18:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743013586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yZ9fztDkm6sfredMdtB+lEs4P0LHgszuyKLAym8M8R0=;
	b=O+SDvGO3ttnvT/LkaDti1OpTQBagDdVyyXukf571Tr8vdgFbOcYtrljscDrVrCkNxlM1d9
	OQj/Q16ye034mttOujwCV/P7j1a//8RZgFyKbaqaBbwNWUeJubEKn30Zfjx1sn4I5nYLb5
	/rhPKRk5W0/9qQrDGHiui9ahU9YN0Fs0SzzRYmXS7+WnBAj36cZ3iFwjnc861npmibhSGu
	J7GLi/H3PowQ17Uv5xmTziDkMwlqT46in/wMvEOPcLLGLiAVd+sgitfw6c33RQNZkAr1ox
	rQCXFWuwQV+13jRcX97SjX8+ZeG6Q8UC3Bnxb9oziX0LLYhHL1rf6hn6t45gyA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH RFC 00/10] Fix the ABBA locking situation between clk and
 runtime PM
Date: Wed, 26 Mar 2025 19:26:15 +0100
Message-Id: <20250326-cross-lock-dep-v1-0-3199e49e8652@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMdG5GcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYwNz3eSi/OJi3Zz85GzdlNQC3VQz0zQjC9PkVItUQyWgpoKi1LTMCrC
 B0UpBbs5KsbW1AOko02llAAAA
X-Change-ID: 20250307-cross-lock-dep-e65f285ce8e1
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
 Len Brown <len.brown@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Marek Vasut <marex@denx.de>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Kevin Hilman <khilman@kernel.org>, Fabio Estevam <festevam@denx.de>, 
 Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
 linux-imx@nxp.com, Ian Ray <ian.ray@gehealthcare.com>, 
 =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Saravana Kannan <saravanak@google.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.15-dev
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieeivdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedugfefveegtdfhvdehudfgkefgheetveefvdelheeuiedukefgfeejheefheevueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrgedvrdegiegnpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdekpdhrtghpthhtohepmhgrrhgvgiesuggvnhigrdguvgdprhgtphhtthhopehlihhnuhigqdhimhigsehngihprdgtohhmpdhrtghpthhtoheplhhinhhugidqtghlkhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehirghnrdhrrgihsehgvghhvggrlhhthhgtrghrvgdrtghomhdprhgtphhtthhopehmthhurhhquhgvt
 hhtvgessggrhihlihgsrhgvrdgtohhmpdhrtghpthhtohepshgsohihugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhhihhlmhgrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com

As explained in the following thread, there is a known ABBA locking
dependency between clk and runtime PM.
Link: https://lore.kernel.org/linux-clk/20240527181928.4fc6b5f0@xps-13/

The problem is that the clk subsystem uses a mutex to protect concurrent
accesses to its tree structure, and so do other subsystems such as
generic power domains. While it holds its own mutex, the clk subsystem
performs runtime PM calls which end up executing callbacks from other
subsystems (again, gen PD is in the loop). But typically power domains
may also need to perform clock related operations, and thus the
following two situations may happen:

mutex_lock(clk);
mutex_lock(genpd);

or

mutex_lock(genpd);
mutex_lock(clk);

As of today I know that at least NXP i.MX8MP and MediaTek MT8183 SoCs
are complex enough to face this kind of issues.

There's been a first workaround to "silence" lockdep with the most
obvious case triggering the warning: making sure all clocks are RPM
enabled before running the clk_disable_unused() work, but this is just
addressing one situation among many other potentially problematic
situations. In the past, both Laurent Pinchart and Marek Vasut have
experienced these issues when enabling HDMI and audio support,
respectively.

Following a discussion we had at last Plumbers with Steven, I am
proposing to decouple both locks by changing a bit the clk approach:
let's always runtime resume all clocks that we *might* need before
taking the clock lock. But how do we know the list? Well, depending on
the situation we may either need to wake up:
- the upper part of the tree during prepare/unprepare operations.
- the lower part of the tree during (read) rate operations.
- the upper part and the lower part of the tree otherwise (especially
  during rate changes which may involve reparenting).

Luckily, we do not need to do that by hand, are more importantly we do
not need to use the clock tree for that because thanks to the work from
Saravana, we already have device links describing exhaustively the
consumer/supplier relationships. The clock topology (from a runtime PM
perspective) is reflected in these links. In practice, we do not care
about all consumers, but the few clock operations that will actually
trigger runtime PM operations are probably not impacting enough to
justify something more complex.

So here it is: every patch in this series decouples the two locks in
various places of the clock subsystem, until we reach a point where all
needed clocks will always be resumed before acquiring the core lock. It
obviously requires a few new helpers in the RPM core which may probably
be enhanced, I've tried to keep them as simple and straightforward as
possible.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
Miquel Raynal (10):
      PM: runtime: Add helpers to resume consumers
      clk: Improve comments with usual punctuation
      clk: Avoid non needed runtime PM calls
      clk: Avoid open coded-logic when a there is a helper available
      clk: Move runtime PM calls out of the prepare_lock in clk_init()
      clk: Move runtime PM calls out of the prepare_lock in clk_prepare()
      clk: Ensure all RPM enabled clocks are enabled before reparenting orphans
      clk: Move runtime PM calls out of the prepare_lock in clk_unregister()
      clk: Make sure clock parents and children are resumed when necessary
      clk: Fix the ABBA locking issue with runtime PM subcalls

 drivers/base/power/runtime.c |  54 ++++++++++++
 drivers/clk/clk.c            | 204 +++++++++++++++++++++++++++++++------------
 include/linux/pm_runtime.h   |   2 +
 3 files changed, 204 insertions(+), 56 deletions(-)
---
base-commit: ab6df33805e6e6e4ac1a519cfcade3f7f19f6ff1
change-id: 20250307-cross-lock-dep-e65f285ce8e1

Best regards,
-- 
Miquel Raynal <miquel.raynal@bootlin.com>


